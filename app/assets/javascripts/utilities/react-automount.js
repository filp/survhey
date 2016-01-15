// Takes care of mounting react components in the page. This file is segregated
// from the rest of the application code and should be used wisely because
// requiring it causes a chain-reaction of requires that will include all of the
// react components and most of the other utilities and elements. This is fine
// when we're working on the application code, which will eventually use
// everything, but it's not OK when we're working on small-footprint files like
// public.js, which have to remain small and don't want to contain unused junk.

import _ from "lodash";
import humps from "humps";
import React from "react";
import ReactDOM from "react-dom";

const COMPONENTS = require("../components");

const REACT_CLASS_ATTRIBUTE = "data-react-class";
const REACT_PROPS_ATTRIBUTE = "data-react-props";

const findReactNodes = (ancestor) => {
  return (ancestor || document).querySelectorAll(`[${REACT_CLASS_ATTRIBUTE}]`);
};

// The exported method takes care of identifying all React components in the
// page, the mounting order of each of them (as some might require other
// components to be mounted first) and then mounts them.
export default function reactMount(ancestor) {
  // Find all nodes where a react component needs to be rendered
  var nodes = findReactNodes(ancestor);

  var mountable = {};

  var mountableEntry = () => ({
    mountsAfter: [],
    toMount:     [],
  });

  var ensureMountableEntry = (name) => {
    if (mountable[name] === undefined) mountable[name] = mountableEntry();
  };

  _.each(nodes, (node) => {
    // Find out the class name of the requested React component
    var name = node.getAttribute(REACT_CLASS_ATTRIBUTE);

    // Ensure we have an entry ready for this class name
    ensureMountableEntry(name);

    // Pick up the actual component class
    var component = COMPONENTS[name];

    if (!component) {
      throw new Error(`The "${name}" component could not be found. ` +
                      "Is it listed in components.js in impraise-components?");
    }

    // Parse the props (if none are present, the result will be null)
    var propsJSON = node.getAttribute(REACT_PROPS_ATTRIBUTE);
    var props     = humps.camelizeKeys(JSON.parse(propsJSON));

    // Push this component to the queue of components to mount
    mountable[name].toMount.push({
      node,
      component,
      props,

      // Tracks whether the component is mounted; used to resolve dependencies
      mounted: false,
    });

    // Find out if this component has any dependencies
    var dependencies = component.componentShouldMountBefore;

    // Skip the remaining part if there are no dependencies
    if (!dependencies) return;

    _.each(dependencies, (dependency) => {
      ensureMountableEntry(dependency);

      mountable[dependency].mountsAfter.push(name);
    });
  });

  // We can now mount components while respecting dependencies.
  // `fetchAndMountEntry` finds the object corresponding to the name and
  // delegates to itself any dependencies it encounters.
  const fetchAndMountEntry = (name) => {
    var entry = mountable[name];

    // Resolve any dependencies before continuing
    _.each(entry.mountsAfter, fetchAndMountEntry);

    // Finish up by mounting the actual components
    _.each(entry.toMount, (item) => {
      if (item.mounted) return;
      item.mounted = true;

      ReactDOM.render(
        React.createElement(item.component, item.props), item.node
      );
    });
  };

  // Mount all of the entries
  _.each(_.keys(mountable), fetchAndMountEntry);
}
