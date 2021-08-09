Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9C23E47D9
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Aug 2021 16:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhHIOor (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Aug 2021 10:44:47 -0400
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:23009
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233724AbhHIOj5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Aug 2021 10:39:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1D1TBbYO/Da62PAXF7yJ0Cd8M0QPs1ZpLbINetVKft2UiRs8gSJCv1kDhuGxeVoh+g6bipoMcMweZAeLoXuHq75iuKmVFiLEKcsNhqmW5/iC8f7O5i+F6eyc/6bfYp7BhXf5jF+4+AIMnqsSGHKEk78c0nX0znimx7jhq3hX5jDsFnJmG+cW9vu8Q09vBuKNIms2J0/2HL8PDMziq5qIvqCSBwxT3Rfu12usZINog3w0JgLucl+Yl7VA2XNHbNV8XM8f4ixpvaaIgR8oa7mIozCp+aS4dDuCeg8Q800LkCz8tP8+y+G0sgZQSvRBBKr/Ac2+NFPvgg8or4ohKlsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVw8EnNEcT5gUpJmZzmr1KR6An3wgFSg8emcTA6hjRs=;
 b=QUYE6Mfi7hoQVfZKDXpHcyshMSDWv5l7gwSn6Q21E7ZeAVC6Ub9/7DgUT5AH90phmyABSN5wY+oPaP1ZGI/nKMpf0Yaffry5Jam/jSzXn8KDDTpj+0585Ox8GjnZH3rm2FLOAYLPHLFnhfQI/89yLwaneDShENDHQNsKp+bW7g/gx+pYLjo1Vuna/mjItHVFiyD3imOVkrpXG6vqdRi2GnQl2KxYWKcTCluim5+hVH6/ZUlw4nnhPJT8jopqV6rgS6wQATuW7YJRX4hPGr3cE9VZMA4s7JvbBjh/mA95q5rz+k/FF/O2Glisd62vo6GsyEvQqKv2nZ0bD30rYJ4QAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVw8EnNEcT5gUpJmZzmr1KR6An3wgFSg8emcTA6hjRs=;
 b=2WVbysMR2m+a7/qNEmIw3XFiYB2uFw2TilDxPD0kUnjBDlOnL6zc0oQ5LKtoi0S+wHv/K0UBScbdfzRkEf/fo6Thkwlh4rgVLsVtKfEL54jJFkLN9vzpisK/1FxWiaTH7OxrK7VE6ibeY5ZmwfopQDIvluqIxwjg0tFxpTGm5DQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2413.namprd12.prod.outlook.com (2603:10b6:802:2b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Mon, 9 Aug
 2021 14:39:33 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::e8ae:ebd6:7f5d:4b36]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::e8ae:ebd6:7f5d:4b36%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 14:39:33 +0000
Subject: Re: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
To:     "Liang, Prike" <Prike.Liang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Stephen MacNeil <macneisj@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
References: <CALWF37bJU92DxcD4VhBxbS+X+EUv-UW2oY-ogwMyNyGAnn=0WA@mail.gmail.com>
 <309288ec-27ac-0321-dce5-e9ba2bbab7ed@redhat.com>
 <BN9PR12MB505286920B83D4C71AC81E3CA0EE9@BN9PR12MB5052.namprd12.prod.outlook.com>
 <e11ce06f-8a5d-345a-5113-dd8802e9a0b9@amd.com>
 <eab56fac-175b-29b7-f66b-398b6477f390@redhat.com>
 <20210803002018.GH2563957@hr-amd>
 <BYAPR12MB3238DC9B9BBDF9B21C430646FBF09@BYAPR12MB3238.namprd12.prod.outlook.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <f258d6c6-d022-4ab9-a4c9-d38122f3b8e4@amd.com>
Date:   Mon, 9 Aug 2021 09:39:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <BYAPR12MB3238DC9B9BBDF9B21C430646FBF09@BYAPR12MB3238.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0069.namprd05.prod.outlook.com
 (2603:10b6:803:41::46) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2600:1700:70:f700:e148:24b7:9719:da28] (2600:1700:70:f700:e148:24b7:9719:da28) by SN4PR0501CA0069.namprd05.prod.outlook.com (2603:10b6:803:41::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Mon, 9 Aug 2021 14:39:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae63ed13-dc26-4460-d8e9-08d95b4380b1
X-MS-TrafficTypeDiagnostic: SN1PR12MB2413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24137287AE6FE80B10474D9DE2F69@SN1PR12MB2413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aep1iZqXYNR55xTdoU8A1ZdQvJ8G0jK4nWZn2tjRfVb1NEmPfZhYdGcVeKTUXYYaA3IMDaqVGcjTBO06RW0Sw6ApEDCaLnnZtGUptZ0FmLxUJgc7iSXDILFiqF78f1zkoa4aQPmLacoLgZ6pu2LfvdkYtcNFflcxaWdUIaFbIAxi6/oPSSJ71cukpBf1yo23MbsjYX79q35LAd9x1HZI/awkDZWsLckwrXmklTHVOeyHHEIlP7epvNPLBSf7NwAAYUDlToNjAeuef1R6d+uxnGeVL1DkMFClCSfwlNB/QKgyBPjJDx8Zs2KnJ8ePZD/2qmNPaEXe7oB1fzpeSxt7dr5HObg3EsbLI08gNhiXD+k+7PkSOh1fzaQgc5yuls9dly/+6z6+oswutLNKroMd9eumlSAsdCYWPynU9DXgPzgl6RHDiVAnnVwqgnfgwbGkyPB/wj8C/rGiS/bEhXB50/vWkpIwIN1NQi40xv+cNIMdkQaBNVSBv5eC3tvrqLKnfAW5S5B4AXfAQogAK2wI3mzN09RZYMzs7Gub4PqH5/xcB4V8jouJHmu7G6/q+Gt2Bh8W7C6hOhbttUuU2B5k5gc9VD0DNq3X/ON5Bkw4QhnH+YdDunZrOZOL2eTh0XuiZcpO44H52VHD4klPYM5yrSW/TJEQ57bDeu3P1V56W0Sh3NxgT9NuVMFae37R3Go7jvJEURgUwlHKpSvE5hjNDJJsQnuXh8QOpIsNMUTs3vJ4O7tKgT14OeVNq3DkTW3nmSYv+AqU/KbcF0YvAV1I1/4pM+STLaX71typaUhgKEDaC0H66z8BCaGp+n80YNlDL/e28f+MKI7gC7YS87ga9tNxrK3TRtzKl2m7xeiaUDrCVSz93xpgXz1sL2qpx8Uv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(31696002)(53546011)(8676002)(2616005)(4326008)(316002)(54906003)(30864003)(31686004)(110136005)(6486002)(38100700002)(186003)(66556008)(83380400001)(66946007)(66476007)(45080400002)(8936002)(36756003)(5660300002)(478600001)(86362001)(966005)(2906002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlJJTlB3MDRGZVBWZ1hoRVUzMERtYTFzVFcwdmY4eFZiSURNU2NYNjdIbUFZ?=
 =?utf-8?B?dUltdkRlVlM2ZXJQMm1YZ1ovaE9YMldLVm8vV0oxcVJjaHY3VDhlaGtDWHBa?=
 =?utf-8?B?ZWJOazVqdmY0eXBLb3R0c1JydjRSUFBXMjRKMEhhNG1lZVFRNGo0VTIyK3B2?=
 =?utf-8?B?Wm9BYTRrbk9pY05tTTg0ODBlZ2NHK0FnWHMvVVhXL211MTFoc3FwMG1tM3dM?=
 =?utf-8?B?ZFJ4d2w4QzRnS0M5UzAxVXpWYjZpZCt2OW5XM0d6dHBBcnBDbUkzNzYvWWhu?=
 =?utf-8?B?d0w1ajZHR0ttZVZGRGNZaDNHL1E0MG1XSTRHemVBb2ZZelA5RTNsTndMRjk0?=
 =?utf-8?B?c3EyZW92M0hVWGx1TFpiTm41NDhRVk9qSWxwSGVUbElyRm4wQkFZd2RodHJh?=
 =?utf-8?B?YXY2clhHNVo3N29sWXMvc0VWQm1NaXp6YmhDdVVBVytYYlpxNWpKWHhkM1pu?=
 =?utf-8?B?NmMwdDZaOW5xaDBCQTRqVElQb1RuU0ZvQUFDZmE3YXNFcWRyUFo5cnVyZUhR?=
 =?utf-8?B?bmpKMnQxM0N6Q2hPeGhOVXdUUkFsSkZyRzFCQTZIWlAvK3lQY1V1bXJhS0Nt?=
 =?utf-8?B?c1dwaFJmMWdnNkVURUZ4azNpdzd5TXRuTVlCck9EQXVJQ05EN0g5bnhHQ1Rm?=
 =?utf-8?B?RFpzWG8wcGEvdGpqSzdNWEFNREpJSGRRMHUwY2hCekpWSGhLNURIVVZZOXU4?=
 =?utf-8?B?eDFUdzlnYXVWdmdEY0lwbmNFcHA4citSMnBOaDlybVFwZGV6dUpFckZScHpt?=
 =?utf-8?B?Tms5WFBCb2p2UW5lLzlIWVQrWjRMN09HN1RPaUNac0xNbG81a1d4eUl5RjJI?=
 =?utf-8?B?bWFsZkttdzlVazVGbzgyaytrNGR4Qm1QbVNIMTFETmRiVDNtQVVVelhTYUo0?=
 =?utf-8?B?VTc1aDQ5SmR4cldiMmg3Q3JyQzgwMmZhTE5Qdmw4Rm1IQmZMdG5rR29SOEVF?=
 =?utf-8?B?bUFwWjNlZlcxaU1yV2dJbnBTVzYwYlh1cjdtVytKOE5aYk9mSmkxd2lnTm9H?=
 =?utf-8?B?Szd4VWFsOVc5cEdIdGF5RTcvM2NDWHYrZjlUSEhxYzViSVd3TmtBM2NBTG80?=
 =?utf-8?B?emMxZ3ZLam1hS0p4RlhJc09iSUdQQkFwWENLc09jZWUzWmFadWJYdzIxazRW?=
 =?utf-8?B?TUVUVTlMWGpDaFhMVHJTQnNTMFNkMkhpVHdINzBBOVNYMzFxci82K251MjRH?=
 =?utf-8?B?emhCU1FBRHB5NUp2QjVMb1A5SnFmekg3STF0UW1yWUxWVTBML3dFWTBIeDBu?=
 =?utf-8?B?Y1lsZTc4Y05iNVg5emhCYmVKZmxaMUpKa1VXUVNaUnhmQjE5bGsrUFBhMHBR?=
 =?utf-8?B?Q1Y0RFBXL2RmOFRpR1VuN0NmTW5NM1kxcnpiUStoU0xuWUtKSStzTjlJaXJ2?=
 =?utf-8?B?d3pGL2NYZk1WRGF0TzRnSEJqbTJjUm5odDR5NjZ3ZldERlZZTlJaOXdPdm9G?=
 =?utf-8?B?VE16UW9MRnkxNXBuSzJXalpMZ24rVGlnVUxyd0tNLzdlSDA4NFZDd2Ztb3Jr?=
 =?utf-8?B?YnBlUEl1VVpzNkZxR3BrSHFJbzNDTUU0bTdQV3hqMWN1UlJCQ0NkbFhIMS9E?=
 =?utf-8?B?THFyTUpRZHZia212cEhRZ0E4c2IxOFlvSUt4WnBlZ0taKytwYlZmaXFmbW1q?=
 =?utf-8?B?T1RHRS9FYm85WnJVSEFiU1c1RjQ1bjRxcFRNZFVQVlp1NzBmTGZnWWxETHY0?=
 =?utf-8?B?R2t5cW42STFCZThvL0pQVWg4TU95SGN5cnlVZUJGL2NwQmJJV284Sm5SMTlo?=
 =?utf-8?B?Vkx0Zy9VRjhxL0ZjdlZIMW1YVWZBbkRUbWlXUjRyOGsvTEZGR3cvaUNJTXFN?=
 =?utf-8?B?bUFCd3V2RGliNmI2RlJnYnAwWEIyTGdFakVwZlFxenNDZkJYcHpkMG5GK1BS?=
 =?utf-8?Q?QSkDfP4xARK/g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae63ed13-dc26-4460-d8e9-08d95b4380b1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 14:39:33.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBdQvopkQ1yKuks6vW2EzFIrXVe2SLhFhDBRzisogcMer/I+nXNqj9HU5Fyvj4Q8LvLVMfl0RsM7tO+729zyTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2413
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This thread is a mix of top posting and bottom posting and confusing to 
follow.  Some inline comments below.

On 8/2/2021 21:42, Liang, Prike wrote:
> [Public]
> 
> In the AMD existing S0ix system seems needn't monitor SFH idle state, meanwhile SFH is powered by S5 rail and the rail keeps ON when SOC is in S3/S0i3 state. Regards to SFH stop working after S3 resume maybe caused by power rail and device context tear down during S3 suspend. In addition, we also need implement SFH suspend callback in amd-sfh-hid like as other vendor.

I think PM callbacks for SFH will resolve the issue at hand and are the 
most likely the correct solution in this instance.

>> -----Original Message-----
>> From: Huang, Ray <Ray.Huang@amd.com>
>> Sent: Tuesday, August 3, 2021 8:20 AM
>> To: Hans de Goede <hdegoede@redhat.com>
>> Cc: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Shah, Nehal-
>> bakulchandra <Nehal-bakulchandra.Shah@amd.com>; Stephen MacNeil
>> <macneisj@gmail.com>; Limonciello, Mario <Mario.Limonciello@amd.com>;
>> Rafael J . Wysocki <rjw@rjwysocki.net>; Linux PM <linux-
>> pm@vger.kernel.org>; linux-acpi <linux-acpi@vger.kernel.org>; Natikar,
>> Basavaraj <Basavaraj.Natikar@amd.com>; S-k, Shyam-sundar <Shyam-
>> sundar.S-k@amd.com>; Liang, Prike <Prike.Liang@amd.com>
>> Subject: Re: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
>>
>> + Prike
>>
>> On Mon, Aug 02, 2021 at 01:43:01PM +0200, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 8/2/21 11:34 AM, Basavaraj Natikar wrote:
>>>> On 8/1/2021 5:15 PM, Shah, Nehal-bakulchandra wrote:
>>>>> [AMD Official Use Only]
>>>>>
>>>>> Adding few more folks
>>>>>
>>>>> -----Original Message-----
>>>>> From: Hans de Goede <hdegoede@redhat.com>
>>>>> Sent: Sunday, August 1, 2021 3:17 PM
>>>>> To: Stephen MacNeil <macneisj@gmail.com>; Limonciello, Mario
>>>>> <Mario.Limonciello@amd.com>; Rafael J . Wysocki <rjw@rjwysocki.net>
>>>>> Cc: Linux PM <linux-pm@vger.kernel.org>; linux-acpi
>>>>> <linux-acpi@vger.kernel.org>
>>>>> Subject: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
>>>>>
>>>>> Hi Rafael, Mario,
>>>>>
>>>>> Stephen is having an issue with a recent AMD laptop (a Lenovo Ideapad
>> model) where Linux defaults to using S3/deep suspend instead of S0ix/s2idle.
>>>>
>>>> Hi Hans, Et al.
>>>>
>>>> Looks like the Lenovo platform Stephen MacNeil is using does not support
>> the S2Idle as the FADT flags as not set (looking at the output of the script).

So Lenovo intends the platform to be S3 this means.

>>>
>>> I believe it does, if it would not support s2idle at all, then this
>>> would not be offered as an option in the "cat /sys/power/mem_sleep"
>> output.

I don't believe this to be correct.  s2idle is always added.

You can look at the comments (and in the code) to see this:
https://github.com/torvalds/linux/blob/5bfc75d92efd494db37f5c4c173d3639d4772966/kernel/power/suspend.c#L174

>>>
>>> Part of the problem seems to be that the system supports s2idle, but
>>> does not use it by default
>>>
>>>> If sensors are not working after ACPI S3 resume, I am suspecting
>>>> that it could be because the PM support is missing in the amd-sfh driver
>> (which is already WIP from my side).
>>>
>>> Right, making sure the SFH code also works with S3 suspend is good
>>> regardless, but AFAIK most modern systems should use S01x / s2idle
>> suspend by default.
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>>
>>>>> This is causing the sensors provided by the AMD Sensor Fusion Hub to
>> stop working after a suspend/resume. Adding mem_sleep_default=s2idle to
>> the kernel commandline fixes this.

Given that Lenovo has set the FADT not to expect S0ix it's possible that 
other firmware methods used for S0ix are not present such as the LPS0 
_DSM or the methods that amd-pmc would be calling.

If those methods are not present or working properly then it's unlikely 
that the system is getting into the deepest power state.

So unless amd-sfh has introduced the PM callbacks you'll have a tradeoff 
here of non-functional sensors and low power consumption vs functional 
sensors and high power consumption by changing this option.

>>>>>
>>>>> Do you have any idea what might be causing this ?
>>>>>
>>>>> Regards,
>>>>>
>>>>> Hans
>>>>>
>>>>>
>>>>>
>>>>> On 7/31/21 2:31 PM, Stephen MacNeil wrote:
>>>>>> I wrote Basavaraj Natikar the new maintainer of amd_sfh for the kernel,
>> after sending the information he wanted his reply was...
>>>>>>
>>>>>>>> Thanks Stephen MacNeil,
>>>>>> On our hardware we do not see any amd_sfh issue with 5.14.0-rc2
>> kernel.
>>>>>>
>>>>>> Could you please check with Lenovo, as we are not observing amd_sfh
>> issue on our reference platforms too.
>>>>>>
>>>>>> Thanks,
>>>>>> Basavaraj
>>>>>> <<
>>>>>> looking at the information I sent him  i looks like the issue is
>>>>>> (to me anyway)
>>>>>>
>>>>>> cat /sys/power/mem_sleep
>>>>>> [s2idle] deep
>>>>>>
>>>>>> without
>>>>>> cat /sys/power/mem_sleep
>>>>>> s2idle [deep]
>>>>>>
>>>>>>
>>>>>> this is the info he requested... any idea who else I can contact.
>>>>>> this is the output with and without the kernel param
>>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks a lot Stephen MacNeil  for the information.
>>>>>>
>>>>>>
>>>>>>
>>>>>> Could you please provide me below information:-
>>>>>>
>>>>>> ·  what version of kernel is running.
>>>>>>
>>>>>> uname -a
>>>>>> Linux ideapad 5.14.0-051400rc2-generic #202107182230 SMP Sun Jul
>>>>>> 18
>>>>>> 22:34:12 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>>>>>
>>>>>>
>>>>>> ·  Are you using latest patches from amd-sfh
>>>>>>
>>>>>> only the kernel
>>>>>>
>>>>>> ·  Could you please provide me output of /sys/power/mem_sleep
>>>>>>
>>>>>> with kernel option mem_sleep_default=s2idle
>>>>>>
>>>>>> cat /sys/power/mem_sleep
>>>>>> [s2idle] deep
>>>>>>
>>>>>> without
>>>>>> cat /sys/power/mem_sleep
>>>>>> s2idle [deep]
>>>>>>
>>>>>> ·  Could you please provide output of below script after
>>>>>> installing "apt install iasl*". acpica-tools
>>>>>>
>>>>>> with kernel option mem_sleep_default=s2idle
>>>>>>
>>>>>> Intel ACPI Component Architecture
>>>>>> ASL+ Optimizing Compiler/Disassembler version 20190509
>>>>>> Copyright (c) 2000 - 2019 Intel Corporation
>>>>>>
>>>>>> File appears to be binary: found 265 non-ASCII characters,
>>>>>> disassembling Binary file appears to be a valid ACPI table,
>>>>>> disassembling Input file apic.dat, Length 0x138 (312) bytes
>>>>>> ACPI: APIC 0x0000000000000000 000138 (v02 LENOVO CB-
>> 01    00000000
>>>>>> LENO 00000001) Acpi Data Table [APIC] decoded Formatted output:
>>>>>> apic.dsl - 16071 bytes File appears to be binary: found 40
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file batb.dat, Length 0x4A
>>>>>> (74) bytes
>>>>>> ACPI: BATB 0x0000000000000000 00004A (v02 LENOVO CB-
>> 01    00000000
>>>>>> LENO 00000001) Unknown ACPI table signature [BATB], decoding ACPI
>>>>>> table header only Acpi Data Table [BATB] decoded Formatted output:
>>>>>> batb.dsl - 1274 bytes File appears to be binary: found 31
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file bgrt.dat, Length 0x38
>>>>>> (56) bytes
>>>>>> ACPI: BGRT 0x0000000000000000 000038 (v01 LENOVO CB-
>> 01    00000002
>>>>>> LENO 00000001) Acpi Data Table [BGRT] decoded Formatted output:
>>>>>> bgrt.dsl - 1606 bytes File appears to be binary: found 16
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file cdit.dat, Length 0x29
>>>>>> (41) bytes
>>>>>> ACPI: CDIT 0x0000000000000000 000029 (v01 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Unknown ACPI table signature [CDIT], decoding ACPI
>>>>>> table header only Acpi Data Table [CDIT] decoded Formatted output:
>>>>>> cdit.dsl - 1115 bytes File appears to be binary: found 2765
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file crat.dat, Length 0xB80
>>>>>> (2944) bytes
>>>>>> ACPI: CRAT 0x0000000000000000 000B80 (v01 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Unknown ACPI table signature [CRAT], decoding ACPI
>>>>>> table header only Acpi Data Table [CRAT] decoded Formatted output:
>>>>>> crat.dsl - 15424 bytes File appears to be binary: found 15189
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file dsdt.dat, Length 0xAE9B
>>>>>> (44699) bytes
>>>>>> ACPI: DSDT 0x0000000000000000 00AE9B (v01 LENOVO
>> AMD      00001000
>>>>>> INTL 20180313) Pass 1 parse of [DSDT] Pass 2 parse of [DSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    dsdt.dsl - 384071 bytes File appears to be binary:
>>>>>> found 229 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file facp.dat,
>>>>>> Length 0x10C
>>>>>> (268) bytes
>>>>>> ACPI: FACP 0x0000000000000000 00010C (v05 LENOVO CB-
>> 01    00000003
>>>>>> LENO 00000001) Acpi Data Table [FACP] decoded Formatted output:
>>>>>> facp.dsl - 10098 bytes File appears to be binary: found 59
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file facs.dat, Length 0x40
>>>>>> (64) bytes
>>>>>> ACPI: FACS 0x0000000000000000 000040 Acpi Data Table [FACS]
>>>>>> decoded Formatted output:  facs.dsl - 1368 bytes File appears to
>>>>>> be binary:
>>>>>> found 28 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file fpdt.dat,
>>>>>> Length 0x34
>>>>>> (52) bytes
>>>>>> ACPI: FPDT 0x0000000000000000 000034 (v01 LENOVO CB-
>> 01    00000002
>>>>>> LENO 00000001) Acpi Data Table [FPDT] decoded Formatted output:
>>>>>> fpdt.dsl - 1452 bytes File appears to be binary: found 30
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file hpet.dat, Length 0x38
>>>>>> (56) bytes
>>>>>> ACPI: HPET 0x0000000000000000 000038 (v01 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Acpi Data Table [HPET] decoded Formatted output:
>>>>>> hpet.dsl - 1865 bytes File appears to be binary: found 279
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file ivrs.dat, Length 0x1A4
>>>>>> (420) bytes
>>>>>> ACPI: IVRS 0x0000000000000000 0001A4 (v02 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Acpi Data Table [IVRS] decoded Formatted output:
>>>>>> ivrs.dsl - 6001 bytes File appears to be binary: found 36
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file mcfg.dat, Length 0x3C
>>>>>> (60) bytes
>>>>>> ACPI: MCFG 0x0000000000000000 00003C (v01 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Acpi Data Table [MCFG] decoded Formatted output:
>>>>>> mcfg.dsl - 1526 bytes File appears to be binary: found 32
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file msdm.dat, Length 0x55
>>>>>> (85) bytes
>>>>>> ACPI: MSDM 0x0000000000000000 000055 (v03 LENOVO CB-
>> 01    00000000
>>>>>> LENO 00000001) Acpi Data Table [MSDM] decoded Formatted output:
>>>>>> msdm.dsl - 1557 bytes File appears to be binary: found 25
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file sbst.dat, Length 0x30
>>>>>> (48) bytes
>>>>>> ACPI: SBST 0x0000000000000000 000030 (v01 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Acpi Data Table [SBST] decoded Formatted output:
>>>>>> sbst.dsl - 1282 bytes File appears to be binary: found 410
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file ssdt10.dat, Length
>>>>>> 0x47F (1151) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 00047F (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt10.dsl - 5673 bytes File appears to be binary:
>>>>>> found 708 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt11.dat,
>>>>>> Length 0xC1D (3101) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 000C1D (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt11.dsl - 15424 bytes File appears to be binary:
>>>>>> found 848 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt12.dat,
>>>>>> Length 0x9AD (2477) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 0009AD (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt12.dsl - 12474 bytes File appears to be binary:
>>>>>> found 9207 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt1.dat,
>>>>>> Length
>>>>>> 0x7216 (29206) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 007216 (v02 LENOVO AmdTable
>> 00000002
>>>>>> MSFT 04000000) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt1.dsl - 208699 bytes File appears to be binary:
>>>>>> found 3968 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt2.dat,
>>>>>> Length
>>>>>> 0x1500 (5376) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 001500 (v01 LENOVO AmdTable
>> 00000001
>>>>>> AMD
>>>>>> 00000001) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing
>>>>>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt2.dsl - 59265 bytes File appears to be binary:
>>>>>> found 449 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt3.dat,
>>>>>> Length 0x53A (1338) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 00053A (v01 LENOVO Tpm2Tabl
>> 00009999
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt3.dsl - 10738 bytes File appears to be binary:
>>>>>> found 474 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt4.dat,
>>>>>> Length 0x64C (1612) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 00064C (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt4.dsl - 8258 bytes File appears to be binary:
>>>>>> found 400 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt5.dat,
>>>>>> Length 0x480 (1152) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 000480 (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt5.dsl - 5582 bytes File appears to be binary:
>>>>>> found 1140 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt6.dat,
>>>>>> Length 0x1497 (5271) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 001497 (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt6.dsl - 20293 bytes File appears to be binary:
>>>>>> found 1314 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt7.dat,
>>>>>> Length
>>>>>> 0x1576 (5494) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 001576 (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt7.dsl - 30076 bytes File appears to be binary:
>>>>>> found 4095 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt8.dat,
>>>>>> Length 0x353C (13628) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 00353C (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt8.dsl - 78242 bytes File appears to be binary:
>>>>>> found 74 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt9.dat,
>>>>>> Length 0x90
>>>>>> (144) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 000090 (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt9.dsl - 1767 bytes File appears to be binary:
>>>>>> found 32 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file tpm2.dat,
>>>>>> Length 0x38 (56) bytes
>>>>>> ACPI: TPM2 0x0000000000000000 000038 (v04 LENOVO CB-
>> 01    00000002
>>>>>> LENO 00000001) Acpi Data Table [TPM2] decoded Formatted output:
>>>>>> tpm2.dsl - 1515 bytes File appears to be binary: found 189
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file uefi.dat, Length 0x12A
>>>>>> (298) bytes
>>>>>> ACPI: UEFI 0x0000000000000000 00012A (v01 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Acpi Data Table [UEFI] decoded Formatted output:
>>>>>> uefi.dsl - 2505 bytes File appears to be binary: found 37100
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file vfct.dat, Length 0xD484
>>>>>> (54404) bytes
>>>>>> ACPI: VFCT 0x0000000000000000 00D484 (v01 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Unknown ACPI table signature [VFCT], decoding ACPI
>>>>>> table header only Acpi Data Table [VFCT] decoded Formatted output:
>>>>>> vfct.dsl - 269557 bytes File appears to be binary: found 17
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file wsmt.dat, Length 0x28
>>>>>> (40) bytes
>>>>>> ACPI: WSMT 0x0000000000000000 000028 (v01 LENOVO CB-
>> 01    00000000
>>>>>> LENO 00000001) Acpi Data Table [WSMT] decoded Formatted output:
>>>>>> wsmt.dsl - 1313 bytes Low Power S0 Idle is 0 The system does not
>>>>>> support S0ix!
>>>>>>
>>>>>>
>>>>>> without
>>>>>>
>>>>>> Intel ACPI Component Architecture
>>>>>> ASL+ Optimizing Compiler/Disassembler version 20190509
>>>>>> Copyright (c) 2000 - 2019 Intel Corporation
>>>>>>
>>>>>> File appears to be binary: found 265 non-ASCII characters,
>>>>>> disassembling Binary file appears to be a valid ACPI table,
>>>>>> disassembling Input file apic.dat, Length 0x138 (312) bytes
>>>>>> ACPI: APIC 0x0000000000000000 000138 (v02 LENOVO CB-
>> 01    00000000
>>>>>> LENO 00000001) Acpi Data Table [APIC] decoded Formatted output:
>>>>>> apic.dsl - 16071 bytes File appears to be binary: found 40
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file batb.dat, Length 0x4A
>>>>>> (74) bytes
>>>>>> ACPI: BATB 0x0000000000000000 00004A (v02 LENOVO CB-
>> 01    00000000
>>>>>> LENO 00000001) Unknown ACPI table signature [BATB], decoding ACPI
>>>>>> table header only Acpi Data Table [BATB] decoded Formatted output:
>>>>>> batb.dsl - 1274 bytes File appears to be binary: found 31
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file bgrt.dat, Length 0x38
>>>>>> (56) bytes
>>>>>> ACPI: BGRT 0x0000000000000000 000038 (v01 LENOVO CB-
>> 01    00000002
>>>>>> LENO 00000001) Acpi Data Table [BGRT] decoded Formatted output:
>>>>>> bgrt.dsl - 1606 bytes File appears to be binary: found 16
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file cdit.dat, Length 0x29
>>>>>> (41) bytes
>>>>>> ACPI: CDIT 0x0000000000000000 000029 (v01 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Unknown ACPI table signature [CDIT], decoding ACPI
>>>>>> table header only Acpi Data Table [CDIT] decoded Formatted output:
>>>>>> cdit.dsl - 1115 bytes File appears to be binary: found 2765
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file crat.dat, Length 0xB80
>>>>>> (2944) bytes
>>>>>> ACPI: CRAT 0x0000000000000000 000B80 (v01 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Unknown ACPI table signature [CRAT], decoding ACPI
>>>>>> table header only Acpi Data Table [CRAT] decoded Formatted output:
>>>>>> crat.dsl - 15424 bytes File appears to be binary: found 15189
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file dsdt.dat, Length 0xAE9B
>>>>>> (44699) bytes
>>>>>> ACPI: DSDT 0x0000000000000000 00AE9B (v01 LENOVO
>> AMD      00001000
>>>>>> INTL 20180313) Pass 1 parse of [DSDT] Pass 2 parse of [DSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    dsdt.dsl - 384071 bytes File appears to be binary:
>>>>>> found 229 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file facp.dat,
>>>>>> Length 0x10C
>>>>>> (268) bytes
>>>>>> ACPI: FACP 0x0000000000000000 00010C (v05 LENOVO CB-
>> 01    00000003
>>>>>> LENO 00000001) Acpi Data Table [FACP] decoded Formatted output:
>>>>>> facp.dsl - 10098 bytes File appears to be binary: found 59
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file facs.dat, Length 0x40
>>>>>> (64) bytes
>>>>>> ACPI: FACS 0x0000000000000000 000040 Acpi Data Table [FACS]
>>>>>> decoded Formatted output:  facs.dsl - 1368 bytes File appears to
>>>>>> be binary:
>>>>>> found 28 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file fpdt.dat,
>>>>>> Length 0x34
>>>>>> (52) bytes
>>>>>> ACPI: FPDT 0x0000000000000000 000034 (v01 LENOVO CB-
>> 01    00000002
>>>>>> LENO 00000001) Acpi Data Table [FPDT] decoded Formatted output:
>>>>>> fpdt.dsl - 1452 bytes File appears to be binary: found 30
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file hpet.dat, Length 0x38
>>>>>> (56) bytes
>>>>>> ACPI: HPET 0x0000000000000000 000038 (v01 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Acpi Data Table [HPET] decoded Formatted output:
>>>>>> hpet.dsl - 1865 bytes File appears to be binary: found 279
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file ivrs.dat, Length 0x1A4
>>>>>> (420) bytes
>>>>>> ACPI: IVRS 0x0000000000000000 0001A4 (v02 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Acpi Data Table [IVRS] decoded Formatted output:
>>>>>> ivrs.dsl - 6001 bytes File appears to be binary: found 36
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file mcfg.dat, Length 0x3C
>>>>>> (60) bytes
>>>>>> ACPI: MCFG 0x0000000000000000 00003C (v01 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Acpi Data Table [MCFG] decoded Formatted output:
>>>>>> mcfg.dsl - 1526 bytes File appears to be binary: found 32
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file msdm.dat, Length 0x55
>>>>>> (85) bytes
>>>>>> ACPI: MSDM 0x0000000000000000 000055 (v03 LENOVO CB-
>> 01    00000000
>>>>>> LENO 00000001) Acpi Data Table [MSDM] decoded Formatted output:
>>>>>> msdm.dsl - 1557 bytes File appears to be binary: found 25
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file sbst.dat, Length 0x30
>>>>>> (48) bytes
>>>>>> ACPI: SBST 0x0000000000000000 000030 (v01 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Acpi Data Table [SBST] decoded Formatted output:
>>>>>> sbst.dsl - 1282 bytes File appears to be binary: found 410
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file ssdt10.dat, Length
>>>>>> 0x47F (1151) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 00047F (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt10.dsl - 5673 bytes File appears to be binary:
>>>>>> found 708 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt11.dat,
>>>>>> Length 0xC1D (3101) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 000C1D (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt11.dsl - 15424 bytes File appears to be binary:
>>>>>> found 848 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt12.dat,
>>>>>> Length 0x9AD (2477) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 0009AD (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt12.dsl - 12474 bytes File appears to be binary:
>>>>>> found 9207 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt1.dat,
>>>>>> Length
>>>>>> 0x7216 (29206) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 007216 (v02 LENOVO AmdTable
>> 00000002
>>>>>> MSFT 04000000) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt1.dsl - 208699 bytes File appears to be binary:
>>>>>> found 3968 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt2.dat,
>>>>>> Length
>>>>>> 0x1500 (5376) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 001500 (v01 LENOVO AmdTable
>> 00000001
>>>>>> AMD
>>>>>> 00000001) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing
>>>>>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt2.dsl - 59265 bytes File appears to be binary:
>>>>>> found 449 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt3.dat,
>>>>>> Length 0x53A (1338) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 00053A (v01 LENOVO Tpm2Tabl
>> 00009999
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt3.dsl - 10738 bytes File appears to be binary:
>>>>>> found 474 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt4.dat,
>>>>>> Length 0x64C (1612) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 00064C (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt4.dsl - 8258 bytes File appears to be binary:
>>>>>> found 400 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt5.dat,
>>>>>> Length 0x480 (1152) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 000480 (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt5.dsl - 5582 bytes File appears to be binary:
>>>>>> found 1140 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt6.dat,
>>>>>> Length 0x1497 (5271) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 001497 (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt6.dsl - 20293 bytes File appears to be binary:
>>>>>> found 1314 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt7.dat,
>>>>>> Length
>>>>>> 0x1576 (5494) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 001576 (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt7.dsl - 30076 bytes File appears to be binary:
>>>>>> found 4095 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt8.dat,
>>>>>> Length 0x353C (13628) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 00353C (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt8.dsl - 78242 bytes File appears to be binary:
>>>>>> found 74 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file ssdt9.dat,
>>>>>> Length 0x90
>>>>>> (144) bytes
>>>>>> ACPI: SSDT 0x0000000000000000 000090 (v01 LENOVO AmdTable
>> 00000001
>>>>>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
>>>>>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>>>>>
>>>>>> Parsing completed
>>>>>> Disassembly completed
>>>>>> ASL Output:    ssdt9.dsl - 1767 bytes File appears to be binary:
>>>>>> found 32 non-ASCII characters, disassembling Binary file appears
>>>>>> to be a valid ACPI table, disassembling Input file tpm2.dat,
>>>>>> Length 0x38 (56) bytes
>>>>>> ACPI: TPM2 0x0000000000000000 000038 (v04 LENOVO CB-
>> 01    00000002
>>>>>> LENO 00000001) Acpi Data Table [TPM2] decoded Formatted output:
>>>>>> tpm2.dsl - 1515 bytes File appears to be binary: found 189
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file uefi.dat, Length 0x12A
>>>>>> (298) bytes
>>>>>> ACPI: UEFI 0x0000000000000000 00012A (v01 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Acpi Data Table [UEFI] decoded Formatted output:
>>>>>> uefi.dsl - 2505 bytes File appears to be binary: found 37100
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file vfct.dat, Length 0xD484
>>>>>> (54404) bytes
>>>>>> ACPI: VFCT 0x0000000000000000 00D484 (v01 LENOVO CB-
>> 01    00000001
>>>>>> LENO 00000001) Unknown ACPI table signature [VFCT], decoding ACPI
>>>>>> table header only Acpi Data Table [VFCT] decoded Formatted output:
>>>>>> vfct.dsl - 269557 bytes File appears to be binary: found 17
>>>>>> non-ASCII characters, disassembling Binary file appears to be a
>>>>>> valid ACPI table, disassembling Input file wsmt.dat, Length 0x28
>>>>>> (40) bytes
>>>>>> ACPI: WSMT 0x0000000000000000 000028 (v01 LENOVO CB-
>> 01    00000000
>>>>>> LENO 00000001) Acpi Data Table [WSMT] decoded Formatted output:
>>>>>> wsmt.dsl - 1313 bytes Low Power S0 Idle is 0 The system does not
>>>>>> support S0ix!
>>>>>>
>>>>>>
>>>>>> #################################################
>>>>>> #!/bin/bash
>>>>>>
>>>>>> cd /var/tmp/
>>>>>>
>>>>>> acpidump -b
>>>>>>
>>>>>> iasl -d *.dat
>>>>>>
>>>>>> lp=$(grep "Low Power S0 Idle" /var/tmp/facp.dsl | awk '{print
>>>>>> $(NF)}')
>>>>>>
>>>>>> if [ "$lp" -eq 1 ]; then
>>>>>>
>>>>>> echo "Low Power S0 Idle is" $lp
>>>>>>
>>>>>> echo "The system supports S0ix!"
>>>>>>
>>>>>> else
>>>>>>
>>>>>> echo "Low Power S0 Idle is" $lp
>>>>>>
>>>>>> echo "The system does not support S0ix!"
>>>>>>
>>>>>> fi
>>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Basavaraj
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Stephen MacNeil
>>>>>> 905 334 5092
>>>>>> mglessons.com
>>>>>>
>> <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2F
>>>>>>
>> mglessons.com%2F&amp;data=04%7C01%7Cray.huang%40amd.com%7C0db
>> f347b
>>>>>>
>> 744f4480a76608d955aab43c%7C3dd8961fe4884e608e11a82d994e183d%7C0
>> %7C
>>>>>>
>> 0%7C637635013945224005%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL
>> jAwMDA
>>>>>>
>> iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Z
>>>>>>
>> c6RqCBpmncIWTGiBpZ%2BmOBmPVV7gIx8mS2hqBenP6k%3D&amp;reserve
>> d=0>
>>>>
>>>

