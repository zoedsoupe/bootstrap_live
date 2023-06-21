import "../css/app.css";
import "bootstrap";
import { LiveSocket } from "phoenix_live_view";
import { Socket } from "phoenix";

const socketPath = document.querySelector("html").getAttribute("phx-socket") || "/live";
const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

const liveSocket = new LiveSocket(socketPath, Socket, {
  params: {_csrf_token: csrfToken},
});

liveSocket.connect();
window.liveSocket = liveSocket;
