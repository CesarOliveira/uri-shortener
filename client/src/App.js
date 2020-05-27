import React, {Component} from 'react';
import Links from './components/links';

class App extends Component {
    render() {
        return (
            <Links links={this.state.links} />
        )
    }

    state = {
        links: []
    };

    componentDidMount() {
        fetch('http://shortener.cesaroliveira.com.br/api/links/hits')
            .then(res => res.json())
            .then((data) => {
                this.setState({ links: data })
            })
            .catch(console.log)
    }
}

export default App;
