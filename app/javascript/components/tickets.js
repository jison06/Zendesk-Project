import "./App.css";
import React, { useState, useEffect } from "react";
import axios from "axios";
import Ticket from "./components/Ticket";
import { Typography, Pagination, Row, Col, Alert } from "antd";
const { Title } = Typography;
import "antd/dist/antd.css";

const RenderCards = (tickets) => {
  if (!tickets.length) {
    return <Title>No Tickets!</Title>;
  } else {
    return tickets.map((ticket) => {
      return (
        <Row key={ticket.id}>
          <Col span={24}>
            <div className="post-container">
              <Ticket
                id={ticket.id}
                title={ticket.subject}
                status={ticket.status}
                content={ticket.description}
                updatedAt={new Date(ticket.updated_at).toLocaleString().replace(/(.*)\D\d+/, "$1")}
                createdAt={new Date(ticket.created_at).toLocaleString().replace(/(.*)\D\d+/, "$1")}
                tags={ticket.tags}
              />
            </div>
          </Col>
        </Row>
      );
    });
  }
};

const Tickets = () => {
  const [currentTickets, setCurrentTickets] = useState([])
  const [count, setCount] = useState(0)
  const [currentPage, setCurrentPage] = useState(1)
  const [error, setError] = useState(false)
  const [errorMessage, setErrorMessage] = useState('')
  useEffect(() => {
    axios.get(`/tickets/index?page=${currentPage}`).then((response) => {
        setCurrentTickets(response.data.tickets)
        history.pushState({page: currentPage}, `Page ${currentPage}`, `?page=${currentPage}`)
        setCount(response.data.count)
    }).catch((error) => {
      setError(true)
      setErrorMessage(error.response.data.errorMessage)
    })
  }, [])

  const handlePageChange = (page) => {
    axios.get(`/tickets/index?page=${page}`).then((response) => {
      setCurrentTickets(response.data.tickets)
      setCurrentPage(page)
      history.pushState({page: page}, `Page ${page}`, `?page=${page}`)
      window.scrollTo(0,0)
    }).catch((error) => {
      setError(true)
      setErrorMessage(error.response.data.errorMessage)
    })
  }

  return (
    <div className="App">
      { !error ? (
        <>
          <Title style={{ marginTop: 25 }} className="title">
            Tickets
          </Title>
          {RenderCards(currentTickets)}
          <Pagination total={count} current={currentPage} showSizeChanger={false} pageSize={25} onChange={(page, pageSize) => handlePageChange(page)}/>
        </>
      ) : (
        <>
          <Alert message={errorMessage} type="error" showIcon/>
        </>
      )}
    </div>
  );
};

export default Tickets;
