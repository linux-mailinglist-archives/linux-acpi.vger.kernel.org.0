Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC88979DD18
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Sep 2023 02:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbjIMAVH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 20:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbjIMAVG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 20:21:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E5818D
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 17:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEMLkiVi8RuUeIaXYC2C2FuiTiFnUVZGxjOXaXOZpH6AH18YqxsrFjqu+nx9HpaRbxTZA1Qx/yE4kkEbPb2gbt+wwZQ4finKjLuLCoGeKHigf46eALcV+FhtY+lGWvvHpGpMfVXv7WaiEA18mUUcMm6wufZnpBdPa2WPajKbtW2gKsOZ9FAZsC4Ncp1A5Pc4tS1xoj3LYFum3kZZ1Uf9MX9rn6DEiLNPFe+7Um+6swAkvPf5U8Ob48gabLk7ivB/NWTFN6jLZMWaKbMyuBsTZ8ZR5Cod07Q8EeNC99dRQrnJCfCX80YONyPhp79Dg8T2ZMND4ZmAtqxolShGhvGzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug4dN1FxDwWu3+s1DhvANlsvaFHIffOKpbdAo9qNvSQ=;
 b=TfzJAWdZaT5x2qpD47XhJUOT/Xg7fMwXs3qenpDSZKWcn3p1B8HaEVReOVwoqUwH2O9NaEcAsAphVAIQN82twl2ZfkIqk2SQD3hJx8MOs0M/5K5M2ECmMly6i49Wf/hs52fvuKN9FrvJ5an/ZZwX1iPLvZm7lJtqJkc4kmvY7yFoVa+eUaux306IMQ0oOEV0hjuMJ8vRhq3fUYkFBOlunqWWAzfiNN/HltHWEv0cDRdU1AzWg9B3/+SPaPJvRsPFxkhvISgs0wwOzVIE7/GlEBtuDDpwA2tT1ujsJNmQOghQtKNgFFHZWZMHFOCWBvtzo0qpDGJ5MUXeEOYm6pVufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug4dN1FxDwWu3+s1DhvANlsvaFHIffOKpbdAo9qNvSQ=;
 b=augW9L3qprCTyKWO+zRBNvBDXNl1fkg16xHz+9SH0IUckGNbBf6eby0gKZ7g53hXOyy27wwvD9p/vBuiiUKnvDgIWCJAqj5BFMVaBwAWejuRTAfpv7eGiSacCiDmDyrhaAwtgAf4tVw85ndtkse7rnVNh/6K5E7gzTU0EWuJ6JA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 00:20:58 +0000
Received: from PH7PR12MB6978.namprd12.prod.outlook.com
 ([fe80::c422:217b:5b:979d]) by PH7PR12MB6978.namprd12.prod.outlook.com
 ([fe80::c422:217b:5b:979d%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 00:20:52 +0000
Message-ID: <e0a9d7a1-1c6e-b49a-6c1f-6727f489defd@amd.com>
Date:   Wed, 13 Sep 2023 08:20:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V3] acpi: trigger wakeup key event from power button
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org, cwhuang@linux.org.tw
References: <20230912131605.734829-1-Ken.Xue@amd.com>
 <ZQCCTA9YblEHgKT8@smile.fi.intel.com>
From:   Ken Xue <Ken.Xue@amd.com>
In-Reply-To: <ZQCCTA9YblEHgKT8@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To PH7PR12MB6978.namprd12.prod.outlook.com
 (2603:10b6:510:1b8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6978:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cadf8c-b19d-4520-a00a-08dbb3ef49e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6NhKCs6mDAC31Izswwj23DAhdMOzLgPVFlnCZPlM2wZ1rRWJ6MI4TA423P64d0TjBLEkZwSLpzvWw9DhKIyXQ4gT2ETFeXUdwII2QRGNN4uUQBWAQh2AxtUIxBUo27LcElqqTMYA4alqxrR1aaxK8Uta5yQfjhxkp+234MhDY2Vi1LmMihuwamBGlfC9EmsLi/xHTlJEGBZ6bLHza9TjzjGCxJdJmSArn5mNI3csqTMf6H8VUgKNVKOyXh5ztRzE2kqYEUhb7n2xj7G2eFlu2ggkzP7/f0lWfBt/airObiFlHTOUaEGCH6WFQtKa+kOd7OG1+mt7hId7t6EtkpE8GDzafKlXx2ri8mxxVEZzfSC+L9IatnUr7vnyADCSp7VTN/L6gAfISsVLNZL8DgwaP5ydoe2oXgs5IEFv6M30Bp7DGCB+OTh1+jFkX0uJNX3HmTNOGD9yAoOAtytwJaLjkf9eXxyjVf70IckG40A3WHdl9At5s3AMWlBSxfqV8cAtkNT2azYWPq2sHKrcZArrL0knmv9teMny8vaqh2LcQ1+ysIoIqxQG4N1FFzHf59mVTv+K2robF9zGzYibLUPa1wSth/SUMX0k9+05mjlafE8gjtv7zOQNxh9IM86qHzd1FLfnbTM6+Py1fAucbWp4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6978.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(186009)(1800799009)(451199024)(6512007)(5660300002)(8936002)(8676002)(4326008)(31686004)(53546011)(6506007)(6486002)(26005)(2616005)(6666004)(478600001)(6916009)(66946007)(41300700001)(316002)(66556008)(66476007)(86362001)(31696002)(2906002)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEp4ZzI1eThxZkQzZ1RaUDJha0tkWURJTEE2Z0k4cGt2dERlUHpKbUppa2hU?=
 =?utf-8?B?RFFhMFpNNEo1UlB3UWJBK1ZTS2NSanp6VzRLbGpFWS8xdnZaTm1JV1dBcXlX?=
 =?utf-8?B?SUwzeEJJbzFzOXZ2ZXlsSjdEN0d5SWVFc3MxRC9BajBTa1EyQzhMSy9IdUts?=
 =?utf-8?B?T2NrVU5QS0RmZWorOVZLQUJlRTVRMGhVQWxqNmh4QWZvbjVMZzZabmtKdFlY?=
 =?utf-8?B?ZDEwOGp4bkM5dE9TTFJaUWZ4NGtPOFlVaFBwWWxYN3VYUG4vTDdQSnVXNnli?=
 =?utf-8?B?Qit0WElkYmt5K0pWS1N1aDZLMnpadTBIUmQwMFoxUVdJM1kra2F2UHZPblIv?=
 =?utf-8?B?dDlSOWpHMERwcGw2dWliU1NXTjZEZnZ2aUw3YUZ4USttNFlpTXJBNlp2WDF3?=
 =?utf-8?B?K0tEaUUyV3RYSHdhVkp4V2c5NWxKVWpobjN5UHpaS0Q5OHRoTFBGZUNPdExR?=
 =?utf-8?B?eE55QkM0c1ppdmJrayszOGZCczZWRFJmT29LeU5jRjRzTXFjdGozY2Y0VUcz?=
 =?utf-8?B?b0RLeklmV3BLV2llUzVER3JTWVArS2tBMlU5cER5T1J4UXE4anF0WWtaSEJh?=
 =?utf-8?B?REtNRVgyWmZJUm5FNjRqR0xidGpxd05ERkF3WG0zaUl1MVhoZlRVOUxhT3Nk?=
 =?utf-8?B?QXhmeXZkalBsaEZtaVZ5Y1I3Nkt6RXFtUUp5cE4zc2tKbzNLcWZScE5adHU4?=
 =?utf-8?B?cGE2a0hrQ0F6alMrU1hQRWViVE1UYWRIRE16SDRUUTZabkhONCtiTFJmeVlR?=
 =?utf-8?B?SS9HZTVFYnhKcENVNUtBR1RIUjZSRURvS09BWVdWTDE5NThQcUF6ZVd5TFBO?=
 =?utf-8?B?cUxrMGFLdFhxZ2xJTnhJZXNiNnpzZkczcEJFU3JTZVlwOVg2Nld4a2t1UmxX?=
 =?utf-8?B?T0lYQjFKek0rMW5ycWl1WEV0T3NZUkNZc2hXWHg1SFkyRE44VTV5cDZkMjlk?=
 =?utf-8?B?Ti82YnR4UDhJdTZGT0d1UE9DR1Z6TENVaWwyMnJkS2xQMHF1c2pOTkgzSlJ3?=
 =?utf-8?B?U0ZYb0VDVEVoTWdHNWo4VXlmTHVFOHc3aUJod2gwQ09qUDdTeHVPUWpBWXlX?=
 =?utf-8?B?YjJ5OW5NM0lGTm84R3BBKzh3VlkrbjR0VUlsUEVmTXBDeTU2djRKK3NxZjIw?=
 =?utf-8?B?cWVyODY0ZmE3ZEgzSTBmMkdxWGlhUzUyUVpoUDZlV09Scy9uN2JrWG52ZlI4?=
 =?utf-8?B?TW82bjl2Qm1WZ3ZaOE5rc2Yxb2g3M242NURGU2x1VnVydXhxeFdtRzFiM1pk?=
 =?utf-8?B?MUZGVkRDV1o1L21BTUUxTVBzRS80S0lvVjJSaG4xZm05T3BWaTNoanhWcVRI?=
 =?utf-8?B?amZCZUhiS041TldZcGJNVTZORmVZa0JmM2JkMWNCOGNOYmRYYlMxU3lpdW44?=
 =?utf-8?B?VnRCZFVnSVVQNlUyeDFiUlFFRnhLV0VUMWpmc3owRVRubzd1WHRVUi9xei9u?=
 =?utf-8?B?emhaUkRtS3VXQi93Sm4yV3lUM21zb0JsQkpYSTBLaVBrTGFYZDVnVnZKYVNt?=
 =?utf-8?B?Q1kzTHhrOXh4ME1HbjhxYTJMWHBvcGoxbXRab2NnV29sOHJWNUJ5Q0pON3Zs?=
 =?utf-8?B?aXVwK0dWMkVsOGxCck5zT1B0K2YwZVlzaWNwSUZvTlJrdVRONGxheURwbHBl?=
 =?utf-8?B?R1krZnNkZ0lrak9Gc0VmMTQ4MUNHTlI2dUk0dW9GaEtBMFp3NWNTQ3pxcUlr?=
 =?utf-8?B?Zy91ak5Jb2pFN0J5QWdtbmFFTi9Fb2NGSE5wNExWTlQrTFVPTkNSK0FpYnJG?=
 =?utf-8?B?Z2Z2VWd5TFpuamZnaTI2L3R6b0NPTmxDVnFPWjM4elBsdFUwR2xyUmFvREEy?=
 =?utf-8?B?TnJlcTBENjg4a0pBOVhmNVdTdExSaXhPOVFtQlc4V05IaHRmMzhJeUFTQmcw?=
 =?utf-8?B?OGdjYXZSVTk5dG40SkMvZE5LQ0FPNWdBczlkYzVtbDNJUVkwL0piSzlqWlI2?=
 =?utf-8?B?VHgrQ21EVjdFMU02UHQ5cmRZUEg0S1NYQXVMUGhPaUFjeUZEWmIwVFpRb1h0?=
 =?utf-8?B?QzRWYWc2eGdMVUpLNktQK0EwUUJMQnZSVjVXazJKekpFU3owaGwvbXhaZGJ5?=
 =?utf-8?B?S0pXYlZpODAwTGh5L09VaEpZcUd5MDVneUtkU3B2RlBJL0toTG0wVXA1YUdu?=
 =?utf-8?Q?OMRfZs3XDo5k5+y9ytlwyoRIH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cadf8c-b19d-4520-a00a-08dbb3ef49e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6978.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 00:20:52.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D01JmEqy1nOMe04yG4HC9gLOISqaufKVJkv61e6B985M57oEEQQUG5M/u52sdMjH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 2023/9/12 23:22, Andy Shevchenko wrote:
> On Tue, Sep 12, 2023 at 09:16:06PM +0800, Ken Xue wrote:
>> Andorid can wakeup from various wakeup sources,
>> but only several wakeup sources can wake up screen
>> with right events(POWER, WAKEUP) from input device.
>
> You still have a room for 10+ characters on each line in the above paragraph.
> Why not use them?
>
ACK


>> Regarding pressing acpi power button, it can resume system and
>> ACPI_BITMASK_WAKE_STATUS and ACPI_BITMASK_POWER_BUTTON_STATUS
>> are set in pm1a_sts, but kernel does not report any key
>> event to user space during resume by default.
>>
>> So, trigger wakeup key event to user space during resume
>> from power button.
>>
>> Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> ...
>
>> +void acpi_power_button_wakeup(struct acpi_device *dev)
>> +{
>> +	struct acpi_button *button = acpi_driver_data(dev);
>> +	struct input_dev *input;
>> +	if (button->type == ACPI_BUTTON_TYPE_POWER) {
> It seems you missed the suggestion and I haven't heard an objection on written
> the above as
>
> 	if (button->type != ACPI_BUTTON_TYPE_POWER)
> 		return;

ACK. sorry that I do missed the suggestion at first place.


>> +		input = button->input;
>> +		input_report_key(input, KEY_WAKEUP, 1);
>> +		input_sync(input);
>> +		input_report_key(input, KEY_WAKEUP, 0);
>> +		input_sync(input);
>> +	}
>> +}
> ...
>
>>   #include <linux/syscore_ops.h>
>>   #include <asm/io.h>
>>   #include <trace/events/power.h>
>> +#include <acpi/button.h>
> While at it, I would add a blank line here to distinguish groups of header
> inclusions.
>
>    #include <linux/syscore_ops.h>
>    #include <asm/io.h>
>    #include <trace/events/power.h>
>
>    #include <acpi/button.h>
>
> Or even
>
>    #include <linux/syscore_ops.h>
>
>    #include <asm/io.h>
>
>    #include <trace/events/power.h>
>
>    #include <acpi/button.h>
>
ACK

