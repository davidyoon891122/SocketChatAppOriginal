//
//  ChatTableViewCell.swift
//  SocketChatApp
//
//  Created by David Yoon on 2022/07/26.
//

import SnapKit
import UIKit

final class ChatTableViewCell: UITableViewCell {
    static let identifier: String = "ChatTableViewCell"

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        return imageView
    }()

    private lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 13.0)
        return label
    }()

    private lazy var chatLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.numberOfLines = 5
        return label
    }()

    private lazy var chatLabelView: UIView = {
        let view = UIView()

        view.backgroundColor = .secondarySystemBackground

        view.layer.cornerRadius = 8.0
        view.layer.masksToBounds = true
        [
            chatLabel
        ]
            .forEach {
                view.addSubview($0)
            }

        chatLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8.0)
        }
        return view
    }()

    func setupCell(
        nickName: String,
        chat: String
    ) {
        nickNameLabel.text = nickName
        chatLabel.text = chat
        setupViews()
        selectionStyle = .none
    }
}

private extension ChatTableViewCell {
    func setupViews() {
        [
            profileImageView,
            nickNameLabel,
            chatLabelView
        ]
            .forEach {
                contentView.addSubview($0)
            }

        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.width.height.equalTo(40.0)
        }

        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().offset(-16.0)
        }

        chatLabelView.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(nickNameLabel)
            $0.bottom.equalToSuperview().offset(-8.0)
        }
    }
}
