import React from "react";
import ReactDOM from "react-dom";

const AutoFocusInput = React.createClass({
  propTypes: {
    value: React.PropTypes.string,
    readonly: React.PropTypes.bool
  },

  focus() {
    ReactDOM.findDOMNode(this.refs.input).select();
  },

  render() {
    return (
      <input type="text" {...this.props} ref="input" onFocus={this.focus} />
    );
  }
});

export default AutoFocusInput;
