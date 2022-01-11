Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6F448B206
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jan 2022 17:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbiAKQXv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jan 2022 11:23:51 -0500
Received: from mail-dm6nam08on2056.outbound.protection.outlook.com ([40.107.102.56]:33409
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349946AbiAKQXq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Jan 2022 11:23:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vzek/7VVjXo/P1+2bR58M+uFoTeWSWsV9JIP15EVCNYed28XKLHRjn5nhO3jFq28/FEGIvrFDg7pEWL8woeuehdw/3xMxjMBkNpaMqhTTNJ1H2V6xy7XRDDlFQppnuIXKBq3r0kCLRVJlCMVjZTew/HUNd9PsdHUz9J0e9nX6Z+kU2oNLnovnh/ZCztjfLBdzxUv+Ob9LJZRI99THmeXF4i3i3kChFQuIdmqXVtzAhYkSMcaoZFBMOqj3pxp+dKoNmr/psKvFV+Y7+kg45p67ofLOQ3HFzz+djiYKnkm2CQgGyrDEEwzuuroFGC8zKNZCIaS5r7CysFYd/oXx15xgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/08WSBLtdcUMbXttCWpUyKdnOTDntHVqdkPY24c5yeg=;
 b=Nc7jLZQyh0uJMP/WGOKP2pDh1i92Bh0MjuVd/e8UKs38rC5lqUZxFEhRjAWp0w75gawEEG8odul8xhLK5OqLzWomVhb6Rb4JFI8emHaE8bFT08BmTuTLzRuZ/MxJ2WX9AN/ja8kwQ5IvAZqK18pgbHy2Ct/6rnM2C+VKV8uwUt6Qa2DjfS9oELqN3YBzfisMFtCgrKNqMkjcZ8zkRC/U6FVohv8fVjqfF45NAFtmLzcgMuPu5EGOKKVKktdgzDTDEYz4vV55tXCyD553QP+9BI5XHgAxLkCPcIVzsAXetQmkzh7x0ntqCicotTuGu/RwPhgDQ/RwpVMcdkpbPokavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/08WSBLtdcUMbXttCWpUyKdnOTDntHVqdkPY24c5yeg=;
 b=EWTC1CdDjKFAqn+tPNVctng/wDbzkrOVtUSdgwhyRJdAogk7lpFAFkhSnycag/PDrXPbhaqx8ktssSxzBvwbxIriB6AMYcWRzEumjZ+PxLo3hPiQtqauVSrhIyw9KMdbpCUxaxCBGTTMbAXP1hCbddHAVgoIY8L9aIOqpHQMG+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 16:23:44 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 16:23:44 +0000
Message-ID: <eb3a323a-a4bb-bf8a-e642-88a2f68eeda7@amd.com>
Date:   Tue, 11 Jan 2022 10:23:42 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/3] On AMD platforms only offer s2idle w/ proper FW
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        bjoern.daase@gmail.com
References: <20220105193910.25678-1-mario.limonciello@amd.com>
 <CAJZ5v0g-q4SLfK65bvWum7+OQZgbNQs47Pu3y-BCs9Px2C3Jag@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0g-q4SLfK65bvWum7+OQZgbNQs47Pu3y-BCs9Px2C3Jag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:806:a7::23) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aadca656-9e34-47f3-258b-08d9d51ebc9a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB519113C447E88107292E746CE2519@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Esji4o4QWh+hFv0RDVnyBL1D6oQV/5WpLyZCGVzH1om3v7yTTVE2JASY79shvn9EBOKHvg38Lq4dYe7M2afEqW9O+LPLj2GljYh/W9lBa5uxvt5y6K5889O1+n6jQMsxqG95E15KKIoRoLo81ZdrJuoJo6TyrQocT75dXqmdvVRgMR+GyrS11t1m6WmissSxuYhraTysZ8L8KiMy7mvIiua69iZbQW3OrA+gd1pxLOYQXPa4acxYyA8vgEbkNiZ7Qasp4e9AsN+uJfHobmCmOwY7V+6rbC1n9E6lgHkrDMfPAI5jtYBwXcp4m+SlUPsytZPHyvn7i//iEXdEoIaZjA+HyddkUvvhPdqrLjH+etSvUITMfot7eNvCBr91Wj+7g0AkgzkDLT8jrUzZayg0atnVBWb3+KbovNr7EQzvoTsyQHcfePsijv77almfOAyiZBfue3He0le+8+gZ+iNmwlmHUCv5/D8HkDMo5xzSwu6W9YCBTasofaNJ5YU8lyl3T/ghZC5T02XfBTM9vSBB8k98wfPUpi98kqmB6AVnd4tu9F5XGaNzwUroxrjAmcoR0ciaZbivP6i52OHbxKMNRnTHUE2Z6XLWnd2kArA3H4sW8MnrQDUxFnKXvix4XGoB+2ITolE8xHpkLynmYqcBu3n4x3GTDQf+LCQc0/kMEVOtLKB7lNIr8o/9ViHVcMlqdF3VudOeutN8pN/ibX7TDsza7bRJUMH1GVu4DzAKxpeaiSFve4vgfhzDmN5BLCO1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(6512007)(6486002)(86362001)(508600001)(6506007)(31686004)(2616005)(53546011)(316002)(54906003)(186003)(36756003)(66946007)(66556008)(66476007)(5660300002)(6916009)(2906002)(4326008)(8676002)(8936002)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aENqQUttZHN5ZjdsK2doeDBtMnB3TnZLaDMzeER3OXhrOVo4NDd1RWNlN0tr?=
 =?utf-8?B?VUNSVFRtZkJacHR5dW9jd3lHZ0YrQmo3OWdmMXlIUkduc21mY25WU05sSnlK?=
 =?utf-8?B?aEJFYmJ3NTRFMk1pU0R1VnJMMGVDUVYxUUp0RFNCWWFQZ1NLbE1XeWJnNjlC?=
 =?utf-8?B?UXIrcUNMWENzc3lmZ0NHZTdLQzh0QXFGdDh0M2d0QTd1MUhWUTFMWkpJbGNG?=
 =?utf-8?B?SnJ6dFNSYklhYmlLMjl3c0xMeTMyNWk0Wi9XUWJ4NGZKMHNVd2lrekxBclA3?=
 =?utf-8?B?ZWczeTJBWTd1czdLUTdYSlpMd20xd2s1ak43NklvSGJ4MldBV0k0WFR3aG1M?=
 =?utf-8?B?OCtsL0o1UmkrSUoraVJJcmZFL2oxNXV4WkhvdkxQck1xc1FKazR1bXVmY0hN?=
 =?utf-8?B?a2RqYTdiREd0cWRqcTZuOG9OTXRZWmhOM2swcmJvZm5hTGZ0WWtrMzBxL1hw?=
 =?utf-8?B?a2xTUC9LcGYrSDVKMWdCYVVuMlBvUzQ0UllGRWRmY3ZmTEF1a1ZKUFRZTEs1?=
 =?utf-8?B?WldPRXRsbFN6L3Qzb0JWMGdsRmhTSUduWmpHbFlMRVJMWU5oUm9OTCtBbkNQ?=
 =?utf-8?B?U3g4MmhuT25YaDBsSVcvTlFCQ21TU3dRREU1WmVCQUJIcG43NHNoaUg0b3hM?=
 =?utf-8?B?VmdsOHNoM2NSRE0vN3JoNjRSOUNCaVRBN2dIM0xYSTNCODBXRlgvV1JHOXVD?=
 =?utf-8?B?NXJQdk5XTjVRVXBGeEVoVjRrbktKNUpOWUQwemRzSnlYMlFMakRGOFdyMjRk?=
 =?utf-8?B?WVFBeVFnNlpHbG9STER6MzlneGszQWpMOFpWOXZzeEduY2pnOEFoS1dCTFVR?=
 =?utf-8?B?NXVyY1p0eFJJT055dFRIbzNCcU81NUx2YitzN1JJZ0xpaTg2dW1BaGl0S0RY?=
 =?utf-8?B?T204NHdyNlJTbktMc2lVTnF3U3E4M2Fxb3lPRGh3NmRkZnRYdS9sWHZXYTNL?=
 =?utf-8?B?MWVteEIzbGtQdU1TL0ZRUlR4ZmR0S0sxNmc4UGNzUTdReHhFMTJORWJFWVpK?=
 =?utf-8?B?RDE3UmlyUzV3REh6akRwSjZsZGxLSkdXS3c4SmJLMGpOajdjRDJlZWd2UU5n?=
 =?utf-8?B?dmkxaDBjbmdjQ3lDcHJyb3JyTmFXcWJNdlRTUnNET2RRQU5WaVAyRDhiblo0?=
 =?utf-8?B?MXBSR2hlK0dSZzFYK1U0ZVNQakNOTi9aalltS1JYb2FFSnVJK0J6YVhzNEkx?=
 =?utf-8?B?bjRmQjQ0Z0Fabmp1c25NcFdJNGJGZnRscjNsNmF4SWpiT2FqN0o3WHdlM3ox?=
 =?utf-8?B?Z25rTjRFM25wQU96Y0Jic2xYR3lla0ZLdmk4VnlxWlJ0Ky9SQUxCL1ZmbUhQ?=
 =?utf-8?B?bitqSFE5QThzc0JVdXhCclY1TTd0eUNvalRuMEtUVEh0Y2ZkVm1kbWdqL0xv?=
 =?utf-8?B?RGZZK1QweTh6TjRDemM5ZlcrWTFkUE8vclhOZkF4bGVvZ1lnOForclRrMkRO?=
 =?utf-8?B?RW1rUUFrTFkxSDZBcjhzL1BXdTg5bUlnc0plNTVHNmFNYTNUeDJ2YzdDNERG?=
 =?utf-8?B?MEtWYkZsdVg0SktrM094STF4U1ZJTzR1UXlvaHI1WmFkOEFQbDFMUXowWk9t?=
 =?utf-8?B?cHphbko0YUlrSUVIYzh3RGl0NDgveU1IUWU4Tit3WTl3bXl5K0lnTm41WU5m?=
 =?utf-8?B?YWdUZHJQcmplQTZHdVVzaGxQcisxMktTaVp2bng3ZXVta1RFU3pNRGNwRTJU?=
 =?utf-8?B?V1Y2U1pCMUNtRmZpTTZSVy9nVk0ybjB1STZ1T1BJRDdsSERVSWltNTNFUC9M?=
 =?utf-8?B?M3BTYWpYYVZWeWN4cEg0YWJnMVVhQndXeE15OVdHYUpDOU1yV2poUjBMajdG?=
 =?utf-8?B?clRzbzdKRk9lSzlDbUcvaER0ZENmYlV2RHQ2WHBpMVM0TlZ4U0hFLzN6N1FR?=
 =?utf-8?B?b1k3NTBkQjgzdi9lUVU0aEZMVEVRQ2pxeVRWYzVGVkZwakZYcEpQczZkUmxK?=
 =?utf-8?B?bUh3MmcrM3d0a3RpbTlCWnNFT05BM3JBMWxqU1lsSTgyTDhuNlY5VUpETVAz?=
 =?utf-8?B?SXdQdmZJRW0xMzNISHdnckFxUkhMcUgvWHgvU2U2YWF0UVlYR0NaWUxpcW00?=
 =?utf-8?B?eGtId2pHa0Rsbzd2aWNteU5iUnljZ01wSnhzcnkwSXRMaWd3U1pWN002TkFo?=
 =?utf-8?B?Y0V4U1poS3RNNlBxQmNxamQwU0dwSzgwVkFzdUxjNWs1RWZFZm1uV0cybE9v?=
 =?utf-8?B?Tm5VYkIrd1B5b251ZlRvdGkwSTV4TXhTU2Zac2l2cWVaTm14cEtsTDVIdWgr?=
 =?utf-8?Q?OWzKCUiHThTL6VALf09oTu8N0Evp2ocB555Tk/yN7M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadca656-9e34-47f3-258b-08d9d51ebc9a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 16:23:44.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUX2rTGNbMODF38Z47X0dtjNufrgzEUYjdMjH6iZa1thbDcoAnVZlcySIsyd9QvpytBk480371ClNwCGd4PUWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Alex

On 1/11/2022 09:52, Rafael J. Wysocki wrote:
> On Wed, Jan 5, 2022 at 8:39 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Currently the Linux kernel will offer s2idle regardless of whether the FADT
>> indicates the system should use or on X86 if the LPS0 ACPI device has been
>> activated.
>>
>> On some non-AMD platforms s2idle can be offered even without proper
>> firmware support.  The power consumption may be higher in these instances
>> but the system otherwise properly suspends and resumes.
> 
> Well, the idea is that s2idle should not require FW support at all. >

May I ask - why?  It's an intentional design decision?

> It may not be possible to reach the minimum power level of the
> platform without FW support, but that should not prevent s2idle from
> being used.
> 
>> On AMD platforms however when the FW has been configured not to offer
>> s2idle some different hardware initialization has occurred such that the
>> system won't properly resume.
> 
> That's rather unfortunate.
> 
> Can you please share some details on what's going on in those cases?
> 
> Technically, without FW support there should be no difference between
> the platform state reachable via s2idle and the platform state
> reachable via runtime idle.

During resume there is a number of page faults that occur and during 
initialization the ring tests fail.  The graphics is unusable at this 
time as a result.

The amdgpu code actually *does* distinguish between the 3 different 
cases of S3, S0ix, and runtime suspend.

The function "amdgpu_acpi_is_s0ix_active" causes different codepaths to 
be used during the suspend routine.

In this particular case that FADT doesn't set the low power idle bit
and that function returns false meaning the s3 codepath is taken but
the hardware didn't go through a reset.

It *might* also be possible to solve this by mandating an ASIC reset in 
such a case (we didn't try).

However it comes back to my first upleveveled question - is this a case 
we really want to support and encourage?  This type of bug and 
combination of codepaths is not a case that is going to be well tested. 
This patch series will align the kernel behavior to only what AMD validates.
