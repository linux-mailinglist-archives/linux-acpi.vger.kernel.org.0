Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB39279C649
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 07:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjILFcY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 01:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjILFcX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 01:32:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4E4E72
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 22:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jl7odXh7n15HigfhyGjvxgT/NbWnZQ7wsHNIFtboCEE87i1DzsYMkNtdspbthMsWbOrKUMO0spLbnpIM9Y4XgUbPt8lnv0Jnq/TduVZwPrfj7+ujZuMFnfcaJZhc2m/q67FqOoUn0KegA0hQdL42/twRWv0CMuCIZQ40Y6o8n7Y4X1wOPgEsVM8/6bWJBoY+EQrCtvrE00kCzi8VUwpgDtsYAy1Mvo3j6O1j35R9W/6gWdTvIkXFhI6PU88GxWpAHPK38ezOzqg6zy4LB0F2LoGMr3T4w6GE9eAmwsGVQHd8t9u5rKb3QJNQpTUGBdNqRI5o/WqpiPFU6+yJycd19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcMi/ZR1p8M9bmR3Mx9PxE85nvgprxCXgXC7YthPBCc=;
 b=Ea31szbLzhNhCPwiPipiUBdC8Fn1tp94cHyzW572iHK4oqRmGqJcr5iELmPqnxDUQBoBqmvDKo6E7H+MhbZaduDG4HX2iK6/nTvSiMn9PSkpJAi27I+/hocdyPok2llOHGmFrdi5QaWySzI/f/ZWOSYiq3ousMH0nPnpYDYqfxptbzA7agSWKHzlpZatVGQ7UnbHNxHQG3rfGjJ7lPjwnFitTC/Vjrg4UpORhDx7lZDhgjOSIosb8flggdHjs14+CqLqkJWJPn6HxSrT3OjJrhOD6hex949uGxRTMOT30Z9JoeNZU0fR+TaIYkQ1PgeMbNBmfBY9RAWYccYsVmB/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcMi/ZR1p8M9bmR3Mx9PxE85nvgprxCXgXC7YthPBCc=;
 b=eKPrjtwLIzN8jE11V9OfWcL9jetAHGyfFw7ihXYDh9OPis5p88vZMwNPtLLo+f4COPJV1D3EAFmkcfCqJpyJX1DoHwyauVjYw4U3IGKvik5iY+c1V8f3494MCGKTk/C0+kpo3RDNy7VwH1cP5W2xT+mkYmk4etis4xRMsbWAgbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 05:32:16 +0000
Received: from PH7PR12MB6978.namprd12.prod.outlook.com
 ([fe80::c422:217b:5b:979d]) by PH7PR12MB6978.namprd12.prod.outlook.com
 ([fe80::c422:217b:5b:979d%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 05:32:15 +0000
Message-ID: <2bfaa431-ca9f-c879-9967-f13d18dd4cd3@amd.com>
Date:   Tue, 12 Sep 2023 13:32:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] acpi: trigger wakeup key event from power button
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        rafael@kernel.org, kernel test robot <lkp@intel.com>,
        cwhuang@linux.org.tw
References: <20230908095747.446389-1-Ken.Xue@amd.com>
 <ZP7hH9i6ZQgINbcB@smile.fi.intel.com>
From:   Ken Xue <Ken.Xue@amd.com>
In-Reply-To: <ZP7hH9i6ZQgINbcB@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To PH7PR12MB6978.namprd12.prod.outlook.com
 (2603:10b6:510:1b8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6978:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fec3b7-204a-4946-15fa-08dbb3519f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6gElZaasQHX34estrVec0JWTt69roHkcMDn4izO2d2D0Jt2g/Ux8RaDxiLgKTrd3avDPPo/VmHRheTp8nAmZ9WOveo0e+7zzRxTayTQAdQT9Vl1jNtIlpNy7OPiCJaC1cjn7ovKobsFOg2lRpfQ2Lx96LSLA/0DE0gjCoVTbJbRke0X6i8kfnF7zxmTLVK49McNjzBnfy+a/Sy89DayVGI7UowaDh26E5LfZL/rlw6iyRsorCWotBk2cPJLotlRtePhROCVCi/e2E1rXtYF191aTCZKhfrkedi4cl48A/OoOZKW8hQ/3qqYxUbcmKJoPtbGpK14pMsITDVm9fW3I6Jt4bfH9+FNpa5jwiuvUBz7Wly9ev7TGyfykILijqRwHRBhwR1/EDrliPm74sG6fXL9xn32+KgpavuvqjL3G92kfBHoEQuduhekUjU0riqk+LNRV0iTW/B+vHRHf+Bl1Z/aaTZDdU9WQXr5NthKNoydQXDtNfhtvKULv7a1brwoEeD/q3F80Tf7pk+moUiQdUx3LcX2klKuZoNLmiUoSkaXjhgyLoqlMxEkYwjxhvSmx16IfJTwmKXjIO0lFpvWlkv7OJaWFcz3KyjgkvvMvQa9qdsi/ijOVAe1QtBaOvupGsBEhx9dtb0gU5toL0uCIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6978.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(186009)(1800799009)(451199024)(2906002)(83380400001)(6512007)(2616005)(26005)(6666004)(66556008)(316002)(6916009)(4326008)(8676002)(8936002)(66946007)(66476007)(6486002)(41300700001)(5660300002)(53546011)(6506007)(478600001)(966005)(38100700002)(31696002)(86362001)(36756003)(31686004)(3714002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amoyTFZIUzhuV1hNVTQ4QitJY2RISlg2aENwbFcvQ3ZjbjNyeUNBemtkOEps?=
 =?utf-8?B?N1VhM0VGTjNlUHZZOFpDS1ViMVQzMG9QeGlFK3dzOWV1QzhHSGFKU0NyazNq?=
 =?utf-8?B?ZVBRSUc2c3QveFJWYnJmMmRxeXpqU044eGk5RVE1NTNsZmcrOGdFQ2VyWkIv?=
 =?utf-8?B?Q3lrcmhyc0gyUlFTcXEyM2VtaDVqR0prM2ZKTWFkUUxCNTlXSzJPUDdENTY0?=
 =?utf-8?B?Yit4N2xNTGJYekdzYm42ZFA3dmpYU1FOMDVaVG1uTnRkVmhoN1Z4TkNhZVcy?=
 =?utf-8?B?UXgyOVRqYlN2ckxKc0JSU0NRSGg3WmhrejV2LzJsSFNDWWJTbjJKOGdhNWUw?=
 =?utf-8?B?RlQzaVZacG9lL3NQTlRkQTFxSmtqWTJhNUp3SE9Nck1OVnpmM2FqeFhKRmJE?=
 =?utf-8?B?UTg1RFlFUzl4UVdQZVc0V2tKV2tydEM5WXpkRjdGamVWcjFiRktHVkxSR0Ur?=
 =?utf-8?B?b1k0aWhHOEkzaU9POWpMdTVYbGp2ZDdUamluenFqb3hUdHAxa21RL0w1TnJv?=
 =?utf-8?B?NHBRM0pYaytlTWgzbk9Fb3NSbFRWZzV3ZzFxa1BaMFVKOUkrQm9MeW12WlFh?=
 =?utf-8?B?NGVCZlNrcDg4T1Zyck9Ob25ObmNVOHJ2WnhBeGdLUGF2NDdtWTdocjJEY3J0?=
 =?utf-8?B?azFldEtwdThRb3hPeURpOTNpa2wwQ01BditrcWxYZUEzU3VRYjNMVE1Sa2N0?=
 =?utf-8?B?NUZjNDluSHNDc0FtSjB5L0hieUpyeUZ0TC9KQzdKZkpTempUbWk0blIyVkVU?=
 =?utf-8?B?QnBKYXd3K0tHOFpZQkRKVjl1c25SS3JUQ3hHVlRDRnRBNVBhVk5XY1BEVkNj?=
 =?utf-8?B?YXRHRzR0b0FJSEhRUG9PcXZ0STg3RW93d2dFeWZmK1hGRUpnVlZkQ0FLMEJN?=
 =?utf-8?B?bmNJWXNlcFR3RFh4RERHeFlITysyRkoxNG5halZXOXI4ZXpsVXBpWi9BSDFm?=
 =?utf-8?B?aGNtdWFOYXhWNUNLU3NMdTNrTDF6QWdiV0ZxNFA5T21XL3c4Z0NzWWhRZkdJ?=
 =?utf-8?B?VUZNYWsyOHlhVkxycUZmSVpXem51WUtvUnV4OFVKRm9SSjFueTVKeHJpMnhk?=
 =?utf-8?B?NnNReThkMzJBQkRnWDRBdHhqdTBtYjNteHNLVEVaZFRYNld5bEtRVHFnQ2Ju?=
 =?utf-8?B?R016L2lURE9rL3FQREplT1RhUWo2RnkxUmppM3pjU05la3FTN0VpZ0FXN1lG?=
 =?utf-8?B?MW1pak5qV0Z5aUVuOXUzaFZuU3BvNjFEWTVmVnNpcE9tdjNqRVNUWFdVWDhI?=
 =?utf-8?B?YmVxMFF3d1NQc2xadTFuM1dMdm5IU050bDhwd3RQSjMyenNZbjYxd3ZqWnhL?=
 =?utf-8?B?TW9vallVdVBrNjZ6MHQ3V1F1dkFrNUNGQzFXck04ekdKMXFmcDNqU255SmVJ?=
 =?utf-8?B?TTBKVmloZ0JLNThzT1g2bzRXeUVISjB4NHJWWisxY3hPZjZuWTFTTU9WOGFq?=
 =?utf-8?B?OXBiYXJ2YkR2NFpseFFpOTQxV0htN3lVRU5ZVGxGY0VLSFpUQ1VEVlk5c3Ba?=
 =?utf-8?B?azR6SnZ3T2hYbEhSNFVKeThoanNod0xxeDBiZWRnZFkrMFBLS3FYcEg4TW43?=
 =?utf-8?B?UjlEQ28zOEFzdm5xcG5rVU5QMlQwd1l4S1F1YU5lb3Y5eG5JbkdocWVuRHdh?=
 =?utf-8?B?NFJVNnhrUGdZOWhpd3dwMGV2RHBTRG9PYWlhT1RuQnZWTVhKZjVIaW5CVG5a?=
 =?utf-8?B?VDRkS3hnV3FUSVAwV2hNbUVzMDBnZHNBU1U2SVdoZUREM2Z4NVB6L1pyZ3Bq?=
 =?utf-8?B?eGhWQmRnRzFKaitWckZHTUZtUlJNOXFvL1QySG9hYnZ0Q3hYTzhPSGVXRzFB?=
 =?utf-8?B?SjQwSlZ3UWI3QUVuUWsxV01naXhXQmxpRU41a3Qzc3I0cEZ4ckFLdnkrY3ZE?=
 =?utf-8?B?dlpDRENMUzBxbmsrRXNNemVPZnIwUXpiZzlXVHpZQ2FpbnFXY2NFVGlwVEF5?=
 =?utf-8?B?Y2FMWm9Jcmh1Z0daeFJleFNqbzJJQzdacGpwcVMrTlk3eitXTEYrS2JnQkZU?=
 =?utf-8?B?QVVOQ1ZON2lqMStrZnIwQWxqV1ZZMUhEb1MvUlJ0VjdNc0RvL1JzRkdCSkRj?=
 =?utf-8?B?VEt2YXpWKy9SL1hMUXNVQjZPUkRidVpmcnFVdC9XNllGYklkWVUyZmJjVmVv?=
 =?utf-8?Q?I7h9pRr9jYmk+/mg0A2XEa8WT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fec3b7-204a-4946-15fa-08dbb3519f8a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6978.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 05:32:15.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFi4HGJ0j5TEbqLtvYZk7R/UxJaejY97yglekNsV/9HgHFiVQo7B6utq6c6HgJts
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 2023/9/11 17:42, Andy Shevchenko wrote:
> On Fri, Sep 08, 2023 at 05:57:49PM +0800, Ken Xue wrote:
>> Andorid can wakeup from various wakeup sources,
>> but only several wakeup sources can wake up screen
>> with right events(POWER, WAKEUP) from input device.
>>
>> Regarding pressing acpi power button, it can resume system and
>> ACPI_BITMASK_WAKE_STATUS and ACPI_BITMASK_POWER_BUTTON_STATUS
>> are set in pm1a_sts, but kernel does not report any key
>> event to user space during resume by default.
>>
>> So, trigger wakeup key event to user space during resume
>> from power button.
>> Reported-by: kernel test robot <lkp@intel.com>
> Are you sure?

Thanks for review. Sorry for confusion.

1)The patch is trying to fix the android wakeup from power button issue

I can see Android can resume from S3 and wake up screen from USB keyboard.

but Android only can resume from S3 and fail to wake up screen from 
power button.


opensource android-x86 tried to fix this issue with a patch

(https://git.osdn.net/view?p=android-x86/system-hardware-interfaces.git;a=commit;h=78688b149314ec16cb2d90507a5908e5f2ba0fda) 


in upper layer system_suspend service as a WA.  It  emulates wakeup key 
during resume in a user space thread. And it is still not part of 
upstream Android.


I believe the root cause is no wakeup key event being reported in kernel 
during the resume from acpi power button.

And I have verified this patch on linux also, it seems no side effect 
for Linux resume with this patch.


2) test robot reported some compile warnings and errors detected by test 
robot which is fixed in V2.


>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202309080315.txQUEyHQ-lkp@intel.com/
>> Closes: https://lore.kernel.org/oe-kbuild-all/202309080239.IiC7uLpW-lkp@intel.com/
>> Closes: https://lore.kernel.org/oe-kbuild-all/202309080351.xHt2qhP2-lkp@intel.com/
> Are you sure?

Just some errors/warnings from the v1 patch.


>
>>
> Blank lines are not allowed in the tag block.
>
>> Signed-off-by: Ken Xue <Ken.Xue@amd.com>
>> ---
> How this change is different to the previous patch you sent?
> Do you forgot versioning?
> Do you forgot changelog?
>
> Please, read Submitting Patches documentation before trying again.
> It will help to make your contribution nice and understandable.
>
> ...

sorry.

I will add V3 and change log later.


>
>> +	if (button->type == ACPI_BUTTON_TYPE_POWER) {
> 	if (... != )
> 		return;
>
> ?
>
>> +		input = button->input;
>> +		input_report_key(input, KEY_WAKEUP, 1);
>> +		input_sync(input);
>> +		input_report_key(input, KEY_WAKEUP, 0);
>> +		input_sync(input);
>> +	}
> ...
>
>> +#include <linux/acpi.h>
> There is no users of this header.
>
> Check how forward declaration can be used (as it's done in many other headers).
>
Yes, "struct acpi_device" is defined in "include/acpi/acpi_bus.h", but include acpi_bus.h alone

will lead to more compile issues.

Regarding "forward declaration", how about

typedef struct acpi_device *acpi_device;

>> +extern void acpi_power_button_wakeup(struct acpi_device *device);
> ...
>
>> +static inline void acpi_power_button_wakeup(struct acpi_device *device)
>> +{
>> +}
> This can be done on a single line.
>
Ack.
