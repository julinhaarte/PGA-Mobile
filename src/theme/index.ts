import { MD3LightTheme, configureFonts } from 'react-native-paper';

const fontConfig = {
  displayLarge: {
    fontFamily: 'System',
    fontSize: 32,
    fontWeight: '700',
  },
  displayMedium: {
    fontFamily: 'System',
    fontSize: 28,
    fontWeight: '600',
  },
  displaySmall: {
    fontFamily: 'System',
    fontSize: 24,
    fontWeight: '600',
  },
  headlineLarge: {
    fontFamily: 'System',
    fontSize: 22,
    fontWeight: '600',
  },
  headlineMedium: {
    fontFamily: 'System',
    fontSize: 20,
    fontWeight: '600',
  },
  headlineSmall: {
    fontFamily: 'System',
    fontSize: 18,
    fontWeight: '600',
  },
  titleLarge: {
    fontFamily: 'System',
    fontSize: 16,
    fontWeight: '600',
  },
  titleMedium: {
    fontFamily: 'System',
    fontSize: 14,
    fontWeight: '600',
  },
  titleSmall: {
    fontFamily: 'System',
    fontSize: 12,
    fontWeight: '600',
  },
  bodyLarge: {
    fontFamily: 'System',
    fontSize: 16,
    fontWeight: '400',
  },
  bodyMedium: {
    fontFamily: 'System',
    fontSize: 14,
    fontWeight: '400',
  },
  bodySmall: {
    fontFamily: 'System',
    fontSize: 12,
    fontWeight: '400',
  },
  labelLarge: {
    fontFamily: 'System',
    fontSize: 14,
    fontWeight: '500',
  },
  labelMedium: {
    fontFamily: 'System',
    fontSize: 12,
    fontWeight: '500',
  },
  labelSmall: {
    fontFamily: 'System',
    fontSize: 10,
    fontWeight: '500',
  },
};

export const theme = {
  ...MD3LightTheme,
  colors: {
    ...MD3LightTheme.colors,
    primary: '#ae0f0a',
    primaryContainer: '#ffffff',
    secondary: '#8e0c08',
    secondaryContainer: '#ffffff',
    tertiary: '#d32f2f',
    tertiaryContainer: '#ffffff',
    surface: '#ffffff',
    surfaceVariant: '#f5f5f5',
    background: '#fafafa',
    error: '#b00020',
    errorContainer: '#ffebee',
    onPrimary: '#ffffff',
    onPrimaryContainer: '#410002',
    onSecondary: '#ffffff',
    onSecondaryContainer: '#410002',
    onSurface: '#1c1b1f',
    onSurfaceVariant: '#49454f',
    onBackground: '#1c1b1f',
    onError: '#ffffff',
    onErrorContainer: '#410002',
    outline: '#79747e',
    outlineVariant: '#cac4d0',
    shadow: '#000000',
    scrim: '#000000',
    inverseSurface: '#313033',
    inverseOnSurface: '#f4eff4',
    inversePrimary: '#ffb4ab',
    elevation: {
      level0: 'transparent',
      level1: '#ffffff',
      level2: '#f3f1f9',
      level3: '#e9e6f0',
      level4: '#e7e4ee',
      level5: '#e2dfe9',
    },
  },
  roundness: 12,
};