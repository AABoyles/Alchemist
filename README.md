---
title: "Alchemist"
author: "Anthony Boyles"
date: "February 2, 2016"
output: html_document
---

Transmute useless data formats into useful datasets

Input Formats:
 * arff - Weka Attribut-Relation File Format
 * csv - Comma-delimited Files
 * dat - Fixed-width Files
 * dbf - XBase Files
 * dta - Stata Files
 * sasb7dat - SAS Files
 * sav - SPSS Files
 * spss - SPSS Files
 * tsv - Tab-delimited Files
 * xls - Excel 97/2000 Files
 * xlsx - Excel 2003+ Files

Output Formats:
 * arff
 * csv
 * dbf
 * dta
 * rds
 * sav
 * tsv
  
Constraints
-----------
 * It only does single sheets (for now...)
 * The theoretical maximum file size is 200MB, though I haven't load tested it.
 * It's running on a tiny server instance that I pay for out-of-pocket. Feel free to use as needed, but please don't hammer it.
