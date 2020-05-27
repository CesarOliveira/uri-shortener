import React from 'react'

const Links = ({links}) => {
    return (
        <div>
            <center><h1>Most Accessed Link</h1></center>
            {links.map((link) => (
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">{link.title}</h5>
                        <h6 class="card-subtitle mb-2 text-muted">{link.destination_url}</h6>
                        <p class="card-text">{link.total_hits}</p>
                        <p class="card-text">{link.unique_hits}</p>
                    </div>
                </div>
            ))}
        </div>
    )
};

export default Links
