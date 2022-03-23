import { StyleSheet, View } from "react-native";
import { Header } from "./components/Header";
import { StartGame } from "./screens/StartGame";
import { GameScreen } from "./screens/GameScreen";
import { GameOverScreen } from "./screens/GameOverScreen";
import { useState } from "react";

export default function App() {
  const [userNumber, setUserNumber] = useState<number | undefined>();
  const [guessRounds, setGuessRounds] = useState<number>(0);

  const configureNewGame = () => {
    setGuessRounds(0);
    setUserNumber(-1);
  };

  const startGameHandler = (selectedNumber: number) => {
    setUserNumber(selectedNumber);
  };

  const gameOverHandler = (numOfRounds: number) => {
    setGuessRounds(numOfRounds);
  };

  let content = <StartGame onStartGame={startGameHandler} />;

  if (userNumber! < 0 && guessRounds <= 0) {
    content = (
      <GameScreen userChoice={userNumber || 0} onGameOver={gameOverHandler} />
    );
  } else if (guessRounds > 0) {
    content = (
      <GameOverScreen
        rounds={guessRounds}
        userNumber={userNumber}
        onRestart={configureNewGame}
      />
    );
  }

  return (
    <View style={styles.screen}>
      <Header title="Guess a number" />
      {content}
    </View>
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1,
  },
});
