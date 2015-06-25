def two_sum(nums, target) 
	return if nums.size < 2
	map = Hash.new
	res = []
	nums.each_with_index do |num, i|
		if map.has_key?(target - num)
			res[0] = map[target - num] + 1
			res[1] = i + 1
			return res
		else
			map[num] = i
		end
	end
	return nil
end

def merge_two_lists(l1, l2)
	dummy = ListNode.new(0)
	cur = dummy
	while l1 != nil and l2 != nil do
		if l1.val < l2.val
			cur.next = l1
			l1 = l1.next
		else
			cur.next = l2
			l2 = l2.next
		end
		cur = cur.next
	end

	cur.next = l1 if l1 != nil
	cur.next = l2 if l2 != nil
	return dummy.next
end

def letter_combinations(digits)
	res = []
	res.push("")
	return res if digits.size == 0
	digits.each_with_index  do |digit, i|
		letters = get_letters(digit)
		new_res = []
		res.each_with_index do |r, j|
			letters.each_with_index do |l, k|
				new_res.push(res[j] + letters[k])
			end
		end
		res = new_res
	end
end

def get_letters(digit)
	case digit
	when '0'
		return ' '
	when '2'
		return 'abc'
	when '3'
		return 'def'
	when '4'
		return 'ghi'
	when '5'
		return 'jkl'
	when '6'
		return 'mno'
	when '7'
		return 'pqrs'
	when '8'
		return 'tuv'
	when '9'
		return 'wxyz'
	else
		return ''
end





















