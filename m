Return-Path: <linux-acpi+bounces-10286-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7BE9FB575
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 21:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1101188242E
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 20:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7DA1C3F13;
	Mon, 23 Dec 2024 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoNiVvhs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333CE1BE871;
	Mon, 23 Dec 2024 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734986421; cv=fail; b=W+PoUyZ/3q49Qqm2uJIzJUoBLPq+WhKj+KAIUbKh/Z5W/e+d6ZJemTf/IK5l6QLdSBRP7bU/DWo2KDaG7nB4WvduW4C60K9tz9I2ZxhbFaskQ1RpHB01h3vQxsz6AuKkZN2vVeo+SwA01OLXgSawuqoqY41Fr+BnoTRHLR9qplU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734986421; c=relaxed/simple;
	bh=pIRUK+9/P5J9FIS8HYwdaRa1msdTiG+fdA9JXxccbGs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FPJp9xBKUYdCiIcqMTVDkVgpdz7B/nLFIJbySiJk5+w6MWvfzCidS3SPFpvW+LrJ4fL0Y5wlzL8AAAxryvBp35Tl8M4pnnzgvHYq45nGVAJtdWyB7KYXpQTow2b5jAGB8hTl37rTI5RoF+mNnEcg1MIO/rpoD4TaPZeD2uX4Vi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PoNiVvhs; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734986419; x=1766522419;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pIRUK+9/P5J9FIS8HYwdaRa1msdTiG+fdA9JXxccbGs=;
  b=PoNiVvhsRg15+fU2Irxah+jw70o7AmX0GdmYFJL6TV42HN53i/A7tjrn
   ecN9BUD/2H/O/Y6mg9jQvFIM/3pxHiV22Phl7RYN/19gcAH+72Ehs5GdI
   8ku5ENOv5MAQU9ttvyUnLcrpzV+2sw+8yBhruiJn9v/DDb2iBkSwss1bl
   9vjWESaIl2K+LGinST1c+22Ff3vnfGy58zZ6QjMRp+p9rZhRt3dNabPmj
   wf9S+ynzIOPh8iHN/7eaHhACeEwr1uzWQpb9H5xpBf8okrsQRGj+stW80
   2jvKbQk0POr8K+Q8NXkkZSm+RQElrHdrFB225uKc35xnzCTlOVpkVYqva
   Q==;
X-CSE-ConnectionGUID: CClLgsKoTOGLZ3x2w9RZBg==
X-CSE-MsgGUID: r56R63o+TzWu9zJ/4eNZJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="35340960"
X-IronPort-AV: E=Sophos;i="6.12,258,1728975600"; 
   d="scan'208";a="35340960"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 12:40:19 -0800
X-CSE-ConnectionGUID: vVpiuWjIRKuPXD/bsTyMIQ==
X-CSE-MsgGUID: vFmPZ3ckSzK+EznreGfo4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103385593"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 12:40:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 12:40:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 12:40:17 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 12:40:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEG5j/qBoY91xpUlnZi4qnbXzX3EoJ9eok7JM0I7JLS6xWPDffeUQ2qOuKBfA9rpXdc9MQRbEu1EC1FgWpqQdh7TGJfrD0zvigl4dU8hSpWU+IEmI3Vp/wD9gPBuCTSMV4iBQJrXez1pyqsIMvD0Bo5RCADYTHX8sDf85eIP2aODvRa7NzrSMyzyZ9ZJ8aqkru8cN1oz1agyrwr+kBNk79OaTVmbajMyqh3rE4HxRyLGo14XjvEF8P68zwr/ZbGA2Gpei2ZdYyrHMDXVorrLj2p+FksXjhZth1PV1KA19v6JghrCzzhGYQy9hASVD2UaCeHXrlcQgBlUofvD1LNwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hy8UVMOInFPrH9EqmsPXq1Gl+buWVhd8iwJlAZc6Yxc=;
 b=AsIOkOrl9VG3E0Fe3LwAsKkZsdfEeN++dl45kyUOVD0ZecWr/OXmqTlDs6kn/Hh23OCADqFCP+RpHi6iUrj/ZZYxjEDr9/kFFikImsmYnVVOqUdbR1NLqovpdE2DTPMGXa1pe8dF19sPB1Us7ZAn3rIfOtebdj2kLf/yvjnHW29xVTkebig3TP6pzl4FG1+Lt3PpyDnN/CviSm8JeeqQJ39DvpjidJqMOtlMZh+f/ZcrXKR6hz0c0pTvydlWHPf4BrjHWQi995MgriPwnA4NcDWyaFrsQOUOD4nCUAJqPPjCnaKVnES7usp3JpLs308Iubm8MIvIRIZIOoYp2kedBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 SA0PR11MB4703.namprd11.prod.outlook.com (2603:10b6:806:9f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.21; Mon, 23 Dec 2024 20:40:11 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 20:40:11 +0000
Message-ID: <47670327-7a66-43f7-8890-10c7e2f024b7@intel.com>
Date: Mon, 23 Dec 2024 12:40:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/15] x86/apic: Fix 32-bit APIC initialization for
 extended Intel families
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
 <20241220213711.1892696-2-sohil.mehta@intel.com>
 <0553d913-0a8c-4508-9657-9b53b106f4bb@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <0553d913-0a8c-4508-9657-9b53b106f4bb@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:303:b5::11) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|SA0PR11MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 115ce5d5-8704-4571-bb54-08dd2391ff26
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QW5aVGFvM1RreXMveGhnVU1VYkhtdXc1ZFFIOFBOUGhrOHZxVUEzRml0RDlq?=
 =?utf-8?B?VGRiUWNSbEtlWG5kQStWNGZUYjJpOXlKcFppWUJHOUorOGxQVS9uM2tTc2NI?=
 =?utf-8?B?ayttKzJxeEQrYW50Szh0a1FZZXludTg5WDB4QlczeG1mOEl5KzBBTjUxVTA5?=
 =?utf-8?B?VldVMG1CekxuQWlPM0drcE0wSTZNaTRydG92dFhRelVBTlZwcUpobFU4cDIv?=
 =?utf-8?B?QmVZUlE3UE5aaVp2RTBWeW84c2hzQnBtbVliWWNmVE01NVpuN0l1SlFzT1ZZ?=
 =?utf-8?B?cG9QQS92QzdHZXlFNm9NdFpVdmJKVXVDV0h3QTRPM2J0dW1FNHJxSEkxc3Ux?=
 =?utf-8?B?cElaTlBXcHJ2RnlvTlA5elJTYkZ2VldhWnFGQkNwbFphUmNWaVV2UGJmTWg1?=
 =?utf-8?B?bDh3MXRmVTBweDUrYjNlLyt6eVN0Ulk3YWdDditQanRsVWlBVmdKbG1sODR4?=
 =?utf-8?B?R0hUdzM4cElNZFROUDdPaHpJYVFZR1psKzhPSVp3eEJlaDZZRmFIQkpLbFFL?=
 =?utf-8?B?N05hdllMem1LclVLMVI5TDVnbjJQeWszb1FBa0V5K1MvY3hxUDRFUGI2QVRv?=
 =?utf-8?B?bWFFY1pJR1BHS0R2MjcxaHdPWHBzQmpDbzJRaTF6T3ZLNXdBY0dxc1kzMnhl?=
 =?utf-8?B?UmMyYUs2czZONFFuSHQ3RDJqUjZYcWxJa1lLc016aVdEYVJabFBiQU1kZENi?=
 =?utf-8?B?Y0I0L2IvdjZZZUpMUmFyV1JaTTZ5SkVtdnNobzRuVTlDbnJ4MkZ1NUdFcWI0?=
 =?utf-8?B?Y1dSSktENmN3dW5sWmtnVk92aU5QRXU5dzZMME1YdFJ4dHhIb3Z5MmdNY0w5?=
 =?utf-8?B?U1ZyV1BXYUVvaXNWVDVhNmIvbFB1WFVKZzBRNk84TUtya2RncnpsbzFuRDlj?=
 =?utf-8?B?NThETTFJZVp0Smp4Nll0R003WjJ3eUc4M3kzU0pkU0ZJSE5scHY2dmRCeEVV?=
 =?utf-8?B?dERUT21wcHVKcm4zK3R4VlI4bmV4M1p0cUtGVzFydU53Q3VPdGw2WldUWEw1?=
 =?utf-8?B?czVLM0hNTEc0VFJLSWNjSlREV2J3UTVwSzVVMjJuQjJOMFVFUUZLYlFkOFJS?=
 =?utf-8?B?Q3Qvd2JrdDd4Y3prV1R2eVEzbE5BOGF2MndveWEwdDhOMXZRV3YxV210TE95?=
 =?utf-8?B?UFAyZ204ZmVQcVFPU3poWCtiOWFwSHZHRm13aHpEcFlXQTBTS01VY0I4K3RU?=
 =?utf-8?B?ZkhLcFlHKzMrRE5FNDFidlkzUmx2TVhRMWNtV3F5MkhtZHRXYXRCakgrNWgv?=
 =?utf-8?B?RFlJSU53V25nanR6VVVlbldJeG5JbEtJQUkvNVZIb2h3U3V0bW9tYkVnZkRu?=
 =?utf-8?B?YjNtdW5ySnREYktMTzVDSUMyckI4elNCeFhKeVBiTk9Xam9ERDAxZEdrWHlE?=
 =?utf-8?B?Mk5WTEs5WlJvWG15OThPVmJNZlBobkJMbTJrbnRoTWdxUC83R3FObCtaS2F5?=
 =?utf-8?B?TUZOSTFJSGJJb0xWemJzbUZJL3k1cXkyT1VxL1RuaW1uekJpazVpWGFJWFQr?=
 =?utf-8?B?dml5OGlIVmxDRmJsMGFFNnY3L3NKRWdYWVFqZEkzWXl3Q3MvdE1nVWJCSTNz?=
 =?utf-8?B?RERqMFhZVnJDNjN6OG9kTWg5VjJMVEl0UVJRMDlRRkdsOHlTVlI1YmZ0NTdj?=
 =?utf-8?B?aytCMHVEL2I4cUxHMTUzeGNPa3Rkc3dpaGxKYnM5VWc1UTJHQTJhaDNMUDNN?=
 =?utf-8?B?K0N1dHNoRTlITHVrSEZXVk1sNHhoK1dzTSt0aVkrbGRyUnQ1NCs5UXNoQzFT?=
 =?utf-8?B?SExjL3Znd2VTeHFQZGxZSTRGdENZWkU2ZWgwQUlEY1ZveVIxV3MwOTJzZHZr?=
 =?utf-8?B?dE5DYkl2Y2xjZm9DUDZJcXVOUFp4UzI2ckdQaFhLcHlkcTRWYWdJZ3VER1da?=
 =?utf-8?Q?hTDPBphi+WFE1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDh4U2tPNmhIRHA4RHVXOVVaaGlRVDI1RTNBWXlzcWw2SFpZd045ZDY0TXZC?=
 =?utf-8?B?VHlvLzFkVWU2UEkyYURFWndDazlHL251TENkWmJqWkJOL1QyNFEvNFkrczFJ?=
 =?utf-8?B?bXBlT29oM04vdHlGZldnTzBnSHRHTjdReTFRdUVORlZkb0g3NHovSDhicDA1?=
 =?utf-8?B?VWtTWmpZQTg4NnJpby9NUWZMTzVSby9SRTJsbjI3TFJ5cHEzZCs2OWxsbVJv?=
 =?utf-8?B?SEh1c1luTW1sV2RzVlp4Q3NtTW5FYVRNc0c2SVBKU0JKaVhEcitoQklVZGNx?=
 =?utf-8?B?SSt5T0tTWGlYaGQvdGNIL3Q2bkRkbGhWK2M1b3Z0bG9KMlVrSnZ4R3JOL2lN?=
 =?utf-8?B?eXo3N0QvRkJoS1A0STRwcXNyd3dCWGU0MXhJUGQ1NHFRamZleC8zRFhMUk5W?=
 =?utf-8?B?a2lpd1ZRa2tnRG5IbkJXMC9XOUlkR1JLcDFCWVo4blhuVGUxREF2OEdCWlNI?=
 =?utf-8?B?bC9iTmJpaFU2QXByaGxwT1laRXJ5Y2FSUE90NGY0MU5LcWxaQjRSRkpjQW1C?=
 =?utf-8?B?SXB4Z2RNcGI0NmM5R1prTXQ1SW5qSUk1VzV0aUZHUVZqTlJpczBxdmt2WUJP?=
 =?utf-8?B?QjFoa3J1Ujd5K09IbSsyWHY4eGJybElGeVZ4RXpQL0R2SnBXUGMveXRPRXNs?=
 =?utf-8?B?ZmxVZm1sUVYzT3hvTU14aHpCTG1zNk44Y0JuNjByY29HSWFURTVIMnB3bjl2?=
 =?utf-8?B?SElzRGhmSEx1OG9mR2JtY1BCQW16cnRjTkYrZTVySXZKc1lrQXJOcE1WNVg2?=
 =?utf-8?B?S2VDZmFXREE5Z3p4eHJFd2lQZnQwVFlkcFdVb2N4R2NIOHVPVXB6UTNjNGhp?=
 =?utf-8?B?WkY3YXlwY0NlbG1OWmJnV1djMkk1bXZQcDhLbi9mUUtDZ3M3U1h0QU02WVpY?=
 =?utf-8?B?aWIzd1JzSDdCVVZ6eUYwQTY4RHFDbVgyN1gwMUNwYlN1VlZoV25jNFNUYlRy?=
 =?utf-8?B?anRDYjN2MHE1Z2FIa3F4M2wyT2FXejQ5a24raFN6cGZ1b3pTZmVoc1psMGxr?=
 =?utf-8?B?cUVJNDVwdlhwT01JSGNMU1p2OE56SkkwUEFZVDZ2V1RQSGhhSEU1cTh4aDFi?=
 =?utf-8?B?eFNGNVdiM0NtMzgyWEJnaTN3VXdLZEs0REIzSHlwZVFPS3JyWVFCVnlVVFcr?=
 =?utf-8?B?K2EwWHBIZStZRlpzd3ZrSWtPYjNrbDBNYjdHT25PZDBkUWhyUkxHNnl4OVZm?=
 =?utf-8?B?cVkyNTBhZVpRb3M2Unp4c0RKREhJOVd2Y29HWUxLaWt2RzQ1eUV4b3c1K1dl?=
 =?utf-8?B?ZnBMT3ZaOE1vcUpjN2xqWksveEpYdEZKcmczQURxZ3lBUCthOGJFTzBQSjA4?=
 =?utf-8?B?Q3ZzVndWV1VSeEZmNDFwSjR4SVkxUjR4dFJyUno0S2JnMjA5MlZjK2RpaS9X?=
 =?utf-8?B?d3hqY2hGeGxhUG9uRHpzNU5CY0VId2ZBaTArbXNHZGpvajdSalhuRmdiYk4z?=
 =?utf-8?B?NGdSLzhiaERreS9sMVZMdm5ZU0xxd3liTG1zQ1VPeUlvOEI3MTM3dHVhenls?=
 =?utf-8?B?WDMxQys1UnhiZTlsemhRN0tUdjdJVHRkRS9GZ280NHdqdHB2ZU1PV0U0ZTdn?=
 =?utf-8?B?N0xjcy9KZ1BiL1lmbmdKUHpoUnVkTkh4M1lZRGNMalpqS1FUS2NsMm1ZY283?=
 =?utf-8?B?RjhRcTJXOGpXNHZodlBWMytsdWJaeW9LNXdKMGlSY2ZpR3ZBRWU4ZGM5V2JR?=
 =?utf-8?B?eGNtdVh2bmJxbTdDd1NMU0xUTnJwa0RoMFA1OWNocHM3ZHQrcG1YbUhyTVNi?=
 =?utf-8?B?ZjZwTzRuMXhQSnRtMXFRU2R0M2tTcDVyRGUzMSs2elFOTGo3SmFnZDRqKzhQ?=
 =?utf-8?B?WFJDNnAzM3MxazkvbEN1eDRucW04UWFwdVl2OVVvNmVuMmZzZVI1ODQvWkw3?=
 =?utf-8?B?SkpoNGtsczVlMm1CcEREWTVmWG5DS3U3VHJ0Wnc4WWtHS3p2eTV1K3FNeHZo?=
 =?utf-8?B?SzJKbHEyVlRtVXdiampXUGJHYlJ3S0tDbjdkWkVqWkwzNjE5L05yTkU1bFpi?=
 =?utf-8?B?eUowS0JpcnhScmIzUytOSE1nc25VZ0hoaUNMWjhuM0NkS3VJWjZHU3NDRFgv?=
 =?utf-8?B?QmxvdDhRN2t6SnNjV2NhTDlGQ0prc2dlOWM3YXNEbWlNSjh1cjRpQzh6MXEx?=
 =?utf-8?Q?mZ8EGZz97GcbsZB8STf59VwEM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 115ce5d5-8704-4571-bb54-08dd2391ff26
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 20:40:11.6429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWp+Lb2h0R0VLvlBZNtkNar3GH2PaVMr2sUaSW7WiOd2bKQth9PxO3pQTNmeWilAgujzaT/1C29sf+gLdlDnnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4703
X-OriginatorOrg: intel.com

On 12/20/2024 3:13 PM, Dave Hansen wrote:
> On 12/20/24 13:36, Sohil Mehta wrote:
>> detect_init_APIC() limits the APIC detection to families 6 and 15.
>> Extend the check to family numbers beyond 15. Also, convert it to a VFM
>> check to make it simpler.
> 
> This changelog doesn't _quite_ fit the code. I'd rather it was a bit
> more precise. It does not _just_ expand to "numbers beyond 15".
> 
> Also, It doesn't _really_ help to have the changelog tell us the
> function name. That's why we have diff -p.  How about:
> 
> 	APIC detection is currently limited to a few specific families
> 	and will not match the upcoming families >=18.
> 
> 	Extend the check to include all families 6 or greater. Also
> 	convert it to a VFM check to make it simpler.
> 
>>  arch/x86/kernel/apic/apic.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)

...

> With that changelog tweak:
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks for the Ack! The updated changelog does make it more precise.
I'll use that.

