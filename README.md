Post-UITableViewCells
=====================

**This is a work-in-progress**

I'm building a UITableViewCell that gets its height from the data it's displaying. Many examples use UILabels with plain text, Mine are using attributed text strings in UITextViews. The TableView calculates the cell heights before displaying them, mostly because I can't figure out how to do this asynchronously.

I've gotten many ideas from this [Stack Overflow post](http://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-heights) and [caoimghgin's code](https://github.com/caoimghgin/TableViewCellWithAutoLayout) that is referenced in the SO comments.

## To-do

- Hit testing for individual letters.
- URL, link, @username and #hashtag detection.
- Aysyncronous calculating of cell heights.


## Known Issues

- Cell heights are calculated in `viewWillAppear:` so calculations don't need to be done while scrolling. This causes a bit of a lag at load time.

Please forgive my horrible code and copious errors.
