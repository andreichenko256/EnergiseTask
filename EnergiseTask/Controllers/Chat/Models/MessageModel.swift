enum MessageSender {
    case user
    case other
}

struct MessageModel {
    let text: String
    let sender: MessageSender
}
