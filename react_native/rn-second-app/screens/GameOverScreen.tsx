import React from "react";
import { View, Text, StyleSheet, Button } from "react-native";

interface GameOverScreenProps {
  rounds: number | undefined;
  userNumber: number | undefined;
  onRestart: any;
}

export const GameOverScreen: React.FC<GameOverScreenProps> = (props) => {
  return (
    <View style={styles.screen}>
      <Text>The Game is over</Text>
      <Text>Number of rounds: {props.rounds}</Text>
      <Text>Number was: {props.userNumber}</Text>
      <Button title="new game" onPress={props.onRestart} />
    </View>
  );
};

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
});
