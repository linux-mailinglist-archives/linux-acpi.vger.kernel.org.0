Return-Path: <linux-acpi+bounces-2786-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE13782A3D2
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 23:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 342E8B26D04
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 22:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA5C4F1E5;
	Wed, 10 Jan 2024 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T+GJemKq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D44F882;
	Wed, 10 Jan 2024 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhw1wyh8sLwNBx6qrIt9cl34p8uuH1rzrE+OohOUx3kBt1lTF4+sMUkFv2YUMsc5DDFLuFVDJzNbvjhUZhIhqTyLe7LwkiS5cPMt7EDhnwGeS45bJZ3eBNKFDsRz9XE6C9kon9jiTBp9FG2C3ZMHXXgZ181Df9/uzD5KBuBpddaYhVHpteFx/UgmGMbmPWVF6L7OCTrSGcrW5OxeQiwAWvVn4p6eVfTqucxyrK0Cs3FN2H+v9N5hAi2hf9zWyeX0eDOCcVP3B1lqXecB6hv+ml24u6eazxnJa5lAEa85iCSw6WHFb4tYtHMb6GJR7/8q1mzccIIJm5U849Hd6uHYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tZ8CvLi5o4ByH5J3sBDm3lhuNEIbAMXq4swOzxTdHA=;
 b=CDXKq4QeUDXEMzff6DGsbsA9tFO5rmsOX1/dHbkDsyB62lcKOXfa1GOUV9vcggV9zLXTTVh4anUJ9801WyyR7R5qLm9t3AEK8gFkhMC1B8WQYNl3ft/1u40L9IboYNSxqNhl2YWBev5bRNdSqm3wi74XR3yamjaEl+OG0ufenTceiHf578GAOKAZ8Idw32OK3qVxS1uiNSFFTV6N3HXmMXZMFm5C6gS+LnpZ0LekyqkNlMxxSeow9d2iYs+8GBzGkp879doqemmDh08zTnJGox0aeaC8AljzL9xKjcvFQPFU5FcJtiw3Ifajlrm+3D95mj+eR1tOVuavjfB1Gg6N7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tZ8CvLi5o4ByH5J3sBDm3lhuNEIbAMXq4swOzxTdHA=;
 b=T+GJemKqcfjH+eJfUxIxu0Gn0AT8tZ0Ag2+bEaXYFqR3pypLsiGlw2ABHI3lVk5Xk6MSRDmz1VWx0iuTsr1j99a30ILZDmWtzzgml2cKob7D+yaIkUv+HfnvM04qmJJ/MUGHvRNmgVd0SlD6ULc+5Ve4PUMGzK+IAr3dIdDeOa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 22:17:24 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::cc71:1a30:afcb:c569]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::cc71:1a30:afcb:c569%7]) with mapi id 15.20.7159.015; Wed, 10 Jan 2024
 22:17:24 +0000
Message-ID: <3f2b728e-6484-48e4-b59e-eab41d293b66@amd.com>
Date: Wed, 10 Jan 2024 16:17:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] cxl/core, EINJ: Add CXL debugfs files and EINJ
 functions
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave@stogolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
 <20231213223702.543419-5-Benjamin.Cheatham@amd.com>
 <65812045c086b_71549294aa@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <83ab6ac9-8e64-475e-8ef3-a605cfafedac@amd.com>
 <659f15d1b4a6e_5cee2946e@dwillia2-xfh.jf.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <659f15d1b4a6e_5cee2946e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::20) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: a609bb37-74fe-4b26-16a5-08dc1229ebe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ht/algVwtw5K0NY6iFCVrgWF86sSj8+V2BTC0C4D36yiQRhprGc00nA6t6suTdcMUzyRlbOQAWVC7diCJ2/yi3PobomPax4vI6FCe//1Xg5YLzSo5adb05SghVEUTsRBG1n1xtJy9BoZHnsvAB0HrhNYaa4NN3V22vMOFT+fpgH4etSoiSmVRxYDrBoMW1s1uDsnD1b9fDKDDEbpGZqmfrFGDA6INhCAz3PbQCicIAWcAKg+gJoAdz2bgHYZq2ZSBpp5B/tpNj0EZ09/YJOXFYqCd0r5KGXFllArEuWtqv8fjo0lOgQZk64dI/rH6pNDMu0kI16buYIJ9J3Jfntx980mH+RRljmt9oTV1tgkOOfoHOdUlY2nK77k+3K7VoLXwnSoG8tVhLJTy3oCwcDFgoozhtwWh0t/qaBkUeMTD/hROYT2TYRGCYP9KU0xsVmBMaz/3hu0aF10NMFck9nTTv9u+5+GayNrKWxS6USVwbGAOsvnP3vuFC1RAV9+H33V+FD/tNFIMp8o06F1qet2Q6QzzQCY3pzNAE+6GgbT1gShNXKITJ11fO4zEdWr7eyQPm3mchvr3ukDTp3bVcFSzmuWCTnX36zMWwE4juj3wa+OomW/wTskOlHOJEgeTcpS4lVn0/cC3GhYsiBt3gm9kA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(8676002)(66556008)(66946007)(66476007)(8936002)(6486002)(316002)(36756003)(5660300002)(7416002)(2906002)(41300700001)(86362001)(31696002)(4326008)(2616005)(26005)(83380400001)(6506007)(6666004)(53546011)(6512007)(31686004)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TU9wdFZlQTcxbndKM081dWRkM1ZrdVhpSjdTK1lYaG4xQ1NoWGtDeG9LT1dJ?=
 =?utf-8?B?ZC9GYW9IYTBWM29LY0NLMHhTWTNsUVhibE5RMHIwRHdRNjFXMm5Qa2VlOFRl?=
 =?utf-8?B?dnlLbS9rQU51ZUg0T3BFcU9tNlBSSzQ5bExSNFBrV3UzMThWUEo2bHFhWlRR?=
 =?utf-8?B?VTRxeWszY1R2eHFMSTlIRXlCOG16ZklNV3JPQnFLQXcwNm1WUTBwdllJSmdq?=
 =?utf-8?B?THN5cnhhQ1RuUXc4MzRyamRhcE80MGJEMHoxamxFdmJxS0pkbGl1ODl1bzV3?=
 =?utf-8?B?U20xY0oydEJQUS91UWhjbFlUSk9pbm16RjNSZGFIUUNncjJUY2tPVkhLK2Jq?=
 =?utf-8?B?UGFlQnlwdFN0aHNOL3hnUDNZOXRsNjJlcTdxZDJqclMrMXRNQU9la1dKcXpO?=
 =?utf-8?B?Wkx4RzlyUWwvdmtvQ2xHU01LdDdxTEhKTVcxU3lMVmwvOW8vTTcyMVF3QTc0?=
 =?utf-8?B?ZnNPQmRWbzNRcmVrRXNuN0VtdnpLZlZVcGpaak5Ib0ZldVRLRERZdEZvZ0Zi?=
 =?utf-8?B?eWJKaS9pV0dBQXhKZHc2V0w3VmFNcWpuM1dWV09KcnZlYVRtczhkVWpiQklR?=
 =?utf-8?B?cW1RYVZhVmZiZE9meGdhNHpTVDdpNlBZOWJIcFJrbC9kbDREbFk5V1lFQ011?=
 =?utf-8?B?cUV2VW1hQWNmM3FPbG5yaENFdG82QTBLWHpleGdZK1haL0xLY0pmOEZSR0Q3?=
 =?utf-8?B?cDVTeElSV2xCNEF4eGovM0tvRlBQM2dLeGk1MGQ3Vm0wbnowbFRMS0NSbUhL?=
 =?utf-8?B?TDM3c3ZRaWtvRkRVNFRCZlVPeUtUWk8ralFVVm1NN0xSaVV0bDMwUkx2a1Br?=
 =?utf-8?B?YVFlZE1mOE1YdXIzN05PWm1ISDZMZVRFVmRldDRvaHk0WE50NmdpemRJUk5P?=
 =?utf-8?B?R1VuUjgrOFNPMzZNZTA4OTRseUtXQmxLMUtPSXRleG5CaElQcEI5L2UzT09Y?=
 =?utf-8?B?eS9VamhxcnZ6RXFSNXYwb05HcUZNajZuQk5BR1U1bmRQZkF2cEVBTVdFdkNk?=
 =?utf-8?B?elRKb3ZDcWVoVXdMQWlQeHJNU3Yxd1FvV1lxSG5GZ3VtTXhJaVJZaTkvR2dM?=
 =?utf-8?B?S1M3ZSt6UEl1ai9HbkxmbUpQZVRudVR3RW5GUW1zcFJ3TkoyeU5LdFQzT1M4?=
 =?utf-8?B?UWtkbkw2MmhKNysyYnIwenAwcmc0Zm56R0lFT3NJRUxzSko3ekxocUpid0hD?=
 =?utf-8?B?SUxJdUROWElTVzhsSWZQZmhqdWRubTgrUDBTWVVXZU1IL0QycmFaUG83bHdY?=
 =?utf-8?B?dmlYK3hReERsU2ZZY3FNWE4xK1J2ZTZJTVVEYnhFL2EveHNaeHdMU1RPdStG?=
 =?utf-8?B?aDRzRTdKUHhEcW5OaHRJNEFRbXZLeFl3a3pWZHUxZ0RKRjlhb2E3Q0dDNDM0?=
 =?utf-8?B?d2Vodi9rb2J6NFlzK1JUSlFXRnM0RFN3ajZtV1FXZHZRaGNDeitKRGNxU3hK?=
 =?utf-8?B?dGdrTm4wTjVSZWdyQ1hldlpnSCtYR0NnczNzbVVCNkRQRXREZW0xUXRGcW1k?=
 =?utf-8?B?aXpRYnJsQlY0RWlOL0ZJa1N6RWdrS3l6YU5YMkdVWjJaV0ZPaE9hQ1RET0Rl?=
 =?utf-8?B?TDdjditSTE9Vd3hIeFN6UG94cGFrM0Y3cThVc3ZwNENqS3ZIRmJtWXhHMVNs?=
 =?utf-8?B?MTY1eFF5a0x4UHdvbVpsRm5uL0VnMkVBbFFoRngrV0dQNDlxT2ZXNjVVV3JN?=
 =?utf-8?B?dlhWNFZMNzM1QnJNYkZUZGNXSkUrbGgreGxLWVNxNXN5SXFGeTFCdDVUQkJo?=
 =?utf-8?B?ZXc1ZWdlUDNSa1NlVW10YlJRaGlhVEJsMFBmMlVPY3NRK1FaTVVZdHh5S2FC?=
 =?utf-8?B?bjVNL1l2S1EyTThxSjZOd2k1ZWpRR1VsWUxMNFJSZ0ptR2tVWnozV2Q2T0FL?=
 =?utf-8?B?MVZjZDlUZEhHOWlFdU8vaHFpN3prdWF1UUJXdm5meEl4Q3gvZ3AxQXcxbG53?=
 =?utf-8?B?RmtTS1doa3FZdG5BaC96M2Q3amxXR3hIazMzR1hiNndsWHc5VEJLdDkyaERU?=
 =?utf-8?B?QnpUdTk4RCtyWVI2T0ZNRUFlaEFlcTlVSUpnRmhZUUM4YS9EdjYwTWhpSGVF?=
 =?utf-8?B?eW1PME1IR2hPbGNjZys3dGxlTzlkMDVTbjlGYjNrZm5PaUp4V1gzU1dSRzV5?=
 =?utf-8?Q?a8uHWz81emRhc3FjtQzKxHBRi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a609bb37-74fe-4b26-16a5-08dc1229ebe1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 22:17:24.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6LqFZ1TIK1dmvEhc9b1xnUbKnQ7fniTPO2e9vmp4HjnQzNUxPl0CsRxRm39SkKORp8uS7knB7p86yi9itoCWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164



On 1/10/24 4:10 PM, Dan Williams wrote:
> Ben Cheatham wrote:
> [..]
>>>> +
>>>> +	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
>>>> +
>>>> +	debugfs_create_file("einj_inject", 0200, dir, dport,
>>>> +			    &cxl_einj_inject_fops);
>>>
>>> I will note that I am little bit uneasy about this ACPI'ism escaping
>>> into the common core, but he mitigation for me is that if some other
>>> platform firmware invented a platform-firmware method for error inject
>>> it would simply need to reuse the einj_cxl_ namespace to make it common.
>>>
>>
>> I'll be honest; I'm not sure I understand the concern here, but that's probably
>> just inexperience on my part. That being said, I don't mind changing it if you
>> have any suggestions!
>>
> 
> Notice how the CXL subsystem organizes all the ACPI interface concerns
> into drivers/cxl/acpi.c. There are some generic callbacks like the
> @calc_hb argument to cxl_root_decoder_alloc(), but there are no direct
> ties of the CXL core code to ACPI details. This separation allows, in
> principle, a non-ACPI platform (like PowerPC OpenFirmware) to support
> CXL without needing to unwind a bunch of CXL-ACPI specific stuff.
> 
> This "cxl_einj" work is leaking an ACPI specific term "EINJ" into the
> core code. The reason I am ok with this is that the ABI is still gated
> on CONFIG_ACPI_APEI_EINJ. Also, we still have the option to require that
> OpenFirmware error injection just call their user facing ABI "EINJ" as
> well, even if it is a different name in the OpenFirmware specification.
> To be clear though no one has sent patches for CXL support on anything
> other than ACPI based platforms.

Ok that makes sense, thanks for the explanation!

