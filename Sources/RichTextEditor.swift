//
//  RichTextEditor.swift
//  RichTextRow
//
//  Created by Fabio Felici on 5/4/17.
//  Copyright © 2017 HubSpot. All rights reserved.
//

import WebKit

public protocol RichTextEditorDelegate: class {
    func textDidChange(text: String)
    func heightDidChange()
}

public class RichTextEditor: UIView, WKScriptMessageHandler, WKNavigationDelegate, UIScrollViewDelegate {

    static let textDidChange = "textDidChange"
    static let heightDidChange = "heightDidChange"
    private static let defaultHeight: CGFloat = 60

    public weak var delegate: RichTextEditorDelegate?
    public var height: CGFloat = RichTextEditor.defaultHeight

    public var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }

    public var text: String? {
        didSet {
            guard let text = text else { return }
            if editorView.isLoading {
                textToLoad = text
            } else {
                editorView.evaluateJavaScript("richeditor.insertText(\"\(text.htmlEscapeQuotes)\");", completionHandler: nil)
                placeholderLabel.isHidden = !text.htmlToPlainText.isEmpty
            }
        }
    }

    private var editorView: WKWebView!
    private let placeholderLabel = UILabel()
    private var textToLoad: String?

    public override init(frame: CGRect = .zero) {
        placeholderLabel.textColor = UIColor.lightGray.withAlphaComponent(0.65)

        guard let scriptURL = Bundle(for: type(of: self)).path(forResource: "RichTextEditor", ofType: "js"),
            let scriptContent = try? String(contentsOfFile: scriptURL, encoding: String.Encoding.utf8),
            let htmlURL = Bundle(for: type(of: self)).path(forResource: "RichTextEditor", ofType: "html"),
            let html = try? String(contentsOfFile: htmlURL, encoding: String.Encoding.utf8)
            else { fatalError("Unable to find javscript/html for text editor") }

        let configuration = WKWebViewConfiguration()
        configuration.userContentController.addUserScript(
            WKUserScript(source: scriptContent,
                injectionTime: .atDocumentEnd,
                forMainFrameOnly: true
            )
        )

        editorView = WKWebView(frame: .zero, configuration: configuration)

        super.init(frame: frame)

        [RichTextEditor.textDidChange, RichTextEditor.heightDidChange].forEach {
            configuration.userContentController.add(self, name: $0)
        }

        editorView.navigationDelegate = self
        editorView.isOpaque = false
        editorView.backgroundColor = .clear
        editorView.scrollView.isScrollEnabled = false
        editorView.scrollView.showsHorizontalScrollIndicator = false
        editorView.scrollView.showsVerticalScrollIndicator = false
        editorView.scrollView.bounces = false
        editorView.scrollView.isScrollEnabled = false
        editorView.scrollView.delegate = self

        addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            placeholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addSubview(editorView)
        editorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            editorView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            editorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            editorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        editorView.loadHTMLString(html, baseURL: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case RichTextEditor.textDidChange:
            guard let body = message.body as? String else { return }
            placeholderLabel.isHidden = !body.htmlToPlainText.isEmpty
            delegate?.textDidChange(text: body)
        case RichTextEditor.heightDidChange:
            guard let height = message.body as? CGFloat else { return }
            self.height = height > RichTextEditor.defaultHeight ? height + 30 : RichTextEditor.defaultHeight
            delegate?.heightDidChange()
        default:
            break
        }
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let textToLoad = textToLoad {
            self.textToLoad = nil
            text = textToLoad
            placeholderLabel.isHidden = !textToLoad.htmlToPlainText.isEmpty
        }
    }

    public func viewForZooming(in: UIScrollView) -> UIView? {
        return nil
    }

}

fileprivate extension String {

    var htmlToPlainText: String {
        return [
            ("</?br>", "\n"),
            ("(<[^>]*>)|(&\\w+;)", " "),
            ("[ ]+", " "),
            ("^\\s+", "")
        ].reduce(self) {
            try! $0.replacing(pattern: $1.0, with: $1.1)
        }.resolvedHTMLEntities
    }

    var resolvedHTMLEntities: String {
        return self
            .replacingOccurrences(of: "&#39;", with: "'")
            .replacingOccurrences(of: "&#x27;", with: "'")
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "&nbsp;", with: " ")
    }

    func replacing(pattern: String, with template: String) throws -> String {
        let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex.stringByReplacingMatches(in: self, options: [], range: NSRange(0..<self.utf16.count), withTemplate: template)
    }

    var htmlEscapeQuotes: String {
        return [
            ("\"", "\\\""),
            ("“", "&quot;"),
            ("\r", "\\r"),
            ("\n", "\\n")
        ].reduce(self) {
            return $0.replacingOccurrences(of: $1.0, with: $1.1)
        }
    }
}
