Return-Path: <linux-acpi+bounces-4221-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C5687707C
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Mar 2024 11:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7F8AB2099E
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Mar 2024 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ACC2576F;
	Sat,  9 Mar 2024 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="naK9DAeh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1795C8B
	for <linux-acpi@vger.kernel.org>; Sat,  9 Mar 2024 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709980791; cv=fail; b=n0BsfDygPld7maFHlVeWyO3oJLoj6KJk0CVjL3DopudrdSwsrJA34JkkJ6+wK+FW7wfJLTVxFV+UDCDPDKz92+PvOkXmzQMjxTP/3QVZZTa1OjVPhkbYcDYSbohAvWZSZ+T5HzmxqDPapTsc4FONGNyYU5kOCPx/V8eWDpzdN3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709980791; c=relaxed/simple;
	bh=1TFiksir9rWCwqohUV23xit7aTj+bdbaA8Mrw0Pm4d0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jBTEaSTS9xzU2KCNB0ZhQa0mTudeyxDx8Q4HIcIcOs2z2I0CGjylIx5GAV95LiPY7HX51ZPLO5qikfe6djxAdWDDZHX1Sdot1rF/iC15r06NvHvMvpnTBIMubSehHD0xuUxRSJVW266g/oI4rMKCTzwawZf7FpvHWSGYsWCqFy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=naK9DAeh; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709980789; x=1741516789;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1TFiksir9rWCwqohUV23xit7aTj+bdbaA8Mrw0Pm4d0=;
  b=naK9DAehrOHqIW7ge9kejvYnGJ/KkfMRp4+Nc8UIf8q3Mc4GPR14Vk5B
   ZB2C2SsoEEQBYMw2SFLbRvGHs3P/yfOw3tLxaSY/bXApWUwTM/XLE3WbB
   j/Ca9zUyBxaHBfbqB9AreMEaSkSOnwzE/AvynFpkr1SesOKkVTKRqubTA
   Iekz5PzaPoI30Q6Ar3AL01VJGbILQ9HYln213cu9B+hYfyzLksAt1wK3Z
   EarVPw7GRh4991cgCmrvtm/ZYIbOPOzXQubvpultTGJf6G2MHtmCeJS0+
   ViD7UHGIIEEBYOFLWo4ic5YW+TtSdv07KoPfPf9LYgJcfJpIdqJbKT9TA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="22225002"
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; 
   d="scan'208";a="22225002"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 02:39:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; 
   d="scan'208";a="15355571"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Mar 2024 02:39:48 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 9 Mar 2024 02:39:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 9 Mar 2024 02:39:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 9 Mar 2024 02:39:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 9 Mar 2024 02:39:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0wDYQlmHmmX1G6cpT6FbiW9anX+nt3Iy0KrRPgYeidOPXgoQcNyeIgT8TSJ+9WIk6Uwuxh9ZD4xwM0hX4EjuNQAEKIYa4b6mAIAqRdyRJ7IYbl8GjOS7xyVKwhZrnJWjua0EKUeVx4QbBz9G462frowqS82wjdVPFnVfxChiwqmyYc/MZN2M9sebzOgGwpOc7HahwD7pzjTDlX/IsRp2gQKGwEu22FzCF5lb1s/CsVJ6usArhNLObyKQ4gJvSEPKsj9M/2C/teYgewSUpAhX2VkPcnKBNmnjkRAejiltxNP52yQgyMtNN3KUVZFTSNbtRRH65Tyn4+777xVGhuwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OY/ybjPtWxEkHB9PGCkBmmSK8ubnmIdSZiuIcvyCRY=;
 b=bFKSOwkNmFu11z1yShSscQTd+eC+NBDRRjSm/ew+bqHDKcrdz23x43aYtsX3d2TVKK8EScShVfbi8CjuMee66ENJIW/kR8mq5kiL4mf+Et8YOa60c4NQV5FHK+kDe/K7m2QRGuon/6yRvsxCx/f1Zl0/zcmCxaA0HtSW7ZGlwvHCmlN0I1yvFUpEUyGpHR8TnW533gSBYzXDLx+z8RMwbeMUT32qRX54L7aVBxTpCAdio27fZBU/J/M2A0+V5wiFhBKxC61EcmEGIpxc47vdpFnu/NyE7tpk3p3q/rHBi/B8i2HhnMK4RD92GwRuoRLqwNfibFz+1UEV9NE161pd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 DS7PR11MB7833.namprd11.prod.outlook.com (2603:10b6:8:ea::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.14; Sat, 9 Mar 2024 10:39:45 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cb11:e68c:53db:aba5]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cb11:e68c:53db:aba5%7]) with mapi id 15.20.7362.019; Sat, 9 Mar 2024
 10:39:45 +0000
Message-ID: <dd7b08f4-2513-4b35-8364-2227780632ff@intel.com>
Date: Sat, 9 Mar 2024 11:39:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] ACPI: NHLT: Introduce API for the table
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
	<robert.moore@intel.com>, <amadeuszx.slawinski@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>
References: <20240308073240.2047932-1-cezary.rojewski@intel.com>
 <20240308073240.2047932-3-cezary.rojewski@intel.com>
 <ZesU9QXtM2n2eiZ1@smile.fi.intel.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <ZesU9QXtM2n2eiZ1@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0013.eurprd05.prod.outlook.com
 (2603:10a6:10:36::26) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|DS7PR11MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 60517c80-700b-4668-2639-08dc40253c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2b8RlFHEAY5vRkkOeorqTBuw5b4OrxT1l1UcYy8R62Zwq0h4xrUDp+edh8Lyq3SCiSycVaNmHSDXg65GytUtyz0ZlyHZNwJ5ovRv3eQP3/rcT4tOGrQgJVZvS2VcShYAY9aiLfkXQY7xopoMFyQg5MoUJ3QYvoPP9/coi0gC4yRmL8vLWXoTYufiTWMrlIyVlvbTdw7fVfAHYM3zRAPGgbKKBHYM5ze60677Md7OyDfVdvky9WwvzObY86Dn+xh7WmcPKDOifBHrqBkvaiGFJNyvSNityUGQsAJsccZCAJBD7BuQPvvXGguER4tkSvnaKQPHaRPU9q9EtmOFXb/wr7qXv3noHYYUmloQQq9kYgFpYvjtAprIWw7Q+PDhdKPcsofd37zQCmTYQt2s8K2zTTSQLcHZLkhJNHhSF+zVz01grTK6107A3YhrigXvhZnUeqv5WVDctDOio8rmxyPbq27Fov8omw0f++uyx2R0a5olHw3FMetZuqB4q2FzlCDDPHsMfVbcFn7pfL7wVO4bK8RLmyNOD/UHgiRWkOyb/yXK8Z+2/dOGKOfbEeQjv74S8PhrbxXmJgj10fZ/sdXWdGbSKA3EVXmtnCjYEWCXZc1O/qi09ez2rpGyLRPzLy3Th+fS9RjNNDH3fPPhWxjzmR3lHdpsKinLMKVUm8MOFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmJGNDJIOWVhRWZKRVFpWkFadUtzTGNkS1VOSnNQNWRVTTNqckdSU2Y3dTR5?=
 =?utf-8?B?amxTMUFjSytIVjRUZzlENjJMZ21Sd3dhK21LMkZDTlg2bnNKa3lqQ2g0UERl?=
 =?utf-8?B?Wi9pTTlubmxKWkNxcjNPMmh4enFiR0h2YUIvbzVGUm0wcFA2WXdpZWVmblJl?=
 =?utf-8?B?SmlER3VSQWoweTJGWURMbUNmeEdLMWxKSllmUDdNaDM3MWpUR082cm81ZEM3?=
 =?utf-8?B?UDNJQ0x2NnplbXFUSGY0eFRRVnlPclN0ckdXaS9vQS9NSU53VzhIMXVmNlpv?=
 =?utf-8?B?aUdnNVZadTliSC9LTGJKWjM1K1dSMFVkbnpOVnRwbThBc0VwUTZHMERwMlg4?=
 =?utf-8?B?MUg1b2pjZkVWRDNpVUFlclNXeVFhaVdJSUNJc3RaRTVEdTd2WjBMcmRJVzUr?=
 =?utf-8?B?OFlCNGlpVWJJbTAzbzhsUHJOcFNTVXVWZHhVTmZQNWI3THh5b2RYdjNkVG1I?=
 =?utf-8?B?UUkzbk85MGJJNWVSbWJIMS9WQkphYjRJem5BSFF0ZTdSdWYxZ21nR3FSdUht?=
 =?utf-8?B?MHFPRnlxazFuS3pmRFowc2w0Z3h6a2IyZG9xTC9hVS9vVVQrL3VZK05oRkdH?=
 =?utf-8?B?WW91VVRTbXNJYXVGbGlkR2ltUGxTZWNnL1lmaFp6YUYzWFRLeVhHT29nMndP?=
 =?utf-8?B?L3FpeWg3b1hUMlZJVkdXMWdoeEJsLzJraGpTY1VkdW56cEh5UDZJenZWMXc2?=
 =?utf-8?B?OGc3OGNGZGtvTEl4bHJ2R1dxVDFFaUlaYVZsKzVueEs5N01RRi91cUJZL2cv?=
 =?utf-8?B?Vythbm4xcEdFY0t4UFZ1eGhjaWpKN0lCYUFUeXljV0crbkFIWFZFOXZ0M0lM?=
 =?utf-8?B?S0pFLzE4NmRUSHNCQS9VTVNSRmxrRCtra1ZWZWRpcHNwVSt5MnZ3a043OENM?=
 =?utf-8?B?Zkl2bEZEZjVmVDFpdHNTMm90VWg0SGtXT3IxeEhiT1lkVHZlZHNRWkpVbU9O?=
 =?utf-8?B?Y2NBbEVUa3Aya3hOdW1SaVhSeXdSVURSaGY4QkJnMHIySDZseUpNcVdveU91?=
 =?utf-8?B?cTA3SG44KzVaSlE2VlVqKzhFbHhzaUFpWi9rQ3JVTVFqMzJDbmtWVkhheGR3?=
 =?utf-8?B?aU80ZW1YWVVIbWUyaEVMaTNETWY5NTZPdi9QTkl1eE1vQkZXcXBkMXNxZHRY?=
 =?utf-8?B?SmQyWnhodGFKeEhoalVoMDVaeXhMeWIyb015NDhEVE16YjZYTW1vNkpHMVVO?=
 =?utf-8?B?NCtqeDJEb28rRVY3ZzJZdWxLbEQvSlBZc3k1bGljRjhoR0JpUExkY2svSk9Y?=
 =?utf-8?B?WkVad0dwMTlMTUJiUHNCc3orck9hOEZpRmZWOGJCT2lzMUFjUUpyamFoOGcz?=
 =?utf-8?B?OGxhaFRncEVUU0oxbjltcHl3WTZPaE1MSzdTb29Dd1hteGdEMCthcnY0L21h?=
 =?utf-8?B?aVJGWEJaWU1jQ20yYXI5WE5TZWlMN0VJblM3bE5ubE1qK0trSVV2bWlnQkZP?=
 =?utf-8?B?SUtTWkw0eXZJM0psSjJtUGwxU2NycUxqemdiZTdvTGZhem54dWFtNXNWRTlU?=
 =?utf-8?B?VnNVa1U5VktXTlo3SmlYbmtnUE1LbDRoeDRpaFpjY2h3NGFNdGRybFRRMlo1?=
 =?utf-8?B?SVRiWm9KMitLTVNCRGhUZVltb1ZIbXQ0SUVHM2xOTTNUK1ZkblQvZU9FOHZh?=
 =?utf-8?B?Mzdoc3VHbFBpaklYaGlKbTA1TjJ0ME9IRTF6S1htQytsOHlVcjNIR2RlV2pj?=
 =?utf-8?B?SEVFSi9XbDJSeU1Gb2Z2WWFvVXZ3SkZXMzJXK0htMlVVb3N1NjUxa25GMnVI?=
 =?utf-8?B?ZzFLbFRLdXNNaXh1L01pbWx6b29GazhjWVBzelVNcEpDbm9oc2I3TGlRZSt0?=
 =?utf-8?B?bXBPZ0lGbFpIYkNxaWJhYnVOMGlpZlRxdVpnWlJDUjUwZ2JtbkV5Q1Q3ZkJF?=
 =?utf-8?B?dTRxWXFKVWkxeUxSVXNrb2J5eWp1c1hPNmp4SnJMYnU4aWs4b2UwU0dZc0Fs?=
 =?utf-8?B?MyttdHFtMDRJbmJXUkVJV0pTSjFQRDk1WWtnMFFaZDJmNWZ0dFBNUnM5RDRq?=
 =?utf-8?B?Rkcrclc3TUVMUXhQcWRwTE5Rdi92T3N6d21BK0dJcU5CdVBXTk1LY241QVph?=
 =?utf-8?B?eFRaajY1NWRZT2Q4eTl1ckNQRmVNcDAwaUtGZSt0UkU1WGRPSWw4UThYU2Nj?=
 =?utf-8?B?TGFGN0ZrUEdiRzdPNitIMzhwWkxMNjZLaElPUi9ydHhPZW9KRXA3WExHVy9y?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60517c80-700b-4668-2639-08dc40253c7b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 10:39:45.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wF7IwrmaaJFDfO7aotG9QOnVI1K34ojazWmzVuLo9LndmC+TUNYXEZqjBpgT4qp55vYonUFURii9ag0M3QmXQLY9Cqonli8o0fe4WWVdwlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7833
X-OriginatorOrg: intel.com

On 2024-03-08 2:39 PM, Andy Shevchenko wrote:
> On Fri, Mar 08, 2024 at 08:32:38AM +0100, Cezary Rojewski wrote:
>> The table is composed of a range of endpoints with each describing
>> audio formats they support. Most of the operations involve iterating
>> over elements of the table and filtering them. Simplify the process by
>> implementing range of getters.
>>
>> While the acpi_nhlt_endpoint_mic_count() stands out a bit, it is a
>> critical component for any AudioDSP driver to know how many digital
>> microphones it is dealing with.
> 
> ...
> 
> + acpi.h ?
> 
>> +#include <linux/export.h>
> 
> + errno.h
> 
> + minmax.h
> 
> + printk.h
> + types.h
> 
>> +#include <acpi/nhlt.h>
> 
> ...
> 
>> +#if IS_ENABLED(CONFIG_ACPI_NHLT)
> 
> + kconfig.h ?
> 
>> +#endif /* CONFIG_ACPI_NHLT */
> 

Which tool helps you find out these? I want it too!

While I'll add the headers mentioned here, it feels weird to include 
primitives such as errno.h or minmax.h. Majority of C-files found in the 
kernel utilize such primitives yet the number of includes for these when 
looking at the kernel as a whole is low.

Is there a "common defs" header in kernel? Looking for an equivalent of 
'build-essentials' package.

