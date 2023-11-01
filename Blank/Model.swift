//
//  Model.swift
//  Blank
//
//  Created by Rajesh Khuntia on 31/10/23.
//


import Foundation

struct Task:Identifiable{
    var id=UUID()
    var name:String
    var date:Date
    var list:List?
    var priority:Priority
    var description:String
    
    
    
}
enum Priority:Int{
    case  p1=1
    case  p2=2
    case  p3=3
    case  p4=4
}

struct List:Identifiable,Equatable{
    var id=UUID()
    var name:String
}
class Manager:ObservableObject{
    @Published var tasks:[Task]=[]
    @Published var lists:[List]=[]
    @Published var changingTasks:[Task]=[]
    init() {
        lists.append(List(name: "holiday"))
        lists.append(List(name: "house party"))
        lists.append(List(name: "road trip"))
        for _ in 1...20{
            
            tasks.append(Task(name: generateRandomWordsString(length: 3), date: generateRandomDate(), list: generateRandomList(), priority: generateRandomPriority(), description: generateRandomWordsString(length: 10)))
        }
        
        tasks.sort{$0.priority.rawValue<$1.priority.rawValue}
        changingTasks=tasks
        
        
    }
    
    func addNewTask(){}
    func EditTask(){}
    func DeleteTask(){}
    func addNewList(){}
    func EditList(){}
    func DeleteList(){}
    
    
    
    
    func generateRandomWordsString(length: Int) -> String {
        let words = ["apple", "banana", "cherry", "orange", "grape", "pineapple", "strawberry", "blueberry", "kiwi", "watermelon"]
        var randomWords = [String]()
        
        for _ in 0..<length {
            let randomIndex = Int.random(in: 0..<words.count)
            let randomWord = words[randomIndex]
            randomWords.append(randomWord)
        }
        
        return randomWords.joined(separator: " ")
    }
    
    
    func generateRandomPriority()->Priority{
        let x=Int.random(in: 1...4)
        if x==1
        { return Priority.p1}
        if x==2
        {return Priority.p2}
        if x==3
        {   return Priority.p3}
        if x==4
        {return Priority.p4}
        return Priority.p1
    }
    
    
    func generateRandomDate() -> Date {
        let dateComponents = DateComponents(
            year: Int.random(in: 1...2023),
            month: Int.random(in: 1...12),
            day: Int.random(in: 1...28),
            hour: Int.random(in: 1...23),
            minute: Int.random(in: 1...59)
        )
        return Calendar.current.date(from: dateComponents)!
    }
    
    func generateRandomList()->List{
        let x=Int.random(in: 0...lists.count-1)
        return lists[x]
        
    }
    
    
    func last3Days(){
        
        let currentDate = Date()
        
        // Calculate the date 3 days ago
        let threeDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: currentDate)!
        
        // Filter tasks for the last 3 days
        let tasksInLastThreeDays = tasks.filter { $0.date >= threeDaysAgo }
        
        changingTasks = tasksInLastThreeDays
        
    }
    func next7Days(){
        
        
    }
    func lastMonth(){
        
        
        
        let currentDate = Date()
        
        // Calculate the date 3 days ago
        let threeDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: currentDate)!
        
        // Filter tasks for the last 3 days
        let tasksInLastThreeDays = tasks.filter { $0.date >= threeDaysAgo }
        
        changingTasks = tasksInLastThreeDays
    }
    
    func today(){
        let currentDate=Date()
        let tasksInToday = tasks.filter { Calendar.current.isDate($0.date,inSameDayAs: currentDate) }
        changingTasks = tasksInToday
        
    }
    
    func tomorrow(){
        
        
        let today = Date()
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)
        
        let tasksInTomorrow = tasks.filter { Calendar.current.isDate($0.date,inSameDayAs: tomorrow!)}
        
        changingTasks = tasksInTomorrow
    }
    
    
    func byList(listt:List){
        let taskByList=tasks.filter{$0.list == listt}
        changingTasks=taskByList
        
    }
    
}
