# Newspaper Text Padding

The Challenge

> You will be given a selection of text, and you must produce the same text with a maximum line
> width of characters. The formatted text must be output with full justification (adjusting the word
> spacing so that the text spans the width of the entire line, and the first and last words are flush
> to the left and right margins).


## Example:

>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac lorem
> vitae mi mollis lacinia. Proin in metus accumsan, maximus turpis vel,
> volutpat leo. Fusce sit amet ultrices elit. Pellentesque habitant
> morbi tristique senectus et netus et malesuada fames ac turpis
> egestas.

## Output (line width of 50 characters):

```sh
Lorem ipsum dolor sit amet, consectetur adipiscing
elit.  Ut ac lorem vitae mi mollis lacinia.  Proin
in  metus  accumsan, maximus turpis vel,  volutpat
leo.  Fusce  sit amet ultrices elit.  Pellentesque
habitant  morbi  tristique  senectus et  netus  et
malesuada     fames     ac     turpis     egestas.
```
### Usage :

```sh
$ text = %q(Hello from Text Formatter. Markdown is a lightweight markup language based on the formatting conventions that people naturally use in email. )
$ TextFormatter.format_ruby_text(text,50,true) # For Formatted Text
$ TextFormatter.format_ruby_text(text,50,false) # For UnFormatted Text
```
