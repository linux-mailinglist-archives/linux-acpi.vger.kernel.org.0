Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2493AD082
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 18:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhFRQgP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 12:36:15 -0400
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com ([40.107.236.71]:55136
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235534AbhFRQgO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Jun 2021 12:36:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2JSSf5R6ZQO2Hz4AOucyMSkZE/ghDXt5+2mLO0bSBAgR1c1v3Do+nGEVUy0Wi0AoHcuKenW0eM7zBJ93k2+v2bvqSQ7ZAC0/V5FCrK0y2z6VKeFR/3Dy/GgDHvqri6zxmRHE6zxQa3KwPO9b6pZoLiCbBmtAjDAGUJ5izpxWVmnv0gMxHxL6ORFy4pDKEVIOEIvs15ehuIU8mwiuyX3Uhjviar1Ra89iogDRRNpsILHJeXcF7h9bnMg/BR59qoT0FmVBXBIe4bSz5tIMAYsPBGmy9+F5NP8MyL+6o+eKVbHRdjcEodjH6pAC12bvtq/d+wc3jrOvaTxUApD6ofmCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ33jiFn5WTgkiYqbWV2QF0zduxx+KfeqnWiAAvXgwg=;
 b=Pv+lL8iA60cAhgPtmMn1n326xbAb4qBYEP20TYWLkvquL+avinUfDL/c7C0xVaCay1PHRA0aDB0cffoMCsqJQnehdgbMeFEGQRXy/yINOzfYjB/JALF+FukeTxhbOfYLtb36TWbG1xz8cOFagKr5LXxArA2cMNhp4S6Em5Zo7ifsPzE5k0ttrBss+jkhG2eVU6EkCzIlaZsvXEm3f3KwrXUs3YHT59IDN741wcP5VLtwV0RkPb4jzGsuksQ8t0gsgIwUhi9AH+/WZ+rOhhMvG3+pW0HIxUb0EZPxiXZHeeZN3xS6vq7NhQ6QpdKMzPrbzIpAIj7OVs4bgDVIHx2lVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ33jiFn5WTgkiYqbWV2QF0zduxx+KfeqnWiAAvXgwg=;
 b=gm98sNAmHYNP0cAQLfUhVcN0M6PbgN0Zaq6a9XlKJCmyfXGwTvHMmbzxEBXFA8lgOHEyTZvyP3LJgTJ4OO+h6qQgkAmGYzI5IICkjc8pROPNERkxg3mJGHBY5unliTpPDznu3d6pIA7Xm8J0zfP7gRrsjDF+5EQHBPoqkKpxC14=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2448.namprd12.prod.outlook.com (2603:10b6:802:28::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Fri, 18 Jun
 2021 16:34:03 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0%6]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 16:34:03 +0000
Subject: Re: [PATCH 3/5] ACPI: PM: s2idle: Add support for multiple func mask
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Julian Sikorski <belegdol@gmail.com>, teohhanhui@gmail.com,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
References: <20210617164212.584-1-mario.limonciello@amd.com>
 <20210617164212.584-3-mario.limonciello@amd.com>
 <CAJZ5v0gryewS7GFY_vBd4QAc_5hSG3PH2pZ4xyjStt7TxeCO0Q@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <5e5bef84-3bbb-05a1-1a28-e01a016007b5@amd.com>
Date:   Fri, 18 Jun 2021 11:34:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAJZ5v0gryewS7GFY_vBd4QAc_5hSG3PH2pZ4xyjStt7TxeCO0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA9PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:806:24::35) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.51.208] (165.204.77.11) by SA9PR13CA0120.namprd13.prod.outlook.com (2603:10b6:806:24::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.9 via Frontend Transport; Fri, 18 Jun 2021 16:34:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b3f2b14-a88c-41f1-1e24-08d93276e246
X-MS-TrafficTypeDiagnostic: SN1PR12MB2448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2448006C5E2D4CC2D8D0412DE20D9@SN1PR12MB2448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKMHJC3P7HTqFw6ZTlKdFjoHGZxvOKkIJedFzcX/EvsA1PCVvGUyvHBU0dCgJdHFLrAlROPlY4kA9P4TePNoiOFO2aodsySDcWSVP/BMnUaGiga9Ve+aumdsEoLKiwa/z2C1cRsmBb0E2fdg2sdFrpz805P14QNDLoLF1MqenOEIXv6tVW2h36u03OV4RiHMD7ARfWCu/VRsNqEZ9Pv286V/b0ABMcs7F/cwIMi7e1rTwymE8CLFKSkkAaqEfmH7+5sGjrkr1vf4ZwLKoOU+PCufrA6iewX6cI5w8XYe9mkSDPXWl+Q+v+FphtjBZcFdkKh54yusU/jyZ4zMQrhIhTsy6mMo1ptaYBM9m0RUyM9gcZiwfYuLMu3ca6tGiLpDJivWu083or4N1t5ChWT9K5IfsdsKAH3x+wf5t3jKdnZfByChw9FnpzwIcPPYAjEKQZEKjuHspCdw50kx8ugChV3CmgQ38fNYBS24h/LFKd1f3o0RQgl0WUDKtUzPU08XlhNwL6gopFufZOhfjk9fu4ZIZSVyVy2i4nAtzI5rJrA+//MxSXT+FAjMOz5ZY937t2msP+td89l+otGIh7OasvZvMnBKHVs5pQvNS8WppEofZDqFs/SP8otCOHkyfUbiMYwSLiaJl3eSxZamfK4Y/u5h3PvI7fzp/P6wtNKrh8B81ndXqptpwvhQPqX2GYvH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(31686004)(86362001)(8936002)(66946007)(31696002)(8676002)(5660300002)(478600001)(83380400001)(36756003)(38100700002)(66476007)(53546011)(16576012)(6916009)(2906002)(16526019)(186003)(2616005)(26005)(66556008)(4326008)(54906003)(316002)(956004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWJUbDh5VDVuckJBdExqWFlqYkl6c250d3k0VExJaUtVMXpreWJFNEQ4ZnlW?=
 =?utf-8?B?VXNtTDF3ZDBZaFhCcVRTM2pCZHo4Q3FKakFCekRCSjUrc0lTOHBaQjU1ZXph?=
 =?utf-8?B?dE9qOExFeEJmM3h4cU1SRkhGYUJPeGlmcW80bzdjNDVFNWpQeGJjRktNMzlW?=
 =?utf-8?B?Q2szeVR2ZjdaMytrWVkzcVlIY0ZFUW1iTWlZSTBucVlxWmNFVlRnNStsalFj?=
 =?utf-8?B?dnpLZVhCdGFIOURVdzdacmQxRmNKYjQ4RVVTOGJRUFpQLzBVbnJsQUw0Qzdk?=
 =?utf-8?B?bkUrRzltY2RCb1RZeEs2c1BCa1NIa1Y0cDQ3aVVGd2YzejBXM3pYNnpGQ0hK?=
 =?utf-8?B?cXA4R3lrcjJ0bWwxTG9HOWRtWlpRVlBLSFdoKzM1UmZsZ01YL2pJTHpZNzJD?=
 =?utf-8?B?TkJ3QXZFQkZGdlArdTF2bjNLdGl0cXE5R0JGenNMbUwwSnJ6aVE3QTMreVc4?=
 =?utf-8?B?ZGdIeTBXZ0g4L2gyNmxqQzVQQlY0bk1OMVE5bHEzdUxGOGd5WEdWTGxZMGRr?=
 =?utf-8?B?Q0pvR2ZxNzBEUDNOa2ZBKytZbURXSVV3TDZMTnJQL2srTTJMbmU1SWRCUUhR?=
 =?utf-8?B?Vmk2ZklzWkVaZ09HRnJYVnhuNGVUV01kNHpVZkt6WWVTUUkrY2xpQ3k3eU94?=
 =?utf-8?B?ZzJiMXNIN0tCYVVhNUZoSE1NSWgrN1llSG8xdEwrTFpaQ2hRZlJTZHlNd1Jr?=
 =?utf-8?B?OWFvelZUSEVMMDNDQncyQ3VrdFNBQmh1QTZrclFtZVlBaVJtcVpyeFFBT25N?=
 =?utf-8?B?ZkNTN0xhclpvb3Vtc3FwYythd2ZDbnNDUVl0bTFXbDRSS0t6NUhZbHZSRkZU?=
 =?utf-8?B?R1g2Q3F0NjFZZTVQb0RNUzFvWEl1cmM5OGxyZEI3NE9hUHlkalBLaVl5bE9o?=
 =?utf-8?B?VUFTNHhjTEl3a3Zobkc5NmhUNXM2RUxlRi81TWR2SExTVGdDOGIzMVcrczA0?=
 =?utf-8?B?Sy9jdWVJQUwweElKN0JGQXF0aTJrQkpNeVFhd0ZqVE9PM2FvQUdoZTFYMkZ6?=
 =?utf-8?B?VVJkNkpNMXlPK3QvSjNpQ0hTZ3BXbkZFem1rdm5NQnZVUWt3OVRjNE1aTFRR?=
 =?utf-8?B?cGROSWlsdVpydnFXN2V6NSsyWU9KbWFKZVRST0V1aWVjMW92M3c1U0hyY2sv?=
 =?utf-8?B?cWhQK09rTk5IR2NQblR4UmVmdHJTcVZhSkEzWHNWVGNNR243RlZuODJiVnhQ?=
 =?utf-8?B?ZG53YXdqTVY2MTlqazMyUkpwUXlBZmJXL3A0ZUpwWkFhZkpyWFJOZWJSVHZw?=
 =?utf-8?B?M2lqRjNFSjBQdHd6SGZLYXltVUkyQUtWLzc4RkI0N1hQZFRrWE8vRWhOL3Uz?=
 =?utf-8?B?bFJLMTlTQVRiY3lEaE9vS1ZGa1BFcGVJazEzdWtGcWRzSHhVOGpxUDJ0SkJz?=
 =?utf-8?B?ZnMvOG1wcnZWS2hmK3Fha2F2bCtBN3AyeDl3aGd6c2Z5WVZaVUc0LzluNU9k?=
 =?utf-8?B?L1cwQ3g3Vi9PSVZVUlZVUytBdnlvR3pLejc2eDlITEgvaElBekt1NkFPZnBQ?=
 =?utf-8?B?ZFpaZUFnTjUxZUZienZrY09FOTQyWnN0SEcvMkhtOWlhbVpseUJuRjJNbGVp?=
 =?utf-8?B?bm41YTZlbUdIQmVZbFJhNTZmeHJRZUxoc0ZXZzV6Q3FZd2VFZWFKZ0ZHNWhn?=
 =?utf-8?B?UHBvczZ5K2ZNSzE3dm9uWnNDS2h6YWI3KzIwdEJGMjBXTGt4WGNRRkhSV3Mv?=
 =?utf-8?B?MDdnSGk1KzYwSCtodDBIMjRMRE1UWlc4cUZKbTg5WGRvZWg3QjNyeEVRQWJw?=
 =?utf-8?Q?FQ7yVCbv2AW91nEkSij51YPn5lJzjBfja9dfvw+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3f2b14-a88c-41f1-1e24-08d93276e246
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 16:34:03.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRKarTCeScQCwlFSKgYnPYXuEvAhfBASkSAkR1t0nTZa+nEqV3twEnyvKtTcPnEIb60TdR+NCU1U8hYz2PQLUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2448
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 6/18/2021 11:30, Rafael J. Wysocki wrote:
> On Thu, Jun 17, 2021 at 6:42 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
>>
>> Required for follow-up patch adding new UUID
>> needing new function mask.
>>
>> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> 
> Your s-o-b is missing.

My apologies.  If I need to spin the series I'll explicitly add it with 
all the other tags that have come through, otherwise:

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

> 
>> ---
>>   drivers/acpi/x86/s2idle.c | 31 ++++++++++++++++++++-----------
>>   1 file changed, 20 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>> index c0cba025072f..0d19669ac7ad 100644
>> --- a/drivers/acpi/x86/s2idle.c
>> +++ b/drivers/acpi/x86/s2idle.c
>> @@ -309,14 +309,15 @@ static void lpi_check_constraints(void)
>>          }
>>   }
>>
>> -static void acpi_sleep_run_lps0_dsm(unsigned int func)
>> +static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, guid_t dsm_guid)
>>   {
>>          union acpi_object *out_obj;
>>
>> -       if (!(lps0_dsm_func_mask & (1 << func)))
>> +       if (!(func_mask & (1 << func)))
>>                  return;
>>
>> -       out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);
>> +       out_obj = acpi_evaluate_dsm(lps0_device_handle, &dsm_guid,
>> +                                       rev_id, func, NULL);
>>          ACPI_FREE(out_obj);
>>
>>          acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
>> @@ -412,11 +413,15 @@ int acpi_s2idle_prepare_late(void)
>>                  lpi_check_constraints();
>>
>>          if (acpi_s2idle_vendor_amd()) {
>> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
>> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
>> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD,
>> +                               lps0_dsm_func_mask, lps0_dsm_guid);
>> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
>> +                               lps0_dsm_func_mask, lps0_dsm_guid);
>>          } else {
>> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
>> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
>> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
>> +                               lps0_dsm_func_mask, lps0_dsm_guid);
>> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
>> +                               lps0_dsm_func_mask, lps0_dsm_guid);
>>          }
>>
>>          return 0;
>> @@ -428,11 +433,15 @@ void acpi_s2idle_restore_early(void)
>>                  return;
>>
>>          if (acpi_s2idle_vendor_amd()) {
>> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
>> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
>> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD,
>> +                               lps0_dsm_func_mask, lps0_dsm_guid);
>> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD,
>> +                               lps0_dsm_func_mask, lps0_dsm_guid);
>>          } else {
>> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
>> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
>> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
>> +                               lps0_dsm_func_mask, lps0_dsm_guid);
>> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
>> +                               lps0_dsm_func_mask, lps0_dsm_guid);
>>          }
>>   }
>>
>> --
>> 2.25.1
>>

