// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/config;
import ballerina/http;
import ballerina/io;
import ballerina/test;

endpoint Client committerReportClient {};

@test:Config
function testPrintPullRequestList() {
    string githubUser = "ldclakmal";
    var details = committerReportClient->printPullRequestList(githubUser, STATE_ALL);
    match details {
        () => {}
        error err => {
            test:assertFail(msg = err.message);
        }
    }
}

@test:Config
function testPrintIssueList() {
    string githubUser = "ldclakmal";
    var details = committerReportClient->printIssueList(githubUser, STATE_ALL);
    match details {
        () => {}
        error err => {
            test:assertFail(msg = err.message);
        }
    }
}

@test:Config
function testPrintEmailList() {
    string userEmail = "chanakal@wso2.com";
    string[] excludeEmails = ["vacation-group@wso2.com"];
    var details = committerReportClient->printEmailList(userEmail, excludeEmails);
    match details {
        () => {}
        error err => {
            test:assertFail(msg = err.message);
        }
    }
}
