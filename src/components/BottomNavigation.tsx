import React from 'react';
import { View, StyleSheet, TouchableOpacity } from 'react-native';
import { Text, useTheme } from 'react-native-paper';
import { MaterialCommunityIcons } from '@expo/vector-icons';

interface BottomNavigationProps {
  currentRoute: string;
  onNavigate: (route: string) => void;
}

export const BottomNavigation: React.FC<BottomNavigationProps> = ({
  currentRoute,
  onNavigate,
}) => {
  const theme = useTheme();

  const routes = [
    {
      key: 'Dashboard',
      title: 'Dashboard',
      focusedIcon: 'view-dashboard',
      unfocusedIcon: 'view-dashboard-outline',
    },
    {
      key: 'Projects',
      title: 'Projetos',
      focusedIcon: 'folder',
      unfocusedIcon: 'folder-outline',
    },
    {
      key: 'CreateProject',
      title: 'Criar',
      focusedIcon: 'plus-circle',
      unfocusedIcon: 'plus-circle-outline',
    },
    {
      key: 'Settings',
      title: 'Config',
      focusedIcon: 'cog',
      unfocusedIcon: 'cog-outline',
    },
  ];



  return (
    <View style={styles.container}>
      {routes.map((route, index) => {
        const isActive = route.key === currentRoute;
        return (
          <TouchableOpacity
            key={route.key}
            style={styles.tab}
            onPress={() => onNavigate(route.key)}
          >
            <MaterialCommunityIcons
              name={isActive ? route.focusedIcon : route.unfocusedIcon as any}
              size={24}
              color={isActive ? theme.colors.primary : '#666666'}
            />
            <Text
              style={[
                styles.tabLabel,
                {
                  color: isActive ? theme.colors.primary : '#666666',
                  fontWeight: isActive ? 'bold' : 'normal',
                },
              ]}
            >
              {route.title}
            </Text>
          </TouchableOpacity>
        );
      })}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    backgroundColor: '#ffffff',
    borderTopWidth: 1,
    borderTopColor: '#e0e0e0',
    elevation: 8,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: -2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    minHeight: 70,
  },
  tab: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 8,
    paddingHorizontal: 4,
    minHeight: 70,
  },
  tabLabel: {
    fontSize: 11,
    marginTop: 6,
    textAlign: 'center',
    lineHeight: 14,
  },
});
