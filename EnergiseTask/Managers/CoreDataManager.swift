import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EnergiseTask")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    // MARK: - Chat Methods

    func createChat(firstMessage: String) -> Chat {
        let chat = Chat(context: context)
        chat.id = UUID()
        chat.createdAt = Date()
        chat.firstMessage = firstMessage
        saveContext()
        return chat
    }

    func fetchChats() -> [Chat] {
        let request: NSFetchRequest<Chat> = Chat.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]

        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch chats: \(error)")
            return []
        }
    }

    func deleteChat(_ chat: Chat) {
        context.delete(chat)
        saveContext()
    }

    func addMessage(to chat: Chat, text: String, sender: String) {
        let message = Message(context: context)
        message.id = UUID()
        message.text = text
        message.timestamp = Date()
        message.sender = sender
        message.chat = chat
        saveContext()
    }

    func fetchMessages(for chat: Chat) -> [Message] {
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        request.predicate = NSPredicate(format: "chat == %@", chat)
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]

        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch messages for chat: \(error)")
            return []
        }
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
