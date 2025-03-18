Return-Path: <linux-acpi+bounces-12334-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7C5A67CCE
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 20:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A3118875E9
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7214C211A3D;
	Tue, 18 Mar 2025 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeSCk+EB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492B1EEE6;
	Tue, 18 Mar 2025 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325031; cv=fail; b=pwuCvlfoMFb5diQHBFhXfWTKGwVO7AESwBdfGKr2+rwO0Iu1b9gsTHmBT1YgqxPKRPXzuxG+BP0P25GXOVeJTegiUBmihOyoO0TJw43f0jQejRS/phPvyeenpYvRH0K+fmvTzSSchhsLL427yIDgDeJQmGc7Wj9cx+8V5fQxtgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325031; c=relaxed/simple;
	bh=aeUFP9ZrumPSTxmLXFYLHUk86RgZClpZBb9Ke+9s1qI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cmqvhy7BGkCeaVI5a8S0RjvNlvyPo1s1ehiBJsxTgSZp29CmwzBskMW/R4MrCPivmNgrJZIfnwx441t3i/HPDFXikEQbxeLOc7gzLHOQvGrcnIbKQzuu6E3XfN2LCA4g4keoqDnpnYPrqFsiSc5prEwfT5e8YHfHDGiqOSseVRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeSCk+EB; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742325026; x=1773861026;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aeUFP9ZrumPSTxmLXFYLHUk86RgZClpZBb9Ke+9s1qI=;
  b=BeSCk+EBjpR63DBTs3gBOyel9Lrm9FQHatfVoXcrcwaPAq1/ntyHQT4R
   oqT8eN1wtdmo2BBNBE+kFXm6Atu9QJOhN6A10AQH7XmFAqO5iaPxXMl1z
   1SuN08lcc2fT/DyX8D4Rv1yUi+TefZYopSwrK/ESoFZWnDm4wG15z4Jsv
   Iz6w1DnQSae7KuTban2ds3oUV1ToU6ToOjYwhkmTAGBTXJKyPs/e/FLrd
   wul3Yp985x2NNxcIDp+2DFPD/7zTWv1YzYKq13Lnz3sksFTfCDfVCKo7l
   VRikR3AKWZCBZ6tuEebHHC+szbinbfnaZ7HMkJOFP4UhfqDKQyat4lw8w
   A==;
X-CSE-ConnectionGUID: jVDBAjfYTKCVa53Z5GmlWg==
X-CSE-MsgGUID: V+ezE44jSMCTNF5E9ZcwkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47265145"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="47265145"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 12:10:24 -0700
X-CSE-ConnectionGUID: XSIfq077SQaNYAmPlnE81w==
X-CSE-MsgGUID: 1v2iphC3SpaQ9fwzWtTw7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="153350070"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2025 12:10:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Mar 2025 12:10:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 12:10:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 12:10:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAPGC6dlnMv1o/7ZBcMSkGTvlNyHnzBtIUN/q57xLyVlCg4oLBXwVR1zFPNvTOdeuemFuE6c2BHbXu5pvRv0/Sr9zekH9ZQJquWLWI6uxORZviP8gC2v11eI6RUYHpK2/hwwcRI12u/tfIdb4PgCHyuh6KAZVYEFdjf/5r45HT9QDFrjxhEoUJPYbiG3qHwaJVjV1PCBAOFZoSyWFtJdpq9Zd/lzxMy1Ky+815X+aKxr4CWLls4hi0qv0vQQNPM8KzbC+T5KooEZ1Ko8tm/4DuAHWH2QrYyaoRmBeC6kywAFVrIA9C/eDYOg1X3lmTohc1FH19qtfmZWFHoVB+HLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JdjNKPMynySDPxN/W2XBU4W985u4cRICQkbWKJCx9Q=;
 b=gknqFBZ8K7KEYKHkmDDssuxMERA+OxqfQ9qW5jgbJja+doiK8d5uiDbO8veE4dyuZUbG1GJ/GiN5aSS0bDPS8iAqdb5jtWgKV1g2W7qjUHjmPXtKBl7Z83eeMfxiv8sfuc0xDBz08rZMyO+2EqGXalZt2DxOiKA/lOQbfpNauq6WpiPOfABD1yN+NjVNuSr/NMpKissSQV6oCd9D4duwwgo3XE2sCeIkSfbpqmV2+RLUE1VX3rW2KiyHP6eNf2WnDZhlmpmy+8gE9skl3poeC3iYe9jKfd7qK4AZaQjNh5H7CIF98u2tvl+3Y36E64ePEQ4rekogEIhp+x55GR0XEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM6PR11MB4689.namprd11.prod.outlook.com (2603:10b6:5:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 19:10:21 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 19:10:21 +0000
Message-ID: <6758e958-a4d7-48b8-83ff-4bcb98f87340@intel.com>
Date: Tue, 18 Mar 2025 12:10:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Prepare for new Intel Family numbers
To: Ingo Molnar <mingo@kernel.org>
CC: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Arnaldo Carvalho
 de Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Zhang Rui
	<rui.zhang@intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>, "David
 Laight" <david.laight.linux@gmail.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Tony Luck <tony.luck@intel.com>
References: <20250219184133.816753-1-sohil.mehta@intel.com>
 <df1b95d7-c953-4757-b742-3072f65539f7@intel.com> <Z9m9B7BmoItsfjiM@gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <Z9m9B7BmoItsfjiM@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0370.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::15) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM6PR11MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: d395e732-4a8c-479d-b22f-08dd6650873c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzlrcEFTL3Y2RUhQdEpQTDFkK2dWT3h3eVhqakM5cnMxSzU1aVBtSVhCVkVW?=
 =?utf-8?B?ZHNpWHFnZkxMb0wrYmJSRVZac1AwajZRQzdhQ1JKSmdPSjR0cndYZmJ4VXlU?=
 =?utf-8?B?SVc5M2R6SmFQSHlwaWZmQ1dHbGFIS1d1ejYybzdHY09OT2N2RktjVUZ1ZEZp?=
 =?utf-8?B?ditaRmpaUlVLV2t5cER1ZDVMTGZ2cldMdEh6eUtWeHUzT2VhMjFoZjJTaWNk?=
 =?utf-8?B?Y3cwejhYSThVUkFJeWE1aysyTVRCTUg4OE52SWEvdlQvSjZRSXhEWVVzbEp5?=
 =?utf-8?B?RUdXMzNWSUFjMW5mSkdGTVYzNElnbWhjbzY0bjFRNXF5MmhoWUpSRy9vdVRX?=
 =?utf-8?B?akEzTWFOSi82SlhNeGJWM0w2Y1hianZpTXhPUXBpSHh3UEJJUmRObDZYdEVS?=
 =?utf-8?B?M1MyQkd2RlJlS2svazZoTzNiSWFoa0JEdVo4eS9hYlVndmFTYzRPNVRyWE5h?=
 =?utf-8?B?T1N5K0xxS2p4dlUvWFZmc2Npb2I3SnRUOVJZUXRHWTZPZXpvUnZsZVhRNCt2?=
 =?utf-8?B?RVlZTklSZk54VThxTDZPSHEwNHNIdWpRWDk3ZjhRSlZXK1NUTGhBNHc2ek5L?=
 =?utf-8?B?cVFUeEF4amIvMG1kUGRFS2t2MmN2Q251ZjFlN0gvTzhiMEFTZnZ2bGhHYUxC?=
 =?utf-8?B?VXRRcGMrckVNVXB5QXhjTSsrbmlaeFhTaEg3N1kwcDdXUVYwZk14RmU2TEhT?=
 =?utf-8?B?SmNoSVBpdlNZMG0rNmV0b3JVdGlxTU5va2ZRdFpQSzhnalhjU0ljc3FKWnky?=
 =?utf-8?B?YzVGRjdSY2lPZzNBZlgxUFdidTR3UUM3S2VXL3RGSVRzM3krZWFXVlZKU3Yv?=
 =?utf-8?B?WjNsckRGQys5SFp4UndXQWpTTjVRWSs4VGJWY25pb2xKMmZ6S3pVYW4yVFlP?=
 =?utf-8?B?Q1VDbTBqRUV0VDlLV2trV3EvZnZ4aGYzZlh0S3JuNHM1TVJHQVhmVDBpRWRo?=
 =?utf-8?B?MW1jb1A1dG95VmpCOHZIb2FmMUdaSWxlNkUyOVRFRGdqQUYxdysyMUovbE5S?=
 =?utf-8?B?dEtPakFpMEpzSVBrcFVWdmFjMFFGTjgyRTZyZzlxSGtxMnQzQjNQMlZmZmRC?=
 =?utf-8?B?dE85emd4TTlGWHlKNVdLb2tFNFRHYTFmVEdjTHMrQ1l6aGV5NU94cmdSdTN6?=
 =?utf-8?B?YzFkamVRclYrYklKZXFWWVYyTDVPb2crOVFkaVNZcmlqVzd1VzQ0bGhzMmtv?=
 =?utf-8?B?aElwTm5RK0h2Zzd6ZUE0UEd4Q2IreEhNbGRuR0NoVUY2cmsycXcwMXRmNElS?=
 =?utf-8?B?K2IzMnhvTjFpQnBPLzBhenBuWmJsWFVWYzdLOVFrK3lLM1pOUTg5d2tuM1Va?=
 =?utf-8?B?VFdaTDc3YXFuTzlneWFOeDB4RURudlFUQXRzdHNpZFkwZ2EvZ1p0ajAyZElR?=
 =?utf-8?B?ekFIODd1aFVOaE14WlpqTVNrd0xTTGF0WTNRZUUrTitHdE55WTdsdTNjWTRT?=
 =?utf-8?B?bUZoQzFuR1dIYy9mVkx1MjM1WWNuWFhsY2lVRndjeTg3QUhiT0dRQUJWU1Zw?=
 =?utf-8?B?dTQ3QWVHWTA3RTlTV0oxOXg5TXF5ZlFqdnU5OE1ZRW9CeGdHZXlPVEx2MlAw?=
 =?utf-8?B?VlpiQVZsL3lRZmMybDJFeVZBV2JiTVZWWWRVVks5ZVk0YS9Nc25uL0MxeTFV?=
 =?utf-8?B?M2dwd0N3UjFTaHI4Ti9VUEE3dCt2YTRPZlFHU0dkN3NwRU1xVmNod2VFR1FH?=
 =?utf-8?B?WGlaM0cyd0pSQW8vanFDSlVlOGlLNWFjRDNFdGxzVmt5WHVmNDBncjViTzF0?=
 =?utf-8?B?RVd1VHRFcFZnQUM1S2FrdkZQMFRSZHV2UmxRR0ZnNXV2c3ZFYmNBZlN4TFhV?=
 =?utf-8?B?cmY3QkxkWjk4bjhIR3MwOFVCUzNzOXVWVzRQZjNvRklkMzExOW5JNWc0TjJK?=
 =?utf-8?Q?KyJMgn0+zyec2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXpucEJMU3NPZ3luQXNOUC9tdTJadTBVNlUxR3d6MG5Ub1JhRzBreFVrYmc3?=
 =?utf-8?B?REZpeFR3WUVaMjN0OTVqaUxEMldZMEk1aHhOcmtRQm8zSlZXazdMTHNZc0JQ?=
 =?utf-8?B?bE9uTU1tUkRyQ2ttYWcvQzc1cG1GZy8vS1dFa2krL0VNQmxML1J0ZldKRmpp?=
 =?utf-8?B?aDBZa1RzUDFma0p6c0NOVmxtcDRJUkdwdklWTm1XVGhENjJEVHczVFJCNlJx?=
 =?utf-8?B?aWJsU2o1NlcrcnQ4MVIvcGR0VFlySnNLRGFmSVYvOEtuZHNnZ2E5NkFSbTVa?=
 =?utf-8?B?MVJUdStzOXAvWTBXYmxscSswV1p1WU02MGhuMm1FTW90d0J1YUVxaTdicGhD?=
 =?utf-8?B?NEZTZHo4NmxqektkVHNsQXVkVlVnM1lnbjNqSmttaW96RDVmQXBYQ29ORUZz?=
 =?utf-8?B?L0FYa0FlTGNSdTVpa0ZDTjJFV0hSMFpmbzJFZFAyaitldGpGeE8vVzIvME9R?=
 =?utf-8?B?Y1QvS1pyU0FpeklaUkxLNDlJRDFwZjByUHBPUnlaazhTcjV3U1NVMisvakE2?=
 =?utf-8?B?YmxxTlpJR3VaRUt6dFJOWTNHa3BOMU1yTjVQaDlHWmI5VGxHSzZSZnVac3hZ?=
 =?utf-8?B?dWRDbFZNdDJIa09mWXR0YWtvelZhdUxHTyt4bFkvSGJEV0ljRDZCWjNiVUdM?=
 =?utf-8?B?MDhmMWZoMkR6ZE9OQmpibXB3MDlmTGNsbUxTeUJmSjluL3pFMWhGVW9DRjRi?=
 =?utf-8?B?d3pENVNQb0F1ZXVmN3grejRZTnBaMWZpM040bzZpV0JGZVRZMzlkRGJEam55?=
 =?utf-8?B?S29TdzNEeEh0R0tCYWFBYkRDM292TTJJQWZXaC9TeXBITXN6N1UyelJBVmgx?=
 =?utf-8?B?R1J6K05tczBhV0I1dk5laTc0KzBpckx1SjBDQzQ2SVZ5bWd3OXdXUHU3S1lV?=
 =?utf-8?B?WlNZK1NMUVAzNWNVcjhDZHEwRXA1U2lkWWlOK1hKNUpyN3REbGpnVGRDbFhh?=
 =?utf-8?B?MHZkT1RMdmtYUFhnNC9SdjZUOE5STlZlaVl0TnRXSHB4M013UytjYUZ3L2hO?=
 =?utf-8?B?UjhrZnhGZUozbjZ6RTJxUWFuekhocWNBaFJWUjZhdFBMcDc2RGNDOFh1WHhq?=
 =?utf-8?B?TkpEVjBtQVhZZ29OVXY3QnQ4OXhhMmd1VGVUQ3hCNkc4ZW11c0lvTVcrbkhM?=
 =?utf-8?B?ZndpRXM5OWcwNkN4RHhCQkxCNFh5QmlQUHJNcGNpeE9wMDExZE96Kytmb0tE?=
 =?utf-8?B?aFQxS2xGZVhBcGhQUVhlSlRydXRoTGpiTjJwZFJSQk5ScGpIdXZwRUlUYkF4?=
 =?utf-8?B?MFoyaVdOck9NZjdCQzBvbUwzVlp6bHBuZFozbkNIZTg3OEpUZXRVcFExNGpY?=
 =?utf-8?B?aUNVQlIvVkpxRzh2QkF4U3h1Nm9kSWtzWHdIejJvUk53TW96bDM4cVFWbEFG?=
 =?utf-8?B?bGMvYlgrRDl3cjVyYWhRMzBNb25kNkhKbHdMR2ZnVnRpZi9rWi83WlVibVNm?=
 =?utf-8?B?OVFNZTlraWFQNGtEUnNWRU5OM3FFU0ZtMWxkcnBubktVaDVXNHFxU1RrL1dS?=
 =?utf-8?B?TnY0Z0tJS09zOVMvK0FwMnBaeDJYcTBOYlNkS3RFTUNrbVY1TG1HWGRBVTM3?=
 =?utf-8?B?WnAvU2xBc0pFSW9aeXBaTnFEM2ptdnVmbEcvNy9IWkdmdnpqWjJ1eGRQYSt0?=
 =?utf-8?B?aVk4bGVJYnA3MExPKzRVZXJtYjFNYjhYOWdRR0hIV24xSFp6RjNjS2tFVHpz?=
 =?utf-8?B?elBHTHRZWWN4MnN1YUJhVHQ4MWlPQ2RlTVBKWW1vdHB4a09oMXdDV280NFRO?=
 =?utf-8?B?bjNVbTRRQmRWRkozU21RR3JhcnpQd0JVU0JZZ3dMeEdWdWtsT1A3bm5NMFRs?=
 =?utf-8?B?eHdnTjUwcDZGTFBaeE9UQ0QrNkNxajN2dzZYdkYzNlkwZTNjN1NnMDFSUlZG?=
 =?utf-8?B?dzJIZ3FUWUZrdEMrYWNPQzI0M1NzNWFkK0Q1VUwwU3FMNVVaN3ZUYTdGTTI4?=
 =?utf-8?B?V0I5NjBmZjFjc2p3ZjV4blNQNjhVNlFUb1crVGlMSkl0cXBiUnRLeC9XOCtI?=
 =?utf-8?B?L2xlSytmd0JhcXorWXBadDBraExIRTZ0M2hGYm5hRjdVam1qbUFrWjMvZGls?=
 =?utf-8?B?L3d1bE1HajFaK05qU1E5dUFkSmlsZXdvbUtiTUMwYWlpR2gvcWowTnJRb1lO?=
 =?utf-8?Q?eMCnoIiwQjPudNlPb8sFDHzbv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d395e732-4a8c-479d-b22f-08dd6650873c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 19:10:21.0758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohBi0clsbAf1t1DEYWGl6Qb6NrEp806F9py76gZqZsKH/s8PjkaHao4hc2+yidsdJpQJnnP2s9dlissH5xLTRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4689
X-OriginatorOrg: intel.com

On 3/18/2025 11:35 AM, Ingo Molnar wrote:

>> Most patches have review tags now or are simple enough that they might
>> not need one. Patch 11 can probably use another look.
> 
> LGTM, but I've extended the Cc: list to make more people aware.
> 
> (I did the same for some of the other patches that could use extra eyes.)
> 

Appreciate it.

>> Patch 14 is the only one that has a minor change. Seeking additional
>> input before spinning another revision.
> 
> I've applied the first 13 patches to tip:x86/cpu to help move this 
> along. I fixed a handful of typos, but haven't noticed any functional 
> problems so far, so unless there's problems in -next this might be OK
> for the merge window. (Famous last words.)
> 

Many thanks.. Fingers crossed!

-Sohil

