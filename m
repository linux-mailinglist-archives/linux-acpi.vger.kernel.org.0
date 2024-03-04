Return-Path: <linux-acpi+bounces-4093-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 739C9870BA6
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 21:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10D51F22772
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 20:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9668BF9;
	Mon,  4 Mar 2024 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLacKLan"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0B6FA9
	for <linux-acpi@vger.kernel.org>; Mon,  4 Mar 2024 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584452; cv=fail; b=BJpsv88DlN1wia20JYQkKZAtElaYyqtTHJXH+Z/5vjlHqMVxtO1PZh2AQQuV9hkS6sexN9KMTD+MRDASsmHPQc1foKwCVKzHHj/7tCyl2wQBTESY+9n9Is/xCv/2SCphm0564STcjnllmei18hiZaZ3aLfePvUBuveuXHUI1Hik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584452; c=relaxed/simple;
	bh=4fI8T29rbob6FgZfYS01Ks8xPwh4phstvXJaVqZHJfs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rawSxKSPwFxC+B9APrz2m6jv+ORpACLGrqOcAB4prMAVa566IpvWzjPg3yjd3KI+SY6V0ViAF0iuog8YiphRAGthX+iaxomBtuyySOE9Z90pB+jmIwPeJH5ouqp+LcWCfURafwFieuqwe+eQviymq5N5Jwfzovetk0Re+Agqwn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLacKLan; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709584451; x=1741120451;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4fI8T29rbob6FgZfYS01Ks8xPwh4phstvXJaVqZHJfs=;
  b=iLacKLanNHgTzXvXhPicm5YJCLxCFT5VAH5XQP+EhfR+JkYkdhIayrc6
   M8TcifYwvHcpCT0o2R2Vs+4FZAfVsgnV09G32oyMFK/ICDDjPhKW5KSoU
   BuQIRA1mMntryFsEtI54cJRsO9LHWtnXSlr4wsH5+FfiuC76+6PIJZZIG
   ck5wrRwIlCUJ3PMAMlvYFmcPcMNsm1LeXvr9+Za/soEANZrWDC6XiqiSS
   KBb6GaKcCTUSLSb/TKsy9pzXqiJl5CMgZLFriejm7dY//PPX0VGiaEzU/
   YlPF2KUB7ppr4UA2x+//9nmIm5ZYRwIQg3BYNyRqBJaT5X/95iKZiLdtG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4026866"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4026866"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 12:34:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9062872"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 12:34:09 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 12:34:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 12:34:08 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 12:34:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwKhYwzypWR4ZdSm/3yzsj64R7XVzDZJVfEygY0C56uIAzTanr3LHy8T2Onc5edgqjxmne4T8F108NbbMC0tvjv03f8TqPEUn7i5/5HE9xZDEslZYneT2Su8xdqkfWfm0NV/UET/J0DLjxzeIJK2MMpnvys2fXjFZSQcqsOFEI8D2ckbumi2m6Ymz+GKWXz8E3u2C/+EGj5Krdn36HamjPKx1XLQUbDZhYndKNgRS8Je0fMy26oPE0EbHrlKhVVTEzkS6nX/oi3B49K5w+JWPilwK3xHUpaqNioSY6l+mCve+BPWrar0z2K402amSf8pxZGqcsKUj8j5lX74oHAu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfwqzAs/7HW7ee/t9fj69r6VZgLPlI13DolJdyoeygA=;
 b=QFGcd99FsaTdJM0XvRkBzJOjr8Kvsk6yFkzCPrgxqvMVM8ILeyhVqrnigMPVLC00TBbt4aNEXz4ltnAjEuq8suBq8o+0pLFRMxludctJs0YvhJ/cNmqVY0ktXB29uEJVBQ1BXoTI0/PHOyqFTXe/hqgl1aFort/8NkzXpZUs9XsYXkMC7jaccdlTLm58O5kLYkcWCUjknVrdj7hxkbbjdTHAt/Z/lTOZJmI4XhnKHOSQkM7oj8p5vTo2ch4Av0sLv2v6hMjCSjqilKmlzrUIXLrd3rm9wYK+W1g23su9wPwH4gs7kApC3Ye7jclD3us8boUUD0BWUCpAPg3x33FAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 SN7PR11MB7068.namprd11.prod.outlook.com (2603:10b6:806:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Mon, 4 Mar
 2024 20:34:05 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cb11:e68c:53db:aba5]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cb11:e68c:53db:aba5%7]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 20:34:05 +0000
Message-ID: <312ff9d7-8b90-428f-b90c-ebb278e029a7@intel.com>
Date: Mon, 4 Mar 2024 21:34:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] ACPI: NHLT: Reintroduce types the table consists
 of
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>
CC: <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
	<robert.moore@intel.com>, <amadeuszx.slawinski@linux.intel.com>
References: <20240304161335.1734134-1-cezary.rojewski@intel.com>
 <20240304161335.1734134-2-cezary.rojewski@intel.com>
 <0d1b777e-bd95-4755-8e4c-ee37640d155b@linux.intel.com>
 <ZeYlrwqDQLAcFcnl@smile.fi.intel.com>
 <17d55fd0-8884-4f05-99f7-abccdda0e174@linux.intel.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <17d55fd0-8884-4f05-99f7-abccdda0e174@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0044.eurprd04.prod.outlook.com
 (2603:10a6:10:234::19) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|SN7PR11MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: c78494af-efa5-4cb9-ccdf-08dc3c8a6f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFUZQs0t34smUf87YUA+NrzerlUkA+WyOG2ATB6rZMGuFj1wi8X+ValrdZJ5Z3S5pfgRe9N0u5zkjJKfa3rBMYzUDUF1ybvlcTj+RVTw9jCUj9AMGyfEoPjkYKlJItKJ2Caj13P4VmHUHzVYhDfHA0kcWEN4MEfxzKr8LR8z2zCz9m32E+UOYaKa1+YUHwNF7d1NJk021xm+ynERjhxRbLNKmqeg3jokhGsJsYUR/LFPyFJv1XQUrB5zRwVOUgR5OG+z2Vqpu07x5ibE6VGQ1zen7T0GUUnRbs9x/y0IZ70vh1B78Uai3QYFuOpJkzPoGCsJQQai+WVP+K5BsWSfQw/GKEhY27uyglEUBsElB8h/jwz5yTfvsfgbH46ixVAzJQPsPlFrCAMzPxhvJne5W5AQ3JQUGnPx3+GuUlRc5q29vJZ/5CeygrZ9hx7KuwRBZFi2DIN9nD9ax+aN6Ymhzp2aPTVk07fBOfzS2dw/2E9AQuQFDltK9GcfCldZoKM1PVLD6aCBWuM4iuYM+dgpPzi214rQE9NDXj2iJQecdcBZkAMaiq/90HQA9p0BeOQnrrK9uesovUuCW9qHti4PEw21v3VTCBmfclAH4r17r5/VjbbKNFvDE5jxGI5G3Nmny+75mr/kPBkqq8ETwF3GsTdG9XnVthbdMwaecvv5bsE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wmp6T04vWmhzdnZWbHVLYXkzZVNlcTNXNkU5bUxoeVlFcVVMMWN5eDE5WWFP?=
 =?utf-8?B?NkFkdTVST2RmZjErZHNFbk5HVGhxWWJUb1NCUlJqVXlSeW9haVErK1NaMWVx?=
 =?utf-8?B?bjhUQmtPYnVFQjY3UkxRU1Z5cDV6VmVwaE81UENaSWFMUWRCVjNLenQ3UWor?=
 =?utf-8?B?U2RUYm11SExXSUVmajhLaHI4QWNUMCtQajR6Y1FzQS9oUFQrTjBnNnpRZmZS?=
 =?utf-8?B?LytqTjhiWDBoUG1iUkJWZ3ZoRUNibFVqb0hOV2NleVNxVkhQN0dtYSs0TmpQ?=
 =?utf-8?B?YjV3eXg1aWJoM1l3NTRoVGM0MFFxejRNUTlmbUl6V1VOUHM4U0ZUdHo2L21F?=
 =?utf-8?B?NGZ4WlVOTkVORXZ5TFY5ZE5nRWU3dlRSYWFaSFFEOG9iS0ZnSUZ6dldZUVZK?=
 =?utf-8?B?R1QxTmh6M2lXZ1RFRjJOZURwK0krWk5JeERyV3JPWUV5cE9yNEFrRFRlN0x1?=
 =?utf-8?B?RkRUeU9zcmxSNkwxcFhWc0VSTjcxc1VwUG5OMXcyYzNaSGdwRDBGbDRhY1hU?=
 =?utf-8?B?WFkrdzlVL3JGOHdjWCtYdmlIekFuOFNyZGxBSlkwTVBSZWtUcWdvanIwVnds?=
 =?utf-8?B?MVI2SkJDWnJJMGs3WHFhb1AvdVlkaUw1L0pRdWp0eC9ZbmdJVEYybHA1dU0z?=
 =?utf-8?B?NnhxVk9Qc2trd2lLeEI5S01RWGY5WmExWmlZMWJ3UUlYc1IwdENCTFFGSnds?=
 =?utf-8?B?Uk1uVWZvcVlhMHMyb0hoU0xxK0hsdFNlWnNzQ0I0aE1hbnlYM0hoNk13aS8x?=
 =?utf-8?B?aGdIV2NNbTJ1dHFGdGJLZGkrSFdpcGI5RXlMSDhCU0pjUUJ1RVdTRDVNK1JV?=
 =?utf-8?B?RUhxUjQ2MHZTSHZGU0hvbm16QnAwK2pSbjNyYnptY3o2YkFQMWkyN0JtWktL?=
 =?utf-8?B?RlJpa2Y5Nk50RnBHNHZDWm1VWEFXRU1uTk1YYWFvVEZlSFZjUldJTmhwSzc5?=
 =?utf-8?B?WmN0dllKTVNPOEowellqbWI1Qmc1T2Z5QUxUT282RVdqeGsyUUErNnk3cjJt?=
 =?utf-8?B?UmM3NE4ycDhISWJaRU5LNTlCSys2QVpJdy8xWW5ES2lBNGd0WWZyNkFsbjNs?=
 =?utf-8?B?eXlOV25xelFEZndIb0VMRlZXV21PTHd3djBGczJpSGYvcktOYzA5aHE5M0Jx?=
 =?utf-8?B?VjBZZHRRZkQwV2xvbWdqejd1WVd1cmlzTzJmd1BwbWVOUW1YQVNpNE04RWhL?=
 =?utf-8?B?Tk9sQlozaml3UWVoQmVxUlBGNjJDRTBpRDNLVzlMUFFWMmFFNmZyK3VTRGs0?=
 =?utf-8?B?czZYMzNOeTRHaG9SMUFBYWw2SkFLRkNNOXNMeW80TmdkcUR0T01KWGpNQnk2?=
 =?utf-8?B?WVlmZEg5VmZhbE0xMTgvVVpmOTBZUHhEd0YvdGNITEY0Uk16SG9LbnROSWZP?=
 =?utf-8?B?WDN5UnNtVFMvVTRJVlJRblNKU0VXUnZvL2JsZWFQZkR2V3ExVm5rR0Vubk56?=
 =?utf-8?B?ZThPK0JKQStYYXVHaU9LYzJJWGFIK1YzNW9rWTZWd21jM29Xc1VDT3VYMmlL?=
 =?utf-8?B?ejgxd2ZGY0s3UGhZS0Vmd3E1N20xSTErSkV1WGZ6c1NwZkxES1ZOU2VJUUIz?=
 =?utf-8?B?NGlUd1E1T3dRKy9JZnZZVzIvU1BnNDAzRlJUTEg3ZlQ5c1dQMEtPOHRaWHo2?=
 =?utf-8?B?aFMrOGVxNFRWOXpTUUlFakJqZC9jQmhwV2VJR3EwMTd1NWh4Y0dNMnBFRy9T?=
 =?utf-8?B?bFVtWVJzUkQzWmVjbm1SNExQV2J4cE96Y0dHWnhwbi9WeXJHMXRMdmpCd1M5?=
 =?utf-8?B?dUcxeGZVd1dLQXJSa0tlVm53TWNzV0drQjRLcEpDR01PNSsrMFVRY1BhamVa?=
 =?utf-8?B?dlhjeG1sdXJMNXU5K2ZGcUdOTDNETk03UzV2OU5pUzZxK3Z5d0NsTjJFc0lx?=
 =?utf-8?B?bGwwdjdFR2M5R1ZpalBPVzJnRE96UmtyYnlVQmVOWWYvTUxwMXUzUWxZOUxa?=
 =?utf-8?B?OGxyNWpDQlJwVFpjdzNOWWFVays1Q2krYlZuWUhiRitzRFkwamJTVUJ0Ky83?=
 =?utf-8?B?cVVtcFJnWWlhSDBkY3lMeTJIb2lJQndHcUF4ZmxYTTkzcHc4QmNhMVBEb1Jt?=
 =?utf-8?B?VFoyMmVHczl3Ym1lclRMMWJIUnRaOHovRE1BVElGQk4xbEpCSEUrNVI3Vk45?=
 =?utf-8?B?M2pVdDVQN2tOYnRRV20zZHFlYWtVSnBoTFhaTzV4elhrdzlxWXFGWkRVWFBm?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c78494af-efa5-4cb9-ccdf-08dc3c8a6f5b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:34:05.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08pyskJevb2Bq9Qc4ErYqnkpDkGbxmwQDnfbKJnpLmQy+USxEruwCvnhkIzCHFb491PG5cyLZc8GWCPWgXxTI/EoYuYOj4aVSAEBb6vOGQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7068
X-OriginatorOrg: intel.com

On 2024-03-04 9:22 PM, Pierre-Louis Bossart wrote:
> On 3/4/24 13:49, Andy Shevchenko wrote:
>> On Mon, Mar 04, 2024 at 10:57:39AM -0600, Pierre-Louis Bossart wrote:
>>>> +/* Values for link_type field above */
>>>> +
>>>> +#define ACPI_NHLT_LINKTYPE_HDA			0
>>>> +#define ACPI_NHLT_LINKTYPE_DSP			1
>>>> +#define ACPI_NHLT_LINKTYPE_PDM			2
>>>> +#define ACPI_NHLT_LINKTYPE_SSP			3
>>>> +#define ACPI_NHLT_LINKTYPE_SLIMBUS		4
>>>> +#define ACPI_NHLT_LINKTYPE_SDW			5
>>>> +#define ACPI_NHLT_LINKTYPE_UAOL			6
>>>
>>> More than half of those values are not used. Is there really any benefit
>>> in exposing them?
>>
>> Sometimes a code is the (only) documentation. Since it's a global header and
>> part of ACPICA we probably better to expose all bits that are defined.
> 
> NHLT is an Intel-only solution - no other company uses it.
> Intel does not have any designs where SlimBus is productized.
> 
> I fail to see the wisdom of exposing a non-existent option with
> LINKTYPE_SLIMBUS. It's not because this case was listed in a document
> that we have to add the information verbatim in a open-source header.
> 
> Likewise for SoundWire we do NOT use NHLT at all...
> 
> Options 4 and 5 are completely irrelevant. 0 and 1 most likely as well.

Hello,

How relevant or not given field is in LINKTYPE enumeration is.. 
irrelevant. Those values are reserved since the dawn of the table. 
Renaming those with range of RESERVED_X(s) is hardly an alternative. On 
top of that, specs which have been publicly shared since 2016 _do_ list 
the non-I2S/PDW constants when describing LINKTYPE.


Kind regards,
Czarek

