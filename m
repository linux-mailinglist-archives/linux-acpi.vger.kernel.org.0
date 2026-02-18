Return-Path: <linux-acpi+bounces-21012-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CRYSN/JIlmnedQIAu9opvQ
	(envelope-from <linux-acpi+bounces-21012-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Feb 2026 00:19:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BAB15ADEF
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Feb 2026 00:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3697301466B
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 23:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA0B33A9F4;
	Wed, 18 Feb 2026 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvkVbGRs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E5338936;
	Wed, 18 Feb 2026 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771456751; cv=fail; b=L7C1E9dYZWoctnqTXezUOVJ1LHEkMdCpXroDcTRHGdO6S/eMzF0HZSUZEg+Nt4OmAQhfr6o+ihOS1vKeox22lh0hUx3P0XFu97CGLWJkCY8YaaZgywd5EN+q3Z3fwAJrtIzBjOpGvf/YNEcKgUDeKoL96ZzuPVlVIrh83ITHvWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771456751; c=relaxed/simple;
	bh=ElIQYxqqTul5kPMYsinxvGqYbeD2Y2eSZ+vr1W3WMU4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LPUdMH9lLPVsN4HV0ZtZg+7d3A6tbK2UAvXMThxPAKLgucg8dijXZFWR6GGU6JFaKQxG3bFblr0AHc5INyTbIkWwUEG3cFNpAmr+8hrm6MO7shJkpJqtIcie0XukqDImkYLEHcthTnX0Wo/W+cMJZXIKlIXieRQebTIgB7bJElM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvkVbGRs; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771456749; x=1802992749;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ElIQYxqqTul5kPMYsinxvGqYbeD2Y2eSZ+vr1W3WMU4=;
  b=fvkVbGRstJPtu4v9tPOTDPEfyxzYwvKv48Qh8gV89T4/q0Budiq5VR9r
   zheXN4Icjpu6FEoAgMMXWE1oWDDrDyN5oyQOXGpIEGOmYChUPk7xugEo+
   DX6HSCVbgYnZuxbrYK4FWFE7Ln9byCKOtkVCHKAv8Oid89HA+p9kU1bqz
   RX3hnM/jf/MKdiDa6eunD4ki0O9I5AhFr/pY/wYENuJhxBPOr2+Uy6hy8
   802lleZypc77bMOynXNtB8V/aUCgicEgMvwpn3YuYtWe/49r/xnTK4Ufy
   wLWW2geDIi2DGb4c3essrbg1r949bZAoxuLt5Ph7RWSdVO5O9b68I+QVN
   A==;
X-CSE-ConnectionGUID: nQYIRvSTTG+f3ayg+LdRlA==
X-CSE-MsgGUID: CfKqaGl+SSKZY64fliOjRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83261313"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="83261313"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 15:19:08 -0800
X-CSE-ConnectionGUID: Pi6MlPWMQ/qesfNStfQTnQ==
X-CSE-MsgGUID: HygfFavpQ6uxQqWy0fXzjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="214201106"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 15:19:09 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 15:19:08 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 15:19:08 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 15:19:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3IhcIaSXs4P3tWyl5OBQFDgucE/vbI5M/dXuKLA7l84VRqRyNkM53AcloO+hhlRMfmO958Br18N6d65p/eyWD4gl5l67hYf3a6ND6F0t4VgqhwCeTNQLeqSOEg4t5xbL3b5aJtdfR6cFwmW0WAUnU8utL67TFYr9G598B5hSwunSHT6GMdQ9cyKNRE+MH8pY+C9dexe0sTLp7qguJCbf8oD20gSyJP8oDKRtHOKHrn6tyvehSs+D3xGhwDXyJPCxpbtyJE6CL5+Q0SnFgfo8GY9g2FzbQNarGEHN3xJ3nopLZMNUP3TJ6f4/1ZAMkXyROF59Aos6Z7nGo4m56uUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5YJV/4TfQosUjdJm8P+lado6akkWSxwdFsg/soJqQ4=;
 b=wz18Kl8rFmtFZkfy0+RfRzEORi9c/bzjIm43b2hFvMilGj3lRxZLRUDCcvDp+YOEsuIhtXR8BLWXG2+zJRxeDEPyPGPFO187/aOfN3B/R7Oq/J41sl+30iEfFEK6sOQFVNN4Rzp+pb/DolYzPBNs6CuUX5zKelHk39tqPXdv+nB9wzIlfelLUQFrs1PBwBAv2ija5Ue7ZwBOy9bBW2lhANcyni/Mx7EEMd2EyW6ZuQi+DDekJUL5K6CII0h5Wk+Yc4nVrfG2LNhA1OukEcVF4kvmvJOlee16+BEtKWicMNAxABjclUYPfaYVXITXO2w9cjI69ooi4QXA//7vJfIgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7845.namprd11.prod.outlook.com (2603:10b6:930:72::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 18 Feb
 2026 23:19:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 23:19:04 +0000
Message-ID: <f7ec04c1-0890-4f32-ab3d-4c8b042eb65a@intel.com>
Date: Wed, 18 Feb 2026 15:18:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 08/17] RISC-V: QoS: add resctrl interface for CBQRI
 controllers
To: Drew Fustini <fustini@kernel.org>
CC: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, Samuel Holland
	<samuel.holland@sifive.com>, Adrien Ricciardi <aricciardi@baylibre.com>,
	Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?=
	<mindal@semihalf.com>, Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra
	<atishp@rivosinc.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, "Ved
 Shanbhogue" <ved@rivosinc.com>, yunhui cui <cuiyunhui@bytedance.com>, Chen
 Pei <cp0613@linux.alibaba.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	"Weiwei Li" <liwei1518@gmail.com>, <guo.wenjia23@zte.com.cn>,
	<liu.qingtao2@zte.com.cn>, Tony Luck <tony.luck@intel.com>, Babu Moger
	<babu.moger@amd.com>, Peter Newman <peternewman@google.com>, James Morse
	<james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, Dave Martin
	<Dave.Martin@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <x86@kernel.org>, Rob Herring
	<robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Sunil V L
	<sunilvl@ventanamicro.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<devicetree@vger.kernel.org>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
 <7e35f79c-df56-4cab-9a8b-1a9ffbca053a@intel.com> <aZYz9IdnnnsGZJr9@gen8>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aZYz9IdnnnsGZJr9@gen8>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:303:8c::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: dab24678-b50a-4d46-7ea8-08de6f441b47
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWdVTDh5akUyeW8xRzcxR3VLVVgzVGE0eG4xdnFBVDlEUmZXZDBtRzZvK1Vm?=
 =?utf-8?B?dFQ1ZTlMa2p2TUlmZlQza2k0cHljSjgzUmxqeVI4dU04NDl1YVpKdE9RRjlL?=
 =?utf-8?B?bVVjbWFSSGxuVmpybFBYQlluWFl6NlJZZW5oR1RkeldLbkRWTTkra2pqVnY4?=
 =?utf-8?B?WVBacVhjZ2RsOCttblJGeXZPOHpGM1k4WVZqbk43SFhDalZPR1doUjc3Z0xl?=
 =?utf-8?B?KzlXRExMZWpNT1dxUU14R3hSV0tqd2ZRazNjU00rT1BCaVFJUzFZOW14Mk94?=
 =?utf-8?B?VGhPNC83SVg2MjVKWkdHZmlxU3hOd1FhV1BPK2dHb0pwZG95aGw5bFp0clZH?=
 =?utf-8?B?ajBaSjBKM05sSFRqQTNNTGEvbWZrZDVtY3EwVDhnM2l2a3pIci81bGJQelZG?=
 =?utf-8?B?dEVFU3FJbG9PK1o5a3RuR3Q3d0RxdU9lZDdHQU45Q3pXV0toQ3M0S0VCeHJ5?=
 =?utf-8?B?ZVdtMU53b043WmNOQzBMOVRDYWxjb3VCR3ZlWXhmQzd5WDRtOGdQS2pxbE1v?=
 =?utf-8?B?VHI2SC9LOVF0RmRSTk01RklOYlFhSFZKaWE5aGZxOWk1UUhldjgwNXR3WnVW?=
 =?utf-8?B?MlRKRElGdDEyUmoyNWNqRE5tZTE3amFZdmx5eXlxRXU3U1JjY1lJZG5iYkdR?=
 =?utf-8?B?a3ovLzl0WmRtSCt0UndkN1BWaS9XZFRTcDdJait5YUY2TlRicDl0U05TYnZ3?=
 =?utf-8?B?NE91a3FTRjlqN21uV0YwUmRRN0x3UlVjSloyeUN4NUhnbTZWK0pzbEhqSGtj?=
 =?utf-8?B?UTNNMDlBWDQwaU1QaE8wN2xNSW1FenVJdGJRcDFvWmJEZDQ2QVZ5cktaUUVN?=
 =?utf-8?B?Q3paWW0yNnJNU2h6a0d3WDMxSTNoZjBmWUpkNElLUmUrWW5LcHBCb01yTTh3?=
 =?utf-8?B?eTZLTnNhNXY3L2N4NnltQVUwK1NxVnpmU1RiZE9ReHJKNzlTNU8zZW40MzFx?=
 =?utf-8?B?b1dmeE5JeTNMa1AybHhWQzQrYVFaU0pObFhNZ3ZUeUtibG1FUnNmMUVOcDl3?=
 =?utf-8?B?TVNlMEpjejdpSGxxNkh5dmRPUzc3VWJlcHZkY2JhNGUxb3c2SkxtTXppZUJ4?=
 =?utf-8?B?RzNiNTgxUVF5aGZRT0VRRXBVZGpodVpjZytwRGdXSHlwU0dHY3cyQmVsM1RY?=
 =?utf-8?B?TkVEZ1hnbEg4WGFuMnB4bytMM0RFYWVnV01Zbm85T3ZNR3FlQVBSVE1IV0RW?=
 =?utf-8?B?aStLd29MYVlwSitGZ0owcEQyclhyUHRqT25HdkhRcXZOUE01VEJuRzAyYnlE?=
 =?utf-8?B?SytYbHF0Tm4xZGtXNnNMTTZtQ0ZnNUNvSGMzQzdzT3krR2VKclR3dUVjejQz?=
 =?utf-8?B?NmhoTFM0UkJnMDdYTUwzTWx5Z1VVZUhvUG51OUxVajZKdGxDM3hVajdBWmZv?=
 =?utf-8?B?WU5nakhYMWtncVZUcmtRV3NGSTJ1ZkxSSE1VQ016SG1ERE00YWJiQzlZVUp5?=
 =?utf-8?B?bmJIVUZWTEV0ek92N2Nxb3A2MUczdzJ0aWNVbHhWKzVNRlk1N0dnYkRhRWRY?=
 =?utf-8?B?aFRpS0VOU3hHblF6K21kWEpqYnFxTDlGS0dVdFk3a0xKZmQ2YUtyWmZickZD?=
 =?utf-8?B?TkEzRnIwSUFZWVZIb25IQldZYmFySUxZMFVxc2dBaFo2Mlc3MXl0QkFzTnNC?=
 =?utf-8?B?bE5zK3pkSXB4WEdKSkxMSFpEWFdqdnd3TDluSHRqSHdVQVNzUEplbmVhYVVM?=
 =?utf-8?B?NExIR25NNWwvblN6blZjWU9PWXZGcllnaHN5WEd4SCtXNUh1dGRLTUwwVTYv?=
 =?utf-8?B?cDlsaHZvckhyUFU3cVVGbzVtMWJ2WkIybzRDVXdreElUYlErTHF1SnUvVUJY?=
 =?utf-8?B?a2YwUXlJSzJ2VjM5Q1A0WGFYVGhLc2oxMFpkTzVzR0wwY01JY1JzNkFrQTFN?=
 =?utf-8?B?eE12WnZ3QmhBY3Mxb0tnWFVqeDNqQnJnL1BZb0kzZUxSR3pFTHY1dFhsRWd3?=
 =?utf-8?B?cVJOb2ZZNVBvbnNmOTVaUVRsa1lWWkF0bkwwS1hQSDMweTM5ZzU1YmNhcW9C?=
 =?utf-8?B?UmVXVE1DbHJCR1FwYWhnamdaMDYzb2R0aWZPTlpyS09yenFLbXB3bXQybCtJ?=
 =?utf-8?B?b0VmckJVa01WWGo0Q01zUS9uYitDTmwra2FCM0FnemdsbkVSNjBpc3pkeUpk?=
 =?utf-8?Q?lbnA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGROV3IxSGVhaVBRdTAxWWhUcGNzQnJXWW5RTjdKc0JVaUJVUjA1MHlWRnRh?=
 =?utf-8?B?Und0aGRnZUFTQ2NuUVFQTkQwN0UxVjBrWThIWkxLd3YzYVhnLzdJRFE4Vncx?=
 =?utf-8?B?YSsrdHJSVzRFVXFINmdDTUUwS2tlVkdDNnVqazluOElFcklzMmJpZVk5WmVj?=
 =?utf-8?B?WEgrRW1wSXRFYSs0ZnFvK2g1QVFPYXVWVS83QTJtSStqZHZkUm05ZURSekVS?=
 =?utf-8?B?TGhlYStRMVU3TGJnSWJPZ2ZvZGI5ZFA2QkVYbTdsSGNJYWZYZ3lENkVGdUkw?=
 =?utf-8?B?VXBqaGdyUEIrSUpBZnFmWVoyZXJVVmdPZXNMbG4vYmI2NnU1Q2VSS1I5bHlT?=
 =?utf-8?B?RnBEU2pFQ0lIQ2ZMbVlCQUhoYTd1Q1Qzakk1bkN1N3hsTFo1Y1M4LzZrbXZW?=
 =?utf-8?B?WXpaemg1T1BSMzJHcXBnYUZJQVZWT01ERlEyaGR1bVBzTFYxTlJRSUh0d2lE?=
 =?utf-8?B?VzdZRTNMaWJ5QVd0ZlVmckxYQWVWa3FNOFp3M0xxaVdUKzRnWENVVmNhanlz?=
 =?utf-8?B?MnJrc01yUWtoYWY2VXRaSmhRZllhSTg4ZnMrczdaK1JDZ0QxOXRhMzRLLzRp?=
 =?utf-8?B?WWphLys0YVhQb2c5M1JHRFVDUWdaM1plOGRhUkduWDFMaC9SOTZCUkwraTRK?=
 =?utf-8?B?U0c4d0gvZk9zdzlRMDNEZm5iaHFoY0FjalZSS2N5VmtnS3JUZU56UmZBVzUv?=
 =?utf-8?B?L0RQVzdSU2JNcHpock5KQ2RKbmV1WC8wU2RkMFNvMDVNV0kyZE53bUtTVjdx?=
 =?utf-8?B?NWZpbXZuUmNsRW51Mzh4ZlQ4Q3RyRDdCMFdjWlkrZjNlVHdtRXhBSnVMTEVT?=
 =?utf-8?B?Q1RYWDQ5emkvSkdqSEU3QXlyTTVBMHAxUmt5a21tQTZMcXNMVWxSbjdsMndW?=
 =?utf-8?B?R2VJRnYrazN4NnJYTE9Ebmpnb05ndC8vSzJjSWVNVHBNeTVYRHBoaEdqeFgx?=
 =?utf-8?B?akdlcVBHMGpBNjg0RHN2Ny9MeWJGMEFKd2djUitNak1RdUZjNUk1QjV4SnVD?=
 =?utf-8?B?YjllcENqcUVaV0ZiTUxiamxTV3dQc2NnNEk1TlkrcEc5RVREYjZyL1BLUm1X?=
 =?utf-8?B?OGE2WWZlNk1zUkRIYks1V1hGdVpjbUlvTEFoQmpGTXZkMEVRMGRNL0lxcC9T?=
 =?utf-8?B?RlZpOExCZHRIVDk2eWpkbWs4SEkvUEpBVjRNWEZJWERKN2svRzlmSktNWEZV?=
 =?utf-8?B?ZVlvUnhhWHhMdXZNSkw5WFZSaHRoMDVKUnBjY3g4NjNCb2x5Z3JSekV6eERi?=
 =?utf-8?B?STZPT01jNFhHNWhCZUU5bjBTU2RqZDFtelBJV0lMYVE4NTM1cGNpOGc1enRJ?=
 =?utf-8?B?VUdzMVVUWGxLOTdVZTRrQVFWMU9mNUd2UEhiWVVjZHVtcnpRL201YkRxM29l?=
 =?utf-8?B?VWhJMlNidCswUWVFRGIxL1lUWmJudXhrbWxRWnV3azZJOVlnWjZXaU5BcnNh?=
 =?utf-8?B?YWVGTlZMQkIzdVVOL05pWUFkdHAzalhoYzZTajdWd2NTYXpUR2JzQXhYa3pu?=
 =?utf-8?B?MkRtOGI2UUdPaVU2cTFoQmxBOExEY2VLNDkvOVVyVlU3ZGloRHZlSE5SMWF2?=
 =?utf-8?B?alpObG84T21XWnZSUC84MERKSlQ3TkljaW8rUVNTNlZkWFNiM0hpaWhEUTJG?=
 =?utf-8?B?d1d6VThISjF1MVgrdDFYV3hSMXhMTERZSTJySWZaK0N3NC9UNFUxN3dZZ2pa?=
 =?utf-8?B?ek4wdkdCZisyeVJ5K09TTXFXWGViZU53TmdJN1pESE1aKy9WZXphQ1Z2emdD?=
 =?utf-8?B?SjlGNGFzS0x3WHc0cWVPMXdjQ3JWbFZmWDJRajc4OXA2c2hjY2FBV2JhNXBP?=
 =?utf-8?B?OHRjTnpWdXN5Y3FnTndMajN6bmhXaFE4cGFieE9QZk5xckhKTnNxM0tDc2Qy?=
 =?utf-8?B?UUZNZWV6a3Fjd2ZMKzgzaDVCQ0Rrak1UMTdiMXdZTVpic2dHejdGQjBnT0lm?=
 =?utf-8?B?T0hndmpOb2wrdENxWGRpVnJidXN4UnNtQUpnOW1pRXNVazkwMzZwbHRkMCtk?=
 =?utf-8?B?cGhoR01rRWR5S3pkOEU4NEdtWnF0SFh4Y0VvK1Y2NEQ2UUk4S2g0UVplYTFa?=
 =?utf-8?B?L2crempFUG5iZlh5OHpWYlFhVm0zYVZGWXNTTTZUVS81ZHM1alUxaW51ZU1I?=
 =?utf-8?B?aTVWT2VjZldXMGlybmswNW1nVllUTjNGWFZYQ1dZWHAvNVZ1M3F5WG83S09x?=
 =?utf-8?B?R2U2QnVTaWJRZ3FoeW1xSDhSUW1qVEJBdDhzRXE1MEhaYUMreU4yRjdDTFkr?=
 =?utf-8?B?bk1vN0hMUEI1MmFLay9GUjd1QXJ1MmJHdzNlWFh6MTBVb3NFTlF2TytSaktj?=
 =?utf-8?B?WXVIVjVSMVdCU1BHdFBWYkVtY3UwMVRPNTRxcVE3cUhtUUtmL1lJQ1EyT0dW?=
 =?utf-8?Q?uXheeFWjsjVis3Ec=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dab24678-b50a-4d46-7ea8-08de6f441b47
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 23:19:04.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 928mJAVazBXMF9PdjVEK1wL/x1n6yHMIAoGHIPjDrMJO7FdQeNL5J/TsOwrOPqMISa8v38fK7Pu7FoK4lUCVwt5d3eKrhz4OugNbGBOCiVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7845
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21012-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,bytedance.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[reinette.chatre@intel.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 30BAB15ADEF
X-Rspamd-Action: no action

Hi Drew,

On 2/18/26 1:49 PM, Drew Fustini wrote:
> On Fri, Feb 13, 2026 at 03:30:44PM -0800, Reinette Chatre wrote:
>> On 1/28/26 12:27 PM, Drew Fustini wrote:

>>> +void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
>>> +{
>>> +	*closid = ((u32)~0); /* refer to X86_RESCTRL_BAD_CLOSID */
>>
>> The name is actually X86_RESCTRL_EMPTY_CLOSID - and if RISC-V also needs it we could
>> make it generally available.A
> 
> There is no dependency between closid (RCID for CBQRI) and rmid (MCID
> for CBQRI), so resctrl_arch_rmid_idx_decode() is essentially the same
> for RISC-V.
> 
> What do you think would be the best way to share that between X86 and
> RISC-V?
> 
> Or is it is simpler to just defiend RISCV_RESCTRL_EMPTY_CLOSID?

Thinking about this more, yes, I do think this will be simplest since
a central define would force this on MPAM that does not seem appropriate.

...

> 
> CBQRI controllers are accessible by all harts (e.g. cpus) through mmio
> registers so access should not burden other harts. I think I will modify
> the implementation to just directly read/write the mmio registers when
> necessary rather than caching them in ctrl_val.

fyi ... resctrl is starting to show some signs of support for this. Please see
ab0308aee381 ("x86,fs/resctrl: Handle events that can be read from any CPU")
related to the monitoring code. Support for monitoring is not general yet
though since the default L3 events are still assumed to require reading from
CPU in the domain.

...

>>> +	err = qos_init_domain_ctrlval(res, domain);
>>> +	if (err)
>>> +		goto err_free_domain;
>>> +
>>> +	if (cbqri_res) {
>>> +		list_add_tail(&domain->hdr.list, &cbqri_res->resctrl_res.ctrl_domains);
>>
>> There is an expectation that the domain list be sorted. For reference, resctrl_find_domain().
> 
> Thank you for letting me know. I'll work on sorting the domains before
> adding to the list.

resctrl_find_domain() can help with this. If the domain is not found it returns
NULL and also returns the first domain with id bigger than the input id via a
parameter that can be used to insert a new domain in the right place.

Reinette


