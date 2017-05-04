//
//  RichTextRow.swift
//  RichTextRow
//
//  Created by Fabio Felici on 5/3/17.
//  Copyright © 2017 HubSpot. All rights reserved.
//

import Eureka

public final class RichTextCell: Cell<String>, CellType, RichTextEditorDelegate {

    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
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
        NSLayoutConstraint.activate([
            editor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            editor.topAnchor.constraint(equalTo: contentView.topAnchor),
            editor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            editor.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
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
