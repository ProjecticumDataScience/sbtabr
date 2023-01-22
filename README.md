
<!-- README.md is generated from README.Rmd. Please edit that file -->

# The ONTOX package for merging and visualizing SBtab files

The functions within this package can be used to merge and visualize
SBtab files as provided by the SysRev platform. It has originally been
made as part of a Data Science project for the University of Applied
Sciences in Utrecht.

## Installation

The development version of PackageONTOX can be installed from
[GitHub](https://github.com/) by using:

``` r
# install.packages("devtools")
devtools::install_github("ProjecticumDataScience/PackageONTOX")
```

# Functions

The package currently contains the following functions:
<ul>
<li>
Merging:
<ul>
<li>
sep_sbtab
</li>
<li>
prep_merge
</li>
<li>
merge_prepped
</li>
</ul>
<li>
visualizations:
<ul>
<li>
net_graph
</li>
<li>
merged_net_graph
</li>
</ul>
</ul>

To show the use of the package we first load the needed libraries.

``` r
library(PackageONTOX)
```

The package also contains a variety of data files:

[Raw
data](https://github.com/ProjecticumDataScience/PackageONTOX/data-raw)
consists of four SBtab files in the .tsv format. These have been
provided by M. Teunis from University of Applied Sciences Utrecht and
were a product of the SysRev platform.

[Data](https://github.com/ProjecticumDataScience/PackageONTOX/data)
consists of four types of files. The filenames starting with *physmap*
are the original SBtab files seperated into four dataframes using the
sep_sbtab function. Each dataframe is placed in a folder corresponding
with the type of data it provided within the SBtab file
(incl. compartments, edges, reactions, species and full). Within these
same folders are the files with names starting with *prepped*. These are
the same dataframes except they have been prepped for merging using the
prep_merge function. Lastly, in the *merged* folder are the merged files
per dataframe, created with either the merge_prepped or merge_sbtab
functions. Aside from the files being the input and ouput for the
merging functions, they are also used by the visualization functions as
shown below.

## sep_sbtab

blah blah

## prep_merge

blah blah

## merge_prepped

blah blah

## merge_sbtab

blah blah

## net_graph

To be added.

## merged_net_graph

To be added.
