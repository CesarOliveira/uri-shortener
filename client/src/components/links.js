import React from 'react'

const Links = ({links}) => {
  return (
      <div>
        <center><h1>Most Accessed Links</h1></center>

        <div class="row">
        <div class="col-lg-12">
          <table class="table table-striped">
            <thead>
              <tr>
                <th scope="col">#Id</th>
                <th scope="col">Title</th>
                <th scope="col">Identifier</th>
                <th scope="col">Destination</th>
                <th scope="col">Total Hits</th>
                <th scope="col">Unique Hits</th>
              </tr>
            </thead>
            <tbody>
              {links.map((link) => (
                <tr>
                  <th scope="row">{link.id}</th>
                  <td>{link.title}</td>
                  <td>
                    <a target="_blank" rel="noopener noreferrer" href={`http://api-shortener.local/${link.identifier}`}>http://api-shortener.local/{link.identifier}</a>
                  </td>
                  <td>{link.destination_url}</td>
                  <td>{link.total_hits}</td>
                  <td>{link.unique_hits}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        </div>
      </div>
  )
};

export default Links
