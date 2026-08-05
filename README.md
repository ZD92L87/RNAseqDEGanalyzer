# rnaseq-de (Standalone)

A standalone, Codex-ready distribution of the ClawBio `rnaseq-de` Agent Skill.

## Original Skill

- Skill page: https://skillsmp.com/creators/clawbio/clawbio/skills-rnaseq-de
- Source repository: https://github.com/ClawBio/ClawBio/tree/main/skills/rnaseq-de
- Original license: MIT

## Why This Repo Exists

The upstream skill is designed to run from inside the full ClawBio repository. When installed as a standalone skill folder, `rnaseq_de.py` fails because it imports `clawbio.common.report`, a helper that lives outside `skills/rnaseq-de`.

This distribution patches that for standalone use:

1. Adds an embedded `write_result_json` implementation matching ClawBio's result envelope, so the skill does not require the missing shared package.
2. Forces Matplotlib to use the headless `Agg` backend, so PNG report generation works in Windows, CI, and other shells without Tk/Tcl.

No other upstream behavior is changed. The original `SKILL.md`, script, examples, tests, and fixtures are included.

## How to Use

After installation, invoke the skill's CLI from the skill folder:

```bash
python rnaseq_de.py \
  --counts counts.csv \
  --metadata metadata.csv \
  --formula "~ batch + condition" \
  --contrast "condition,treated,control" \
  --output rnaseq_de_report
```

The `--demo` flag runs the bundled toy dataset:

```bash
python rnaseq_de.py --demo --backend simple --output report_simple
python rnaseq_de.py --demo --backend pydeseq2 --output report_pydeseq2
```

Expected output:

```text
rnaseq_de_report/
├── report.md
├── result.json
├── figures/
│   ├── pca.png
│   ├── volcano.png
│   └── ma_plot.png
├── tables/
│   ├── qc_summary.csv
│   ├── normalized_counts.csv
│   └── de_results.csv
└── reproducibility/
    ├── commands.sh
    ├── environment.yml
    └── checksums.sha256
```

## Dependencies

Required:

- Python >= 3.10
- pandas
- numpy
- scipy
- scikit-learn
- matplotlib

Optional:

- pydeseq2 (enables the DESeq2-compatible backend and LFC shrinkage; without it the skill falls back to its built-in simple backend)

Install with pip:

```bash
python -m pip install pandas numpy scipy scikit-learn matplotlib pydeseq2
```

## Installation

### Option 1: npx skills

From this GitHub repository:

```bash
npx skills add https://github.com/ZD92L87/RNAseqDEGanalyzer --skill rnaseq-de
```

### Option 2: Manual Codex installation

Clone this repo:

```bash
git clone https://github.com/ZD92L87/RNAseqDEGanalyzer.git
cd RNAseqDEGanalyzer
```

Windows:

```powershell
./install.ps1
```

macOS / Linux:

```bash
./install.sh
```

These installers copy the complete skill to `$CODEX_HOME/skills/rnaseq-de` (default: `~/.codex/skills/rnaseq-de`).

### Option 3: Manual copy

Copy the entire `rnaseq-de` folder, not just `SKILL.md`, into:

- `$CODEX_HOME/skills/rnaseq-de`, or
- `C:\Users\<you>\.codex\skills\rnaseq-de` on Windows

## Notes

- The skill is available to Codex on the next session after installation.
- Re-running `npx skills update` against the upstream ClawBio source will overwrite the local compatibility patches.
- This package retains the upstream MIT license.

## License

MIT. See [LICENSE](LICENSE). Original copyright (c) 2026 Manuel Corpas.
