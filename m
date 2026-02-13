Return-Path: <linux-acpi+bounces-20983-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K8UNBGyj2k4SwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20983-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 00:21:53 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4669A139F69
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 00:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36566301A7D3
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 23:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BA633C501;
	Fri, 13 Feb 2026 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J48FH0NF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8C33C53F;
	Fri, 13 Feb 2026 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771024910; cv=fail; b=Ag4Rbccb+4cZ0obj3cvYZ7tYj69gD1QBwbxFOLorVS2e4pN1IwM5gS3qGm5ahwPEbLixo33bITPJMWjKdFVGNzeKu8yyqACmkJcZ1Hlw5ECs8mygx8RmxeUa7vs4PRAeBRCqiurJmG7hf5wsXriOIRZZ6/Hh968hZ+k3rze9pSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771024910; c=relaxed/simple;
	bh=eAjYwyhMJonObA3v1yF/UeedPQuY1Z+ASSjZFP/9ZtI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nbbY+75xx0H4t3ktrGuTluu4i1g53x7WfO1lumS+muemAszyFxL/owNfMC3odx/zp/avqdhgGZiUOdfJHu+xTqIK7AxWcC2bmWnH2U76EZJtcxC3UtIQTODZhcxwkT6bjnMhtgRB4VjhVH4hsBfqazDJlkeH1MdgCu9d6ZPXmQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J48FH0NF; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771024908; x=1802560908;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eAjYwyhMJonObA3v1yF/UeedPQuY1Z+ASSjZFP/9ZtI=;
  b=J48FH0NFYJR1Kk8SHpyoODLUXHrbsJg4EGG6U4N0PEf1WJ2l5YK/zbXm
   zTfUdopcSRmrcPa4XzQTulbqPBxY45YWUyOOEnKK0j/l3ykLr1MSax4Mb
   /uqhnFXil8qcb3p+RssftgT8aVs/cFOlIuUYbNdaSODjJmtH7V0EwtZXv
   PN/YZmUqlJ6lYLhtsz53gmtBNwIez/YgquLb+TeyBb/9BgBVXn2Xn+2Oq
   y7OBov8zeEzSWpYjUOuGkJoUk8CIEUcIamoP1jN8DptCwSikMZ54PH66x
   a9y6CGZ+xZpYaAGNMzZFBJhxKm8kd7idxdCroxekxoaag/ZwQzhkvKDTh
   g==;
X-CSE-ConnectionGUID: 0hzoNwm0TB2lZzJQKUEECw==
X-CSE-MsgGUID: lGZJf+GyRnq5TJHnPv+Rpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="72257850"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="72257850"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 15:21:47 -0800
X-CSE-ConnectionGUID: L9jbL5WqQqqpdDYUrZQ7vA==
X-CSE-MsgGUID: Z7QAFx4ITPWBrOXRwGlAUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="212445715"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 15:21:46 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 15:21:46 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 15:21:46 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 15:21:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEgBq9Cl+Fp9Z70qef633IzuNuv506emnA+gdIVeV+G8TAg7mgd/8PKgm1pAr8Kp8uMfJbr2EKJ9PjLsFJrhSL7ENz+0eHN0XEY3+RmVHAiTx8i56WkASsbkRNH96ooaM961hqvcZm7uct5AWBIL9GxEMtRpSAiizCELmSmZOp+5+7AtKaHkALFoZjyLHwORGeSILI4Jn6REv5PFu3wksqQ/7dJOnaHw4iOYctwUVu6JAwGIQzyux75RWdNrun4KpngrSXARcznC6APCGkbjMYP8S/KgEPwFxbEyA1wOXDeegePqzU4O2xkBYmCdcbRDLxxt0m5VGcIHY44N4TQ/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6CcNkrDCHjI0D0+2UmPm9Npdsh9h18JWx/pYRxhZM0=;
 b=JV7ZOmJ3hE3iYLv10JjKDN9aHuN1UF/fdXruWAvbsFFf+eqLFDJxBx4A514Q+2VPaBha8WaD+SCSqE0F/7sqYLvE356w5XqF4Ah1nZrmAviQDlIAK7+p0cFTjz8Gfk+sGx4S50GIJ+xgHJblCNaFlvMhxeCrr1pXbbUXyB4O8pChAiXKvJxe5eGOaN8UdrACOo5kmNtvFDeiFx8JGBWzqA5ZgdMc0rm9h05dDMyDdcVCYwF6u2zY4oilEh3X84StHo4EOC0g6si5fUjT+XI8Oh0PpYwfZYqy3osxJdIFLWzuU01CkVXSyaTfogeUDuSwjrx1nlwR79JVmgcBPs13WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5001.namprd11.prod.outlook.com (2603:10b6:806:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 23:21:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%6]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 23:21:42 +0000
Message-ID: <01d57303-059d-4025-bb31-56d552a149e3@intel.com>
Date: Fri, 13 Feb 2026 15:21:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 07/17] RISC-V: QoS: define prototypes for resctrl
 interface
To: Drew Fustini <fustini@kernel.org>, Paul Walmsley <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
	<rkrcmar@ventanamicro.com>, Samuel Holland <samuel.holland@sifive.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>, Nicolas Pitre
	<npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
	Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra <atishp@rivosinc.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>,
	yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
	<guo.wenjia23@zte.com.cn>, <liu.qingtao2@zte.com.cn>, Tony Luck
	<tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, Peter Newman
	<peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, James Morse
	<james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, Dave Martin
	<Dave.Martin@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <x86@kernel.org>, Rob Herring
	<robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Sunil V L
	<sunilvl@ventanamicro.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <devicetree@vger.kernel.org>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-7-dca586b091b9@kernel.org>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20260128-ssqosid-cbqri-v2-7-dca586b091b9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:303:b4::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 7067c1e0-86db-47f7-9c96-08de6b56a591
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U05MQmJhby9QeDhXSExtdHBCdjRXdWlqaEtZVnNKYmtHWit2cm5GTUJaOXRs?=
 =?utf-8?B?aUdPZXc3S2d4Y3dOeElWcXVzc0pDS2lpQjVYNFBhSStjOWQ3b2VSMTh0dDFX?=
 =?utf-8?B?bG9pM1ZWekYwZG94V2VyWGJOUDVzc0Z6RGErc09Fc0hSanVwZDYxNmxmR0ln?=
 =?utf-8?B?emh0N04xSG03TS91a2NIQ1lTeC9CWDFJUTV2akZvcUhlckN2eW1Sb2g3R2FY?=
 =?utf-8?B?S0pxRXZHdVN2WUgwOGFQbm9wY3ZOZUY5MElHeHVocXUvMTZtL3NuUXZuMUpx?=
 =?utf-8?B?S3hiL0VmeXE1OWhxWXVtV0dYRDBId1RRSFl3RUJoZzFJeEJiY0UyUVREZDFS?=
 =?utf-8?B?RG40M2VKSUN5SWVYOGYrUFhETEJ2TzBvSkJVZEtnaXRTOVVpcUN3NEgwcGlI?=
 =?utf-8?B?NEdsUStTd011VDA4QVFCa2krWndzYXdkRisxcTN4NS84bnFldGFScDNPbGZ6?=
 =?utf-8?B?UGF6dEVQY0p4d1F1bENxMmZ4TXZscFhjZ3NpbFpsUjh2L3Z1bEFjR1FxZFox?=
 =?utf-8?B?TWlXb3VJV2lyRGdMU0Mrbm53eDlMaDIzcTRmMWpoUHR5TWZTWDkxYy9qUDZr?=
 =?utf-8?B?OGF3N3pOYkNUOFNBOThONmZNN2ZEM01tWGlWNTRwbnc1L1dYYzJsMFRZaFVy?=
 =?utf-8?B?WnJhbkNiME9teVIxdjZBc2p2TnFHQXNiS2drT2NGbm5uaEk3VUlHSm4vYW94?=
 =?utf-8?B?cm8razZGVUNadHM0TDNPdjlqNEk5TldYL1MvNlRpckZQZ1EzSjhMZjg1SnI0?=
 =?utf-8?B?eXNhTjRGTmhYNGxwYjRQZjR0cjhDc2EzekZIYnVOdkJRcUExQW14OEhwNjJj?=
 =?utf-8?B?S00xSld2R05La0gxbFVUSll3NHhqdEY0VGFrOWRFNk5tK0kyZmxGaXk0NzJv?=
 =?utf-8?B?Q2dtTUhkam10Y1BYc0w2ekxPSzIwZ0N1TWVCMjdIbnlXVEVZUkg4S1RQNnl6?=
 =?utf-8?B?NGFTKzRHSzFsVVRRTDErN0NnY2YwOTlOdWFaZnpKcnBNc1hBdFZIZlg2eGtF?=
 =?utf-8?B?M3ZOUW1LcHBwYWxMaUl6YWJzQTMwVThWWG1ROUkvcEVDZ2pVTmRiWUlLb0Iz?=
 =?utf-8?B?QTA5dDVZdzdLV25vOTVvZXk3RHptcEc5THlhbCt3azZSQjBMeTZFMC9LbEZX?=
 =?utf-8?B?ZHlUdGs2T091RnRQOW16dm54clJJd0NrdzNGWkxhcDJ5NlR4emVSOW5QMk9D?=
 =?utf-8?B?cU5tT3huT290WGJIT3BUTWo2eXBhSjdGYXJicU1hNVVzT2lDSDJVMjFLTFJW?=
 =?utf-8?B?eDFGM1ZjWXk2OUEwTWh5SkZTWGx5UHFRcm5wak01MWlXMk9td0xIR2VWUWJt?=
 =?utf-8?B?WnplbWRwMitpVGVZTEhpRlZBaU1CNGpYUXVTT1hrVldnTjI4U2xyQVpBZXF2?=
 =?utf-8?B?b2FDeHExOG9OTjF2TmlQYzlVOHRCSlgzTWJmbVU1cWZyaTNmQXFaYVJEOUEz?=
 =?utf-8?B?b3lwRitBaHV4Si93dUVCYXNDdExGQWdGTjZKUkdob0s1UW16cWFxeVRjUkdy?=
 =?utf-8?B?TW1HRG9JdUx4K2JXYTJHc1Zib3BMVGUwWXdJOVV6KzZObkExK3l2N0R2aHhJ?=
 =?utf-8?B?TDc1OGlSUTlzWWF0Z0o4NXZRZGZWMVpKczFTUDNIM2oxa1FzVlV5YVRvK1FR?=
 =?utf-8?B?Z1crZloyVlhXZmRPU3BwZmpiRlhSY2NsOC9pTTltWHRjRmtOV0xBQTRFNFhh?=
 =?utf-8?B?UzhJMitrYzcxYzNsQ2R2bUpmSVJMajJxQ1pDUkVyMzRTUU1FMDNmbjlabWgz?=
 =?utf-8?B?OWdkWDhFa0NRaWhQdGhIUHAxY1NNVHExcHp1WWwwTk1QaWlSUlYvc0lvR2dp?=
 =?utf-8?B?MFJ5NVhIYlUvU3VRL1pLYy8ydS9xVmU5a052R3BvRHJZc2tGWGpJam5qakRp?=
 =?utf-8?B?MmVtZGlVY1k1MXM0N292YXFiSk1VT0FuWksrSzNNSEJWVEtHQTFLNTN0NnFk?=
 =?utf-8?B?Zi8zRjhZelpPYW9zZ08vdklTdll5UWpHd1pVaXZFcTMrVkR3L2ErNmdoR2d5?=
 =?utf-8?B?RGJzUXpCeUh5TXp0OENCR3V0RGxGa1VMSkNkN1ZaQkRYamZuZm5SNzNVelhz?=
 =?utf-8?B?aWMwRHpYSUVtcnQ3U0FrWEkvSFpJRWZWUHBRNDRKQ09lMTBWeGtncFBrSXBz?=
 =?utf-8?B?M3pjdld2akZNVkcxdTZhQ29ycXNvU2I5VE1uRWovbGZtWnIwM05zV1I5clhJ?=
 =?utf-8?B?U3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGxLRkV2ZWduZ2RabXJubTljZThSQ0p1M3lBSXRTeWdKK0Q2RVpHSkVMTjUr?=
 =?utf-8?B?S2FKcFh6NW9lN0RlOS9jQm01NnpRNWRFRGgxNnN6L3BSNFVuZ25pS3RHek5G?=
 =?utf-8?B?WGhPaGVqZ0tCQS9QYTBPa0E1NjVFZEtEVDF2ZzdvMUFwUUpkaDJhY3dRMHNi?=
 =?utf-8?B?bUVBamM4dlQzNy9mdjRvRFVCSldmWjFOT1pYejlHdEhxaXhHaEtaNXpkajNh?=
 =?utf-8?B?RlJxL3k2QmpIaWRHeFh6YlR5T0w1TFZLSHg1TGFkcWhCZzQvNUkxMk11NG9W?=
 =?utf-8?B?MmlIM0VNSFc3ZTVoVU5rZndUZFVmTlBRY1dPYTZBTmFvUnRxZ3JScjlINzBP?=
 =?utf-8?B?UEp3Sm1PWk4wWVM1YUVRT0p2TEgxbFRQZnhUeWphbEZlMml6S3JCb2w2Tk1H?=
 =?utf-8?B?Vm9Oc0phSFBnc2FrQVdzV3FtS01LcHA5bnJVRHU0N0d5RWxET3FOMEZoVWI0?=
 =?utf-8?B?bzV1S3V4RGFJKytDWVcvaVpxYkVvdjRYRjFWVFlFRmZNdmdHYmFaWGMrWFZF?=
 =?utf-8?B?ekJ1Qi82UFd5MzVxRE42aEk5WU1ob0sxRGpJY3BLeE1EZE9ybUt3aGd5WTBh?=
 =?utf-8?B?N3p1MXRlQVAvankxWjVHTnJIRjZ2Zjd3VDU2dTNZd0laVi8wa0p2MWkyQXNO?=
 =?utf-8?B?SmlkbUdaYk1ZcHpIL0M0NHZEM2xMbXBOb1NNUEFrTFI3N1c0RUFWTGlocWcr?=
 =?utf-8?B?emVVQlBvNWN3eVdXNi96OStqQ3Mxc00yVS9XOU5WaVoyVnhoa2dGMERHNU1U?=
 =?utf-8?B?YkpxelFyY2ZIUWVoZkZvZm5NSzV4QmQyWHRsM2doU0RjMlo3WHBTbVM2d2NN?=
 =?utf-8?B?ekdmeThMUXdVSCtwOTJZU25zS3Roa3VmSVBQSjJ4ZzM1K2F4cHdjZTBhSjd1?=
 =?utf-8?B?U0hHd1NwSEl5VlFsU1dXYktScnRvYld0dDAzM1krTzhqZlRWRUlyM0FBMGN0?=
 =?utf-8?B?dGlCaHhrdDRuSWdndHYvVkhaOWpEMDZkM0JEYy9GTE13N1k1SkV5eEYwazRh?=
 =?utf-8?B?SDFmQzlqZzRWc2ZEdVNFbnFjbTY2UjM3a0Z6ZnhoN0JJRzhFT1pvUDdjSHNo?=
 =?utf-8?B?ZWZIeTd1VFluUFpxY1hWVVVNTll1ZlFpR2IxSHpxZjV0QVdUSnI2RnI3UEc3?=
 =?utf-8?B?YUhCQXZzcDM4UTZUQ05Ea0tpMVZvc0p2bUZwcVBwVFV2MnpZSEI1RXFMYnVh?=
 =?utf-8?B?SGhjTVd2NDBUb1Erc2JoUEpKdFhpTTJaZjBrTGU2QWxWc1MwdEYzL2RPd25n?=
 =?utf-8?B?S21hdmU4YmhCQlcwbEhUYkRsS2pucWRHeUQ5MzRIVTVmcnpPN3Y2bWNFaTl4?=
 =?utf-8?B?UUtUZ1h5Um5uL1NoS1BDRFczVlcwYWFxclNNVWt1elE3RmEzZHZ6QzdYSnNF?=
 =?utf-8?B?NTZUMm1TWFR2dkZ1NnhZb2NxVlowbzVINTNmTWJta2FtclNxdHViYXJTelBI?=
 =?utf-8?B?bzV6d051WGQzUXNWcDhEbEQyZmcxQlhPcWhVbTlJQzN2ZjVUWG5iTHI4ZHRI?=
 =?utf-8?B?NjZheGFLYkdmeW9PVk9tZGlUK2gwNUl2NGpJN2RxRWpSbWtHQ1h3OWd3eXY4?=
 =?utf-8?B?SmYzQU1udnZDUHZkdmZZZHFhVC9vYUtDNUUxcXhZVDdVUXhvNFNKS1NNN2pB?=
 =?utf-8?B?a1B0Z2VaaVQwYVVKcXUvNVNrb1VVTEJWYUFyN0N6N0FFeElkTG1RcU5KQ040?=
 =?utf-8?B?N1RTbk0rcDZWeWV6OE12MTVvbkx3eEF6dlAwWnFoYXhaaUJvbE5WcHIvLzY3?=
 =?utf-8?B?UEFGTjV5NWZKUWFFUmpGL1V6aDJ2MzZacldBclp4cCs5UGFNUjB1YXdTL1RI?=
 =?utf-8?B?Y1NGNEljeHRHcWFQVXZMZlpYVGRkbndQRXduNTc5R3ZtbzAySTJxV0pNTGl5?=
 =?utf-8?B?d2kwRlZDZnhQNis3SXJPaCt6dDd5K3pWdnFncGx5MlNvWFZnY0hFSjJhaU9l?=
 =?utf-8?B?TC9FWnl6bXZWWVlyMEg2Q29udnE0NWs0NmlWVlcrN1cxbU1LemFwamdINXFB?=
 =?utf-8?B?aFZVQTVodW04bmxidSt5SEFLbm9iTkpObG5ncjE5clhjajNKVzcvaWEyRXBR?=
 =?utf-8?B?QzlDN2plUDllbVVzSFdWakQwYVNodFhuSWtOZjJhVDJLT2NzeXBmR3NMSXBT?=
 =?utf-8?B?SlYrZ0trR3FzRlVGN1hFNlU0TXhGdmdjZ1BQY25lck54eVl5L0dYWDJHOEdC?=
 =?utf-8?B?SzE3L2NtbDRDdnhHUWVsRS95SHlERTVrOTQ3cDh1V3FVdFZtM0ZQTkNxWDZ2?=
 =?utf-8?B?V1pYZll2NW42bUg1ZFVpMXZyc0V1UG5wYWxabTUwNFVseE9ZU1JEc0tRQzJT?=
 =?utf-8?B?OTR4YWxNM2hEc3lXWER3OTZINFROQ1pxamVaYjNyb25NdFpXcnFnNy9SblZi?=
 =?utf-8?Q?4TBcL6crj7Q2ALcQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7067c1e0-86db-47f7-9c96-08de6b56a591
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 23:21:42.3690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eyjy9itVtTuREh+C3/g71AcOurNH4V3BkdRJoWVkfzaHaqgrbhm7I3Ze2YplTPimNF1vIGYgwQM7gIcuB0h3V1ESeB0B+2zDgJbCxumuHp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5001
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20983-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,bytedance.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[reinette.chatre@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4669A139F69
X-Rspamd-Action: no action

Hi Drew,

On 1/28/26 12:27 PM, Drew Fustini wrote:
> Define the prototypes for the resctrl interface functions that are
> implemented on RISC-V.
> 
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> [fustini: rebased on current upstream]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  include/linux/riscv_qos.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/include/linux/riscv_qos.h b/include/linux/riscv_qos.h
> index 51c3a96bbcd0..0c551ed85fe1 100644
> --- a/include/linux/riscv_qos.h
> +++ b/include/linux/riscv_qos.h
> @@ -3,6 +3,7 @@
>  #ifndef __LINUX_RISCV_QOS_H
>  #define __LINUX_RISCV_QOS_H
>  
> +#include <linux/resctrl_types.h>
>  #include <linux/iommu.h>
>  #include <linux/types.h>
>  
> @@ -31,4 +32,47 @@ struct cbqri_controller_info {
>  
>  extern struct list_head cbqri_controllers;
>  
> +bool resctrl_arch_alloc_capable(void);
> +bool resctrl_arch_mon_capable(void);
> +bool resctrl_arch_is_llc_occupancy_enabled(void);
> +bool resctrl_arch_is_mbm_local_enabled(void);
> +bool resctrl_arch_is_mbm_total_enabled(void);

These individual event checks are no longer needed. Please refer to commit
d257cc2e5c8b ("x86,fs/resctrl: Replace architecture event enabled checks")
that can be found in your base commit. 

> +
> +struct rdt_resource;
> +/*
> + * Note about terminology between x86 (Intel RDT/AMD QoS) and RISC-V:
> + *   CLOSID on x86 is RCID on RISC-V
> + *     RMID on x86 is MCID on RISC-V
> + *      CDP on x86 is AT (access type) on RISC-V
> + */
> +u32  resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid);
> +void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid);
> +void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 pmg);

nit: the x86 and RISC-V terms are already plenty. It should not be necessary to add
MPAM terms (pmg) to the mix?

> +void resctrl_arch_sched_in(struct task_struct *tsk);
> +void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u32 rmid);
> +bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid);
> +bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rmid);
> +void resctrl_arch_reset_resources(void);

hmmm ... the baseline of this work is v6.19-rc4 that contains the resctrl fs/arch
split. resctrl_arch_reset_resources() seems to be based on some earlier version of
the split work that did not make it upstream.

> +void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, enum resctrl_event_id evtid);
> +void resctrl_arch_mon_ctx_free(struct rdt_resource *r, enum resctrl_event_id evtid,
> +			       void *arch_mon_ctx);
> +struct rdt_domain_hdr *resctrl_arch_find_domain(struct list_head *domain_list, int id);

resctrl_arch_find_domain() does not exist in resctrl. Would resctrl's resctrl_find_domain()
suffice?

> +
> +static inline bool resctrl_arch_event_is_free_running(enum resctrl_event_id evt)

resctrl_arch_event_is_free_running() also does not exist in resctrl.

> +{
> +	/* must be true for resctrl L3 monitoring files to be created */
> +	return true;
> +}
> +
> +static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
> +{
> +	return val;
> +}
> +
> +/* Not needed for RISC-V */
> +static inline void resctrl_arch_enable_mon(void) { }
> +static inline void resctrl_arch_disable_mon(void) { }
> +static inline void resctrl_arch_enable_alloc(void) { }
> +static inline void resctrl_arch_disable_alloc(void) { }
> +
>  #endif /* __LINUX_RISCV_QOS_H */
> 

Reinette

