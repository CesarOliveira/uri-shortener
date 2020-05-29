import React, { Component } from 'react';
import axios from 'axios';

  class Create extends Component {
    constructor() {
      super();
      this.state = {
        destination_url: '',
        shorted_link: '',
      };
    }

    onChange = (e) => {
      this.setState({ [e.target.name]: e.target.value });
    }

    onSubmit = (e) => {
      e.preventDefault();
      const { destination_url } = this.state;

      axios.post('http://localhost:3001/api/links', { link: { destination_url } })
        .then((result) => {
          this.setState({ shorted_link: result.data.link.shorted_link });
        });
    }

    render() {
      const { destination_url, shorted_link } = this.state;
      return (
          <div class="col-lg-12">
            <div class="col-lg-12">
              <form onSubmit={this.onSubmit}>
                <div class="form-group">
                  <input
                    type="url"
                    name="destination_url"
                    value={destination_url}
                    onChange={this.onChange}
                    placeholder="Type the link you want to short"
                  />
                </div>
                <button type="submit" class="btn btn-primary">Shorten</button>
              </form>
            </div>
            <br/>
            {shorted_link && (
            <div class="alert alert-primary" role="alert">
              Here is you shortened URL: <a target="_blank" rel="noopener noreferrer" href={shorted_link}> {shorted_link}</a>
            </div>
            )}
          </div>
      );
    }
  };

  export default Create;

