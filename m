Return-Path: <linux-acpi+bounces-11184-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0609DA3546F
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 03:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CD63AD728
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 02:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675B913D893;
	Fri, 14 Feb 2025 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuitTtjf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853A33C9;
	Fri, 14 Feb 2025 02:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498617; cv=fail; b=te9Dxtos/u6bpcgj6kbS6ZpC5LM1wlX6bVE8VUzO0jZy2ax9ardXeAAnE0d1RlGuopCuq9wdE4WE1AcHrRT059tIPXD9dtiTa/k4xKTWGP0wnmWNmXT5yRuG030s+l+71VFXyxxPJ59YmQeGQqlp/SM4ohsI9Xy5j/0R/LW8kMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498617; c=relaxed/simple;
	bh=e3VV7JGTs+YUYdLFELne2PM5mj2FVWhXlgRJRb/2NZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V5SaGujmV+8o/iD+nyBWDFULap2hoPmfL4Wa7tKxnnQ2K0Nuu77CpjHO8/pawhQT0x21SuNn9UIsaRMTdVqFvQMBERWezDgqCNrymf7HLzGaAx9igq9lg04wwpc1VUcfAl+r+TlNQwIEqJMhaD6BoriRdeBmX1a487IsDRPResE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuitTtjf; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739498615; x=1771034615;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e3VV7JGTs+YUYdLFELne2PM5mj2FVWhXlgRJRb/2NZk=;
  b=MuitTtjfNGTrI8aDDrucADBNYXNB1JhHm8pDXaF8tvTNzsTvPF6ZCuNZ
   ik7GIKfr05m2V5mWTCA4SB8v2nmY8GCbWHdo6SC0yKJoE7rH5/kUT3rvj
   07JX75suEOY+sWzhvtCKL5nV6jtMga1m4VVBp+4zm2C41GH3KvfvTBMkE
   nwOdKohBPIiNlolXRboXeJG89TV+U70OpeVSvjXyOARP+38VqasDI7Psp
   ymjOiJcvjin+9F/YXhdoccUz+5UKGJ2p4JM+CvoWPeDS5jrfozQajs6hh
   5VOhgN2APU1jXIDz5UVXRgx9ySLQnLYAuGHhvP0CGrFL4VT9EIiq4+ftM
   Q==;
X-CSE-ConnectionGUID: RhemH33FSa+UB+wGURHZuw==
X-CSE-MsgGUID: 0DZko0u7SV64taX1WlJvew==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="44000424"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="44000424"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 18:03:34 -0800
X-CSE-ConnectionGUID: e3ebkiQWQ8uGIByLXjzmVA==
X-CSE-MsgGUID: 3HoD3jDaSRq9eGmQvvUIZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114216766"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 18:03:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 18:03:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 18:03:28 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 18:03:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wN6cK9U9t/j4TzWKFW1hemlTlTG5Q4ttYPoMsyyPeSd/9ZoRnW4foPNjwMuvRbDA2x9evl0rBRYXzg6NTmekAkeuhZdjTikwn8lA+otqwokBkub82E4/MHhp8KqI1AUmSA39/tlIUhyT+CaF3QNzLRQeEep9ea/Vo2iuUr95XiI9zl59STxWkEjEHBZJiZUAYRwU+TrnCbM1SSVzAH+wUMO5rkOYwPjyUroLe0gqMcXH4zKvh+vz1Q5PmXxuPAWBpyNSq2AkABSyuA2jYKb4pH4PDnddzt3oONP2LCOX4GU3mhHc3KSMG11fBBiLTAx/QsaWxqCxUNO/+goekDkEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3VV7JGTs+YUYdLFELne2PM5mj2FVWhXlgRJRb/2NZk=;
 b=v9IcllBvtC2YkOpupjHDPvF0ClIrCsptvE9SBfoSJO3HTlIVmNWY6F40K6E/T/YpcoUqWFlePJYAtMbnFDnM57Qoc0XlBQCKbSNQ2VD5VLoV2PyfPZFS2Fr3hJlFecdAiVRDewSewSPlenoQhpdX+CbYZ0waUVD7C3043BW3CrHFxrrKzbrjBBAHZrQpKV4rEPwJbypTSKY3sQ/g0X+JzWExNv1WDgWJfS4f9eF1mkLn6BCsuQOXhpYy04n0qBLpeJ8AlJ1T7P0d5vufJ5daybxGsbXarZGyzpPwlueE7n5gjrZx+SbvdeZPf946Uxrs8gh04Z+UxEvsLnoYkAUn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MN2PR11MB4696.namprd11.prod.outlook.com (2603:10b6:208:26d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 02:03:24 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%3]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 02:03:24 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Luck, Tony"
	<tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, "luto@kernel.org"
	<luto@kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "david.laight.linux@gmail.com"
	<david.laight.linux@gmail.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "jdelvare@suse.com" <jdelvare@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "irogers@google.com"
	<irogers@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"fenghua.yu@intel.com" <fenghua.yu@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "bp@alien8.de" <bp@alien8.de>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "acme@kernel.org"
	<acme@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 06/17] cpufreq: Fix the efficient idle check for Intel
 extended Families
Thread-Topic: [PATCH v2 06/17] cpufreq: Fix the efficient idle check for Intel
 extended Families
Thread-Index: AQHbfL2tst/1HnpQu0G3BANsl6xZFrNDJi0AgAJwagCAAHksgA==
Date: Fri, 14 Feb 2025 02:03:24 +0000
Message-ID: <f162dda5daba3cc96d1bd4f07d710823ffb9eb01.camel@intel.com>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
	 <20250211194407.2577252-7-sohil.mehta@intel.com>
	 <56eb1f8bda3932632cc0b17dde053f77fe7f3f89.camel@intel.com>
	 <3123acc7-cc9d-4224-8fe4-7def3c02637b@intel.com>
In-Reply-To: <3123acc7-cc9d-4224-8fe4-7def3c02637b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MN2PR11MB4696:EE_
x-ms-office365-filtering-correlation-id: 647376b9-5749-4f4a-b8d9-08dd4c9bc3b7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?USsxYjRtRitFamxLa0V5Q0Z0OXM4enlnUGthK0tCUG0vMzNjVFJ6OEtWUGpo?=
 =?utf-8?B?WVpIQXpQM0VoRGJ3cEFNajFubkJMUGdqRDNIazVLbGF4VDF5R3V3QmFQZWhT?=
 =?utf-8?B?eWh6NTh2ekpsaEhNTG1RUDJHVjgyU3kyd29QblZIYnR5c3NIN3F1NVFNaTN4?=
 =?utf-8?B?SGdyVU51K0M0U1VlY2VNY29xRi9jY0JUb3hrSVZiVS9aeDI2U0ZQdTFDWHRR?=
 =?utf-8?B?WTNHWXF3RTZEdGhtQmRRT1RHbCt1SkhzUjlDUkNTanFGK2t5djlpbGVaQmsv?=
 =?utf-8?B?aWJwY0daM3VjVS9jOEZEYjdNWlN0VmdiK0cwYnVQcGp3VlpDeCt5TTFWY1BU?=
 =?utf-8?B?RytUVGVZOFR0c3I1THNKWlI4S0NhS1R2dU9TclN4aW9jV244U0JNVnM4UXlt?=
 =?utf-8?B?azZsWVh0VnVKaU9ueTJaMXBDcE9uVnphbjhsbWJINnkwZXZweVV1dng1emFi?=
 =?utf-8?B?bEdZaDVWc3pxZEYvdzhtUFVxSFM2RmxGdHBrWmd0MW5hK2VBeXp2czBITitY?=
 =?utf-8?B?NC80L3Y4cWR6SjAvS0Jxa1VPMnpxN0pEcnBKb3VXc0pzZVlGZmpkcTc0SVRP?=
 =?utf-8?B?Z2ZLSnFUMkRwTkNocllCNXJvSUdBS2RzakJWZnkyMUg5aHlaRnlMd0NLRTJp?=
 =?utf-8?B?NzJETkFGaUhqUHdQc1cwV1YvVW5zV01uc0JWMkVKTnBockliWHB3eXFCV1RW?=
 =?utf-8?B?Qnc4eno1OE9lTFVuNVFNNkFqN3FhZVhXMktwZmhRaFpBaFN0QncwZlRzb1lm?=
 =?utf-8?B?SXNWMnpiSEJKUnJVS2tsTnhJTmZWVTNPRlh0eXUxRVFXcTlvK2tpbWcvbEhL?=
 =?utf-8?B?dmtqSFdrR3p6cVBBWWwwbC8vc0c5UEJTQmxqcWV1d0NPeTBFU2d4enlFc2FD?=
 =?utf-8?B?WXlRYXQzZUlXNnBybk9GS2owbCszQ0Z0dTdGSE9JNXNjcHdIRzVaNTh2R2FH?=
 =?utf-8?B?Vm02cWp6Z09SWG1aTjhBdFJ0OTNSamtYRjdIcUwwVU1mVitRdGJoNWw5ZVhm?=
 =?utf-8?B?Rm1wQmhQMDB6VWZzUDR1RjY3SFBvZ09iNm9oVXJDK2IvOStzVXRiaWU1b0l2?=
 =?utf-8?B?bFJtYXh2TjIraGlnbzlMNTY2anA0MzdrdThxcEFsbTBDalhCaHlkZHNPZ1FZ?=
 =?utf-8?B?aVJiSENDbjhIdU0vaDR0SGc1MGJmYzROZDRTanVLYWxLNWlnc1hFODdrN3FG?=
 =?utf-8?B?ZTZkdmYycnk3bHkzZHFVME5KL3J1ZGcxWnd0N1FLTXVLM25VdWxkZzZmeEds?=
 =?utf-8?B?TWRIeWhjdnRCT01WdHN6YjNIQVVKQXlJMDJ3Q05BbkdCcENOWGZQLytsdVFH?=
 =?utf-8?B?REh6MkYvd3VpZkdmSEdudVpGZ1JneFlTc3hsWnNxMWdXdUN1ZjE4K0p6b05B?=
 =?utf-8?B?Uk1TKzZHd0JFOGljVWVQWmhVYlhwblluRElPYm9KQ3llVlRxVW96cDNvZzJp?=
 =?utf-8?B?SC9VUjIwRFk0WUVhVkdDcUlnUXJzZkRFaFBJNkdzOWIvS1A5ejUwK2JUUG1D?=
 =?utf-8?B?a25JcEt1ekl3RGVjSVdZT2lQeFJsYjEwUlJ0YUNjdXNRSWdRYjRvNWwrNnhV?=
 =?utf-8?B?QXFZQUdiRHl6K0FpbTMxVlBFR3pOOHVkekRvNDBsTkhBdmpYbGdUZDBHSmVB?=
 =?utf-8?B?S3Vwc0J2djdHN29iVXJHZkxxd1hseGpINW4xck9ySHd0cDF0ai8ybmF4eU5C?=
 =?utf-8?B?TmVSQlc0bGdSMS83NFRhOGpteWJwL1RHMml5ZU9PTWVESWIzREllY2VPb3dI?=
 =?utf-8?B?V05RYTBtOG9YVnZvYlVJWE9yNkJtZkw1RzlvRTNjSkg0Y0tMVFdNbXowaFlp?=
 =?utf-8?B?QjkvdVRxUEp5STg5YUUvckRyQytOc0FxeUs1Q1JXbnpjZC9YekRtbThGTlZi?=
 =?utf-8?B?aWVtZE93OE56Tlg4eGZiWGY0VlpyMHYzdnBTWWw4bi9LWExWWkpwYW9zbVYv?=
 =?utf-8?Q?hMvM0EfeSU13sroQSMSnlZdhRWw0V9+3?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW52akpzUndqbkZ3TzVXSmwyYjhhOGZQK0dibGdzK1FqUmtIN0ZvQzAzMHVX?=
 =?utf-8?B?MTQ2c2JCNENJVnYyUCtKNHZqbHF2VTNiRHJIMjZUYk1BSWxubUozRjdXV0NV?=
 =?utf-8?B?dlpJT0lXNXB3WnBoMURKSVo4SzdQM0JBT0J5Rm9VMWdwOE9iLzYrY1pVQkJt?=
 =?utf-8?B?V3hQM1g4R1lMazk5bm1HQzVFK0JaWFA4Qk1vb1c5Yk5PeVZxY0lsbEZwNG95?=
 =?utf-8?B?M1NpZEc4WjQ3c0o4a1drRlVSV1NnUXAvMHIvRFpURmtJbGtFd0pMZGk1U09E?=
 =?utf-8?B?WTE4dnNCRnpFQStxUDNVSW42OEQ0aU1aanlZcGx6bFc5ZDc1Qm5yNjNMZzc4?=
 =?utf-8?B?ckNKTTl0WCtQaTFwY2FBSk9EQ3B4R1pqVWhQK2xjUlM0UjNXTU43UDFiSXYw?=
 =?utf-8?B?YnpadE90NDlYQmRNcmtVZEhUUGFGcVdja1dTNkJuZUU2OFdzdVNBL1lpU2ZU?=
 =?utf-8?B?NHluWTVsM3JwRjVvd2hzZDBuMEpYR3hhZHQ4azEwSlI0RUwzb1NhREdYVENh?=
 =?utf-8?B?THl2d3dDbHprVkVLZit0N21BZTFYOXdKa2VHU0JxcW53RXppbWQ1czJscXhN?=
 =?utf-8?B?M1k2MUF5eGQ0bkVLcUVpZWlFVDR1bVNSYWw0WXlRenZXMEFIeG5Dajg1bGtI?=
 =?utf-8?B?bE8rNmg4dW9TV25IZEZSK0RxRnR4QTBlenlkQk5lZlIzNlRKdHJtWFhDcEh3?=
 =?utf-8?B?SHNrRGQrbmd5a3ZOb29Rem03U3FDVUwwUlpkNHN0dlJUeFBQZlB0VkJBT3Qx?=
 =?utf-8?B?bEh2QS94WndNTmo1UG5nbW1EbjFldnh5WC8vQ0FEcTVQQjlIdEt6Zmtoc1dq?=
 =?utf-8?B?MG4xSFV6b280SVJGQnZZK3V1U0ozMUtyNjJPWjdXZVRDaVQzNU51WFF5cU9P?=
 =?utf-8?B?REJnS2F6VFFGdGN3WXlBSW1HTkhSMjZnTk5GVHFia3JuYlNjaXZXcEpUNWx3?=
 =?utf-8?B?eFg1aDVRdnM3cDU1R01pMWkrNVY4S0MrQ2lINUVRaTFlay9GZGh3bEpCRTNy?=
 =?utf-8?B?Q1k1aUg2TnI0cmdQSVVOT29RRkRFcXVsZHI5Mk55a21iWlNabTlEcUdQZzhX?=
 =?utf-8?B?MVpzR0JVa29WUTMxNjFNbTZpc3VjemlVcWhYVE1GbFlEYUlNVzl0QmE4TWNJ?=
 =?utf-8?B?V0ZGSkpHMmRLd3ZnYzI0b2pNc3FnbkRBRXd1bldoME8vNEswRGdNR2tpbDYw?=
 =?utf-8?B?TGRLZWNmSHdyUk5OSDhlaHpuZkErZEh5Mkk4aEw2TjZ6MnRVTW4rMmwrbGVh?=
 =?utf-8?B?Ymp1NWZBbjVtVW5TS3pSUnFYazQzYUdYNDFjVXRxUkNTd3FhajQvZEpQem1I?=
 =?utf-8?B?bGlCaUlhRGxwcE1DOWZjRHJzNGUyNnhxT2tFQnI0R0VBOU1pRE5SNWRESVRJ?=
 =?utf-8?B?TkpUOWhKdjlZUmZWcTlLNk96TWZQRmFDbVh0cEtMUzlVNDE3aUFnQ3p4bUNY?=
 =?utf-8?B?L3pjWDdVSkc4WVY0UnRmVTRGZVJXYkxqbW01c24wcjhXTEFTOVFBL05CZEJI?=
 =?utf-8?B?Nk1nOXp2Z1VMWVl4RmpOZmI4LzYzOU5BcmJOYlpsZFFBMjNLeVk1OG9vMUFj?=
 =?utf-8?B?cWozakZjNlh5dGR2d2g1NVVLNlNaWnNxZHovcTRKSExRekNEWXo3bHozclQw?=
 =?utf-8?B?ZktaakhyckF1K0RIQ3FMRGxKam0xd3I1WVhhdGVGUDV0Ry9DSzRJUVFWZUQw?=
 =?utf-8?B?SzI5WitBYnVTTWRmU2RQODgrZ2xwQkNXYi9GekdQNUIxZy9uWTN2UnBjd2Q5?=
 =?utf-8?B?QmFKY2NJUkNlT015NURacnJHUUEyQzN5aTcyeDNQUTljRkUwWFR4QjdVaUti?=
 =?utf-8?B?VzBFM0kxQVBUVk1Nc0V5dXBmU1lYZW9INW1qak0vckprdmllUjJhcHQzdTN0?=
 =?utf-8?B?R0N4T0RDdU5GalUxTFU2U3h3Zm9IWlJoUmwxV3U5YnVTZlZGOHhkREFDT2du?=
 =?utf-8?B?YjVvY2VvRmZ3RHdLWjMvMkszRktRbXZFbExGZUlKYUZRcW5nZFdzb1VDZHdj?=
 =?utf-8?B?WVg5SVdXc01Gb2ZrbzVkNFlBakVpdmRmUWw1bTFJazdYTDNLTWJjN2YyMmQ1?=
 =?utf-8?B?MklVem1ZVDdxQTRUQy9YWHNBajI1blpoeEgzUC9uSElTNmN2RW90bUo5eDRT?=
 =?utf-8?Q?Ofu+ITZ0f0tsVpqgP4PRS0WCG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <337D53926DD35146A3481FEA6A45AB23@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647376b9-5749-4f4a-b8d9-08dd4c9bc3b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 02:03:24.3675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dl1DVOsMPm9znhKmu1vXu0/hvNR52nzzBd9bEdCFPBIlYkoyC9+0fQs8PXFjBA3fM4KS87NKgpAXHjm5CDTqjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4696
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAyLTEzIGF0IDEwOjQ5IC0wODAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
T24gMi8xMS8yMDI1IDk6MzUgUE0sIFpoYW5nLCBSdWkgd3JvdGU6DQo+ID4gPiDCoHN0YXRpYyBp
bnQgc2hvdWxkX2lvX2JlX2J1c3kodm9pZCkNCj4gPiA+IMKgew0KPiA+ID4gwqAjaWYgZGVmaW5l
ZChDT05GSUdfWDg2KQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoC8qDQo+ID4gPiAtwqDCoMKgwqDC
oMKgwqAgKiBGb3IgSW50ZWwsIENvcmUgMiAobW9kZWwgMTUpIGFuZCBsYXRlciBoYXZlIGFuDQo+
ID4gPiBlZmZpY2llbnQNCj4gPiA+IGlkbGUuDQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgKiBTdGFy
dGluZyB3aXRoIEZhbWlseSA2IGNvbnNpZGVyIGFsbCBJbnRlbCBDUFVzIHRvIGhhdmUNCj4gPiA+
IGFuDQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgKiBlZmZpY2llbnQgaWRsZS4NCj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqAgKi8NCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAoYm9vdF9jcHVfZGF0YS54
ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfSU5URUwgJiYNCj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm9vdF9jcHVfZGF0YS54ODYgPT0gNiAmJg0K
PiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBib290
X2NwdV9kYXRhLng4Nl9tb2RlbCA+PSAxNSkNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCBi
b290X2NwdV9kYXRhLng4Nl92Zm0gPj0gSU5URUxfUEVOVElVTV9QUk8pDQo+ID4gDQo+ID4gVGhp
cyBpcyAiU3RhcnRpbmcgZnJvbSBQNCIgcmF0aGVyIHRoYW4gIlN0YXJ0aW5nIGZyb20gRmFtaWx5
IDYiLA0KPiA+IHJpZ2h0Pw0KPiA+IA0KPiANCj4gQXMgZGVzY3JpYmVkIGluIHRoZSBjb21taXQg
bWVzc2FnZSwgd2UgYXJlIGV4dGVuZGluZyB0aGlzIHRvIGFsbA0KPiByZWxldmFudCBJbnRlbCBw
cm9jZXNzb3JzLiBUaGF0IHdvdWxkIGluY2x1ZGUgRmFtaWx5IDYsIEZhbWlseSAxNSBhbmQNCj4g
dGhlIHVwY29taW5nIEZhbWlseSA+IDE1IHByb2Nlc3NvcnMgYXMgd2VsbC4NCj4gDQo+IEEgVkZN
IGNoZWNrIHN0YXJ0aW5nIGF0IElOVEVMX1BFTlRJVU1fUFJPIChGYW1pbHkgNiwgTW9kZWwgMSkg
aXMganVzdA0KPiBhDQo+IHdheSB0byBzaW1wbGlmeSB0aGF0Lg0KPiANCllvdSdyZSByaWdodC4g
UHJldmlvdXNseSBJIHRob3VnaHQgdGhlIEZhbTE1IHByb2Nlc3NvcnMgYXJlIGJlZm9yZQ0KRmFt
Ni4NCg0KLXJ1aQ0K

