Return-Path: <linux-acpi+bounces-11070-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A872AA31806
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 22:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E8D161EB2
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 21:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECDA2676EF;
	Tue, 11 Feb 2025 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWin1nBX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B68262D0F;
	Tue, 11 Feb 2025 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310192; cv=fail; b=m/LQR9S830ow6QGKJ+La4LMGP1t2vpK+P6G0hKN3eqak2UbND3S5thVJbTYT9idV3AcMY8tZFn5hvEIsz+HmRQS1KfdtrU7c7Rp9voUfT9CFc0BQrG1BUysRHh4iwDimOSn5WiSGr7A01UHji2RoiudiFExZrHM0/PPIyO5W7r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310192; c=relaxed/simple;
	bh=EmsrzTLL/50k3QpWa1C861F4LaPiwA2QEaEb96AzKhI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EUg2s3dAHJ7P7uPvd75cFkPi3Q6KGahd055FBsS9FmTkTn1lF2cWI70E1oDfIzDkAVYJ3A/9EjEvM/dMSMhdAqHxaEP3GrvJy9S1lhIjEgV4vaJYQEqpjCa6bhaxHMylI5SxjUa/SR52ZzUGn1HJcccN8U9t8xh96eDGe+dVPDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWin1nBX; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739310192; x=1770846192;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EmsrzTLL/50k3QpWa1C861F4LaPiwA2QEaEb96AzKhI=;
  b=fWin1nBXBbAm9qgwtvMZc8d+FrJaVr5L5umKZxkIZ/M+QphWdJ93SFv/
   n8MKE+WhTf5qDuS9ROyPb1joFHBenaWboteLe2O1R1GwaX2Y8kAjeHmlL
   UvvmCwzXjG5SzrmB3POE8JLTZGB1x9tnXpqbSeq2Oqr/8C7WgzIISJlNj
   JBrGgmNtbQnXHQTfKv7ScF9PbNnmRTvi55yEEDWuzjhFwpRbpRloKG5VN
   rgy1o6kLTzaXvqXcJgEQqG+FWzsF2e1lT0LTQld9jWVccAoOesOXCQ0kF
   rYRjfv2rPdyw/9kqysgZ0fC7+nDPWbJiokQsMg/H5GYhbD6cUXKwkPS5l
   Q==;
X-CSE-ConnectionGUID: epP9HP+PScOmrdLuQnXUgg==
X-CSE-MsgGUID: JUFBqTS9Rx+OZgLlQyeImQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="51342716"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="51342716"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:43:11 -0800
X-CSE-ConnectionGUID: R9rKEbwcRSiGFHBSHwTpmw==
X-CSE-MsgGUID: 7dLtnZiQSJ2LQrs/LOKifg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149816954"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 13:43:11 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 13:43:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 13:43:09 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 13:43:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8zD513maP8tPRzuE7T2rdBJbEF9rzhYRFh/V1RdXwU2PNG2RqmBDUR6VYpb9CELhDDrazQJ9zoSN3bE35mntoTKHECV/RZtVpNu229slCYG+dIeSHcA9o8zWCgT/ttZbfzCidXOJZuWciiugqqknwDiEyCF2QRtygcJHlYYdHk7Lxvwu1eP8+vCtq1mkPI8OjOZ7z5ZvrpN15Z0iKHTygqzYWvztqx6cP9/JqhXwMGBLYoKshEG3jT1hjzPUyVyHKdfsRUjcTsISoj0u7k23AzSGk51Vo402j/dHKLgnib9AbTevpLbHyqk1d14DJSQa0TuzDTsO1YWWV7rYSLl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dee9L9kiretFpXX2Bu92pdILc4nNOgfC4UKip2YcfzQ=;
 b=CCS2ZntRaTQ/XaxIOJGUQ/KXNN6NAsKQIa3FxLIZqJ6OPPhKBTjqoD4D2yg4YK9CcQrFd1bEKXs+n7fErFtaEJaBfOpLQfHujGXfixKyP/+ECfmVwYaaqhFtsYTAgI0WuzKUbduiRnVuBdyI3BnLtl/Es4B8Isc651+ss7OwPOJf4PL9GagvYo0Pg1EqtaqWaKRnNN8S2ky7UBa6UyWXvvHhtI/pKIugX5GfsfZCgr5y7+pGZOp1cg9yN2D1HbBH3mCkl3F+hccItw6QuVr2L3CP33fUwgOjMBicuGaWejNxuYFoHvevzc1WCH/R26pxP2csfJgweBAHLuQ4Mur/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ2PR11MB7646.namprd11.prod.outlook.com (2603:10b6:a03:4c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Tue, 11 Feb
 2025 21:42:53 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%6]) with mapi id 15.20.8422.010; Tue, 11 Feb 2025
 21:42:53 +0000
Message-ID: <ea2d3068-538f-4e94-b1be-765e06e0edcb@intel.com>
Date: Tue, 11 Feb 2025 13:42:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/17] x86/pat: Replace Intel x86_model checks with VFM
 ones
To: Dave Hansen <dave.hansen@intel.com>, <x86@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin"
	<hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Zhang Rui
	<rui.zhang@intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>, David
 Laight <david.laight.linux@gmail.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
 <20250211194407.2577252-14-sohil.mehta@intel.com>
 <24acb878-2b5c-486d-ad8c-72a46b8463e7@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <24acb878-2b5c-486d-ad8c-72a46b8463e7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ2PR11MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 3549413a-b5e2-456c-a43e-08dd4ae50a0d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2lPSmRjdmF5SmNBK1kwREdqODN0OFc2Q2ZVcjZhZHZ4TEc1N1AvSGJkN3cy?=
 =?utf-8?B?UjFmSEkydlpBaEhmdmpqeERxb1ZkVEx6K1d5dWdqNHUzM1RHRzBaSHZJK3NC?=
 =?utf-8?B?TVhVL0FCNG5heFozYjBCNlNJaG9ScWNZOENYTnU5bDB6SWI0WjRKNmV0TGpi?=
 =?utf-8?B?MDE2RGtvRUhjcXdHTWZHdCtHRmI4MnFpK0N2VWlDcS9WbURuUERqbW1wUjZJ?=
 =?utf-8?B?RkVUQTJkbGtDampMN1Q5TUgzVHcvTXB0dlo3bzVneDZETDJjbmFMUDArSWhq?=
 =?utf-8?B?di9JZUd2ZXc5Rk9yWHdhT3BJRTREUVBJdnA3NzVEMEdES0lQOEpPYVZpNmc2?=
 =?utf-8?B?WWpZUjlzMUp4dWsvZDYvOFljNnpCdWRwcUFGdVZxWjV1emZsTnptUmVxN0ZZ?=
 =?utf-8?B?elRtOCtwS3FQajRqVE8zWFNvK2drSkVVeXZDaDcvKzhUWlRpMksvblUzMzEx?=
 =?utf-8?B?ZFIyMTV2UG5MczFIZWhFRlhDUFVuek1tK2JNZFRJUTM1NTA0emFBVWdRTHRa?=
 =?utf-8?B?YVhNak0zSU9tL1E4Tmd3UWhPdW9vb09wSENqdndKNUdPTWFQamNWRjJCKzZG?=
 =?utf-8?B?N3k0YkVGaW8rUjBBMlgycU9STFVobndZeW9PdDVmZDFDZ0h3S3Q1a2hERzVN?=
 =?utf-8?B?L2FPdlQ2K2svMUpiZTFzWkgzcnJTc1FNWWlpdHB4OHArb2RaWVFkOUhzeHNa?=
 =?utf-8?B?cHRrSk1SWmVhd2kwV3lvUWpnWEc0TkR5NWtmN2NMdFBmK3UvTG1PZDFEZ3Qw?=
 =?utf-8?B?RVdsdkt5ejMwNHNzQS9weTVLK2MxTGNBMXpWWTFUbVlKQ25XZEI4RWJVZ0ZR?=
 =?utf-8?B?M0Y0K2I3b2k4UXdyYVZLS3dFV3FSM2tuSHJwOTM4M1diNm44UWtRZmpjUnMy?=
 =?utf-8?B?YTZnMkpoSjV1a3ZZZ1Q0VlJyd3RsVUZOdTU0ZEU0b2ZqbnVndGE0emhoZElD?=
 =?utf-8?B?a25RbnNCOGE5UkNvcnFlSkJQTk5QTWcwRkxOenJicTBlQ2JGRmI2N1J3OHFh?=
 =?utf-8?B?a3lwZXVsZEY2MHBnR1ZjYXJ1TFhZNlJJN2xybHhDdWJFZXozYXZwQUdZakN6?=
 =?utf-8?B?emhEbkFTV3BFY1RyWlZCZUxBRitadGtDMVZYYklmYnhjbHc1d2JSWkg0c2JX?=
 =?utf-8?B?cjJzaVBEUitIb1VFL1BsS2hNcGJ2dUtTVXRhMjI0dFd1ZjdLSWxjZVBmcytS?=
 =?utf-8?B?KzZJY1NrVGNIakVpRS81UTZkZUV6KzRrVDR1TWx4VmE2ZHdaTzhuNmx4dWt6?=
 =?utf-8?B?TnhyZHY5ODdmQkM2bzhWL2JObGpiT3FUWTlaa1VGRkxrRXdSTWU1TFd6bmFQ?=
 =?utf-8?B?MG1EVEt4L1c5eHpSRmV6Tm56bjlIbVVqRWZtdXJndWFCWDFrRFZUUmRncnky?=
 =?utf-8?B?OFF4ditBbGNtQ2owYXVVakc2QjJjTFZGZUtIak5oUW9maGdSNjUwS3Ixcm9B?=
 =?utf-8?B?WlpydlRQWWlLc1UxOVBqZHdhL0xCWCt5M1JJcU81c1daZTJ4bEo4c293VHEw?=
 =?utf-8?B?em03b0RxTEhkY09GZ2xLb2gvY0cxY3BxTElYWG9NWmt1djZ2SDg2b1NkVDFp?=
 =?utf-8?B?RHBYVlAydmpzNE9KdWp5WHZpQzJTaURzM2NvbUlYUFQ5RlJNZis2emFGTXY3?=
 =?utf-8?B?T2M1dFd6cU9xOW52V0Y2UVFHWHkwZjdJeVpNQUNvOHpEcVdXT01ETU5qYU42?=
 =?utf-8?B?R3lubVBQOHpSMGxZK2NCMUZMNFNMZ1h0RTBCNFBuZytKODJxMEVVSzkzdEcz?=
 =?utf-8?B?dTAzdEVIZk9NNUR4YUVMcmQ3UzF0TndwQkdvaHUzVWZLRTl2VGxSYndHSEJB?=
 =?utf-8?B?b2RabnljcUpabytzSDgzZFJVcmEvaWRwQTRkQi9iYlRMdnIvbEQ1aHJYUEpR?=
 =?utf-8?Q?U9NmdgM1PtOC9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0Y1QXBNcjVpcWwrTEkxRGt2UUhOTmYrdWlnUmNCU2hDU01zY3ZjT2FoRFdI?=
 =?utf-8?B?NGlPQUIvd3E2QTlMcEFqMUtBUWVid244cnpUamZUNTYwdXVkZGtqRmVWVXVv?=
 =?utf-8?B?SEczaXBhNENjZERYdTJ3TTM4UnY0SWxsM3RTRnVxUTZtNGdtVElsRkFRbDh1?=
 =?utf-8?B?SDZZSDQvdXhOT3dOMVBQVkNxTjR0MjB2c2xUSEdoNnROdnFpSXZ1Q2pKQXFi?=
 =?utf-8?B?bnVYZUV6NXhRVWdZdnZRNDcrMWxVNk4zUlUvNFE5N3U0YnBadnd0aTBUbURH?=
 =?utf-8?B?akRrRzVxaG5LTnRoOXdEMGtGL2pzbk04REhkUHpYa2FGeDJPQk5QM1JMa3hr?=
 =?utf-8?B?QlowVDMxVnE4K2gwMGx5TzFIM3NKS3AzR2RJVm1QM1pHVTZCMHFvWFdGbDlx?=
 =?utf-8?B?aEJoSEthYzhBdnpuNHA3ZnhKZDAydVVzdnZSUHNLYytXZHRKbTNoMGdsS1F0?=
 =?utf-8?B?RVFTTWpYZ3ZSYnpxTHNMQzR0R3FDTVdLYWkvdVpjOEpKT2YrVHdJZG9qQ1RU?=
 =?utf-8?B?YlRYYUNVNEJTK0YzRkN2Vm56eGFHY0NRSlpCcEJFTGFVSUlHRzVVK0ptVzVo?=
 =?utf-8?B?V3BVY1FQMDhzdy92VXUyQ3k3ZmpjM3hNTGF0MUJkZWJDOE5Ebm1pMHpYQkM2?=
 =?utf-8?B?WmpFeWExNzRFTXBKcXdiY1A3UDJ6c2NYcFd6QUFrTnlPV0dWUUdIMHhPclpk?=
 =?utf-8?B?MFRveXByTXprSUpCL1JLWW1NUVd2ODBWbXM4cW9TMS81bkpTSGQ0VnpyVFRM?=
 =?utf-8?B?TzVDVWVEV3h3N29teXlMT2NDb1FDK09KNjZLNHIrNFJCbzBxalVBUFRDVDMw?=
 =?utf-8?B?YWVYdHpRNUpra1dJM0lmY0pFZk56bit4SmxXbExwVWd6b3VxMlM1SUNjdnEw?=
 =?utf-8?B?SGxzdHE1TnMrREE5dVJDRmNmb1hsZ3JBalFjRGhKNTY5UWlUVmhhaGJGMFYr?=
 =?utf-8?B?OStKVHU2VjhQS2ZyK01lNGFmb25NWXBZRTRqMDFpUG5sY0pJUk9xYlA4OTZx?=
 =?utf-8?B?MVZzTzFOd1VnZkMvN1dHSGVvTTNEMWdYaFlXZWRNNG5zOXlWcjZaMjdGeXpu?=
 =?utf-8?B?QWtISUt2OXJDcnBOTDU2SXA5enVGMjc0eUZTTGc0WWxoWmJxS3k3RzNvOStk?=
 =?utf-8?B?dmIveXByNUZPYjJnVzBrR1lvSTZNTDRhSisxMk9GL2dWVkVEWGNtTHFLVEpK?=
 =?utf-8?B?THVDc01HQmNXcG9OZ1hBaDMrZUZHd0hEa1ZCcE5uY2VNeG81dzBjMGlSNktB?=
 =?utf-8?B?dUQ3Tnd6dnhMdEltYk91eld0c3B1cHNZc0tLOHJCa29tRHZiL0RuU2VLWUor?=
 =?utf-8?B?K2x6aUUrYVRJMXFoUTdraFZKZG1BdFNTVTB3RTVJM0FJT2hYUllQNHZndC81?=
 =?utf-8?B?QzRYY2djR09CNWhjekxWdFZzeVNhTFQzWkdKYmo1NExKcWFRcDV6U0FyUVRm?=
 =?utf-8?B?b2xhSHJoZzFOVTBDWFBCbEU5MHFPeGpuU3Q2ZmExQnNXS0I1b1JxVE1YMXQ0?=
 =?utf-8?B?NzlLZFBUOUcyVCtxeGo3MU1xLzZtTkVhcSt6dzRZVk9ScENWSjVLMXdVZUh6?=
 =?utf-8?B?VThYN3EvTGwrcG1Hd1pzUlhidERBVUEvbTZ5Kzl6eUdITDNqWE01VHl0K1FR?=
 =?utf-8?B?MjhyRUlDcnF5TTZPWGdCRE53S2dyV3FyeC9rYUFDVFEycUgxWFZwOU1oRndB?=
 =?utf-8?B?VHVDWjFRSnJUU1hhcjU5b3l6KzVYajlVZkQyT0NRT2dtUXkvR0ZXaUs4Zmxh?=
 =?utf-8?B?dFM4clFnNEVDRGlmMTdrMmYxNkpiOXZnUzdRTTEzMlVQSjBWZEQxdVgvV2tk?=
 =?utf-8?B?RUp6RERXR0RZUHdxbWh0bXZiemlXSllDWjZxejluSTZ0WFZ5TmRkcy9ydFBp?=
 =?utf-8?B?d3AyMmVBNVp4MExRYzJ6c25RcHlQbytiRWQ4aW1LTVFUS083VjJHa3QwMlFP?=
 =?utf-8?B?MGZoK1ZzTEN6L1EydnkzYno1UXR1NHp6MFR3TFVBdXdvVXYxcGUxeW1kbkNk?=
 =?utf-8?B?dTVPZlNFdTlKeFdxZUZOMGl1OVk5d003MGc2Z0ZyajlaOE1HYzIrUG9TQzlG?=
 =?utf-8?B?eUdBUnlHWi9VWG1ZQ1VNeDRmZ0M5S2g4bWdmY2ZoSXlVNUtQVzlLQ0lTQTFs?=
 =?utf-8?Q?fYwytu9HlNYb6n8tBUB856mtq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3549413a-b5e2-456c-a43e-08dd4ae50a0d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 21:42:53.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObL3EC9V9Xsdw30D3DSTXuNKf1qmEaAjTxoIgebKqdfyzkRtOEOMGDFYZtjDyL2ncvFOwuoEsOCpmA428zKotA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7646
X-OriginatorOrg: intel.com

On 2/11/2025 1:09 PM, Dave Hansen wrote:
> On 2/11/25 11:44, Sohil Mehta wrote:
>> +	if (c->x86_vendor == X86_VENDOR_INTEL &&
>> +	    ((c->x86_vfm >= INTEL_PENTIUM_PRO && c->x86_vfm <= INTEL_PENTIUM_M_DOTHAN) ||
>> +	    (c->x86_vfm >= INTEL_P4_WILLAMETTE && c->x86_vfm <= INTEL_P4_CEDARMILL))) {
> 
> Since these are both closed checks and not open-ended, is the
> 
> 	if (c->x86_vendor == X86_VENDOR_INTEL &&
> 
> bit needed or superfluous?
> 

You are right, since it is close ended on both sides we should be able
to remove the X86_VENDOR_INTEL.

I was thinking if we should leave it there to avoid confusion. But,
INTEL_* in the VFM string is a good enough hint that the checks are
Intel specific. Also, it's not like this check is going to be modified
frequently.

> Also, super nit, can you vertically align the two range checks, please?
> 
> 	    ((c->x86_vfm >= INTEL_PENTIUM_PRO   && c->x86_vfm <=
> INTEL_PENTIUM_M_DOTHAN) ||
> 	     (c->x86_vfm >= INTEL_P4_WILLAMETTE && c->x86_vfm <=
> INTEL_P4_CEDARMILL))) {
> 
> 


