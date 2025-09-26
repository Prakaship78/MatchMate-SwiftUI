# MatchMate-SwiftUI


An iOS app built with **Swift**, **SwiftUI**, **Core Data**, and **async/await networking**.  
The app fetches random users from API, persists them in Core Data, and allows updating their match status.  

---

## 🚀 Features  
- Fetch users from API using `URLSession` + `async/await`.  
- Display user list with name, address, and profile image.  
- Save, read, and update users in **Core Data**.  
- Cache the profile image using Kingfisher.  
- Handle API/network errors gracefully.  
- MVVM architecture 
- Dark/Light mode supported

---

## 📸 Demo  

![App Demo](./demo.gif)  

---

## 🛠️ Tech Stack  
- **Language**: Swift 5  
- **UI**: SwiftUI  
- **Persistence**: Core Data  
- **Networking**: URLSession + async/await  
- **Architecture**: MVVM
- **Libraries**: Kingfisher(Image caching)

---

## ⚡ Setup  

1. Clone the repo  
   ```bash
   git clone https://github.com/your-username/MatchMate.git
   cd MatchMate
   open project an let download dependency(Kingfisher)
   run the project
