pragma solidity >=0.6.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract Poll {
    uint256 public pollCount = 0;
    uint256 public pollAnswerCount = 0;

    struct Answer {
        string id;
        string name;
    }
    struct PollData {
        uint256 id;
        string title;
        string desc;
        string[] answerKeys;
        uint256[] userAnswerKeys;
        mapping(string => Answer) answers;
        mapping(address => uint256) userAnswer;
        uint256 createdAt;
        address onwer;
    }
    struct PollAnswer {
        uint256 id;
        uint256 pollId;
        string answerId;
        uint256 createdAt;
        address onwer;
    }
    mapping(uint256 => PollData) public polls;
    mapping(address => uint256[]) public userPollKeys;
    mapping(address => uint256[]) public userAnswerKeys;
    mapping(uint256 => PollAnswer) public pollAnswers;
    event PollCreated(uint256 id);

    function createPoll(
        string memory _title,
        string memory _desc,
        Answer[] memory _answer
    ) public {
        pollCount++;
        polls[pollCount].desc = _desc;
        polls[pollCount].title = _title;
        polls[pollCount].onwer = msg.sender;
        polls[pollCount].createdAt = block.timestamp;
        polls[pollCount].id = pollCount;
        for (uint256 i = 0; i < _answer.length; i++) {
            polls[pollCount].answerKeys.push(_answer[i].id);
            polls[pollCount].answers[_answer[i].id] = _answer[i];
        }
        userPollKeys[msg.sender].push(pollCount);
        emit PollCreated(pollCount);

        // emit TaskCreated(taskCount, _message, false);
    }

    function createVote(uint256 _pollId, string memory _voteId)
        public
        returns (PollAnswer memory)
    {
        pollAnswerCount++;
        pollAnswers[pollAnswerCount] = PollAnswer(
            pollAnswerCount,
            _pollId,
            _voteId,
            block.timestamp,
            msg.sender
        );
        polls[_pollId].userAnswer[msg.sender] = pollAnswerCount;
        polls[_pollId].userAnswerKeys.push(pollAnswerCount);
        userAnswerKeys[msg.sender].push(pollAnswerCount);
        return pollAnswers[pollAnswerCount];
        // emit TaskCreated(taskCount, _message, false);
    }

    function getPollAnswerKey(uint256 id, uint256 key)
        public
        view
        returns (string memory)
    {
        return polls[id].answerKeys[key];
    }

    function getPollAnswerKeyLength(uint256 id) public view returns (uint256) {
        return polls[id].answerKeys.length;
    }

    function getPollAnwser(uint256 id, uint256 key)
        public
        view
        returns (Answer memory)
    {
        return polls[id].answers[polls[id].answerKeys[key]];
    }

    function getUserAnswerKey(uint256 _pollId) public view returns (uint256) {
        return polls[_pollId].userAnswer[msg.sender];
    }

    function getPollUserAnswerKeyLength(uint256 _pollId)
        public
        view
        returns (uint256)
    {
        return polls[_pollId].userAnswerKeys.length;
    }

    function getUserPollKeyFromIndex(uint256 index)
        public
        view
        returns (uint256)
    {
        return userPollKeys[msg.sender][index];
    }

    function getUserAnswerFromIndex(uint256 index)
        public
        view
        returns (PollAnswer memory)
    {
        return pollAnswers[userAnswerKeys[msg.sender][index]];
    }

    function getUserPollKeyLength() public view returns (uint256) {
        return userPollKeys[msg.sender].length;
    }

    function getUserAnswerKeyLength() public view returns (uint256) {
        return userAnswerKeys[msg.sender].length;
    }

    function getPollUserAnswer(uint256 id, uint256 key)
        public
        view
        returns (PollAnswer memory)
    {
        return pollAnswers[polls[id].userAnswerKeys[key]];
    }
}
