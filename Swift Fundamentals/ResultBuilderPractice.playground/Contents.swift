import SwiftUI

// MARK: - StringBuilder
@resultBuilder
struct StringBuilder {
    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: " ")
    }
}

func makeSentence(@StringBuilder _ content: () -> String) -> String {
    content()
}

let sentence = makeSentence {
    "Hello, World!"
    "To C, or Not to C"
    "Whoa!"
}

print(sentence)

// MARK: - FancyBuilder
@resultBuilder
struct FancyBuilder {
    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: ", ")
    }
    
    static func buildEither(first component: String) -> String {
        return "IF: \(component)"
    }
    
    static func buildEither(second component: String) -> String {
        return "ELSE: \(component)"
    }
    
}

func buildMessage(@FancyBuilder _ content: () -> String) -> String {
    content()
}

let result = buildMessage {
    if Bool.random() {
        "Heads"
    } else {
        "Tails"
    }
}

print(result)

// MARK: - MarkdownBuilder
protocol MarkdownElement {
    var render: String { get }
}

struct Heading: MarkdownElement {
    var text: String
    var render: String { "# \(text)\n" }
    
    init(_ text: String) {
        self.text = text
    }
}

struct Paragraph: MarkdownElement {
    var text: String
    var render: String { "\(text)\n" }
    
    init(_ text: String) {
        self.text = text
    }
}

struct Bullet: MarkdownElement {
    var text: String
    var render: String { "- \(text)\n" }
    
    init(_ text: String) {
        self.text = text
    }
}

@resultBuilder
struct MarkdownBuilder {
    static func buildBlock(_ components: MarkdownElement...) -> [MarkdownElement] {
        components
    }
}

func buildMarkdownString(@MarkdownBuilder _ content: () -> [MarkdownElement]) -> String {
    content().map { $0.render }.joined()
}

let markdown = buildMarkdownString {
    Heading("This is my markdown")
    Paragraph("I'm practicing making my own result builders")
    Bullet("not half bad")
    Bullet("would do this again")
}

print(markdown)
