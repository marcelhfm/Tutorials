import React from "react";
import { View, StyleSheet } from "react-native";

interface CardContainerProps {
  children: any;
  style?: any;
}

export const CardContainer: React.FC<CardContainerProps> = (props) => {
  return (
    <View style={{ ...styles.cardContainer, ...props.style }}>
      {props.children}
    </View>
  );
};

const styles = StyleSheet.create({
  cardContainer: {
    shadowColor: "black",
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowRadius: 6,
    shadowOpacity: 0.26,
    backgroundColor: "white",
    elevation: 8,
    padding: 15,
    borderRadius: 10,
  },
});
