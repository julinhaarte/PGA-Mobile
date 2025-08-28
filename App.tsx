import 'react-native-gesture-handler';
import 'react-native-reanimated';
import React from 'react';
import { StatusBar } from 'expo-status-bar';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { Provider as PaperProvider } from 'react-native-paper';
import { GestureHandlerRootView } from 'react-native-gesture-handler';

import { LoginScreen } from './src/screens/LoginScreen';
import { DashboardScreen } from './src/screens/DashboardScreen';
import { ProjectsScreen } from './src/screens/ProjectsScreen';
import { SettingsScreen } from './src/screens/SettingsScreen';
import { CreateProjectScreen } from './src/screens/CreateProjectScreen';

import { theme } from './src/theme';

export type RootStackParamList = {
  Login: undefined;
  Dashboard: undefined;
  Projects: undefined;
  Settings: undefined;
  CreateProject: undefined;
};

const Stack = createStackNavigator<RootStackParamList>();

export default function App(): React.ReactElement {
  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <PaperProvider theme={theme}>
        <NavigationContainer>
          <Stack.Navigator
            initialRouteName="Login"
            screenOptions={{
              headerStyle: { backgroundColor: theme.colors.primary },
              headerTintColor: '#fff',
              headerTitleStyle: { fontWeight: 'bold' },
            }}
          >
            <Stack.Screen name="Login" component={LoginScreen} options={{ headerShown: false }} />
            <Stack.Screen name="Dashboard" component={DashboardScreen} options={{ title: 'Dashboard PGA 2025' }} />
            <Stack.Screen name="Projects" component={ProjectsScreen} options={{ title: 'Projetos' }} />
            <Stack.Screen name="Settings" component={SettingsScreen} options={{ title: 'Configurações' }} />
            <Stack.Screen name="CreateProject" component={CreateProjectScreen} options={{ title: 'Criar Projeto' }} />
          </Stack.Navigator>
        </NavigationContainer>
        <StatusBar style="light" />
      </PaperProvider>
    </GestureHandlerRootView>
  );
}
