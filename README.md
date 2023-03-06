
# JuliaCon Proceedings

This [Quarto format](https://quarto.org/) will help you create documents for the [JuliaCon Proceedings](https://proceedings.juliacon.org/).

## WARNING

This is a very rough and preliminary version.
Many things do not work as intended currently, e.g.:

- Using theorems etc. causes [compilation errors](https://github.com/quarto-dev/quarto-cli/issues/3650#issuecomment-1455131905).
  Workaround: Use `::: {.theorem}` etc. divs. supported by the embedded quarto-ext/latex-environment extension.

- Unnumbered lists of the form `\begin{unnumlist} ... \end{unnumlist}` are not supported.

- Two-column tables `\begin{table*} ... \end{table*}` are not supported (ref [quarto-cli#2786](https://github.com/quarto-dev/quarto-cli/discussions/2786)).

## Creating a New Article

To create a new article using this format:

```bash
quarto use template devmotion/quarto-juliacon-proceedings
```

This will create a new directory with an example document that uses this format.

## Using with an Existing Document

To add this format to an existing document:

```bash
quarto add devmotion/quarto-juliacon-proceedings
```

Then, add the format to your document options:

```yaml
format:
  juliacon-pdf: default
```

## Example

Here is the source code for a minimal sample document: [template.qmd](template.qmd).
