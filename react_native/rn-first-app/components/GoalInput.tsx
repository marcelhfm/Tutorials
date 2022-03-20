import React, { useState } from "react";
import { View, TextInput, Button, StyleSheet, Modal } from "react-native";

interface GoalInputProps {
  onAddGoal: any;
  visible: boolean;
  onCancel: any;
}

export const GoalInput: React.FC<GoalInputProps> = (props) => {
  const [enteredGoal, setEnteredGoal] = useState("");

  const goalInputHandler = (enteredGoal: any) => {
    setEnteredGoal(enteredGoal);
  };

  const addGoalHandler = () => {
    props.onAddGoal(enteredGoal);
    setEnteredGoal("");
  };

  return (
    <Modal visible={props.visible} animationType="slide">
      <View style={styles.inputContainer}>
        <TextInput
          placeholder="  Course goal"
          style={styles.input}
          onChangeText={goalInputHandler}
          value={enteredGoal}
        />
        <View style={styles.buttonView}>
          <View style={styles.button}>
            <Button title="Cancel" onPress={props.onCancel} color="red" />
          </View>
          <View style={styles.button}>
            <Button title="Add" onPress={addGoalHandler} />
          </View>
        </View>
      </View>
    </Modal>
  );
};

const styles = StyleSheet.create({
  inputContainer: {
    justifyContent: "center",
    alignItems: "center",
    flex: 1,
  },
  input: {
    borderColor: "black",
    borderWidth: 1,
    marginBottom: 10,
    width: "80%",
    height: 40,
  },
  buttonView: {
    flexDirection: "row",
    justifyContent: "space-between",
    width: "70%",
  },
  button: {
    width: "40%",
  },
});
