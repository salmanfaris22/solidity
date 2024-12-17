// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import "hardhat/console.sol";

contract Todo {
    struct Task {
        uint id;
        string name;
        string data;
        bool exists; // Indicates if the task exists
    }

    address public owner;
    uint private taskId = 1;
    mapping(uint => Task) private tasks;

    modifier checkId(uint id) {
        require(id != 0 && id < taskId, "Invalid ID");
        require(tasks[id].exists, "Task does not exist.....");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

  constructor() {
    owner = msg.sender; // This should execute without issues
}


    function createTask(string calldata _taskName, string calldata _data) public {
        tasks[taskId] = Task(taskId, _taskName, _data, true);
        taskId++;
    }

    function updateTask(uint _id, string calldata _newTask, string calldata _data)
        public
        checkId(_id)
    {
        tasks[_id].name = _newTask;
        tasks[_id].data = _data;
    }

    function getAllTasks() public view returns (Task[] memory) {
        uint count = 0;

        // Count existing tasks
        for (uint i = 1; i < taskId; i++) {
            if (tasks[i].exists) {
                count++;
            }
        }

        // Create an array of existing tasks
        Task[] memory taskList = new Task[](count);
        uint index = 0;

        for (uint i = 1; i < taskId; i++) {
            if (tasks[i].exists) {
                taskList[index] = tasks[i];
                index++;
            }
        }

        return taskList;
    }

    function viewTask(uint _id) public view checkId(_id) returns (Task memory) {
        return tasks[_id];
    }

    function deleteTask(uint _id) public checkId(_id) {
        tasks[_id].exists = false;
    }
}


//0xD68Eae00ABf26851e1ef852aC9A35BF3E2D11586 to