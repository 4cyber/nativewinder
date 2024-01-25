# Chiede il nome della cartella
$nome = Read-Host "Inserisci il nome della cartella"

# Crea l'app Expo
npx create-expo-app $nome

# Naviga nella cartella appena creata
cd $nome

# Crea le cartelle "Pages" e "Components"
New-Item -ItemType Directory -Path .\Pages -Force
New-Item -ItemType Directory -Path .\Components -Force

# Installa le dipendenze
npm i nativewind
npm i --save-dev tailwindcss@3.3.2
npx tailwindcss init

# Modifica il file tailwind.config.js
@"
// tailwind.config.js
module.exports = {
  content: ["./App.{js,jsx,ts,tsx}", "./Pages/*.{js,jsx,ts,tsx}", "./Components/*.{js,jsx,ts,tsx}", "./Components/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {},
  },
  plugins: [],
}
"@ | Set-Content -Path tailwind.config.js -Force

# Modifica il file babel.config.js
@"
// babel.config.js
module.exports = function (api) {
  api.cache(true);
  return {
    presets: ["babel-preset-expo"],
    plugins: ["nativewind/babel"],
  };
};
"@ | Set-Content -Path babel.config.js -Force

# Modifica il file App.js
@"
// App.js
import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { Text, View } from 'react-native';

export default function App() {
  return (
    <View className="flex-1 items-center justify-center bg-white">
      <Text>Open up App.js to start working on your app!</Text>
      <StatusBar style="auto" />
    </View>
  );
}
"@ | Set-Content -Path App.js -Force

Write-Host "Template creato, buona programmazione!"
