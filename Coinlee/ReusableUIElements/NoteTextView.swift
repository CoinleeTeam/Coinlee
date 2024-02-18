//
//  NoteTextView.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 04/11/2023.
//

import UIKit

final class NoteTextView: UITextView {
    private let noteTextViewPlaceholder = UILabel()
    
    override var bounds: CGRect {
        didSet {
            if shadowType == .bottom {
                createBasicContainerWithBottomShadow()
            } else if shadowType == .rounded {
                createBasicContainerWithRoundShadow()
            }
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setUpNoteTextView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Setup
    private func setUpNoteTextView() {
        noteTextViewPlaceholder.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 16)
        noteTextViewPlaceholder.textColor = .battleshipGrey
        noteTextViewPlaceholder.text = NSLocalizedString("note_text_view_placeholder", comment: "Note Text View Placeholder")
        
        textColor = .charcoal
        shadowType = .bottom
        font = UIFont(name: Fonts.Inter.medium.rawValue, size: 16)
        textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 0, right: 10)
        showsVerticalScrollIndicator = false
        layer.masksToBounds = false
        textContainer.maximumNumberOfLines = 6
        textContainer.lineBreakMode = .byTruncatingHead
        returnKeyType = .done
    }
    
    func togglePlaceholderVisibilityIfPossible(textViewText: String?) {
        guard let text = textViewText else { return }
        if text.isEmpty {
            noteTextViewPlaceholder.isHidden.toggle()
        }
    }
    
    // MARK: Constraints
    private func addConstraints() {
        addSubview(noteTextViewPlaceholder)
        
        noteTextViewPlaceholder.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(12)
        }
    }
}
