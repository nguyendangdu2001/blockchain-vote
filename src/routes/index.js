import authRoute from "@modules/auth/routes";
import votingRoutes from "@modules/voting/route";

const routes = [...authRoute, ...votingRoutes];
export default routes;
