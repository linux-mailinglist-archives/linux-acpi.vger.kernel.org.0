Return-Path: <linux-acpi+bounces-10285-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBD49FB508
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 21:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F77016684E
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 20:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785C21CC899;
	Mon, 23 Dec 2024 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cA9wY08A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E381C75F2;
	Mon, 23 Dec 2024 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734984837; cv=fail; b=SBQgKPJo/+tbpZiB7ypwJ4U4w9wxtsBmDxhnbsqRtQ6qj9UEMCLBTpASRpKBt4XmIMl7oDZzsoDliexxmir4jdxMwd/zoUWIdz7dw1xyO/voUQjAcr5JxEDGcWZ9hgSz1oW1R/7y+xgY05IEn+1GaxCKIM2HGBMtn/nbaxeO2qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734984837; c=relaxed/simple;
	bh=kY5nGeGDxfeUVfZKzmyB/ep0gY1u6+u9EkVmsstDJrU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RGLYuut/ozXf7Zq6dLIaRTcDjxCIC5Id8bJYy57gzMymCb4UgKdA3or51NM5R2PZGFqm0AnyPo3/PH50Teey6X02saojSyTCQxsYDm3VPf1TbCSM7Ppg7sl5s4BLKYQm3hJsZsvw4DwJg/gexPIhAalZPJZMFX3OXr08GcpM6wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cA9wY08A; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734984836; x=1766520836;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kY5nGeGDxfeUVfZKzmyB/ep0gY1u6+u9EkVmsstDJrU=;
  b=cA9wY08AxTI52W4joQy4D74AX3DOPD3YBR317JYFdI7oF/ea4Ojfl+tX
   6unVweEDsSg3H3QlyJwRs8g1jOQkBykw8r3JalVxNsYCWzRO2vDgBqxGz
   yfOFMCP6Lzx5LdQDNJ1JKTgvwBM+/kqcsU1ohzP80Kx8DkBQpMJwhyk9Q
   vs7cZ+D0uPNIo8nF/rlyPBH3Vxc6Y+eM7SHt74sdW6M6zDl3hZ5aNqMoK
   gref6jw6MHi7B+K9WkmLYfJahCPde44MaGlgr7FeQ6Bnip6t3b8nibgws
   k2ynk9W70C4eXzTbfW/TPDyQ2bczTJbTK3Fhk065wqN4d8Svdohjy51xr
   g==;
X-CSE-ConnectionGUID: HhzStL5xQgW7AmQUph+6MQ==
X-CSE-MsgGUID: 0fUV+RZeRguaxrh1Za00MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="35579878"
X-IronPort-AV: E=Sophos;i="6.12,258,1728975600"; 
   d="scan'208";a="35579878"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 12:13:54 -0800
X-CSE-ConnectionGUID: GFjSxPVESjCmcr8xnkDepw==
X-CSE-MsgGUID: n1NnrxvYQ2SU4zCpL1AJsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,258,1728975600"; 
   d="scan'208";a="99518931"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 12:13:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 12:13:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 12:13:52 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 12:13:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDsydyP8ToENwddVkT3XEaj7MUbGLadxgHXrYaaELA681bvBI15kV8JmdmCkdihRzkh3nuaDnAovh5HjrbsUa3U/49IZYQRBfjV5DPSNcQX07qR97fYFX5Ny0DgG/U0dr/uQTzNZZSGhxOYY4su3mkBARFST4jfWAYB7ZF+N5dtMvweY09fKhpNKIw69X9hlxlI0ZrLP/sxIxC9NONhrj+gJzMOSwuVOz9URepRcDcJIdlmtZasdGsWxfAnp+upukBoYGeU+INsPvH7kpjzPh+qAnCOmXI5eLL1uP7ASW6lS2zpeHMYLLhty7z+LHtkfXOxV3mqTX2GQDNsaNz+how==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kbcSj4hq5pyTZrx5G40oEAQUpgdtFoEI7y+l0GEabY=;
 b=E1kFefltLDZTyzpBPPnJtHqR7SmUMkRKusbQ++VGEA4f0UU82XtTH+Q+yJjd/JK68lNhSE5ctfFycMWGMdKpfOWaIGlUPwzGLAHukrGC07K8T4G25qM/td8/OJF4R6wXLTy0KUEU7Rw5Kgfy3ayO0Nm43nHAVPlSYRJePyDgqyQ+6nSzraGuTAyoFStSxjEAHYS2+2J4t2D5BOSU/i8B0OPDFoJVYZ1MO5O3NDsHQbvR+DOwww862GKnrKxKdbbqd9T3NK/9YnmNSBIC7KW1B/ay48I47dgtzrJeAw2OitaYJyj4COvn5Du9ie1XcBiA6gltZphDkSVhplXZ0YRSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 BL1PR11MB5239.namprd11.prod.outlook.com (2603:10b6:208:31a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.21; Mon, 23 Dec 2024 20:13:33 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 20:13:33 +0000
Message-ID: <c0a686f3-a155-47c9-a298-e5dd4097543d@intel.com>
Date: Mon, 23 Dec 2024 12:13:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/15] x86/cpu/intel: Replace early family 6 checks
 with VFM ones
To: Dave Hansen <dave.hansen@intel.com>, David Laight
	<david.laight.linux@gmail.com>
CC: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck
	<tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
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
 <20241220213711.1892696-9-sohil.mehta@intel.com>
 <20241221103528.2ca530a5@dsl-u17-10>
 <40538b12-5929-4f05-b65e-8b807057abd5@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <40538b12-5929-4f05-b65e-8b807057abd5@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:303:16d::10) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|BL1PR11MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d584665-9348-4d1a-e4d9-08dd238e465d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEczT2xVemhBVE9SV2sxRjJRUk1sTnJWWWZxVDNQUU1TdlF6TlM2MllEeFQv?=
 =?utf-8?B?L25NV0oxdHdxaktRak9JOHdRYUdNMWM2UXdUZ3g3Z2RNeVVoMHJyRDlVWUI1?=
 =?utf-8?B?a3hiYzk3QTZTeUl4UDFZRGlqT1JEYUpnWDhaMGlTeXBCbktITkEwc1hFYzJp?=
 =?utf-8?B?Mk1aZTNoejc3U2lsME5QaURNN0N6Qi9QbmsxVXp2VkpXQ3RqOVBqckNVMThZ?=
 =?utf-8?B?UVd4TlVVNXFwVVZsVUIydXk0bUN3aXRwVUlRTkxBZmpBVVNLQTVHMlJuMXo0?=
 =?utf-8?B?Y29adTVJZjZFSDFxRzJkdEpmVEZSeW1CK1NuUjF6MVl3SHJHclZBTjZZejhB?=
 =?utf-8?B?R0N0c2RIT1lwR2JvbWMzWGJPSGc2SCtSNm4yWEwzRlFRSkxYeERvOUt1T2tH?=
 =?utf-8?B?elpNejdTRk5xTlJpbDE0QTVaZ3JrZ1dHY20wUUQ2dTNGc0hHYk5YVjlOalFv?=
 =?utf-8?B?emI2T3Q3ZzJPY21PNU9tTUJZOWZ5M3NUWXFka0UwUkVLd1JUVjJRWTFBWjNj?=
 =?utf-8?B?QTNCWFVvVmx1eHpZYitKUDV4ZEVzS210Rlp1QzAyc3pHR3JWd2I4RkRnQ0pT?=
 =?utf-8?B?V2JoL1dHMlFHNGtta2hSd3NkVVlZVk9qaGY4Zjc4V0kwdnBhV3g3V0ZpdUUv?=
 =?utf-8?B?MnBQaWdvaGl0S3NRc3NjZWFpQWpORHVMUmZWV3BUVk9NbFU2NHV5SldnMkc3?=
 =?utf-8?B?MGJFRUV3QlFVcGdpQlNOMFNJUnc5bUpBamVCUC9HNmtNaG9nVjZnTVNrUGI2?=
 =?utf-8?B?cllJNGVkbmZJQUg3eW84ejkvclhpbTRDSXJQSXdxdTIydW9TVDVERnJZMjE4?=
 =?utf-8?B?VnRPZTh5ZUpLeFExSFl0U0dBaVBCN2F4eFUvMVBLWTRXek1IcU1rU3FBUjgv?=
 =?utf-8?B?YW1wTVMvVW1YSTdualE5eXY1aGprd1haSjBtK25LcEZHTHFIU0FoSHdLc3pk?=
 =?utf-8?B?aW5ob0RYZStYbVVmS2NRMkRFcWpDQzdZTUo4QzROdXJuVHpKdlllVkQvNHBu?=
 =?utf-8?B?L0lzb1ZHdkZrZXJmejB3ZlVyVWw5aW1tbUpkVWppN2s1THVtZ2p5SURhTW9p?=
 =?utf-8?B?a2xDbzErMGpsNUtINGJDSmpEbmZnMVRDNGNFUW9XSitMd1NpOEhRcDVkNlE0?=
 =?utf-8?B?ZHJ4TERDRWxNaTVKK2JPN2ZEa2E4bUZoNmwrR0FxVFRSN3h2VnkzbmIxS2ox?=
 =?utf-8?B?WTBPQXdwMVVvWGp2dDVwWVdMQnZYbUI2eWhCTGlpSjdTTlBzOHdST01icmhj?=
 =?utf-8?B?aklpTVVDOWZkTkRjT0QwclUyTG8wdnVRMlRIeUZiejAvTGtMMlJ4cDZKVW9N?=
 =?utf-8?B?aVhnazNIdjlRSlFLMUNGc2d1d1BlUU5EM2VFN3hOZ2Z1d2RzbENRZjNPdk10?=
 =?utf-8?B?NEpITStUSjVINy9XdWptQ29TeUVKbmRsSFdZY2FRK0o3WFFTK2tvdDljZWNk?=
 =?utf-8?B?aXFPNGhHZDh6dkJZeTF4OUJyRlhHUWFWNWRPZjVDTS9UYW9xcTZIb0FkUlpj?=
 =?utf-8?B?N1E0UzRrc2krNEI5Nk9ZRWFBTVc1ckdBTFQybXVMZzg1WlNkeHE4b0xVK0Qz?=
 =?utf-8?B?SEEyeFJ1STV0ZFgwcldJSC9yQTdQTlh5VHpSMGRFK1JqV3Nkc29nZ3VjaEY0?=
 =?utf-8?B?dHAxZzNJRVdvWkpLK0pLT2pwTmhwa2kyeWlKUUQwYnV4YlBuZjFNY3JHZEo1?=
 =?utf-8?B?VzBUOTgxeHVDWFJlUDhHaTBidzBaQmZyR1VLSUtnRjczYTJ4cGtDZCs4UFBq?=
 =?utf-8?B?SWhPVnhwT2xNaHRKMzBuNnpNQkFjRkNPN0x1RitxSWZmbi8rNDFhUFI2cGMw?=
 =?utf-8?B?dUR0eHNIbjQ5WUhTNVNyV3ZjU3JGVHk4M09CNXUvSlRTN3M2TjJ5NGJ5Uko0?=
 =?utf-8?Q?C/XzD1Aa3l4Wb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjVyRC9LTWVlM0k5bHhNQWp3Nlh5ekQvY0RaRnJEUC8vV2FtZmEvcVlrazlo?=
 =?utf-8?B?ckFVOG1ESlJUZlg5cG04K0VXQ3JTd3pyMXkyWTdWN2ZWVGhabmVVWTF2L1lp?=
 =?utf-8?B?WFpha1l4cVV4Skl5a1JvcXlsVWZiVE5wbEJJbnlGclFoeEVZT3BneFJjVStO?=
 =?utf-8?B?Wjh0dFJvQkFaUU1wWVpiYjFRLzV1UlFDcG9SZjNlTEZkWC9yWHVEUEtER0lN?=
 =?utf-8?B?Z0dYZ2dMbmR6c2RSZjdEQTJQRzU5NTV6b1lRVDdrSEFGd0FmQ2tEbDdNOXdV?=
 =?utf-8?B?VXpla2JYT3hjblY5WGd6ZmM4NEgwYU9vZFcxWmtFV2VMWHVzMUtnY3FOTldP?=
 =?utf-8?B?Uk5PQ0FqSUZ3cy9rQis1OThJWmppVjFzSHErM2dhMG9oTmFvU09SZVFVaGRi?=
 =?utf-8?B?ekIybjFCVzk5eThGdDRPU3kyUExqQ2dhNGtNNnR4Z0pJaXMxdXFieEUzVnVi?=
 =?utf-8?B?bUlKT3hqSEF5Ymw0Wml0S0Z3a1ZHVTdhamdhVkhSOXh0V0lMNjVaUFZHZFZX?=
 =?utf-8?B?MFIycVBPSEVQNjdNVkxxTGp6MVQ4SDI1eVhtd2RETXFpUjMwOHhLTzc2Rllp?=
 =?utf-8?B?d09WQzFUajVZY05lenNjWXNreGlTL1lHc25mQk9jOWp6QWRzSy9YN0Z4TlV6?=
 =?utf-8?B?ZHNSckdqTXBzc0tBZHAvZVlkc01KOUFWNDhzS3l2TmcvSXVYSy9mMXlSYlBG?=
 =?utf-8?B?M1lmaEpVQlVjem1MOGNObGRvVTNPamVEQ2JFWFhjVzd3TFV2YTRzd0J1Nkpw?=
 =?utf-8?B?dGpqNEFlTUJ2L29adFhJcWgwKzJreUJwbHNaNFkwOTBGcFhhOVRTaVcvKzds?=
 =?utf-8?B?QUN4QWdQdmRrSUhaQU9xaUViYjdmUmJZbU9NaTFLcDB2RGRHMEZHamJ4eExQ?=
 =?utf-8?B?TE43WTduYkdYTnUxQTZJcFpmVjZ3cDZRdU1qaTlOeHNvNk9ZWUdua1NjaXVw?=
 =?utf-8?B?RExpeWRaUVZsTlUwUUNXYW9tYjZHMFpmZjlRY2ovYU41UGhvS25ZKzdLOFhX?=
 =?utf-8?B?NmlnSUhuYjRpdDhReHZhN3FxRko1dmJqbEFzVExLVTdkU1NUejNOVzV3aVc0?=
 =?utf-8?B?WHJ3Tkp6VGVNTW50SnpYUittbGFDWlRwWVQ3SGZpUFByYUlIVFhwZWtOR0xl?=
 =?utf-8?B?VGduczNaTmt1Z29JMTlrSU5wZEZWdlcrNXpzc0lmUDd4ZVU4RFFXV3ZvOFQz?=
 =?utf-8?B?NmR4MFNiK3dkK1VZL0dRaGZtdG1waTJ2dzUzbkFERFI2a2crV1FGNEhnRmxJ?=
 =?utf-8?B?bjlYdmx2QVJKZjdQdnNVWlBhUUJ5MVV6MjYzekh5WWRiSkI0S3pZVlZOWkFI?=
 =?utf-8?B?ME5DWmhUQWQ1OFpyYm1FVS9KYk1tcUhRenc1RzBZbVRUMWVuQXdPWngwNjdH?=
 =?utf-8?B?UDREbmlBOFR3TytaakY2NkMrZE5rSXU1WTNmYmIrbGk1akd3R2hLUS9ML2hX?=
 =?utf-8?B?bzlOMkowVDdoOERCZGtsWENzYTVydjhFaGRKTEcwOU5WQlJHeWZmVmtCZ2VR?=
 =?utf-8?B?ekd5M3RPbnVENERSdFNEVXk3WVdkcnh6M2hzVlRXd0dNTDI5K0w3eFF6enkz?=
 =?utf-8?B?QmZhWUxPdk1XV1g1RG5uSVJ0TWE1MWZCaTJ1L3lLNmFBQnJPdTlnYVBMSmxL?=
 =?utf-8?B?cEdIejYySUY0aUV2bmJHTE9BcDdkZC8xeFVFUERsRHVvZGxtU0lDVGREOHJS?=
 =?utf-8?B?NU1STE5FUGYvWEZZS2YzQ0xyeW5nVWF1RFhjeUEvNnMvZy96Y0p5THZDUkUz?=
 =?utf-8?B?blFQdm00djZCVmdiazUzZllHUEM5R1hBL1ROd3Q5T3QxTUYxUVRhdWV0ME5R?=
 =?utf-8?B?OXZRa1FkSFI4akFJeWxXLzl2aTN4SDIrN2JCZTVYcDQ5aHpQc2pYQTF0eGZv?=
 =?utf-8?B?ajVHbGVWaHhlWTBIR0RMdDBMOEw1L0NlREY1K09CQ3B2VFpJNHNsTEdXSTVL?=
 =?utf-8?B?aFp4VXJYZ0RKOFgvQndDbGJtMDBhVzJ5ckFEQkUzODZ3Z284ank4VnVqcXlw?=
 =?utf-8?B?dStnZkRVVmhJNmZ2OEk1Z1dJK0psWTZjdHZObWhqayt5YnVYYWU0VFNldkY2?=
 =?utf-8?B?dk5iZEQ0WTFSY3QvQ1FsUjlDMU45d0FielU4Y0FIMlp4S2szK1ZMRWgzN0Zo?=
 =?utf-8?Q?58FmaQA9IPThq7VRNxUJWPkGf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d584665-9348-4d1a-e4d9-08dd238e465d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 20:13:33.1622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rB07zhzOWcEG0apu4Mw/jNWT3Qs3WXonhknrDb1cMjnIGn+LC03oAIz7l2LdOuUbJrXNqN5kRbehOe+ZQq0nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5239
X-OriginatorOrg: intel.com

On 12/21/2024 7:57 AM, Dave Hansen wrote:
>> Isn't the order 'funny' as well.
>> I think it ends up being neither numeric or date order.
>> Increasing family order is probably best, but the headings for each
>> 'family' probably need to be a bit more descriptive (esp 15 - all P4
>> netburst).
> 
> <shrug>
> 
> They're already out of order because Quark is a weirdo and we didn't
> want to look at it all the time so it got stuck at the bottom. It's
> _fine_ when it's 99% family 6 plus 2 other weirdos.
> 
> But it should probably get sorted at some point because it's going to be
> hard to find Quark and P4 if the order is
> 
> 	fam 6,1
> 	fam 5
> 	fam 15
> 	fam 18
> 	fam 19
> 	fam 20
> 	...
> 
> But I think all that has to be done is to move Quark up to the top.
> 

Patch 10/15 adds a few Family 5 defines. I'll move Family 5 to the top
along with that.

