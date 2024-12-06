Notes for Day 02 Part 2
=======================

This report is unsafe with the code from Part 1.

```elixir
report = [1, 3, 2, 4, 5]
Solution.safe?(report)
false
```

However if we are to remove 3, it's safe:

```elixir
report = [1, 2, 4, 5]
Solution.safe?(report)
true
```

We can only remove one level. Now, how do we know which level to remove? The only way to know is to try removing all levels one by one and see if the report ever becomes safe. That's my approach.
