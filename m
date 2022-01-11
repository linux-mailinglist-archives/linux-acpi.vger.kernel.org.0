Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E0348B40E
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jan 2022 18:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344662AbiAKRdJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jan 2022 12:33:09 -0500
Received: from mail-bn1nam07on2076.outbound.protection.outlook.com ([40.107.212.76]:41622
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344827AbiAKRcQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Jan 2022 12:32:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=my2dczYXXoLC0vOGUhbr0L/yaZfuQn/JXNx6x0XLQlLrm5dZmhLIiupo2oSQmBHy7yeQko4tPROCnHan83k1zZ2+YYmV6wVyNmwRq/v2SFHXzozlowcSyHNlCQKa7oc92YB38qL0qzUcXEvSS1D0ShBxylv90TIKv5ubI8VqbmJJjlBOx2yey+1Pwgu82d3ePyx+AqCleh8fKEPP64yq4a1pIs5N6JYQiS/P/iji8fUMbKXqsfO2lveyTycplshmY9MaHTqqJ4UAAjgWhxzN6YRMwj4FQMXqFsCM3Uj0Q+w0JqoF7iiw7Vafb81CH/3PjVH1H91OvhxrHa6hSw09oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QD0XyyvLJG+DnZqdaORgJrLW+eX7i7ppd2jnWdXhEPY=;
 b=FzSfbtiRNIgo0rXeeHE4iN26r5dizjPnZfhNCZGkAn9XvpOkA+mDuAv35cVrTxScdjv9Y5z2HbDhoyESOS7cwztcegPSj9WvBkZSUJc2TNDEgUpZqR+tgRXk7d9G9TXKd+jt3F/pSqngAHiiWTv6/BdZueu1KD9oIO9Qy7DOC3f+NZXUgXB2NoW0OC1UW0e1rDhZNv2mWsSTpSXPYQhK1Nfc2UpbqB2L0zEuVk+0eyBs+v7RT4Nt/eRvL0zHi/e2I50PlJYVk5iXo3dE7hhWAl1WDeiPY21W4n1eAZPwYrkwxkXTQbg6pm2XEk+0QTNtfLibrrKVhGI1AOqOTO+SAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD0XyyvLJG+DnZqdaORgJrLW+eX7i7ppd2jnWdXhEPY=;
 b=4DE7jngQhQwUf+LSTK0jVELEVOjQgEVzmm/2EHDQHS1wx1sPm7hpAvTDudci17oSGfasKQNbDN8vIkH2uHnsdna8HwwyUY0Lln3lJpHj8vByXZjLbjn1TKJ8rXrhyHO/qaUAxyCIAzFo7Dm8EADR5iTVBOK8tpnqU1mm5hnjgSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 17:32:14 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 17:32:14 +0000
Message-ID: <e3caf2a1-d9a8-e405-6a20-dc5626c4989d@amd.com>
Date:   Tue, 11 Jan 2022 11:32:11 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
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
 <eb3a323a-a4bb-bf8a-e642-88a2f68eeda7@amd.com>
 <CAJZ5v0hCVUNNgxn3bnn-mDKuYwnHSnOjwwXWiMJrv41dWuqCJQ@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hCVUNNgxn3bnn-mDKuYwnHSnOjwwXWiMJrv41dWuqCJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:610:38::17) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57b66cb1-52b5-4fd4-abfb-08d9d5284e76
X-MS-TrafficTypeDiagnostic: BL1PR12MB5190:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB519032932FE5302C1F8328EFE2519@BL1PR12MB5190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S42F4u12YyDd3tIIF/IfhWFUwV/LzzUjSEbb40xr/I3Q9JBu5zczKhCmgCNngGoyWDX5YgNo3ZnQPVSuHyB3u/w6F3UH7a5j++KQniqvvXYe4+lxWKvCo+rtf7y44tm52++89xcVcRp1971MN+90NvQt20AylUECAD46LKAOlTB2wBQR3xYpSE2YOOD49mQve8ruvfc7SuQVzAtK9Kms7bZlwxbketoUIA+nD/hj6KehaswkYVGHqFhixDoJC9hpzo4nKtG3naLAOuaYDIp4foXI/g9kVf8xSFDQlFWN3E2ptRhyB27Nc4KgiSKeYAL/wp6crMKMic/Rsq4jN/tSIIIUdreZWtVohoCWTvJazXPhWc4aWYd2FUi1g1uALGh0GBuWgTeMQWqHWLspKtTVZbf2o8urMeoIvn9Ym/UFtZlyPrcgg1kihzCq3DsBHL4RYEiY+ENKBPmB9xpk8AV/QIIX8oOP8wmOEE7SU4NuxPEZGZDWXNfSMj+VDGx7/2SwQGeViLV+c/U0rhbDIEP9mztpdum5hh67iTOUdBan5aBI2Z+aoO94FauaNOI0OWDuv/d9oLFY727qPTSGSRvbKTSqESswzpgT95rn1QQo/pFWk+9UmCEGpdM/OLwJaUIrTRzdswZ9gR7Eni7hW52mWrkgxfwuFAZeTOpd9xow5EvHkU/HkYra53cISdNWcrQij1qQtgpi/za8nnhlwx9HluuYtVUPNSdOgx4tYVogp1+8T+d/Tc4/47NYuhuF0KfQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(508600001)(4326008)(31686004)(2616005)(86362001)(2906002)(66476007)(26005)(186003)(6512007)(54906003)(6506007)(53546011)(8676002)(66946007)(66556008)(6486002)(6666004)(316002)(31696002)(38100700002)(5660300002)(6916009)(83380400001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXBUUzgxSDVWRVJvTUNLQUEyRHdKdFRhTkZYTzdjSXFaRTBJYTgyZjBxU0xt?=
 =?utf-8?B?WUlwcUhEVWtzelpqN2phSDdWZjJLYzZja0JBeDRrSjBWOHJrRGEyUHdWbENZ?=
 =?utf-8?B?S0laWC81WFpoNVJVVGlRc0pxV09hbmRKM05keUs3dE5qWnBCdVRURkZFNzhx?=
 =?utf-8?B?RXNWVGJleGV2dXMyenNrOGxqbG9EdWwxZml5d1g5anZ1SXZOVjdqcTZDNGF3?=
 =?utf-8?B?YWphQUNuVkI1RXE1UVVtQnFwcXZNZjRHMGh6SklwSzhvRXIrSTFZYzB5S3pP?=
 =?utf-8?B?WlROZ1JHd3RlL1p0djJXMzRTVlJzaldKRkJoRzh5K3B6OWppaTNxL00wS25X?=
 =?utf-8?B?K052M2tNQlBmRzJ6YUpxMGFqUlpXbmFxYmQwenF4VmZaYmkxVmlhMmtqc3NU?=
 =?utf-8?B?bzk1bWdiUEdsN0hSNnRzTU1xcVgvN3NTMFpQZkhuQmhYTm1PN3pSVWhwcjJD?=
 =?utf-8?B?SnpJbnFaU2lvRXMyWE83K2gyZENMVWNReFRzMVZtbUlBVGJHMzFqR1JqY1V5?=
 =?utf-8?B?Q2ZvWW8xOEg3Y3lLcmcyeFI0VHBVLzZzb29ZdE9sS01kUFFwTERFdHVNSCtW?=
 =?utf-8?B?NjRrdzF2ZDJWWEMyZk9vbXM5aUhkYTFyTElWRzRVUXdLN0hIa2d3K3FYVGxy?=
 =?utf-8?B?YXR2eWxzdkdINXVwMDl3bUFBSWpWZHdiTUhOdXJ3ZktEYThyaGVsb0JjVnVR?=
 =?utf-8?B?SzlmU29LdmtWZUZtc1FMb1FhTWNmekMrTzVHTGVVOVdkTWpvcEp5MFBFaDJr?=
 =?utf-8?B?Y2lDckMyWldVeVJ2dFlTbDJwMDFQZFl6RWc5SFl3TkZTOVQyekcrRFVkRmNH?=
 =?utf-8?B?TXZseCtjckk5OTEzZitCR3ZiZGovMXlKbmFCSjZjMEF0L0xRTWwvODNkdlJn?=
 =?utf-8?B?NnRNQlZaeGpxbEdJTURidEQ5VGJDSkJLcFBuK1htNmI5WTZSVTY4STZXcXZX?=
 =?utf-8?B?bUNvekd4YlJiY1J6QXE4UXhZY0tta0NsaVp2cUJnbDdHTDQ4YmlKYU0xKzN2?=
 =?utf-8?B?TFhWaWFZRFdLa3hQcEtFVTRKaS85aUswN3R4d1F5aGZWZU4rMWF4eFdNOW1E?=
 =?utf-8?B?OHZtYlR4NjRDWklqS3BENFFBK3grR2JJM0pOTk9ydDRjUEp6cE52L0tFdk54?=
 =?utf-8?B?YnhoNkZiOWFuVktocmtYcVpacTI1ZVhDZjI4K05EalNmMjhIYW9VN0VvaEtI?=
 =?utf-8?B?VkpvK05YL1pDUm9hbEt4R3g3cDVSdW5LQUVlKzlrQTQxQkFMdHl3VzZrM0pk?=
 =?utf-8?B?Yi9EQWxtQStlVWhHZVltV3RPWEZPUEQ0Nk1yWWFEbVFZUjYyZVN0ZXQ4Ym40?=
 =?utf-8?B?VlZWTTJMcVpYeXNDRkRHVURYYmFWc2Z1NTd4UHNZd3I3WEdoeUVyd0ZSWk51?=
 =?utf-8?B?enhsUTdvcVMxbitiSkJadEF2V1lXeWl4c2ladncrZzErM2RRY0hvbjJhZVpv?=
 =?utf-8?B?c2o0UUQ2aGdoamtMdkIxQlRZcTdzZVB4MHlzZEZGdkk5cnpYSmQ1K1c4Tk04?=
 =?utf-8?B?WjkwVUFqZTR3ck0rdGxYV25pSDhvL1dWWHNZY3lyY2hQZXBWdGxRN0toa2Ix?=
 =?utf-8?B?NzlTVGtPTFFLRHB0cVVubHAzdXRHRklmRE1XQWFzWVhxS1NsdzRVN1BsTVpM?=
 =?utf-8?B?SDh6VVJXS0x0MGZ2SjA5WXZLWnc2THNhT2t2NTZXbUxna1JnZkhVS1dFSk0w?=
 =?utf-8?B?L1NRM0JaMFF0ZnRTekFiTzMyVkczT0VXMjAwRUlTYk93Vmk5VFVrWjJZV0oz?=
 =?utf-8?B?bkRvR1ZrWjdLNDJaSWVWSy95RHZjZllwb2k1TnRZRTBNWnY1Zk9GbnA0V1Ry?=
 =?utf-8?B?L2MzR0NVYkxHbmJTSm9WaUdnS3BWNGtabUlSenFSSVI2NFBhYmJ3Q2Q3Qy9W?=
 =?utf-8?B?NDZMMERSQVFuSFQ2OFhudzlSN1Vhd1R1N2JtcDVHWlViSWxETHZwWjRvUzZz?=
 =?utf-8?B?UElZdmtTSEluYnp1d3NlQVRhRlZqMStBU01pdG9lMzdkakMweHFyVm9UUGxr?=
 =?utf-8?B?RFVVRUF2b0RIOSswK0NMQ0p4NlhnRnRnMlVESEx1eUJiN1BvSjlSemJrenRV?=
 =?utf-8?B?aHhEdDlxUE1ZOVRROGNMU3NhTU1PNFNaV1dJbUZBVHBmMTlGWDN3VmNXK25N?=
 =?utf-8?B?SUlzMWFqUDRvK2FZa0FnYmlmQVpHMXhSQnNCS2dhdWZiTFNJUy8vc25sZCs5?=
 =?utf-8?Q?CSJQyX+vpsb/GI/sKVtWZw8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b66cb1-52b5-4fd4-abfb-08d9d5284e76
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 17:32:14.3162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KrRPsBokvJOO/ypEUqnmratm3w7PQfE0mskNE4PI2DIHHsTIDxiOolu42iEBphmN1RX0kGRpyimdmCX4uz39A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 1/11/2022 11:05, Rafael J. Wysocki wrote:
> On Tue, Jan 11, 2022 at 5:23 PM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
>>
>> +Alex
>>
>> On 1/11/2022 09:52, Rafael J. Wysocki wrote:
>>> On Wed, Jan 5, 2022 at 8:39 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> Currently the Linux kernel will offer s2idle regardless of whether the FADT
>>>> indicates the system should use or on X86 if the LPS0 ACPI device has been
>>>> activated.
>>>>
>>>> On some non-AMD platforms s2idle can be offered even without proper
>>>> firmware support.  The power consumption may be higher in these instances
>>>> but the system otherwise properly suspends and resumes.
>>>
>>> Well, the idea is that s2idle should not require FW support at all. >
>>
>> May I ask - why?  It's an intentional design decision?
> 
> Yes, it is.
> 
>>> It may not be possible to reach the minimum power level of the
>>> platform without FW support, but that should not prevent s2idle from
>>> being used.
>>>
>>>> On AMD platforms however when the FW has been configured not to offer
>>>> s2idle some different hardware initialization has occurred such that the
>>>> system won't properly resume.
>>>
>>> That's rather unfortunate.
>>>
>>> Can you please share some details on what's going on in those cases?
>>>
>>> Technically, without FW support there should be no difference between
>>> the platform state reachable via s2idle and the platform state
>>> reachable via runtime idle.
>>
>> During resume there is a number of page faults that occur and during
>> initialization the ring tests fail.  The graphics is unusable at this
>> time as a result.
>>
>> The amdgpu code actually *does* distinguish between the 3 different
>> cases of S3, S0ix, and runtime suspend.
> 
> But s2idle doesn't guarantee S0ix in any case.
> 
>> The function "amdgpu_acpi_is_s0ix_active" causes different codepaths to
>> be used during the suspend routine.
> 
> Well, as I said, s2idle need not mean S0ix.
> 
>> In this particular case that FADT doesn't set the low power idle bit
>> and that function returns false meaning the s3 codepath is taken but
>> the hardware didn't go through a reset.
> 
> If there is a separate S3 code path, taking it when
> pm_suspend_target_state == PM_SUSPEND_TO_IDLE is incorrect.
> 
>> It *might* also be possible to solve this by mandating an ASIC reset in
>> such a case (we didn't try).
> 
> I'd rather do a PM-runtime path equivalent if the target sleep state
> is PM_SUSPEND_TO_IDLE and there is no FW support for S0ix.
> 
>> However it comes back to my first upleveveled question - is this a case
>> we really want to support and encourage?  This type of bug and
>> combination of codepaths is not a case that is going to be well tested.
>> This patch series will align the kernel behavior to only what AMD validates.
> 
> But this does not follow the definition of s2idle and its documentation.

Very well, we'll work out in amdgpu what we can do.  Please close the 
kernel bugzilla (I don't have permissions).
