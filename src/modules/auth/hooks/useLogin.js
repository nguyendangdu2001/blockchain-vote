import { useAppDispatch } from "@hooks/reduxHook";
import { useMutation } from "react-query";
import { useNavigate } from "react-router";
import { login as loginAction } from "../slices";
import { login } from "../services/auth";

const useLogin = () => {
  const history = useNavigate();
  const dispatch = useAppDispatch();
  return useMutation(
    async (requestData) => {
      const { data } = await login(requestData);
      return data;
    },
    {
      onSuccess: (data) => {
        console.log(data);
        dispatch(loginAction(data));
        history("/project/public");
      },
    }
  );
};

export default useLogin;
