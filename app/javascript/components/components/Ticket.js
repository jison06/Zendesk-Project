import { Typography, Tag, Collapse } from "antd";
const { Title } = Typography;
const { Panel } = Collapse;
import React from "react";

const Ticket = (props) => {
  return (
    <Collapse style={{ width: 1000, marginBottom: 5, marginTop: 5 }}>
      <Panel
        header={`${props.id}: ${props.title}`}
        extra={<Tag color="processing">Status: {props.status}</Tag>}
        style={{ textAlign: "left" }}
      >
        <Title level={5}>Created At</Title>
        <p>{props.createdAt}</p>
        <Title level={5}>Last Updated</Title>
        <p>{props.updatedAt}</p>
        <Title level={5}>Description</Title>
        {props.content}
        <p />
        <Title level={5}>Tags</Title>
        {props.tags.map((tag, index) => (
          <Tag color="gold" key={index}>
            {tag}
          </Tag>
        ))}
      </Panel>
    </Collapse>
  );
};

export default Ticket;
