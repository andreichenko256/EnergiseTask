enum MessageSender {
    case user
    case other
}

struct Message {
    let text: String
    let sender: MessageSender
}
