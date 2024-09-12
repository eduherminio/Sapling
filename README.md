<p align="center">
   <div style="width:640;height:320">
       <img style="width: inherit" src="./sapling-banner.png">
</div>
</p>

### A strong dotnet UCI Chess engine [BETA] My leaf nodes are growing

> [!NOTE]  
> Sapling is still in active development so expect certain features to be missing or experimental. Also the current release is using a NNUE net trained from self play starting with random weights and is only 11 iterations deep, expect the engine to be much stronger in the coming days as the training does takes a while.

Play it here -> https://iblunder.com/

Or challenge it on Lichess -> https://lichess.org/@/sapling-bot

## Releases
You can browse all windows, linux or mac releases [here](https://github.com/Timmoth/Sapling/releases)

### Latest Release [BETA] 12/09/2024
- [Windows Avx-256](https://github.com/Timmoth/Sapling/releases/tag/windows_2024-09-12_18-15)
- [Windows Avx-512](https://github.com/Timmoth/Sapling/releases/tag/windows_avx512_2024-09-12_18-15)
- [Linux Avx-256](https://github.com/Timmoth/Sapling/releases/tag/linux_2024-09-12_18-15)
- [Linux Avx-512](https://github.com/Timmoth/Sapling/releases/tag/linux_avx512_2024-09-12_18-15)
- [Mac Avx-256](https://github.com/Timmoth/Sapling/releases/tag/osx_2024-09-12_18-15)
- [Mac Avx-512](https://github.com/Timmoth/Sapling/releases/tag/osx_avx512_2024-09-12_18-15)

## Requirements
- Sapling makes use of hardware intrinsics to improve performance. Currently your CPU must support: `Avx2`, `Bmi1`, `Bmi2`, `Popcnt`, `Sse`. Most modern hardware shipped after 2013 should be supported.
- The releases come with a bundled version of the dotnet runtime, however if you want to run from source you'll need the dotnet 8 SDK installed.

## Running from source
```bash
dotnet run --project .\Sapling\Sapling.csproj --configuration Release
```

## Commands
- `quit` : exit the program
- `setoption name threads value 8` : sets the number of threads to use
- `ucinewgame` : initializes a new game
- `position startpos` : sets the engine to the starting chess position
- `position startpos moves a2a3 a7a6` : sets the engine to the starting position then applies a set of moves
- `position fen rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1` : sets the engine to the position given by the fen string
- `d` : outputs a diagram of the current position
- `go perft 6` : Runs a pert test to a specific depth
- `go depth 10` : Returns the best move after searching for the given depth
- `go wtime 10000 btime 10000 winc 100 binc 100` : returns the best move after searching with the given time control
- `go see a2a3` : [Dev] returns a the result of static exchange evaluation for a given move
- `go eval` : [Dev] returns the static evaluation of the current position
- `datagen` : [Dev] starts generating data in the bullet format, used when training a new NNUE network

## Features

<details>
<Summary>General</Summary>
  
- Bitboards 
- NNUE 768->256
- Transposition table
- Lazy SMP
- Pondering
</details>

<details>
<Summary>Search</Summary>
  
- Negamax
- Quiescence
- Alpha-Beta pruning
- Iterative Deepening
- Asperation windows
- Null move pruning
- Late Move Pruning
- Futility Pruning
- Razoring
- Principal Variation Search
- Check extensions
- Internal Iterative Reduction
- Late Move Reductions
</details>

<details>
<Summary>Move generation / ordering</Summary>

- Pseudo-legal movegen
- Static exchange evaluation
- Killer move heuristic
- Counter move heuristic
- History heuristic with malus
- Incremental sorting
- Magic bitboards
- PEXT bitboards
</details>

## SPRT
After any changes to the engine a SPRT test must be ran to ensure that the changes have a positive effect.

There is a script `sprt.bat` which contains the command to run a cutechess-cli SPRT test. Ensure that you've configured CuteChess to point to both `dev` and `base` engines before hand, and also update the opening book + endgame table base to point to one on your system.

## NNUE
I'm in the process of training a 768->256 network starting from random weights using self play data generation and bullet trainer. Expect the engine to get much stronger in the coming days / weeks. Check [here](https://github.com/Timmoth/Sapling/tree/main/Sapling.Engine/Resources/WeightsHistory) to see the sequence of networks starting from scratch and the training logs.

## Resources:
- [Chess Programming Wiki](https://www.chessprogramming.org/)
- [Talk Chess Forum](https://talkchess.com/)
- [Coding Adventure](https://www.youtube.com/watch?v=U4ogK0MIzqk)
