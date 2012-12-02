
# line 1 "mdgenerate.rl"

# line 5 "mdgenerate.rb"
class << self
	attr_accessor :_MarkdownFileGenerate_actions
	private :_MarkdownFileGenerate_actions, :_MarkdownFileGenerate_actions=
end
self._MarkdownFileGenerate_actions = [
	0, 1, 1, 2, 1, 0, 2, 1, 
	2, 3, 1, 0, 2, 3, 1, 3, 
	2, 3, 1, 4, 2, 4, 1, 0, 
	4, 2, 4, 1, 3, 4, 2, 4, 
	1, 4, 5, 2, 4, 1, 4, 6, 
	2, 4, 1, 4, 7, 2
]

class << self
	attr_accessor :_MarkdownFileGenerate_key_offsets
	private :_MarkdownFileGenerate_key_offsets, :_MarkdownFileGenerate_key_offsets=
end
self._MarkdownFileGenerate_key_offsets = [
	0, 0, 1, 2, 3, 4, 5, 6, 
	7, 9, 11, 12, 13, 14, 16, 18, 
	20, 22, 23, 25, 29, 31, 33, 36, 
	39, 42, 45, 48, 51
]

class << self
	attr_accessor :_MarkdownFileGenerate_trans_keys
	private :_MarkdownFileGenerate_trans_keys, :_MarkdownFileGenerate_trans_keys=
end
self._MarkdownFileGenerate_trans_keys = [
	45, 45, 45, 10, 45, 45, 45, 10, 
	45, 45, 60, 45, 45, 45, 10, 45, 
	37, 45, 45, 61, 40, 45, 45, 41, 
	45, 41, 45, 105, 108, 41, 45, 41, 
	45, 10, 41, 45, 41, 45, 60, 37, 
	41, 45, 41, 45, 61, 40, 41, 45, 
	37, 41, 45, 41, 45, 62, 0
]

class << self
	attr_accessor :_MarkdownFileGenerate_single_lengths
	private :_MarkdownFileGenerate_single_lengths, :_MarkdownFileGenerate_single_lengths=
end
self._MarkdownFileGenerate_single_lengths = [
	0, 1, 1, 1, 1, 1, 1, 1, 
	2, 2, 1, 1, 1, 2, 2, 2, 
	2, 1, 2, 4, 2, 2, 3, 3, 
	3, 3, 3, 3, 3
]

class << self
	attr_accessor :_MarkdownFileGenerate_range_lengths
	private :_MarkdownFileGenerate_range_lengths, :_MarkdownFileGenerate_range_lengths=
end
self._MarkdownFileGenerate_range_lengths = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0
]

class << self
	attr_accessor :_MarkdownFileGenerate_index_offsets
	private :_MarkdownFileGenerate_index_offsets, :_MarkdownFileGenerate_index_offsets=
end
self._MarkdownFileGenerate_index_offsets = [
	0, 0, 2, 4, 6, 8, 10, 12, 
	14, 17, 20, 22, 24, 26, 29, 32, 
	35, 38, 40, 43, 48, 51, 54, 58, 
	62, 66, 70, 74, 78
]

class << self
	attr_accessor :_MarkdownFileGenerate_indicies
	private :_MarkdownFileGenerate_indicies, :_MarkdownFileGenerate_indicies=
end
self._MarkdownFileGenerate_indicies = [
	0, 1, 2, 1, 3, 1, 4, 1, 
	6, 5, 7, 5, 8, 5, 9, 8, 
	5, 11, 12, 10, 11, 10, 13, 10, 
	14, 10, 15, 14, 10, 16, 11, 10, 
	11, 17, 10, 18, 11, 10, 20, 19, 
	21, 20, 19, 21, 20, 22, 23, 19, 
	21, 24, 19, 21, 25, 19, 26, 21, 
	25, 19, 21, 20, 27, 19, 28, 21, 
	20, 19, 21, 20, 29, 19, 30, 21, 
	20, 19, 31, 21, 20, 19, 21, 20, 
	32, 19, 0
]

class << self
	attr_accessor :_MarkdownFileGenerate_trans_targs
	private :_MarkdownFileGenerate_trans_targs, :_MarkdownFileGenerate_trans_targs=
end
self._MarkdownFileGenerate_trans_targs = [
	2, 0, 3, 4, 5, 5, 6, 7, 
	8, 9, 10, 11, 14, 12, 13, 9, 
	15, 16, 17, 18, 20, 19, 27, 27, 
	21, 22, 23, 24, 25, 26, 18, 28, 
	23
]

class << self
	attr_accessor :_MarkdownFileGenerate_trans_actions
	private :_MarkdownFileGenerate_trans_actions, :_MarkdownFileGenerate_trans_actions=
end
self._MarkdownFileGenerate_trans_actions = [
	0, 0, 0, 0, 0, 1, 1, 1, 
	1, 3, 6, 6, 6, 6, 6, 9, 
	6, 6, 13, 17, 17, 17, 41, 36, 
	17, 17, 21, 17, 17, 17, 26, 17, 
	31
]

class << self
	attr_accessor :MarkdownFileGenerate_start
end
self.MarkdownFileGenerate_start = 1;
class << self
	attr_accessor :MarkdownFileGenerate_first_final
end
self.MarkdownFileGenerate_first_final = 9;
class << self
	attr_accessor :MarkdownFileGenerate_error
end
self.MarkdownFileGenerate_error = 0;

class << self
	attr_accessor :MarkdownFileGenerate_en_main
end
self.MarkdownFileGenerate_en_main = 1;


# line 4 "mdgenerate.rl"


class ScannerForMarkdownExtension
    def generate(info, file)
        data = File.read(file)
        link_url = nil
        metadata = ''
        val = ''
        bodydata = ''
        
# line 149 "mdgenerate.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = MarkdownFileGenerate_start
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
	_keys = _MarkdownFileGenerate_key_offsets[cs]
	_trans = _MarkdownFileGenerate_index_offsets[cs]
	_klen = _MarkdownFileGenerate_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p] < _MarkdownFileGenerate_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p] > _MarkdownFileGenerate_trans_keys[_mid]
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
	  _klen = _MarkdownFileGenerate_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p] < _MarkdownFileGenerate_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p] > _MarkdownFileGenerate_trans_keys[_mid+1]
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
	_trans = _MarkdownFileGenerate_indicies[_trans]
	cs = _MarkdownFileGenerate_trans_targs[_trans]
	if _MarkdownFileGenerate_trans_actions[_trans] != 0
		_acts = _MarkdownFileGenerate_trans_actions[_trans]
		_nacts = _MarkdownFileGenerate_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _MarkdownFileGenerate_actions[_acts - 1]
when 0 then
# line 14 "mdgenerate.rl"
		begin

@header=<<HEADER
---
category: #{info.category}
#{metadata}
---
HEADER
            		end
# line 14 "mdgenerate.rl"
when 1 then
# line 22 "mdgenerate.rl"
		begin

                metadata += val
            		end
# line 22 "mdgenerate.rl"
when 2 then
# line 25 "mdgenerate.rl"
		begin

                bodydata += val
            		end
# line 25 "mdgenerate.rl"
when 3 then
# line 29 "mdgenerate.rl"
		begin

                relative_url = ''
            		end
# line 29 "mdgenerate.rl"
when 4 then
# line 32 "mdgenerate.rl"
		begin

                relative_url += val
            		end
# line 32 "mdgenerate.rl"
when 5 then
# line 35 "mdgenerate.rl"
		begin

                bodydata+=link_url
            		end
# line 35 "mdgenerate.rl"
when 6 then
# line 39 "mdgenerate.rl"
		begin

                link_url = info.link_to(relative_url)
            		end
# line 39 "mdgenerate.rl"
when 7 then
# line 42 "mdgenerate.rl"
		begin

                link_url = info.img_to(relative_url)
            		end
# line 42 "mdgenerate.rl"
# line 298 "mdgenerate.rb"
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

