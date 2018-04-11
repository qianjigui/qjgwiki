require 'openssl'
require 'pp'

module KnowledgeUtils
  module Generate
    class DesEncrypt
      def initialize(key, iv)
        @key =key
        @iv = iv
      end

      def encrypt(infile, outfile)
        c = OpenSSL::Cipher::Cipher.new('DES-CBC')
        c.encrypt
        c.padding = 0
        c.key = @key
        c.iv = @iv
        plaintext = File.read(infile)
        ret = c.update(plaintext)
        ret << c.final
        File.open(outfile, 'w') {|f| f.print ret}
      end

      def decrypt(infile, outfile)
        c = OpenSSL::Cipher::Cipher.new('DES-CBC')
        c.decrypt
        c.padding = 0
        c.key = @key
        c.iv = @iv
        pp 'decrypt:'+infile
        encrypt_value = File.read(infile)
        ret = c.update(encrypt_value)
        ret << c.final
        File.open(outfile, 'w') {|f| f.print ret}
      end
    end

    class EncryptGenerator < GenerateBase

      def set_tags
        @conf.log_tag = 'EncryptGenerator'
      end

      def prepare_imp
        @enc = DesEncrypt.new(@conf[:enc][:key], @conf[:enc][:iv])
        #clean
      end

      def generate_imp
        encfiles = FileSet.files(@src+'/**/'+@encrypt_dir+'/**')
        encfiles.each do |file|
          enc_file =file.gsub(@encrypt_dir,'')+@encrypt_suffix
          @conf.add_tag_file(enc_file, @encrypt_suffix)
          begin
            if refresh?(file,enc_file)
              File.delete(enc_file) if File.exist?(enc_file)
              @enc.encrypt(file,enc_file)
              @conf.log('Encrypt',file)
            end
          rescue ArgumentError
            @conf.warn(file, 'is Empty.', 'Ignore!')
          end
        end
      end

      def clean_imp
        FileSet.files(@src+'/**/**'+@encrypt_suffix).each do |file|
          @conf.debug('Delete',file)
          File.delete(file)
        end
      end
    end

    class DecryptGenerator < GenerateBase

      def set_tags
        @conf.log_tag = 'DecryptGenerator'
      end

      def prepare_imp
        @enc = DesEncrypt.new(@conf[:enc][:key], @conf[:enc][:iv])
        #clean
      end

      def generate_imp
        encfiles = FileSet.files(@src+'/**/*'+@encrypt_suffix)
        @conf.debug(encfiles)
        encfiles.each do |file|
          fullname=file.gsub(@encrypt_suffix,'')
          dirname=File.dirname(fullname)+'/'+@encrypt_dir
          @conf.debug('dirname',dirname)
          FileUtils.mkdir(dirname) unless File.exist?(dirname)
          dec_file = dirname+'/'+File.basename(fullname)
          begin
            @conf.add_tag_file(dec_file, @encrypt_suffix)
            if refresh?(file,dec_file)
              File.delete(dec_file) if File.exist?(dec_file)
              @enc.decrypt(file,dec_file)
              @conf.log('Decrypt',dec_file)
            end
          rescue ArgumentError
            @conf.warn(file, 'is Empty.', 'Ignore!')
          end
        end
      end

      def clean_imp
        FileSet.files(@src+'/**/**'+@encrypt_suffix).each do |file|
          @conf.debug('Delete',file)
          File.delete(file)
        end
      end
    end
  end
end

