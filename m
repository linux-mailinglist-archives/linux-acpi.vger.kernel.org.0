Return-Path: <linux-acpi+bounces-2567-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A6A81A136
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Dec 2023 15:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B811C1C22347
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Dec 2023 14:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806AD3D0B2;
	Wed, 20 Dec 2023 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KwrzjQiC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD873D0A6;
	Wed, 20 Dec 2023 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXWfD+UdGrCqaLT+6L8i9GPxCJgipXG/uiexOCXCHjCE1w82T/0E4vVrxmJUARBBt5StjSFvSaAfiaZdInaBc4OMvpVPvqkDzcXKnxh59DpZLhhRX2rZOavl02a3GPM49OUPoDJbvWFb95jLD3eXm9AEknL8P3/4Q30+ZkzXiEPqehMgC1uXzFYP2K0RLln/Yj2kllKxBQdutpZvkaiO2LRR84Ew2DSuPwHCBlmpOXwbKoQrFpeL3ZvzhZ+z3T2XAzPJGpJh5FgjkLIIKss6qnvMxT6TQ/LbEHse9a6lCyrPg6wIsUbSCuEpsL4OMSA4S0D1Z7QA9O23iMIQt4Ft6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCOfr7f9rggL8OOER1KtF8l/D/JlBrrETBVufbzuW8c=;
 b=cKH0u6c1GtUq21JW5TNVJsnaPo1MVXIPDOuiNOAtqTsFqCyTQKdtx05xfPzuEhwDBZsshc7dUfDaJBv9Lqta+AOxjnw6Rt3jz2W7hV7/nHuMwQxkj/yhU8X1Mf63+LwTE5ukzmvdhbuSMr82yMWf9MjdPP9u0TPwptedSy/WE9F+80PDwLQIYy7iOE9FgOHiSCE4NyJf4DcKDkGKyq1hM9c/I1NvVYjh2N3QOKcvSUz+CcWJVqVO+I8lkWZ1zsS1hR0yNKRpn5aSRUj8JIW/KMu+xEK6bSEx6fi3jxQN/ym/QSoizyM51zcU6P6fbOFxbHEw8Dr1JdlhVuKZekYVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCOfr7f9rggL8OOER1KtF8l/D/JlBrrETBVufbzuW8c=;
 b=KwrzjQiCcmCiX5/B8NBLolc1qi0jFsKAjDFDDMh5a+2x583Ee+Rj1Xq6tnsFGaKdvAtgKEs0o1XX9I6PlLyNxJvyN79gmvmZWO8rX6Y70+QVMKS0+sCD2wJK22t30X4HVaRsZ6sNxTJOMBnSdsoI5wTHZsZJlPSTPw+IRjXNRIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3270.namprd12.prod.outlook.com (2603:10b6:a03:137::31)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 14:37:35 +0000
Received: from BYAPR12MB3270.namprd12.prod.outlook.com
 ([fe80::fd8d:fd5d:e44:c61a]) by BYAPR12MB3270.namprd12.prod.outlook.com
 ([fe80::fd8d:fd5d:e44:c61a%3]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 14:37:35 +0000
Message-ID: <1e6be72c-8966-437e-8a68-a94d27557237@amd.com>
Date: Wed, 20 Dec 2023 08:37:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] ACPI, APEI, EINJ: Add wrapper __init function
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, rafael@kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
 <20231213223702.543419-3-Benjamin.Cheatham@amd.com>
 <6580dcd03b49c_7154929487@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20231219153955.0000473d@Huawei.com>
 <6582019fd0b2_269bd294cf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <6582019fd0b2_269bd294cf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0322.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::11) To BYAPR12MB3270.namprd12.prod.outlook.com
 (2603:10b6:a03:137::31)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3270:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: c342898f-03fc-4061-7735-08dc0169350e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RqzeUqhHzSOgWqyVDTChS4pXWsrsCb8+O5vbnPyFdwBpv+TnX9Ql3eGPdx1AxEb6DIWy82WBSorRyfo3+6PsPP1PF9Ul16bfk1PVMRS37aPcJLmN2O1lpDS1muA0s5ZDeJnQXZmzVdEjwoPOID57wi65rEU6mu6szJl/z0tVoK0qG3wvMDfkSYHmckT9VS1ZhxHySA+YF5jDtp2hVzO1TrpyKbWGWnez8fNNC82H9hFaV35d+N3ZujnYYiEo1WblvOujcki4gyjJ2Lc1meCpCPEzj29Ai8TWmq5hBJqC9BbnZi1rVs7t+Uu1ZyTMzBEsh3x1tb+d16O5XlKOsYJy+R4qmn/TTlXnTdH5+DeKAtb8XzRvYJu33Wn4SmR65kpesL+/SdbpgUl88Jc9L+1Iiev/YVrUPHUJ/Yc/PAFGGMGrYJNBi1VSFm58T6uvJ+5VKQuEaLDek/MppbPcIXbWb4Ycakxn3Tm3AxwkGu9EC3LsUqd6FtErRQZU+PLhiYeMmadvuYKdkFiJhw0UF2LjvI2Bbdf6fhBLF/XIshsqp8vHyMtcqI8GL/9pwJ0wS0KiE1fx23X6BXOgrE5TEdP321Mq6CIEQ+hgJxKtPohr2YBDwN1NVfyy0w5fH3Rx5oIXXnlOQNV1uGYk2fwtIO7IHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3270.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6512007)(2616005)(53546011)(6506007)(26005)(86362001)(36756003)(31696002)(8676002)(8936002)(41300700001)(2906002)(4326008)(5660300002)(7416002)(316002)(110136005)(66476007)(66556008)(66946007)(6666004)(478600001)(6486002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzF2WjNUN3J6Yk9SWVRrZ3ZjSzdnd3lkWUlPUkFzb2JGOHY3ZGdwUkgwWTJR?=
 =?utf-8?B?cE5hb00rL3JuZGc3SVlYVUZCQ1hnNkZJSklOYm43TGozL2NOZklvY3h2WVZU?=
 =?utf-8?B?czFBenJ3UmdodUlzb0lQNk9wM015emtaNmZWTE9TOVFoc20zak0wa0VxcHNm?=
 =?utf-8?B?WHhoZ3ZHcFQzTHorYjdoR3ZBb0R1Tk5vN0ZiK1lteW80UHFZWFJKUVh4cytU?=
 =?utf-8?B?WWM2WVBiK2NwTjEzcDRKVStodkFaT3lSZWJobERsMlhHbUR5TEw5Mm52ditn?=
 =?utf-8?B?Vjg5SGpDSVRSM0pVcjZZaklZWFFwaEVrdk1QUHBwSzg1RVpYZS9nb3IxZnZQ?=
 =?utf-8?B?V1B1UkNDQVdrMUhZZDZtYUdKcFMzY2ZlanQ5eVo2RUJHZlhYYUhDUm9aUWhv?=
 =?utf-8?B?ZHkxSjdpb05kM2t3SVVLVjFLTHMvR2pITkxZWmpmMTFsU2xGUm5ZUUJIdUhG?=
 =?utf-8?B?V2FZdzdUdVJ6dEVnTlJvNVVrdVZjNFdsS1RTeGpzKytrZFo5cmFnRTNOMFZQ?=
 =?utf-8?B?V2o3bXRhZm0zNlRVVFg1K1JIbUVCY1lONEZodEk3a2lzQTlVdCtIcVZ5VWoz?=
 =?utf-8?B?LzdLSHpka05ZbFlQZnAxYThuVGVtRWNpamFuU2o4SXlzWHJXdjYzSkhHTFlt?=
 =?utf-8?B?NXh2OXNLR0F6ak9ZNVV0NWprQytRM1l2bFlXMGhPcTZXZE5lcVRWVXUvZy9W?=
 =?utf-8?B?MTRCdWR2TURZcFF1S2dpUW9Bd3ZCaGhwTW1yVVorN2RQb3JQaWJhVC91SlEx?=
 =?utf-8?B?aWJvaytmT2xRRGxRelRLaTNLMnRNUE1WT1NRY3c5cTZhSFFPdVJaMUFteXJF?=
 =?utf-8?B?NUpnSHh6SE8rbG9KWllBdjlna0VUazVwMDBBaWNFanUvdCtKay9LcStheXlQ?=
 =?utf-8?B?Q2JKRWt4TngzdWpEd3BZdTJiN0xnRnRGbVdjZTQ3VHBrcnVLSWNoQ01oYklU?=
 =?utf-8?B?aTlSN1JvSDRRZkJ5S2cvTjRRQ0xVQzQ3d0FTUzVsTStzTVR2Q2pydzB2c1pV?=
 =?utf-8?B?cG0rdFZzZm1kdXNNazFnVWNMOWJoYkRRL0JXemVweWNwRlZGMEFRQnR0ejBF?=
 =?utf-8?B?WVdTR3FZMkp1Zzl3MzhaMVIza1kwSzFheE1qUUxvNjVDU01pUVR2R0w1M2hn?=
 =?utf-8?B?bDRGK3pjQnhsUktvbFhkMEE0ZU9DWlZCNlExbnZYN0syRXNvRUhDSU84SWpH?=
 =?utf-8?B?SUZBTUovdmRpRDRiOUNvcjd4aDhHN21WZkY3QkFYVmxuWjIyRlR3SFJHRmpU?=
 =?utf-8?B?L1pJVW53MWNXS1VqRVZWMmVUVnJjZU5hVm9xeTdKWmRlMWlmNS83MHUwdkh5?=
 =?utf-8?B?ZXZEenBPcHpRcFQzdWY3NW9FbGIyclNIK1dKNExLcHB2NGc3RTVmZTRxQkMr?=
 =?utf-8?B?V0FRSVkxOVJIVUNtbytRUmJSaGQxMDRqemU4SER1SXVNMm5Ndjd3T2ZKZFdJ?=
 =?utf-8?B?S1R2M2xoY3BmV05peVEzb2dGMkp3TjVlcVNuNWtlaGxwMHFFdk0zb29nSEZx?=
 =?utf-8?B?ZzZPQTZ0UG0xSGRidHJOK3hXQ2w0c3diUy94RUR4NndETW42aUo3a3pyTTBL?=
 =?utf-8?B?Vzl5ZzhscXVDU3N2WjJVb3RHNzR3U0NiMHpWdVk0TDROblN4OGlhb1l1RGpZ?=
 =?utf-8?B?YjVhUDNtcDQ4OG5JK0syMW9wVzRRU0ZiTG1LU1BMeGJBQlczWEVMbXhBcWRI?=
 =?utf-8?B?ZkNFdTVJM1k4VE9TWTA2SmZJRzJEam9GNW9xYmFwanFaZzJnanFaQzI0Vmtr?=
 =?utf-8?B?TWFDOVZkYnlvRmpndG1zNEdTVThkWGdyT2liRjNvampiWEpwR25nbkF1bGVG?=
 =?utf-8?B?MG9VOFVodUpVWnV3aUI2OHQwMGxGRlBVVFpuUm9zek5pYzJ0NUVQSkZxRHkr?=
 =?utf-8?B?TU02OTEwUFlpdlpxRnJDSVVleFkwUDRXU1VtSVJ1WlJHNHQ5aGtXa1VENGhk?=
 =?utf-8?B?WEI5UW5HaVBUd3A2RENtNDZGMjhUck5JdG5RUnhiMkxSUWd2Z2F2U3lTRFVB?=
 =?utf-8?B?T0hxUGU5bGpvWnBPRkFSTjFWSUFjeTgyZWswek1GQnpRZ0dBeVcycWU0UHo3?=
 =?utf-8?B?NHMzWjNPYXhGUzZicXRGc3Vlc2NDd2VwK1oxVlUyNlhTa0RzemQxd1kxSHBi?=
 =?utf-8?Q?wAQbq04NzeS8AFJOtiqu+xfGx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c342898f-03fc-4061-7735-08dc0169350e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3270.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 14:37:35.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZoEHSM4vuu2XLnNodK/DyZMIwW1vWR1a2IjW86EtLK/yXOZWY32ARoeh/g4dqVapvK3L3NSg1SKfA8h2Flcfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452



On 12/19/23 2:48 PM, Dan Williams wrote:
> Jonathan Cameron wrote:
>> On Mon, 18 Dec 2023 15:59:12 -0800
>> Dan Williams <dan.j.williams@intel.com> wrote:
>>
>>> Ben Cheatham wrote:
>>>> The CXL core module should be able to load regardless of whether the
>>>> EINJ module initializes correctly. Instead of porting the EINJ module to
>>>> a library module, add a wrapper __init function around einj_init() to  
>>>
>>> Small quibble with this wording... the larger EINJ module refactoring
>>> would be separating module_init() from EINJ probe(). As is this simple
>>> introduction of an einit_init() wrapper *is* refactoring this module to
>>> be used as a module dependency.
>>>
>>>> pin the EINJ module even if it does not initialize correctly. This
>>>> should be fine since the EINJ module is only ever unloaded manually.
>>>>
>>>> One note: since the CXL core will be calling into the EINJ module
>>>> directly, even though it may not have initialized, all CXL helper
>>>> functions *have* to check if the EINJ module is initialized before
>>>> doing any work.  
>>>
>>> Another small quibble here, perhaps s/may not have initialized/may not
>>> have successfully initialized/? Because initialization will have
>>> definitely completed one way or the other, but callers need to abort if
>>> it completed in error.
>>>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
>>>
>>> Did Jonathan really get in and review this new patch in the series
>>> before me? If yes, apologies I missed it, if no I think it is best
>>> practice to not carry forward series Reviewed-by's if new patches appear
>>> in the series between revisions.
>>
>> I'm not keen on the solution as it's esoteric and to me seems fragile.
>> I've looked at discussion on v7 and can see why you ended up with this
>> but I'd have preferred to see the 'violent' approach :)
> 
> The issue though is similar to the argument for the creation of the
> ACPI0017 device for CXL, there is not a great place to hang the einj
> device-driver.
> 
> However, since einj has no legacy "auto-load" behavior, I think it is
> not a lot of code to have einj's module_init() do something like this:
> 
> 	einj_dev = platform_device_register_full(&einj_dev_info);
> 	platform_driver_register(&einj_driver);
> 
> Ben, you want to give that a shot? Jonathan is right that my proposed
> hack is *a* solution but probably not *the* solution where this should
> end up.

I can take a look. I won't be able to get to it until around the new year
since I'm vacation at the moment. I'll also respond take a look at the
rest of your review around then.

Thanks,
Ben

