
# line 1 "mdgenerate.rl"
class ScannerForMarkdownExtension
    def generate(info, file)
        data = File.read(file)
        link_url = nil
        metadata = ''
        bodydata = ''
        isInternalLink = false
        isGeneratedLink = false
        
# line 13 "mdgenerate.rb"
class << self
	attr_accessor :__ScannerForMarkdownExtension_actions
	private :__ScannerForMarkdownExtension_actions, :__ScannerForMarkdownExtension_actions=
end
self.__ScannerForMarkdownExtension_actions = [
	0, 1, 1, 2, 1, 0, 2, 1, 
	2, 3, 1, 0, 2, 3, 1, 3, 
	2, 3, 1, 4, 2, 3, 1, 5, 
	2, 3, 1, 6, 2, 3, 1, 7, 
	2, 4, 1, 0, 4, 2, 4, 1, 
	3, 4, 2
]

class << self
	attr_accessor :__ScannerForMarkdownExtension_key_offsets
	private :__ScannerForMarkdownExtension_key_offsets, :__ScannerForMarkdownExtension_key_offsets=
end
self.__ScannerForMarkdownExtension_key_offsets = [
	0, 0, 1, 2, 3, 4, 5, 7, 
	9, 11, 13, 15, 18, 21, 24, 27, 
	30, 33, 36, 39, 43, 47, 50, 53, 
	57, 61, 65, 69
]

class << self
	attr_accessor :__ScannerForMarkdownExtension_trans_keys
	private :__ScannerForMarkdownExtension_trans_keys, :__ScannerForMarkdownExtension_trans_keys=
end
self.__ScannerForMarkdownExtension_trans_keys = [
	45, 45, 45, 10, 10, 10, 45, 10, 
	45, 10, 45, 10, 60, 10, 60, 10, 
	45, 60, 10, 45, 60, 10, 45, 60, 
	10, 37, 60, 10, 60, 61, 10, 40, 
	60, 10, 41, 60, 10, 41, 60, 10, 
	41, 45, 60, 10, 60, 105, 108, 10, 
	37, 60, 10, 60, 62, 10, 41, 45, 
	60, 10, 41, 45, 60, 10, 37, 41, 
	60, 10, 41, 60, 61, 10, 40, 41, 
	60, 0
]

class << self
	attr_accessor :__ScannerForMarkdownExtension_single_lengths
	private :__ScannerForMarkdownExtension_single_lengths, :__ScannerForMarkdownExtension_single_lengths=
end
self.__ScannerForMarkdownExtension_single_lengths = [
	0, 1, 1, 1, 1, 1, 2, 2, 
	2, 2, 2, 3, 3, 3, 3, 3, 
	3, 3, 3, 4, 4, 3, 3, 4, 
	4, 4, 4, 4
]

class << self
	attr_accessor :__ScannerForMarkdownExtension_range_lengths
	private :__ScannerForMarkdownExtension_range_lengths, :__ScannerForMarkdownExtension_range_lengths=
end
self.__ScannerForMarkdownExtension_range_lengths = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0
]

class << self
	attr_accessor :__ScannerForMarkdownExtension_index_offsets
	private :__ScannerForMarkdownExtension_index_offsets, :__ScannerForMarkdownExtension_index_offsets=
end
self.__ScannerForMarkdownExtension_index_offsets = [
	0, 0, 2, 4, 6, 8, 10, 13, 
	16, 19, 22, 25, 29, 33, 37, 41, 
	45, 49, 53, 57, 62, 67, 71, 75, 
	80, 85, 90, 95
]

class << self
	attr_accessor :__ScannerForMarkdownExtension_indicies
	private :__ScannerForMarkdownExtension_indicies, :__ScannerForMarkdownExtension_indicies=
end
self.__ScannerForMarkdownExtension_indicies = [
	0, 1, 2, 1, 3, 1, 4, 1, 
	6, 5, 6, 7, 5, 6, 8, 5, 
	6, 9, 5, 11, 12, 10, 11, 12, 
	10, 11, 13, 12, 10, 11, 14, 12, 
	10, 11, 15, 12, 10, 11, 16, 12, 
	10, 11, 12, 17, 10, 11, 18, 12, 
	10, 20, 10, 21, 19, 20, 22, 21, 
	19, 20, 22, 23, 21, 19, 11, 12, 
	24, 25, 10, 11, 26, 12, 10, 11, 
	12, 27, 10, 20, 22, 28, 21, 19, 
	20, 22, 29, 21, 19, 20, 30, 22, 
	21, 19, 20, 22, 21, 31, 19, 20, 
	32, 22, 21, 19, 0
]

class << self
	attr_accessor :__ScannerForMarkdownExtension_trans_targs
	private :__ScannerForMarkdownExtension_trans_targs, :__ScannerForMarkdownExtension_trans_targs=
end
self.__ScannerForMarkdownExtension_trans_targs = [
	2, 0, 3, 4, 5, 5, 6, 7, 
	8, 9, 10, 11, 14, 12, 13, 10, 
	15, 16, 17, 18, 19, 25, 20, 23, 
	21, 21, 22, 10, 24, 18, 26, 27, 
	18
]

class << self
	attr_accessor :__ScannerForMarkdownExtension_trans_actions
	private :__ScannerForMarkdownExtension_trans_actions, :__ScannerForMarkdownExtension_trans_actions=
end
self.__ScannerForMarkdownExtension_trans_actions = [
	0, 0, 0, 0, 0, 1, 1, 1, 
	1, 3, 6, 6, 6, 6, 6, 9, 
	6, 6, 13, 17, 17, 17, 6, 17, 
	29, 25, 6, 21, 17, 33, 17, 17, 
	38
]

class << self
	attr_accessor :_ScannerForMarkdownExtension_start
end
self._ScannerForMarkdownExtension_start = 1;
class << self
	attr_accessor :_ScannerForMarkdownExtension_first_final
end
self._ScannerForMarkdownExtension_first_final = 10;
class << self
	attr_accessor :_ScannerForMarkdownExtension_error
end
self._ScannerForMarkdownExtension_error = 0;

class << self
	attr_accessor :_ScannerForMarkdownExtension_en_main
end
self._ScannerForMarkdownExtension_en_main = 1;


# line 151 "mdgenerate.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = _ScannerForMarkdownExtension_start
end

# line 158 "mdgenerate.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = __ScannerForMarkdownExtension_key_offsets[cs]
	_trans = __ScannerForMarkdownExtension_index_offsets[cs]
	_klen = __ScannerForMarkdownExtension_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p] < __ScannerForMarkdownExtension_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p] > __ScannerForMarkdownExtension_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = __ScannerForMarkdownExtension_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p] < __ScannerForMarkdownExtension_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p] > __ScannerForMarkdownExtension_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = __ScannerForMarkdownExtension_indicies[_trans]
	cs = __ScannerForMarkdownExtension_trans_targs[_trans]
	if __ScannerForMarkdownExtension_trans_actions[_trans] != 0
		_acts = __ScannerForMarkdownExtension_trans_actions[_trans]
		_nacts = __ScannerForMarkdownExtension_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case __ScannerForMarkdownExtension_actions[_acts - 1]
when 0 then
# line 12 "mdgenerate.rl"
		begin

            metadata = metadata[0...-4]
            p metadata
@header=<<HEADER
---
layout: default
category: #{info.category}
#{metadata}
---
HEADER
            		end
when 1 then
# line 23 "mdgenerate.rl"
		begin

                metadata += data[p].chr
            		end
when 2 then
# line 26 "mdgenerate.rl"
		begin

                unless isInternalLink
                    if isGeneratedLink
                        isGeneratedLink=false
                    else
                        bodydata += data[p].chr 
                    end
                end
            		end
when 3 then
# line 36 "mdgenerate.rl"
		begin

                isInternalLink = true
                bodydata = bodydata[0...-3]
                relative_url = ''
            		end
when 4 then
# line 41 "mdgenerate.rl"
		begin

                relative_url += data[p].chr
            		end
when 5 then
# line 44 "mdgenerate.rl"
		begin

                bodydata+=link_url
                isInternalLink = false
                isGeneratedLink= true
            		end
when 6 then
# line 50 "mdgenerate.rl"
		begin

                link_url = info.link_to(relative_url)
            		end
when 7 then
# line 53 "mdgenerate.rl"
		begin

                link_url = info.img_to(relative_url)
            		end
# line 305 "mdgenerate.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 80 "mdgenerate.rl"

        @header+bodydata
    end
end
