import React, { Component } from 'react';
import axios from 'axios';

  class Create extends Component {
    constructor() {
      super();
      this.state = {
        destination_url: '',
      };
    }

    onChange = (e) => {
      this.setState({ [e.target.name]: e.target.value });
    }

    onSubmit = (e) => {
      e.preventDefault();
      const { destination_url } = this.state;

      axios.post('http://shortener.cesaroliveira.com.br/api/links', { link: { destination_url } })
        .then((result) => {
          //access the results here....
        });
    }

    render() {
      const { destination_url } = this.state;
      return (
        <form onSubmit={this.onSubmit}>
          <input
            type="text"
            name="destination_url"
            value={destination_url}
            onChange={this.onChange}
          />
          <button type="submit">Submit</button>
        </form>
      );
    }
  };

  export default Create;

