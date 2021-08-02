Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0782D3DD300
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Aug 2021 11:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhHBJfF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Aug 2021 05:35:05 -0400
Received: from mail-dm3nam07on2071.outbound.protection.outlook.com ([40.107.95.71]:43201
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231460AbhHBJfF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Aug 2021 05:35:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDR7yf/AJHEW4ZHV3/249ViIR+NCOqP0wM1UWjTOyQJkIlsUtwFm5j+cn6+QQjRbIQ758PqkMIj+cdsAs4xh80gwn63ToH0/NWvUbK3T+5libh3T7Smjb7Q45hv3VF5b53hhwuaamhEad85gY//5jBZ8uaTHiIyCgSsiDSoeCynjvKokhvn695dayXW4zdRRl6MukRZW5DXPpA9hSBzLT/fn2l6yChFakqUKhn3DI9EIlJxdE5RjDKO8lVvkNCnNYMC+9T1WQ8DRLvXU9jU+6hlB5PZXqEfFH83gYyV0K0HLy+9MsqNNmxAHQaivJhTZHYAWfPgMKQHJlO0lCBD2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkD2c0nXTVuV+3oseOkNclG5qO2oXEa0X5W6YFuPtPc=;
 b=TEpcaDAqr8r8LutjrDa9Hv1O7Jw57DiBKcf/f27c9HTpnUU0NFGURL/CknVqgPzTKAiHgQZkyur5SwIEO3WBpeLZWE3VcBQAQeuDmvTaHu90G7E8TJ5HEg7DUfzLKCWF8/bodxjQV+Y5sqHEd6Dao498N4e05/nESNXZIpIDXfQxWSk8GXaNKPl/yt8y6x/N2rSJG68TTaAd2Lw/MSgsApOGtd1vZH0odOmu2TASgbYeDPTtOj411xgPX2JAJsJu7P0urMXtZQL1QaatkRzc6YT8ONSi7tlu+W9HuPM3vBQj0hARMq4ns/fp5oyLTHoYGpB4WwijypZgNqmV9Zv+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkD2c0nXTVuV+3oseOkNclG5qO2oXEa0X5W6YFuPtPc=;
 b=SV5gPxJcXVd6zbX9mmuYU4P8oqJ/CXXgyMeHz/eJni56Xzd3wW74FQEWHiRHTC0XXH20gqfOdWFXr7aJoiv+HPL7KhwQAKiP6XPGT10k/+bscdnwfgVL7FbgB5iH3sXx+cVJjNlNSp4jT5bXpd9iEq8R6Eg5ei/NxCklQT1/DDM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Mon, 2 Aug
 2021 09:34:54 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::7c6d:57fe:e2e6:69e3]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::7c6d:57fe:e2e6:69e3%4]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 09:34:54 +0000
Subject: Re: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
To:     "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephen MacNeil <macneisj@gmail.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
References: <CALWF37bJU92DxcD4VhBxbS+X+EUv-UW2oY-ogwMyNyGAnn=0WA@mail.gmail.com>
 <309288ec-27ac-0321-dce5-e9ba2bbab7ed@redhat.com>
 <BN9PR12MB505286920B83D4C71AC81E3CA0EE9@BN9PR12MB5052.namprd12.prod.outlook.com>
From:   Basavaraj Natikar <bnatikar@amd.com>
Message-ID: <e11ce06f-8a5d-345a-5113-dd8802e9a0b9@amd.com>
Date:   Mon, 2 Aug 2021 15:04:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <BN9PR12MB505286920B83D4C71AC81E3CA0EE9@BN9PR12MB5052.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::28) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.90.200] (165.204.159.242) by PN2PR01CA0173.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:26::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21 via Frontend Transport; Mon, 2 Aug 2021 09:34:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93704a3a-b7b8-4cd4-1a9d-08d95598c8d4
X-MS-TrafficTypeDiagnostic: DM4PR12MB5038:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB50386EB060B8C72D83801CB7E6EF9@DM4PR12MB5038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i47viX+AS4KQa1lCmoD7YFXWr5WwOCmYcW0XfzxbhdppGnP9PPtdZx96ipZBIR+UhmgIqCVlz9T/aC6Zv7XEIBJoWk8uq1fFklsd9weOTkGRJ1SV28Hhmw6yEKq8FopCQ4hj65xOaBJ+n96v3DSFrj5HGFml5MX7o2rVtgg8z1spwbangxUKtz19uh7lM2Fu3uQcKm/6kXx6KjzEdTegKpgbk+ZEUAsGeK5eoC/KJEn/C4ksEeym63AhX3+afI4jJwD1rW3PMvZeTd7VCEwDXG5Fr3SjKstUm5I+q7mHykFJjnYP9HWUoFG6rgLuQsL9Arpv882rK/RtSYgWMMR9BcityfsF9XURB7VVCZZ2AjD8jxZARFg26lg2H7wxj6INKJxHvs6LOwgLiHumvFHlhlOhBjPyIoKq+/FVw2djv4cz87zCKl3Uqy5c0gmbTAdkfybmnwXK3fRW2GNtSGu0pvThTWtx4S0o07JW4wmbu7x1TevHVCKSgPt9cv3fAND0zQ3Z92U7VWDeL4YNmxw43rQDLx4sshuccvmPQdNS0V07d5bfveY+oyqWOPx6rbLHbw0kUJwo7v9KkEGnubfaJ6ANSWtS2skf0ZgO9m9FiRC/EavfyXY8haRCtqSZ0du8l0ly6Y8mHura3xXv4FcBj4v0RipcVl2yuIX8ZI+z35QQd+ZYjSUXrcUeIfMzs6yeJ5SlfRhvZ8zew5qRjusrJbY8TxhISwzzXSWHHVnjvTvbwIyNaM8BvuDt02q1U/Mx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(2906002)(38100700002)(5660300002)(186003)(26005)(31686004)(2616005)(956004)(83380400001)(53546011)(66946007)(66476007)(6486002)(8676002)(66556008)(30864003)(478600001)(36756003)(6666004)(45080400002)(316002)(54906003)(110136005)(16576012)(8936002)(31696002)(4326008)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXBmOGZsK0pJenUvVHl2M2EvOG1Wbm9GelQvNHRHN0UvYWdxT0RqenRFZmpz?=
 =?utf-8?B?MG8zY0hKZnNrb2NYNnNCSE42U3EwUWQ4SkV4VEVPUUIvNzg3ejVIdHhvTlZP?=
 =?utf-8?B?UTlVMlg1Slo2eGN6anlZbW1FZlJpYktqMWtqOC9uQm5UZHR6WWhRT0s5Z0xJ?=
 =?utf-8?B?Ui8weU9iWm5uNHJOZ1JLMFI2d2lWbEt0SXRSREdKNkJVM1NtMDlTbDBTOG1D?=
 =?utf-8?B?d0kzU3Q1RlJOYmNoa3MrdGVwdnVvYnJKa3gzWDZDS1NRN3p4MUMvRGFGcWtJ?=
 =?utf-8?B?aHp2b0tOM21qNFJpQVVRR1RBRXFDN3NtRWlISEIweGw5ZlFZQjZnL3U5U1N4?=
 =?utf-8?B?aEpYSHBOeS85ZnQvS0lsSEdta1dTb3FMTm5ldnJtaVNIWHl6c29Md2tkNUIx?=
 =?utf-8?B?QWUvdlloOGpqNEpLSE1zeXhSTUZ5eTJ4Y25iMXdobTBVbzVFMmlyVGhBS3dZ?=
 =?utf-8?B?UjZReGpHVXRrcmlUcjlRZFlxNi9hbHBxUnM1K1BKWU5RclJmRVl3VHZjcFJL?=
 =?utf-8?B?M29ReXZMMWJxTis5dC9FcWRMZ3RrMzF2VFdBMUNrVHhUS0FsZWRPYitxVkd4?=
 =?utf-8?B?eVhxT28vWFNJUTFtUkxxNXpwOVJCamRkTzJab21ZWTdGaTlqTkM1SFp2S1B5?=
 =?utf-8?B?d2gwVzA2bkJ2cHhQZHlHVHVJaldEcFB0aDBEQlk2NnlScGJyeGlzTlljOXhQ?=
 =?utf-8?B?OVFheDZlTGI4NVhsejJDT1ErK3J2dVMyeVpYOWtJL25CdXpoOThOTEpialJj?=
 =?utf-8?B?NXFzRi9Sb2F3VkVHTi8zb1E2YkxRaGhIMTl6Y1dWYWlFR3Zsb1IxcUJHYlNF?=
 =?utf-8?B?UDZlUGM5d2NWSmZ6bThuV2N0TkJWbzZneUZmNU5jUVN1cTg5dEs3aTNPOS9p?=
 =?utf-8?B?Ti9hRVY0Q0wySnJ4dDVtL1oxQWxqK1YzNUNJb3g0dWRGN3diZEJnUGtvZ2xN?=
 =?utf-8?B?M0d1K2xDMWhZQlBOTm5KeEN1ck1TV3dTeFRIZmkzMXM4QjFXSmxwVVZxRnNX?=
 =?utf-8?B?TS9nQmpjenBOc1g3TXBqNkY2YjB1UDViUGNRZ1o1UEQ0eWxXUEN3SmdhK3o5?=
 =?utf-8?B?Sktkakc4ckEwM1dRSzNReUl6KzFJa0t5TC9WQlA1aDVtd1hkQTZwaW1rZGFn?=
 =?utf-8?B?bVk0WFR3NituVHNpazJYQ3Y5bVpXSUxOMzRyaEpvaU91UmxRV3Y0MzNONld6?=
 =?utf-8?B?YnlEbXk0SW9iZ3pSdUJJdGFmMmN0YityYWI4RFo2andRdDBzbXcxdHlWK21n?=
 =?utf-8?B?OWhxK0FEU2hEelZBNzYwRDBZam9nd2pDVExiZ2U4N1NRb2pvMjl0UzNHT01H?=
 =?utf-8?B?NWNPbW53MUJaWmQ5VHA2c3ZwQVEvQldvaHZWc1lPamJxdXp0ejllcm05SWNT?=
 =?utf-8?B?aVh2bVQwTmhmd2hZOW5IdkpJUjFLUHVLZ01qUENDSk4yd3BjaGYzRHVNWmph?=
 =?utf-8?B?Nit1dThJRWYzQjl2UlhPYnJ3YjUyOTFaT1Z3M2UxRjE2cDRPNkoyaE1Wc3RU?=
 =?utf-8?B?L3czQzZ4UWkyTFQ3K0xUZnNmU3RFYmNheHlSaGlIVDA1VVJiOGxXNTFzTnU3?=
 =?utf-8?B?aS9WOUNwblFuTDZLdGtBczFZTUgwR1dXWXJEc0JnYThYemo4d0M1NFc4MURN?=
 =?utf-8?B?RjZNK0s4c0FJV2dyVGE0T1FiT2FnemxaVzhaOGwxd1VIUlc5NjBFRlBtWjYy?=
 =?utf-8?B?T3pLY1lKWC9JL2xaS290MldkaGs5WFVVSDVBYVJkMUxzZGZTZnBva01zVk1P?=
 =?utf-8?Q?DBvqgBn4zNkqriFPELGH5yfn+dhc37wmu9KRSfJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93704a3a-b7b8-4cd4-1a9d-08d95598c8d4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 09:34:54.6829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUUpTr05hLXtmtmq2rSoPJY5WQ7XWmesLCbcsLbrPtvgCKLlir8aM0mPfAZxUsf18ItJbqhjm0/NMhSIh8ZVpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5038
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 8/1/2021 5:15 PM, Shah, Nehal-bakulchandra wrote:
> [AMD Official Use Only]
>
> Adding few more folks
>
> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com> 
> Sent: Sunday, August 1, 2021 3:17 PM
> To: Stephen MacNeil <macneisj@gmail.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Rafael J . Wysocki <rjw@rjwysocki.net>
> Cc: Linux PM <linux-pm@vger.kernel.org>; linux-acpi <linux-acpi@vger.kernel.org>
> Subject: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
>
> Hi Rafael, Mario,
>
> Stephen is having an issue with a recent AMD laptop (a Lenovo Ideapad model) where Linux defaults to using S3/deep suspend instead of S0ix/s2idle.

Hi Hans, Et al.

Looks like the Lenovo platform Stephen MacNeil is using does not support the S2Idle as the FADT flags as not set (looking at the output of the script).

If sensors are not working after ACPI S3 resume, I am suspecting that it could be because the PM support is missing in the amd-sfh driver
(which is already WIP from my side).

Thanks,
Basavaraj

> This is causing the sensors provided by the AMD Sensor Fusion Hub to stop working after a suspend/resume. Adding mem_sleep_default=s2idle to the kernel commandline fixes this.
>
> Do you have any idea what might be causing this ?
>
> Regards,
>
> Hans
>
>
>
> On 7/31/21 2:31 PM, Stephen MacNeil wrote:
>> I wrote Basavaraj Natikar the new maintainer of amd_sfh for the kernel, after sending the information he wanted his reply was...
>>
>>>> Thanks Stephen MacNeil,
>> On our hardware we do not see any amd_sfh issue with 5.14.0-rc2 kernel.
>>  
>> Could you please check with Lenovo, as we are not observing amd_sfh issue on our reference platforms too.
>>
>> Thanks,
>> Basavaraj
>> <<
>> looking at the information I sent him  i looks like the issue is (to 
>> me anyway)
>>
>> cat /sys/power/mem_sleep
>> [s2idle] deep
>>
>> without
>> cat /sys/power/mem_sleep
>> s2idle [deep]
>>
>>
>> this is the info he requested... any idea who else I can contact.
>> this is the output with and without the kernel param
>>
>>  
>>
>> Thanks a lot Stephen MacNeil  for the information.
>>
>>  
>>
>> Could you please provide me below information:-
>>
>> ·  what version of kernel is running.
>>
>> uname -a
>> Linux ideapad 5.14.0-051400rc2-generic #202107182230 SMP Sun Jul 18 
>> 22:34:12 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>
>>
>> ·  Are you using latest patches from amd-sfh
>>
>> only the kernel
>>
>> ·  Could you please provide me output of /sys/power/mem_sleep
>>
>> with kernel option mem_sleep_default=s2idle
>>
>> cat /sys/power/mem_sleep
>> [s2idle] deep
>>
>> without
>> cat /sys/power/mem_sleep
>> s2idle [deep]
>>
>> ·  Could you please provide output of below script after installing 
>> "apt install iasl*". acpica-tools
>>
>> with kernel option mem_sleep_default=s2idle
>>
>> Intel ACPI Component Architecture
>> ASL+ Optimizing Compiler/Disassembler version 20190509
>> Copyright (c) 2000 - 2019 Intel Corporation
>>
>> File appears to be binary: found 265 non-ASCII characters, 
>> disassembling Binary file appears to be a valid ACPI table, 
>> disassembling Input file apic.dat, Length 0x138 (312) bytes
>> ACPI: APIC 0x0000000000000000 000138 (v02 LENOVO CB-01    00000000 
>> LENO 00000001) Acpi Data Table [APIC] decoded Formatted output:  
>> apic.dsl - 16071 bytes File appears to be binary: found 40 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file batb.dat, Length 0x4A (74) bytes
>> ACPI: BATB 0x0000000000000000 00004A (v02 LENOVO CB-01    00000000 
>> LENO 00000001) Unknown ACPI table signature [BATB], decoding ACPI 
>> table header only Acpi Data Table [BATB] decoded Formatted output:  
>> batb.dsl - 1274 bytes File appears to be binary: found 31 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file bgrt.dat, Length 0x38 (56) bytes
>> ACPI: BGRT 0x0000000000000000 000038 (v01 LENOVO CB-01    00000002 
>> LENO 00000001) Acpi Data Table [BGRT] decoded Formatted output:  
>> bgrt.dsl - 1606 bytes File appears to be binary: found 16 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file cdit.dat, Length 0x29 (41) bytes
>> ACPI: CDIT 0x0000000000000000 000029 (v01 LENOVO CB-01    00000001 
>> LENO 00000001) Unknown ACPI table signature [CDIT], decoding ACPI 
>> table header only Acpi Data Table [CDIT] decoded Formatted output:  
>> cdit.dsl - 1115 bytes File appears to be binary: found 2765 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file crat.dat, Length 0xB80 (2944) bytes
>> ACPI: CRAT 0x0000000000000000 000B80 (v01 LENOVO CB-01    00000001 
>> LENO 00000001) Unknown ACPI table signature [CRAT], decoding ACPI 
>> table header only Acpi Data Table [CRAT] decoded Formatted output:  
>> crat.dsl - 15424 bytes File appears to be binary: found 15189 
>> non-ASCII characters, disassembling Binary file appears to be a valid 
>> ACPI table, disassembling Input file dsdt.dat, Length 0xAE9B (44699) 
>> bytes
>> ACPI: DSDT 0x0000000000000000 00AE9B (v01 LENOVO AMD      00001000 
>> INTL 20180313) Pass 1 parse of [DSDT] Pass 2 parse of [DSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    dsdt.dsl - 384071 bytes File appears to be binary: 
>> found 229 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file facp.dat, Length 0x10C 
>> (268) bytes
>> ACPI: FACP 0x0000000000000000 00010C (v05 LENOVO CB-01    00000003 
>> LENO 00000001) Acpi Data Table [FACP] decoded Formatted output:  
>> facp.dsl - 10098 bytes File appears to be binary: found 59 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file facs.dat, Length 0x40 (64) bytes
>> ACPI: FACS 0x0000000000000000 000040
>> Acpi Data Table [FACS] decoded
>> Formatted output:  facs.dsl - 1368 bytes File appears to be binary: 
>> found 28 non-ASCII characters, disassembling Binary file appears to be 
>> a valid ACPI table, disassembling Input file fpdt.dat, Length 0x34 
>> (52) bytes
>> ACPI: FPDT 0x0000000000000000 000034 (v01 LENOVO CB-01    00000002 
>> LENO 00000001) Acpi Data Table [FPDT] decoded Formatted output:  
>> fpdt.dsl - 1452 bytes File appears to be binary: found 30 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file hpet.dat, Length 0x38 (56) bytes
>> ACPI: HPET 0x0000000000000000 000038 (v01 LENOVO CB-01    00000001 
>> LENO 00000001) Acpi Data Table [HPET] decoded Formatted output:  
>> hpet.dsl - 1865 bytes File appears to be binary: found 279 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file ivrs.dat, Length 0x1A4 (420) bytes
>> ACPI: IVRS 0x0000000000000000 0001A4 (v02 LENOVO CB-01    00000001 
>> LENO 00000001) Acpi Data Table [IVRS] decoded Formatted output:  
>> ivrs.dsl - 6001 bytes File appears to be binary: found 36 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file mcfg.dat, Length 0x3C (60) bytes
>> ACPI: MCFG 0x0000000000000000 00003C (v01 LENOVO CB-01    00000001 
>> LENO 00000001) Acpi Data Table [MCFG] decoded Formatted output:  
>> mcfg.dsl - 1526 bytes File appears to be binary: found 32 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file msdm.dat, Length 0x55 (85) bytes
>> ACPI: MSDM 0x0000000000000000 000055 (v03 LENOVO CB-01    00000000 
>> LENO 00000001) Acpi Data Table [MSDM] decoded Formatted output:  
>> msdm.dsl - 1557 bytes File appears to be binary: found 25 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file sbst.dat, Length 0x30 (48) bytes
>> ACPI: SBST 0x0000000000000000 000030 (v01 LENOVO CB-01    00000001 
>> LENO 00000001) Acpi Data Table [SBST] decoded Formatted output:  
>> sbst.dsl - 1282 bytes File appears to be binary: found 410 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file ssdt10.dat, Length 0x47F (1151) bytes
>> ACPI: SSDT 0x0000000000000000 00047F (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt10.dsl - 5673 bytes File appears to be binary: 
>> found 708 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt11.dat, Length 
>> 0xC1D (3101) bytes
>> ACPI: SSDT 0x0000000000000000 000C1D (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt11.dsl - 15424 bytes File appears to be binary: 
>> found 848 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt12.dat, Length 
>> 0x9AD (2477) bytes
>> ACPI: SSDT 0x0000000000000000 0009AD (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt12.dsl - 12474 bytes File appears to be binary: 
>> found 9207 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt1.dat, Length 
>> 0x7216 (29206) bytes
>> ACPI: SSDT 0x0000000000000000 007216 (v02 LENOVO AmdTable 00000002 
>> MSFT 04000000) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt1.dsl - 208699 bytes File appears to be binary: 
>> found 3968 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt2.dat, Length 
>> 0x1500 (5376) bytes
>> ACPI: SSDT 0x0000000000000000 001500 (v01 LENOVO AmdTable 00000001 AMD  
>> 00000001) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt2.dsl - 59265 bytes File appears to be binary: 
>> found 449 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt3.dat, Length 
>> 0x53A (1338) bytes
>> ACPI: SSDT 0x0000000000000000 00053A (v01 LENOVO Tpm2Tabl 00009999 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt3.dsl - 10738 bytes File appears to be binary: 
>> found 474 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt4.dat, Length 
>> 0x64C (1612) bytes
>> ACPI: SSDT 0x0000000000000000 00064C (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt4.dsl - 8258 bytes
>> File appears to be binary: found 400 non-ASCII characters, 
>> disassembling Binary file appears to be a valid ACPI table, 
>> disassembling Input file ssdt5.dat, Length 0x480 (1152) bytes
>> ACPI: SSDT 0x0000000000000000 000480 (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt5.dsl - 5582 bytes
>> File appears to be binary: found 1140 non-ASCII characters, 
>> disassembling Binary file appears to be a valid ACPI table, 
>> disassembling Input file ssdt6.dat, Length 0x1497 (5271) bytes
>> ACPI: SSDT 0x0000000000000000 001497 (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt6.dsl - 20293 bytes File appears to be binary: 
>> found 1314 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt7.dat, Length 
>> 0x1576 (5494) bytes
>> ACPI: SSDT 0x0000000000000000 001576 (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt7.dsl - 30076 bytes File appears to be binary: 
>> found 4095 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt8.dat, Length 
>> 0x353C (13628) bytes
>> ACPI: SSDT 0x0000000000000000 00353C (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt8.dsl - 78242 bytes File appears to be binary: 
>> found 74 non-ASCII characters, disassembling Binary file appears to be 
>> a valid ACPI table, disassembling Input file ssdt9.dat, Length 0x90 
>> (144) bytes
>> ACPI: SSDT 0x0000000000000000 000090 (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt9.dsl - 1767 bytes
>> File appears to be binary: found 32 non-ASCII characters, 
>> disassembling Binary file appears to be a valid ACPI table, 
>> disassembling Input file tpm2.dat, Length 0x38 (56) bytes
>> ACPI: TPM2 0x0000000000000000 000038 (v04 LENOVO CB-01    00000002 
>> LENO 00000001) Acpi Data Table [TPM2] decoded Formatted output:  
>> tpm2.dsl - 1515 bytes File appears to be binary: found 189 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file uefi.dat, Length 0x12A (298) bytes
>> ACPI: UEFI 0x0000000000000000 00012A (v01 LENOVO CB-01    00000001 
>> LENO 00000001) Acpi Data Table [UEFI] decoded Formatted output:  
>> uefi.dsl - 2505 bytes File appears to be binary: found 37100 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file vfct.dat, Length 0xD484 (54404) bytes
>> ACPI: VFCT 0x0000000000000000 00D484 (v01 LENOVO CB-01    00000001 
>> LENO 00000001) Unknown ACPI table signature [VFCT], decoding ACPI 
>> table header only Acpi Data Table [VFCT] decoded Formatted output:  
>> vfct.dsl - 269557 bytes File appears to be binary: found 17 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file wsmt.dat, Length 0x28 (40) bytes
>> ACPI: WSMT 0x0000000000000000 000028 (v01 LENOVO CB-01    00000000 
>> LENO 00000001) Acpi Data Table [WSMT] decoded Formatted output:  
>> wsmt.dsl - 1313 bytes Low Power S0 Idle is 0 The system does not 
>> support S0ix!
>>
>>
>> without
>>
>> Intel ACPI Component Architecture
>> ASL+ Optimizing Compiler/Disassembler version 20190509
>> Copyright (c) 2000 - 2019 Intel Corporation
>>
>> File appears to be binary: found 265 non-ASCII characters, 
>> disassembling Binary file appears to be a valid ACPI table, 
>> disassembling Input file apic.dat, Length 0x138 (312) bytes
>> ACPI: APIC 0x0000000000000000 000138 (v02 LENOVO CB-01    00000000 
>> LENO 00000001) Acpi Data Table [APIC] decoded Formatted output:  
>> apic.dsl - 16071 bytes File appears to be binary: found 40 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file batb.dat, Length 0x4A (74) bytes
>> ACPI: BATB 0x0000000000000000 00004A (v02 LENOVO CB-01    00000000 
>> LENO 00000001) Unknown ACPI table signature [BATB], decoding ACPI 
>> table header only Acpi Data Table [BATB] decoded Formatted output:  
>> batb.dsl - 1274 bytes File appears to be binary: found 31 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file bgrt.dat, Length 0x38 (56) bytes
>> ACPI: BGRT 0x0000000000000000 000038 (v01 LENOVO CB-01    00000002 
>> LENO 00000001) Acpi Data Table [BGRT] decoded Formatted output:  
>> bgrt.dsl - 1606 bytes File appears to be binary: found 16 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file cdit.dat, Length 0x29 (41) bytes
>> ACPI: CDIT 0x0000000000000000 000029 (v01 LENOVO CB-01    00000001 
>> LENO 00000001) Unknown ACPI table signature [CDIT], decoding ACPI 
>> table header only Acpi Data Table [CDIT] decoded Formatted output:  
>> cdit.dsl - 1115 bytes File appears to be binary: found 2765 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file crat.dat, Length 0xB80 (2944) bytes
>> ACPI: CRAT 0x0000000000000000 000B80 (v01 LENOVO CB-01    00000001 
>> LENO 00000001) Unknown ACPI table signature [CRAT], decoding ACPI 
>> table header only Acpi Data Table [CRAT] decoded Formatted output:  
>> crat.dsl - 15424 bytes File appears to be binary: found 15189 
>> non-ASCII characters, disassembling Binary file appears to be a valid 
>> ACPI table, disassembling Input file dsdt.dat, Length 0xAE9B (44699) 
>> bytes
>> ACPI: DSDT 0x0000000000000000 00AE9B (v01 LENOVO AMD      00001000 
>> INTL 20180313) Pass 1 parse of [DSDT] Pass 2 parse of [DSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    dsdt.dsl - 384071 bytes File appears to be binary: 
>> found 229 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file facp.dat, Length 0x10C 
>> (268) bytes
>> ACPI: FACP 0x0000000000000000 00010C (v05 LENOVO CB-01    00000003 
>> LENO 00000001) Acpi Data Table [FACP] decoded Formatted output:  
>> facp.dsl - 10098 bytes File appears to be binary: found 59 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file facs.dat, Length 0x40 (64) bytes
>> ACPI: FACS 0x0000000000000000 000040
>> Acpi Data Table [FACS] decoded
>> Formatted output:  facs.dsl - 1368 bytes File appears to be binary: 
>> found 28 non-ASCII characters, disassembling Binary file appears to be 
>> a valid ACPI table, disassembling Input file fpdt.dat, Length 0x34 
>> (52) bytes
>> ACPI: FPDT 0x0000000000000000 000034 (v01 LENOVO CB-01    00000002 
>> LENO 00000001) Acpi Data Table [FPDT] decoded Formatted output:  
>> fpdt.dsl - 1452 bytes File appears to be binary: found 30 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file hpet.dat, Length 0x38 (56) bytes
>> ACPI: HPET 0x0000000000000000 000038 (v01 LENOVO CB-01    00000001 
>> LENO 00000001) Acpi Data Table [HPET] decoded Formatted output:  
>> hpet.dsl - 1865 bytes File appears to be binary: found 279 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file ivrs.dat, Length 0x1A4 (420) bytes
>> ACPI: IVRS 0x0000000000000000 0001A4 (v02 LENOVO CB-01    00000001 
>> LENO 00000001) Acpi Data Table [IVRS] decoded Formatted output:  
>> ivrs.dsl - 6001 bytes File appears to be binary: found 36 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file mcfg.dat, Length 0x3C (60) bytes
>> ACPI: MCFG 0x0000000000000000 00003C (v01 LENOVO CB-01    00000001 
>> LENO 00000001) Acpi Data Table [MCFG] decoded Formatted output:  
>> mcfg.dsl - 1526 bytes File appears to be binary: found 32 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file msdm.dat, Length 0x55 (85) bytes
>> ACPI: MSDM 0x0000000000000000 000055 (v03 LENOVO CB-01    00000000 
>> LENO 00000001) Acpi Data Table [MSDM] decoded Formatted output:  
>> msdm.dsl - 1557 bytes File appears to be binary: found 25 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file sbst.dat, Length 0x30 (48) bytes
>> ACPI: SBST 0x0000000000000000 000030 (v01 LENOVO CB-01    00000001 
>> LENO 00000001) Acpi Data Table [SBST] decoded Formatted output:  
>> sbst.dsl - 1282 bytes File appears to be binary: found 410 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file ssdt10.dat, Length 0x47F (1151) bytes
>> ACPI: SSDT 0x0000000000000000 00047F (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt10.dsl - 5673 bytes File appears to be binary: 
>> found 708 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt11.dat, Length 
>> 0xC1D (3101) bytes
>> ACPI: SSDT 0x0000000000000000 000C1D (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt11.dsl - 15424 bytes File appears to be binary: 
>> found 848 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt12.dat, Length 
>> 0x9AD (2477) bytes
>> ACPI: SSDT 0x0000000000000000 0009AD (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt12.dsl - 12474 bytes File appears to be binary: 
>> found 9207 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt1.dat, Length 
>> 0x7216 (29206) bytes
>> ACPI: SSDT 0x0000000000000000 007216 (v02 LENOVO AmdTable 00000002 
>> MSFT 04000000) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt1.dsl - 208699 bytes File appears to be binary: 
>> found 3968 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt2.dat, Length 
>> 0x1500 (5376) bytes
>> ACPI: SSDT 0x0000000000000000 001500 (v01 LENOVO AmdTable 00000001 AMD  
>> 00000001) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt2.dsl - 59265 bytes File appears to be binary: 
>> found 449 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt3.dat, Length 
>> 0x53A (1338) bytes
>> ACPI: SSDT 0x0000000000000000 00053A (v01 LENOVO Tpm2Tabl 00009999 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt3.dsl - 10738 bytes File appears to be binary: 
>> found 474 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt4.dat, Length 
>> 0x64C (1612) bytes
>> ACPI: SSDT 0x0000000000000000 00064C (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt4.dsl - 8258 bytes
>> File appears to be binary: found 400 non-ASCII characters, 
>> disassembling Binary file appears to be a valid ACPI table, 
>> disassembling Input file ssdt5.dat, Length 0x480 (1152) bytes
>> ACPI: SSDT 0x0000000000000000 000480 (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt5.dsl - 5582 bytes
>> File appears to be binary: found 1140 non-ASCII characters, 
>> disassembling Binary file appears to be a valid ACPI table, 
>> disassembling Input file ssdt6.dat, Length 0x1497 (5271) bytes
>> ACPI: SSDT 0x0000000000000000 001497 (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt6.dsl - 20293 bytes File appears to be binary: 
>> found 1314 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt7.dat, Length 
>> 0x1576 (5494) bytes
>> ACPI: SSDT 0x0000000000000000 001576 (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt7.dsl - 30076 bytes File appears to be binary: 
>> found 4095 non-ASCII characters, disassembling Binary file appears to 
>> be a valid ACPI table, disassembling Input file ssdt8.dat, Length 
>> 0x353C (13628) bytes
>> ACPI: SSDT 0x0000000000000000 00353C (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt8.dsl - 78242 bytes File appears to be binary: 
>> found 74 non-ASCII characters, disassembling Binary file appears to be 
>> a valid ACPI table, disassembling Input file ssdt9.dat, Length 0x90 
>> (144) bytes
>> ACPI: SSDT 0x0000000000000000 000090 (v01 LENOVO AmdTable 00000001 
>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>>
>> Parsing completed
>> Disassembly completed
>> ASL Output:    ssdt9.dsl - 1767 bytes
>> File appears to be binary: found 32 non-ASCII characters, 
>> disassembling Binary file appears to be a valid ACPI table, 
>> disassembling Input file tpm2.dat, Length 0x38 (56) bytes
>> ACPI: TPM2 0x0000000000000000 000038 (v04 LENOVO CB-01    00000002 
>> LENO 00000001) Acpi Data Table [TPM2] decoded Formatted output:  
>> tpm2.dsl - 1515 bytes File appears to be binary: found 189 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file uefi.dat, Length 0x12A (298) bytes
>> ACPI: UEFI 0x0000000000000000 00012A (v01 LENOVO CB-01    00000001 
>> LENO 00000001) Acpi Data Table [UEFI] decoded Formatted output:  
>> uefi.dsl - 2505 bytes File appears to be binary: found 37100 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file vfct.dat, Length 0xD484 (54404) bytes
>> ACPI: VFCT 0x0000000000000000 00D484 (v01 LENOVO CB-01    00000001 
>> LENO 00000001) Unknown ACPI table signature [VFCT], decoding ACPI 
>> table header only Acpi Data Table [VFCT] decoded Formatted output:  
>> vfct.dsl - 269557 bytes File appears to be binary: found 17 non-ASCII 
>> characters, disassembling Binary file appears to be a valid ACPI 
>> table, disassembling Input file wsmt.dat, Length 0x28 (40) bytes
>> ACPI: WSMT 0x0000000000000000 000028 (v01 LENOVO CB-01    00000000 
>> LENO 00000001) Acpi Data Table [WSMT] decoded Formatted output:  
>> wsmt.dsl - 1313 bytes Low Power S0 Idle is 0 The system does not 
>> support S0ix!
>>
>>
>> #################################################
>> #!/bin/bash
>>
>> cd /var/tmp/
>>
>> acpidump -b
>>
>> iasl -d *.dat
>>
>> lp=$(grep "Low Power S0 Idle" /var/tmp/facp.dsl | awk '{print $(NF)}')
>>
>> if [ "$lp" -eq 1 ]; then
>>
>> echo "Low Power S0 Idle is" $lp
>>
>> echo "The system supports S0ix!"
>>
>> else
>>
>> echo "Low Power S0 Idle is" $lp
>>
>> echo "The system does not support S0ix!"
>>
>> fi
>>
>>  
>>
>> Thanks,
>>
>> Basavaraj
>>
>>
>>
>>
>> --
>> Stephen MacNeil
>> 905 334 5092
>> mglessons.com 
>> <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fmglessons.com%2F&amp;data=04%7C01%7CNehal-bakulchandra.Shah%40amd.com%7C64a299468a7047508e7308d954d15362%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637634080305647130%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=deJr%2FVlbHHTyu%2BYTUma%2BpVhmAMtF%2B968z1hIai%2Bpdug%3D&amp;reserved=0>
