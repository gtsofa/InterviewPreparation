## Create a table view cell in Interface builder
These are the steps to quickly create a table cell
- Create a new file with the name of nib file exactly as the name of the code file eg `WrongAnswerCell.xib`
- Select the Table view cell ie `WrongAnswerCell`
- Under the `Identity Inspector`(should be the 4th Icon) fill the class field with same name of your nib file. ie. `WrongAnswerCell`
- Under the `Attributes Inspector`(should be the 3rd Icon from right) fill in the Identity with the reusable identifier as nib file name . ie `WrongAnswerCell`
- Add labels to your nib file
- Connect the labels by control + drag it to the class that contains the code file .ie `WrongAnswerCell.swift` 

## Add auto layout to the table view cells in interface builder.
These are the steps for adding autolayout to the cells.
- Embed the labels in a stack view by selecting all labels and go to file menu and on the `Editor` -> `Embed in` -> `Stack view`.
- While selecting the `stack view` hold `control` and drag to the content view slowly and release once you see the dropdown menu. 
- Add the four constraints namely leading space to container margin,trailing,top and bottom. When you're done, you will a folder with your constraints.
- While still on Stack view, go to the `Size Inspector`(should be the 2nd Icon from the right). Remove the auto generated constraints values and set your. I usually set them to default by adding `0` to theconstant field. When you're done. You should see something like `Trailing Space to: Superview.` to all the 4.

#### How to add a delegate to the interface builder table view
Add delegate by selecting table view, control + drag to file owner's and select delegate to choose. This is when you want to a delegate to your table view. For my case here it's `ResultsViewController` file that I want to add the delegate to and not any table view cell.

> **_Tip:_**  This is to add add a delegate to a table view on the interface build. Follow this pro tip right here. Hold `control` + `drag` to `file owner's` and release to select option. In this case choose `delegate`.



