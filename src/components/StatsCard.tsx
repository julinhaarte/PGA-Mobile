import React from 'react';
import { View, StyleSheet, Dimensions } from 'react-native';
import { Text, Card, useTheme } from 'react-native-paper';

const { width } = Dimensions.get('window');
const cardWidth = (width - 48) / 2; // 2 colunas com gap de 12

interface StatsCardProps {
  title: string;
  value: string;
  icon: string;
  color: string;
}

export const StatsCard: React.FC<StatsCardProps> = ({
  title,
  value,
  icon,
  color,
}) => {
  const theme = useTheme();

  return (
    <Card style={[styles.card, { width: cardWidth }]}>
      <Card.Content style={styles.content}>
        <View style={styles.iconContainer}>
          <Text style={styles.icon}>{icon}</Text>
        </View>
        <Text style={styles.value} variant="headlineMedium">
          {value}
        </Text>
        <Text style={styles.title} variant="bodyMedium">
          {title}
        </Text>
      </Card.Content>
    </Card>
  );
};

const styles = StyleSheet.create({
  card: {
    borderRadius: 16,
    elevation: 4,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  content: {
    padding: 16,
    alignItems: 'center',
  },
  iconContainer: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: '#f5f5f5',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 12,
  },
  icon: {
    fontSize: 24,
  },
  value: {
    fontWeight: 'bold',
    color: '#1c1b1f',
    marginBottom: 8,
    textAlign: 'center',
  },
  title: {
    color: '#49454f',
    textAlign: 'center',
    lineHeight: 18,
  },
});
