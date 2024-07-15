
import React, { useState, useEffect } from 'react';
import axios from 'axios';

function App() {
    const [data, setData] = useState([]);
    const [currentPage, setCurrentPage] = useState(1);
    const [itemsPerPage] = useState(5);

    const getAllData = () => {
        axios.get(process.env.REACT_APP_API_URL)
            .then((response) => {
                console.log(response.data);
                setData(response.data);
            })
            .catch((error) => {
                console.log(error);
            });
    };

    useEffect(() => {
        getAllData();
    }, []);

    const lastItemIndex = currentPage * itemsPerPage;
    const firstItemIndex = lastItemIndex - itemsPerPage;
    const currentItems = data.slice(firstItemIndex, lastItemIndex);

    const displayData = () => {
        return currentItems.length ? (
            currentItems.map((item) => (
                <div className="data" key={item.id}>
                    <h3>{item.title}</h3>
                    <p>{item.description}</p>
                    <hr />
                </div>
            ))
        ) : (
            <h3>No API data from: {process.env.REACT_APP_API_URL}</h3>
        );
    };

    const totalPages = Math.ceil(data.length / itemsPerPage);

    const goToNextPage = () => {
        setCurrentPage((prevPage) => Math.min(prevPage + 1, totalPages));
    };

    const goToPreviousPage = () => {
        setCurrentPage((prevPage) => Math.max(prevPage - 1, 1));
    };

    return (
        <>
            {displayData()}
            <div className="pagination">
                <button onClick={goToPreviousPage} disabled={currentPage === 1}>Prev</button>
                <span>Page {currentPage} of {totalPages}</span>
                <button onClick={goToNextPage} disabled={currentPage === totalPages}>Next</button>
            </div>
        </>
    );
}

export default App;
