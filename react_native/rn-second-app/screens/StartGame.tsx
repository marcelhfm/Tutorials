import React, { useState } from "react";
import {
  View,
  Text,
  StyleSheet,
  Button,
  TouchableWithoutFeedback,
  Keyboard,
  Alert,
} from "react-native";
import { CardContainer } from "../components/CardContainer";
import { Input } from "../components/Input";
import { NumberContainer } from "../components/NumberContainer";
import colors from "../constants/colors";

interface StartGameProps {
  onStartGame: Function;
}

export const StartGame: React.FC<StartGameProps> = (props) => {
  const [enteredValue, setEnteredValue] = useState<string>("");
  const [confirmed, setConfirmed] = useState<boolean>(false);
  const [selectedNumber, setSelectedNumber] = useState<number>();

  const numberInputValidator = (inputText: string) => {
    if (!/^\d+$/.test(inputText)) {
      setEnteredValue("");
    } else {
      setEnteredValue(inputText);
    }
  };

  const resetInputHandler = () => {
    setEnteredValue("");
    setConfirmed(false);
  };

  const confirmInputHandler = () => {
    const chosenNumber = parseInt(enteredValue);
    if (isNaN(chosenNumber) || chosenNumber <= 0 || chosenNumber > 99) {
      Alert.alert("Invalid Input", "Number has to be between 1 and 99.", [
        { text: "Dismiss", style: "destructive", onPress: resetInputHandler },
      ]);
      return;
    }
    setConfirmed(true);
    setSelectedNumber(chosenNumber);
    setEnteredValue("");
    Keyboard.dismiss();
  };

  let confirmedOutput;

  if (confirmed) {
    confirmedOutput = (
      <CardContainer style={styles.number}>
        <Text>You selected:</Text>
        <NumberContainer number={selectedNumber} />
        <Button
          title="Start game"
          onPress={() => props.onStartGame(selectedNumber)}
          color={colors.primary}
        />
      </CardContainer>
    );
  }

  return (
    <TouchableWithoutFeedback
      onPress={() => {
        Keyboard.dismiss();
      }}
    >
      <View style={styles.screen}>
        <Text style={styles.title}>Start a new game!</Text>
        <CardContainer style={styles.cardContainer}>
          <Text>Select a number</Text>
          <Input
            blurOnSubmit
            autoCapitalize="none"
            maxLength={2}
            autoCorrect={false}
            keyboardType="number-pad"
            style={styles.input}
            value={enteredValue}
            onChangeText={numberInputValidator}
          />
          <View style={styles.buttonContainer}>
            <View style={styles.button}>
              <Button
                title="Reset"
                onPress={resetInputHandler}
                color={colors.secondary}
              />
            </View>
            <View style={styles.button}>
              <Button
                title="Confirm"
                onPress={confirmInputHandler}
                color={colors.primary}
              />
            </View>
          </View>
        </CardContainer>
        {confirmedOutput}
      </View>
    </TouchableWithoutFeedback>
  );
};

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    padding: 10,
    alignItems: "center",
  },
  buttonContainer: {
    flexDirection: "row",
    width: "100%",
    justifyContent: "space-between",
    paddingHorizontal: 15,
  },

  title: {
    fontSize: 20,
    marginVertical: 10,
  },
  cardContainer: {
    width: 300,
    maxWidth: "80%",
    alignItems: "center",
  },
  button: {
    width: 100,
  },
  input: {
    width: "30%",
    textAlign: "center",
  },
  number: {
    marginVertical: 20,
    alignItems: "center",
    width: "60%",
  },
});
