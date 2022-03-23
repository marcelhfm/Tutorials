import React from "react";
import { View, Text, StyleSheet } from "react-native";
import colors from "../constants/colors";

interface HeaderProps {
  title: string;
}

export const Header: React.FC<HeaderProps> = (props) => {
  return (
    <View style={styles.header}>
      <Text style={styles.title}>{props.title}</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  header: {
    width: "100%",
    height: 90,
    paddingTop: 36,
    backgroundColor: colors.primary,
    alignItems: "center",
    justifyContent: "center",
  },
  title: {
    color: "black",
    fontSize: 18,
  },
});
