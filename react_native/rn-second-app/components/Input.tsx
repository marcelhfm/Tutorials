import React from "react";
import { TextInput, StyleSheet } from "react-native";

interface InputProps {
  style?: any;
  blurOnSubmit: any;
  autoCapitalize: any;
  maxLength: any;
  autoCorrect: any;
  keyboardType: any;
  value: any;
  onChangeText: any;
}

export const Input: React.FC<InputProps> = (props) => {
  return <TextInput {...props} style={{ ...styles.input, ...props.style }} />;
};

const styles = StyleSheet.create({
  input: {
    height: 30,
    borderBottomColor: "grey",
    borderBottomWidth: 1,
    marginVertical: 10,
  },
});
