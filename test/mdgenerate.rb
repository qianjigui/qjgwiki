
# line 1 "mdgenerate.rl"
class ScannerForMarkdownExtension
    def generate(info, file)
        data = File.read(file)
        link_url = nil
        metadata = ''
        bodydata = ''
        
# line 11 "mdgenerate.rb"
class << self
	attr_accessor :__ScannerForMarkdownExtension_actions
	private :__ScannerForMarkdownExtension_actions, :__ScannerForMarkdownExtension_actions=
end
self.__ScannerForMarkdownExtension_actions = [
	0, 1, 1, 2, 1, 0, 2, 1, 
	2, 3, 1, 0, 2, 3, 1, 3, 
	2, 3, 1, 4, 2, 4, 1, 0, 
	4, 2, 4, 1, 3, 4, 2, 4, 
	1, 4, 5, 2, 4, 1, 4, 6, 
	2, 4, 1, 4, 7, 2
]

class << self
	attr_accessor :__ScannerForMarkdownExtension_key_offsets
	private :__ScannerForMarkdownExtension_key_offsets, :__ScannerForMarkdownExtension_key_offsets=
end
self.__ScannerForMarkdownExtension_key_offsets = [
	0, 0, 1, 2, 3, 4, 5, 7, 
	9, 11, 13, 15, 18, 21, 24, 27, 
	30, 33, 35, 38, 42, 47, 51, 55, 
	59, 63, 67, 71
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
	60, 10, 60, 10, 41, 60, 10, 41, 
	45, 60, 10, 41, 60, 105, 108, 10, 
	37, 41, 60, 10, 41, 60, 61, 10, 
	40, 41, 60, 10, 37, 41, 60, 10, 
	41, 60, 62, 10, 41, 45, 60, 10, 
	41, 45, 60, 0
]

class << self
	attr_accessor :__ScannerForMarkdownExtension_single_lengths
	private :__ScannerForMarkdownExtension_single_lengths, :__ScannerForMarkdownExtension_single_lengths=
end
self.__ScannerForMarkdownExtension_single_lengths = [
	0, 1, 1, 1, 1, 1, 2, 2, 
	2, 2, 2, 3, 3, 3, 3, 3, 
	3, 2, 3, 4, 5, 4, 4, 4, 
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
	45, 49, 52, 56, 61, 67, 72, 77, 
	82, 87, 92, 97
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
	10, 20, 21, 19, 20, 22, 21, 19, 
	20, 22, 23, 21, 19, 20, 22, 21, 
	24, 25, 19, 20, 26, 22, 21, 19, 
	20, 22, 21, 27, 19, 20, 28, 22, 
	21, 19, 20, 29, 22, 21, 19, 20, 
	22, 21, 30, 19, 20, 22, 31, 21, 
	19, 20, 22, 32, 21, 19, 0
]

class << self
	attr_accessor :__ScannerForMarkdownExtension_trans_targs
	private :__ScannerForMarkdownExtension_trans_targs, :__ScannerForMarkdownExtension_trans_targs=
end
self.__ScannerForMarkdownExtension_trans_targs = [
	2, 0, 3, 4, 5, 5, 6, 7, 
	8, 9, 10, 11, 14, 12, 13, 10, 
	15, 16, 17, 18, 19, 21, 20, 26, 
	24, 24, 22, 23, 18, 25, 18, 27, 
	18
]

class << self
	attr_accessor :__ScannerForMarkdownExtension_trans_actions
	private :__ScannerForMarkdownExtension_trans_actions, :__ScannerForMarkdownExtension_trans_actions=
end
self.__ScannerForMarkdownExtension_trans_actions = [
	0, 0, 0, 0, 0, 1, 1, 1, 
	1, 3, 6, 6, 6, 6, 6, 9, 
	6, 6, 13, 17, 17, 17, 17, 17, 
	41, 36, 17, 17, 26, 17, 31, 17, 
	21
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


# line 149 "mdgenerate.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = _ScannerForMarkdownExtension_start
end

# line 156 "mdgenerate.rb"
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
# line 10 "mdgenerate.rl"
		begin

            p metadata
@header=<<HEADER
---
category: #{info.category}
#{metadata}
---
HEADER
            		end
# line 10 "mdgenerate.rl"
when 1 then
# line 19 "mdgenerate.rl"
		begin

                metadata += data[p].chr
            		end
# line 19 "mdgenerate.rl"
when 2 then
# line 22 "mdgenerate.rl"
		begin

                bodydata += data[p].chr
            		end
# line 22 "mdgenerate.rl"
when 3 then
# line 26 "mdgenerate.rl"
		begin

                relative_url = ''
            		end
# line 26 "mdgenerate.rl"
when 4 then
# line 29 "mdgenerate.rl"
		begin

                relative_url += data[p].chr
            		end
# line 29 "mdgenerate.rl"
when 5 then
# line 32 "mdgenerate.rl"
		begin

                bodydata+=link_url
            		end
# line 32 "mdgenerate.rl"
when 6 then
# line 36 "mdgenerate.rl"
		begin

                link_url = info.link_to(relative_url)
            		end
# line 36 "mdgenerate.rl"
when 7 then
# line 39 "mdgenerate.rl"
		begin

                link_url = info.img_to(relative_url)
            		end
# line 39 "mdgenerate.rl"
# line 299 "mdgenerate.rb"
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

# line 68 "mdgenerate.rl"

        @header+bodydata
    end
end

