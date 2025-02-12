Return-Path: <linux-acpi+bounces-11079-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F757A31DFB
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 06:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDC316700B
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 05:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA21F5437;
	Wed, 12 Feb 2025 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXVl2+UM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3174D1F3FC6;
	Wed, 12 Feb 2025 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739338511; cv=fail; b=M5rc1/iDxef6qZoJyKJD5WHuzzvhUqjlfBG7GfQAfzwY4X3bpb2O1mA47ArG8fKfTmzouz1N66ehL0Xmy063Qr/hXq2sWcIChDoNfW0kJ3t3//yMkB9wlRkTZ9TvlLxMmqPGrlvFED8l6SBNKZToJ7PGWqxTNtP329ZVXpmlKrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739338511; c=relaxed/simple;
	bh=GxGZATlX2wxzCMIVvOLtFWLS4ND2pcQzkeM1XGmSbAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gMbq8Nrl/zD/UZswNy8983f+3sBXz7soINDBOVTxa0HHfwwci+WoJiGrKcXBUJLEFlNtVkMXNlODSZyeymcrillilwI442TfG3Ub6d+7P3RN+/TvAI6ut62XI3kcrcw9KiBgchytNVm1stZVG/jgz5H3XbnRMCLNTvVFb6LD6fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXVl2+UM; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739338509; x=1770874509;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GxGZATlX2wxzCMIVvOLtFWLS4ND2pcQzkeM1XGmSbAE=;
  b=AXVl2+UMX2F/OagSFoUoLVfVTMW4kSl0aq6aykRJlTd9LWe5sJ8mvuOw
   ybphgChwbfyEKuwRX5JTN3A0tWh8LLFJmI3ZCLYlgTYgEagyNiukdDVwd
   1p0v61p3ryHIfTAhByuo+82G9o50ZJyIU25SbZ+qMlQMwYGrgFNALwCQ4
   QX6kyv/wOlzbpJboF8rgo1n13hu2X4gv29SSsk+IoFiZ6Y6RpFOu81XWb
   AI/11KmU9vsnDqswLSVqCinWkdD+IWI5qkdXAAFJL8/+iRiiyDCUSKzkW
   KAq6KczAzrfi0Z7LcywYBXYJEaN+GWDpHq5fSJC609L/bn+NiDUxBA6U7
   A==;
X-CSE-ConnectionGUID: M6ZdrULLRfKTCb/WpguJug==
X-CSE-MsgGUID: aJ0+p7CsSv+7o8r07cPAyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39171528"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39171528"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:35:08 -0800
X-CSE-ConnectionGUID: AcCBQXXNSDqyg9CcwINa6w==
X-CSE-MsgGUID: a3IeSWdlRgCGPplt2/Zhhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117892834"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 21:35:07 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 21:35:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 21:35:07 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 21:35:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slzO5YtlVBrAvVHvMI/d9fCJNLHkoCFX29bJH1iEldItuaBnMYc32stU4K3hABNSnjG7LuFQZOFJog1qkwwrfWxCkOwBf5zmdEmii2yJFdYsQn6vw/G6roQpCjQzvvEn4J5V8s5nuot0BmSiSlCL3NZmDObrGvZPLz4MAgwcGYXNCsZ4QKVQ0a84phONPtBKX/cOAKscfqdj58kReP4jVKeLVgYEcjuHcwi+1xOQzCdRXmJcGIczjLcl3UL78CmC9GYwk7G2uG2YwDxp9SeOLkuLlqqKIiHA9pvsRE74d6PkP+bnCWiSwPqPfw4sAh8dslrKHnS/Wbp7MCpCVEi8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxGZATlX2wxzCMIVvOLtFWLS4ND2pcQzkeM1XGmSbAE=;
 b=t2s65s1JPmWkvMHtjFiw9Ij6YzI5sT3jen7BA4EiBteEHIUJg3ZBw+G/homEqxUHOMYwvMJpsad09MbuayFgQeDKGrYto6jNE925yX/SuHP5/pkXgRSS0A5sRN62EpzfFJrppoVSXflZF3du7bgBZH9tD7f2+yPv4d8f67EpJ1uQVJICfpjPAe78ToxQOQCEI9awcRNTB04PzzwrRXz0pfXwaKpFRzrSrMPUAMeTLGI2I/2sic6UgUGC2EdEfho55beg7/X4L2iiNBDpsGHuGXjwozHWRmBo9GX8ULwXUtm6DhSCIyRFzmjDGHE00RgufqEaO2k7GcrBIQU5Zhkdag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 05:35:05 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%7]) with mapi id 15.20.8422.009; Wed, 12 Feb 2025
 05:35:05 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Luck, Tony"
	<tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "david.laight.linux@gmail.com"
	<david.laight.linux@gmail.com>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "jdelvare@suse.com" <jdelvare@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "irogers@google.com"
	<irogers@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"fenghua.yu@intel.com" <fenghua.yu@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "bp@alien8.de" <bp@alien8.de>, "acme@kernel.org"
	<acme@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 06/17] cpufreq: Fix the efficient idle check for Intel
 extended Families
Thread-Topic: [PATCH v2 06/17] cpufreq: Fix the efficient idle check for Intel
 extended Families
Thread-Index: AQHbfL2tst/1HnpQu0G3BANsl6xZFrNDJi0A
Date: Wed, 12 Feb 2025 05:35:05 +0000
Message-ID: <56eb1f8bda3932632cc0b17dde053f77fe7f3f89.camel@intel.com>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
	 <20250211194407.2577252-7-sohil.mehta@intel.com>
In-Reply-To: <20250211194407.2577252-7-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB5183:EE_
x-ms-office365-filtering-correlation-id: bfb6cacb-edea-4df7-9bbe-08dd4b27016a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OGxyNDNhMnlEUnRId1p2MFg3NVpmd1MrVXI4M2FRcEtuakV1WURia2Nqd3BW?=
 =?utf-8?B?ZFNLYmUxM1U5MTVoSlQyeURrSXArYnpaRVR2eXh1WFNmS3lIbkNBZFEzKzNp?=
 =?utf-8?B?M2x3eWhSVXhTZXE2VlFUK0R5YTZzeUgwZGVmamREMHVJUnRySEVUNHhaMGtl?=
 =?utf-8?B?a3I2TDY2N0FGOG5kQzBzLzk5a0ZLK3A1ek13dndwTmNYVnF4MFV5L1JSWldE?=
 =?utf-8?B?WmVmeUFqQlhrVVdJL09vaUsxR1U2Q1RpbEN4aGp6d09TS0FjOGhKVjFhaFJl?=
 =?utf-8?B?eDcrUktMM1JBc1ZIcnJ1cnFiQkU4ckovb1dJd3Zod21Cdkhjbm91MFBnY0FW?=
 =?utf-8?B?dmR1d1c1dmlYM0hXU2VsYkI2dHgyd0UvUjRYMGUralNQcDJMSTBCeVdtTTF0?=
 =?utf-8?B?N1MxMlNpc3hqOVphR1dEK3lOQ1hJTnY2TjhaM3VDYUl2SGJld2cyc2NLY0wz?=
 =?utf-8?B?QldmM2w5OG9KRU5lczRFaUc5WHhLOW5KTi9iVEsrekVkaTBKMkV2MjZMRjk0?=
 =?utf-8?B?cnllOGRLWWhzbzR3RG9MUWRwSWdqS2FNSDJFWTFYeHRkbW9jOGNpZllMK2tY?=
 =?utf-8?B?azltdTRTMWZyOVlURFhSNXBjNHlpbW0zejlCS3pXZjFNcStJL0ZQR1dhU1NR?=
 =?utf-8?B?ZlR2RmNYdGNyNERscmlEenp4TGxVem1kak1HakpCTSszQTU1NTNGK21Xd2hN?=
 =?utf-8?B?aWhRNE9MYUxqanVya25kWERPcUtwcHNUdnJHSzg2NzYvc0xQbHhkYlB1TXd0?=
 =?utf-8?B?b2o0SzNpUEZodHdxbjBQejBYaTdFYnR6WGNzQmNBVDUvZWZ4bkpFQkxqMnBI?=
 =?utf-8?B?ZHdTSVFNekpka2NWeTd2U0ZITGxSTE1LYnZEMWcxRGp1OXIyL0VlZXVLWlg1?=
 =?utf-8?B?eExYZHBkbFBQL2gvZlpBM3V5NnM1N1h5VGVNKzZNT1pMMW1GRXBWeXNYdE5i?=
 =?utf-8?B?bFo5blFvNDV6VUtvMit6QThoTWxRNW83bGpHRG5BQnM5RWlRck82K1hHTVNK?=
 =?utf-8?B?NFVmSjgxZUNvTTVUR0kwQlFXWm9EYVNRdjVzaldLOWZGTnFUOWt4bjQ4bkFN?=
 =?utf-8?B?WCtCckt4YnhPSXh2cGszdUU0TDBkZ0YrK1UxVUZGQ2hCUVVUQ0pzdWM1bDhS?=
 =?utf-8?B?R2lPS3pZRE1pSHNRUjlMZEpBeWQrTFMvcnRNLzQrR1pjTUpKWXZXYUxDeDRU?=
 =?utf-8?B?TzAxSkdFZ0djTk5tZ1c4NzZWbzMyS24yNWMycS9uVWZWQ1pYeEdHSVFvdDdI?=
 =?utf-8?B?TmNGQSt4NlQvTnNuRzFicitvR3NlQ3hiZ1RjQnpqWDludzd6ejVCS3FicU42?=
 =?utf-8?B?bU9ZNXdBZW9Kd3d5NnZjTVJ0UmVmNEpzaGFDN1NTTGJ2TmgzZ2c0ZDhnMmlP?=
 =?utf-8?B?TEFMTnRkVmJaMUprWE81WWo2V1NxSXFXck4vVlFIYXd5UmVXeVRidmozYUtL?=
 =?utf-8?B?aWFnRExEQlR2N1ArMU5OZnZRam1FMWFUanJpT2Vzc05hUTd1TmQyVm9WVW5y?=
 =?utf-8?B?SWFTblNyUzk4YWxiVGExa2ZpNzg4VWkxOEh6NkIrMjN1N2lVbmdpeWpZZXBm?=
 =?utf-8?B?MXZ2U1JsZzhGRElNYnZsdU9tTjFUb0F5Nmh2NXNkNlZJVjE3QTJFMUZVeEVE?=
 =?utf-8?B?OXpjR0dnT0k5bzhqK2wrbkt0TSswRmJCWGdHWFZIOUpDQ0p4NEtuRFRqL2xF?=
 =?utf-8?B?SER6bHhxQzVVM1cvdEZ3aXpqSm9CU3RxSTlEeXBrUTZVQ2N6dFdFZk0yTHh1?=
 =?utf-8?B?ZlR0K2xreGV5ZWFvUlA1QXhIN1dRamlrL2kxbmRsdVo3by9QYk9qMmxyZkVD?=
 =?utf-8?B?eVR5Q3BrQkVzcXFnVkszTWZCMzRRdThReWI4RVZyQnFMTVh3TWhIQnM5RXVN?=
 =?utf-8?B?SklrS3RJUGNUOEZNbDJXdEg0Sms1dTcxM3ptWlBjY1J2eVVUaGl4a25keG8w?=
 =?utf-8?Q?mbQD/AcmDt5hM1M60pXmSR6NgJUuUIPC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnhmT0ZjdEFBVG95L1MwVUpyWWkvNmhReU1ZU0IxaS9nOXhrN2EzWkR1VGpC?=
 =?utf-8?B?N0pieWhHYWJUZ0hUOFVycnlzT0JLbDB4ZnJURkJOdGhNV1JpS3YzQ1RkZnpS?=
 =?utf-8?B?MkI5c2FBaU9NQ2twUWh5WElPWVdsckZoZ2VoRkxvcnkxZlF0a3cvSk93RTJv?=
 =?utf-8?B?TVh6Y0tpWFVBSS9qbGlUWXRlR0s0KzNmaG9YQmhjVE9STWFKMnpDblRHRUY5?=
 =?utf-8?B?N0M3K0VSWkk1Y2dMQUpoMDUxOFlnRDg4a0VDTXhCNHBHa1NBcGxyUUhJNHNz?=
 =?utf-8?B?dWViS3lPbGR1VDJGRE5HUFFJVFduWTZybmVTd3dLRkFmdUIxK3Q5NWpxcU5x?=
 =?utf-8?B?dEtBNXhDQVNlS0hnd2I3d0FOdmMrN01OZThaOGo0NENZdlMvbDBONVU4dVhr?=
 =?utf-8?B?VjJNYnlnbzRWM1VVSXQ0Ri9uaTZkRFZrcW9YbWptUXZHK0NxMXNaVGIyTFpO?=
 =?utf-8?B?Z01Tb2xCN0c0R0RvU0JLTDBNM21MdmMxdjdOZnVtNldPMEZhOU1pejlIVElW?=
 =?utf-8?B?U01MVHlSY05hdXNxZUo3NXg1enpzVFUyQlkxV0ZmL0tVeWQ1cFREekN6RndJ?=
 =?utf-8?B?WmpPWjhya3JRV09ZN1hCTTBEZnh5RFFpUlY4Sk4rK25XVkp1a09WMC9JWS95?=
 =?utf-8?B?QkxSNFNVbzJoY2VLa08xcVJISUxRTkl3MytoQTNFcTJCbEdZZW5pMjdkMndP?=
 =?utf-8?B?MHJRNlN6R3hBSzE4MmxXekJJUnBHTGROTW11bE50cXBvZmQzdmx6RUxyZVdQ?=
 =?utf-8?B?OHNlNkRsRlNseG1BblVQOW0zZHRKWWZEWXBSRmdCblR5NUVnY0h1WmRFWmxv?=
 =?utf-8?B?RFRpc0lDUm1lY1Q0ZnhWdWUrUzVkK3N4TGRqQ3htOVo1R2FSL2ZPTFZXdkdT?=
 =?utf-8?B?c2F5NEdFR1R6YUZPM3Y1M0EwOERIeThiL1NZZjF1MUR4U2xRSnp1VGRrOXI0?=
 =?utf-8?B?eXpxQzRtQ2toVmxxNG94b3FKVGJpRElmenprM3daRCtFYU1oTnlJZmdwVFVG?=
 =?utf-8?B?RlhoUlUyNmFITUVLeDZXaUNhUDUwcUlOQUgzSy9MaUpwME5PR2cvTEhEeHpi?=
 =?utf-8?B?aGZOZ1B2Sk96a2NHUlMrRTdDODc1QUZRdC9TWlRSenBqdHF4am4yT3lZVWRi?=
 =?utf-8?B?Y1BsbkN0VDNOcm9VQjV1a3dkeFZyUkxRNTUrZGpIdGJrOHBuVzJTRTlGL2hV?=
 =?utf-8?B?VldTZVNpdGZzRzJ0bDloRHJwb2VuSkxuV01JdXRoTjdRNW5JV0N1TGgvWVZk?=
 =?utf-8?B?ZUNucnAxSWxvTC9MT0ROMnVjTUZ0ZWlHSGFZdThlWCtkcU0rNHdoZmVIemdu?=
 =?utf-8?B?VFdwRFdRN3ArTTlTZHJOVDJqWXRkTlVwc1Z1MlZrUDZwSXJZbUR5UnNxRDFN?=
 =?utf-8?B?aDRRWVhFQXZBbDRySzR1OCsyUUp3T2V4SlUyUVVzU2lPUEJscjZ4TTNrTy9x?=
 =?utf-8?B?amU5a0VSZFJXRTRteDFFZTR2NXJDeUlsekUrYXFNMjZxeVh6QlI4NG1uZC9x?=
 =?utf-8?B?NnpSN005bkl5RThTYm9NTWF1WGxhd2EveHNnNkRSRzVrTGdrNEdzc3NCUmg0?=
 =?utf-8?B?Z1VESjR1NDh3a1N5bWdyZTQwOWZkYlI5S0grcHJRVWFXZHk2R3NZZ3R0Rm4v?=
 =?utf-8?B?WUkvUVlkNngyZ1lZY1d6MFhVUFl5QjNZdFoxa0JjV0hGdHk1OEZ3d3Y4Nlor?=
 =?utf-8?B?US92YmpUTFkzZnRXQWgrbjZvVk1ZelBGUlQrWFdrSndEcnAvR1JOMWV2TDR6?=
 =?utf-8?B?UmlObTZ1VDltdVNqeHl0amc5Mi9vckNGWTdrZXBqWlF4cldJbGlFUTBzYThm?=
 =?utf-8?B?S1Qva2V5QS9yREVCQkFIa0hMbDhZTzVnWXlZeXJUMVF2b1oxcVZwbGg4WVk1?=
 =?utf-8?B?MWI1WE5CZTVPaUFlS1lLUEdvdjQyQkhydDB1Wm12MDg0OTR0L1ZNTjRZN0d3?=
 =?utf-8?B?b1FOZ1pUOG5TRnB6U1Mzby9NZVJ6Q29lQTg4bXZRbWgxNzZ1bnFaU2VRZmg3?=
 =?utf-8?B?cHFYWFN0Z0ZxcFl6WFN6QmFWSWpkeGcxR1YvYTM2WUhheHpNYWY5U0VPeVJV?=
 =?utf-8?B?VGhTSjE5d2R5b0JEZHN3bmFOTDVJd1lZV0hjam1vUjJ0Z1kwc3dhL0Ruc0g3?=
 =?utf-8?B?QzlJeGl5ZUdUUWZaWms3Y0JxZU1pRXdPNjZaOUtBRWJ1ZUpPcUtEOTA3WTIr?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3A400C41D80244E826E066832673332@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb6cacb-edea-4df7-9bbe-08dd4b27016a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 05:35:05.5980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qabu22Ue7tetvNNfKzX3Odu+2GCzbAg/fRm9g0NSwDaMWXMOv6lSCQiPI9bvU7qEpkK51vDaNrDqS+d2PvxOZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTAyLTExIGF0IDE5OjQzICswMDAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
SU8gdGltZSBpcyBjb25zaWRlcmVkIGFzIGJ1c3kgYnkgZGVmYXVsdCBmb3IgbW9kZXJuIEludGVs
IHByb2Nlc3NvcnMuDQo+IEhvd2V2ZXIgdGhlIGNoZWNrIGRvZXNuJ3QgaW5jbHVkZSB0aGUgdXBj
b21pbmcgRmFtaWx5IDE4IGFuZCAxOQ0KPiBwcm9jZXNzb3JzLiBBbHNvLCBBcmphbiB2YW4gZGUg
VmVuIHNheXMgdGhlIGN1cnJlbnQgbmF0dXJlIG9mIHRoZQ0KPiBjaGVjaw0KPiB3YXMgbWFpbmx5
IGR1ZSB0byBsYWNrIG9mIHRlc3Rpbmcgb24gb2xkIHN5c3RlbXMuIEhlIHN1Z2dlc3RzDQo+IGNv
bnNpZGVyaW5nIGFsbCBJbnRlbCBwcm9jZXNzb3JzIGFzIGhhdmluZyBlZmZpY2llbnQgaWRsZS4N
Cj4gDQo+IEV4dGVuZCB0aGUgSU8gYnVzeSBjbGFzc2lmaWNhdGlvbiB0byBhbGwgSW50ZWwgcHJv
Y2Vzc29ycyBzdGFydGluZw0KPiB3aXRoDQo+IEZhbWlseSA2Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogU29oaWwgTWVodGEgPHNvaGlsLm1laHRhQGludGVsLmNvbT4NCj4gDQo+IC0tLQ0KPiANCj4g
djI6IEltcHJvdmUgY29tbWl0IG1lc3NhZ2UgYW5kIGNvZGUgY29tbWVudHMuDQo+IA0KPiAtLS0N
Cj4gwqBkcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9vbmRlbWFuZC5jIHwgMTUgKysrKysrKysrLS0t
LS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9vbmRlbWFuZC5jDQo+
IGIvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFfb25kZW1hbmQuYw0KPiBpbmRleCBhN2MzOGI4YjNl
NzguLmIxM2YxOTc3MDdmNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFf
b25kZW1hbmQuYw0KPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9vbmRlbWFuZC5jDQo+
IEBAIC0xNSw2ICsxNSwxMCBAQA0KPiDCoCNpbmNsdWRlIDxsaW51eC90aWNrLmg+DQo+IMKgI2lu
Y2x1ZGUgPGxpbnV4L3NjaGVkL2NwdWZyZXEuaD4NCj4gwqANCj4gKyNpZmRlZiBDT05GSUdfWDg2
DQo+ICsjaW5jbHVkZSA8YXNtL2NwdV9kZXZpY2VfaWQuaD4NCj4gKyNlbmRpZg0KPiArDQo+IMKg
I2luY2x1ZGUgImNwdWZyZXFfb25kZW1hbmQuaCINCj4gwqANCj4gwqAvKiBPbi1kZW1hbmQgZ292
ZXJub3IgbWFjcm9zICovDQo+IEBAIC0zMiwyMSArMzYsMjAgQEAgc3RhdGljIHVuc2lnbmVkIGlu
dCBkZWZhdWx0X3Bvd2Vyc2F2ZV9iaWFzOw0KPiDCoC8qDQo+IMKgICogTm90IGFsbCBDUFVzIHdh
bnQgSU8gdGltZSB0byBiZSBhY2NvdW50ZWQgYXMgYnVzeTsgdGhpcyBkZXBlbmRzDQo+IG9uIGhv
dw0KPiDCoCAqIGVmZmljaWVudCBpZGxpbmcgYXQgYSBoaWdoZXIgZnJlcXVlbmN5L3ZvbHRhZ2Ug
aXMuDQo+IC0gKiBQYXZlbCBNYWNoZWsgc2F5cyB0aGlzIGlzIG5vdCBzbyBmb3IgdmFyaW91cyBn
ZW5lcmF0aW9ucyBvZiBBTUQNCj4gYW5kIG9sZA0KPiAtICogSW50ZWwgc3lzdGVtcy4NCj4gKyAq
IFBhdmVsIE1hY2hlayBzYXlzIHRoaXMgaXMgbm90IHNvIGZvciB2YXJpb3VzIGdlbmVyYXRpb25z
IG9mIEFNRC4NCj4gwqAgKiBNaWtlIENoYW4gKGFuZHJvaWQuY29tKSBjbGFpbXMgdGhpcyBpcyBh
bHNvIG5vdCB0cnVlIGZvciBBUk0uDQo+IC0gKiBCZWNhdXNlIG9mIHRoaXMsIHdoaXRlbGlzdCBz
cGVjaWZpYyBrbm93biAoc2VyaWVzKSBvZiBDUFVzIGJ5DQo+IGRlZmF1bHQsIGFuZA0KPiArICog
QmVjYXVzZSBvZiB0aGlzLCBzZWxlY3Qga25vd24gc2VyaWVzIG9mIENQVXMgYnkgZGVmYXVsdCwg
YW5kDQo+IMKgICogbGVhdmUgYWxsIG90aGVycyB1cCB0byB0aGUgdXNlci4NCj4gwqAgKi8NCj4g
wqBzdGF0aWMgaW50IHNob3VsZF9pb19iZV9idXN5KHZvaWQpDQo+IMKgew0KPiDCoCNpZiBkZWZp
bmVkKENPTkZJR19YODYpDQo+IMKgCS8qDQo+IC0JICogRm9yIEludGVsLCBDb3JlIDIgKG1vZGVs
IDE1KSBhbmQgbGF0ZXIgaGF2ZSBhbiBlZmZpY2llbnQNCj4gaWRsZS4NCj4gKwkgKiBTdGFydGlu
ZyB3aXRoIEZhbWlseSA2IGNvbnNpZGVyIGFsbCBJbnRlbCBDUFVzIHRvIGhhdmUgYW4NCj4gKwkg
KiBlZmZpY2llbnQgaWRsZS4NCj4gwqAJICovDQo+IMKgCWlmIChib290X2NwdV9kYXRhLng4Nl92
ZW5kb3IgPT0gWDg2X1ZFTkRPUl9JTlRFTCAmJg0KPiAtCQkJYm9vdF9jcHVfZGF0YS54ODYgPT0g
NiAmJg0KPiAtCQkJYm9vdF9jcHVfZGF0YS54ODZfbW9kZWwgPj0gMTUpDQo+ICsJwqDCoMKgIGJv
b3RfY3B1X2RhdGEueDg2X3ZmbSA+PSBJTlRFTF9QRU5USVVNX1BSTykNCg0KVGhpcyBpcyAiU3Rh
cnRpbmcgZnJvbSBQNCIgcmF0aGVyIHRoYW4gIlN0YXJ0aW5nIGZyb20gRmFtaWx5IDYiLCByaWdo
dD8NCg0KdGhhbmtzLA0KcnVpDQo+IMKgCQlyZXR1cm4gMTsNCj4gwqAjZW5kaWYNCj4gwqAJcmV0
dXJuIDA7DQoNCg==

