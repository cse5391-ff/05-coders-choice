**Name**: Jenn Le, Seung Ki Lee **ID**: 45920619, 35460312

## Proposed Project

> Our app is a collaborative youtube playlist and we named it Endlist. Endlist seeks to provide a simple and easy way to manage playlists among a large group of people. Generally in a large group setting like party, one person will typically have a machine that controls the music in the room. Endlist allows the user to invite people, join playlists, add songs, and vote on the songs, thereby democratizing the playlist management. Because the application requires streaming videos in sync among a large group of people, minimizing the latency is critical. For this very reason, we've chosen Elixir/Phoenix for our backend.

## Outline Structure

> We plan to use Reactjs, Phoenix, and Electron as web frameworks for Endlist to make it a cross-platform application. Each user will be able to create and join playlists. At this stage of the design, we seek to limit the use of supervisors to to form a "room." A room is a playlist with multiple participants, and to make sure everyone is in-sync it will have a rest-for-one strategy with transient option so it will restart at an unexpected crush. 