class MinStack {
	ArrayList<Integer> stack = new ArrayList<Integer>();
	ArrayList<Integer> minStack = new ArrayList<Integer>();

	public void push(int x) {
		stack.add(x);

		if (minStack.isEmpty() || minStack.get(minStack.size() - 1) >= x) {
			minStack.add(x);
		}
	}

	public void pop() {
		if (stack.isEmpty()) return;
		int current = stack.remove(stack.size() - 1);

		if (current == minStack.get(minStack.size() - 1 )) {
			minStack.remove(minStack.size() - 1);
		}
	}

	public int top() {
		if (!stack.isEmpty()) {
			return stack.get(stack.size() - 1);
		}
		return 0;
	}

	public int getMin() {
		if (!minStack.isEmpty()) {
			return minStack.get(minStack.size() - 1);
		}
		return 0;

	}
}