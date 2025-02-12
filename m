Return-Path: <linux-acpi+bounces-11099-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4DBA32769
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 14:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85EC1164FE4
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF24120E716;
	Wed, 12 Feb 2025 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IODk8vrR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C120E6FA;
	Wed, 12 Feb 2025 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367842; cv=fail; b=fYGC6ZHy1w0vEf7TR7OSVVcLqL12CVrj9rdriiF0X10EHX0wQkFcgJeWdpgIJZu4uxHGlLy3fcWT3vVohWMtD1wgn1MPAKKmaotbJ+L6wXsu4sbb5SClYy2x7joS1xSK/JSIZv/q4fUE2Vq2EF7mxO47Rtur1zBj2jQd6+ihdGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367842; c=relaxed/simple;
	bh=lUKAgh3tI/R33rnQag4YzaxjCOBk+SHexz1Rq+jqyVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XoKxk5SQzq1XFeFprNMzlkbicpTIyV8fPh98fi1k2NMWwL2iIPmLoGBQozM9Z5OMhezzZCpjrh93gm8DGXMMugDtCWvqBIAwaYCTSf6Llcz07ecnEWQky6J9hVz7zJ7BNcLiM4JDPwpSuJRTKhI1FlB4+I2tUN3C9DU10j2+0p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IODk8vrR; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739367841; x=1770903841;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lUKAgh3tI/R33rnQag4YzaxjCOBk+SHexz1Rq+jqyVI=;
  b=IODk8vrRNp4jyV+OWYyajeBSzQu6omOrjxnzdm/dHFGcfwII+qpfpmcF
   gKDTOop6fWfYzWsUgLWYPM4apa9VYpcdQV5I/XLQBOlX5LraUcHwMv+0F
   9eoGMqwXm24IfwR66OnndUm/zi36+Z1nsT5DInUNbsWy0FQMM0o1cZFsD
   crDUQmFcLTBz++3vXVamzYN3UoSXGm80QIBf9xyr8QYJdiINnHdCQlQKu
   H2K2KZTxv2yslNew4d8KojPNMiIt/cvGHWSgjDJ+f7/hF5hmo7nU/n7wx
   Ayd9MpmckD5wsdM/gv1M3Mm1bMWh3TkefVH+YxiuJU5NI2+uEsKQeiU/7
   Q==;
X-CSE-ConnectionGUID: a+CjQm5WS5iZcIQYkttsrw==
X-CSE-MsgGUID: grvfr5vqT5W3kpn3864SFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40146175"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="40146175"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 05:44:00 -0800
X-CSE-ConnectionGUID: 2wVWzxrMT4CV2VXxbYnO1w==
X-CSE-MsgGUID: xGoRKjObQaqBouPx1Ix1ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118003307"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 05:43:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 05:43:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 05:43:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 05:43:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrDLVIyns6Dm8yL4bfPNKmU1mDkD5yjEgJXNVtCqxlAuA9gSwKYnFtrZpHzJtKy1lDtUHK6SGrxMZkNWZfsEF7NbrAxcACFygymbfcGU8ZQAwfn2T9+MKJ2UwqkU5zyhc9LFvUGWyEYlNrukOSqMuqBMb87XkPKqe1CFS8zsxnQvjYiqojm/75XrVu2U7c/tjUSnqWwUtDUFThpxOKzp+iZ/GoQOkW3Za2HzEJevB99UAjzdvToQBB0TLVOt0EzJAhGWPg4IL5vUFevBBuccGa82rgUqUy4rJ2NrefTkHuo5/m98aZ/CmVm7qjmEVtq4cCoJu1Q3gC/Nn8iV+YsngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUKAgh3tI/R33rnQag4YzaxjCOBk+SHexz1Rq+jqyVI=;
 b=OMEoluB+GE4eZWgqm6anpLnNZoTQ6nRAzi3xBt4PFj4r4ZNDErYG9zaRCt2uCgJcCw2xpLDs4uCjfNwsDUKonmdReqSmQLeTgvykR6mseAeTQj80nf4ENO/vHIjigPVLF26slM2CAjdzdohEZpthqkg/8L8uC29zVEUKTqlxXq+BGXLWYOKMaAMet53VuuTSS8T4E+KS/Hs/y2Wfx9HTKHHwwi7ptT+PZJw4VrUpWxwJe5fO+A/2i/VamdA8kgaSVk4OvY8XmgbjJk/TFvA2Hp+8dg4SRelC7Im1TCTZZzB52s1VwGvVLD2gEztsWzm6Qzjsl5/zC/jzZnpSJCQFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by DS0PR11MB7359.namprd11.prod.outlook.com (2603:10b6:8:134::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 13:43:25 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::91a:711e:b675:edac]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::91a:711e:b675:edac%6]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 13:43:25 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Luck, Tony"
	<tony.luck@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
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
	"linux@roeck-us.net" <linux@roeck-us.net>, "lenb@kernel.org"
	<lenb@kernel.org>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"bp@alien8.de" <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 07/17] hwmon: Fix Intel Family-model checks to include
 extended Families
Thread-Topic: [PATCH v2 07/17] hwmon: Fix Intel Family-model checks to include
 extended Families
Thread-Index: AQHbfL2rjK1vhQiYLUq3fbVp1YoV0LNClfWAgAALQoCAAQ14gA==
Date: Wed, 12 Feb 2025 13:43:25 +0000
Message-ID: <273b9080d42bcd2fb36fc4510416f0e111edee62.camel@intel.com>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
	 <20250211194407.2577252-8-sohil.mehta@intel.com>
	 <23e24c79-96ca-45da-832b-83a9b6456208@intel.com>
	 <882357df-7600-4aee-9fb1-4a118872f1af@intel.com>
In-Reply-To: <882357df-7600-4aee-9fb1-4a118872f1af@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|DS0PR11MB7359:EE_
x-ms-office365-filtering-correlation-id: a70ed847-ec58-46bb-243b-08dd4b6b3971
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QnJvaWhManlyb09FWGtkTVJ0MGM4MUpOSHF3ZXJoaWJsK2xQSmdnZloxNkQ1?=
 =?utf-8?B?WUhOZTBiWTlVZVoxK2tTUlU2anlHczRLNlpPZWJKT3Fra2dPUW05R2FZRGlv?=
 =?utf-8?B?cGpRZUhYWEc2ck5HSzNSQjhYRGtFZFdEcm9FS3NtRXp5dmZnYS9OZlFuRFRn?=
 =?utf-8?B?d3BHajB5UVd2eXFEQW1tcHZYRUNjTGE3V3dTTjRVNnljQVdYT0pUcjFoUWRy?=
 =?utf-8?B?WHFYcXBnZ0RlRFM0YWVwUm1EaTdHVnMzd1lrMXdLUmwxMGdEYk4xN3l6emtm?=
 =?utf-8?B?RFFKd0NmTW9JWEZCTDRyQStRTlE0SjBHRWtSV2NiUVNKZkdMQkwvOTQrQlhV?=
 =?utf-8?B?WHg1dVIzS00yZXlTN0NLcTlDNE5tQTlBVDlwdDd6V29hWXl4Zm1xUHc5UnpU?=
 =?utf-8?B?b3lPK3hLZXd3b0c1SGhmMjcrSVVVRjliTGtTQWIzY3ZNaWx1ajVtYVBjbmll?=
 =?utf-8?B?aCtaMkM3ditsaW1GQ3BWOU9RRlJXWklKOGgxeHBuZUowN1JKVDRvS2Q1U2dx?=
 =?utf-8?B?RjI4OHYybU1FRTF2TDlmS1lCNHExZVRtWGJGRlNoV2dRN24xcm9kZkRqelpY?=
 =?utf-8?B?ZDIrRFpRTzZIVXEraFJHZG9nZXNSaFhoWmhuMCtNRmxiRnRwSk05MDZ3L1pS?=
 =?utf-8?B?YlZkYlpKcmhYSFVQbWpBZjREQjFZZDdsTW5Gd1FvMS82ZWlCZTFNcUNwemkr?=
 =?utf-8?B?UklmUW83R2R4UEJrTGlPK1lGNFZvaTlvRHYrN0xpWXgwRzllZlphdHhXRjEw?=
 =?utf-8?B?MzlON21ITjkvQkJqcUNOVTVZWEVjL01MTm9uVmhxc084emVjS2V6Z0JkVU45?=
 =?utf-8?B?Y2lMWGNZbUdEejZxeGM4dWhmR0dRQnVYSkx1dE5mQUtNYUE3VjBqbTVocEN4?=
 =?utf-8?B?elR4MUttTnVJVlJSN1V3cnEyVGRjTFNnd2NWODZ5VEI4ZlFJS25tbWJWakpB?=
 =?utf-8?B?aVkySVlPTVJHYmJpcHpKVDd1eXpEa0grT2ZtclJRQThZMlFaYjE2OTJXSE92?=
 =?utf-8?B?S2x0WWxURHZ2TTVUSDZ4aFlNME1tTXZjaHROckIvcURZR3pIK0poNU5ycUhs?=
 =?utf-8?B?M2lmYzJJN0xZS0xnMGc4VTBKd2ZqUndIdVAvdUJwaXhBTXEwMWhERUM1KzZN?=
 =?utf-8?B?SDMzMWhvR1Y4bDg1WEwxZWkzbDV0TWJpclM2L1BwakRxYW9vZXZuZSsrSnNM?=
 =?utf-8?B?QVBPKy94cjVxc1RiWXg2Sm8zeDVHNEdoMFZVSWVsZWNEWk81SU5WNVpyVloy?=
 =?utf-8?B?MXFKV0hOakZtb2dzSWovN3owcENFaVZnVmd2NFBWVkh5MVRlYnB5b25EVzNp?=
 =?utf-8?B?WW9IRTBxK25pY296aTVVNGEvQkZtQWFhdzhaZnkydTN6V1ZNODQwTGRnQlJG?=
 =?utf-8?B?Q09xSkJSQlE2UXVsMmFOZjdMSFRXMmVmUlVyYksrTGgzcjBGMHpha2Q4T1ZB?=
 =?utf-8?B?K1piTXZyeC9teE51cWRmZmpmOTZtbWZKdWUyKzZmS0JPSFNiYVVhZkx0ZjNV?=
 =?utf-8?B?TnhRZDIrcmNtcU9IWjBwWENHc05paEVZUjNnczgvaFpoa0dHVHlKQjhkTVdW?=
 =?utf-8?B?WVcyY2dxYU1RazRXZUc1aFVmZDNmclVBaTlNTHRkMjdBRGVKaHZLNjNuVmJi?=
 =?utf-8?B?WGFvY0JPRnhBYlFubkJvSFN5d1FGU2xuS1RUZnBrU3AzRUxSRDRJQkxML0x2?=
 =?utf-8?B?eG8wSmhqWnZyZ1hPVlFmdHN6b1I3cW8rMGp0UWNOQU9jL2RBcGVWUDdMd09t?=
 =?utf-8?B?TWZrcEdSZ25DNTNZbGpZNS9TZ3B0SVYrZTNoU2kxdjJ3RmRNS0ZIWk1WS3A0?=
 =?utf-8?B?eUJFSWE0bCtKVlpHWlFxM2JxOGtHbEhnMHc3UzUvYlRWRXdMQnVGZFdLeXhl?=
 =?utf-8?B?Wk1jN2ljN2UzN1FQcTluMUxDTjJzZ2lTUFZ3bjQ0UU9FTHpDZlFhTXhRYTIz?=
 =?utf-8?Q?aP68nnY4faFCil42jRsmpYAaCQp3loO6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDVCUEhXMVJrM3hpd2g5VkNNcTdTNTVSKzNsalRSaVltVFdWSStpdmIrNVVG?=
 =?utf-8?B?dVdIV0ZqQ3RpbHFwTXA4UDljdS8yNytYY0hzdWRYTnRRbEtIWjNqLzNRU3Fj?=
 =?utf-8?B?VThzMDB6RGN3UHI4QlFaaW9NNEduQStubkhmVUV4QU5jNFBPSVQ0NytlZUt4?=
 =?utf-8?B?RG1UK0FNU1lqQi9oTm1PSk9rNDFiRmhodG0zTi9jZG9VZHFzVE0yVEU5RDR3?=
 =?utf-8?B?MGx4U3NwM0dlUExQOXJWMm1EKzI5enZlVktOMHBISDFLMzI1aFRUWkpIQ0lO?=
 =?utf-8?B?SUl5L2tzT1RaVlhoRHdxQ1NHWW9KMTlDb1orMG50bTlXY3NyRkhhNlNhMHUw?=
 =?utf-8?B?QktEbUdQdEdIamJDYVJ3dXdLNUZVZjNLRGhCT3NYQkVtMUZ1Z2tTYXNKejhn?=
 =?utf-8?B?RW5yeDVHVXlTNXdSMkJpb0VRMUc5dkZScDhwdHlxaktRYWNmYlUrOWxyS0dX?=
 =?utf-8?B?ak92dXI5ZVNhRGdUNHVmR1dOTTZXTG5vbHR2Zk9XMDhGQkhjaEhvMnFkcDU3?=
 =?utf-8?B?YXVFOHdXT09CTzJIRUZiOVpCclJSeGtOQ0w0S3hrK01WV3NLdDRTZGhDbWdP?=
 =?utf-8?B?bGxFaElDV29vV1dBYUY0Rkk3SWNEbmdZU01vUU9Tb2hqYkZZSkhiWXcxaHhJ?=
 =?utf-8?B?U0R4Vzk4TlR2Z3NzU3ZoNFlyUi8rZlZ5TDFNbjBMdDE0eDJML2JEbnRDVkZl?=
 =?utf-8?B?cllJNWw5N2ltV3JadzQvelQ1eFU1WlpDc2N4bWFsREo3czk3TTFrdEwvOFlO?=
 =?utf-8?B?Tk83YlR5RHJOd2twMGtoaHF0cmVzR292WDAvdGlqd2VpQTRHT01oUjE0U0ZF?=
 =?utf-8?B?ajB2VjJWbEhVNVh1SFYycHNTUWd6N3grdWFGYUI0N3RFUnBqb0hWSUxuM1k0?=
 =?utf-8?B?VkVTU1g2bU1MRHl0MFZ6VVNySUV6QTFIQTIrQ05LSHhlcU0wSUJuTDMrdUZv?=
 =?utf-8?B?eGdSMGdab3Nod0l3VDJmcmd0Q09JOFA2c3AvVGdibXVjTlNTaWs2V0tmYVll?=
 =?utf-8?B?THVKenQ5T0xsNVM5blpSaVVQcm43K1d4NGdvT2VWYkwwRFllYnVwZC9Hcjdw?=
 =?utf-8?B?U2RScngvaXBORkpKSkRvcklMY2FZVFA5NE96U3V6Y2ZDWVFZdmpuaG9tUVgy?=
 =?utf-8?B?eDZJbmNsdTZNL2tRckRidVQvdUtBVnNvcW1nMDZpQ2RCT2NMQ0k4dnJMNjk1?=
 =?utf-8?B?WlJ6UXpFcWhWWXNKS0FuRUd6VU52Rm54V2RiRUFnMFpyMkdoaHQySENzQTkz?=
 =?utf-8?B?YnhzS2t5UGV6WjVNdVVGa2xOTFZtNW1XNTNuVmFCRGwyYWxyaHRRZ29pVTQ5?=
 =?utf-8?B?ZUtLelBqU2wwb0oyUDdITU1XbjRFVXNuajEwWldTc2lyakZaSmRJbTFzN1Y0?=
 =?utf-8?B?MGl3VGVSSkVQK3pycHJEbWx0YmN4bXJzWFp4OEtzY1BhSlpXanYwU3g2Rzkx?=
 =?utf-8?B?eHhBV0hxUW1VVUl6MFJ4U1haaXV6VlgwaFpzU0Jnd2Y5VkQ3SjljY3N0d3dp?=
 =?utf-8?B?Ni9mN21ZSEViY001ZndnNGRFalRRK1Z2OHhLblE2b1Z1T2hleExITG12SjAv?=
 =?utf-8?B?N3hVUDEzakhENFRrRVZETUIvK1lmYkoycnhnU3kwM1hkRWN2NFR0VksrclIx?=
 =?utf-8?B?N0tkT2swVzRwMS9GRGxlb2Fjbk0vUFFBNFMwU0NmYitjc1p1NEFBOWl1b2o2?=
 =?utf-8?B?WkE4a2xFTW1OUCtPVk00T3psbHVoVC9iYnJkR2VBOG4yekh3WlUzU2ZLQTdZ?=
 =?utf-8?B?S1BhbHgvQVFuOTU2Uk9kN0JNQmU5WGZjTmlSYkpHM1d3ZlVkMHRTU1FFOTFx?=
 =?utf-8?B?QThtUk1sZHUrcWNmUXNUcGVSdkJhbllreUJPbkRpalN0bVRhWUUvRHhKSUc0?=
 =?utf-8?B?ZXROUERaTElPWDhpTU16RVVFMkZkajZ4M3J6ZkVhZGZOOVVvUDFlSkFES25y?=
 =?utf-8?B?QldCVWtyNFlKc2VPZVdxSFVxOXcrRk9XOGt2cU8zR0RKNzFBMFY1amVzSUhs?=
 =?utf-8?B?Wi9zNjkyUE5QK201ay9nbUlnZ1hoK1VWdVFCd0VVcXl4Nm5STm8zcHpoK0Ur?=
 =?utf-8?B?a3RNeDM1S055TjczVjdhNkhzcVBiK0VYWGF3V2VOeGY4SFU4SHUxRHo1YWpI?=
 =?utf-8?B?VEIwMVh4Mk9GdmE4VDBjclFWN296VVJhWlFIRGY0bmhVSlo2aWwzZGppaWdY?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0F7B4F268FC7846BBE1CAD51A9AE798@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70ed847-ec58-46bb-243b-08dd4b6b3971
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 13:43:25.3714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VggQGiC2BY21AQ4/qo4SdN1L2BaSeMuQOpV89/X6snYd3B0+cYmaS7nPrJjW7/ya/PVMUXUmpBkSNaVVyJa7Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7359
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEzOjM4IC0wODAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
T24gMi8xMS8yMDI1IDEyOjU4IFBNLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4gPiBPbiAyLzExLzI1
IDExOjQzLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoC8qDQo+ID4g
PiArwqDCoMKgwqDCoMKgwqAgKiBSZXR1cm4gd2l0aG91dCBhZGp1c3RtZW50IGlmIHRoZSBGYW1p
bHkgaXNuJ3QgNi4NCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCAqIFRoZSByZXN0IG9mIHRoZSBmdW5j
dGlvbiBhc3N1bWVzIEZhbWlseSA2Lg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgICovDQo+ID4gPiAr
wqDCoMKgwqDCoMKgwqBpZiAoYy0+eDg2ICE9IDYpDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIHRqbWF4Ow0KPiA+IA0KPiA+IFNob3VsZG4ndCB3ZSBiZSBjb252
ZXJ0aW5nIHRoaXMgb3ZlciB0byB0aGUgdmZtIG1hdGNoZXM/DQo+ID4gDQo+IA0KPiBGb3IgZHJp
dmVycy8sIEkgbWFpbmx5IGZvY3VzZWQgb24gZml4ZXMgaW5zdGVhZCBvZiBjbGVhbnVwcy4NCj4g
DQo+IENvbnZlcnRpbmcgZHJpdmVycyBvdmVyIHRvIFZGTSBjaGVja3MgaXMgc2lnbmlmaWNhbnQg
d29yay4gVGhlcmUgYXJlDQo+IGENCj4gbG90IG9mIHN1Y2ggY29tcGFyaXNvbnMgYW5kIHN3aXRj
aCBjYXNlcyAocHJvYmFibHkgbW9yZSB0aGFuIDUwKQ0KPiBhY3Jvc3MNCj4gZHJpdmVycy9jcHVm
cmVxLyBhbmQgZHJpdmVycy9od21vbi8uDQo+IA0KPiBTb21lIG9mIHRoZSBmdW5jdGlvbnMgbWln
aHQgbmVlZCBzaWduaWZpY2FudCByZWZhY3RvcmluZyBhbmQNCj4gcmV3cml0ZXMuIEkNCj4gdGhp
bmsgc29tZW9uZSB3aXRoIGV4cGVydGlzZSBpbiB0aGF0IHBhcnRpY3VsYXIgZHJpdmVyIHNob3Vs
ZA0KPiBwcm9iYWJseQ0KPiBkbyBpdC4gSSBkaWQgc3RhcnQgd2l0aCBpdCBpbml0aWFsbHkgYnV0
IGl0IGlzIGJleW9uZCBteSBiYW5kd2lkdGggYXQNCj4gdGhlIG1vbWVudC4NCj4gDQpJIGFncmVl
Lg0KYWRqdXN0X3RqbWF4KCkgY29udGFpbnMgYSBsaXN0IG9mIHF1aXJrcyBiYXNlZCBvbiBQQ0kt
DQpJRC94ODZfdmVuZG9yX2lkL3g4Nl9tb2RlbC94ODZfc3RlcHBpbmcuIFRoZSBjb21tb24gcHJv
YmxlbSBpcyB0aGF0IGFsbA0KdGhlIHF1aXJrcyBhcmUgZm9yIEZhbTYgcHJvY2Vzc29ycyBidXQg
dGhlIGZhbWlseSBpZCBpcyBub3QgY2hlY2tlZC4gU28NCnRoZSBmaXggaXMgc3VmZmljaWVudC4g
SW4gZmFjdCwgSSB0aGluayBpdCBpcyBiZXR0ZXIgdG8gbW92ZSB0aGUgY2hlY2sNCnRvIHRoZSB2
ZXJ5IGJlZ2lubmluZyBvZiBhZGp1c3RfdGptYXgoKS4NCg0KUGx1cyB0aGF0LCBJIGRvIHRoaW5r
IHdlIGNhbiBoYXZlIG1vcmUgY2xlYW51cHMgb24gdG9wDQoxLiByZW5hbWUgYWRqdXN0X3RqbWF4
KCkgdG8gYWRqdXN0X3RqbWF4X2Zvcl9mYW02KCkNCjIuIG1vdmUgYWxsIG1vZGVsIHNwZWNpZmlj
IHF1aXJrcyBhbHRvZ2V0aGVyIGFuZCBhdm9pZCBtb2RlbCBjaGVja3MgaW4NCnRoZSBtYWluIGZ1
bmN0aW9ucy4NCjMuIGZvciBwcm9jZXNzb3JzIG5ld2VyIHRoYW4gZmFtNiwgdGhlIGRyaXZlciBz
aG91bGQgZmFpbCB0byBwcm9iZQ0KcmF0aGVyIHRoYW4gdXNpbmcgYSBoYXJkY29kZWQgdmFsdWUg
d2hlbiByZWFkaW5nDQpNU1JfSUEzMl9URU1QRVJBVFVSRV9UQVJHRVQgZmFpbHMuDQoNCm1heWJl
IEkgY2FuIHN0YXJ0IHdpdGggc29tZXRoaW5nIGxpa2UgYmVsb3cuDQoNCi0tLQ0KIGRyaXZlcnMv
aHdtb24vY29yZXRlbXAuYyB8IDk4ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKSwgNDEgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMgYi9kcml2ZXJzL2h3bW9u
L2NvcmV0ZW1wLmMNCmluZGV4IDFhYTY3YTJiNWYxOC4uZmMyY2Y2MDdhYTM2IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9od21vbi9jb3JldGVtcC5jDQorKysgYi9kcml2ZXJzL2h3bW9uL2NvcmV0ZW1w
LmMNCkBAIC05OSw2ICs5OSw3IEBAIHN0cnVjdCBwbGF0Zm9ybV9kYXRhIHsNCiAJc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgbmFtZV9hdHRyOw0KIH07DQogDQorLyogQmVnaW5uaW5nIG9mIE1vZGVs
IHNwZWNpZmljIHF1aXJrcyAqLw0KIHN0cnVjdCB0am1heF9wY2kgew0KIAl1bnNpZ25lZCBpbnQg
ZGV2aWNlOw0KIAlpbnQgdGptYXg7DQpAQCAtMTQ3LDEyICsxNDgsMTEgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCB0am1heF9tb2RlbCB0am1heF9tb2RlbF90YWJsZVtdID0gew0KIAkJCQkgKi8NCiB9
Ow0KIA0KLXN0YXRpYyBib29sIGlzX3BrZ190ZW1wX2RhdGEoc3RydWN0IHRlbXBfZGF0YSAqdGRh
dGEpDQotew0KLQlyZXR1cm4gdGRhdGEtPmluZGV4IDwgMDsNCi19DQotDQotc3RhdGljIGludCBh
ZGp1c3RfdGptYXgoc3RydWN0IGNwdWluZm9feDg2ICpjLCB1MzIgaWQsIHN0cnVjdCBkZXZpY2Ug
KmRldikNCisvKg0KKyAqIEFkanVzdCB0am1heCB2YWx1ZSBmb3IgZWFybHkgRmFtNiBDUFVzIHdp
dGggdW5yZWFkYWJsZSBNU1JfSUEzMl9URU1QRVJBVFVSRV9UQVJHRVQNCisgKiBOT1RFOiB0aGUg
Y2FsY3VsYXRlZCB2YWx1ZSBtYXkgbm90IGJlIGNvcnJlY3QuDQorICovDQorc3RhdGljIGludCBh
ZGp1c3RfdGptYXhfZm9yX2ZhbTYoc3RydWN0IGNwdWluZm9feDg2ICpjLCB1MzIgaWQsIHN0cnVj
dCBkZXZpY2UgKmRldikNCiB7DQogCS8qIFRoZSAxMDBDIGlzIGRlZmF1bHQgZm9yIGJvdGggbW9i
aWxlIGFuZCBub24gbW9iaWxlIENQVXMgKi8NCiANCkBAIC0xNjMsOCArMTYzLDE2IEBAIHN0YXRp
YyBpbnQgYWRqdXN0X3RqbWF4KHN0cnVjdCBjcHVpbmZvX3g4NiAqYywgdTMyIGlkLCBzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQogCXUzMiBlYXgsIGVkeDsNCiAJaW50IGk7DQogCXUxNiBkZXZmbiA9IFBD
SV9ERVZGTigwLCAwKTsNCi0Jc3RydWN0IHBjaV9kZXYgKmhvc3RfYnJpZGdlID0gcGNpX2dldF9k
b21haW5fYnVzX2FuZF9zbG90KDAsIDAsIGRldmZuKTsNCisJc3RydWN0IHBjaV9kZXYgKmhvc3Rf
YnJpZGdlOw0KKw0KKwkvKg0KKwkgKiBSZXR1cm4gd2l0aG91dCBhZGp1c3RtZW50IGlmIHRoZSBG
YW1pbHkgaXNuJ3QgNi4NCisJICogVGhlIHJlc3Qgb2YgdGhlIGZ1bmN0aW9uIGFzc3VtZXMgRmFt
aWx5IDYuDQorCSAqLw0KKwlpZiAoYy0+eDg2ICE9IDYpDQorCQlyZXR1cm4gdGptYXg7DQogDQor
CWhvc3RfYnJpZGdlID0gcGNpX2dldF9kb21haW5fYnVzX2FuZF9zbG90KDAsIDAsIGRldmZuKTsN
CiAJLyoNCiAJICogRXhwbGljaXQgdGptYXggdGFibGUgZW50cmllcyBvdmVycmlkZSBoZXVyaXN0
aWNzLg0KIAkgKiBGaXJzdCB0cnkgUENJIGhvc3QgYnJpZGdlIElEcywgZm9sbG93ZWQgYnkgbW9k
ZWwgSUQgc3RyaW5ncw0KQEAgLTE4NSwxMiArMTkzLDYgQEAgc3RhdGljIGludCBhZGp1c3RfdGpt
YXgoc3RydWN0IGNwdWluZm9feDg2ICpjLCB1MzIgaWQsIHN0cnVjdCBkZXZpY2UgKmRldikNCiAJ
CQlyZXR1cm4gdGptYXhfdGFibGVbaV0udGptYXg7DQogCX0NCiANCi0JLyoNCi0JICogUmV0dXJu
IHdpdGhvdXQgYWRqdXN0bWVudCBpZiB0aGUgRmFtaWx5IGlzbid0IDYuDQotCSAqIFRoZSByZXN0
IG9mIHRoZSBmdW5jdGlvbiBhc3N1bWVzIEZhbWlseSA2Lg0KLQkgKi8NCi0JaWYgKGMtPng4NiAh
PSA2KQ0KLQkJcmV0dXJuIHRqbWF4Ow0KIA0KIAlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh0
am1heF9tb2RlbF90YWJsZSk7IGkrKykgew0KIAkJY29uc3Qgc3RydWN0IHRqbWF4X21vZGVsICp0
bSA9ICZ0am1heF9tb2RlbF90YWJsZVtpXTsNCkBAIC0yODAsNiArMjgyLDM3IEBAIHN0YXRpYyBi
b29sIGNwdV9oYXNfdGptYXgoc3RydWN0IGNwdWluZm9feDg2ICpjKQ0KIAkJbW9kZWwgIT0gMHgz
Nik7DQogfQ0KIA0KK3N0YXRpYyBib29sIGNwdV9oYXNfdHRhcmdldChzdHJ1Y3QgdGVtcF9kYXRh
ICp0ZGF0YSkNCit7DQorCXN0cnVjdCBjcHVpbmZvX3g4NiAqYyA9ICZjcHVfZGF0YSh0ZGF0YS0+
Y3B1KTsNCisNCisJLyoNCisJICogVGhlIHRhcmdldCB0ZW1wZXJhdHVyZSBpcyBhdmFpbGFibGUg
b24gb2xkZXIgQ1BVcyBidXQgbm90IGluIHRoZQ0KKwkgKiBNU1JfSUEzMl9URU1QRVJBVFVSRV9U
QVJHRVQgcmVnaXN0ZXIuIEF0b21zIGRvbid0IGhhdmUgdGhlIHJlZ2lzdGVyDQorCSAqIGF0IGFs
bC4NCisJICovDQorCWlmIChjLT54ODYgPiAxNSB8fCAoYy0+eDg2ID09IDYgJiYgYy0+eDg2X21v
ZGVsID4gMHhlICYmIGMtPng4Nl9tb2RlbCAhPSAweDFjKSkNCisJCXJldHVybiB0cnVlOw0KKwly
ZXR1cm4gZmFsc2U7DQorfQ0KKw0KK3N0YXRpYyBib29sIGNwdV9oYXNfYnJva2VuX3Vjb2RlKHVu
c2lnbmVkIGludCBjcHUpDQorew0KKwlzdHJ1Y3QgY3B1aW5mb194ODYgKmMgPSAmY3B1X2RhdGEo
Y3B1KTsNCisNCisJLyoNCisJICogQ2hlY2sgaWYgd2UgaGF2ZSBwcm9ibGVtIHdpdGggZXJyYXRh
IEFFMTggb2YgQ29yZSBwcm9jZXNzb3JzOg0KKwkgKiBSZWFkaW5ncyBtaWdodCBzdG9wIHVwZGF0
ZSB3aGVuIHByb2Nlc3NvciB2aXNpdGVkIHRvbyBkZWVwIHNsZWVwLA0KKwkgKiBmaXhlZCBmb3Ig
c3RlcHBpbmcgRDAgKDZFQykuDQorCSAqLw0KKwlpZiAoYy0+eDg2ID09IDYgJiYgYy0+eDg2X21v
ZGVsID09IDB4ZSAmJiBjLT54ODZfc3RlcHBpbmcgPCAweGMgJiYgYy0+bWljcm9jb2RlIDwgMHgz
OSkgew0KKwkJcHJfZXJyKCJFcnJhdGEgQUUxOCBub3QgZml4ZWQsIHVwZGF0ZSBCSU9TIG9yIG1p
Y3JvY29kZSBvZiB0aGUgQ1BVIVxuIik7DQorCQlyZXR1cm4gdHJ1ZTsNCisJfQ0KKwlyZXR1cm4g
ZmFsc2U7DQorfQ0KKy8qIEVuZCBvZiBNb2RlbCBzcGVjaWZpYyBxdWlya3MgKi8NCisNCiBzdGF0
aWMgaW50IGdldF90am1heChzdHJ1Y3QgdGVtcF9kYXRhICp0ZGF0YSwgc3RydWN0IGRldmljZSAq
ZGV2KQ0KIHsNCiAJc3RydWN0IGNwdWluZm9feDg2ICpjID0gJmNwdV9kYXRhKHRkYXRhLT5jcHUp
Ow0KQEAgLTMxMiw5ICszNDUsOCBAQCBzdGF0aWMgaW50IGdldF90am1heChzdHJ1Y3QgdGVtcF9k
YXRhICp0ZGF0YSwgc3RydWN0IGRldmljZSAqZGV2KQ0KIAl9IGVsc2Ugew0KIAkJLyoNCiAJCSAq
IEFuIGFzc3VtcHRpb24gaXMgbWFkZSBmb3IgZWFybHkgQ1BVcyBhbmQgdW5yZWFkYWJsZSBNU1Iu
DQotCQkgKiBOT1RFOiB0aGUgY2FsY3VsYXRlZCB2YWx1ZSBtYXkgbm90IGJlIGNvcnJlY3QuDQog
CQkgKi8NCi0JCXRkYXRhLT50am1heCA9IGFkanVzdF90am1heChjLCB0ZGF0YS0+Y3B1LCBkZXYp
Ow0KKwkJdGRhdGEtPnRqbWF4ID0gYWRqdXN0X3RqbWF4X2Zvcl9mYW02KGMsIHRkYXRhLT5jcHUs
IGRldik7DQogCX0NCiAJcmV0dXJuIHRkYXRhLT50am1heDsNCiB9DQpAQCAtMzI0LDYgKzM1Niw4
IEBAIHN0YXRpYyBpbnQgZ2V0X3R0YXJnZXQoc3RydWN0IHRlbXBfZGF0YSAqdGRhdGEsIHN0cnVj
dCBkZXZpY2UgKmRldikNCiAJdTMyIGVheCwgZWR4Ow0KIAlpbnQgdGptYXgsIHR0YXJnZXRfb2Zm
c2V0LCByZXQ7DQogDQorCWlmICghY3B1X2hhc190dGFyZ2V0KHRkYXRhKSkNCisJCXJldHVybiAt
RU5PREVWOw0KIAkvKg0KIAkgKiB0dGFyZ2V0IGlzIHZhbGlkIG9ubHkgaWYgdGptYXggY2FuIGJl
IHJldHJpZXZlZCBmcm9tDQogCSAqIE1TUl9JQTMyX1RFTVBFUkFUVVJFX1RBUkdFVA0KQEAgLTM0
OCw2ICszODIsMTEgQEAgc3RhdGljIGludCBtYXhfem9uZXMgX19yZWFkX21vc3RseTsNCiAvKiBB
cnJheSBvZiB6b25lIHBvaW50ZXJzLiBTZXJpYWxpemVkIGJ5IGNwdSBob3RwbHVnIGxvY2sgKi8N
CiBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqKnpvbmVfZGV2aWNlczsNCiANCitzdGF0
aWMgYm9vbCBpc19wa2dfdGVtcF9kYXRhKHN0cnVjdCB0ZW1wX2RhdGEgKnRkYXRhKQ0KK3sNCisJ
cmV0dXJuIHRkYXRhLT5pbmRleCA8IDA7DQorfQ0KKw0KIHN0YXRpYyBzc2l6ZV90IHNob3dfbGFi
ZWwoc3RydWN0IGRldmljZSAqZGV2LA0KIAkJCQlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqZGV2
YXR0ciwgY2hhciAqYnVmKQ0KIHsNCkBAIC00NjAsMjMgKzQ5OSw2IEBAIHN0YXRpYyBpbnQgY3Jl
YXRlX2NvcmVfYXR0cnMoc3RydWN0IHRlbXBfZGF0YSAqdGRhdGEsIHN0cnVjdCBkZXZpY2UgKmRl
dikNCiAJcmV0dXJuIHN5c2ZzX2NyZWF0ZV9ncm91cCgmZGV2LT5rb2JqLCAmdGRhdGEtPmF0dHJf
Z3JvdXApOw0KIH0NCiANCi0NCi1zdGF0aWMgaW50IGNoa191Y29kZV92ZXJzaW9uKHVuc2lnbmVk
IGludCBjcHUpDQotew0KLQlzdHJ1Y3QgY3B1aW5mb194ODYgKmMgPSAmY3B1X2RhdGEoY3B1KTsN
Ci0NCi0JLyoNCi0JICogQ2hlY2sgaWYgd2UgaGF2ZSBwcm9ibGVtIHdpdGggZXJyYXRhIEFFMTgg
b2YgQ29yZSBwcm9jZXNzb3JzOg0KLQkgKiBSZWFkaW5ncyBtaWdodCBzdG9wIHVwZGF0ZSB3aGVu
IHByb2Nlc3NvciB2aXNpdGVkIHRvbyBkZWVwIHNsZWVwLA0KLQkgKiBmaXhlZCBmb3Igc3RlcHBp
bmcgRDAgKDZFQykuDQotCSAqLw0KLQlpZiAoYy0+eDg2ID09IDYgJiYgYy0+eDg2X21vZGVsID09
IDB4ZSAmJiBjLT54ODZfc3RlcHBpbmcgPCAweGMgJiYgYy0+bWljcm9jb2RlIDwgMHgzOSkgew0K
LQkJcHJfZXJyKCJFcnJhdGEgQUUxOCBub3QgZml4ZWQsIHVwZGF0ZSBCSU9TIG9yIG1pY3JvY29k
ZSBvZiB0aGUgQ1BVIVxuIik7DQotCQlyZXR1cm4gLUVOT0RFVjsNCi0JfQ0KLQlyZXR1cm4gMDsN
Ci19DQotDQogc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmNvcmV0ZW1wX2dldF9wZGV2
KHVuc2lnbmVkIGludCBjcHUpDQogew0KIAlpbnQgaWQgPSB0b3BvbG9neV9sb2dpY2FsX2RpZV9p
ZChjcHUpOw0KQEAgLTU4NSwxNCArNjA3LDggQEAgc3RhdGljIGludCBjcmVhdGVfY29yZV9kYXRh
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsIHVuc2lnbmVkIGludCBjcHUsDQogCS8qIE1h
a2Ugc3VyZSB0ZGF0YS0+dGptYXggaXMgYSB2YWxpZCBpbmRpY2F0b3IgZm9yIGR5bmFtaWMvc3Rh
dGljIHRqbWF4ICovDQogCWdldF90am1heCh0ZGF0YSwgJnBkZXYtPmRldik7DQogDQotCS8qDQot
CSAqIFRoZSB0YXJnZXQgdGVtcGVyYXR1cmUgaXMgYXZhaWxhYmxlIG9uIG9sZGVyIENQVXMgYnV0
IG5vdCBpbiB0aGUNCi0JICogTVNSX0lBMzJfVEVNUEVSQVRVUkVfVEFSR0VUIHJlZ2lzdGVyLiBB
dG9tcyBkb24ndCBoYXZlIHRoZSByZWdpc3Rlcg0KLQkgKiBhdCBhbGwuDQotCSAqLw0KLQlpZiAo
Yy0+eDg2ID4gMTUgfHwgKGMtPng4NiA9PSA2ICYmIGMtPng4Nl9tb2RlbCA+IDB4ZSAmJiBjLT54
ODZfbW9kZWwgIT0gMHgxYykpDQotCQlpZiAoZ2V0X3R0YXJnZXQodGRhdGEsICZwZGV2LT5kZXYp
ID49IDApDQotCQkJdGRhdGEtPmF0dHJfc2l6ZSsrOw0KKwlpZiAoZ2V0X3R0YXJnZXQodGRhdGEs
ICZwZGV2LT5kZXYpID49IDApDQorCQl0ZGF0YS0+YXR0cl9zaXplKys7DQogDQogCS8qIENyZWF0
ZSBzeXNmcyBpbnRlcmZhY2VzICovDQogCWVyciA9IGNyZWF0ZV9jb3JlX2F0dHJzKHRkYXRhLCBw
ZGF0YS0+aHdtb25fZGV2KTsNCkBAIC02OTYsNyArNzEyLDcgQEAgc3RhdGljIGludCBjb3JldGVt
cF9jcHVfb25saW5lKHVuc2lnbmVkIGludCBjcHUpDQogCQlzdHJ1Y3QgZGV2aWNlICpod21vbjsN
CiANCiAJCS8qIENoZWNrIHRoZSBtaWNyb2NvZGUgdmVyc2lvbiBvZiB0aGUgQ1BVICovDQotCQlp
ZiAoY2hrX3Vjb2RlX3ZlcnNpb24oY3B1KSkNCisJCWlmIChjcHVfaGFzX2Jyb2tlbl91Y29kZShj
cHUpKQ0KIAkJCXJldHVybiAtRUlOVkFMOw0KIA0KIAkJLyoNCi0tIA0KMi40My4wDQoNCg0KDQoN
Cg0KDQoNCg==

