import React from 'react'
import { useState, useEffect } from 'react';
import axios from 'axios';

function Get() {
    const [data, setData]  = useState('');
    const getAllData = () => {
        axios.get(process.env.REACT_APP_API_URL)
          .then((response) => {
            console.log(response.data);
            setData(response.data);
          })
          .catch((error) => {
            console.log(error);
          });
    }
    useEffect(() => {
      getAllData();
    },[]);
  
    const displayData = () => {
      return data ? (
        data.map((data) => {
          return (
            <div className="data" key={data.id}>
              <h3>{data.title}</h3>
              <p>{data.description}</p>
              <hr />
            </div>
          );
        })
      ) : (
        <h3>No data yet</h3>
      );
    }
    return (
      <>
        {displayData()}
      </>
    );
  }

export default Get;
