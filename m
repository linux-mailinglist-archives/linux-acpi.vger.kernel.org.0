Return-Path: <linux-acpi+bounces-11134-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08643A3315F
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 22:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BCC188918C
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 21:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5024D201258;
	Wed, 12 Feb 2025 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhAlK7jm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0AA1FBC8D;
	Wed, 12 Feb 2025 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739395217; cv=fail; b=V6SLNudNeGEkUGyPDWR11eU/2PKUSHsBAyg6NBRz6ejptR/z7jI7KjfNOnWtSgY1YrlMaZRo1yFyzNFIAnzLKRPU5hdzlENgjhtUnLIKuptUAmwM2h8YqBwxcB28av61peV3Wc//3/9z1PPQaJmCfIqglvZ6TuIztsgcPfFdWqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739395217; c=relaxed/simple;
	bh=szP2sOZEO/0qJi2QUvElLrNRQuQokfYnJ9Vwm4C5dvM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KoCN0gorXllcKEWMB+AOnWvHceRY0y9hnIK420UA5USMIx1jWZg/W8Da3VWb4Ss3ky6bFRc1PCoAo7Ml8oBLCGqLtrOIc90jGf3mihYSxgEhK0gna4GT97HsXGHzQO73QzSmGWKgix7g6qh7xHDSLW6huaj5m1RO+l4aOKR7BBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhAlK7jm; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739395216; x=1770931216;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=szP2sOZEO/0qJi2QUvElLrNRQuQokfYnJ9Vwm4C5dvM=;
  b=MhAlK7jmq8mnycUJa1YEcme8lzLMdk7v8JWhQqRjd751zkN13jnUEuvL
   62AcO97v6lAfQi+U7YWNoDnl+1yCHsN2VkPSgrN9USlJA4T2GgItFpLMc
   v03Tk4WV1OQvLDF0s2qxQTp5Vxb5OAU+9up6XnHUOIOFjsanbsEiuAsZI
   GIVhGqjHbiY+FZJL92/OqPUoZ8hev92d+FlsfeSJCn4cRoP27JNIvUgXs
   Yfkem8wLMdm2Gk9+hP4Fk1Yb/HLT5OqzbseP6aPE95WnJ1GjgIKieQEBY
   e9H/80TDyP5ikQq0Omiu02do/8oNVIiXHNNbB29WYRGsNEcpoWs0u7uOf
   A==;
X-CSE-ConnectionGUID: /MXIdjozT7+7MZpAn62fdA==
X-CSE-MsgGUID: 4ZexPsIYTMmJKbA625BA/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40340237"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="40340237"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 13:20:14 -0800
X-CSE-ConnectionGUID: 5H6IRHxzSRS/yzHDZqbVPA==
X-CSE-MsgGUID: Bs9vTAcRSFGhtq39UXaH/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="117883941"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 13:20:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Feb 2025 13:20:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 13:20:13 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 13:19:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0eBXa/7NhIqVHi3GYR8coKFmvphE9ndiyq5RMJFW6/5Qx8+Mrkk2VzXv9AJT8qzwwNRr+/M88srHmd22vDJ9nDBWFKEt+EgMT8QHAkNiMSQNDPgn5suqDXCZLyZ3Aps1qHqM/Gy2B6velijag9HNE0jL99TUWJSLV1WJVA4aVYtAemFWfWI+dSuMIOC9ArvZhhFzEWW8i42504mPPBTrh1PpAEpbSfInlPvp+hJ6hMaPcJ+FIQHBnZ1hOempRjTZuz65C7Ldgf/asSCIKHY4eb+HMtX+bsnG9/lGTZjIahjnznEPU+4c5JPfsVPuMaBSt3AFYm49pCiVrzXdcQtyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUouwerO+o0mfbEBrQp4b489c8T931iSVsAkK24KMQA=;
 b=WbXE8uKbc6C/izhvTakaBt+WYz1F6qEuiDIb6HISc3z2vzGUKZu+F0Tz4mBw/QAdq7jFz+gMHHNhoYs6zTZ0CNrBJq9/400peQvkpFDfw35vOJM2q95aF6rmpQKBPzUuBDjXitr00HyKQSyA+Vu+yFQVZbYKTlSgt98zqHVizuKa0OpHM8LqDYzrsNLSLF4TLv0NhEScwjEr41BzOhQC2JfAmRPDgwA7I4HCymE+0koCu+GY1RutG31Cet0E0wwG+VRqMLHYoS0z94tzv4PLG48AJ3Ri0sqBqrBtzI7KDTlv4XmzLKww5U3J8V90gnXS4lbvGIGnkAILDBA9Ee1Mqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH0PR11MB4903.namprd11.prod.outlook.com (2603:10b6:510:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 21:19:53 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%6]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 21:19:53 +0000
Message-ID: <90eb900b-0b75-4c0d-be65-a4357729e5cd@intel.com>
Date: Wed, 12 Feb 2025 13:19:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] x86/cpu/intel: Fix page copy performance for
 extended Families
To: Andrew Cooper <andrew.cooper3@citrix.com>, Dave Hansen
	<dave.hansen@intel.com>, <x86@kernel.org>, Dave Hansen
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
	<rui.zhang@intel.com>, David Laight <david.laight.linux@gmail.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
 <20250211194407.2577252-6-sohil.mehta@intel.com>
 <b9c21518-54fc-4907-8fc3-d492a3f33bdf@intel.com>
 <2299c94f-aa46-47b5-bd25-9436a8fbd619@citrix.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <2299c94f-aa46-47b5-bd25-9436a8fbd619@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH0PR11MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cafc9ce-5f84-4a1e-9b13-08dd4baafda6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGFocGhyOXJRdWNzQmx2WjU4MU92L2twL01FaWEzSnlEdnNlRkhMZGNQdE82?=
 =?utf-8?B?OXltbVZWaHV1ZmVOSlIyTkVrcU05RC92WElZTDlBR2xzOHZTNkNmNUFxQ2Fp?=
 =?utf-8?B?L2RvdGlPY2FuSlUrQ0RkWm1OVkdsSEVIWllkKzFwZ05GOFg2TzhYZXc2c3Ro?=
 =?utf-8?B?aFVZSWJZS2FOdk4vTUNjenBrTWNVYXE4Q3YyaHpTdEZRK05KNHlzcFpBQ3F1?=
 =?utf-8?B?T3l4M21PODNsRURodUpHSEFPTVlIeUtUMU9PV202M2l6T2lwVXdlRXNHRkN3?=
 =?utf-8?B?dWxLK1lEK2kxWmI0VUdIamUzMDBzMjJhSmJ5TWVuS2lRV2FDNmRhTFNZbGRF?=
 =?utf-8?B?YnNnZ1NGcm54SHQ1UW1DbERVdHU2cjdYdzVYamd4akQvNCtBTjRRWHR4bHFF?=
 =?utf-8?B?b3Zydzh1Qy9XbS83R0h5QWVLbFZSdVZ6Q3FRYzVsVG1jRHFSSmRvVG9pMkJk?=
 =?utf-8?B?RU9VQ1lMNUtab283ZFV4TGV2VGpUM0hYV3ZtV1dkT2dyZkxtOTdqWmFUSTdM?=
 =?utf-8?B?VEtKNzluSE1CeS9ZUWJPd1FOYzBpZ0hSR0IzQ25HZ3FocVhIQ2JQOXp1MlZz?=
 =?utf-8?B?SW5xQlRmTTFzYncrT2VyU2NxemlWcUFYcmZ4NXJ6Smp1NHlzQ0d5T1BST1JV?=
 =?utf-8?B?VUp2NW92Ykw2aTNUZVc0cE8vaUVrdGx0dnV5MnI3T0pxMjVRdmFwZTExcTgx?=
 =?utf-8?B?WnNTemkxUlEvZzlzSE5vdzFObXZoY1U4WFVucE5oQTBQZUJucU0zOCs0SVpr?=
 =?utf-8?B?ZGk0eldEb3ZCYU85QmkyNzRUMmMrdS9Hc1VQMXN3YjhIQ1BZUEhLYnBUdE1x?=
 =?utf-8?B?dFFDNGtnYmpkdDVkQmE1OFRnS1JXelZRcWdsSnN4WmZ6bHVZdklPelFVZjNw?=
 =?utf-8?B?N3BNbTJjYWVja0VjS2hlU2pZMVRlcnhzMG9FT0tEbW1XdHM1WExMampuTGFT?=
 =?utf-8?B?c0YxNTM3Und2c2dFVTVxN3BuTHg1L0VFb0ZoemdIcTVJTnU2dC95Z3YrYjkz?=
 =?utf-8?B?amt1bHpVeExoOGUrZVJaeDZiaGJWTVM4NHJlTEU4RnhQMGNicjlQNVZ4VEhL?=
 =?utf-8?B?S28wQktNZ0w3cDBPQS96Q3lueVcwMVNTSkNiR3F5SVp4TFFWZ2lSc0lFZ3BN?=
 =?utf-8?B?NGZmOHg5eDNyTnYrVG9OKzQvZG04Q1BscG1ETDNDcXFLNWpJVVJPcDV3WVFq?=
 =?utf-8?B?a0pzWElOTE5BdVdjSkN3RUQ1WU9JUjIrNW1WV2dWQVhZOHpGSklrcTltVnVv?=
 =?utf-8?B?amhWR2RUdTdqd0JXS1JmbzhKSTlwOXRBSWRZZk9Rakp0bnhKODRPOTlqbnFK?=
 =?utf-8?B?b0ZoNDRueVdKNlRBc1h4d3ZhNCtZYVpBdzVoMmJvdlNUUU10UHdJM3ZsNVJh?=
 =?utf-8?B?QVdsTmcvL2RGbFlqMUZsVXVKUC9PTHp6Y3BFNWRKTGh6ZkNWU0VwZGNxN3pZ?=
 =?utf-8?B?V1ltS1ZCY1FRVXd2Y2ZmdnB5MHBtVy9qNW5kbmNlRGpFK3E4N0hwNWp4U1Jy?=
 =?utf-8?B?NWllV3lBejYydkFSUllhb0wxekZub1daQStuWC9aZlRlc3pSZ1Y1TW4vVkFL?=
 =?utf-8?B?SFRtbXI5WnIvWUZQSG1kRWNkRzl3ZnRLV25LQkdhZnJzR2tDZFk5eDV2STFj?=
 =?utf-8?B?MW9QL0hpaVZ4bWdQOU1SQXdTOHA3RmFxMG5GK3ZYWmFKRlpRdE56ZGZOVnNH?=
 =?utf-8?B?VWM2ZUhSZDYxeWVkUzB1dExZVWJXU0JuaDJHaUFreUNnSjFIdWtYUDljOVRE?=
 =?utf-8?B?cksxcE16cHJxWWV2dGlQTFBRdC9xcjVzMHczQms5Mmo5Y0hwZVVJYVlBMzNH?=
 =?utf-8?B?MGc2T1UrRm8wT09tbG0yeHVybHBMSW1NZjRYbEUzUXZmdkZUVWtOTFpjbi8x?=
 =?utf-8?Q?lnwehJLWHUAJN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVlFM0FXYTJpZjR5WVZ3blVwRWlXdWtnTENIZGVxTytOQ052K2VuYVJxK0cv?=
 =?utf-8?B?MTZCekNUclZjaGFSWi9KZkR2NlRZaWorVUROckVRREtpdEx3bTRjenhqeUVn?=
 =?utf-8?B?blQ0eC9zOHY0V1dYbnI0R243c29PKzM1QU44QkxFVGdCNlJVaGdZcGl6QkVN?=
 =?utf-8?B?VjlWTTdpWU9SMGNDWWwvdG1VMW1OR1dhZldYSHlqanFRVG9kQkkxUWFFVXc5?=
 =?utf-8?B?ZFM0ek1GM3NybzJiN0pZaDloeDZHTkYvUjlGRFFsbFB5a3c2STg1b2pFRk5l?=
 =?utf-8?B?d1VXRGtRVlhFYVpzOXFDODR0MFBjeUlQQmZiSUpnOXc4SEJxa0pnSVA3UUls?=
 =?utf-8?B?N0RqNzdmOUpPSHVrRTlVRjFrR0l5cE15UnZldy9FUmhNNEVMNjRnMmt2RUw0?=
 =?utf-8?B?WHZ0ci8yWWYzRDhTS05uSk1LN0xpL3hyZ2NPY2FGdzhtTkFyNW5QVlByNy9y?=
 =?utf-8?B?NjYvazdaZlVpeTU4a045QzBIL1NPaTJIbU1CaGNxdXhPcE9qZmtUc1pPaWdz?=
 =?utf-8?B?WFU0YkhYQ2pDREZ0dmh1M3F2dUYybTExNXpwcmVOZUF1WURiR2p6Rjc1RnhQ?=
 =?utf-8?B?QzNaTXh6RFdkUDcvVkEraDY3cnhpQ1BJczMzM0pDOEw1bEEyWmlzVHBPREVj?=
 =?utf-8?B?c2pnT1l3UjlrZHN1dURQMkhIbk4yZlRRK2xYcW91L29tSGZLR21iM1FHYzFn?=
 =?utf-8?B?a1B2THZqSnAvYWtqRG12YzY5SkQzZkZrRmtKbS81RFpUTTNjL285TEV5amtV?=
 =?utf-8?B?dUgyeXI0Q0dUemppT3Bmc05QZU13a1RpeDY4VHBYeEFCaTh4OG96ZHM3Qysr?=
 =?utf-8?B?Y1o0T2pzZDM5NWhCSTFZWXJ1T2ErY2JFRzRwbTk0WmNSSWNZYUpubDFRR3dM?=
 =?utf-8?B?OTBYWHg0WmJFL0JycFhzdWF4TUlVVzdWYUh2SkdKRjNXbDhMQlV0dXdYay9B?=
 =?utf-8?B?L2paSmJxbXlHbWJlRVVETVJkTWY3eFJCellqVTBoaDZNT09KbkxSODVYcFI3?=
 =?utf-8?B?UmFzMFFVOW9IOWg1NklmeCtKdFBqUHFvT1hKcWRmQk5SeFoxNWNadXJLS0dJ?=
 =?utf-8?B?MnUrWGh1ZWR0a3UvYzVMTmlTOTREUGRkblpyR1FkOXFYSldUQzg2ZmlwTUVU?=
 =?utf-8?B?d2NJMlJDUTlMUEdDdjZ4Q1h5SGg4ejU1b0c5R1hocXBzTjdsQUVrNVhWMXh0?=
 =?utf-8?B?MW80OWY1aGZmVEdtRHI5VTZNVDBqNndydm42K2VlQUFlb1RrU1ptam1LTXIz?=
 =?utf-8?B?RUYwNzVDUWc2aFhsSkZDME1ua0pWVzRLN20yWEs5SE9XaVdvNThMd1U5bWx2?=
 =?utf-8?B?MS9sR0Y2WEFRVDJvV2U2cnZ2bWZxTFRPa0VhYTAxMU5SUU5ORDBLQlNTdHov?=
 =?utf-8?B?c2l3V2FhSnBENlJKSmRpYXJxc3ZjSUcyUWo3NGJEWHVXVWZFS1N6WXNSQTRH?=
 =?utf-8?B?c2M2KzMzK2J1c2lJSzNOOGVaYWl6NDU5WmhzV2l5bHdRY2NzNHVpVk9HWlpp?=
 =?utf-8?B?N2VmVzRta1FwMWFiVEVoVlBGRWsxK3FyUStKREI1UGlEeGdnVURCSXhrc0tl?=
 =?utf-8?B?VUVHVlA0OUtOa0ZyNkZjbm1KOVBVRko2a3JuUEVyODNOTTN0TWxMZDQ3T2o2?=
 =?utf-8?B?bkV2YytoaTMya251NlZhbitBRnlxbmV6NVR0VEpCWUZGZ3J6TVIrTm1xb0JS?=
 =?utf-8?B?MzJ5ckxyWjkrODBxTnhuSkNWVGNJSUs5VmowRWZCaVBpbEVuRnF5SmlIMGVC?=
 =?utf-8?B?WVNsbWp5RGZyeU5STk16UHI3M3NGS0F4VWF2MFJlVGdtSjdPK2FkNzkzczU0?=
 =?utf-8?B?UFNJdy9zajcwbjczZnJUZkw4R016SU9qc0VnK3I0ejJGcGl5eXVNYTdXZFpw?=
 =?utf-8?B?Q2ZMOFVidG8wN2tOTkdwcTAvN2svTmZlVnFKT0hZc0lKTWhGZlAxbkFuck9m?=
 =?utf-8?B?WXJlK0NiWmtwWS9UMGdMMVdTMW01RzlRMkUzN0xBaVh5UjduRWFySHJreXYw?=
 =?utf-8?B?QjFKeUNGMDUwNEx6ZW5tZ200SE1QYUc2TWtUYmF0QTkzSzhOaGxZdG5pRmY4?=
 =?utf-8?B?ejRobzBmaGlSOUN0Um8vT3loR0sxZVJLTXdYWWJuM1BtNkRQRDFqWUxkVklQ?=
 =?utf-8?Q?LoYYmAy0wHy6FQmCt8M/zTe+O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cafc9ce-5f84-4a1e-9b13-08dd4baafda6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 21:19:53.0079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhv0C7OO8bRJafBdFAsDcYqd+sI3AQmwEeS7n0YY/Tufq6f6nP0mdh1nhxg+ni0QdHR7nxCSPSLMKZTeVA/e5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4903
X-OriginatorOrg: intel.com

On 2/11/2025 4:54 PM, Andrew Cooper wrote:

> If you're going to override the BIOS setting, then you need to
> explicitly set MSR_MISC_ENABLE.FAST_STRINGS.
> 
> Otherwise you're claiming to Linux that REP is good even when hardware
> is prohibited from using optimisations.
> 

I think the current checks have unnecessary overlap which makes them
confusing. We should be fine if we only rely on the architectural
MSR_MISC_ENABLE.FAST_STRINGS bit and rely just on the BIOS setting. My
justification is below.

The simplified version of the current checks is as follows:

Check 1 (Based on Family Model numbers):
> /*
>  * Unconditionally set REP_GOOD on early Family 6 processors
>  */
> if (IS_ENABLED(CONFIG_X86_64) &&
>     (c->x86_vfm >= INTEL_PENTIUM_PRO && c->x86_vfm < INTEL_PENTIUM_M_DOTHAN))
> 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);

This check is mostly redundant since it is targeted for 64 bit and very
few if any of those CPUs support 64 bit processing. I suggest that we
get rid of this check completely. The risk here is fairly limited as well.

Check 2 (Based on MISC_ENABLE.FAST_STRING):
> /*
>  * If fast string is not enabled in IA32_MISC_ENABLE for any reason,
>  * clear the fast string and enhanced fast string CPU capabilities.
>  */
> if (c->x86_vfm >= INTEL_PENTIUM_M_DOTHAN) {
> 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
> 	if (misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING) {
> 		/* X86_FEATURE_ERMS will be automatically set based on CPUID */
> 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
> 	} else {
> 		pr_info("Disabled fast string operations\n");
> 		setup_clear_cpu_cap(X86_FEATURE_REP_GOOD);
> 		setup_clear_cpu_cap(X86_FEATURE_ERMS);
> 	}
> }

This is the only real check that is needed and should likely suffice in
all meaningful scenarios.

Comments?



