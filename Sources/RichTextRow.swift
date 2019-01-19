//
//  RichTextRow.swift
//  RichTextRow
//
//  Created by Fabio Felici on 5/3/17.
//

import Eureka

public final class RichTextCell: Cell<String>, CellType, RichTextEditorDelegate {

    required public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    lazy private var editor: RichTextEditor = {
        return RichTextEditor()
    }()

    private var tableView: UITableView? {
        return self.formViewController()?.tableView
    }

    public override func setup() {
        textLabel?.text = nil
        detailTextLabel?.text = nil
        height = {
            self.editor.height
        }
        editor.delegate = self
        editor.placeholder = row.title
        selectionStyle = .none
        contentView.addSubview(editor)
        editor.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
            [
                (.leading, 0),
                (.top, 0),
                (.trailing, 0),
                (.bottom, 0)
            ].map({
                .init(item: editor, attribute: $0, relatedBy: .equal, toItem: contentView, attribute: $0, multiplier: 1, constant: $1)
            })
        )
    }

    public override func update() {
        editor.text = row.value
    }

    public func textDidChange(text: String) {
        row.value = text
    }

    public func heightDidChange() {
        tableView?.beginUpdates()
        tableView?.endUpdates()
    }

}

public final class RichTextRow: Row<RichTextCell>, RowType {

    required public init(tag: String?) {
        super.init(tag: tag)
    }
}
