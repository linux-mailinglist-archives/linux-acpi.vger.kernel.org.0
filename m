Return-Path: <linux-acpi+bounces-3456-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7F68537C4
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Feb 2024 18:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C491C21846
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Feb 2024 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C75FEFF;
	Tue, 13 Feb 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R/5kmhvG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FF15F54E;
	Tue, 13 Feb 2024 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845364; cv=fail; b=BfGv0FFEb2GaE8gzNl6bT5iEitr71lpvkACkxZwogw1/SeyV20MM2L5eJXFZc8Y3SssS1sMXdq/h2d8vDTwBgpAjh6XkPC5oi4a0mwY7e89BFaq2At6wCmTJa3q46pjmYFqHgMkA6RE1kkB6VnNyDPrenR76IP7fDTA3GY0V+Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845364; c=relaxed/simple;
	bh=ENYwT2pyzbyXCXoD9TQV6mY2Phq4LnUoWVOn3o8/JwI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mQpJXB1x9cgCliW4230IruAJsuExpp8Qx+ab4kCP/hkf5IXuwtfCrtSb1nd0Lk5+EMRq1w5c0cjMoLb/G7UfekmcezvrX2gPeRWOgmna2vgY0/NKqHXOOklUXv3oXgX2lK6B9tVhBzBKaeLY68INN1InAiANIqN5agyAW/fYuYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R/5kmhvG; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW3u1PhLLsQv/sYQr+KK0kIEgufSbFl4iwdZ7As4S2zcPQRE/BUo0HP7i5aFi727W7l8vxYsh9fJSlzajimoKzfOhD7EImGbVf8ESRTR2lT/4f9ygztJ/f9bBqlzd8EF4FeTQxxbzufReliqjthE6jNreI1Levi5Dqz5j2nw73F/CLgCIc7ztOoYe0FR7rnMLF3mboJCFytoqFkutabTf/7m0d8lpJ2ZC5UERSiWhyIlwZvDKLBPkM21g581ZAqtCeGW0O1zYiu7OTJU1zxktu0mXZSyri+ojqBX8TRLbuS1hbRf2r096k0XpQcNFX43KlNdNvzHepFW+TXwAyz3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+U1Bfw5nHL/tYHnmj8HRzSlzPvbtboA02RphWst+kU=;
 b=N8qVSmHWZoJnD1lKU1KcWIa7CU9du3KFeZVeOH1X9fUwsYBhQ3ddba96Zu67BT6HzWemM7AaZLaPuffvaWknxUWX9RrWjBTBOxaexskkE7WuE41Xr1qzjXppgpT5jIjFcjppoKEWfu31tTCAqGt4tQ1x2hsZbFXzwpkuW/ED4eMAh5jp06BDuSmuEw9aSbgo8sSMS3DcRGu6OcPhYAdLedq7D+8DO+g4RLSU/MOBL8MoOJpoZu0uRO1/HER8UfqL81hFj8BgeFDKOxhITij9YgQDdpdBbHjHmSYsqa4YMCNk0GJpA0Ft6+OtGnGiY0ieKXkLFTRcn3zWmzAd732KbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+U1Bfw5nHL/tYHnmj8HRzSlzPvbtboA02RphWst+kU=;
 b=R/5kmhvGIycPkESmL2DjTFfK7kxeBdxOQDgmFickQDqP22r9dGA+Mkm5Z1Z6lY8rQ15BneDz3N6QrI4XjSc7w5H4iff97188h0AIMOQYtay49Jo8XEJyXCYD+SeFV48vdcgbQN/1sMcQlS8KyZmpunc9j5xpY+KkK8VRjmHakjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Tue, 13 Feb
 2024 17:29:20 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d%7]) with mapi id 15.20.7292.018; Tue, 13 Feb 2024
 17:29:19 +0000
Message-ID: <81f10f6b-fc67-44fc-a190-450df00752fc@amd.com>
Date: Tue, 13 Feb 2024 11:29:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
From: Ben Cheatham <benjamin.cheatham@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, dave@stogolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
 <20240208200042.432958-4-Benjamin.Cheatham@amd.com>
 <6cd90997-0dea-4dd6-ab8e-2630efaa6209@amd.com>
 <65c6bd181bd36_5a7f294dc@dwillia2-xfh.jf.intel.com.notmuch>
 <65c71827726ae_5a7f29434@dwillia2-xfh.jf.intel.com.notmuch>
 <2329b256-184a-4646-b92c-7d3f8589474f@amd.com>
Content-Language: en-US
In-Reply-To: <2329b256-184a-4646-b92c-7d3f8589474f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0095.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::36) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac2a02b-34c7-4df7-5c76-08dc2cb94f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ulWA2S6bHCPQWz1yothA6Oei8Fwt80Vhnrw94KvpxqevOlHBGUhZ8aq7FbkXOGKK9bB5ElbJJASTWHQdL7Abdswhwn9jTjTRiSSAUDWPNKLqMCpNtjgJia9Lcm9nUGFpaUB4RSnGyKXe2ajTQi4A83UFjhioWTyf/JVmIAB30I7BOdiM8Li8z6zFnPGEZymz3CrnTCqhDe0QF9oWIn5I5kBsR6EqA1+cE5YID5u5yjuXG/byBDvK8pSgpKr+XT+gN7NldSJmKm0RVQ1DrqD4KkD839V8TC3hLilWXeyCEjpyO/8z7VZ8mvSzUxOhYIO2ZWhnd1tqUSXA1fJFdo503R2u2eJN+KCCmPakAaWunBeuKAzWGWXMxDTRZYnEYFP+Yl3VVgQGbCBGj/Apfh90TTx3973fJvybmc6hic00sqHjlh9oGZgBhBP4bYhBT9m5dVn24v8a+WOFXjwOMar6wv3OrDb5wJrj8VZi8sqsyMx+3Pd+L4/7Nfx0uiG8gh4Swg6L+rZekKZzMbk94ZSRsVmHAr3jOLX3zvgCqxDTocO3AkXSYEdQOjurjaABOme5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(31686004)(53546011)(6666004)(6486002)(478600001)(66946007)(66556008)(5660300002)(66476007)(7416002)(4326008)(6512007)(26005)(2616005)(2906002)(36756003)(38100700002)(6506007)(86362001)(31696002)(316002)(8676002)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVp5aVZpbXZmL2F5K3I5cWFmcTFtSHIvTE04NHhURURsSHRrRm5pZFlqWnRP?=
 =?utf-8?B?NUpIRVVmSUMzZDNuQTNhNkk5U1lVZGZFQ1dyeTJrNFdaS0F3VS9oZ05saFRs?=
 =?utf-8?B?OWJVU2RSKy9qdng2Q0x3RTVDWXBoZ2YvKzBTWW4wOFFMRlpXVmhUVmxsL0hF?=
 =?utf-8?B?NGtqN1FUQncrSHdDVVB6MUxuUmhvdDNYYUNFelhqaElLNkFKakRjdldCNTAw?=
 =?utf-8?B?YXByRGdZR2xWeXlSTjZ6ZVFzVFltNUxrbzJ0UVQxdW9vVGMxQi9CUloyanFz?=
 =?utf-8?B?YlJJWFlWTnc2VFVKMThiMEYrTjVSUVZrTVJZd0E5SVdMMDA0b1ltUVVmQmZQ?=
 =?utf-8?B?MC9HUDVSOGJIcnA5MnFtYmNNVUtMajV6QVdpdVN3clVXYmRKaFlYVkF2TkNF?=
 =?utf-8?B?V3o5alpiYjhxQlNxT0p1dTNkUDNHSXB0My84TmxQV3NjcHZEaXFtTVVoa0tP?=
 =?utf-8?B?QXVxZmVrcElaWi9kNUtSTTZROG52Uk1yYm5rMkxoYyt6cE8zRTE5NVpGUUtj?=
 =?utf-8?B?bUJGNW1uenJlaEJtVG5mbE9WemNHWThoaVlEVFZ2Skl5UTFxM09zUTZBa2Qw?=
 =?utf-8?B?Zy9OUm5teVpMS3V6b25DMjQwTUIxaTdXRXd2bHJ2TFlsdXB4WEVRR3JNVjBl?=
 =?utf-8?B?cXJKcXhxOHB3anFJWE5vWk54QUJEVFdscndHQWYxVVkvMUVRUWd4RUNXS21H?=
 =?utf-8?B?c2NnbTRWeit3Z3IxSk91YzBwNHQyZkRFdksyM01MOUtpNkg4SEJKRFlNZUJ1?=
 =?utf-8?B?YldQZmJsbXJMSStTZjg5ZG5sc2lSZWxHVUtqWHNLeldZNkZMNDFScDhuYzU5?=
 =?utf-8?B?U3NUM2FxQWhpNjVtY0NuaGsyZWZoV3hlUWJHN3M5ZHJ5bmYwOTcwMlQraml2?=
 =?utf-8?B?dDFQU1hqSHQ3L3lta0xJVlE2VkxwWVgwbVREYnc5K2FqYTI5UTE1S2N0T1BT?=
 =?utf-8?B?UFJyZFpyMEd4M3pWMVpCd0VESWZ0bjRreU9ONHo2a0wzbkF5aExndUk1YnFJ?=
 =?utf-8?B?UWdVWEFDQlNTcC9xdDdiSmlxRHdnOFlXVm9xUGw1RisyS25QYzVkWWcyR1ov?=
 =?utf-8?B?S2U0dmdRNHJoUlRvcUM4TWh4UVZIbGZiSldSMXJGUzZvbTJ3OWZGVjIwNzdK?=
 =?utf-8?B?ajhTWHFwSEszelBOSExtREU0bXBNSGw4anN6dEV1UlVER2xVSG1oZFJGZU9T?=
 =?utf-8?B?K0dJSW5UTE55S01TOHdMSUxGTExSSW1rN0tZcW1rNUV0NWhRNWZETGZlYUFu?=
 =?utf-8?B?RkswUXVjUnlkSG4yMlhIM012dTBmeWtUMnZ1UjRPZDRIdHJSQ2VFUE1ZQ2dS?=
 =?utf-8?B?YW9oM1hYUEZRdjJNeGtubGE2ZSs0VjlrNG5JS2hXNjBaemJVVkR5c1RBVGRY?=
 =?utf-8?B?NjZrVCtWSExXSTJhc1V3RVhPT2s0OTBYSFBSQzN0U2hvWlcyN2hyR1ozSVJy?=
 =?utf-8?B?SXNWNklrUlNmQWNuNkFia0pYU1c5TzllZWFsMnFObTBkdVV2V2lZVkxZakpJ?=
 =?utf-8?B?ejR2bVhwSmhXTEVxbmZIMGVFa25Wd25Fa3FxVGRlMU01S3dYZ3RiQmRMWVpT?=
 =?utf-8?B?K2FqM0hkUFJ1aTZmSXN2SGM3U3BqNDRFemVDbTNBaFV6eTBoU1pGYktVTTg2?=
 =?utf-8?B?eFZjN3JXcXZoSXg0Q05mMFd1N3VpcW0vc3E4MXdrcW42blhSWUpmQXNOeFhC?=
 =?utf-8?B?a003OGlJZ1lXWVF1ZG9kWm1QczN2L1huYVlTNm4yeUIwZ2o0enhiek42RUlw?=
 =?utf-8?B?Q0VWNlFsd2MwWGFsQUk5bnEzU0x4a29odVZrSnV2dFVBZTNlVkxtYzNNQVRz?=
 =?utf-8?B?RGF5Tm1yV0RvbGQ4RjlGS3gxREQ4U3k4dEJoejl5T0JweHl4OTdXQTFIRURn?=
 =?utf-8?B?emRvQjZvQVJ3RkNRalFWMHhreHJoMmlnR2JsTnJUZ3YwaUtSeW94TnFzNGFy?=
 =?utf-8?B?L3VLYUdKQm0zMnVPaDU0SzFsZXlNNnpFeWtoVEM0ZlBVcEhpWHFqZHpWL1E1?=
 =?utf-8?B?V3pOYkNVT0lHeGVQRHNXV3FKVXBZNkkwNmlURnc3bDdrSDhGMjRudHRzUGcx?=
 =?utf-8?B?bmsrQlpJOFZoaWZvK2REYm5BQ3d1VkkyejVxV0JjUGJSVXg3elBEWm8vNTIv?=
 =?utf-8?Q?ZAefyN9ngkhLSZqm4BX2s9YWQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac2a02b-34c7-4df7-5c76-08dc2cb94f87
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 17:29:19.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BeBFbIfwFdritL48g/il3jDdg+mTf7WYVIhS5gndnQqWvdRi6hLtByTGrMTQMhu7bHN5o9xK2SRSnuFGQYDcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184



On 2/12/24 8:12 AM, Ben Cheatham wrote:
> 
> 
> On 2/10/24 12:31 AM, Dan Williams wrote:

[snip]

>>>
>>> I don't think this is the right fix. CONFIG_CXL_EINJ should be disabled when
>>> CONFIG_CXL_BUS is built-in. Looks like the polarity the dependency is
>>> backwards. The problem with IS_REACHABLE() is it removes the simple
>>> debug option of "send me your .config" to see why some functionality is
>>> not turned on.
>>>
>>> Could you test out flipping the dependency from:
>>>
>>>     depends on ACPI_APEI_EINJ >= CXL_BUS
>>>
>>> ...to:
>>>
>>>     depends on ACPI_APEI_EINJ <= CXL_BUS
>>
>> Wait, no y == 2 and m == 1, so:
>>
>> depends on ACPI_APEI_EINJ >= CXL_BUS
>>
>> ...is correct, but you need IS_ENABLED(CONFIG_CXL_EINJ), not
>> IS_REACHABLE to guard those exports.
> 
> Ok, I'll test it out today and let you know if it works.
> 

Alright, I tested it yesterday and that fix doesn't work. When I change the guard to
IS_ENABLED(CONFIG_CXL_EINJ) and set CONFIG_CXL_EINJ=n and CONFIG_ACPI_APEI_EINJ=y/m
I get a redefinition error in einj.c. I've found a 4 ways to fix this so far, here they are:

1. Leave the guard as IS_ENABLED(CONFIG_ACPI_APEI_EINJ) and add IS_ENABLED(CONFIG_CXL_EINJ)
around any calls to the functions in einj-cxl.h in cxl/core/port.c.

2. Change the guard to IS_ENABLED(CONFIG_CXL_EINJ) || IS_REACHABLE(CONFIG_ACPI_APEI_EINJ) and
add a IS_ENABLED(CONFIG_CXL_EINJ) check at the beginning of the einj_cxl_* functions in einj.c.
I'm not a fan of this one since it doesn't actually change what's built and just "artificially"
gates the functionality.

3. Change the guard to IS_ENABLED(CONFIG_CXL_EINJ) and add a #if IS_ENABLED(CONFIG_CXL_EINJ) guard
around the einj_cxl_* functions in einj.c. (I know this is pretty undesirable, but I thought I'd
mention it for posterity's sake).

4. Change the Kconfig definition of CXL_EINJ to depends on ACPI_APEI_EINJ = CXL_BUS.

My vote is for option 4, but I figured I should ask to see if you (or anyone else reading this thread)
likes a different one or has a better idea than the ones I laid out.

Thanks,
Ben

