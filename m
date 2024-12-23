Return-Path: <linux-acpi+bounces-10281-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933889FB3DB
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 19:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053E91658FA
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 18:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004AC1BD000;
	Mon, 23 Dec 2024 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0Js+qCr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8F61B0F1B;
	Mon, 23 Dec 2024 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734977636; cv=fail; b=eAyjoHIhGAFb1MaQJ7CRdABESCwuqWFZuHBTCD5NSmEH+2FsoI8Xd5ZWL7FPD47dPcakpLRuYk/bg7adUJk9DpaUqu+/Y6j3me2PZDgRLbcazjquZYASaayXVSHtOUQ7y9B9Y6GOrN7Cwc6S2abdS5rkxfwtpJNqF+TyOFmKQa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734977636; c=relaxed/simple;
	bh=oQZW4wKdybArjz3rE5vTmDXlLWz9KvveNeqfkg0977Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hii7QkzhfZY6sviDqOiAy5hR0Py1aeQ2FAjynQFMfYLYMBF/YRud9dymqPiDCdzJFapsY0a8eEbN4AdbzCa5smwAiOmqZx/H2g9DLP3JPOvmM792yhnRNdgZtvDjH4K/dNhiKJjn6n1Lc78XaKAR9QHEX77mn80RFf3D/S9Fq5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0Js+qCr; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734977635; x=1766513635;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oQZW4wKdybArjz3rE5vTmDXlLWz9KvveNeqfkg0977Y=;
  b=R0Js+qCrQMXjnqXa6lRFkPvQNtnf1qWbWshGy/vUOZitGQRceuI+RTRJ
   /hKYPW9xaHwSQYjv49lCMFCjfv85n9AOCEgkdf6gScbT5BjNKT/cX9Gtr
   gRFqTmjY2Z3sRAfI9S0tIjHFcTY/+QvE6hg5Om50mhDgz+bw+HvYeqQKw
   fOSXKHYil+HfI5JngWoG0zlZ8dnRwYdnOyCJhQowHiLp709NZGhNzfR+C
   kIPqgjCUHm6AhDVsyBy8UB9c54Jjj/yiSPY+27E1olfChn6l5FMZjS/Ll
   ttFej7df9aUcmFVyLYQHcR1Y+2aRPq6lP1tZd7T7gIwAeZ6NZqzir/t5j
   g==;
X-CSE-ConnectionGUID: ms+7QL4QQpq3nJiwCkk5Nw==
X-CSE-MsgGUID: hGfgzq+lRuy+tnM5XuaE/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="39225580"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="39225580"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 10:13:53 -0800
X-CSE-ConnectionGUID: tayWr4TPSDOkDzerQeJVEA==
X-CSE-MsgGUID: RGzeHUaISSmUJV8w985q+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="99033619"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 10:13:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 10:13:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 10:13:52 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 10:13:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H766VVISCBYMA9LVkWMLYfaazQASX+zCs2YWDv2VjdoxqHrCiMOXyzsLMjauX1PRbkQ7Qh5edqiBZeWUfyEneK0EOWe9KJHixiHjKT9GjDaWLtl6jIOCOv/t1GSg07Fmo5uVRSlCC+LPSobO31Ke2kq4c1iYKTZG7sdQXnxlAhAH6nN8W+4EfxSfeKAV4pRkzp/aSuRraW99BNkloy8fLCnfk9dJAHVzPVatUBvgxElAsJ4VngqY7WlznFbSrP4DB3oQeGt4GARCh2hxkMCk7QexijMDfRCCIZ7Zqe4awtrPg2dvCQ6j1rktcvyV71E4od15Zy1PYaTl9YfTkNbiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQ+FsPxdNrx5QTUgunpSMaDlF21sLo51LqAgGGPwbcM=;
 b=rYpR5eBtnVz4PVKLYerDTR/rROeRGS+OwKc92U7XSkFZlKFpXht0tooGaOY1S0zGXLQPbhUOZKENWDY7su4vp5vuQtw0OqMjs2PW8fYo+EsY2QDG2fV/IoqPIPBIhTYBD8aiXlZW1TC6WPPhtQ5+TXLhtffMDeO81H/0Na0oM3i5O9n2VAhS3kclIFMpkGEt0k1L1jLR65ystoyfHoYN/hbhOPvmwIp4svVgRSZMxYsf5lySMKHL8eXc/4vj40WFncoz3JMjukowhRwo7lKQua09SFXEphTzmWpV7OM44xsB2KwbuLtCEciJ6T5ljcPzme7VwUv0pDKFrSnDtjUATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 CO1PR11MB4851.namprd11.prod.outlook.com (2603:10b6:303:9b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.19; Mon, 23 Dec 2024 18:13:50 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 18:13:50 +0000
Message-ID: <89acce43-b4f6-434a-96c3-1a2874116b5f@intel.com>
Date: Mon, 23 Dec 2024 10:13:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/15] hwmon: Fix Intel family checks to include
 extended family numbers
To: Guenter Roeck <linux@roeck-us.net>, <x86@kernel.org>, Dave Hansen
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
	<jdelvare@suse.com>, Zhang Rui <rui.zhang@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>
References: <20241220213711.1892696-1-sohil.mehta@intel.com>
 <20241220213711.1892696-6-sohil.mehta@intel.com>
 <cdece644-385d-408c-bb8c-c8fbb17c1372@roeck-us.net>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <cdece644-385d-408c-bb8c-c8fbb17c1372@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:303:83::7) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|CO1PR11MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: 506bacff-9097-481e-740e-08dd237d8d04
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2FjSDk5alNvUklkWUFUWU9VOVNUWG05Y1NEVFlVM2pWZk9nUmh3QTEwV0NE?=
 =?utf-8?B?U0J1Sy9hbHZzMFZscHQycy9UZCt6ODZXenN4NCtBZERldXcwZDc3UTJIZGM4?=
 =?utf-8?B?UG5KNjVMMnJnczFRSmoxVnNTR2dPcnBSd3JtdDRRYS92YXNCUGdUOEN2K1hC?=
 =?utf-8?B?VnJzMVFPU1d6Qit0eDlnVlptMWZHNEtadWZWQTdQMnFTanRHcGN5ZDZiVnJy?=
 =?utf-8?B?NDhrZ2pVMGRmMW1YaXFYVkpmS2wvcmlqcXptMUpvekRqd2R6am02allHVGZk?=
 =?utf-8?B?S3dBMnFrRmtuTVZKY1p5aFV1N0FzOEFGZTR1Y1pkTGw0eGlld3piQlhYNk40?=
 =?utf-8?B?Vm51b0lxTk1YdCsvN0NkWVpkUEY1UUtDQ3VqclNVTTlBNTlwZllrb21tSmRz?=
 =?utf-8?B?ckxzeWtVM2djbHlWb3FZZG1zbHdqNUFBdWo0dFNmaHdaa3V1c3hxREsxVTFz?=
 =?utf-8?B?bDd1YjJGcGswZS9IRC9HSnR6Um50RWJRWVBwT0NIVVh3ZSttSlM2NXBRQTdR?=
 =?utf-8?B?bWpUbTN0VkFCT2swTGRwQnkza29CTmJKM2wyRUVTdllidks1M0pITW1NU2hW?=
 =?utf-8?B?emRVM2E2THJtbGlCamVSQjBHQUEvOExDMDdtZjhKTGpGWTJWRWFPaEN6Y0lt?=
 =?utf-8?B?dDJVNFdJNHhiZWdmY0Y3TENPdDB2bW9DdFNNaHRiYWRvNHZIZFJ0UXNIN1ZZ?=
 =?utf-8?B?WUR5WHQ1NXRSbTBhZTk4c2I5T3A3RDJUaFh1RVRhbkxNS0JlNmpHNmJMYjBI?=
 =?utf-8?B?Y2lYRjJ2aHJ1bjdMSWUwb3NmTU9DRWRuUWpjT0ZIQi9JT2NuTDNROVlnalZs?=
 =?utf-8?B?RUVkSjF4UEJ0Z0JaWHUvRnNZdEZtRWpVNE9QMkRMcjMvRVBrSXpzR01US1J4?=
 =?utf-8?B?dnQrUW00OVd1N3VVSHhqNVRJMU82RVNJVWYxVlZqSXNsMmEwWEpwcUZBS1pF?=
 =?utf-8?B?VmNyWDg0TEtzZ2FnaEgzWEc0d2dGbjA5UXY0UVBJejhHNXBjcGwwWWk2MEw1?=
 =?utf-8?B?S0dFUVJTdk9CelZLblFXNXRJU0xwdjBVSDJzbjMzcjdhTE85TTd4SFhWRmRW?=
 =?utf-8?B?cGhURkZWbmwwQzJmSU9UMG5FZ3p4TG9DWGdKUVRYVmg3OEVaUnlqcndOSWYv?=
 =?utf-8?B?U09OYmR6SHI5UEtKYjNZbVpMNk1leWNjdlRsQXJZYjZlTm10TDNXR0puMXB4?=
 =?utf-8?B?bkFyRS9DVW5BTkRPV1NiUm9LVVR0YWtsOFlsVndSQ0VrSVMvZ0JFN2V4VGZC?=
 =?utf-8?B?RjViWTIrTlArWElRVjhicGxEYm5QdFJvV01RbmxIZ2kwQ0ExQS93UWhZWnl5?=
 =?utf-8?B?eUZJdTNQNGpOdExNaTJGenp5Rld0bmlaOUJoTGpXVG9zMjJKSS9iL3FRQ1lX?=
 =?utf-8?B?SjBlMTVJemlVbWt5VFZrM0FjMXp0Ry8yQUpvOTFlVEx3SURVdkdFcm53SUpQ?=
 =?utf-8?B?ZGRDRzQ5Nkx0a3NuSjk2ODVFdXlxdldOd1dlZFpPM3dXTHdwbDRaY3lEKzNB?=
 =?utf-8?B?ajBpM3FEcVlNdFMyN2NtTVh0YzFJRjZzWTJqMWpqSXpINE9tL1RxeDJMNVJZ?=
 =?utf-8?B?L0ROaU9oOFRRWHFjVjFrZ2RwelJOTEM2d1UwUDBld3Jhd2RlZE1jM05Eb0lR?=
 =?utf-8?B?L1RrYllNbWRjTFdJMjJQNWtoblJ1Z2ZJWlp4U1krZEhLV3ZiNHBETTVaWTV2?=
 =?utf-8?B?UzFMd091MElra3ZhQ1QxNGplM1VTVDN4czl1eUc3ZDZ1ei9OQnR5QUxQM3Zu?=
 =?utf-8?B?NzltalBsaTBKa0Zlbi91Y3pkekdkUnpaTEoyenl4R3dYUFVtSWpjaHJJVUJ3?=
 =?utf-8?B?MHI0MFpXODlGbzJWNzRYbmRnYW1OSWhnRGhIazJ4NUYvMStjM3dnRXIxTU1x?=
 =?utf-8?Q?hR1SiLf3Iz6vU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2VPVXJ3aktDVDJnYmF4THc3VmxCWndqRkpTQ09LRUpDSzVtR1FVZlU1dlNm?=
 =?utf-8?B?U3FLSWppTzRoUzZ5WXh0bmNvM2hzaFc2R0wvQXBaWXZneUVNMG5RNVI1U2tl?=
 =?utf-8?B?NUdhNk1pZ3Bqdi8raUkyZjQvUWhIKzEyVm52QUk0SDJpZHRmSGR3K25rQnBE?=
 =?utf-8?B?QlovNDhhYnA4ai9PcERhaGhiOGVEU3pQS1cyK0NlZGt0QVBWdVRCM1hoQ3E1?=
 =?utf-8?B?RkFURnlpYU9PNVRJQmIvcEE1TFVCTXBwS04rcmRycVFPODFqeU5mUGt2NmpX?=
 =?utf-8?B?OVk1WlovcHdCVUg4M3ZPcVR6a0toWEU1VkJ5UVk3MWF1akFRUlZleWNUTGxu?=
 =?utf-8?B?TzI3dmdNWjRRZjdZTG5LOWx2WmxJdkFOb0VDRzhseHlxWVhPRXhIOGlkOWx5?=
 =?utf-8?B?YWlHOEd5RmdSeW81ZnEvZS9uL2Jta3A4MU9GVHd5NlU1SXU4VzF5S1NmL09Q?=
 =?utf-8?B?N1dNeDc2OVhHTGd1MFI0eWZ3R3BLUmRtVnpzbldDSVhjeml6OVV3ZTBOUnpp?=
 =?utf-8?B?aVNtdVZsSWFrVENZc3Axck44ak5tdHBZM2VwQndaTFdnVkd1ZGtnUHU3RFJJ?=
 =?utf-8?B?WWkrRWU0Qis3dVZTcnpraU5xdno2ZWhBY2gvY1EzYWxnMUR2RGhWNFB3djlO?=
 =?utf-8?B?bElZRHRCL3ZqT1VydW9rSnNQYnI3YU51VWh4YjJkK2hYUExNUkh1S2Yrbzlx?=
 =?utf-8?B?MFk2SXR6VE0yTVpSNnp1dG5IaG1BR2RUWkhzVjRlRVdJcHNRWUlYK3J4WTRH?=
 =?utf-8?B?Umt3OGlCSDNUbm95NEh2WmdWRFd6SHhjMmFIa3NVYjdnUWVSMlhFVDM0OFZ6?=
 =?utf-8?B?aS9RdEZtWDBWK3hiMzNCMlVkMnJtKzg4YnBJbEIvRk9MeFlCM0txczJTZXUz?=
 =?utf-8?B?djVrNlVFNTVuampOU1N6cjg0eDFjK1ZNSFJ5Q0orWDZtSVZDQWJCcUc5Q3Bi?=
 =?utf-8?B?U3lWbTRHK2ZVUHRVdllBY3FGamNncHdWRFhJQlZrTEt5VTJna0d4TnVjWEpt?=
 =?utf-8?B?RlpPbFN4amlMOUtCaklhQVRPU1k2QXkyTVlSQUIyQ2YySUZteUpQbmo2QWhH?=
 =?utf-8?B?aEpDSDJMNG9SaEhXSXVCbjZoeGFneC80R3BzNVhQMmdNenpSaTlGM0c1V3Na?=
 =?utf-8?B?WCtjOXAwcHZFU2MwcyttVmQ1RG5NWk1aSTk4Y2t6QVNoZTZ1RGlTalJWaSt2?=
 =?utf-8?B?d1I0SkdmRXprcjRYdHBxMTcybjdOcHZRT0hFMG9IazdmcGUxMS9rTEFFcWJj?=
 =?utf-8?B?K24vT1RxUWJjalF3Y0Fuc3dyd2dnZkxrc1liQkpVMUFLcHFoeFpaMS9RTmo2?=
 =?utf-8?B?aTVYQUhtbFo1Z0N6eTFMUnZCaS9tMDRjVmFHdDRFanY2WTRHY2NFZCt1MjZ2?=
 =?utf-8?B?N2Y5QTJ4L01Ob093cmgvekNIOXhWOGZJcm9Pc1dnUnEra0VKdFZ5MWt3UUY5?=
 =?utf-8?B?SEdvN0Z1Z2hLTUJFY0VRc0JGb2ZKWUNnMTkwMUF4aTc3YUtRRklMMTB3UEtt?=
 =?utf-8?B?Q1lkTHFCTEZETHhiUS9ZeTVDY1FsbkV4WXY4UEwxblRwSlVOTVdGZldiT2RI?=
 =?utf-8?B?TFhQZEFwc1JNdzFuclBIcDVXNXZhNXEwU2lPa1JyYTNQeS8wVTJRSkdJR0Rt?=
 =?utf-8?B?MlNQTWg4OWppWnEyWmZldWNnM1MwN0JiZ3I0N1FDTTlKelJiZUtTSm5qVVhl?=
 =?utf-8?B?TStkN1hmMThIK2tXdGgzV0JkVm9uTFdCdVRNbUNwQ2UrNjM5SDBaaXpqQXNT?=
 =?utf-8?B?TjI5T3paajREd0VmTGxpZHp0L2tGRW1YNk56NjNKdkFsaDkrWGsvbnQyNFdF?=
 =?utf-8?B?MFRSWEZaMk80OUVTWGNmeWgvS0VaQnF5QmN4ODE5TmpMZE4rQXFsQ2QyNW92?=
 =?utf-8?B?TVlVZUgzT2pjazgrVERyaVlWOXZpdUczRXV4Zk5uc01ieHdVUmkwTEk4RHRr?=
 =?utf-8?B?ODBLaFljdHpWaGhlc05EUlNTOVlTRHZ4VDB4REFkb0lDMDlQTHpYa3ZYaUdx?=
 =?utf-8?B?ckV6Q0lyUnh1TVdoUU94ZmRQOVRFUUxEZHJNNGxzazhDVzB6R3JXaWVaUG9p?=
 =?utf-8?B?MWlnS0V4S284WVoyUndZcWo0KzNjNzJoWGx1N29JZHdaSHJMWHl0VCtPS1pw?=
 =?utf-8?Q?AFYAkHNRFpqImJe3PEkt2dHhy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 506bacff-9097-481e-740e-08dd237d8d04
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 18:13:50.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeO13LitoJNLG6fCG4uF2PszmOUA7m1so/OX4PUMDyXrbp16ERneJ4hAA5ScVS/QqE/0MNhqEJHN9fZGDMpzbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4851
X-OriginatorOrg: intel.com

On 12/21/2024 9:27 AM, Guenter Roeck wrote:


>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 

Thank you for the Ack.

> The patch is independent, but since it is submitted as part of a series
> and there is no comment suggesting otherwise, I assume that it is expected
> to be pushed together with that series, and I won't take it into the hwmon
> branch.
> 

This first RFC version was mainly intended to be a conversation starter.
I am not very familiar with hwmon and my testing has been fairly
limited. I was hoping we can get at least one tested-by on this patch
before merging it.

I have tried to keep all the patches independent to make it easier to
merge whenever they seem ready. Please feel free to merge the patch if
it seems so.

Sohil

