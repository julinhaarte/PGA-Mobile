# PGA Mobile - React Native App

Aplicativo mobile nativo para o sistema PGA 2025 da Fatec Votorantim, desenvolvido com React Native e Expo.

## 🚀 **Como Executar o Projeto**

### **Pré-requisitos:**
- Node.js (versão 18 ou superior)
- npm ou yarn
- Expo CLI
- Android Studio (para Android) ou Xcode (para iOS)

### **1. Instalar Expo CLI Globalmente:**
```bash
npm install -g @expo/cli
```

### **2. Instalar Dependências:**
```bash
cd PGA-Mobile
npm install
```

### **3. Executar o Projeto:**

#### **Opção A: Expo Go (Mais Simples)**
```bash
npm start
```
- Escaneie o QR code com o app Expo Go no seu celular
- Ou pressione `w` para abrir no navegador

#### **Opção B: Emulador Android**
```bash
npm run android
```

#### **Opção C: Simulador iOS (apenas macOS)**
```bash
npm run ios
```

#### **Opção D: Web**
```bash
npm run web
```

## 📱 **Funcionalidades Implementadas**

### **✅ Telas Criadas:**
- **LoginScreen**: Tela de autenticação com design moderno
- **DashboardScreen**: Dashboard principal com estatísticas e projetos
- **ProjectsScreen**: Lista de projetos com filtros e busca
- **BottomNavigation**: Navegação inferior intuitiva

### **✅ Componentes:**
- **StatsCard**: Cards de estatísticas responsivos
- **ProjectCard**: Cards de projeto com progresso
- **BottomNavigation**: Navegação inferior personalizada

### **✅ Recursos:**
- Design Material Design 3
- Tema personalizado com cores da Fatec
- Navegação com React Navigation
- Componentes do React Native Paper
- Gradientes e animações
- Layout responsivo para diferentes tamanhos de tela

## 🎨 **Design System**

### **Cores:**
- **Primary**: `#ae0f0a` (Vermelho Fatec)
- **Secondary**: `#8e0c08` (Vermelho escuro)
- **Surface**: `#ffffff` (Branco)
- **Background**: `#f5f5f5` (Cinza claro)

### **Tipografia:**
- Sistema de fontes escalável
- Hierarquia clara de títulos
- Legibilidade otimizada para mobile

### **Componentes:**
- Cards com sombras e bordas arredondadas
- Botões com estados visuais claros
- Inputs com validação visual
- Progress bars coloridos

## 🔧 **Estrutura do Projeto**

```
PGA-Mobile/
├── src/
│   ├── components/          # Componentes reutilizáveis
│   │   ├── StatsCard.tsx
│   │   ├── ProjectCard.tsx
│   │   └── BottomNavigation.tsx
│   ├── screens/            # Telas da aplicação
│   │   ├── LoginScreen.tsx
│   │   ├── DashboardScreen.tsx
│   │   └── ProjectsScreen.tsx
│   └── theme/              # Configuração de tema
│       └── index.ts
├── App.tsx                 # Componente principal
├── app.json               # Configuração Expo
├── package.json           # Dependências
└── tsconfig.json          # Configuração TypeScript
```

## 📱 **Compatibilidade**

### **Plataformas:**
- ✅ Android (API 21+)
- ✅ iOS (12.0+)
- ✅ Web (Chrome, Firefox, Safari)

### **Dispositivos:**
- ✅ Smartphones
- ✅ Tablets
- ✅ Diferentes resoluções

## 🚀 **Próximos Passos**

### **Funcionalidades a Implementar:**
- [ ] Tela de criação de projeto
- [ ] Tela de configurações
- [ ] Autenticação real com backend
- [ ] Sincronização offline
- [ ] Push notifications
- [ ] Testes automatizados

### **Melhorias Técnicas:**
- [ ] Service Worker para cache
- [ ] Lazy loading de componentes
- [ ] Otimização de performance
- [ ] Internacionalização (i18n)

## 🐛 **Solução de Problemas**

### **Erro: "Metro bundler not found"**
```bash
npm install -g @expo/cli
expo install
```

### **Erro: "Android SDK not found"**
- Instale o Android Studio
- Configure as variáveis de ambiente ANDROID_HOME

### **Erro: "iOS Simulator not found"**
- Instale o Xcode (apenas macOS)
- Execute `sudo xcode-select --install`

### **App não carrega no Expo Go:**
- Verifique se o celular e computador estão na mesma rede
- Tente usar o IP local em vez de localhost

## 📚 **Recursos Úteis**

- [Expo Documentation](https://docs.expo.dev/)
- [React Native Documentation](https://reactnative.dev/)
- [React Navigation](https://reactnavigation.org/)
- [React Native Paper](https://callstack.github.io/react-native-paper/)

## 🤝 **Contribuição**

1. Faça um fork do projeto
2. Crie uma branch para sua feature
3. Commit suas mudanças
4. Push para a branch
5. Abra um Pull Request

## 📄 **Licença**

Este projeto é desenvolvido para a Fatec Votorantim como parte do sistema PGA 2025.

---

**Desenvolvido com ❤️ para a Fatec Votorantim** 🎓
