import React from "react";
import { Mutation } from "react-apollo";
import { AddItemMutation } from "./operations.graphql";
import { LibraryQuery } from "../Library/operations.graphql";
import ProcessItemForm from "../ProcessItemForm";

const AddItemForm = () => (
  <Mutation mutation={AddItemMutation}>
    {(addItem, { loading, data }) => (
      <ProcessItemForm
        buttonText="Add Item"
        loading={loading}
        errors={data && data.addItem.errors}
        onProcessItem={({ title, description, imageUrl }) => {
          addItem({
            variables: {
              attributes: {
                title,
                description,
                imageUrl
              }
            },
            update: (cache, { data: { addItem } }) => {
              const item = addItem.item;
              if (item) {
                const { items: currentItems } = cache.readQuery({
                  query: LibraryQuery
                });
                cache.writeQuery({
                  query: LibraryQuery,
                  data: { items: [item].concat(currentItems) }
                });
              }
            }
          });
        }}
      ></ProcessItemForm>
    )}
  </Mutation>
);

export default AddItemForm;
