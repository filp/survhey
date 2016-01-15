import React from "react";

const CHOICES_LIMIT = 25;
const PLACEHOLDER = "first choice";

const ChoicesForm = React.createClass({
  getInitialState() {
    return {
      choices: 1
    };
  },

  disableEnter(event) {
    if (event.which === 13) {
      event.preventDefault();
    }
  },

  updateChoices(id) {
    var num = this.state.choices;

    if (id + 1 == num && num < CHOICES_LIMIT) {
      this.setState({ choices: num + 1 });
    }
  },

  choices() {
    var choices = [];

    for (var id = 0; id < this.state.choices; id++) {
      var formKey = "survey[choices_attributes][" + id + "][body]";
      var placeholder = id === 0 && PLACEHOLDER || "";

      choices.push(
        <input type="text" key={id} name={formKey} className="text-input survey__choices-form__choice-input"
               onChange={this.updateChoices.bind(this, id)} placeholder={placeholder} onKeyDown={this.disableEnter} />
      );
    }

    return choices;
  },

  render() {
    return (
      <div className="survey__choices-form">
        {this.choices()}
      </div>
    );
  }
});

export default ChoicesForm;
