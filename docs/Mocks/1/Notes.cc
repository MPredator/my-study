// Link:
// https://www.youtube.com/watch?v=1qw5ITr3k9E


// ###########################################################################
// OOB Question 
// ###########################################################################

/* ---------------------------------------------------------------------------------------
Online Book system, something like Amazon Kindle

How do you want me to start with?

The things are jump to me.

Q1: How many books can a user set as active?
Q2: If a user mark a book as inactive, do we need to remember the page where user is on?
Q3: Do we know how many books can a user save in his library?
Q4: What if user A mark book A as active and read on page 20, then remove it from library, 
    and then add again, do we need to recall the page his was on?
----------------------------------------------------------------------------------------*/
/*

Code Structure:

// This record will serve everyone, and unchanged.
Class Book {
  Guid bookId;
  string title;
  Array<html> contents;
  // title, author, publish date
  Dictionary<string, object> metadata;

  html show(int page, int scalePercentage)
}

Class BookStore {
  Book findById(Guid Id) {
    return BookRecord from DB
  }

  Books listBooks(int pageSize, int pageIndex) {
    return Array<Book> books;
  }

  Books searchByTitle(string title) {
    return Array<Book> books;
  }
}

Class Bookmark {
  bool isActive;
  int activePage;
  Guid bookId;

  int scalePercentage; // 150, 200

  void turnPage() {
    this->activePage++;
  }
}

Class Library {
  map<Guid, Bookmark> bookmarks;

  public void add(Book bookId) {
    // check if exists in the bookmarks

    bookmarks.add(new Bookmark(false, -1, bookId))
  }

  public void remove(Book book) {
    // check if exists in the bookmarks

    bookmarks.remove(book->bookId)
  }

  public html read(Book book) {
    return book->showContent(bookmarks[book->bookId].activePage)
  }

  public void turnPage(Book book) {
    this->bookmarks[book->bookId].turnPage()
  }
}


Class User {
  Library library
  BookStore store

  Book activeBook
  Bookmark activeBookmark

  public void add(Book book) {
    this->library.add(book)
  }

  public void remove(Book book) {
    this->library.remove(book)
  }

  public html read(Book book) {
    return this->library.read(book)
  }

  public void turnPage() {
    this->activeBookmark.turnPage()
    syncToLibrary()
  }

  private syncToLibrary() {
    this->library->update(this->activeBookmark)
  }

  public search(string title)
}

*/


// ###########################################################################
// Algorithm Question 
// ###########################################################################

// detect two most likely books that might have plagiarism: longest shared
// common section of text
/*
  Book A: aaabbbccc
             ^
  Book B: ababbbacb
             ^
  Result: abbb

  map<char, vector<int>> jumps;

  int res = 0;
  for i from 0 -> end of S1
    for j from 0 -> end of S2 every step
    for x in jumps[S1[i]] few step
      if (S1[i] == S2[j])
        for k from 0 -> i + k < S1 && j + k < S2 && S1[i + k] == S2[j + k]
          k++;
        res = max(res, k)

  time complexity: O(N^3)
  space from O(1) to O(N)

  dp[i][j] mean length of common section between S1[i] and S2[j]
  dp[5][6] aaabb ababbb | bb = 2
  dp[3][2] aaa ab | "" = 0

  dp[i + 1][j] = dp[i][j - 1] + (S1[i + 1] == S2[j]) ? 1 : 0
  dp[i + 1][j + 1] = dp[i][j] + (S1[i + 1] == S2[j + 1]) ? 1 : 0
*/

#include <algorithm>
#include <bitset>
#include <climits>
#include <cmath>
#include <complex>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <functional>
#include <iomanip>
#include <iostream>
#include <limits>
#include <list>
#include <map>
#include <numeric>
#include <queue>
#include <set>
#include <sstream>
#include <stack>
#include <string>
#include <typeinfo>
#include <unordered_map>
#include <unordered_set>
#include <vector>

using namespace std;

class Solution {
 public:
  string detectPlagiarsim(string &s1, string &s2) {
    vector<vector<int>> dp(s1.length(), vector<int>(s2.length(), 0));
    dp[0][0] = s1[0] == s2[0] ? 1 : 0;

    for (int i = 1; i < s1.length(); i++) {
      dp[i][0] = s1[i] == s2[0] ? 1 : 0;
    }

    for (int j = 1; j < s2.length(); j++) {
      dp[0][j] = s1[0] == s2[j] ? 1 : 0;
    }

    for (int i = 1; i < s1.length(); i++) {
      for (int j = 1; j < s2.length(); j++) {
        if (s1[i] != s2[j]) {
          dp[i][j] = 0;
        }

        dp[i][j] = dp[i - 1][j - 1] + (s1[i] == s2[j] ? 1 : 0);
      }
    }

    int idx = 0;
    int length = 0;
    for (int i = 0; i < dp.size(); i++) {
      for (int j = 0; j < dp[i].size(); j++) {
        if (length < dp[i][j]) {
          idx = i - length;
          length = dp[i][j];
        }
      }
    }

    return s1.substr(idx, length);
  }
};

int main() {
  ios::sync_with_stdio(false);
  string a = "hello world";
  string b = "world";

  Solution solution;

  cout << solution.detectPlagiarsim(a, b);

  return 0;
}


// ###########################################################################
// Follow up 
// ###########################################################################
// How do you handle this functionality in library with lots of books

