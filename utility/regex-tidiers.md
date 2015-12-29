Snippets that can help Tidy Code
========================================

1. Swap names when replacing `plyr::rename()` with `dplyr::rename_()`
    * Pattern:
        ```r
        "(\w+)"\s+= "(\w+)"
        ```
    * Replacement:
        ```r
        "\2"       = "\1"
        ```
1. Add space to prettify declaration of column types.   Then you have space to column-select multiple rows, and `ctrl + shift + right-arrow` to unify the alignment.
    * Pattern: 
        ```r
        "(\w+)"\s+= "(\w+)"
        ```
    * Replacement: 
        ```r
        "\1"                                             = "\2"
        ```
