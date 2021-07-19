Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B1F3CD5C7
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jul 2021 15:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbhGSMzM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Jul 2021 08:55:12 -0400
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:18137
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238836AbhGSMzM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Jul 2021 08:55:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiFeQ/Q6y4FAFO5Nq/s25HatfsWatP4XFHf3O/i8FKXhkBbBCkiLU7F9KzzQWh3cjsI3RsD5M9jyQfFCcSgZK3bFQ+zAJ8x7piW9QzWAhmBpGPR0KnhbiPFTHT0Dn6gbUNVVrFjOCRxj5UcnHmGP/QmN/pBVo21p1OvQgg1ml2LcS9aWM8iIn6Ol19ozlsp33efNojDSDRXjma+jvXOebS18BGamzAj8MkV28k6njky5dvDA0Dzyw1nuOjeCJ19KDzzHu3xd4SUEdDZ1SrSYVvLlnYgN8jfliR675XgXA2Z4AVFQ/XsD2eElnkBE2KgXbLziZxv03DOwJl3IqdQ/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1xnb1SJjuCt9fznyQWxdbt8pAD6vg0RUKSFO03746I=;
 b=e4VabEFXuSJn9YUtskbdF/V0hOrw3TTFFrRI/KiCL+OAHA5kpCpEQM+6S529Bg69rjxM6t2S1M49+uD9GObK7wNuKuRvabraxVi2aT+NJlVwW2IqphAR1UTkPSkxUS2808XT0wT6Pvo1d8y3mDU11p5SFKFb8dyFutMANHe9eKhwpeQcTp4ScwtlD6aIuh/ccwdVYfYjk4TnGBJZ9PXjWbJjDeHY+z5nByfnQVBBMHKdyZFp4Y+mqeeoy4JRzff4RHZUIMjUzXZEeEYLdMVgJN7S/9LM6oFQXSAOOTd5EFwHVMIaECHmTn+S+VMa8mTVTFli7wmEOnle0Y9Os5C5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1xnb1SJjuCt9fznyQWxdbt8pAD6vg0RUKSFO03746I=;
 b=ljbOMDHnME737nG5Lw1yVxCrnZpHKim/Up+shUOypaNDNivWik6T4kZsLzDcqx1OfnaxFPLCO/4xnX3uP8z58qWVvc+eEEKbuDQTP8ABUe0PNhAsT7owZT/DvsagQE8NqfauTxfu3UUK2XjE+CVBHQMa8QqU3IcJgDw8iKdDa3Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 13:35:50 +0000
Received: from DM6PR12MB4499.namprd12.prod.outlook.com
 ([fe80::c092:6a5e:146:c1a5]) by DM6PR12MB4499.namprd12.prod.outlook.com
 ([fe80::c092:6a5e:146:c1a5%9]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 13:35:50 +0000
Subject: Re: [PATCH] ACPI: PM: Add support for upcoming AMD uPEP HID AMDI007
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        stable@kernel.org
References: <20210718041138.4739-1-mario.limonciello@amd.com>
 <CAJZ5v0iOV-E2V=XvLDmwPXpBEsywe2me58LbX2PxuJdDUCG7Qw@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <ceb36e73-0014-704c-d0b2-fc7c2a0def46@amd.com>
Date:   Mon, 19 Jul 2021 08:35:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAJZ5v0iOV-E2V=XvLDmwPXpBEsywe2me58LbX2PxuJdDUCG7Qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0077.namprd12.prod.outlook.com
 (2603:10b6:802:20::48) To DM6PR12MB4499.namprd12.prod.outlook.com
 (2603:10b6:5:2ab::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.185.221] (165.204.77.1) by SN1PR12CA0077.namprd12.prod.outlook.com (2603:10b6:802:20::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 13:35:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dcc3add-c0e0-4231-dc4b-08d94aba1f63
X-MS-TrafficTypeDiagnostic: DM6PR12MB4497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4497B081B6A1D8FE40E68A6EE2E19@DM6PR12MB4497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAjgIgcj39dvOEzcyQARAQyyUxNZ8m1c2tyY3o/9DHZ5ZWrV2JsMbS+Yc0eQE1nvHU0R5ywjgxgjWXtPiSbNCzqm9E441XHU4TI3na2OUr1XmcCNF6dhpFjowlHVp5zjpiHZIk4b/cQkgC1g0DGci/jV8XoVdvs63L3TirjEPIYCS4NRcU4k2LlQu4YWUxhOp+j3uMDHshtA2cBlo08ZxAbalPnuQjt20F+DZA1ezZXawZqO9aRDHWYwaThusmyiimG6DtS96ga145zn4yPwjplUAzUddy4++GflJ4HTbjKdRkkATMUR2t3WEKmG45Tk0s16NP5ynlvFj+gXMX4P/NH/OGLfiqtez8hkGTdADFK44X1DQyKJWjJahyDpOO8lwYjfwcuiBUGwDUDpXya+KZ0cacpo11NLReEXu4sPiKFTrmKTO7gC8OHqIS1hd2e1POO1FgAUDB0QaFBVAu7hPBEFWUhD4Bn7Sjb6dWJXj3vcsOSjWZlXnd9AgdFEDr4icFnTkJmKPEAw8wUOX8El0eVe3E0TX1Wd18P5ej28ZPKr4vFLqsPLaQDU16bzJRedKN1t040+qWhvjM7ofi434CTysWMsApOQPgeJQQ9Yj0AJWePn0D6/hqaBHzWmbj8dqL5qKwgJUR6R0CUU8dZIXHuYhMsNVThHsBzZjgm+L3Xlcji59Ao0ELUTfhrLJbJDcupoV7YTkjuAA4obJvfoENPauUSSWaNvqV+S9K23lhHtCrM3FJaZEVvgRoI++J/C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4499.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(66556008)(66476007)(26005)(45080400002)(4326008)(31696002)(2906002)(186003)(6486002)(316002)(6916009)(478600001)(86362001)(54906003)(16576012)(66946007)(8936002)(31686004)(2616005)(8676002)(5660300002)(53546011)(956004)(38100700002)(6666004)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnA5WGZ5V3hHaytzakRPV3drWk84MmJVcGM2Sll5YVkvVXhIM0xXb1NWbjdm?=
 =?utf-8?B?OWxEVjQraU5OSC9XM2lqUmJoQ2cyQTc0Y2ZkdlFwVDVmYmJrZGZNMjlsRE1n?=
 =?utf-8?B?WDB4Z1owcEtQYjlUYnBnMmFkcGJyWVN3N2JldEkrY05BSm56SVpRaTB0MU5s?=
 =?utf-8?B?MEhleWtpMlN6NnZPbkdaR3dmYk9aYVhqbGxXZjNkOENVb1JabFV6NjVYMUJ6?=
 =?utf-8?B?ZVhPSTVLMEdqakM5b0g5VFExWDJ3UFdmTm5aREZOZmxnZENvWUJuTjVQcFY1?=
 =?utf-8?B?Ull2VzdTck40Yml6VDh2Y1Q4VXZJc284NVl3MzBqVWdsdHo5NHRTbjI4OStv?=
 =?utf-8?B?cVdCdFAxWTlYUGtlbWFsbGFYWFFwaVFiOXR1cmRoeTR4OHFVZi85RjVScFdu?=
 =?utf-8?B?Zko3WjRBcmhPbko2RGMwVFlMR0FTTkxWRlFkcmxoTWlKQUZVUUdmSjBwQ3hx?=
 =?utf-8?B?RUp5cXhqcjR6Z2FPT0lqSktyZ3YxcGVscVZSdkRheS9FMHFsb3MxYk56WVF1?=
 =?utf-8?B?YThyRnBPdmM5VDJ1aWpZRFg1bEltVlNNWVdrK2l4Ym1yWnJrelRrSzI2V0xQ?=
 =?utf-8?B?eWNOWGlqWjE2TWlPL1dXcnBKaXM0M1BVR2ZWckVLTDVQVFVrTWdBZlBiWWFz?=
 =?utf-8?B?bGhoRUxoREtnam4ySlJNVEhSVTZwYkVxYkVubmFucGdJMVRjMmNxNVFUZFJo?=
 =?utf-8?B?eEl0UXRkcytoL09VYlovQ01HOGJISncrMlZUY3VJTUZLZnpVK3IzcUFyVk5S?=
 =?utf-8?B?c1VSYVVEbWNqalFoMjk1QlpWRzNxM0N4ckhOOTRuY1FidE9LckJzK2hWVG5V?=
 =?utf-8?B?alJJNjBwY2F4T0hMQWJoQlpaRk1LMnZ5c1FlZUFEOXBxMWNaLy81aXRxVFVw?=
 =?utf-8?B?dGRhK0pmeURTd0JlTFFEMVJnRzNrcHovbUJQVldmRlBhUGQyRXVyYWRNS2Vo?=
 =?utf-8?B?dlRPcFplVUxyU1cxaXh4ZEZ4ekpnSFdpdGJ1WGUzWHJoZ3BtM29ua09OT1dr?=
 =?utf-8?B?UFA2WWl2ZmZPRERJTHNIdEkzYXVXQVdSQTZ1UERMNEQ1OXpESXFFQTZyWWh0?=
 =?utf-8?B?Nk9zUjZuQXFoL25EaGh3VytHRldVZUlVL3FZcUVLQmhLckxxMkdPTG9Xek5T?=
 =?utf-8?B?aytJaWpFTnpITGJyMVdYOVp2NjRwQS9vSTZMbFNicU9ySHp2V0VLZU1LajJi?=
 =?utf-8?B?SVpkWWEwOFZMN3RuSU9vK2dyTzgrWUhRdmJkQVdYdUZQVnJvMEVnVXlCOW0r?=
 =?utf-8?B?WFR5Yi92NjE5Q1Zrc3dWVGRFZnJvaHBEWFRMSTRRREQ1Z0dXdDNlZDcxTmFS?=
 =?utf-8?B?bnBhNDRmbkdSMytiYVBHTXEydTBQNUltUDlNY2Mxc0d3YzZ0Tno2RG1YaDBm?=
 =?utf-8?B?ZFhSUnJkWEpqMVlHNC9ZemxOQzhFZjV1by9jM3l6aWc1UFJPeTdXTVlEYWND?=
 =?utf-8?B?RTVYbEJLOXg4SDFWd0J2T3NlcENTRTFib2VHR0h0ZUxoVGlORkxicHhSOExh?=
 =?utf-8?B?YXVNdWtDazNJU0l1S0xLUjJzb3NndXUvZFl6eVlIM3VibGU0TkVVdHdwazhI?=
 =?utf-8?B?UUxkYUY1YndJUUpHd3NRR1lCTi9Va1hqUnlzdUdyWDhLSXpNSlBLUll2WFRl?=
 =?utf-8?B?V3F5YkowdDR0OTQyT09RVTB0cTl2R245TFEycEIrVVhyRkxBNE1ReVFKM1VF?=
 =?utf-8?B?ZVU4WnpZKzRBU3haRlpsNElPMC9xMnZhVHUzSUE1c2dtOHQ2R3ZzSlp5cjZm?=
 =?utf-8?Q?fPrXoetOSA5Y96VWY4dnX7rlxdcxezAa9ko3wQP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcc3add-c0e0-4231-dc4b-08d94aba1f63
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4499.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 13:35:50.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lu/bXFnn9HZJWQm6iENX9JIXFvRGv7Wbc5ZCGKdp8tHq1hZ+ESkAFxxVeStSSuJ3BBOed+cvpCKgoSo3Y0hFwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 7/19/2021 07:09, Rafael J. Wysocki wrote:
> On Sun, Jul 18, 2021 at 6:11 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> AMD systems with uPEP HID AMDI007 should be using revision 2 and
>> the AMD method.
>>
>> CC: stable@kernel.org # v5.14
> 
> Well, what do you mean?
> 
> 5.14 is still under development.

I didn't want to presume the timing or target that you would accept 
this.  If it's still viable for 5.14, then yes that would be preferable.
Can you just remove that line from commit message?

Thanks,

> 
> 
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/x86/s2idle.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>> index 1c507804fb10..fbdbef0ab552 100644
>> --- a/drivers/acpi/x86/s2idle.c
>> +++ b/drivers/acpi/x86/s2idle.c
>> @@ -378,19 +378,25 @@ static int lps0_device_attach(struct acpi_device *adev,
>>                   * AMDI0006:
>>                   * - should use rev_id 0x0
>>                   * - function mask = 0x3: Should use Microsoft method
>> +                * AMDI0007:
>> +                * - Should use rev_id 0x2
>> +                * - Should only use AMD method
>>                   */
>>                  const char *hid = acpi_device_hid(adev);
>> -               rev_id = 0;
>> +               rev_id = strcmp(hid, "AMDI0007") ? 0 : 2;
>>                  lps0_dsm_func_mask = validate_dsm(adev->handle,
>>                                          ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
>>                  lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
>> -                                       ACPI_LPS0_DSM_UUID_MICROSOFT, rev_id,
>> +                                       ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
>>                                          &lps0_dsm_guid_microsoft);
>>                  if (lps0_dsm_func_mask > 0x3 && (!strcmp(hid, "AMD0004") ||
>>                                                   !strcmp(hid, "AMDI0005"))) {
>>                          lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
>>                          acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
>>                                            ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
>> +               } else if (lps0_dsm_func_mask_microsoft > 0 && !strcmp(hid, "AMDI0007")) {
>> +                       lps0_dsm_func_mask_microsoft = -EINVAL;
>> +                       acpi_handle_debug(adev->handle, "_DSM Using AMD method\n");
>>                  }
>>          } else {
>>                  rev_id = 1;
>> --
>> 2.25.1
>>

