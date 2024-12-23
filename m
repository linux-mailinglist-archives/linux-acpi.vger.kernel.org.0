Return-Path: <linux-acpi+bounces-10288-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 562B99FB7E9
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 00:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6060318849E1
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 23:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C741D5ADD;
	Mon, 23 Dec 2024 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khVKhmW0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C75188596;
	Mon, 23 Dec 2024 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734997329; cv=fail; b=d8gIei75t/FGonqOw0uiKnfV2m5K1pM5koHw5/v3rulc1ePtxLGVAdfshjmAFJRDXjSrslh0YsGkwj6M956s9QIkwgeAgfafQHQXczmnDSfZOBJGZhu9ettfugRUrpPx/cEyjVNwcc4bMc+/KSlaSU9pjImtdrNRVfTH0Id5Yfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734997329; c=relaxed/simple;
	bh=PiJKN4J1d3oGjhlHaamblMWuplP6DGCb2hrvE6VOjsw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fKQ81QThxPAReIu4yMgcKeJY6ZI9l+32e/EieBjCmQLE4J3dtzIfCLBNc6kQWOT0QfSxRrd0d0CTDSwWjNXwdo2ECiFbgqIq2QjhUj3FNrW6NGaIx0SAt/x/f11xX48ZcVYXvAjAy0in27xCdsneMeMUq7/5HZATt3bYftiqAV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khVKhmW0; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734997327; x=1766533327;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PiJKN4J1d3oGjhlHaamblMWuplP6DGCb2hrvE6VOjsw=;
  b=khVKhmW0PkTMowy+4CTLaYRib44iy6wi1ArzBpkhY6WmYf1f76ppb3ej
   GdIGeBF6Nwsdj7/GQRdVvD/+opI+rlh3FwiHIVdCqU3pBlh2h46C7j1t1
   ROQ4NW0g3p/vvCLhV2PlscBo4lMv6Bss21VbOoKiTn3PdnE5VQhQHXje0
   9Gzsi5w9QjuH/8YgOJ42Uh+t/FKMEX2ZWITNN5H5l1OcXAve2j8aI16vN
   Fn7OlrJ0zYY60YtWj9/4R/e88oD5Ar5c1yTKnPlIKudIrzI4ZJ1+bsxrW
   vDO0c8R1jzIC6zGxXcq+j2xprtYwZJLno2kInEVw/fLmZqoAm2kQAvex7
   g==;
X-CSE-ConnectionGUID: AVtG1NHlSfy99brB1WWndA==
X-CSE-MsgGUID: M8cH2tCbTmm0Xjr/kcSyFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="35175455"
X-IronPort-AV: E=Sophos;i="6.12,258,1728975600"; 
   d="scan'208";a="35175455"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 15:42:07 -0800
X-CSE-ConnectionGUID: pP9UJnXfRmaf5hlBOg5SAA==
X-CSE-MsgGUID: 4uzy3GT5QRGfLEbV2rILMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,258,1728975600"; 
   d="scan'208";a="99084623"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 15:42:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 15:42:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 15:42:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 15:42:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5ZuWFYBGlIxIphVOjHI/w2WSdb74FklqxP8S1Uvy4tbwab8+AvNvEj6vQyHLPLKNMdZhMQ1XOKvTV8hO4nMHKtf4FdQZ0wtVu1+y85ZQmXySfGB2nFpg50/BbwoU9963YSWKqA/CVBWZLM/DrC/JJJWGd1cDNraVb9j7LCjXUSVymYrdNcwkPwUw4JWnpG3lZY69twc/OGjH3Ba1dXsMyI2bs1ejOaZ7l/NwfKsuRRolziYgVkuGWgsTkK2AHojIqzwxHoZFX/T+Ftgw/AUiLOQ8A/rCrSQh2L9YE9zxbVfTTu+lbTVmuFpmgF11+vhC1UG/nAerAPrLBLXZifFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH0ZtkOFAZHuZZimXk2kAfmAy6LiDVXSgXVBFIUvdw8=;
 b=aNovpMYW72p+lUQ2cvhrqCIuuVvO0TqE+Ah9Twf6bJv3v16iUiQCIKA7NmfmDcAIs3rjJAWzTaVXmHFSrqEdj37XQF5X0B7TrKgG/QzOln4iFUoykx6qT2EG39wMOHs1BnWOD47Xfu2/UCaanYwXuWAB1kovVmh66jKWo8eDknZwvhouI1UIU3vBgiT74h9VO1f7Lj/+pUSJNp8ynwjw5Y0bcnGn6kX0OBgJjdE6AetE3xUoEFY7IMaYM+nDT0BsXyr8QYuQBeaHcw1KDgkdcFxLbgOrbzp1aRpDYY8epv5Cniug0Tsjh0kpiJVMUk52QXYJeZsLQJyIkCMB2mVJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 23:41:58 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%3]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 23:41:58 +0000
Message-ID: <369605f0-9d6c-4a5c-bfc0-f480b537f34d@intel.com>
Date: Mon, 23 Dec 2024 15:41:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/15] x86/cpu/intel: Fix init_intel() checks for
 extended family numbers
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
	<rui.zhang@intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
References: <20241220213711.1892696-1-sohil.mehta@intel.com>
 <20241220213711.1892696-4-sohil.mehta@intel.com>
 <54df5b3f-8b98-42b8-b3ec-3860abd5ce67@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <54df5b3f-8b98-42b8-b3ec-3860abd5ce67@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:303:6b::24) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW3PR11MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a394db-bdfe-42d6-f568-08dd23ab63dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVJzalBNWXlrMm5Lc3NMeEhrSHhPR09RdG94TG5EU1kwZFJWZUpjYncycGFR?=
 =?utf-8?B?L0tKNlRvSUFybnBTQmh1OFowZVpiamc2MHpsL1dzanV3cHcrSk1lMDBSekgw?=
 =?utf-8?B?aHlkcUUvUHhFWndqL1gxTzE1NGwzSnBjMmRUQlJLakIyY2k0VHpuT25zWjBy?=
 =?utf-8?B?VVRObGhDM0xmZ0txb0JVdVlpZHlkUUlyNzRNT0RsYmliTTIyVjM5ZGdQcjlF?=
 =?utf-8?B?TUlqbGRrM3UrS3BBdUY4UDRWQ20rSnNsVlQ0cnVOczNiNS9qeEhCenUyaHEv?=
 =?utf-8?B?ZmgrNnFJR0RIZy9VdUxVRFdKYWx0VGVPMnV2aFNjcHVsMkFJTG1ORUg1Wkdk?=
 =?utf-8?B?OTI3S0w2dGdUVHFwZW9zV2FmUWtOcS9uN1RoV1d6OTM3L1VrcldJWVlZakF5?=
 =?utf-8?B?Zys1YnUzOXpKaHRpNWhKdURTcUYyOGpOWVF2bmZjbGhBZFo1WW9aeC9ZWHU2?=
 =?utf-8?B?VHpzZFRLemtlSi9qOHM3V3V3dGNLMGVvZ2xaSzNXaXFDbHcwaWFUUkhhbXYw?=
 =?utf-8?B?OFZteDhnTlliU3dJQTc2QmZmd0U2WkZ0bnh2b0sxSW4rc3JrdE1tbjBqNjY3?=
 =?utf-8?B?VW5ZOVBQbHRkcWVoM3hBOTZEVkQrZll6QXREVUVOR29BV1NRZm9kMGZDcStK?=
 =?utf-8?B?ZTFnVkFhNHZpdUkwdHh4eGd4RmZnNUoyWTdabkpLZ1VsRmpMR2V2eXlZY1o4?=
 =?utf-8?B?czgvVWFWaUtQSndRZWxEclFUUndRWGJNK3BSaFpjUnI1WHBSdUNHd0paN1Mx?=
 =?utf-8?B?R1dnZklIUmNVMnpSWkhSMHA2SFJNdElyd0VKcklQbko1V0w3OEt1Ty9peFVO?=
 =?utf-8?B?djhNZXAvMkgrbTM0T015aGd6YUpJem9pWWRyTDM4RHpSOHVaZDE1L1dzSnFl?=
 =?utf-8?B?d1RKcXliTG9PdnNEbEZRL1VnVmV3TWppQUQ5bTdSMXY0c2w5LzgwdTIySWxI?=
 =?utf-8?B?bm9BVXE5SjlzaU16dFd1Q2RLUndaLzFlY1VwUXJ3bzA3ZlU2QnFJNWNKMDJt?=
 =?utf-8?B?VWdyZGJiWDdKMWpEdU1aTUJodFBiYThFcFUzUDRYbzEvSnVFOFljNWRUNEJV?=
 =?utf-8?B?YkJ5UGw5N09OYTlHUWhMdlF4QWdhbisvV3J0L1ZmSFZCYUxRc083VXJ2dkRw?=
 =?utf-8?B?R3hHZUgwWDZseVc1bk5yVzhMM0tlYlFDN3RrdkwwT1lTdVFUem9TUU1jTGFE?=
 =?utf-8?B?YmZkL1RSTFlId1N6SXpLQS8xWGcrZWloRE1TbUM2ZHNYbmJmUWIyOHNVMDgx?=
 =?utf-8?B?ZXZjMTNCdXFZN2prb3JXc0hONXFZZUJkd0cwR2ZWRjhwMldxTklaU2tORDRw?=
 =?utf-8?B?LzcrR2FzUmFWcVFDcC91U0xicGZhUUtJSTJVZFRFcU5UN0tTcVAvWkhXa0Fi?=
 =?utf-8?B?Y0ZjUWpZSTYvY25laW5pamsxOW94R3ZEWXNkclRZZXBjbEMxM21ya0RTZys1?=
 =?utf-8?B?VkkrQytkRHlva2NoVStwb1I2R0xVdExIZnhsZnNUMWpETWgxcTcrSWV5QUlC?=
 =?utf-8?B?TUdJRXRJM1ZWQzNzYXNsSDNVajhpMmx2RHRmbGJwOUZyWGxjSEJQMVh4c2xF?=
 =?utf-8?B?bElKbkRFQUFZdDdoMWRTdHhvV09KaFBJZ1pBWE5pY1BXVXc5cTNYSlFNeWpt?=
 =?utf-8?B?Zlk1ay9ESFFuY1RDOHFxSzFXaE9hOVpUaUo0YS90MWV2b1dmaEVkcXArOGpM?=
 =?utf-8?B?azEyaGhGY3pnMVpZTm5WZTZaM0JuNFNoN3BqWXdRdkFOOFBSMUVGWStSN0FE?=
 =?utf-8?B?R21KbnUzeTlKOTRYVkczNEp4eTZoeGQrQzE0bG5URHg2dFNKUW41L1NvMllB?=
 =?utf-8?B?RkhXZStOamprblp6U2YxTUROTTY4QlRZRWFsWXc1VXlFZE9yWjVVYWduTUcy?=
 =?utf-8?Q?EQ60aiCiukphU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T29WRkU2Rk9rMnhHVzMwRjVYQ21Cb29sYnpYeDNDQXB5bjhTZDcrTDRvMGQx?=
 =?utf-8?B?bU5EUTJCSmFuZWl6dUR4akwveXVVcGpHanR0T2d1a3ZEVkhONWdTNG5CU1g4?=
 =?utf-8?B?UEFnUzk5OTMrS3NpRWNSYitwdDBqNTZsYlU4eVV2c3ZhZnZhVlMrUDFiMHNy?=
 =?utf-8?B?NXZsalFGdHJpQTdEOG5tYmltcTA3cjQzNkd4V2t6WnU5TERXQklOclZDVHE3?=
 =?utf-8?B?ZzhnZWVsNG9KSGY4Sy9ib0IyeXhZKzlsSlNqTmp3OFkvWi9BaVd6eXdvSXZ5?=
 =?utf-8?B?Z2prR2dOeUZTQVRTR1c3Z3lOZE1ERlp1YmE1c3M4RTRBQW1jcHE1WTFlWGk5?=
 =?utf-8?B?VHU1NUllZFlyVDd3N3AxY0YrdG1nK2pRMVdrbGo5djhRYmkvbFFqK25RZ0l4?=
 =?utf-8?B?MVh4YmRhWEhJWDNaYS8vVUN5b2psaWpMODI0U3o2UmhRVC9FY3F0SThLSGh3?=
 =?utf-8?B?bnIxQUpuTzZ0MHlzQ0hFa1M2N0lkaU9rOVdlZTVEM1lGTWE4VSt3Tmw4MkFs?=
 =?utf-8?B?VE1TRUsxcWE2NkJPQzE4RXpOc3M3VysxMlkybHcwd3RvR2N0b0tyajVvR3JJ?=
 =?utf-8?B?ZUxWb2J6MHJyV2x4cnhGOVBtUkpNcVMvejZFTFpHMVB0K01BWU55Q092MW51?=
 =?utf-8?B?UGt0bXFKY3RZaDdmdnFaL3YzZFJUU3ZLdzNNREx4NDRTNU5MRTJzN3VzVzNR?=
 =?utf-8?B?allhOWlPMTI2R1k2ODF4RTE1NHZWQ3ZXQ3ZvMzlmZHV1Y2tkM2Z1MTNleHdy?=
 =?utf-8?B?Yk1Qc0FjR2tFTFVUNFdFRjNwZkppRFZTSnlzSWJGTk1rYUh2UGFBbmZmNldK?=
 =?utf-8?B?eFZKZ2Z0dXdjUFo2SVJmck1yRCs4L2VDNmxsV1VKYTNiZDcvcEN4OTlhdFNr?=
 =?utf-8?B?YWE2c0x2SUtGUjlCL0V1S3EyQ1pJS2FpUUUxR2dVN2dCekJOUXVCOHJtMTkr?=
 =?utf-8?B?eDFubmJmbGhORnJLNWY5SzNsZVJ5QkZjWjdFZVk5bnUxSThyUW5iSDh3bEFY?=
 =?utf-8?B?M2NNQTIvbEtuY001QWpYRkdTdWZaR2ZwVDZNQTBsQklHYlQ5NEFuVXYzMTdR?=
 =?utf-8?B?RHVMTWIxc1RMcG0wbWU2bFVYOFgxTlN0N3FDK1ltNXBERHA0MXArSWg1Z1FY?=
 =?utf-8?B?MVFWWTlNNU0zSytrWjRrTTdBR0FCNmhQNzJWM1IvU1Z2N085T1BxS2x4N0dP?=
 =?utf-8?B?bXBtQlhCdk5xMWQ4TytCZUFFNEFGZFQ3MkUwd2ljSWlqRk9JZC9IYlkwVlI4?=
 =?utf-8?B?OXlMb3JrS0pqQTlLTGU0bmpWdWIrTnhwNjVpVkNwYXl6NnBZRWc4N0pUSm9j?=
 =?utf-8?B?ZjRKY1h1THVSSHc1MzVnQUtLVmlLVDJianZscmIzbGdXZ283c2VXZStVTzVL?=
 =?utf-8?B?bHNBbUZwY1BPK2t1SVZTdkhFYzNKQlJ1ajRVV3Z0WjVrSml2TVdaUUxzQkps?=
 =?utf-8?B?a3Y5TENPSVlvaFRMZ2cyOVF2OS9zUVM0KzNzV0xWaVFxVkRrSE42bEpna2lm?=
 =?utf-8?B?QW41UzBoNlNrTVFrdktvWWJRUXcwdFptaXpmazFNUC9PNG96Szl5UW1VQUg0?=
 =?utf-8?B?OVhIKytlVTdlMitvU2pWYWhTRnU5NG1XelVSaHNkN1l0OXcreWFmTVhPbDE2?=
 =?utf-8?B?cS9QMzJZYWJCSVFyRGVxdjZOSXkxT3NReVcvU3l0ejJBQ2lyenV0cHp6L1hr?=
 =?utf-8?B?c285T2lsWnRSTUl3aklFN1Qwam9PQzBRR1VsK3dFT1ExVmgyTDlrSHd3ZXVD?=
 =?utf-8?B?b1pHWGJSUS9FYjl0V3lJMEtXaSsyN0g5cHNKV0tueUxDVVdENEVGdU53NkVJ?=
 =?utf-8?B?cXNMcFFwbkNVRVEyWGdlajNOYWZ0eVR5eFpjZlJjZlJsdXJCbVpFck1oQXFJ?=
 =?utf-8?B?bGordlV6bzVCM2s4WDhOamp6N2Vsb2FiWTlsdlF3Z0hWSHI1cjhMTnFyaElU?=
 =?utf-8?B?TSs5Q2hydDRhbG5ybS82OThDMDdqODZtbDJ3RnNuR0wxcE53T1BpN21wSk5a?=
 =?utf-8?B?THI2QlZ5eCtHK0NyaGlEWmxDUFBmczA4L211aEs5aWpqdTgrMjhrN2hxMll2?=
 =?utf-8?B?MEwzMHdraE9RWDc4L3BZMlY2OHZsdyt6MTBSNFAwL0tHeG84emVlWklDRXQx?=
 =?utf-8?Q?DgN9j0IpYaT45nua+XAbmP8IU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a394db-bdfe-42d6-f568-08dd23ab63dd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 23:41:58.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlmYnhnhyrWDioYe+NL4hHfKTbWANjMlAIDA4LUsMXJUsRrGLqIKKi4uivJ5gJXswUpGi8/1aOZDqjQoBZ7WUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-OriginatorOrg: intel.com

On 12/20/2024 3:27 PM, Dave Hansen wrote:
> On 12/20/24 13:36, Sohil Mehta wrote:
>> X86_FEATURE_REP_GOOD is only set for family 6 processors.  Extend the
>> check to family numbers beyond 15.
> 
> Could you explain why, please?
> 

To answer this I was trying to understand where Fast string
(X86_FEATURE_REP_GOOD) is used. It looks like copy_page() in
lib/copy_page_64.S is the only place it really matters. clear_page() in
include/asm/page_64.h would likely use Enhanced fast strings (ERMS) if
available.

Would it be correct to say that copy_page() and potentially clear_page()
would be slower on Family 18/19 CPUs without the fix?

>> It is uncertain whether the Pentium 4s (family 15) should set the
>> feature flag as well. Commit 185f3b9da24c ("x86: make intel.c have
>> 64-bit support code") that originally set X86_FEATURE_REP_GOOD also set
>> the x86_cache_alignment preference for family 15 processors. The
>> omission of the family 15 seems intentional.
>>

Analyzing more, it seems the below check in early_init_intel() is not
really effective.

/*
 * If fast string is not enabled in IA32_MISC_ENABLE for any reason,
 * clear the fast string and enhanced fast string CPU capabilities.
 */
if (c->x86_vfm >= INTEL_PENTIUM_M_DOTHAN) {
	rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
	if (!(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
		pr_info("Disabled fast string operations\n");
		setup_clear_cpu_cap(X86_FEATURE_REP_GOOD);
		setup_clear_cpu_cap(X86_FEATURE_ERMS);
	}
}


It gets overridden later in intel_init() with the below code:

if (c->x86 == 6)
	set_cpu_cap(c, X86_FEATURE_REP_GOOD);

Shouldn't the order of this be the other way around?

>> Also, the 32-bit user copy alignment preference is only set for family 6
>> and 15 processors. Extend the preference to family numbers beyond 15.
> 
> Can you please provide some more context so it's clear which hunk this
> refers to?  Alternatively, can you break this out into a separate patch?
> 

This is referring to the below chunk. Separating it seems like a better
idea to avoid ambiguity.

> -
>  #ifdef CONFIG_X86_INTEL_USERCOPY
>  	/*
>  	 * Set up the preferred alignment for movsl bulk memory moves
> +	 * Family 4 - 486: untested
> +	 * Family 5 - Pentium: untested
> +	 * Family 6 - PII/PIII only like movsl with 8-byte alignment
> +	 * Family 15 - P4 is OK down to 8-byte alignment
>  	 */
> -	switch (c->x86) {
> -	case 4:		/* 486: untested */
> -		break;
> -	case 5:		/* Old Pentia: untested */
> -		break;
> -	case 6:		/* PII/PIII only like movsl with 8-byte alignment */
> -		movsl_mask.mask = 7;
> -		break;
> -	case 15:	/* P4 is OK down to 8-byte alignment */
> +	if (c->x86_vfm >= INTEL_PENTIUM_PRO)
>  		movsl_mask.mask = 7;
> -		break;
> -	}
>  #endif




