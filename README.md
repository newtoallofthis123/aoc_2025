# Advent of Code 2025

I use elixir for work, so I decided that I shall do this year's AOC in elixir.

I believe it was a very good decision on the part topaz as detailed in his [reddit post](https://www.reddit.com/r/adventofcode/comments/1ocwh04/changes_to_advent_of_code_starting_this_december/)
to remove the global leaderboard and make it for only 12 days.

It was generally that after the 18th day that the problems really increase in their difficulty, so I am pretty excited to see how the problem difficulty increases in 14 days.

It is a relief that there is no global leaderboard to tempt me, not that I was making it on there.

Let AOC this year be actually fun :)

## Setup

This is a simple elixir app. Install dependencies:

```bash
mix deps.get
```

## Usage

### Generate a New Day

Create scaffolding for a new day's solution:

```bash
mix aoc.gen 1
```

This creates:
- `lib/dayXX.ex` - Solution module with template
- `test/day_XX.exs` - Test file with example input placeholder
- `priv/inputs/dayXX.txt` - Empty input file

### Add Your Puzzle Input

Copy your puzzle input from [Advent of Code](https://adventofcode.com/2025) to the input file:

```bash
# Manually paste into priv/inputs/dayXX.txt
# Or use curl (replace SESSION with your session cookie):
curl https://adventofcode.com/2025/day/1/input \
  --cookie "session=YOUR_SESSION_COOKIE" \
  > priv/inputs/day01.txt
```

### Implement Your Solution

Edit `lib/dayXX.ex` and implement the `solve_part1/1` and `solve_part2/1` functions.

### Run Tests

Test with the example input:

```bash
mix test test/day_01.exs
```

Run all tests:

```bash
mix test
```

### Run Your Solution

Execute both parts with your actual puzzle input:

```bash
mix aoc 1
```

This will output:

```
Day 1
  Part 1: <your answer>
  Part 2: <your answer>
```

### Benchmark Solutions

Compare the performance of different solution approaches:

```bash
# Compare part1 and part2
mix aoc.bench 1 part1 part2

# Compare different implementations
mix aoc.bench 5 part1 part1_optimized part1_v3
```

This uses [Benchee](https://github.com/bencheeorg/benchee) to show:
- Iterations per second (IPS)
- Average execution time
- Memory consumption
- Statistical comparisons

Example output:
```
Name               ips        average  deviation         median         99th %
part1_v3        1.23 K      813.01 μs    ±10.23%      801.23 μs     1234.56 μs
part1           0.89 K     1123.45 μs     ±8.45%     1101.23 μs     1567.89 μs

Comparison:
part1_v3        1.23 K
part1           0.89 K - 1.38x slower
```

## Project Structure

```
aoc_2025/
├── lib/
│   ├── aoc2025.ex           # Main module with helpers
│   ├── day.ex               # Behaviour definition for day modules
│   ├── input.ex             # Input loading helpers
│   ├── dayXX.ex             # Solution modules
│   └── mix/tasks/
│       ├── aoc.ex           # Mix task to run solutions
│       ├── aoc.bench.ex     # Mix task to benchmark solutions
│       └── aoc.gen.ex       # Mix task to generate scaffolding
├── test/
│   ├── test_helper.exs      # Test configuration
│   └── day_XX.exs           # Test files for each day
├── priv/inputs/
│   └── dayXX.txt            # Puzzle inputs (not committed to git)
└── mix.exs                  # Project configuration
```

## Tips

- Use `@tag :skip` in tests to skip slow or incomplete tests
- The generator creates a clean structure - parse input, then solve
- Benchmark different approaches to learn about Elixir performance
- Input files are gitignored per AoC's sharing rules

