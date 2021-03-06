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

import ballerina/io;

documentation{
    Return the untainted next URL after clearing the given link header with other symbols. If next URL is not given,
    returns an empty string, which represents the last page
    `Link: <https://api.github.com/resource?page=2>; rel="next",
      <https://api.github.com/resource?page=5>; rel="last"`

    P{{linkHeader}} Link header of the request
    R{{}} Next URL and Last URL
}
function getNextResourcePath(string linkHeader) returns @untainted string {
    string[] urlWithRelationArray = linkHeader.split(COMMA);
    string nextUrl;
    foreach urlWithRealtion in urlWithRelationArray {
        string urlWithBrackets = urlWithRealtion.split(SEMICOLON)[0].trim();
        if (urlWithRealtion.contains(NEXT_REALTION)) {
            nextUrl = getResourcePath(urlWithRealtion);
        }
    }
    return nextUrl;
}

documentation{
    Return the resource path after clearing the given URL with other symbols

    P{{link}} Link URL with other parameters
    R{{}} Cleaned resource path
}
function getResourcePath(string link) returns string {
    string urlWithBrackets = link.split(SEMICOLON)[0].trim();
    return urlWithBrackets.substring(1, urlWithBrackets.length() - 1).replace(API_BASE_URL, EMPTY_STRING);
}

documentation{
    Return the build query parametrs for GMail API

    P{{userEmail}} User email for 'from' parameter
    P{{excludeEmails}} List of emails to be excluded from 'to' parameter
    R{{}} Built string with query parameters
}
function buildQueryParams(string userEmail, string[]? excludeEmails) returns string {
    string queryParams = "from:" + userEmail;
    match excludeEmails {
        string[] list => {
            queryParams += " to:(";
            foreach email in list {
                queryParams += " -" + email;
            }
            queryParams += ")";
        }
        () => {}
    }
    queryParams += " -in:chats";
    return queryParams;
}

documentation{
    Add the given key and value to the given map

    P{{m}} Map, the value to be added
    P{{key}} Key of the value
    P{{value}} Actual value to be added
}
function addToMap(map<string[]> m, string key, string value) {
    if (m.hasKey(key)) {
        string[] valueArray = m[key] but { () => []};
        valueArray[lengthof valueArray] = value;
    } else {
        string[] valueArray = [value];
        m[key] = valueArray;
    }
}

documentation{
    Print the given GitHub data map

    P{{m}} The data as a map
}
function printGitHubDataMap(map m) {
    foreach key in m.keys() {
        string githubOrgWithRepo = key.replace(API_BASE_URL + REPOS, EMPTY_STRING);
        string githubOrg = githubOrgWithRepo.split(FORWARD_SLASH)[0];
        string githubRepo = githubOrgWithRepo.split(FORWARD_SLASH)[1];
        io:println("GitHub Org  : " + githubOrg);
        io:println("GitHub Repo : " + githubRepo);
        string[] list = check <string[]>m[key];
        foreach item in list  {
            io:println(item);
        }
        io:println("---");
    }
}

documentation{
    Print the given GMail data list

    P{{list}} The data as a list
}
function printGmailDataList(string[] list, string category) {
    io:println("Category: " + category);
    io:println("*****************************");
    foreach item in list  {
        io:println(item);
    }
    io:println("---");
}
