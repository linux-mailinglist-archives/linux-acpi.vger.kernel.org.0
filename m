Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EB341BEC3
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Sep 2021 07:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244188AbhI2Fji (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Sep 2021 01:39:38 -0400
Received: from mail-bn8nam08on2053.outbound.protection.outlook.com ([40.107.100.53]:50721
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243585AbhI2Fjh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 Sep 2021 01:39:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMI58QHURHd3H9BkRVzg7x1HDhkPQLYTx9J/OscHPLCAzRNgwN7NsMQJL5w4C0HDUj6AzCbdayjdBq6dF9JR1yBcTLfaZxUfiFlWowDuqC3te6aQxSRyvm1Zmpc4k6GJsno5F96WfCTsoIz2DztUaHehnPDETfFaGDF0r0YHfAylVbCMCtmsZAR13RgMM8h/HFDfe2wsnjEevWPSgFT2S+G5AnR0F+PupRjj0M8CJYaNI0S73xmdq6dtd7nbBHfeu7YB9ZadrzgBiz1wv9ZXh5HDmfbK992EW60PlNkAMdA6FDv6drG4o8q8aIvqQD4Jl+xxvSN6/B4uMObG6Ev/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qQ5yiF9hLD2355dLv8Q+EtEZ3fXkw9dHUCgc0fB0swo=;
 b=G0xIlk1X4F6E9YmiyRLvLJJWuPAIFC5rB6zmWW7/X8V6cBNaYNiJxENPEv54UtZXlc537z9B0dlcqV/Hm6c2vl73VCKWGpp6yW0E6onex0g+8C9Lj+iaDEj3p25DjPTeUlHMPVX3MlQa9wB70L19lhekypkiCN28zozTGMhJ4spmD76uuwmtvcTfCrBKtV5R/7DBmV0Ydecf/zGbfnnN12h3+HmAfgcTYvyHCwOJ8LRJHqIK2wT9hymtakG2RW9YtGVkUhl9G07hS945OxmqpUPpvkaj+l6Lby2Vj7/mqCi2pI8LZ4GqQGt10SCswGz9yrvompqW8tgjJlT7orPwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ5yiF9hLD2355dLv8Q+EtEZ3fXkw9dHUCgc0fB0swo=;
 b=YId5xrG4I2MiopTeYfWIoRR/P0XkLd7Wh7bjXMo4YETybn2+3wIrkfCgkMdLHAbwj02EF7A9qpUdbWScb6ZZHKyMoz04FEIrEcoyFlDiQxycdPO44bWnm/582Kq0Fnzzvcd7Cps17tGbS+MxLp6Wsx+pQ/moPw0zQL7QmDLzG6Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3209.namprd12.prod.outlook.com (2603:10b6:5:184::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 05:37:54 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 05:37:54 +0000
Subject: Re: [PATCHv1] ACPI: processor idle: Allow playing dead in C3 state
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        boris.ostrovsky@oracle.com, Len Brown <lenb@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Gong, Richard" <richard.gong@amd.com>
References: <20210922133116.102-1-richard.gong@amd.com>
 <CAJZ5v0jpOzNS5TFdJNXdxa_p2D_5QQMwwRcSMe8JmjOaTjR8gg@mail.gmail.com>
 <3b26b179-69ba-64a2-807e-8d7609fbeb6e@amd.com>
 <CAJZ5v0g+VcGz65s=iu4fzWmkHS7Z0Dx9tMpDgFZ46f3U4jRkoQ@mail.gmail.com>
 <7b8a7c2a-027f-16c9-0258-d91917c39bac@amd.com>
Message-ID: <52fd74a5-c0cb-0dcc-b5da-fc84651c2253@amd.com>
Date:   Wed, 29 Sep 2021 11:07:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <7b8a7c2a-027f-16c9-0258-d91917c39bac@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::13) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by PN1PR0101CA0051.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 05:37:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed3a2890-5a4f-4d65-816e-08d9830b4945
X-MS-TrafficTypeDiagnostic: DM6PR12MB3209:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB320930829A9E3BEAA1EEC36B97A99@DM6PR12MB3209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfrycR1IgHIQvpLNocTeBmNWWqRAI0qH7eyRtAFXB94LbUa1LEwmGupDlTx253RFTxSC0D7N4t7k1NSav9hqeuqErC6zJ548Xki1WZpLF2QGj+jjQeL3zFDdoKg/3aalqhfpqJ72dHucOLspZjxtzJa8Je1jMYBYdeybGkaUbhrmphanKZIZ84HiLsjziWp59MhP8dPjz8dAdHiGGq3wTg+4yzWHpNcqd4mtnVcxaibvAtvXkmeoAS8mIzAc1hJNkq+AXrSXxN4K6+V01UDWRaQbnhTe6X39IdebIZdmuaeo7T4NBAm69lSWWMyoWbi5EHS84a3+wU0SG3RGqXlR73AaQ94p5niFtkDPpQopewDt0W7si8IfaPXc3ACF3+YGnDzdhp17HHut5nTdTJXJLkWxJj2m0sVcPmi2Tg3S8hC8cp5m8Jx+5VA1pjAgz5OYVGec8G+0qD6ggO07sP9d0eU3d5ILXVlP7GwnUO+3IBYO9AHC8fGPu6zhPiGLW/LnrYHVN9gkLiDxpa7o6m5f6pschnr0vdUcGhhMPvw4Z9QvVzf3uzn+iABcYii/ACYqdadk16inRsWXwaRToOUSFzed1McVS2qPuwJ95WPL74mRDCRrJHg7PUWzNt0/BBK8TkLqC9Ry89VwESutujkXBNiscYO6SEOOyVNM/QpbbmUeZ8WhD/Gk4gZE9H/JD0I7DZMeUec2ITspfFvQm2bHDajYW4WsCgmusVh/DeAgpUxuNlGAGdZLtYi6wKQY/1bF3D14TNoZyGIZu8atp9p6S0UgbV7IxX8WXHl9j6Bh25V1w7nqc4lBjMGi9XSybuXqSQjsYX0XGfcOhupO6uAbmLO9cRVgON+/MMEi9kUGIfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3930.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(45080400002)(83380400001)(36756003)(38100700002)(5660300002)(966005)(508600001)(2616005)(2906002)(26005)(110136005)(6486002)(16576012)(66476007)(66946007)(31686004)(6666004)(4326008)(86362001)(316002)(66556008)(186003)(31696002)(8936002)(53546011)(8676002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elZkRHhIb2ZwZ2hoSlZRS01ZblhZaVVUK05HeEwxMlhkNUVKUDlvSlMwQ2pH?=
 =?utf-8?B?Zll3NGZXMVpGYXFiV2N2SURwczBGUzBUaEdhSEdweGprbXRSdDRJeFBmS2xo?=
 =?utf-8?B?QjlVNFJObUNBa1pFVzEzUkpvZWIrRGxzSkdrZmpYUitUdmdsQTRhUHpnQkxF?=
 =?utf-8?B?SWFkV0lNTWhmZXlBejVDTUFKNHU4S2NuaFFzckh4ZFRiNVdsSzFhZ1pBUUFJ?=
 =?utf-8?B?RXg4bU5lQjJWWmtkcGdSR2VSbWdlMzgxbXd5dHhFU0lSNElrSDZhZzdkeS9a?=
 =?utf-8?B?L2pxZDhrb1NSQitXRVh1VjVpSkZoVC9KMzNLcmx3NFNmYkJvNVQ2cUVMV0FF?=
 =?utf-8?B?YzNJK0c2VTNESEdvWlVUWm1qWXV5dGZCL3FEUmQ5T2JWc3g0aTBYS3ltQjFR?=
 =?utf-8?B?aytKYkdaUkNZb2RFd0hUV0tOQ3hmZ01xeVk4R3pkVVFHcjRIV3hyenkvN202?=
 =?utf-8?B?dzdRbklCcmhDZzYvd3VCVjV4RmVjY00zRXdOTERvRzdXUFZ6TE1xVzRaelBo?=
 =?utf-8?B?MTBsUEJGd20rejdkMnZWMjB4ZHFHSTZUNkdwcHdReisvQjZYZksxd1IxVWhk?=
 =?utf-8?B?TWF4WnpZQlNvaEFUUFBKVXJlUnpJR0FPQlVibXJLd00zWUpxRFZ4Y1Q4VGRR?=
 =?utf-8?B?VGRSOE05My9PY3VSSCsrM1N4UUhYSzdOZW5WaDVkck1DTFNteFNSZ1F5MGVu?=
 =?utf-8?B?dWQrTStPTXVsakY0dVY4aHdheVRRTGpVL3JXakZtYVJleXpLdit6RCtZVXhi?=
 =?utf-8?B?VmhvTk01ZWRMZlFvS1M3SEpHZ0VmK3dZdWtqQ1NUajBmZ3NFVVQ1SjlyY21X?=
 =?utf-8?B?YzJUeGhDRUF4U0NRV3F4N0o3Mkc0Nm5RdWlDMm1Ha1VKcVhwVHR6S3BaSlpZ?=
 =?utf-8?B?ZStOZ3p3aTFhUnJNUXNRYkFxK3gxakZObHZoQmdTZTZ1NTJHUHlvRDg5YXRE?=
 =?utf-8?B?dXU4dE5IOTV0Qi9vQXYvZ21KRXNmZG45enFUTEZtaDUyRDdKSHhBSU0yeEJ3?=
 =?utf-8?B?TitQSUFiK3VQUUJUUklSeXNGNE84bWtkYW5SN0RpTmw3MWZ3OGRTYjVQYTNS?=
 =?utf-8?B?WVRTSFVMVDNRdkwxZnhzRGdmYm9CSTdEUXRkWlIyTzUvNzJIMmsvRmxVN29G?=
 =?utf-8?B?bUhXREtVRVJoNEhCdVVVVVFKVHdCSVovOGU3OWRsUW9OS0VPQUswcjhuQUd2?=
 =?utf-8?B?QzVvZ0dOeUR2MmNuVkc5QjdMb1ZoVHVOZEJUNmkxa0hZN3d1SGxFMmhOcWFB?=
 =?utf-8?B?ZEpEMUs3b1JWQ0dzNFA2Q3Z3SUZWaDdCQWZSU1hSaGtMNHFaM256SnlFNXVK?=
 =?utf-8?B?SUVWNS80VzQzV3BsTnBSZGZZR0dQNzZxWktEbVBrcm9nWXQ0Y2tiSERjV2xT?=
 =?utf-8?B?ZHUzNmhweUw5SWlpL2tQZGFDSHZvc3ZCME4weFVkcmRSQW54R205WHFKU3JG?=
 =?utf-8?B?dXM0ZDJHZ3FyTERBMmJVZHBsRDN4NGxIMzNFUGRLK2JtQ092OWRxQ2Q5TEF1?=
 =?utf-8?B?bDU1TSt6UTB1VnRSOHpYWEJBN3hPWnNmditpTmtDamIrOFN6VVVnVEhRTEtL?=
 =?utf-8?B?cy9RbnhnNGRCUHhIdzVmNFNsdWg3ZTNla1JyUlhhMjRLNE5oMDBKdlRWdGd3?=
 =?utf-8?B?dkRPaU1yT2F6b3BObm5wZGozMTFBN05ha243Y3lkQy9zd1g5NUdEZ3piejdF?=
 =?utf-8?B?NEJWOU5sWDlxVWhkVmZsMWZaVlduSXA5alppUnFHdDM1Z3U2NVN5VjE2UFgv?=
 =?utf-8?Q?8OqREfneb8Gn0eD7HssUF6dUz1HMZI6TlRZGmQS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3a2890-5a4f-4d65-816e-08d9830b4945
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 05:37:54.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZp80LTJ4mJTz7avcJ5JXveWILhqVnFOGP3creIJThc4G3fOJP/uHG/lj4n/uzbR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3209
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 9/28/2021 8:38 PM, Lazar, Lijo wrote:
> 
> 
> On 9/28/2021 7:18 PM, Rafael J. Wysocki wrote:
>> On Tue, Sep 28, 2021 at 3:00 PM Gong, Richard <richard.gong@amd.com> 
>> wrote:
>>>
>>> Hi Rafael,
>>>
>>> On 9/24/2021 11:31 AM, Rafael J. Wysocki wrote:
>>>> On Wed, Sep 22, 2021 at 3:31 PM Richard Gong <richard.gong@amd.com> 
>>>> wrote:
>>>>> When some cores are disabled on AMD platforms, the system will no 
>>>>> longer
>>>>> be able to enter suspend-to-idle s0ix.
>>>>>
>>>>> Update to allow playing dead in C3 state so that the CPUs can enter 
>>>>> the
>>>>> deepest state on AMD platforms.
>>>>>
>>>>> BugLink: 
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1708&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C44c85e9ae1dd4bec087e08d98286aa72%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637684337168161919%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Qoh%2BwD%2B1JzPYBc0rrGfNCdQWY1pKo8WBhLPmsmQ6G%2Bo%3D&amp;reserved=0 
>>>>>
>>>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> Signed-off-by: Richard Gong <richard.gong@amd.com>
>>>>> ---
>>>>>    drivers/acpi/processor_idle.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/acpi/processor_idle.c 
>>>>> b/drivers/acpi/processor_idle.c
>>>>> index f37fba9e5ba0..61d5a72d218e 100644
>>>>> --- a/drivers/acpi/processor_idle.c
>>>>> +++ b/drivers/acpi/processor_idle.c
>>>>> @@ -789,7 +789,8 @@ static int acpi_processor_setup_cstates(struct 
>>>>> acpi_processor *pr)
>>>>>                   state->enter = acpi_idle_enter;
>>>>>
>>>>>                   state->flags = 0;
>>>>> -               if (cx->type == ACPI_STATE_C1 || cx->type == 
>>>>> ACPI_STATE_C2) {
>>>>> +               if (cx->type == ACPI_STATE_C1 || cx->type == 
>>>>> ACPI_STATE_C2
>>>>> +                       || cx->type == ACPI_STATE_C3) {
>>>>>                           state->enter_dead = acpi_idle_play_dead;
>>>>>                           drv->safe_state_index = count;
>>>>>                   }
>>>>> -- 
>>>> Tentatively applied as 5.16 material, but have you done any research
>>>> on why this restriction has been there in the first place?
>>>
>>> Yes, we need this change to align with the updated firmware on AMD
>>> platforms.
>>
>> Well, it wouldn't be necessary to change the code otherwise.
>>
>> Still, without the patch it is not allowed to play dead in deep idle
>> states (C3 type) and do you know why?
>>
> 
> Found the original patch thread, unfortunately there is no discussion on 
> why C3 was skipped or not allowed - 
> https://www.spinics.net/lists/linux-pm/msg27003.html
> 
> Maybe, Intel CPU offlining worked through MWAITs and AMD bothered only 
> till C2.
> 

Hi Boris/Len,

Apologies to barge in. This is regarding the patch you added years back 
- https://www.spinics.net/lists/linux-pm/msg27003.html

Do you recall why C3 was not considered for offline/play dead scenarios 
in the original patch?

For newer AMD processors, power management controller expects all cores 
to request C3 as a precondition for s2idle. When cores are offlined, 
they request only C2 and that prevents s2idle in such cases.

This new patch series is to consider C3 also for offline purpose.

https://lore.kernel.org/linux-acpi/7b8a7c2a-027f-16c9-0258-d91917c39bac@amd.com/T/#ma818870a8272a3755de896dd79d478cf944d1555

Please take a look and also at the questions from Rafael.

Thanks,
Lijo

>> Or IOW how likely is this change to break anything on legacy platforms?
>>
