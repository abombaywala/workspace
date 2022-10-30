"""
252. Meeting Rooms
Given an array of meeting time intervals where intervals[i] = [starti, endi], 
determine if a person could attend all meetings.
"""
class Solution:
    def canAttendMeetings(self, intervals: List[List[int]]) -> bool:
        intervals_sorted = sorted(intervals)
        for i in range(len(intervals_sorted)-1):
            if(intervals_sorted[i][1] > intervals_sorted[i+1][0]):
                return False
        return True