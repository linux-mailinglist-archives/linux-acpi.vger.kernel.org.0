Return-Path: <linux-acpi+bounces-11068-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2001A317EF
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 22:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79238165E2E
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 21:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEEF268FCC;
	Tue, 11 Feb 2025 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9gWp+Qc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B67B268C76;
	Tue, 11 Feb 2025 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309970; cv=fail; b=SWpEKxPPP+M7ayd7wNyBgEvCLNrVk4BX2+ScKB6Lfyzq9UZQ76iaouckzrSry4TEjRs20+Bqxcm0YBK1+xIo9+fZ9DRrjJqXa7ZXolR9EbDK0rDXSw5uCmAaB+2kM60mvjtVWcyV2/LXKz+IkCDnr+ao55EHc4DE5vQYvN5xPfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309970; c=relaxed/simple;
	bh=kDeGQBSLErxFh/Rurnuk8HjGn0STGcYdj0W9HiS7yFs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GCoOf0V39uv8Wr/PhNSNyjCMFu+h9/25FEmDjkaClo7+Aji0VTl4GKXxWdYic8/Fz4KJlmDTG3FoMDObK1vE8kHn5KXtjqmHP3QB8xveqwZjx3GNcxG8vqx9vtcvw4Ut38BrAejEXamYUTIFs/ayX1p/Xs3S0a+5toGtqgBq+fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9gWp+Qc; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739309968; x=1770845968;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kDeGQBSLErxFh/Rurnuk8HjGn0STGcYdj0W9HiS7yFs=;
  b=R9gWp+Qc6Arhn4M2Hl6h/C5UNrx7aqBTN5DvdXGvOTG4itk7bjt3qj03
   lDO6RBpsbJTpwfXMr4BWUAYowP0rVH9GSoWwPzq24EGZPy8b0BilyQ3/D
   VAAerg0ETXWcdEMRu7KCSYGEEx7mExxIF49KyyjMg6cQDAL32/+iQv4J0
   WWX7HTPoHCxjjslu0KnMzfsfZU0vmPBnGnLZCtKNCNQBb/6gxDBnvvWq/
   AW7GPEO5gFlfQBVvjXxcBlfHbKC5+/EbUzohLMb9tU7EpfUocpdihmsxR
   w7n3Hn8s31J8Gr33t9s60r2pkI42Z306XWJMlE3CS9/iej283oViRds7c
   g==;
X-CSE-ConnectionGUID: N2I5FmLsT7WkBhcYOFRR6A==
X-CSE-MsgGUID: 9MXa0ah2S1+Uo8cz/JNLUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40091315"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="40091315"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:39:27 -0800
X-CSE-ConnectionGUID: OIqYTme5TzShKJaMmcgc7A==
X-CSE-MsgGUID: kdFRCof4TsOsN+kGYE7IRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116718697"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 13:39:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 13:39:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 13:39:26 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 13:39:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFmHcodhqHIPUP+HSL+AFmMQ/wnWneJRYCByhfn16BtRqSqqMmNdTIYkJ93aVlu40XXYnaZBJr3r6tHSLU66n5q14UKnVMb9tp/+jgnT07Z2yh2kwm4Owh3P1RWWf0+WKL0rPHL9fehePiWRlSjSY9jd5H6r4gFYpYuwB9WHFw3bo+K5LKlgareBNEMcprezZhJZ7IYG4dOT1WDv4P54y6tK57ipip3UOlsDe+q+Jgb4tl08YT9Km58QaXbk4X/LY/VTGPND8AQqxtS5WvBPHAzD4LJdcCdl+zmQWxJSSFX3C7LBeVwfA7CNeTgyI1sdV48Chq63O/OEbDkcYvp0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efatJwz4ZrdJfEF4kL4dW77SUVHeFE3YuBJNfZRc9DA=;
 b=idt1YJUNFTXEuSiqS8m5PardwtFsSrSxVtCDtFsgbEFP6Jhu98GoVM8KRNWcxE2V707iemcs/loerTcggqp4f9pshkQG6JY4VL62e6uNIAyfNM5bKir3YE2y24G2dmJfNo2HrKKzvii1b86SX2NCa8/QMhOguKQS51fB0TiLsiEG44z7JD5GIP2GJDWJnTn0ERu0T9qSLdQ5yVfj9FVFSwDV+GFOM1LTQk9I+ACdgBuFBc1JmbbTZdM42yidQ96Rl1tR8DeGoFcoc+GqA3WbEmmgsNeZZnkTnPlEm5IQAGUl2lRaCwyXzGeaSYcw8W0oGsa7s6ViA/1KN4gmbUROfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CH3PR11MB8520.namprd11.prod.outlook.com (2603:10b6:610:1af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 21:38:56 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%6]) with mapi id 15.20.8422.010; Tue, 11 Feb 2025
 21:38:56 +0000
Message-ID: <882357df-7600-4aee-9fb1-4a118872f1af@intel.com>
Date: Tue, 11 Feb 2025 13:38:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/17] hwmon: Fix Intel Family-model checks to include
 extended Families
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
	<viresh.kumar@linaro.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
	<linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, "David Laight" <david.laight.linux@gmail.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
 <20250211194407.2577252-8-sohil.mehta@intel.com>
 <23e24c79-96ca-45da-832b-83a9b6456208@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <23e24c79-96ca-45da-832b-83a9b6456208@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:40::36) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CH3PR11MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 040f68e1-e310-4814-f481-08dd4ae47ca1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXJCQXlic3Q3c2xlQ3JETXJoQmt0dHV2cC9TeFdJQzZqdVh1UjNZUVJDZ0NO?=
 =?utf-8?B?R3hyYk1UZ1k0eUZFOVcyYjBrRTZBbWM2dE9zUXFHQXhJdU5pa3M4RXlBc0U5?=
 =?utf-8?B?VGtvNDY1dUlBZDV3MTZaNUZqSDBoUDM4TXhJeFc1L2VCeXJKbUZUR290Qmkz?=
 =?utf-8?B?bG50ZXUxS05GamRGc2ROZEVmODV3Wi9wUmF2L2ZFSmI1OXV4WkFyMmt0a3ls?=
 =?utf-8?B?Ti9JeXBhRFN0d0JxUlFjc3lYRkRaMzNpcnN2VnpNd0ZjRDFuMFNoNjZiMWRZ?=
 =?utf-8?B?dW1KMHp0WTJ1M0kzTVVvaDJSVTI0UUdLUzhkN05GVU1palZaVnZUL3pnbFJD?=
 =?utf-8?B?bERneVdOZGtvVEFtTnU5NlE3ellEM2lTWC9DL3gxcU0wZ0JSbjhKaERDVmlG?=
 =?utf-8?B?ak9VV0dCTEtiZ1ZmQTFWOUZhUWZZbEtmaU1DU1pwVW5iZUZlM0pycWM3Uzlx?=
 =?utf-8?B?ZDJIRVRqSjVIVnAyemtCN3dzWW1GY25mZDMyQ2R5SW9QTWxWOWMwVWZZei9G?=
 =?utf-8?B?bC9aMEtBakRVRUI5Ulk2cEh1R00yeXBOdHRkbFYrZ1FhUitXQU14aUJlN1Jh?=
 =?utf-8?B?c3pqeUYyM0J1YjRFN3hOZVVzQk5rNFRyUjl1Y0ZIcklKVkdUOUY0M0tUUElj?=
 =?utf-8?B?ZkJ4UGVEU25Zc2psd3hQYlNzTE13NkNMTWR0Z0JwQytlRWlscE9QT2ZyZVly?=
 =?utf-8?B?QitPbVYzNFduZDZpUE1odEE1NUhlZnNRZEVyK3REMmorQ3hicXM1VHIvb3U2?=
 =?utf-8?B?VWE2QWJISzZTdjA3MnBXbG1jN1FNYVJOUzRweEdYRFpxUEJMV0tIMEE2UGJy?=
 =?utf-8?B?NlBKbjd5S2hTUCt6ZGJmMERnQmxYc2orSlpKRmp1SWlsTXB3UjVmdmhib1JS?=
 =?utf-8?B?YlRLVHhBZnNFalF2cGJvNC9aWjlaUVJTQU9EeFRBTSt0SmE0YU9aWDJZd1dN?=
 =?utf-8?B?TU9ET1hpdjFFQjBVaWpNM3l2RmVhR1RkTTAvVno0M1duWldZZEw5WkpaTnla?=
 =?utf-8?B?SlpQVURqMExySjVOQ0txY05uaVMwNXhSZDhsNjRmT2FoU0NzeC9NQ2Z5Vmxq?=
 =?utf-8?B?UStvcWpCbHhTbkxPNXVFWU1KK1g3T2htUlgvRmlMblI3WUJuVzk2RllTV1k0?=
 =?utf-8?B?YTBHL3czZkJNQXlGdWxZemMwbmpSREtkTTR0RlIyY2loTmg4Q1NFaDh4OEtn?=
 =?utf-8?B?ZFFwQ1JDemtTdDhaR3Nmblo0eVdwM3FXSzgyNWdaSDRaOFpyNXhLRkN3N0Qr?=
 =?utf-8?B?ckc5bW8wVStkQTVyLzd3a2tSUndyM2hnS2xTcmd0WWlhTkFvRUQwT0RMdWJl?=
 =?utf-8?B?cTNDMG9CSGhReU5lREEyc0VmRTF5WExzRVNkSjJMTHZ5Sm1MU2hmRm9kQ2N3?=
 =?utf-8?B?WmVva243aDBXOE9QZ3h3Ump2UjFhNGZFNW1aeExqTnYrT2x3aHNhRG1YWEJB?=
 =?utf-8?B?d3Z4bHlGakl3cm1lRVN1cHZVUWRISUtIdndiQVB0SkFrNEptNFhoaDBmbktI?=
 =?utf-8?B?Ui9Qd08zVHZuNWhucXZFbzIrb2RkU0o1Y0lGYXRhZjFpRzZLWDFkTU1yVEdD?=
 =?utf-8?B?RFlOSTJCaTkzQUhDQkNtMnpNMTRLZ3pCdU1ZUVdwOTJPeHIrM2Z3aEZ1NDF2?=
 =?utf-8?B?T2V3bnJpZCtVZytDL0xEeHc1WTdsZTBtRDNXSFZhMUpVMGRNb1JXalBSb21W?=
 =?utf-8?B?dnRnbTlDUHhkZ3RvUzcwOHFEcFF5OWRVclpQSXBuU0c2RU5RMm5ENEk1dERP?=
 =?utf-8?B?M2NLS0xhWTJmc0dVMUFJSFltU2VvYjZFY0RNaGozZFpsdTUwTm1sOFRCL1Ro?=
 =?utf-8?B?R2VmTkE2dFZHREM1aGpHbUtJRC80cThybzNMLzg5dDU0K1ZKM3FEQWNOcHlP?=
 =?utf-8?Q?WiU6lE8NSprdT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmx2SlpjKzB4MS9WK1lTcEkxSkF4R1E3RUVnU1FPdDhOU1hLRnNsMUkva0Q2?=
 =?utf-8?B?bHdKaU5zS081YWwrYk13TlN2SFlDQUFqN1hBR1Rwd0F6TDJmMXRtR0VGR0xh?=
 =?utf-8?B?OVg5dVg3ckxCc3NSdVQ3NzE4TnhDajV1dTJvTmdmT2c2bERwTFo5SzJSd2Nj?=
 =?utf-8?B?b2JNM2NhQkRXekg3Y2hhWHc2ZnE5YVBwNlM2YlJSS2ZsZ09EYlAxQXRhM0J6?=
 =?utf-8?B?S2VlKzVjejBGeXNkemJHQWVZN0MvSFE2eUE3cWV2RDk5K0Z2dkE3N0swZGVj?=
 =?utf-8?B?aEpnaU92a3duaHBlTUY4NGRNRWhxZ2syQkJhRzF0UHhwUzBXM3VmV2JZWEVR?=
 =?utf-8?B?cElrZGF6a25uRFRjRnJCaDRLNDJiZ21TdVFzRFpHRHpadG1YWVFEZ1FFT3A0?=
 =?utf-8?B?MUI5S29tVlNlNnB5aHluU1k2cWJ3UDIxZms5dy80N2JWc3lkbm5RYUg1b253?=
 =?utf-8?B?ZHNrSmpvU3pUejA0K0MyUXFuQnlYT0JlOElpZGRST3NLM1laK0RoNFNZKzdE?=
 =?utf-8?B?SVN6OElqczVienI0S294ZUovOUtGaUtSZFl4amJMTDFrcXJCTmNIVTRTOVlv?=
 =?utf-8?B?MDVienNYLzFoQ1pnd1IrNlNqREJQQ2hGb2FlTEJhTDlxMFQ3dlFuQmtrbE9a?=
 =?utf-8?B?K0hWWmZWY1JRbi9VSmlVSlQzRVVFNGRhYmNFeStISndNV0tTOG15c0dMRVEx?=
 =?utf-8?B?YTgyampObGZJUmdDM2NDRElmU0dKcjZIdC9hZU9POGlYQkRVRjZYSWp2U0dR?=
 =?utf-8?B?elpSN1BhUlZ5NzliSmxWQXJFUzI3TEc3L2Z6U1BabGF6YzlCam4yRVVHd3Fo?=
 =?utf-8?B?ek9WSy9NY2cvUitUTTE4QjBmRFdvdkpBSW0zL2s5NHBqcFR3ZjJyRmJVcFk3?=
 =?utf-8?B?QnRDNll2cmlPT05hQkUzd0M3aEZPR29CNWcwSllYKytQY3dkRGkwaDVYS3Ft?=
 =?utf-8?B?a01KSDRnUC9jNHhmNjdmNVlDMmxJMW1zakZvSjNTSE8wV3BFWjBIYlBEUnI2?=
 =?utf-8?B?RTlFUkcwamNmMm9nd1RQUXZKTjVUazNLNytVMHU3MHdINGRkZytHTS85eTRh?=
 =?utf-8?B?eHhjZlBpUHEzaUE0ZVNhdy9LeXlmMW1CRTh1UHZYTnVYb0h6aDdPa1FEc0Zr?=
 =?utf-8?B?VStZamNLZFBISG5MbXVyaldJMUczbVN5UUtKMWxmaFRvT0d2czlBMDdTVTd3?=
 =?utf-8?B?QUZLUEo2aUxEY2hVSW5FS3JrUUdXRHIxdkNKdUtnQjhqNE1ZaTh5blI2ak5F?=
 =?utf-8?B?Y0Vhelc1bnFmTHZrbVlmYkswTVpUdDI4Q2J3RkJBYkFXaG9FRFFVTHZtOXRV?=
 =?utf-8?B?RWJHaWxRbk5PNDVYKzhXS0llRDVocGg4RXpUWDVOY0trS1RSWUY1M0dkeWZZ?=
 =?utf-8?B?eERZR1hEcXowUmdZL1NrdmNRQXN3Nkx3RlZBRC9aVlkzajk0ZGdnY3JudkRk?=
 =?utf-8?B?R0NrQmd3TVdJR3N1cHJDeEppQXp0UEJKOW5HMXlYVDhJVEFkWjEwRUU2WE85?=
 =?utf-8?B?c0tMSklLdTFKc09UeHFGTThBeDc3VW5HY0g5Nmg1YTJvcHAyN3VINnFTWHZk?=
 =?utf-8?B?aTkzU3d2UVF1TUVOUW4xUjU3eFZ2QVBKSWJBTUlUbWY4RG5KRnBXVkJtMGVP?=
 =?utf-8?B?d2ZjenVZQlVKS2NGcFloaWVTOHBXeDJzYkFQb2RMNjFGdjhuRWEya0hZSjNo?=
 =?utf-8?B?WG55Ujl1Nkhxb0pZRkxVTmo2WkRHa0NYYXl6bFY4VXdxVk5jemdPWTFxbHFC?=
 =?utf-8?B?ZFJOL0N4eWJmNnpnaWo2ZkhvQUVwWGxyQmYyY3NVeU1vbVV2TDNLOG42RGdL?=
 =?utf-8?B?MmFIY2QrTU1najhaWDNqR2tXcDZ2Qi9PblkyczQyS2svRDRUSXNBOTB1SHQx?=
 =?utf-8?B?Y2tqQ0ZIdVBZN1JKaTlkei8zOUNmeWJQZHFLOHlMcnB0cWRsaTJUNFMyUmdL?=
 =?utf-8?B?eUNzekk4clRpbnI1dU9JWEtJRzVyL0FPMVQwWm00Vm1yRzNQZ1hGaS84TXdD?=
 =?utf-8?B?UnlrTktIdjROZjJiM0pxOG11Sm1ycGE1a1JIMzdWNXg5OFFPTnZiT3lYa0Jm?=
 =?utf-8?B?UkVQakNCb0E0bHZ0OWttZW9Jc2c5RkZXTEhXeDk2bTRmNEZDSVNZTk1MVVdO?=
 =?utf-8?Q?V6/zs5cuHeXXbfNDqRLBXx/nJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 040f68e1-e310-4814-f481-08dd4ae47ca1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 21:38:56.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRnmA3y2XmSLF1Cin3Opi2MA6EbFaA03X+xTbAc7haWV/ZwdlCl/SOuxqnopmmux6T6TWYCo+6wgz8TLiYHGiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8520
X-OriginatorOrg: intel.com

On 2/11/2025 12:58 PM, Dave Hansen wrote:
> On 2/11/25 11:43, Sohil Mehta wrote:
>> +	/*
>> +	 * Return without adjustment if the Family isn't 6.
>> +	 * The rest of the function assumes Family 6.
>> +	 */
>> +	if (c->x86 != 6)
>> +		return tjmax;
> 
> Shouldn't we be converting this over to the vfm matches?
> 

For drivers/, I mainly focused on fixes instead of cleanups.

Converting drivers over to VFM checks is significant work. There are a
lot of such comparisons and switch cases (probably more than 50) across
drivers/cpufreq/ and drivers/hwmon/.

Some of the functions might need significant refactoring and rewrites. I
think someone with expertise in that particular driver should probably
do it. I did start with it initially but it is beyond my bandwidth at
the moment.

> This is kinda icky:
> 
>> +	return family > 15 ||
>> +	       (family == 6 &&
>> +		model > 0xe &&
>> +		model != 0x1c &&
>> +		model != 0x26 &&
>> +		model != 0x27 &&
>> +		model != 0x35 &&
>> +		model != 0x36);
>>  }
> 
> I'm not sure how this escaped so far. Probably because it's not in arch/x86.
> 


