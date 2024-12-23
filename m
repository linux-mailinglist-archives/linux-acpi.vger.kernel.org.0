Return-Path: <linux-acpi+bounces-10284-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB9F9FB4CC
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 20:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC925165CDA
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 19:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168FD1C3C1A;
	Mon, 23 Dec 2024 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0TISm6I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A591C3BE9;
	Mon, 23 Dec 2024 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734983547; cv=fail; b=QuHqgpU7ZsR2Ci2lIKwy35KthosX5sNIKF7H3zUTyosAUHmCf/GV05zSBgAnxblu5lD9gYp/Rn2ytncFmYlDO269CD8JSBVwD3Y4l+yGOF2Wi9ZRfYcOQ0oJA5Ss5EBgAKYQwuMhxfQpjLL/2O/ZH66R50xBiF00C0rhjA1m6kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734983547; c=relaxed/simple;
	bh=+XLyN5LD5YoU90tPrGRXEzqI+d4Z5Klkno2x7SOaxPU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M0Kv6txipz28+tTLhIzJohpgYYDGgwD+Q4xqRX/Z2Fb0IoIhA6Ld0mTnSwGH3GS/idXRqpyJLUzky75435K1AnkX/dC5Mx/39kYyxMJkzCBSqsQ1RibW6/g5QZBQD9q1DpuJs8IorUdCbx6G5PZcfhDx4L3Va06aN3L5MLGEnA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0TISm6I; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734983545; x=1766519545;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+XLyN5LD5YoU90tPrGRXEzqI+d4Z5Klkno2x7SOaxPU=;
  b=U0TISm6I20gO80cu0uVpN91s8okQK1xEh9iCcOOcq5rRoNeq+C68vxNH
   WgvR+rPYgf3L8Hztj7kiRy8o6QLtk/EeEd/OBpBrJLtjYTXF1M+pNUVVC
   HBFMu5FeqfqO7aLOWNNenqgg5FsHPPUbAFquLBAL6S364IddlMcAG/1iF
   oG9k6Bz8+ssZ3W8I/QqnM8HKh40sJoM5Q/PcV9TZAFIo9TyUzLV6jjBiB
   wXRkKRo0DNjfNz6wERtmW7edjnF6VwjwxW8dzcTVysPANFdNIctqH8ZvJ
   R9mir9Y1dR/zhSjHAwd9hidLQyHXk9k/g+KCTgiG9sbqB3vTYKQnafw2k
   Q==;
X-CSE-ConnectionGUID: FUdZpFnfQfKJE8Fb2mWxqg==
X-CSE-MsgGUID: ICXHJKbzQWuoLphb0kLIAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="45947910"
X-IronPort-AV: E=Sophos;i="6.12,258,1728975600"; 
   d="scan'208";a="45947910"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 11:52:24 -0800
X-CSE-ConnectionGUID: CyduYdY6QWa1y6YalyEWsQ==
X-CSE-MsgGUID: Iu4bWS17QUSME5LhdqyiIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103377690"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 11:52:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 11:52:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 11:52:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 11:52:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyBhXOFhzC6vEPmmu2bNvn2C6DqJ3Oe0hlTbbXP1z5ApuEdBuPttzQmzwZT8sDLfHU4RzKEt+z0WG2MuYSxKd2ZDF2nw1npEF54cfQe4kJo4lvFxF3qhcEz8C9/bkmWNvH9canxAyQhfyouj9CMjeSJSsk2j/ryaTGll5gebc3nXrSENLfeSHAkLHWDoKO21zdKh91A+vHY0K/S+bgfmJnoK+halHN1l6MrE6nAvOmabwoMPiFXB+XP/APWuAeIuDgGBdCrCV/Rz0BCVQQ29jHSGO+78vXPpe7y/aTZTIaT/R63Q+jKq53GtYwFqs8sqtBEfSGEiPoqjzM4jyV6XCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC9uGAXuJ/zVKRJOXwdYkmJUo85YhyiMJysDhto1Dl8=;
 b=vhHrXA+G0VSmRnYCYo8q/GTxmna0ifJcN1B/+NZJF7R1fl8z0fCYfeQSdReuZM/7S3n16S6l7yd1s1rujnuIEcZ2BXkazJUHiCcfYB0t9dZCLela8UJzPHlALb2JIj9GqGk58pFhvBoABO9RIKBj+nSS0J4KccfJgIo9buczo1aJg/NDoiT16KE/biZKlknJJoIAr2BCjqy7eek2yyMj7mXr4kIwGM+u0fYCJGgukSfR0/Id81b0nB16oeCOmX3qiFDeW4rZfAgmrNxlGsDvapWKsoAvzyGlgXMiCc6aAni2HAvu+ZjSof6TvCbeadqlz6/JxdoTp5tqJ/tBeTfPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 SA2PR11MB5002.namprd11.prod.outlook.com (2603:10b6:806:fb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.20; Mon, 23 Dec 2024 19:52:13 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 19:52:13 +0000
Message-ID: <a6aaa2ab-e0f4-42f2-b08c-d9bc9cf6830d@intel.com>
Date: Mon, 23 Dec 2024 11:52:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/15] x86/microcode: Update the Intel processor flag
 scan check
To: Borislav Petkov <bp@alien8.de>
CC: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck
	<tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, "Len Brown" <lenb@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Fenghua Yu
	<fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
	<linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>
References: <20241220213711.1892696-1-sohil.mehta@intel.com>
 <20241220213711.1892696-7-sohil.mehta@intel.com>
 <20241221091104.GBZ2aGKIXUMlpmrbQW@fat_crate.local>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241221091104.GBZ2aGKIXUMlpmrbQW@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:303:b4::30) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|SA2PR11MB5002:EE_
X-MS-Office365-Filtering-Correlation-Id: 575efd3a-a72a-462a-366f-08dd238b4b88
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTdHSm1lYXZJR2VOZ2hTNTFQbDVLaWhWK1BKcnRCaSsxYTZ1VCt2QjhPTTVL?=
 =?utf-8?B?bktsTGNKdlljVEJBa3czZCtGODJoUWk4RU91Ry9pelg2NXZ5dStOQk1nZTd6?=
 =?utf-8?B?VVlRTkJTSVgwSjNQU2dTcHl4UXdKOE5PRWthcERUaWRGOXp6MlkyZ01IUGI4?=
 =?utf-8?B?NEt0bldCa1lPVWM3MmQrK2EzN2dKcFhUUU90UHRnaVZYSXhJR0hUR3lRSzd4?=
 =?utf-8?B?d0tPNk0rQzduVWhSTitDNnNyTHNEVFNoZThPNnBXNWJRSlpTeUdOMW9MMm12?=
 =?utf-8?B?WUFVS0p6djBFc0hzSCt2ajlveHhkUEpsL3lNZWp4SVBpRkNGTXBCZTJiZDJ0?=
 =?utf-8?B?UDgyWEJsaStycld6Q1h3anlZbUlxRHo5MjhNbmo4bndPeXJDRmdENkhSN01Q?=
 =?utf-8?B?WFN0TXQ3OFRLMnNpQ29RS1R2MFhXWVpDelhzSWUxVHV4eHY4WjJmaGJSd2JU?=
 =?utf-8?B?RTdFR2xiOXg1Y2ZoaGxJcUVxeWE1VElUSmMrZ1hWbVpJaEtNQ2ViUjJiZ2Jm?=
 =?utf-8?B?SFpDZUl1TkYwVWU0emlHTUMwNktvdHY0VlpQMmJ6clF1MHNNNDVsMnRtTlRj?=
 =?utf-8?B?MGtSbHE4ZXVqSTlmRDJjZEpHK2dRajROMkRYbkVVdnJubE5HS0hQbUw4cTBl?=
 =?utf-8?B?R1NFWW5yOTQyOFBMR1hhQXZMNzZXeXkvNnZBdDVKTGx5SFFKaWRza1Q4T241?=
 =?utf-8?B?K0N1N20zZ3k0VjFxdmsxMTRtVnJRMWRGbHFGWTFvVXROWXdYMGNVNEhFckt4?=
 =?utf-8?B?cXJ6cDFEemNWOG1Td0xzS01WYnJncTFHWjNTVXlJdFM2dWg0UXdQK25PUE9L?=
 =?utf-8?B?QVBHOTRzMm1JcWVJVFVvYk5WanJpd3lZbzM5VjFqNTdRTlQxb2JVSXJUWTVu?=
 =?utf-8?B?WTJXTGpJVmxKOG1udGhLVkpqMFFORjBVYkFuZXUyTkhIY2xqcCtEU3NURXht?=
 =?utf-8?B?SW90Q3R4QTEraExpU2NVeVQzeHA5VVNTN0ZydUpFRCtVbTIwanpXSmZVczdr?=
 =?utf-8?B?TzBlck9VU3JBMlprdXRYbGoxc3YvZ09SWkYvY0hleXJ1ODFSQlU2cGFCVWZp?=
 =?utf-8?B?LzlxY0RhZXpzdTZwSHFrQkJIM3hjRm4zY3g5aGtOMW5SaTdZUEZNeG8wOUN2?=
 =?utf-8?B?dFdabUU2TDRsM0FQZU5nQW9rTksvWlh0dVovbnd0NE00VDNzenU0MnMyODBN?=
 =?utf-8?B?Qk9PdXpOOURCT1BzZmhyTXlQcWd0MDRKZTQ5ODFEVGhpS1BMa1JtSzFHSlNt?=
 =?utf-8?B?M3FqbGxFNUdoS0duaUlpalVsbFQ5YjJ0SU4zRDR0M2Q4NGpNTzMyYUhkVWdU?=
 =?utf-8?B?Ri91TWhqcFNYSzAwYUhQaWVwaWJlc093akVZVXZwYmpqZFVENisxVWx4MDg0?=
 =?utf-8?B?WVVzZ09QZVdTR05yNTc2MENzN2tsQ1RRYlEyS2t3UlZYMVUzZnd4ZllMZ0pY?=
 =?utf-8?B?VW12WjB2NEZpUy9RYjZBUm1zUlZITDRCSzVQc1R4UFJKWFFqNklVbUJ1VHpo?=
 =?utf-8?B?M3NySGUwd2ZkandwaEtZZllvMVo5RTNUYVNFTGpzc0pyOXc0a0M4NDhjb0RL?=
 =?utf-8?B?T0Q1S1RaSVBTOHY5YUc4d2IvWURwRGxOUTZLUVJpc1dCNlMyZFhsaVJ5N0Zm?=
 =?utf-8?B?cTJ2WWZBM1g3clI0c0YxYmpmRDdXa0ROZUwwMWdJNHJyU2JENFJjUFRMd1c2?=
 =?utf-8?B?Z1FnT3Vid1dMbU81TmNXZzY4N1prLzdzL0VCZFRJWlczZittYjVaVzdCNzJl?=
 =?utf-8?B?WVBOUVBjREZDR3RvaGRna0d0bGdJRVdBenlJOTdNb3kvNUdPME5jeVhXWWZv?=
 =?utf-8?B?UU5ScnFiTWY1aEZNeWg2a0wvTFVxQm1Fa3BPM0NJUThWS2EvUFlJcG9oMm5u?=
 =?utf-8?Q?EmdJPoKcdgDpu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmYyS1QvQTdvclV0OGduYXBIQ1IxRjU2OE9BRy92TjF1UThoeDN3TXpVYUtx?=
 =?utf-8?B?Sy82WmNYM0ZBOWpJL3piQmtDREg3ekRzVUVTZWV0MG5wS1ZyS290aG9ybExC?=
 =?utf-8?B?RHU4SHIyTkpWTGFwKythcXRtbGJndHRqNEU2WnBEalhuQUR3Ti83UTU1bmZv?=
 =?utf-8?B?ekk4VzZsVGUxbHNQaGx1SUgxWE85QUoxa1JzZWJvNkQ4bHB1eCtEYWJYeVEz?=
 =?utf-8?B?bUVycnZ3SytjbW5RaVJZUW5BaGRVZERkclMrc05nbjY3VktiempYamZUeDUr?=
 =?utf-8?B?cE9HWVgxZW04aUM2dG5MZ3VJZHViRVk4Z2dhc2hpQkNaQWVlOFdHV2c2T20y?=
 =?utf-8?B?WFh0SzRxWC96UW5OUHk1TVNTRGxtaExpQkZQVitvbk9pekJTV1FWNTNDdVFD?=
 =?utf-8?B?SENXU1lITGk4VTRNR3ZYV2VvN29XN3czSXgzL1VWMUtKNzBoeWhRRlcrbmJ4?=
 =?utf-8?B?LzNPMkJIN1Z1QlJzeWJJYUhXUnJlQXQyTzJqMytTUE50NThLTXlhRXZ2eGZ3?=
 =?utf-8?B?dUE5dFNSNEdpdmJTYXM5NHFwS3RSNGtoemFPZ25mYi9TeGdjTVNrd3o5TE1n?=
 =?utf-8?B?VThSN3RZcGFxakdZVHBmcUdMT1JnVlhUZTM5dENKUUhpdXZndVYwMkxBZ3JR?=
 =?utf-8?B?TGh1NENOY2dwaXg1aThoTE9FZnpmNTJ5QWVzY2tKZ2pyZG4zWktTbFNDVXpW?=
 =?utf-8?B?T0U5cVZBMWRFdGpTaTF2MDhpNmtpMWZ4a21najBtaEhtcDB5SnVrejBUWnhx?=
 =?utf-8?B?d0QrME9yMVp1dUx3RXNiUERTZkxid29BQVZVSGRTM1V3VHFkNm94eWZ5SEgr?=
 =?utf-8?B?K3BqM2duSXBDdzhXOUhFV1FWRmE0NU1XQlNUclFWNmtkWTJWRVl6VCs0S1Vl?=
 =?utf-8?B?OE03VmtVbmN6aEh6Y2RQdG0yTTN6U3NmSzdhb1FJRWhsUWlieGkrV21mRURT?=
 =?utf-8?B?bVJJYnJVcVd1ZlpOK3FkcDZHcks5OGRyQzN1dWc1bU5qS1RaY01JUU5PcEZ6?=
 =?utf-8?B?cWtCWFh5KzB1YjVRb0NrNXdJWEU4SFRFL2tQNitaYUExeXlXcWZnbzZFK3Bq?=
 =?utf-8?B?TElzOUtWUGxBeGpnb0tNSUxSN1lsYWN3YjFUNzkzTDArL1pEeG81dzV6bUdC?=
 =?utf-8?B?S1hCZmhPV0VPKzBnL3RvOHJEQzRianRiUHF0NFhnYmFVYk5YcCt4R1JyWkRm?=
 =?utf-8?B?bitpUGtkVS85UEFXYi9LMlV3bklmSmFPeTRHRGdIWU02RTFSMFZiUkJDQlNL?=
 =?utf-8?B?RDRpOXhiOGM4NCtLUmpQL0hpS2JMOE1BNDJnR1RyTEF2TDFtbVRvVUpCREEz?=
 =?utf-8?B?VGJMaFUzTHdwRTdKKzBReTMrT2FzRWZ2RlloNi9taGI3dlo4QmJsSktCbWt4?=
 =?utf-8?B?MTJHeHp6Q1FwQlJicmRnTGZHOUx6VXlFZjBlYWFLMitHaGE2U1E5bVhaS2NC?=
 =?utf-8?B?WG9kaWJGZUNkbDlNSVhieU1kNVFSQkpTYTN6OGlkTms0dWRuVm5qUnN0TnBD?=
 =?utf-8?B?QWpnVlFGTnRNZnZvRndnaUxmR0lqN2doMFM3VGthSG5uNkRKeUtBWXkxMER0?=
 =?utf-8?B?Nnlwek5Yb1U5a0t4bE9MREREVE4xL1Q1Q0tlR1FNZGs1SEtINDZacW4vdlRl?=
 =?utf-8?B?REErV2xTdUY2bmE5QmxHWGpDZXFPZmVGMFd6a2ZwK1NJSjRwS3lmOHhYU2NN?=
 =?utf-8?B?Unhlbm4yOHIrWlVZNjFmY3pUQmY5aG1QL2hTRnRQcEpOQjljVmg2NmNLYjhT?=
 =?utf-8?B?blphaHJyYkV0MnlnWkJkSnVBNW83dUVFV3FTNXVxWUJXY3RndndLY3VOOVZF?=
 =?utf-8?B?Ny9rWWtMSTdReFphdVJDWmxkYStIcEpCbGRvM0RnRG03YzU3VUozMFVOQXpv?=
 =?utf-8?B?dDNXMUljelhwVkdNYWI2dlNOcHlrUENOMVRLL2M1MkM2b1NXY3hBb29hemh2?=
 =?utf-8?B?WFJlMEc4U0diWkprdml0QWVLZzR4dXpCMStjUWVqdVlVUjh5K205VkFuUXJY?=
 =?utf-8?B?bkJJbFN4bi9aWDJHb2F0Qm1vWnc1cWpCL1orL2I5bm9wSDNGZkRzRHRLU0Fj?=
 =?utf-8?B?QTkzSkZOdHovNnBCMzJVcHF1VE9oV3BTK3ZqdS9qck54NHV5NDNoS3VuUDNW?=
 =?utf-8?Q?DQJoUeDu/jwwYgHCtMXG6Cbn9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 575efd3a-a72a-462a-366f-08dd238b4b88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 19:52:13.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3AA/ZyHTkRFODE7miR+cyfjynk4W9y0p7eOYoQtL0n06OSMxOukAeNkkYRiONEYzVRPPTz/XBahGqhgu8bk4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5002
X-OriginatorOrg: intel.com

On 12/21/2024 1:11 AM, Borislav Petkov wrote:
>>  
>> -	if (x86_model(sig->sig) >= 5 || x86_family(sig->sig) > 6) {
>> +	/* TODO: Simplify this using a VFM check? */
> 
> No TODOs. Take your time and do it right from the get-go please.
> 

Sorry, this sneaked through. I was supposed to modify the comment before
sending it out. For this RFC, I was looking for suggestions since there
didn't seem a straight forward way to convert sig to VFM.

But as Dave mentioned in the other thread, maybe we don't need to redo
CPUID in the first place and this code can reuse cpu_data(). I'll
explore that path first.

Sohil

