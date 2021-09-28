Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1598941B2A2
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Sep 2021 17:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241409AbhI1PKT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Sep 2021 11:10:19 -0400
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:3009
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241433AbhI1PKL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Sep 2021 11:10:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIC5q5kBHDZEvChqIGkBssF2RsAJ2wLewtZxse+SmtazL8nA45p8VaCwwoeLOOmHNHBAJ78mvYdideu3fHPscHIl9r3j3jvB+40cjrmhDpvu8NlxguedVN0VChyv1MReZQAeN8J2rJjbujSAsi66TWBC+OzpMyZCCQE85ZD850DVAXlNoIzjLujZNRZ3q6P7OM0RzCj5/I8/XqEGiPlbvN+zrxbWMYNXChyzhOKlUxQXu3SLIbrWc/kdwwQwpx6kYZcaKE3brjL5F66X+e7XIwg/iAfqVZVsAFF7CACub9ljqpF9098mO+g4QBMfc0BJoKLbQYodltaw0/jHtAkKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=M4mQE3vrQp3M1DedB6pEQy88aYy4u+y72EQOPTVI7Dc=;
 b=T02aVLQIgdP2axl4KstCTJsj4f+aboHOwlUfEth4AGLc+mUya7UOQObm/juCoCQ7b1Dy51XxkpK4jDZwRvlzhB6OYwHvG8vUV5DQmoiMnYAZ6fvL3LW7/3zOctIWY+0kHaeyq2O6Q3kkQNrjSBVUZNtySjr+nIeXrm1yj6XThpKGxU/Ft3Oih6QeGMHywa0kKDjHTb0RPkYmdzwNrLLlxnmyB3zIbEbBHSuQiMyiu5u/+AzFHyjDHowS3NH4J2Pu1OEJ22KHg7t0gYAakyuGHW37G6GmBsU9KlTw47TJbAP6KuqBw8AMNV1z084WboXYx01PrSLNGhc/5Pj8jOA+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4mQE3vrQp3M1DedB6pEQy88aYy4u+y72EQOPTVI7Dc=;
 b=2cvquEslxIMkyJOV1tnE04fzTB5+IC5Fe1Wz/IFgeGcxo+2MZEoux/eCjKPzdPgCC1fBK4L/z6ZikyBJoOPCNbM2DUR95jsIzFd3pQPiPH5zhqOWWPU6pMYuUEaVprqw86LSofgf6KRkwy3s7yGdNdwiP/cTBdjPQhmvy6liJts=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 15:08:30 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 15:08:30 +0000
Subject: Re: [PATCHv1] ACPI: processor idle: Allow playing dead in C3 state
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Gong, Richard" <richard.gong@amd.com>
Cc:     Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20210922133116.102-1-richard.gong@amd.com>
 <CAJZ5v0jpOzNS5TFdJNXdxa_p2D_5QQMwwRcSMe8JmjOaTjR8gg@mail.gmail.com>
 <3b26b179-69ba-64a2-807e-8d7609fbeb6e@amd.com>
 <CAJZ5v0g+VcGz65s=iu4fzWmkHS7Z0Dx9tMpDgFZ46f3U4jRkoQ@mail.gmail.com>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <7b8a7c2a-027f-16c9-0258-d91917c39bac@amd.com>
Date:   Tue, 28 Sep 2021 20:38:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAJZ5v0g+VcGz65s=iu4fzWmkHS7Z0Dx9tMpDgFZ46f3U4jRkoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::17) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by BM1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 15:08:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d245c3a8-ab10-4648-fb26-08d98291d4b8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4944:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4944A94EB5AF8C81101AB1EF97A89@DM6PR12MB4944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96cmvXQV8Mgz7x3Iaje9A/JiAOrreK34iDoUY8uc7A6gYwZBUFnnv8W3j0vCVSXevL6Dkco7e8ogK0SGNLsrEpFPumgvNDuT1C+IuAqQBrO0Oo0R4nxL0RRRO2+e0MOqMEUD/1wAf6yrgG1uoniBq1v+PtNuiT0sKCDCd9kmAVReWTMVWHQwgUcBjxGDWDXJdvwnLHu+lcP3RB6Dj1q7YzhMNEqYbGFPQNMgvdW9/mCCIQ/g5dQSKG0w5xZLGwd1wdpG4evkdkcfWBq1nyy/bSUpjZ91mDeK/iWr1Qv7+BMufDtNyurRw4oWDp/IfVeQjaFw0Y35Nfh+1IiHEB0VPhFtAzcD2FaeYJ3EFtV++pkXlNZOOH0bhpC2a0/YW9Rhd3qjoCsm/zAqyzMzNIkjxxdA4S3qsplgX95SX5Bo12xMSrnweFxfp+54g5MKhwlJhkGJbQxRtM6tXiDnwjoTduO9m1ddjiS2jXx4Q+MXWRZy7EMKmqpdEOyK8Mq84KU2nY8lY8OLH+6X5TUJqxD+i22bJaETBOkWlEU8P2HDWN6TiKfTNlj9TFucJdDPzjVJnzGoKlo5WhYyU4eM3vdYwIe9E9sGhi2E4K2oJPkRle1PRV2MDJXOj5Gn2dQOwSB4UWYrYNGoFk859/RR5jxAVCMA7Q9ZoLjB9aCAf1b+CyCZ3aW7/UjmxLfJVwu2D1VMumEmb5aBqcu0pHrwPERcRpzzBVkPUcvUr/Bm5icQrpsnYfMa9aVBqmtnYYB9GO2kdRDqUS2QxS7lpA3yHdPmAoapIDAtTwtV34226j9l51iprz4Pd/eE14QZ1WsHsGDA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3930.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(4326008)(2616005)(508600001)(956004)(5660300002)(966005)(36756003)(8936002)(53546011)(45080400002)(6666004)(8676002)(66476007)(26005)(66946007)(186003)(66556008)(6636002)(31696002)(31686004)(316002)(110136005)(54906003)(16576012)(38100700002)(2906002)(86362001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXpuaHFIZ0Z1dnJQRkZzSVdGNlZSL21ZR21aSlJlVCtkQWYzbTNnTmZqb2dy?=
 =?utf-8?B?RXgydDJwbnB3aHdyNTdiL05IclBQQzNvVXJnSDIzNWlPcmFxZ29TVXVJSEVB?=
 =?utf-8?B?aDdGR2ViNS9VQ0lqcitvU1pZUTNSWHZGUHhSWm9xVC9ta2xBNDY2M1NiUWpo?=
 =?utf-8?B?VXBSV3FWRWVVN1M5RkJzQ3BVOXE5VkRwZ25KR2J1V2VWemRhRk9NWldTTitH?=
 =?utf-8?B?QytpNXZwWnZrRkxhSkNnRUU5MVE5NWpocmQ0VEQ3ZWpmVnNyd0NwK2R1WFFu?=
 =?utf-8?B?bEZzdFlPSjY2U3MvMjk0NmtqQmg5bTRiY3FyL1NNRXNKOSt0WWVMK2VId2F6?=
 =?utf-8?B?UWNPclQ2MHZ6cThzWlRqdEtCTTJEMjZyeGNRRkdUMm1yMjMzRTllWDhISE0r?=
 =?utf-8?B?ckNvSWJNMk5PZzVGdzhrRU0zeWhRcGNrTUhqNlFHWGlGS0tNNXMzVFB3R040?=
 =?utf-8?B?TUNUdWdlSEkwdVdOa2FHTGwzZ3pkclNablpYTmxwV2xlTGFTOWtSMUg4MmUr?=
 =?utf-8?B?QlhRdS8ybjdpajRhSWRQQkloRTc0cUdBbk1YSXZoZDI1K1RlcC9YT29KeTR6?=
 =?utf-8?B?aTJwcTUybzUwalorUXYvQUVMM3ViTU5mOVowMW81eUNmTFlnUGkzQ09QQ3Bj?=
 =?utf-8?B?UW92LzFZV3NxV3lVZ21QZmxYS1VuS1pJRFUwTHZTbTZ6THo2VHFNajB2VVUy?=
 =?utf-8?B?MlVSWVgrYWEyZnl3VkNpWS9QdER1SEptb0k1VnEybFV3Ynl3QlhCRnJlalc2?=
 =?utf-8?B?Zm5xUW1oWnd1MEFaNU9lblY1Q2NON0lCSmV5Z3ZzNGpaUVB4dXY5Y3dNOWM5?=
 =?utf-8?B?TWFqM3NkNXdJbTRVck9qWWNCWVlHMVFUL01xL1VmMm9PdXpDbDA5YlJrcTRN?=
 =?utf-8?B?VkRMeGZscTIvSk94cFVtQk1VN0hrd2dqeWZpUzNnekJHWWIrZCtNa1hoYWNQ?=
 =?utf-8?B?UUpqTEZVL2xoUjBXQzRUcWR6ZnB4M3lHekllZ25Pb0VKN1IxQTFRQW9CRGhZ?=
 =?utf-8?B?dytzTDJpa3l2TTQ5YThwR0VMSjRFa1A3b09DbUR1bXAzVFZscWpVWEVHMlU2?=
 =?utf-8?B?Y2QzRHdZaWpDRnV3Q2xKUGFnSE9adEhLaFlnbXNiVGt1aTFab3hzYlBwZnhM?=
 =?utf-8?B?ckhHSUozb1lOclZXZkRqVjNDay9iMlVHdGFtVXhDVlpzMXFvZ2xiUDJZNDJB?=
 =?utf-8?B?N3lFM2E3cEhXZmRjeTVhdEpCdXdWdEZ1NGlMTHNjc1hxZ3J2WjBuN0JrNE1R?=
 =?utf-8?B?eVdCejlIc2pvWVdyM0o3UG1ueVdabVVFVzBtSkRqd241S2dQS1U1NTBBUzdH?=
 =?utf-8?B?ZGRZbGQ2cGFFcUo3dXViVnRrcEpiTjRKM2xCcC9TdjNtVXB1Q0lqOVZudXRJ?=
 =?utf-8?B?d01LSjMvV3JsRlA3SW54TGc2eWFVZFR6NGthSnN0UjRkRW5nYnFjSldZQm15?=
 =?utf-8?B?cXJTaFJ5NGROMTM4OTZmQmx4cUhienZieExNSEh2ZzZhRE0xSXNhVk5jY2NI?=
 =?utf-8?B?NzNMaEdnVVFGYm9Wc2c0bVRBSkl1NVBWK2d0RU82SnFRUGJZMnRYWWZZaVU4?=
 =?utf-8?B?aURLdDZQYis0a21pZElXNEdUbDFPb0ZGVnRLWWt6Ni8wbklLaXJmckVtekJJ?=
 =?utf-8?B?R1Z5NUhKY2VTMmZYVFNYYk1KbTZjNlVISXRlcW5xaDMzWE5zYUFoaHhiNUR3?=
 =?utf-8?B?NnU4NERvYTc3TVhtVHlLUlgreHZJUWhkeHRKeVNJZzdLZzJxTnR0d3RCc1Fq?=
 =?utf-8?Q?fJQvGn26fDJqvK5VzH6AocqzVBkSE5buAqaWHfV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d245c3a8-ab10-4648-fb26-08d98291d4b8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 15:08:30.1596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AOIycAlHAqGhn3aoyZt8Gu9j2+EWAbD1/oX4dOBjXCYarJl4H7hBYaKWzvuI/RZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4944
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 9/28/2021 7:18 PM, Rafael J. Wysocki wrote:
> On Tue, Sep 28, 2021 at 3:00 PM Gong, Richard <richard.gong@amd.com> wrote:
>>
>> Hi Rafael,
>>
>> On 9/24/2021 11:31 AM, Rafael J. Wysocki wrote:
>>> On Wed, Sep 22, 2021 at 3:31 PM Richard Gong <richard.gong@amd.com> wrote:
>>>> When some cores are disabled on AMD platforms, the system will no longer
>>>> be able to enter suspend-to-idle s0ix.
>>>>
>>>> Update to allow playing dead in C3 state so that the CPUs can enter the
>>>> deepest state on AMD platforms.
>>>>
>>>> BugLink: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1708&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C44c85e9ae1dd4bec087e08d98286aa72%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637684337168161919%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Qoh%2BwD%2B1JzPYBc0rrGfNCdQWY1pKo8WBhLPmsmQ6G%2Bo%3D&amp;reserved=0
>>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> Signed-off-by: Richard Gong <richard.gong@amd.com>
>>>> ---
>>>>    drivers/acpi/processor_idle.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>>>> index f37fba9e5ba0..61d5a72d218e 100644
>>>> --- a/drivers/acpi/processor_idle.c
>>>> +++ b/drivers/acpi/processor_idle.c
>>>> @@ -789,7 +789,8 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>>>>                   state->enter = acpi_idle_enter;
>>>>
>>>>                   state->flags = 0;
>>>> -               if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2) {
>>>> +               if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2
>>>> +                       || cx->type == ACPI_STATE_C3) {
>>>>                           state->enter_dead = acpi_idle_play_dead;
>>>>                           drv->safe_state_index = count;
>>>>                   }
>>>> --
>>> Tentatively applied as 5.16 material, but have you done any research
>>> on why this restriction has been there in the first place?
>>
>> Yes, we need this change to align with the updated firmware on AMD
>> platforms.
> 
> Well, it wouldn't be necessary to change the code otherwise.
> 
> Still, without the patch it is not allowed to play dead in deep idle
> states (C3 type) and do you know why?
> 

Found the original patch thread, unfortunately there is no discussion on 
why C3 was skipped or not allowed - 
https://www.spinics.net/lists/linux-pm/msg27003.html

Maybe, Intel CPU offlining worked through MWAITs and AMD bothered only 
till C2.

Thanks,
Lijo

> Or IOW how likely is this change to break anything on legacy platforms?
> 
