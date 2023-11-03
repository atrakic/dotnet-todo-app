import React, { Component } from 'react';

class HelloWorld extends Component {
  render() {
    console.log(process.env.HOST_IP_ADDRESS);
    return (
      <div className="helloContainer">
        <h1>Hello, world!</h1>
      </div>
    );
  }
}

export default HelloWorld;
