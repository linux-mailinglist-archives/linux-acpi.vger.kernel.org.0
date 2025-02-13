Return-Path: <linux-acpi+bounces-11156-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D9EA34E09
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 19:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AC7188F349
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 18:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C3245031;
	Thu, 13 Feb 2025 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbRSWBCR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D86E2222C4;
	Thu, 13 Feb 2025 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472632; cv=fail; b=kkGkzr9yemoWJ/ALclG5xtqoNG9lWrGecKyw9zT7pJjKnCtQYbU4gxMj4XCQw/jp7LugshABn77uY6Cr4Fw9n1bxrv5opDuYy/vK43VQsnBEDAGil0skJtvKLoW9nuBohAqfX0cTbV2ZOj8owTeD1fZlbmznyoQPgeX9vX6e2HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472632; c=relaxed/simple;
	bh=hKcs5GEtfqGWReP718J4Ttulh4BIexzRvR5lIhA/MhA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tU/D+UxqWv/pLBuzC2ZVkAYhQAJbICwbKGGkUG+GgL05JtzLgJ4tzazQRIfD0PCUEFaQ08EusO+t+M51cuYdjiIdTR2CC4u9YDxdLigndu0sunP+a9+JsFeqhw6ZcWMXfGCSHMh8YjucjphCYS9IQilzcUgSh+UqSwfp0T8JhKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbRSWBCR; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739472631; x=1771008631;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hKcs5GEtfqGWReP718J4Ttulh4BIexzRvR5lIhA/MhA=;
  b=hbRSWBCRCnc7vWfl06S+pkdx6EUKNFR+fmP5dDder1Nk0WPZ6Fqtcxzb
   VA0eo0SUuot6LpnsCVRC50KwBosA8uOibeG6T6h6yFmz20BEQMwGR8iR0
   zz2VjgaW7+1IBZhfRpFAtSg7XX/2TkYsdlfmj1kFv+nj+jwSWRWRh5H3M
   8AGNToS2KBp7itlgKwle7VcjGWKgTob3dh0Rb2INHw8kmUlP0kt1p0RRl
   d4Os0ZARYq6do6ZHbk4xbPfg3VJm95SEsQE8+hkekJGEaHc4i1YfTk/Nx
   1/tvqLndUBzmS64WrOz6msimmh1YPxpsjqB2fU26q218DSNXDnSlQpdC4
   A==;
X-CSE-ConnectionGUID: Ttfp0Ce8R0iBiKbjBuSTqw==
X-CSE-MsgGUID: SUze44oYTjO1/WeBUKExYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43965039"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43965039"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 10:50:30 -0800
X-CSE-ConnectionGUID: gZ3eVMtTTISQVoH5+o7WPA==
X-CSE-MsgGUID: PoDo8/caTPKMjAU6nOXH8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113731960"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 10:50:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 10:50:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 10:50:27 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 10:50:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ika6lSapgFw8GLLmbZo4VB2HUwseJSzhCANx38DhcUkLAqGv1atT69UP8e3sZG9kDtgUtPVMBAMjlTeEmHBulvJg5alIcHcpAv2tjHb7NwxjKWGK4X6rQXT182mWi1P4Zzp1oxweNjz4hERE60qVKTMTI9/dZ/15HiFuzmuBnKOLF5JQczOldW66l9SDhi3mTDsv5zT+5+AOrPpBPpYJs3CTlgLiFvPdQqgIJPQ+acI+uZonmqAW4Bgv4Up34iHpLp/qSyTN1mT73OXs7KoA1kz3lBO7X8IhdDTjbU/8Q80XX7O0nnXrP/a96malIwndaYkE2eI5+PU3Y0fdD4CRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3avRBD1OhYteha/CrcxZep/yXZHpIybS4tLDp3ZUDQ=;
 b=fldprHFrLnFrXxEyTH8F5IIKpGxpunfY3Dqlyoh7rfSAq+8+F/YnFku5rL0o9qkrMZlgk8q49GMuS8tBAwh3qRO4O+dGk5yVSIes01Xzlr/bLUt3VV02upnzG3+jh4Uezayu00CS6A5buQRIh5d03t4akeTGQSBuh3oE6xkWN5YFad+2fCC8x3MZ+cliWFE4G23prmI+cJjRna761uJOJ52kCr1LyGNaaGGJYyM48vtZrtu8/dsm+xnLAysSPH7S3bALfYZzn2Z2bt/Mgn92bA55LEoRm/tW87VDQiCcOPhbO8axEg91y8lqECOF/GY6/ZGXS1q+gkVTicinnD1xFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB4880.namprd11.prod.outlook.com (2603:10b6:a03:2af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 18:49:41 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%6]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 18:49:41 +0000
Message-ID: <3123acc7-cc9d-4224-8fe4-7def3c02637b@intel.com>
Date: Thu, 13 Feb 2025 10:49:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] cpufreq: Fix the efficient idle check for Intel
 extended Families
To: "Zhang, Rui" <rui.zhang@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
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
	"fenghua.yu@intel.com" <fenghua.yu@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "bp@alien8.de" <bp@alien8.de>, "acme@kernel.org"
	<acme@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
 <20250211194407.2577252-7-sohil.mehta@intel.com>
 <56eb1f8bda3932632cc0b17dde053f77fe7f3f89.camel@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <56eb1f8bda3932632cc0b17dde053f77fe7f3f89.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a03:505::6) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ0PR11MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af8f63c-bcc4-409e-1918-08dd4c5f2c93
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGRtYzZvM1VYekFWMzlocEU2TDduazUvQlVJZC8zek9GdVVRWUhHRTUwZ1px?=
 =?utf-8?B?cFJPT3ZCbEhVY3VWeXhwQ1dFVnNQTkN5Y0h0RUdRTHJ1cEdYRWFZNTdkb1k2?=
 =?utf-8?B?aTBVd291c0pNQ0haMXQxenRMY2tqNHY1RU1UWW5DY2s1N0pJT0NHcDZhV3Rk?=
 =?utf-8?B?SmRFdlRzbVJ2R2tGYlJ2MXFVRm12SnFpc0pqS01lZ2FHNVFUSmF3RGVIT3RL?=
 =?utf-8?B?WVJaOGk2K01lZk9xSytDZzJOZW1NdktqQi82cXdkT2cyYVdGR1pRYU0waHRx?=
 =?utf-8?B?czA1WlQwSXNtWUViQVRtc2ozOVhha0dCeXVsSTlrRnE4S2pOc0hkNkFaeVN3?=
 =?utf-8?B?VzZUQ0dYd0pZT3NRMFlTMmJWajRnTDl0SFMrdzRWYjA5SXBQZkpWaEU5Ujdw?=
 =?utf-8?B?YmNMS2V1VFBONWwvMSsxMnRWRThZQ3JiYW0zZGE1clpBd0t4RE82UHU1Nmkx?=
 =?utf-8?B?S2tDVktTWktMTEk5L2MrVEFVUXc1eG1OWFJSRzJaUmJtKzQrMmMxNFEvOWtB?=
 =?utf-8?B?TXh2UE1UQ2NacWpGcVFYeDN0ajhUS0d2aTQwQ2ExclB2K0FQdnhaWUVrZXpi?=
 =?utf-8?B?eDNiYUJkdUpQbTJyMjFHckR5akVTVzN2UjJkQys3MVd4WHp3YXQydTRad2I0?=
 =?utf-8?B?QktQcnpvQmxva1Y2d0VndDFoWnpwb1VwNGFROHUyQlFXTituNUliZUZub0hB?=
 =?utf-8?B?bnBSV09TZjNnSC9Za0wyZ2laSnZrWHlLZzVkT0VNdmxTMlNTVUxuU2ZhenQw?=
 =?utf-8?B?eEVFaXdUYTMwV0IvRFd5YWdtdE9abkRoalJuR0pyVjRZT0k2M1ZkOTIzTVlY?=
 =?utf-8?B?TlQ3QUJERFNZWkk5UXRKU2VWTUVyMG9NZ0FTMHdra2d6eW1TbnFuUmZUNzN6?=
 =?utf-8?B?TUI3YXoybzhid0pBZC9IUUlzMEJLWTdxRmsvZ04rYTc1VC92eGhyakVPVWVG?=
 =?utf-8?B?dWx0R0VpYW11aXJId3FDQ0Qwa3h5QVo0RzVWQnp4aU5vVkEwejVHSnJ2TFFs?=
 =?utf-8?B?eFAyNi9pcnI3VS9TMFJSS250dkJnV3Y4S3h5dzlSWUsyQTBJeXArZDdxeEJP?=
 =?utf-8?B?STZ2dHJhMTFnRUV1L2sxbjNIOEhvdXJXRTkwNGFRNGFoZ2V4SXFSd3JUNlQ3?=
 =?utf-8?B?YkdCcVJnN2NDdU9IdWxsU1ZOTG9zTDJRYUo3Sm9EazFNSlJNcy80bnZWTlBx?=
 =?utf-8?B?dlVVWVpqVmZqcWdvZEYvWW82QW1sY1pZa3hIRkV4RjQ1RzladmNmaXNzRXJF?=
 =?utf-8?B?U01BM1M3eHZ5bU85SmdSLzlMQk9MYXBzZ2NiL2ZPWVBmRndHamJKUi9Sb2Er?=
 =?utf-8?B?Tk5oZTN4ZmYrTkdGM0pQM3JjVEdjVTIwMHlUQlorbTNCajJsU0laV1dkWW9G?=
 =?utf-8?B?cmgvL2RwUmxpNTdCWm9EY2RRZ3V6ZXF6WUEyZTJjbW0rWExqMXY3Nzl1ZkR6?=
 =?utf-8?B?SmJHbXJPT3Z1TEVLQ3BkeTRFU2tHUTlKOTJpdHpER1F4UkdkdjVmQ2VqQS9T?=
 =?utf-8?B?WS95QW9xaHZueWExMUFDUHlhTjVaelMyY0p3bGRBQ0FOeU5LODNncUZZckJJ?=
 =?utf-8?B?Q2lrd2NuWlN0eitUY2RaNHBEbGtrcE5ORnBnQUs2emFCMGhJc0M0Mk9ia0s1?=
 =?utf-8?B?M0V4VDV0WU95dlhVK2JxdVpidUtzUlJhS29raHVCc1lvZ1poRjlDZFduN0E2?=
 =?utf-8?B?alFDY01HZ1ViMTRmMUVRRkU3aXh2KzR1NGlWWWJGY0RrdnVZY3psNUJKYWY5?=
 =?utf-8?B?cDlSZ3ZTSmJrMU9QL0FEdTJnckkva09MZzF0ZkE5UW44Uk10VG1oNTlpcTFB?=
 =?utf-8?B?Wm1rOGhOSWdpOHV4aWJ4SFAzc3Jrd1kyK2xIRnhhU1M3R1RTRUJBU0VSbDRv?=
 =?utf-8?Q?GDJ4r8B1tvIrC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEdaTlpaNVFLODUyb2VTYmhJSnpYZVBYd05maGVuWXpIR3hlNG5xU0dmZkJo?=
 =?utf-8?B?V0M1eFBUS1ZtbUdzODBPMWJ3RGVSZjQrbjdmS2RFYVVKLzhBMlpzNVlCYVBO?=
 =?utf-8?B?U05MbEpSTlBDcnVmQWF6ekgrbTJ3M1pMc3ZOb3JqRFEyREY4Z1h5cWc3c240?=
 =?utf-8?B?WEFtbGJ1SlVocGFiQVNuN0tMdVlxVGIrREhicG1ud1NlT2xyQzVSbFhqRWhK?=
 =?utf-8?B?WW9IUUVpUFYxTjVpQTEvZm5TaWd5eXlHNktEZXlUVncyanZqRmROL0ptZGY2?=
 =?utf-8?B?NDYzZVl3MTBTMW0zbXNtdkNsV09hTlZ6bUVUTTBvVVBOOFMrNkx1QkEyRXQv?=
 =?utf-8?B?NElsV0RmaTVCVzBjYmxZdXpySUVFMm5Xc09paVQ0S0hyUFMvQlFrTWtCdy9Y?=
 =?utf-8?B?Wk1SMnhIb2ZicDRTd3M5dEt1cmZBVWRyaVpoMUZRZFBwUHlNVFByZmNIKzRt?=
 =?utf-8?B?VmJxRGxTTUI1UkMxSTB1RTV3MlMyRy80TmVhemI2ZHppTkpOZCtDU1dhK1pW?=
 =?utf-8?B?KzJHOXVMeWg3YjFqcEwrenFVYWJYRkRXeWl4R042V3VMcUxyMThBTGdyaGpx?=
 =?utf-8?B?RW5OYUQzdG9lK3VJbVZsWXBHUjZOUkVhRW1na1hCQXhwWHMxL3FzTFR4b1BE?=
 =?utf-8?B?TEpxMzlDZG4zVWt3RkZ6K2lhYXUvcUp2V3lydjNYSXRwQ1dtYTNsYTlqRWk3?=
 =?utf-8?B?aUM0Rk9yVjhMbU1YOUpJSmNZeURnRWxtL1V0K1pNeHZTRUlMdXlUTXRnOGl5?=
 =?utf-8?B?d1RBMUg5M2pFdXloZjBZdjY4TG9uYkhyU211U0RxRUZUS3BURHpRR1ZDMi9H?=
 =?utf-8?B?eTExdFFtRGxVTWtUVUhDNU5EMFRJRW5MOEsxZnRzREZQdTNBOVJYdVpMVTdz?=
 =?utf-8?B?eDR5RmJTamxWNCtObzNKZlkrMVNoMlpjUThIaTVXK2s1cUw4a3hYK3k1U3gw?=
 =?utf-8?B?K0hldHU4TU90ZkZUR3AwczB4ejdxN1d6UlROT2Y2M0NERmRCTUN5RkowdWNo?=
 =?utf-8?B?TzVSaktJMEgza3R2aFlXMUtJdmNBZXBzb3JVdkF4c1R4K0F4Z0pOeEFpMitZ?=
 =?utf-8?B?SUhVS1VQcTdZMjc0elZvdmtyTi9IeXRrOFJndHIxS3ZSaVJyNDh3YnJITTV6?=
 =?utf-8?B?bU5aRDYxN3grbGt3YW4yUWR3SmNpYWQ0RC9vbXIrdmZSSXM1WE9WeGZINE1n?=
 =?utf-8?B?c1pReE9aMWJrUUhLWTEwL0Q1WVZUM3prU2VqNVBqWThJYzExZjhIS1FEdHIv?=
 =?utf-8?B?TjNDQlFFcjRnVGZySDdFVlFTOWlFNnUzRENpa1lXZTFRU1ZZVHFjVy9KZWEv?=
 =?utf-8?B?VW1PMWlCRm5pZTBNMlhzY3FlMzlTRlVnbEsrby9PRnEvV0FZNEhTTGxmbklO?=
 =?utf-8?B?Tzd0K2gxeVA3ZWl1RlhTTS9PY1hoTGJDeUpWdlBhdkVrYmFKNndlTVVuYkww?=
 =?utf-8?B?cnpLVTVqMjVOdzJSOGRCdFIxTDRQdk14d2I2cE9xd3BjMGlVQjB3NUpoMmdJ?=
 =?utf-8?B?V2swWjJqNloxeGFiM2lRajRUU1pzMS9tNllmU2RoN2Y3OEtlWlRrWWFHd0pS?=
 =?utf-8?B?Ry8xU0wxRjVJamNnTzI1MjZpQm1nUEx3ZTdiSEdhcjVDdWtQOG5JenBSTnI3?=
 =?utf-8?B?cml2VVJ5YWNBaGFrOTY3Nld0cCt2OE9YNmlMNHdieW1JVUVuZmhJTHhvQW9o?=
 =?utf-8?B?SzRRZzZjelIrbUNsYTUzcFRoRXZIeEp2VlR5Nm04V1JTRFk0YTFuT2JlSisy?=
 =?utf-8?B?Y2JQT0RPVHBFRUVIWTlxRS9mMng1SFZnM0ZzZ21MZjhiRzZ2K0orV0hqeEdM?=
 =?utf-8?B?b3hwb01uNjRNeGFYZmx2S2gzclZsUFo1VnJyTXRoUHhBdkRjN0pXcVNndE4y?=
 =?utf-8?B?djhOeGJwNzdYSGZsbkpmbUpOVVZEMzBVRUh2ZzZ6d090ZlA2akZUMmc2bTlj?=
 =?utf-8?B?LzZWQ3Y3R0RJYklFUFBiNEVnelJlTlZubFFhNUhOOGlZVHcrL1R3SjNQWmJL?=
 =?utf-8?B?WFBTTG9GVm1WZXo3a29nVlpSTG5sWlV4YTN3aTdHUGttb09GNE9SYnhpemxt?=
 =?utf-8?B?K3NYZElLTVdNbTdWcmgwczJTWXVrVG5EUC9XcGt5a3IzclQ3NFZiWkYrYjhn?=
 =?utf-8?Q?rGXHPDF7W+3tddkTzDQXs/1SY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af8f63c-bcc4-409e-1918-08dd4c5f2c93
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:49:41.1824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5MEoN68nETrw1tWMkqVwzBATb8FdrB4CYDVNo9BBeIln6XNHA81+ahGi62g69De3WV7NiHi7iy19UM4udJb0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4880
X-OriginatorOrg: intel.com

On 2/11/2025 9:35 PM, Zhang, Rui wrote:
>>  static int should_io_be_busy(void)
>>  {
>>  #if defined(CONFIG_X86)
>>  	/*
>> -	 * For Intel, Core 2 (model 15) and later have an efficient
>> idle.
>> +	 * Starting with Family 6 consider all Intel CPUs to have an
>> +	 * efficient idle.
>>  	 */
>>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
>> -			boot_cpu_data.x86 == 6 &&
>> -			boot_cpu_data.x86_model >= 15)
>> +	    boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO)
> 
> This is "Starting from P4" rather than "Starting from Family 6", right?
> 

As described in the commit message, we are extending this to all
relevant Intel processors. That would include Family 6, Family 15 and
the upcoming Family > 15 processors as well.

A VFM check starting at INTEL_PENTIUM_PRO (Family 6, Model 1) is just a
way to simplify that.



