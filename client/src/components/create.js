import React, { Component } from 'react';
import axios from 'axios';

  class Create extends Component {
    constructor() {
      super();
      this.state = {
        link_destination: '',
      };
    }

    onChange = (e) => {
      this.setState({ [e.target.name]: e.target.value });
    }

    onSubmit = (e) => {
      e.preventDefault();
      // get our form data out of state
      const { link_destination } = this.state;

      axios.post('/', { link_destination })
        .then((result) => {
          //access the results here....
        });
    }

    render() {
      const { link_destination } = this.state;
      return (
        <form onSubmit={this.onSubmit}>
          <input
            type="text"
            name="link_destination"
            value={link_destination}
            onChange={this.onChange}
          />
          <button type="submit">Submit</button>
        </form>
      );
    }
  };

  export default Create;

