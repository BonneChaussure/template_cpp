# C++ template

# 🧱 How to Use This C++ Template for New Projects

- This repository serves as a base C++ project template. Follow the steps below to clone and reuse it for other projects, solo or in group work with vscode.

- Clone this template in your folder : 
```bash
git clone https://github.com/BonneChaussure/template_cpp.git
```

- Once cloned rename the folder as you wish.

# ⚙️ Build Instructions

- To build your c++ code, use this command : 
```bash
./scripts/build.sh
```

- The command above will (by default) build your project in **Debug** mode.
- To build in **Release** mode, just specify it : 
```bash
./scripts/build.sh Release
```

- Once the compilation is done, you can find your complied file in ```/delivery/<COMPILE_MODE>/<YOUR_SYSTEM_PROCESSOR>/```

- Finaly, to **rename** your compliled file, you need to got to the ```CMakeLists.txt``` file and change this line : 

```project(MyCppProject VERSION 1.0 LANGUAGES CXX)```
