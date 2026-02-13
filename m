Return-Path: <linux-acpi+bounces-20984-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBfhFDW0j2l8SwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20984-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 00:31:01 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9156139FD5
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 00:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12F783007487
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 23:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19EC2F9985;
	Fri, 13 Feb 2026 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bREg94WV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47925F4F1;
	Fri, 13 Feb 2026 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771025458; cv=fail; b=K+I8tO52dBqWRVD7eVnn7Z2EPBkP/nhHkBL4b81LxVf8DNZLjIfjMtVTY8Vs8hIEzlMCBzPSkhH73aDrrF/DIJKf8KYgIO3as0YM6faEgaaOuGGXxwU7K6JsVLYyTdAeGIu8qUF9l+xIFbAuGUIq+d9Lz0FD+TEMRANl1r0qt5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771025458; c=relaxed/simple;
	bh=qM7TkH4DZ+k6KJylb0ULwhQcLKQDxexksHWWCjEUEUo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QLsxP/D9kqH4HcF6ut+zutzAgF4n4ySatwLCtVhOtXy9TFqZwYeAKaLz5Qqkv8VKoJs/HQouvWM2msGADARuZt15jXdHdI8m2RaDSANHPhFx4phPAvD7vRxP95H/03URRS71tNfUPYiTe3CAtNdtsHUOsYmjoAxV7sI1JdX7+2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bREg94WV; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771025456; x=1802561456;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qM7TkH4DZ+k6KJylb0ULwhQcLKQDxexksHWWCjEUEUo=;
  b=bREg94WVeTdJNFVpLjnogpbaFNGRerrqi/BFqAS5/qGMuPpwRex/7R2D
   HzHmWZR3txtL7ee+TvPKdq8C6rbhi6hQ3uF2PWkSoXFQ101r6qenC8xNo
   kN9Y2YcHj62tC9HtsEAwrCva37AzZ3Y7DyzULMtiQ7SeLYpPHrIA6500q
   JwveOdgq8oee6TCF8IsCn9ZNmUmhUSNC2rKbUDAfhdQvNU4mSQ8SCxMOw
   51aCrcOSKcNQISH7zeMWGGGUrPWC8BuVVF7AhNjh99pW8r8SdjkakGBZN
   PhoRUj1MMGA9A4QwgBUHXuglzZhV8tnrlCWw7ojVT29uP9VOclWmzjr4i
   A==;
X-CSE-ConnectionGUID: GM4ijVjESvGroyxtEVngjg==
X-CSE-MsgGUID: EpiIGnVnSwWNEnRoUCQqRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="72283888"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="72283888"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 15:30:55 -0800
X-CSE-ConnectionGUID: IYkj12jTRUeZWMEOcOmYKg==
X-CSE-MsgGUID: tLxDmhIpQK6debMHZGwDFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="213156005"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 15:30:53 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 15:30:51 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 15:30:51 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 15:30:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQWuzHIuhQDNArvGdG/mJJMBQroa41RM7Um4U7JI5qvHQJEbIJmPxrlr06k4ggzOM8BMmKebuvWPWmBjKo1SzZeEN3LGiCtC5uLDj0vAy8TUiOhdXYart6JQlhjE6x2GiDqCRiPGxqf7Czq8UvIPmszfhmOG/Ouvkzzas6mnWTdaFMcnt9VmWpKc5+WBk8sOQsdN5SD3oYnrXaoB53w5OTGpculQz+Pmt5M7s34gHHyPEQPHOiybXIpKtjH02coohlsiVMUKKRcafAhlm/jyV6Y5ehmn6HYB76t31HTRISKiJX41bBm0oIrf2lt4q6uGiFJ6ExaHVUtUbd/NxVRLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rh7bzUYwUOAw4yd/sfVlJxRfg2+vyh2hUZuxcfG1CYM=;
 b=xWFOu2hZNlZ0EQx37mwrNbqCNRLIE7bNanN0bwpJZcHK9yFib1gnKSqEM0QAzSevxRn+DpNWIl8fx7s+ca6qVh+OFVjloBZr7Nn9ogfVhqQfHORA4VdgzxZa6Ff8yAl+IblxRRa/6XOFRaQuXSM9rrNtZfEtqps/qf9/jY7IvjnH5SkIsUFczFoQJ7La/f3Vae/J5guADOED+Jc39b9n8Q5G8+6M9J755UFXuoRC2prwB0imAa/YVzCuratBS53YE0R4v6652c8tLGt0kDCYt02BxVDwvSpuB6TSZgtp3gd+HUjb7BN82mymIkHR29+Hs7MkLSb2mzkzVAUZ4zLRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6519.namprd11.prod.outlook.com (2603:10b6:8:d1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.14; Fri, 13 Feb 2026 23:30:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%6]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 23:30:47 +0000
Message-ID: <7e35f79c-df56-4cab-9a8b-1a9ffbca053a@intel.com>
Date: Fri, 13 Feb 2026 15:30:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 08/17] RISC-V: QoS: add resctrl interface for CBQRI
 controllers
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
	<peternewman@google.com>, James Morse <james.morse@arm.com>, Ben Horgan
	<ben.horgan@arm.com>, Dave Martin <Dave.Martin@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<x86@kernel.org>, Rob Herring <robh@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore
	<robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <devicetree@vger.kernel.org>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6519:EE_
X-MS-Office365-Filtering-Correlation-Id: b734092c-1223-4857-bee0-08de6b57ea7d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0dJeWtpeWlIL2FtdlVkL3RmWDU0ZXgxdk91c1FvYlJuYTV4ak1NTG5lQTFv?=
 =?utf-8?B?UnBWM3A1MVRjakVldjVIU1MvZTNWY2RwajNQSEl6Wld5anV5TU1aN3E3a0RZ?=
 =?utf-8?B?QllGelNxZjlYdE5WY2gyOE5LSmtOMUdZbXc3VnB5Y0FpZWF1bnNBL0w1UVhS?=
 =?utf-8?B?OHJpQ21kd0FLREJKSEdVcVhiUi9KN2JCRXNTcUlmYTRpYXAxQzNwWjBlRHhS?=
 =?utf-8?B?Qnp0anE3NmhYK3Q1c0I3TlpDV0FJTVZyclkxdWFKaHlydkVNMjgxV3krT1ZQ?=
 =?utf-8?B?c1M4UkovRkEyLzhBbEpXN0loeGREZmV5VTZuM3QxVkhhMnZqenhMQXdPZld2?=
 =?utf-8?B?dEVVN2VqZkc5TndBNUgxSEpJVSs0S3F0aXNsbnd1citSSFFVbmRsbGpwZys3?=
 =?utf-8?B?T0tMS3VhekpCYS96dEpkQ0ZSMWF3aHpaVU5YYlR4dDZWcVNzOXZLdmw0YjJS?=
 =?utf-8?B?REhVNGh3b2MrWmZuRU5jSitMUW1yZE52cnU4WEJtSWhsVUMxS2YvUmNkeHpp?=
 =?utf-8?B?WXBjVVdJc1Y2R0tZM0NwZndaeTlDeDdrT2NUYWZEdWhOL1RNVWI2Y29ZQ1JE?=
 =?utf-8?B?elVDTnlHVE1qcXhJbkNpMlNVUUwycFdBSDhhZ0ovMDJPajNBdTRVNjdRblZ5?=
 =?utf-8?B?Z2dtdWZ6YiswdlBYallLaDFVdVQ3eEtWc3dnZnBId2t3TlM1UTlicjB1dDJ5?=
 =?utf-8?B?aGtzVkZnNDdXY1VDc3NjSFF4NDEvV1ppdUhHeXMreWFwWXFzakJoUUs5Rzda?=
 =?utf-8?B?VXFYUzZRcEFPRzB4c0l3dFkzUGdSWUVaQzBVMXlUbktZeG9USmxKZXdJL0RD?=
 =?utf-8?B?bml6L2xra3g4ZXZhY2ZpTEdUUkpEMVJBdHM5S1RLL1d4aXBRQWUxSFgwMENY?=
 =?utf-8?B?VHlJTDNOYVpWTk1oNW9iNWE1S1hramVaQnRSNDNJNGNMYXRUSWNMSkNuWGFi?=
 =?utf-8?B?SlB0MnMzbU9SbmdZWVFsbEVLTlJMbXh4ZDJBSmpYRnE3ajlxbldPZlRralVj?=
 =?utf-8?B?aGh5QXdUejBNUmc3T2RRNkUydndtZkEzR1lRR015STdQVVF5SDBLN2RIS0cv?=
 =?utf-8?B?eW9tOXVUMmVOMWE5bldoekZLWnRFNUpuUHIwdDlYajZYV1Q3dXpQQXNjREVm?=
 =?utf-8?B?ZTFOSEs0Rm9Yd3loV0pURXZESHFKdEhXYmNLVmxNSEJGTzhkQys5VVVqTHpW?=
 =?utf-8?B?eC9saDI0VVJ0Vm9Ybk1uVUN0R3haWmVyYkE1dHFjcDlaNWh4NEJ4cHFVT0Vs?=
 =?utf-8?B?aFRuQjJVaXBYNFlyQ0NBUitqVVdBcTEvUWtyR0VZb0FMRzYxSnhKdjMzYkhs?=
 =?utf-8?B?OTJ3RUFJN3pCU012RDRoR3hlajJtTXN2M3kzMCtXV25Wa3NETzF1eTRYV3VG?=
 =?utf-8?B?S0pCWjdnOXB6dmxNVEFmSHpIRzR4SURYT1JWVlNQWHB2aVNlcTI0SzBySGQv?=
 =?utf-8?B?WWJ0d0dEL28xa01xbTYrd2xIMXNoUTZSQ0dBcUFUeWp4a1cxakZUUEdsK3lL?=
 =?utf-8?B?K0lrWi9VS0RKYlh3UE1pNlMwWk9xM1lzOWo5a1IzeWM0TW1xVDhUWDM3K2FX?=
 =?utf-8?B?cUZPR3dheWxyVEcxN1ByZnhNMk5qdzhvS1NDWUNhR21XQW5xK3BYd1Q5bmVT?=
 =?utf-8?B?RmQwaHY1U0U1bGpZbFpsTCszcExkVFJOWjNIem05Z2RrK2VxM2xOaGhwcmhP?=
 =?utf-8?B?RE11Y294N2dFRno4eEdjNW5YWkdtOXJyNDMwQmV5Q25kcyt2YmpHek9WeXMx?=
 =?utf-8?B?ZlRNVnc1clJXajVYUHd0QU9jaGMxY3U0em1CWDV0S2ZmdVlVVDV5cGk1NDI3?=
 =?utf-8?B?eEk5MXFYMFNSTEVLRDI1dGJJektMYnVFUmh1ZitNb1dhVGhBMXppaFBQR054?=
 =?utf-8?B?am8rK3h2Y1dhcm1MOVpaS05RaGNnY3A0M3ZGak96ckNrTTFSZTA1ZEtCYVJP?=
 =?utf-8?B?dWhvNldJR1VYY0VwZ2xsaTRzenlkTThMbXJvclpBN21TYkw3MDBIWm1peTNP?=
 =?utf-8?B?RkxBSGpsdVMvazM0cGtqNUN0b1Jld2p4VVJ3SmRaOXY3QUZnQ1JMSUxqaERJ?=
 =?utf-8?B?anBJbUtWRDdjQWd5S2tLZVBuT0hPWkdHVlhTNjMrTTBQU05Oek56cG9NeThj?=
 =?utf-8?B?MkFCUzlmSFQ4cndLSXhIa1hRdHRCMFZjd0pycUIxOHBZMGJVRmVEc0IyVVNa?=
 =?utf-8?B?TGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qjh4ckNwb1c3KzBBUGdZNURTOEhvTVVoU2VxNWMzV25ESTkxMkJ2UW5sc2hC?=
 =?utf-8?B?bTVqc1QzUkkrN2ZxR29nNUVJdlpSQWpLSmp1ZUltZEdpYXR6aTRQNUkva09u?=
 =?utf-8?B?Ylk5eTNFdXRuaG9nbGM2Q05TMnlVNm16Q0VSWmFMaFdwUmtrYWFlSVU0d0dZ?=
 =?utf-8?B?MnFuWWVRbkN2WXp4V3VzK3NwS094bkhjV0pqbW9mdmVXV2ErRWoxY2dpcGRj?=
 =?utf-8?B?SUxFMlZiRmtrb2laVm9aazNla042cUhmc1FnOTVKcWNIT29KWEZXdkdtTDhQ?=
 =?utf-8?B?YVNZRWFZWDNRVFNMQWc3NFdIazVNbTlOVDhOZzV4eGhxcUx1MndZYTF4S1N3?=
 =?utf-8?B?MDRuTUpac0tqU1VEVWg5ZXZXU25Oc3NaaDZxcnpBemRwYjhGY0IzSU5HTEps?=
 =?utf-8?B?cEQ5RmhzcklxeXROdjA5NlMyYlJ0Wkx6TUFJdy9zc0cybVNBcUtqaWgwb1Iw?=
 =?utf-8?B?L2JVeUZva0tFTm1pT0twQ1M2bU1BVzNpaGNOVTlHMDRkM25rZlJzZ2xTS29o?=
 =?utf-8?B?Smx5ZElhcGNzeU84NlpHWVdOUGZUSzVrT2hLWG1PR1k1R01Na25mQkgxMjQ1?=
 =?utf-8?B?czhPQXY1Q2hoNGN3akFrNTFrYzIzWDFoUkQ2TVVyaUhlQVBQYkJnOGJKdmp3?=
 =?utf-8?B?d3d0dytpcDd5aVJ5TTVrejJzZjUxd1NobGhaUEx4MFkyNDhOUjVXTzlZTDAy?=
 =?utf-8?B?ci92WVFjQ0ZlZXdyeFJqdElZUU0zOHBKZDdOR0N0R04xNDVZM2hEQnhsams5?=
 =?utf-8?B?YzNrVndTWFZta3RpeVNTdkFlbUk2cENHUnpIUFJQNUU4MDkzazJBL3VXb0Vk?=
 =?utf-8?B?WFh5OWZmejBnQVpYb2tRaVZKdFZvd3JmM3RsSmF5MHU2bnVzMkdLb0J3RTh3?=
 =?utf-8?B?YTIwckxoWldmVFlHQUdZTWxSN0lhdWwveW1DRVQ3SGhDemxxNTBtN3dxaE9B?=
 =?utf-8?B?aUJIWUpOWVZDWitHS0Y2MTk3TERxNGR2b2NHMlIrM3dQU2ZBRFVwcC9LNGps?=
 =?utf-8?B?ZHlNSXFKZE5kV2lNRkZDV1R2ZmVzWUd5eFpBeGRuR1ZSMU52K1Z5ZjZyeVdE?=
 =?utf-8?B?V2dBcWpGMGQ3WndEWWFXZThDRzljNGVWdy9lYTJGT1FmYnFFSklubG9zVVgy?=
 =?utf-8?B?T1NOdHZ3VXp2TEZUamxUcFJ5SXNORG1YY2Jzc2l1R1ZxTmJ3R3ZXdzUxTHJk?=
 =?utf-8?B?NUFrTEJFTEM3S0c0Y251R28wNk1Kdk1SYTdQekhDTk1WRTZvRjZNUlZwcVpj?=
 =?utf-8?B?UFVMMEUxYnMzazRYOENON3N4eGd6amJPOTRDcmZoZzd0Vkl0UVNSRE9iOW8w?=
 =?utf-8?B?bS8vTlUwNWZQeFdZaU1XT21SUGRiVDMwaW1oUThXQkRDbHE5NnBKK0E4em52?=
 =?utf-8?B?OW12ZTA3Z0QwV0lZSFBmdHNaTUNnMDZuTDJ2MTJCdTF4MklFMmJZY1B5aEs3?=
 =?utf-8?B?N2pML1RLRVU5TklNaGF2NnJTd29TcFljQU9wcGFSS0hjNlZIeUx2dG9xZk8v?=
 =?utf-8?B?RmkzQ01YYjRXRVEyVnNqSkxGYnl4Q01zbmQxQkxKRG50ajErR1l1ZFVja09o?=
 =?utf-8?B?NjdwL012YzhMSGVJTi81M2theUxxbVRHY0VneWZIZ2UwUVkrSldiakF6cnVo?=
 =?utf-8?B?Ly9jMmZkZ3M1R0pFUzQ1SmRXb1RMZVNlQ2ZSNXdsWWpMTEQ4emhtZUFGeXJR?=
 =?utf-8?B?bitxQS9TQlZOcnNCeEovcUowUVh1T3o3Sjl1akswOWxXTkFPeVpDcGZjWHhV?=
 =?utf-8?B?YUtzTHBmY3NxSmpOcGVFR2Nub2dMUDRYZWU2am5CNnJ0VXZLL1ViYXFabTEy?=
 =?utf-8?B?NC9xMHNsSTFUaVh0bEx0UklkUm9aMjVBMHd6WFlnRXBrbDcwMksrakpsNkNL?=
 =?utf-8?B?dUdVVE44NUUrc0hMNXJHYTllL2o5OTBYZE1VQnhHWGNzejhzeHAybWhXd0Zy?=
 =?utf-8?B?d3RIcm9KUFBkWVlSNG9xaVpLU2VGTC9Cd2E5aWliUXZVZzNJNlZTS1NKRXA5?=
 =?utf-8?B?ZXMrcHNtZGRoUGtUVy8wbER5MUdZc3JQSEFnbm1zS2pzZXUvRVVzS2kxZndQ?=
 =?utf-8?B?VVBEelBhR3lJaVJ5RGRROE1jbFdKRnVFZTZleWdEQUUrVHpLRS96NmRMMVA2?=
 =?utf-8?B?ZkJuODJidUs2cnJ0QUh3b1k3Q2pwTEpHbmhybFpsU2ZXdURxaEtnMFc3R0lv?=
 =?utf-8?B?eGhvVTlhak9NdnBNdFVkUFZ2b0o0bytqK1B3K01PeGZ1QUlVSWo4Y3NRK2cy?=
 =?utf-8?B?VGRycGxvS3VYeVJ1Q0RDZ3JLTzhQNi95WmVNUjE5OUlhWVhobDJhek5vSkoy?=
 =?utf-8?B?QmlrQ2dpcCtuR1NXSEx2TTZCVWZ4aTZyaDZrUmNHMUx2RXoxVGQ2WCtmMjJS?=
 =?utf-8?Q?pPluC5cyp6LtTwGE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b734092c-1223-4857-bee0-08de6b57ea7d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 23:30:47.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pr4MVnAkcLlNeHSQ+LQbpNoiSrJFadfzSNk2kNLBxFZRmegGzDLhKDeiyo+XqlLtUaNYFbjshb5pig/AJpvZG318S8WT8w0MqDTdH6MoFUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6519
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20984-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,bytedance.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[reinette.chatre@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E9156139FD5
X-Rspamd-Action: no action

Hi Drew,

On 1/28/26 12:27 PM, Drew Fustini wrote:

...

> +
> +struct rdt_domain_hdr *resctrl_arch_find_domain(struct list_head *domain_list, int id)
> +{
> +	struct rdt_domain_hdr *hdr;
> +
> +	lockdep_assert_cpus_held();
> +
> +	list_for_each_entry(hdr, domain_list, list) {
> +		if (hdr->id == id)
> +			return hdr;
> +	}
> +
> +	return NULL;
> +}

This indeed looks like a duplicate of resctrl_find_domain(). From what I can tell it
is not used in this series nor is it an arch call called by resctrl fs so can be dropped?


> +
> +void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
> +{
> +	*closid = ((u32)~0); /* refer to X86_RESCTRL_BAD_CLOSID */

The name is actually X86_RESCTRL_EMPTY_CLOSID - and if RISC-V also needs it we could
make it generally available.

> +	*rmid = idx;
> +}
> +
> +/* RISC-V resctrl interface does not maintain a default srmcfg value for a given CPU */

This means that when user space uses resctrl fs to assign a CPU to a resource group and
then run a task belonging to the default resource group on that CPU then the task will not
obtain the allocations that user assigned to that resource group. Here is what the resctrl
docs currently contain wrt "Resource allocation rules"

	Resource allocation rules                                                       
	-------------------------                                                       
                                                                                
	When a task is running the following rules define which resources are           
	available to it:                                                                
                                                                                
	1) If the task is a member of a non-default group, then the schemata            
	   for that group is used.                                                      
                                                                                
	2) Else if the task belongs to the default group, but is running on a           
	   CPU that is assigned to some specific group, then the schemata for the       
	   CPU's group is used.                                                         
                                                                                
	3) Otherwise the schemata for the default group is used.         

If I understand correctly RISC-V thus does not support CPU assignment but user space cannot
tell. That is, user may write to the cpus/cpus_list file and resctrl will show that it
succeeds and actually display the new cpumask but underneath it all the actual allocations will
not reflect that?

> +void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 rmid) { }
> +
> +void resctrl_arch_sched_in(struct task_struct *tsk)
> +{
> +	__switch_to_srmcfg(tsk);
> +}
> +
> +void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
> +{
> +	u32 srmcfg;
> +
> +	WARN_ON_ONCE((closid & SRMCFG_RCID_MASK) != closid);
> +	WARN_ON_ONCE((rmid & SRMCFG_MCID_MASK) != rmid);
> +
> +	srmcfg = rmid << SRMCFG_MCID_SHIFT;
> +	srmcfg |= closid;
> +	WRITE_ONCE(tsk->thread.srmcfg, srmcfg);
> +}
> +
> +void resctrl_arch_sync_cpu_closid_rmid(void *info)
> +{
> +	struct resctrl_cpu_defaults *r = info;
> +
> +	lockdep_assert_preemption_disabled();
> +
> +	if (r) {
> +		resctrl_arch_set_cpu_default_closid_rmid(smp_processor_id(),
> +							 r->closid, r->rmid);

This just calls the empty function above?

> +	}
> +
> +	resctrl_arch_sched_in(current);
> +}
> +
> +bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid)
> +{
> +	u32 srmcfg;
> +	bool match;
> +
> +	srmcfg = READ_ONCE(tsk->thread.srmcfg);
> +	match = (srmcfg & SRMCFG_RCID_MASK) == closid;
> +	return match;
> +}
> +
> +bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
> +{
> +	u32 tsk_rmid;
> +
> +	tsk_rmid = READ_ONCE(tsk->thread.srmcfg);
> +	tsk_rmid >>= SRMCFG_MCID_SHIFT;
> +	tsk_rmid &= SRMCFG_MCID_MASK;
> +
> +	return tsk_rmid == rmid;
> +}
> +
> +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
> +			   u64 *val, void *arch_mon_ctx)
> +{
> +	/*
> +	 * The current Qemu implementation of CBQRI capacity and bandwidth
> +	 * controllers do not emulate the utilization of resources over
> +	 * time. Therefore, Qemu currently sets the invalid bit in
> +	 * cc_mon_ctr_val and bc_mon_ctr_val, and there is no meaningful
> +	 * value other than 0 to return for reading an RMID (e.g. MCID in
> +	 * CBQRI terminology)
> +	 */
> +
> +	return 0;
> +}
> +
> +void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			     u32 closid, u32 rmid, enum resctrl_event_id eventid)
> +{
> +	/* not implemented for the RISC-V resctrl interface */
> +}
> +
> +void resctrl_arch_mon_event_config_read(void *info)
> +{
> +	/* not implemented for the RISC-V resctrl interface */
> +}
> +
> +void resctrl_arch_mon_event_config_write(void *info)
> +{
> +	/* not implemented for the RISC-V resctrl interface */
> +}
> +
> +void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d)
> +{
> +	/* not implemented for the RISC-V resctrl implementation */
> +}
> +
> +void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
> +{
> +	/* not implemented for the RISC-V resctrl implementation */
> +}
> +
> +/* Set capacity block mask (cc_block_mask) */
> +static void cbqri_set_cbm(struct cbqri_controller *ctrl, u64 cbm)
> +{
> +	int reg_offset;
> +	u64 reg;
> +
> +	reg_offset = CBQRI_CC_BLOCK_MASK_OFF;
> +	reg = ioread64(ctrl->base + reg_offset);
> +
> +	reg = cbm;
> +	iowrite64(reg, ctrl->base + reg_offset);

This just writes the new 64bit value without any modifications. Is it necessary to
read it first?

> +}

...

> +static int cbqri_apply_cache_config(struct cbqri_resctrl_dom *hw_dom, u32 closid,
> +				    enum resctrl_conf_type type, struct cbqri_config *cfg)
> +{
> +	struct cbqri_controller *ctrl = hw_dom->hw_ctrl;
> +	int reg_offset;
> +	int err = 0;
> +	u64 reg;
> +
> +	if (cfg->cbm != hw_dom->ctrl_val[closid]) {
> +		/* Store the new cbm in the ctrl_val array for this closid in this domain */
> +		hw_dom->ctrl_val[closid] = cfg->cbm;

How this hw_dom->ctrl_val[] is used is not clear ... it almost seems unnecessary? It seems to
resemble the x86 rdt_hw_ctrl_domain::ctrl_val that essentially contains a copy of the values
set on hardware but its use during config read and write does not reflect that.

In cbqri_apply_cache_config() hw_dom->ctrl_val[closid] is set before any attempt is made to
write it to hardware and below it is clear that code doing the writing may fail. Does this mean
that the driver may think that it set the control value correctly (because it will not retry
based on the  cfg->cbm != hw_dom->ctrl_val[closid] check) but that is actually not the case?

Jumping ahead to the partner code in resctrl_arch_get_config() that reads the current
configuration value it is unexpected that the implementation refers to the hardware and
not hw_dom->ctrl_val[closid] ... but actually sets hw_dom->ctrl_val[closid] there also
to reflect the hardware when the configuration is *read*?

As I understand there can be two possibilities, either cache the hardware value or don't:
One possibility could thus be to move hw_dom->ctrl_val[closid] assignment in this function to
be after hardware is configured so that it reflects accurate state and then resctrl_arch_get_config()
could just get the value from it instead of hardware.
Another possibility may be to drop hw_dom->ctrl_val[] entirely and just read from/write to
hardware every time, something that is much cheaper to do with this design that does not require IPIs.

This implementation seems to be a bit of both?

> +
> +		/* Set capacity block mask (cc_block_mask) */
> +		cbqri_set_cbm(ctrl, cfg->cbm);
> +
> +		/* Capacity config limit operation */
> +		err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT, closid, type);
> +		if (err < 0) {
> +			pr_err("%s(): operation failed: err = %d", __func__, err);
> +			return err;
> +		}
> +
> +		/* Clear cc_block_mask before read limit to verify op works*/
> +		cbqri_set_cbm(ctrl, 0);
> +
> +		/* Performa capacity read limit operation to verify blockmask */
> +		err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, closid, type);
> +		if (err < 0) {
> +			pr_err("%s(): operation failed: err = %d", __func__, err);
> +			return err;
> +		}
> +
> +		/* Read capacity blockmask to verify it matches the requested config */
> +		reg_offset = CBQRI_CC_BLOCK_MASK_OFF;
> +		reg = ioread64(ctrl->base + reg_offset);
> +		if (reg != cfg->cbm) {
> +			pr_warn("%s(): failed to verify allocation (reg:%llx != cbm:%llx)",
> +				__func__, reg, cfg->cbm);
> +			return -EIO;
> +		}
> +	}
> +
> +	return err;
> +}
> +

...

> +static int cbqri_apply_bw_config(struct cbqri_resctrl_dom *hw_dom, u32 closid,
> +				 enum resctrl_conf_type type, struct cbqri_config *cfg)
> +{
> +	struct cbqri_controller *ctrl = hw_dom->hw_ctrl;
> +	int ret = 0;
> +	u64 reg;
> +
> +	if (cfg->rbwb != hw_dom->ctrl_val[closid]) {
> +		/* Store the new rbwb in the ctrl_val array for this closid in this domain */
> +		hw_dom->ctrl_val[closid] = cfg->rbwb;

(similar comment as above about ctrl_val[])

> +
> +		/* Set reserved bandwidth blocks */
> +		cbqri_set_rbwb(ctrl, cfg->rbwb);
> +
> +		/* Bandwidth config limit operation */
> +		ret = cbqri_bc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT, closid);
> +		if (ret < 0) {
> +			pr_err("%s(): operation failed: ret = %d", __func__, ret);
> +			return ret;
> +		}
> +
> +		/* Clear rbwb before read limit to verify op works*/
> +		cbqri_set_rbwb(ctrl, 0);
> +
> +		/* Bandwidth allocation read limit operation to verify */
> +		ret = cbqri_bc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, closid);
> +		if (ret < 0) {
> +			pr_err("%s(): operation failed: ret = %d", __func__, ret);
> +			return ret;
> +		}
> +
> +		/* Read bandwidth allocation to verify it matches the requested config */
> +		reg = cbqri_get_rbwb(ctrl);
> +		if (reg != cfg->rbwb) {
> +			pr_warn("%s(): failed to verify allocation (reg:%llx != rbwb:%llu)",
> +				__func__, reg, cfg->rbwb);
> +			return -EIO;
> +		}
> +	}
> +
> +	return ret;
> +}

...

> +
> +u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
> +			    u32 closid, enum resctrl_conf_type type)
> +{
> +	struct cbqri_resctrl_dom *hw_dom;
> +	struct cbqri_controller *ctrl;
> +	int reg_offset;
> +	u32 percent;
> +	u32 rbwb;
> +	u64 reg;
> +	int err;
> +
> +	hw_dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
> +
> +	ctrl = hw_dom->hw_ctrl;
> +
> +	if (!r->alloc_capable)
> +		return resctrl_get_default_ctrl(r);
> +
> +	switch (r->rid) {
> +	case RDT_RESOURCE_L2:
> +	case RDT_RESOURCE_L3:
> +		/* Clear cc_block_mask before read limit operation */
> +		cbqri_set_cbm(ctrl, 0);
> +
> +		/* Capacity read limit operation for RCID (closid) */
> +		err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, type, closid);
> +		if (err < 0) {
> +			pr_err("%s(): operation failed: err = %d", __func__, err);
> +			return resctrl_get_default_ctrl(r);
> +		}
> +
> +		/* Read capacity block mask for RCID (closid) */
> +		reg_offset = CBQRI_CC_BLOCK_MASK_OFF;
> +		reg = ioread64(ctrl->base + reg_offset);
> +
> +		/* Update the config value for the closid in this domain */
> +		hw_dom->ctrl_val[closid] = reg;

This is what I refer to above, why is it necessary to read from hardware here and not
just return hw_dom->ctrl_val[closid] directly?

> +		return hw_dom->ctrl_val[closid];
> +
> +	case RDT_RESOURCE_MBA:
> +		/* Capacity read limit operation for RCID (closid) */
> +		err = cbqri_bc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, closid);
> +		if (err < 0) {
> +			pr_err("%s(): operation failed: err = %d", __func__, err);
> +			return resctrl_get_default_ctrl(r);
> +		}
> +
> +		hw_dom->ctrl_val[closid] = cbqri_get_rbwb(ctrl);
> +
> +		/* Convert from bandwidth blocks to percent */
> +		rbwb = hw_dom->ctrl_val[closid];
> +		rbwb *= 100;
> +		percent = rbwb / ctrl->bc.nbwblks;
> +		if (rbwb % ctrl->bc.nbwblks)
> +			percent++;
> +		return percent;
> +
> +	default:
> +		return resctrl_get_default_ctrl(r);
> +	}
> +}
> +

...

> +
> +/*
> + * Note: for the purposes of the CBQRI proof-of-concept, debug logging
> + * has been left in this function that detects the properties of CBQRI
> + * capable controllers in the system. pr_info calls would be removed
> + * before submitting non-RFC patches.
> + */
> +static int cbqri_probe_controller(struct cbqri_controller_info *ctrl_info,
> +				  struct cbqri_controller *ctrl)
> +{
> +	int err = 0, status;
> +	u64 reg;
> +
> +	pr_info("controller info: type=%d addr=0x%lx size=%lu max-rcid=%u max-mcid=%u",
> +		ctrl_info->type, ctrl_info->addr, ctrl_info->size,
> +		ctrl_info->rcid_count, ctrl_info->mcid_count);
> +
> +	/* max_rmid is used by resctrl_arch_system_num_rmid_idx() */
> +	max_rmid = ctrl_info->mcid_count;

It looks like the max is just the MCID count of the last probed controller as opposed to
the maximum among all controllers.

...

> +
> +static int qos_resctrl_add_controller_domain(struct cbqri_controller *ctrl, int *id)
> +{
> +	struct rdt_ctrl_domain *domain = NULL;
> +	struct cbqri_resctrl_res *cbqri_res = NULL;
> +	struct rdt_resource *res = NULL;
> +	int internal_id = *id;
> +	int err = 0;
> +
> +	domain = qos_new_domain(ctrl);
> +	if (!domain)
> +		return -ENOSPC;
> +	if (ctrl->ctrl_info->type == CBQRI_CONTROLLER_TYPE_CAPACITY) {
> +		cpumask_copy(&domain->hdr.cpu_mask, &ctrl->ctrl_info->cache.cpu_mask);
> +		if (ctrl->ctrl_info->cache.cache_level == 2) {
> +			cbqri_res = &cbqri_resctrl_resources[RDT_RESOURCE_L2];
> +			cbqri_res->max_rcid = ctrl->ctrl_info->rcid_count;
> +			cbqri_res->max_mcid = ctrl->ctrl_info->mcid_count;
> +			res = &cbqri_res->resctrl_res;
> +			res->mon.num_rmid = ctrl->ctrl_info->mcid_count;
> +			res->rid = RDT_RESOURCE_L2;
> +			res->name = "L2";
> +			res->alloc_capable = ctrl->alloc_capable;
> +			res->mon_capable = ctrl->mon_capable;
> +			res->schema_fmt = RESCTRL_SCHEMA_BITMAP;
> +			res->ctrl_scope = RESCTRL_L2_CACHE;
> +			res->cache.arch_has_sparse_bitmasks = false;
> +			res->cache.arch_has_per_cpu_cfg = false;
> +			res->cache.cbm_len = ctrl->cc.ncblks;
> +			res->cache.shareable_bits = resctrl_get_default_ctrl(res);
> +			res->cache.min_cbm_bits = 1;
> +		} else if (ctrl->ctrl_info->cache.cache_level == 3) {
> +			cbqri_res = &cbqri_resctrl_resources[RDT_RESOURCE_L3];
> +			cbqri_res->max_rcid = ctrl->ctrl_info->rcid_count;
> +			cbqri_res->max_mcid = ctrl->ctrl_info->mcid_count;
> +			res = &cbqri_res->resctrl_res;
> +			res->mon.num_rmid = ctrl->ctrl_info->mcid_count;
> +			res->rid = RDT_RESOURCE_L3;
> +			res->name = "L3";
> +			res->schema_fmt = RESCTRL_SCHEMA_BITMAP;
> +			res->ctrl_scope = RESCTRL_L3_CACHE;
> +			res->alloc_capable = ctrl->alloc_capable;
> +			res->mon_capable = ctrl->mon_capable;
> +			res->cache.arch_has_sparse_bitmasks = false;
> +			res->cache.arch_has_per_cpu_cfg = false;
> +			res->cache.cbm_len = ctrl->cc.ncblks;
> +			res->cache.shareable_bits = resctrl_get_default_ctrl(res);
> +			res->cache.min_cbm_bits = 1;
> +		} else {
> +			pr_warn("%s(): unknown cache level %d", __func__,
> +				ctrl->ctrl_info->cache.cache_level);
> +			err = -ENODEV;
> +			goto err_free_domain;
> +		}
> +	} else if (ctrl->ctrl_info->type == CBQRI_CONTROLLER_TYPE_BANDWIDTH) {
> +		if (ctrl->alloc_capable) {
> +			cbqri_res = &cbqri_resctrl_resources[RDT_RESOURCE_MBA];
> +			cbqri_res->max_rcid = ctrl->ctrl_info->rcid_count;
> +			cbqri_res->max_mcid = ctrl->ctrl_info->mcid_count;
> +			res = &cbqri_res->resctrl_res;
> +			res->mon.num_rmid = ctrl->ctrl_info->mcid_count;
> +			res->rid = RDT_RESOURCE_MBA;
> +			res->name = "MB";
> +			res->schema_fmt = RESCTRL_SCHEMA_RANGE;
> +			res->ctrl_scope = RESCTRL_L3_CACHE;
> +			res->alloc_capable = ctrl->alloc_capable;
> +			res->mon_capable = false;
> +			res->membw.delay_linear = true;
> +			res->membw.arch_needs_linear = true;
> +			res->membw.throttle_mode = THREAD_THROTTLE_UNDEFINED;
> +			// The minimum percentage allowed by the CBQRI spec
> +			res->membw.min_bw = 1;
> +			// The maximum percentage allowed by the CBQRI spec
> +			res->membw.max_bw = 80;
> +			res->membw.bw_gran = 1;
> +		}
> +	} else {
> +		pr_warn("%s(): unknown resource %d", __func__, ctrl->ctrl_info->type);
> +		err = -ENODEV;
> +		goto err_free_domain;
> +	}
> +
> +	domain->hdr.id = internal_id;

I am missing something here. For the cache resources I expected the ID to be initialized
to ctrl->ctrl_info->cache_id instead (which is only introduced later in patch 15 though). 
When interacting with the L2 and L3 resources the domain ID should be the cache ID since that
is the ID printed to user space where the cache ID is expected. 

How is this "internal id" used?

Also please note there are a couple of other fields in the header that needs initializing.

> +	err = qos_init_domain_ctrlval(res, domain);
> +	if (err)
> +		goto err_free_domain;
> +
> +	if (cbqri_res) {
> +		list_add_tail(&domain->hdr.list, &cbqri_res->resctrl_res.ctrl_domains);

There is an expectation that the domain list be sorted. For reference, resctrl_find_domain().

> +		*id = internal_id;
> +		err = resctrl_online_ctrl_domain(res, domain);
> +		if (err) {
> +			pr_warn("%s(): failed to online cbqri_res domain", __func__);
> +			goto err_free_domain;
> +		}
> +	}

Reinette


