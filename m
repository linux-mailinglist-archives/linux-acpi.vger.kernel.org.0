Return-Path: <linux-acpi+bounces-12934-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20118A83BED
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 10:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457733A21C6
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 07:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C8B1E32C3;
	Thu, 10 Apr 2025 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJ/uQ2i7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089B1552FA;
	Thu, 10 Apr 2025 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271804; cv=fail; b=CgJ57KaDY7xJ9MSMDkGD/YxRxMOa0iWMhnoVnIdxKCF+ZZjpUoOhwA680PG4o0t4Z94Y9xJQQuZrBLCBVJlXX6b+q6bKz8FKaQ2pkMUzUhUPPvG5eshUZTeLT67w0WBmOpT4esVFcggxEp3U5u6yoGGBSnSfiAVozRsNwmvSwdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271804; c=relaxed/simple;
	bh=HtOXFYzPeOAEhv257ITfI4MTTU38elcGWw4U/TtQ7YU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fmRPyUEcl2EeAayM7gYvReQfoYlfqpbnNGk/E+U6ORpus0pFlRwd6lWBJVb7YYyc4m3AW3ffflDD6XhfHVf4ArSPkAUR80e6i3JY4S4XNk99eW3WP3qlXWnOFwfPfSFrlnTZSaZUbZ54szKH7mSWpFJPud3kTqvTWQvcMDlGdXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJ/uQ2i7; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744271803; x=1775807803;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HtOXFYzPeOAEhv257ITfI4MTTU38elcGWw4U/TtQ7YU=;
  b=QJ/uQ2i750SZNMEte3vFV5eU1T7t1FtuRBWqDopYPDqW/V04YsM4R2CT
   pqB54WibOgciyL86gSJSuSSX7Cg/ABap0+cAZU4v4MHFarWo4m0gz95AJ
   U4Eq0kkDtvLvBZSKjlZxUm+jZhLi8RsWRZwan6/qewj2gSajNijEAkYpK
   s7cFL1YDUJNftt7tecYsR2LjVUf27UqTraJ0Oz3W0lV+UxmcDZe31hDeG
   PxzKMY1iiFFVkN8yW+EoBpNhGaRkGLeAm1OMehKV4jldg5s9l7Ivw1p1i
   xXzSybkKb+m8esJVHj1YrN+FW56lrnRV1aY0VUeIi97PAW7yy8IwoMOC4
   g==;
X-CSE-ConnectionGUID: fFvuWsDLSdCDRBedFith5g==
X-CSE-MsgGUID: WBP0xLggTFqZzBmcuavYkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56756183"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56756183"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 00:56:35 -0700
X-CSE-ConnectionGUID: CrHwnz9PTK215Zwmt5w8Bw==
X-CSE-MsgGUID: 6h2zGzwnTf6p7EckJ8zvfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="133944898"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 00:56:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 00:56:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 00:56:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 00:56:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSQyr5ziZSnpA2gkQnnapFhoF13MQf9zqQrGGP6NlWPSzmwWGPK/OgA70dJ9eXtvwMLRgbyWB+xRmSk7YPrXtTskDGRKwtHkkv8ZoqHK7fiGrR7FzK0bN0DXRoaZd22pfrRwU2t0lfBnI07kn9veXEk1DIe/jygRLe4vYzQzzohPJcIan9BltOmi6LNkUoADgLKdAxBL6HCC9xtpxJHG4kmfLsd67aAftrA1FJh/aa4kPSdQYuLCYlBTRIWuPFWuYwra1DVKD6A9iq46j0e6/qa03dY1NvuxXRHvCeNQCHmNWF3SBgMsHFH4Jxv6Bk8DYblGfrBXiFL2+6l6lL8Z4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtOXFYzPeOAEhv257ITfI4MTTU38elcGWw4U/TtQ7YU=;
 b=qpHVCqlSGm6kQ0IxxGRCHfoLg8qZBe7hhDAlpoTPWN3rJNLZrwbXbBscQJLEfqDYHABdZ0jJxvK44ed+FAcODJM9WpY2DKIhazOCGx+cmMKLyh4DhHsgFqM88PWGnKdFR7uGNu91htJPL2dhrWI17iuEzO7AeXhp24c3eVoJWxPUjvZoiNCxaqe86BmOsH5FmKb2TJUwbtZnscP/m4rqSZ8aEnN+4iwBQLpU+5Iu7SnFgy/YW+g1iDi0q/JZpzk/QJXzCCAvf+CTh2V58yHLsG+BCJUFYAgmtWyEqBOi3gmD38sItNnvpK9sTuNJUM0ZZIysG8kRxDGf7rk4nigP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB7367.namprd11.prod.outlook.com (2603:10b6:208:421::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 07:56:12 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%3]) with mapi id 15.20.8606.028; Thu, 10 Apr 2025
 07:56:12 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: lkp <lkp@intel.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devel@acpica.org"
	<devel@acpica.org>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [rafael-pm:bleeding-edge 44/56]
 drivers/acpi/processor_idle.c:464:22: warning: unused variable 'i'
Thread-Topic: [rafael-pm:bleeding-edge 44/56]
 drivers/acpi/processor_idle.c:464:22: warning: unused variable 'i'
Thread-Index: AQHbqcwIZ92yDQ/ZQ0awLXOWrBr0p7OciHMA
Date: Thu, 10 Apr 2025 07:56:11 +0000
Message-ID: <d7d99d34ea030d96256531cf09d21d5c6ec16433.camel@intel.com>
References: <202504101132.pgiDBR2Q-lkp@intel.com>
In-Reply-To: <202504101132.pgiDBR2Q-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB7367:EE_
x-ms-office365-filtering-correlation-id: 263260b5-07a3-4e18-ba14-08dd78052970
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|13003099007;
x-microsoft-antispam-message-info: =?utf-8?B?ZGR4NFdFMURaVnRkMnVqVzhWd0s1a3FDaDBmeWF5V252QlM4Vnd5dDNyZHVU?=
 =?utf-8?B?ZEdyQkxxUldVZzJKbTdYOHdyUmU3Wjh3K01WVSt2UXdiWnJsTk16dVRsb3JR?=
 =?utf-8?B?RHlTODN1TTBYZVFXYnJtYUVHNlo3T2dGSGxYTUkya0UrYVErb0pSTjMzd2lC?=
 =?utf-8?B?YjIvaEZJT1Y4U0RGOEJPSHFFNEgvUVp0N0VKWDYybm1NcTk2bzRaa2EyaVBh?=
 =?utf-8?B?V0Q0YklqQUFCT1BnZ2hza3NFbDF0MkZoMmw3QUp2RjBrdm1wMVpNbUlTWU5B?=
 =?utf-8?B?YVpBU1M1c0hzNFRMeEx3WUErTDR6dTRJcWZNSmVEWlhFSHhWblRjWWhROExq?=
 =?utf-8?B?bmdrVHlucis5UnBoSjdYWVc3bEJDL0RnY1BmVVVpWXYzMDVGMWJMSTk4M1pi?=
 =?utf-8?B?bnh1SkRIZE1WM2tEUDVqcFhsc0VwOU9zS3I4WllnenVVZlJsa29jTTNWajJF?=
 =?utf-8?B?MU5jUjlSQUxxMEh1cmhUYXpvL0RNSnFhVk8wMXdtKytZMDltY2NLT3lpSk1y?=
 =?utf-8?B?enBoR0tDUzhYVDZPSEdJVmJhQWpYNDhsRllPVVRCaFo1aWNQUk9PVlZGeG1U?=
 =?utf-8?B?NzBVa3hVM2xzYW81QzFEcjc1ZjhEdHVmY2RDTW8zTCtrSDlDRDJ1VXpGcXRP?=
 =?utf-8?B?d1YreUFVV2tHeTRCeWxmYnI5QmJwaSs3alp5NUNjQXFQM2cxQVMwS2EwdW4w?=
 =?utf-8?B?V0tacXFxekVJa00rTzlXbzU3cDVKT0dBT3c1K2J2My85TVN2czNCa28xMzVm?=
 =?utf-8?B?NW4yd1B0YVJjQ1RyeFVuV1JZZ0lEWlphY09GSWhEdlhmWFp6Vmg1V0JhaC9Z?=
 =?utf-8?B?dXlkM0F6akZpQmtpYjZQR1kvNjJNQitDcUNrMDNKcldGVmRvY09OYkdER3Q2?=
 =?utf-8?B?aHR4NXJVUGg3TElvb0NEdzhUMWVtbkJkenhPNFNweUJ4K2dVZzF3MTUyYXZU?=
 =?utf-8?B?c3RVQzZNRnVBaWZjL1NLUzZ4K05scFJTTlRUREk4cTM5aW8rNTA5OEY2SHJ0?=
 =?utf-8?B?WGNXUFJaS3diUm5qeSszWDhiRlhrUDlYSmNKblNCcklFNTNINzNvellqNDg4?=
 =?utf-8?B?SWlZS0JOZVgyZWQrNXpUd1FBZ1dYTXYwSzdvc0FwU1UxWmc4SGRldjFUb1M5?=
 =?utf-8?B?dUsvbXM1YVJtY0loOGszeVh4WnE1WWp6cHBINWI0ekJtMnNNNzViOWNjQzNw?=
 =?utf-8?B?blZudFlKek9OY2tmSW12Qno5SlBkdmpWWTc5TGhpcUR6WmZTdzVDWFk1OXBT?=
 =?utf-8?B?ZDhRdk1GcExoR0JwVGt0QjNOL0dmcVJYSERjNVdyVWxOT1UxYlRWVU1qOFhE?=
 =?utf-8?B?MTV3Qks4cHRqN0tOSmtkSytodW5FT2E2b3JtcGZiai8rS1VRTGdTVVZxU3ZG?=
 =?utf-8?B?TndCa09JRHAxQklNMm1rY25UZnZMY3RGMFJXb0ZPTnhtc241QU5qTG9lQW52?=
 =?utf-8?B?bzVKWHBadVJZbUNhdUlmYndkUk5oSmw0TjFjcjVLZDBvOXhId0x3OXBFa043?=
 =?utf-8?B?c2VpaDZpZVhsVU80L0orVlpJbnNvTzIwcCs3RXVVeks1RXRXUUZvRGFCaVlB?=
 =?utf-8?B?UmZJempSbktaRUwyTzFTRzRkVGsraTRON0x5cW9CeWprV05Uc1U5M0ZqU0JZ?=
 =?utf-8?B?Ukc4K0t1M0xxbWxmMGlWNCs3R0I5NTRndW9QUVc0dFVBMnN1Q0dIV251QmtD?=
 =?utf-8?B?UERpNGtzd3JJdWdxMXJISFM5UkExYTR3WXdoRVJTS1daNm5heEZXeTFPYmJB?=
 =?utf-8?B?ZzNxRXVFa0NjWnQ3TDRSZVVCSktLZ285bnVOZ2dmbFppSEt3Vi8zenNyYmRq?=
 =?utf-8?B?YmJsMEcwU1BPTTFlaTBObUY4eVBsdkQrcEw5TmUzSWNyNEE0U29RUERwMjAw?=
 =?utf-8?B?VWU3cGg5czNWNDRRakFySDgwd0RSSlY1bWxoUmE4RmwzM2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzMwSzZ2UnlLTDlKRFJiZUloenFYakV5YUZ6SVZTYTBrc3doTklSVVZzbjk4?=
 =?utf-8?B?bFVvVUxDY0k5NlJjVjlhS0FhR09sQW1ITWpkS09XRWk1eFVLTThQRFFWZnh1?=
 =?utf-8?B?bnBwY1Z4dXZ3ZHhZcHdyQkFpTXJCTG5uNmVXNDZFRk1VOWhhMFRDbG5MUVl5?=
 =?utf-8?B?ZGdOUWNaQzBuUWtIQTFSejllQWJzQzBBdDh3QkdFaHVoSmc0aHhjTEVYR2Jn?=
 =?utf-8?B?KzkvL3A1SVFWcFFoUDRna0ZGSlN6dEF4Zkp4QVRRSytDYnEzQTgxdzY1aWVR?=
 =?utf-8?B?c2RJb2wwbEpuQ2dPcXVsUnFKMEtLRVN1ckhER3FmbDg3QWVwaHdSSUIxZWQ4?=
 =?utf-8?B?REFsNFUrVGRUVmRYRllYMEE0V2RJM3pBVnd1aHJuY2Z0N3JrOWlFdkc3VlIr?=
 =?utf-8?B?eU9iSGQ1dTNDZ0xBVTkzb2VsbllTOGdqWDR0RjlaMmg5RjhkTHhSMm52bGs0?=
 =?utf-8?B?aXQvcVBaQ2U2VGV2bFFZMlF0eGlkODNUSjcxM04rcDlJdE5iNUM4c1ZlL2Jo?=
 =?utf-8?B?enA3aU4waEpORlMxNjZUWGVSSHlxMEN0V2h6ckVyRWZNdndRY1JVNWowRURk?=
 =?utf-8?B?RkFZVE9MWDdoMUp5WmtDdVpXdDZZY1FwYTVLQllVbnM1RktybEV2KzVZU0hF?=
 =?utf-8?B?Q21leUNHMDdISUdjNjJoU1E4dHNMM0J0TmJmQzlQWEVqQVRrMWFZUVg0Q2xv?=
 =?utf-8?B?ZTFSeWw4dDA4L3ZKajFsdHM2NENwanRtV0JkQ25IWTBpVW9EVExIQllRQmtw?=
 =?utf-8?B?RkVMOHdrRDJISDZrclpLSlZ1Q0Rqc2VmWGJXTFN4blZDL0YyQStqTC9jNzVE?=
 =?utf-8?B?ZlR1SWZXbGtyZUlEcWcvcUR4MktxejBnRTFNM3lTdzdKUjhJK09yaGM3UVlK?=
 =?utf-8?B?MDY4ZHBkOVd0SXZqZ1ppdTBHTE1naXRuRXR6WGZEcE9DMDNsdDlMMDBrSzRz?=
 =?utf-8?B?ZjlqOVZMMVJYOFp2bE9wcGxuTmhQM0JJVk12LzI4cmgzM3FHbE1rY1ovSEd6?=
 =?utf-8?B?QUtMNGxJdUw3SmhMZm1iL2NhakVjT3dIek13U05CbUFsMnNmNSs0aVJ3bW5W?=
 =?utf-8?B?NkRlalZudjBpNWg3amRhRUREZWNlWWNNRllpeUlFNHNkQm9QV3pnUXpNRFlm?=
 =?utf-8?B?YnVsVjYwejJiSC82QXJ6T3dBNnBWZThuelp1NVBySmxvcUgyM2dBNCs3b3Fh?=
 =?utf-8?B?dHdtVFNRSkltaytzQzcyclB4NEVoVzU3QStOazlZU2U4YitnQ1ZOdFlYakpV?=
 =?utf-8?B?YzRVVlRRd3p2MlNGNDZYOWgyaWdFSWRyOGtpVmJENEczNklJeEp1M2Ntd1Yr?=
 =?utf-8?B?SU5icUp3V25qTElpZ1JXZk1ueVdpMzc3dlN4WVltb2loZjRaYTREYTh5NTNx?=
 =?utf-8?B?dE44ZXBaTlBPaVFUTU0yTHlyTkpwUkR3bFJUbXpnY2t1TVY2SWx5Uis1SGZs?=
 =?utf-8?B?MysrbVlzb0U0RVRkTkZEUzAwUjhReXlkZ0VlcGsrSUpwWWRqbEhLZGM2SFZz?=
 =?utf-8?B?RCtFeXB6WlNERThrSkpHWGI4MVg5eVVWSHdGS0FOVCs4MDJUZHZJZkhJUW9R?=
 =?utf-8?B?TGVNd3NkVzlQSitSMG1PcjcybnVtM01FZ01nMDR1TWtleEZDdGNvVEJEWFV4?=
 =?utf-8?B?ZVVBUEpXL2hWOWNidnZVTUtBM01USkc0bHcrZ3MxYnFPUCtrOURtaURDTG9z?=
 =?utf-8?B?TVlLZE9oWURpVVYwS1lrRVp4YVN4UHlsbDg0R3kxSzFDaXZSWG5aQTdkRGpX?=
 =?utf-8?B?NGFUQmZKN2lydlptWnM1YmZaTkQrNjhpTmp5VjVpdHJUMTNML0QyRENPaHY0?=
 =?utf-8?B?c1RRVHE2bVF3Z3B6M1dndHdrZjViM29sQzRqT1dHaEFlQU9WTU5FZEwxZm1J?=
 =?utf-8?B?d0RjbFE1cWxaY1AwWEx6azBmSjlZajcxdnlwUm9JYVZLcjBSeUw1MGhtMGY5?=
 =?utf-8?B?ZHBLLy83WjJCT0M3Y2l2YnBFSnRySysxME1zdWl5cndXclNIRi9uYkZZVWRH?=
 =?utf-8?B?bU5oTW5JanM2clBjeEhVY2dYOThBYnlCQkdWZnEwbjE3SlV2WXJreWd2UTFp?=
 =?utf-8?B?dkdNalBzWGdqWHdlL2s1ODh3TGRzK3BmRDJMd1RGV0F2TEQ4QWI1VjZvTERQ?=
 =?utf-8?B?MVVCYVU4Q3NDVU5zUzc5bUpXYVg0S3hpdFhUdkk0UGRtTnVWYU1kamtHbWl1?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D6AFD042CB78D49AA497ED37E58615E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263260b5-07a3-4e18-ba14-08dd78052970
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 07:56:12.1627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6/ZwqSAjVph1LobwathJI8ZCeIoVQrkvDhf9Qe6oKYEluIb0kRvPdrKvMBcMUYYCgUAFoTZpJXUOIbx6uF1zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7367
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTA0LTEwIGF0IDExOjUxICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4gSGkgWmhhbmcsDQo+IA0KPiBGWUksIHRoZSBlcnJvci93YXJuaW5nIHdhcyBiaXNlY3Rl
ZCB0byB0aGlzIGNvbW1pdCwgcGxlYXNlIGlnbm9yZSBpdCBpZg0KPiBpdCdzIGlycmVsZXZhbnQu
DQoNCnllcywgdGhpcyBpcyBhIHZhbGlkIHJlcG9ydC4NCg0KUmFmYWVsLA0KRG8gSSBuZWVkIHRv
IHNlbmQgYW4gdXBkYXRlZCBwYXRjaCBvciB5b3Ugd2lsbCBoYW5kbGUgdGhpcyBkaXJlY3RseT8N
Cg0KdGhhbmtzLA0KcnVpDQo+IA0KPiB0cmVlOsKgwqANCj4gaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcmFmYWVsL2xpbnV4LXBtLmdpdMKgYmxlDQo+IGVk
aW5nLWVkZ2UNCj4gaGVhZDrCoMKgIDY1NWQzM2YxNGQ2Y2ViY2Y0NmU0MjJiY2I5ZDIyNWQ3OTFi
YmE0MmYNCj4gY29tbWl0OiA4ZWE5ZDExOWU3YzY2NmI2ZDg3Njk3YWYxYjY5MTkzMzU0Yzg2NWQx
IFs0NC81Nl0gQUNQSToNCj4gcHJvY2Vzc29yOiBpZGxlOiBSZW1vdmUgcmVkdW5kYW50IHByLT5w
b3dlci5jb3VudCBhc3NpZ25tZW50DQo+IGNvbmZpZzogaTM4Ni1idWlsZG9ubHktcmFuZGNvbmZp
Zy0wMDMtMjAyNTA0MDkNCj4gKGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2
ZS8yMDI1MDQxMC8yMDI1MDQxMDExMzIucGdpREJSMlENCj4gLWxrcEBpbnRlbC5jb20vY29uZmln
KQ0KPiBjb21waWxlcjogZ2NjLTExIChEZWJpYW4gMTEuMy4wLTEyKSAxMS4zLjANCj4gcmVwcm9k
dWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKToNCj4gKGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBk
YXktY2kvYXJjaGl2ZS8yMDI1MDQxMC8yMDI1MDQxMDExMzIucGdpREJSMlENCj4gLWxrcEBpbnRl
bC5jb20vcmVwcm9kdWNlKQ0KPiANCj4gSWYgeW91IGZpeCB0aGUgaXNzdWUgaW4gYSBzZXBhcmF0
ZSBwYXRjaC9jb21taXQgKGkuZS4gbm90IGp1c3QgYSBuZXcNCj4gdmVyc2lvbiBvZg0KPiB0aGUg
c2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWdzDQo+ID4gUmVwb3J0
ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiA+IENsb3NlczoNCj4g
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIwMjUwNDEwMTEzMi5wZ2lE
QlIyUS1sa3BAaW50ZWwuY29tLw0KPiANCj4gQWxsIHdhcm5pbmdzIChuZXcgb25lcyBwcmVmaXhl
ZCBieSA+Pik6DQo+IA0KPiDCoMKgIGRyaXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jOiBJbiBm
dW5jdGlvbg0KPiAnYWNwaV9wcm9jZXNzb3JfZ2V0X2NzdGF0ZV9pbmZvJzoNCj4gPiA+IGRyaXZl
cnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jOjQ2NDoyMjogd2FybmluZzogdW51c2VkIHZhcmlhYmxl
ICdpJw0KPiA+ID4gWy1XdW51c2VkLXZhcmlhYmxlXQ0KPiDCoMKgwqDCoCA0NjQgfMKgwqDCoMKg
wqDCoMKgwqAgdW5zaWduZWQgaW50IGk7DQo+IMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBeDQo+IA0KPiANCj4gdmltICsvaSArNDY0
IGRyaXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jDQo+IA0KPiBeMWRhMTc3ZTRjM2Y0MTUgTGlu
dXMgVG9ydmFsZHPCoMKgwqDCoMKgIDIwMDUtMDQtMTbCoCA0NjHCoCANCj4gYTM2YTdmZWNmZTYw
NzE3IFN1ZGVlcCBIb2xsYcKgwqDCoMKgwqDCoMKgIDIwMTYtMDctMjHCoCA0NjLCoCBzdGF0aWMg
aW50DQo+IGFjcGlfcHJvY2Vzc29yX2dldF9jc3RhdGVfaW5mbyhzdHJ1Y3QgYWNwaV9wcm9jZXNz
b3IgKnByKQ0KPiBeMWRhMTc3ZTRjM2Y0MTUgTGludXMgVG9ydmFsZHPCoMKgwqDCoMKgIDIwMDUt
MDQtMTbCoCA0NjPCoCB7DQo+IF4xZGExNzdlNGMzZjQxNSBMaW51cyBUb3J2YWxkc8KgwqDCoMKg
wqAgMjAwNS0wNC0xNiBANDY0wqDCoAl1bnNpZ25lZCBpbnQNCj4gaTsNCj4gXjFkYTE3N2U0YzNm
NDE1IExpbnVzIFRvcnZhbGRzwqDCoMKgwqDCoCAyMDA1LTA0LTE2wqAgNDY1wqDCoAlpbnQgcmVz
dWx0Ow0KPiBeMWRhMTc3ZTRjM2Y0MTUgTGludXMgVG9ydmFsZHPCoMKgwqDCoMKgIDIwMDUtMDQt
MTbCoCA0NjbCoCANCj4gXjFkYTE3N2U0YzNmNDE1IExpbnVzIFRvcnZhbGRzwqDCoMKgwqDCoCAy
MDA1LTA0LTE2wqAgNDY3wqAgDQo+IF4xZGExNzdlNGMzZjQxNSBMaW51cyBUb3J2YWxkc8KgwqDC
oMKgwqAgMjAwNS0wNC0xNsKgIDQ2OMKgwqAJLyogTk9URTogdGhlDQo+IGlkbGUgdGhyZWFkIG1h
eSBub3QgYmUgcnVubmluZyB3aGlsZSBjYWxsaW5nDQo+IF4xZGExNzdlNGMzZjQxNSBMaW51cyBU
b3J2YWxkc8KgwqDCoMKgwqAgMjAwNS0wNC0xNsKgIDQ2OcKgwqAJICogdGhpcw0KPiBmdW5jdGlv
biAqLw0KPiBeMWRhMTc3ZTRjM2Y0MTUgTGludXMgVG9ydmFsZHPCoMKgwqDCoMKgIDIwMDUtMDQt
MTbCoCA0NzDCoCANCj4gOTkxNTI4ZDczNDg2Njc5IFZlbmthdGVzaCBQYWxsaXBhZGkgMjAwNi0w
OS0yNcKgIDQ3McKgwqAJLyogWmVybw0KPiBpbml0aWFsaXplIGFsbCB0aGUgQy1zdGF0ZXMgaW5m
by4gKi8NCj4gOTkxNTI4ZDczNDg2Njc5IFZlbmthdGVzaCBQYWxsaXBhZGkgMjAwNi0wOS0yNcKg
IDQ3MsKgwqAJbWVtc2V0KHByLQ0KPiA+cG93ZXIuc3RhdGVzLCAwLCBzaXplb2YocHItPnBvd2Vy
LnN0YXRlcykpOw0KPiA5OTE1MjhkNzM0ODY2NzkgVmVua2F0ZXNoIFBhbGxpcGFkaSAyMDA2LTA5
LTI1wqAgNDczwqAgDQo+IF4xZGExNzdlNGMzZjQxNSBMaW51cyBUb3J2YWxkc8KgwqDCoMKgwqAg
MjAwNS0wNC0xNsKgIDQ3NMKgwqAJcmVzdWx0ID0NCj4gYWNwaV9wcm9jZXNzb3JfZ2V0X3Bvd2Vy
X2luZm9fY3N0KHByKTsNCj4gNmQ5M2M2NDgwM2E1ZmVhIFZlbmthdGVzaCBQYWxsaXBhZGkgMjAw
NS0wOS0xNcKgIDQ3NcKgwqAJaWYgKHJlc3VsdCA9PQ0KPiAtRU5PREVWKQ0KPiBjNWExMTRmMWZi
MmQzYzUgRGFycmljayBKLiBXb25nwqDCoMKgwqAgMjAwNi0xMC0xOcKgIDQ3NsKgwqAJCXJlc3Vs
dA0KPiA9IGFjcGlfcHJvY2Vzc29yX2dldF9wb3dlcl9pbmZvX2ZhZHQocHIpOw0KPiA2ZDkzYzY0
ODAzYTVmZWEgVmVua2F0ZXNoIFBhbGxpcGFkaSAyMDA1LTA5LTE1wqAgNDc3wqAgDQo+IDk5MTUy
OGQ3MzQ4NjY3OSBWZW5rYXRlc2ggUGFsbGlwYWRpIDIwMDYtMDktMjXCoCA0NzjCoMKgCWlmIChy
ZXN1bHQpDQo+IDk5MTUyOGQ3MzQ4NjY3OSBWZW5rYXRlc2ggUGFsbGlwYWRpIDIwMDYtMDktMjXC
oCA0NznCoMKgCQlyZXR1cm4NCj4gcmVzdWx0Ow0KPiA5OTE1MjhkNzM0ODY2NzkgVmVua2F0ZXNo
IFBhbGxpcGFkaSAyMDA2LTA5LTI1wqAgNDgwwqAgDQo+IDk5MTUyOGQ3MzQ4NjY3OSBWZW5rYXRl
c2ggUGFsbGlwYWRpIDIwMDYtMDktMjXCoA0KPiA0ODHCoMKgCWFjcGlfcHJvY2Vzc29yX2dldF9w
b3dlcl9pbmZvX2RlZmF1bHQocHIpOw0KPiA5OTE1MjhkNzM0ODY2NzkgVmVua2F0ZXNoIFBhbGxp
cGFkaSAyMDA2LTA5LTI1wqAgNDgywqAgDQo+IGNmODI0Nzg4NDAxODhmOCBKYW5vc2NoIE1hY2hv
d2luc2tpIDIwMDUtMDgtMjDCoCA0ODPCoMKgCXByLQ0KPiA+cG93ZXIuY291bnQgPSBhY3BpX3By
b2Nlc3Nvcl9wb3dlcl92ZXJpZnkocHIpOw0KPiA4ZmEyZjhiZDZhZDEwZWMgWmhhbmcgUnVpwqDC
oMKgwqDCoMKgwqDCoMKgwqAgMjAyNS0wNC0wOcKgIDQ4NMKgwqAJcHItDQo+ID5mbGFncy5wb3dl
ciA9IDE7DQo+IF4xZGExNzdlNGMzZjQxNSBMaW51cyBUb3J2YWxkc8KgwqDCoMKgwqAgMjAwNS0w
NC0xNsKgIDQ4NcKgIA0KPiBkNTUwZDk4ZDMzMTczNzggUGF0cmljayBNb2NoZWzCoMKgwqDCoMKg
IDIwMDYtMDYtMjfCoCA0ODbCoMKgCXJldHVybiAwOw0KPiBeMWRhMTc3ZTRjM2Y0MTUgTGludXMg
VG9ydmFsZHPCoMKgwqDCoMKgIDIwMDUtMDQtMTbCoCA0ODfCoCB9DQo+IF4xZGExNzdlNGMzZjQx
NSBMaW51cyBUb3J2YWxkc8KgwqDCoMKgwqAgMjAwNS0wNC0xNsKgIDQ4OMKgIA0KPiANCj4gOjo6
Ojo6IFRoZSBjb2RlIGF0IGxpbmUgNDY0IHdhcyBmaXJzdCBpbnRyb2R1Y2VkIGJ5IGNvbW1pdA0K
PiA6Ojo6OjogMWRhMTc3ZTRjM2Y0MTUyNGU4ODZiN2YxYjhhMGMxZmM3MzIxY2FjMiBMaW51eC0y
LjYuMTItcmMyDQo+IA0KPiA6Ojo6OjogVE86IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BwcGM5
NzAub3NkbC5vcmc+DQo+IDo6Ojo6OiBDQzogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQHBwYzk3
MC5vc2RsLm9yZz4NCj4gDQoNCg==

