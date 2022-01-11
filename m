Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA948B5C3
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jan 2022 19:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345431AbiAKSg0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jan 2022 13:36:26 -0500
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:12529
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242948AbiAKSg0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Jan 2022 13:36:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8hTJCPwwX0RVWmOCK8LcIeq0IKzNIg6hey+DLvYm3FljHmXgPwRb/ZawIqk4HZ6/6PUkCMW/dc5lM5zrhmRSj0oqyf5Ak0z6u2YkeUN0mSsHrjEaGmX7HkbYuUyUsigj0os4mJv0FFGxwfp7x2ZramyskvTEZt9UoyBANdR9CQvHfs+pPJFGhFzuxCbi3n5UZrfzKREADcqp9ecesdPUod4huO00ZyZbXlERvGYp8e894MOqRmc72xsF76U4b6xjNso2Vliwm4m0m9L0KXNVlAR9xphQShxGzwHvIjkB0sYIq5Arzeiw/LBVwD+QDdWtutkWJldA84wPvfpYU408w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qv50ZMLs3CqRXYZ6PWARBiexxl1SxWNSW8LvgEOs1KA=;
 b=amXEx8HcKbmi8xPlLrLQdT3LBwDySP7ZaAEUtghgrsllXwlSLBVOgoEZ/0wvnJeuRQH29Hnzk/rptnwO0Wd1iagJ1ytpyCfBcD7jiFt7AM79XGZIfVFZImmNOdbMtcgl0VLJ7Ue3cZsrCUP79LOHfJ8kieN9PUTTBQJumF/qBqRL8bJuvT4u53qwxjs1negEoT7b89rS4b7p6/a87RMaPeMEWjNNQGO4dfNJvTH/g87MSzhEdKsVst42zS0mrEE56foB8QGddfYtlcDz0TJH79lAbk0hYalco9UagrWZ7Itz/PI1ywpPRZ2VR2+3iff3JVKHziRFJ3C1IqZlsxvexQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qv50ZMLs3CqRXYZ6PWARBiexxl1SxWNSW8LvgEOs1KA=;
 b=06BZ+erlsRbG5nfg5BoZOVqh9yFFt4WEeTyEIkxIyR8NewX9uFBt8GUYqbz4OAmH0C4paq4cJwHYktQKRHzG5F3vdAbvSaia81QbEfa4zqElktWCkPqqFOVGpK8R7TScTLuCRpxOG7CWMc9D+vqu94vHBDXrP0aH9qditZnIBVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 18:36:24 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 18:36:24 +0000
Message-ID: <e1a43f9b-e4d0-5df6-cd32-1843a1bd1b29@amd.com>
Date:   Tue, 11 Jan 2022 12:36:19 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 0/3] On AMD platforms only offer s2idle w/ proper FW
Content-Language: en-US
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bjoern.daase@gmail.com" <bjoern.daase@gmail.com>
References: <20220105193910.25678-1-mario.limonciello@amd.com>
 <CAJZ5v0g-q4SLfK65bvWum7+OQZgbNQs47Pu3y-BCs9Px2C3Jag@mail.gmail.com>
 <eb3a323a-a4bb-bf8a-e642-88a2f68eeda7@amd.com>
 <CAJZ5v0hCVUNNgxn3bnn-mDKuYwnHSnOjwwXWiMJrv41dWuqCJQ@mail.gmail.com>
 <BL1PR12MB51443949D250B3963AEC1224F7519@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CAJZ5v0iSR7rCpF3HKR_O0EUg7n80RM=oXm5MFh6f=DJZF+hWQg@mail.gmail.com>
 <BL1PR12MB5144434DE31017304CAA43FBF7519@BL1PR12MB5144.namprd12.prod.outlook.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <BL1PR12MB5144434DE31017304CAA43FBF7519@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0024.namprd19.prod.outlook.com
 (2603:10b6:610:4d::34) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 148bbc0c-4974-4038-209a-08d9d53144e2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5240:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5240B456FE59CBCCB19595F7E2519@BL1PR12MB5240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zzt0tJ/wFx+MjRFRO6GSBL247SzXKE9b4HJrbjaUpPQZoHyBb1Jy8M9+nQzhHnoYN02TZ4M6lLyd+d9tRVFH4VKLcL2uQH7fc+4jaQfwn0kwbplsWHk0o57vEcYUvyEdjAWUgEZ2J+xbNRlhu/Xq5ePlT6aqZl4TKFegsZDYgJPUYvdEEjxLvGz8BUdO2CgJ7ZVJpwVTZB4S2WUaaUb40SMeCOVFHChmH2VDaxJsO7ojkXjNPiMsHWMeSjCT+zzZFL74AkknjzXKjEW8w3smkWZDN3b5tLgBIEHCWuoCpKQP+zE7G9pQO9ZyllWz90xweax4Zt/+m20kO6xhBm0xHPeFSfXw7g4QaHul9l2el4/iPYMtDT+w1RQq5Te/Y3ppVByr8jDgMW14UEKE3he5N8K3JOppo0nVsIOofEJZf6AxO0TQEtCkzEQeJJXjeOPDXPKtGnUzAOWIbgpeb3JvCsCxn7sxIXUgYllF0qyfYA0/6HLlY/ApG+qhj0D1dxHb3bkLNsr+AmRJ5H2rK8qqNhUr3nHX3d/Wz26yU5q+a0UO2KpYTWAHxfQ+0dT0gk+/iEZK3pWRvAWO7pX1kp7rODck9Tje78DtLp2/nEgzNnJmU9eilHGHmu/lI1alnA7U8gjFu4TqcjOV21g1Vu6SiOj9WlZgijADBwN3208ycSDUDfz1+IeoOiTYjVCT8sQBZuFP341nd4v/Hc9K8t4g20w7l837VEbBtsS0jGRt2Huqbs03uJc1kEkvGlsexxIq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(186003)(54906003)(2906002)(508600001)(6512007)(2616005)(38100700002)(86362001)(31686004)(31696002)(4326008)(26005)(316002)(6506007)(5660300002)(8676002)(8936002)(83380400001)(53546011)(6486002)(66556008)(66476007)(66946007)(110136005)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlNWckN2dUw0b2VtNHFja1Fsdm9tY21GbDRIZFo2bXZxNmlqS0UxdUVsZXF0?=
 =?utf-8?B?bHpzMmRwc2VIQTJVbUQvaHRhQ3ducjhyUmpxRzVSV1pwS2tHZENlOGdTMzZK?=
 =?utf-8?B?N1B2S1BxaGJpc0tXY0pjWlp2OUlld2kwbDJTNmU2Qkc0NHdCM3FJNC9zQ1Y5?=
 =?utf-8?B?QUNreXc2bEdLQmNhMk9Dc3k5ejYvWnhrRkgyVXplU2xBeVBlV1JweGh6MU1C?=
 =?utf-8?B?dTg1eXV2WGhSaDhQM0tzckhzblUwYVNWZDVCdVYyYTZZQXBTN0R5QUxWS1FB?=
 =?utf-8?B?MG5Pa3ZKcHFXek1nV285MUFrZ29CZHNmZHFSMldjRHFiL3JQcS9sWCtpU21M?=
 =?utf-8?B?VytyMHp4MnhBOFluZVlwdlh5UjhQTnlNT213RVNiVFIzUkc2V3FtS2NZRkJN?=
 =?utf-8?B?ZW5lOFBnRVhTY3Z3aXRJWVJIYTJ6djNIK3haVU1uQ1k4RE1rWDJlZWpLYkFR?=
 =?utf-8?B?ekVGVXQ1RERsRy9GcUdlMnd4NmFnR2p3YmpQVEtQYmlXOExUenM4cTdHTnFU?=
 =?utf-8?B?blI0MVpXenRuN1ZWTUQ0VUoxRE1RenZPUWppKzRla1ZpWmcwY2xNMWZNbW9D?=
 =?utf-8?B?SERVWm1HOVB1MVNSZURkS1pWK0dNTDE2cG9qeTUyZXVLWmM2cHJNcW8zUnBm?=
 =?utf-8?B?cnEycEloQVAwZVNGb1FKbjdRTkRTdytYMkF6dlFqWkphRHdnRkNnUDZ1WUkx?=
 =?utf-8?B?bktTaTlxeTFBNnUxK2p2LzNyZVVpVmtyeE16M1pUc0VxSFpUenVJTnNLZ3Nm?=
 =?utf-8?B?RTVESGQ1aURCZHcvVERIQUg4MVZIWERBYlkyK05uNldUb1NvYzhvbnpYRGU3?=
 =?utf-8?B?R3l2b0tkblZNRHNnNVM2ZTM4ZHIzY3NIY1ExbFBrTzN2b2Z1c1czK2F2elpI?=
 =?utf-8?B?VkdtdFZTa1B6UTFlUHVpcjRtNW9pQTBJWTFEbnlmRVBjemg1S2lqVnQ0NzZR?=
 =?utf-8?B?b2p1T2lqME1hWmt3ZlZmc2xtalIyL215OXZlZUNGMk9JbjRTY1lwRzRvemhK?=
 =?utf-8?B?WkxTU09TOEVSQUNLRmVTVGorS1hHQldWZHlDNVI0cWxCL25rdzZ6endtSmVo?=
 =?utf-8?B?djQvODBqcTg5YllNOW13blZuZXNwY0NDQXdWQmkzUzBZTmg3dWlHd1Z1amM3?=
 =?utf-8?B?VFdUTFhxL1lqdU9hQis1aGxDTmNXQkFGY2daaENtb29tdjBCMHRxc2ZDQ3Fr?=
 =?utf-8?B?ZlBpcWhwOU8zaXo0SWduREdmOWdMTi9OMDVwR3djdVhMT1laK1kwMlhRb3FT?=
 =?utf-8?B?M2J6K2FBMTVITUZFY0VYdjVtY1VicFNlNFBQWnRIMllhaDhSdUxjZi9KN0VX?=
 =?utf-8?B?blpZTmJLNDErZG1EbTNQOFk4UHJEWDU5OW0vSEJBYzg3UG14T2kzY3NGQkpE?=
 =?utf-8?B?OStua0dtWkF4WVNHNmYweE5DOUhFSHBUTDBBaTV6SlBScnN4K2ovWXJsL3A4?=
 =?utf-8?B?RE5WNlBmN2ZDdEJDbHRLckFwTjhKb1IrOUN6TGRIdE5tZUJmU0Z0YVo0V3Fh?=
 =?utf-8?B?SzJJcjJGNmZMR2hjcEUzTFNhN3Q5Z01pUWFrUHl6K3p2dXphdnlMU05sS1R3?=
 =?utf-8?B?ZmFERDRJWHFOQVh0QXY2N211Vzljclcrbkt1ME40WHBPSEZsbGNQWk8vTHph?=
 =?utf-8?B?Y21jdFR5VXAwaXlScmY4N1hETTBHT0hQeTQ4N1JZTzlpN2xoc1lpd29selJC?=
 =?utf-8?B?YlhuekUweEVoZDFQakVjbXd6NFQwcjRyODhTQWpqQmRDOTA5UFo0bkNINThT?=
 =?utf-8?B?bk9YcmtDdnRTMmJIelNYb0RNeUdZN1NwU01nVWFzUHJyNDRoUFRkbmVBdUlj?=
 =?utf-8?B?ZjFSRkpHQjE4a2phK21zQnBMdUd4YTdLNjNOWlptRXlZZzhQOW1ZR0J0d2NB?=
 =?utf-8?B?R0xPcHZtYUM2Zm5OeXh1bER5elBGYjNUWFQzR05GdUh5eTMvL1hUZ0VVVitn?=
 =?utf-8?B?eGdySEJLaXlBdFFSS015ZXJseWpwN1FpWGN6MS81Z3RSS1FFVkdCMDF3OUlC?=
 =?utf-8?B?QlNEeXF6c2NtWEo2K3dzS2JkU2ZaSENjL05YMFR4WCtnYkNtR3RRVE5rK1JO?=
 =?utf-8?B?NEplWG9adml6RjIrNnJ5Mm1nWDFCM2k1WDJTRHA4R0d6ZU9jVXAwN2REcUtq?=
 =?utf-8?B?bGFkbG82THZ1WmxCNUJ0WEhZdXZ3Y01GMk9USnkwTkdqcEhvWVNPR2tVN0FU?=
 =?utf-8?Q?wvNMcHZE2d63fS7wGF74pFo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148bbc0c-4974-4038-209a-08d9d53144e2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:36:23.9950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weKJaPtR+yybop6TFJ2/QllVG7P3NzpBqxCeEDm8Hr8UHGteKMWKyQnBY1uJjIGbFZby45Gwx2mSR7CzLmqfXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 1/11/2022 12:30, Deucher, Alexander wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Rafael J. Wysocki <rafael@kernel.org>
>> Sent: Tuesday, January 11, 2022 12:45 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: Rafael J. Wysocki <rafael@kernel.org>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>; Rafael J . Wysocki <rjw@rjwysocki.net>;
>> ACPI Devel Maling List <linux-acpi@vger.kernel.org>; S-k, Shyam-sundar
>> <Shyam-sundar.S-k@amd.com>; Natikar, Basavaraj
>> <Basavaraj.Natikar@amd.com>; bjoern.daase@gmail.com
>> Subject: Re: [PATCH 0/3] On AMD platforms only offer s2idle w/ proper FW
>>
>> On Tue, Jan 11, 2022 at 6:32 PM Deucher, Alexander
>> <Alexander.Deucher@amd.com> wrote:
>>>
>>> [AMD Official Use Only]
>>>
>>>> -----Original Message-----
>>>> From: Rafael J. Wysocki <rafael@kernel.org>
>>>> Sent: Tuesday, January 11, 2022 12:06 PM
>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>>>> Cc: Rafael J. Wysocki <rafael@kernel.org>; Rafael J . Wysocki
>>>> <rjw@rjwysocki.net>; ACPI Devel Maling List
>>>> <linux-acpi@vger.kernel.org>; S-k, Shyam-sundar
>>>> <Shyam-sundar.S-k@amd.com>; Natikar, Basavaraj
>>>> <Basavaraj.Natikar@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; bjoern.daase@gmail.com
>>>> Subject: Re: [PATCH 0/3] On AMD platforms only offer s2idle w/
>>>> proper FW
>>>>
>>>> On Tue, Jan 11, 2022 at 5:23 PM Limonciello, Mario
>>>> <mario.limonciello@amd.com> wrote:
>>>>>
>>>>> +Alex
>>>>>
>>>>> On 1/11/2022 09:52, Rafael J. Wysocki wrote:
>>>>>> On Wed, Jan 5, 2022 at 8:39 PM Mario Limonciello
>>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>>
>>>>>>> Currently the Linux kernel will offer s2idle regardless of
>>>>>>> whether the FADT indicates the system should use or on X86 if
>>>>>>> the LPS0 ACPI device has been activated.
>>>>>>>
>>>>>>> On some non-AMD platforms s2idle can be offered even without
>>>> proper
>>>>>>> firmware support.  The power consumption may be higher in these
>>>>>>> instances but the system otherwise properly suspends and
>> resumes.
>>>>>>
>>>>>> Well, the idea is that s2idle should not require FW support at all.
>>>>>>>
>>>>>
>>>>> May I ask - why?  It's an intentional design decision?
>>>>
>>>> Yes, it is.
>>>>
>>>>>> It may not be possible to reach the minimum power level of the
>>>>>> platform without FW support, but that should not prevent s2idle
>>>>>> from being used.
>>>>>>
>>>>>>> On AMD platforms however when the FW has been configured not
>> to
>>>>>>> offer s2idle some different hardware initialization has
>>>>>>> occurred such that the system won't properly resume.
>>>>>>
>>>>>> That's rather unfortunate.
>>>>>>
>>>>>> Can you please share some details on what's going on in those cases?
>>>>>>
>>>>>> Technically, without FW support there should be no difference
>>>>>> between the platform state reachable via s2idle and the platform
>>>>>> state reachable via runtime idle.
>>>>>
>>>>> During resume there is a number of page faults that occur and
>>>>> during initialization the ring tests fail.  The graphics is
>>>>> unusable at this time as a result.
>>>>>
>>>>> The amdgpu code actually *does* distinguish between the 3
>>>>> different cases of S3, S0ix, and runtime suspend.
>>>>
>>>> But s2idle doesn't guarantee S0ix in any case.
>>>>
>>>>> The function "amdgpu_acpi_is_s0ix_active" causes different
>>>>> codepaths to be used during the suspend routine.
>>>>
>>>> Well, as I said, s2idle need not mean S0ix.
>>>>
>>>>> In this particular case that FADT doesn't set the low power idle
>>>>> bit and that function returns false meaning the s3 codepath is
>>>>> taken but the hardware didn't go through a reset.
>>>>
>>>> If there is a separate S3 code path, taking it when
>>>> pm_suspend_target_state == PM_SUSPEND_TO_IDLE is incorrect.
>>>>
>>>>> It *might* also be possible to solve this by mandating an ASIC
>>>>> reset in such a case (we didn't try).
>>>>
>>>> I'd rather do a PM-runtime path equivalent if the target sleep state
>>>> is PM_SUSPEND_TO_IDLE and there is no FW support for S0ix.
>>>>
>>>>> However it comes back to my first upleveveled question - is this a
>>>>> case we really want to support and encourage?  This type of bug
>>>>> and combination of codepaths is not a case that is going to be well
>> tested.
>>>>> This patch series will align the kernel behavior to only what AMD
>> validates.
>>>>
>>>> But this does not follow the definition of s2idle and its documentation.
>>>
>>> At least for devices integrated into the SoC, the power rails are controlled
>> by the firmware in the SoC.  For S3, the power rails are cut by the FW when
>> the platform enters S3.  For S0ix, the power rails are cut when all of the
>> devices on the rail suspended and various conditions are met.  Also, in the
>> case of some devices, the device has to be in a very specific state for s0ix to
>> work properly.  The GPU is the big one here.  For S3, the entire GPU has to
>> be re-initialized at resume.  For S0ix, the GPU's state is largely handled by the
>> firmware and attempting to re-initialize it won't work unless you reset it.
>> Integrated AMD graphics don't support runtime power management, only
>> dGPUs do.  For integrated graphics the firmware dynamically controls the
>> power at runtime so there is no need to do anything special for runtime pm.
>> For dGPUs we support d3cold either via ACPI on platforms like all-in-ones
>> and laptops or via a driver initiated sequence for add-in-cards.
>>>
>>> What does S2idle ultimately do when all devices have suspended?  Does it
>> enter S0ix or S3 at the end when it want to ultimately suspend the platform,
>> or is the assumption that if all devices have suspended, the that is equivalent
>> to S0ix or S3?  For AMD platforms, either S3 or S0ix needs to be entered for
>> the platform to actually power down most of the power rails.  It's not clear to
>> me what we should do for s2idle.
>>
>> s2idle will never enter S3, because that requires platform support and
>> generally is a different thing (eg. some devices need special upfront
>> preparation for S3, wakeup may need to be configured in a special way etc.).
>>
>> It will attempt to enter S0ix if possible, but otherwise it will just put CPUs into
>> the deepest available idle state and stay there until an interrupt (or
>> equivalent) triggers.
>>
>> Physically, at a device level, s2idle is more similar to runtime suspend than to
>> S3, but it uses system-wide suspend callbacks and it requires wakeup to be
>> disabled for the devices that are not allowed to wake up the system by user
>> space, that is device_may_wakeup(0 returns false (PM-runtime assumes
>> wakeup to always be enabled for the suspended devices that can signal
>> wakeup).
>>
>> In any case, the ACPI system state for s2idle is always S0.
> 
> Thanks.  In that case, it's kind of pointless on AMD platforms then since the power rails will never be turned off for most devices on the system.  Does it even make sense to expose it?  It just gives users a false sense of suspend and then they will probably complain that it uses too much power when in s2idle.
> 
> Alex

That's why I thought my patch series made sense.

I guess another (antisocial) response would be to to return false when 
the suspend callback for amdgpu happens and dev_err mentioning that 
firmware support is needed for suspend.
