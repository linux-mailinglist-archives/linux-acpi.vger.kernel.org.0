Return-Path: <linux-acpi+bounces-18602-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E60C3CFFF
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 19:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0427418970DD
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB482D1F7B;
	Thu,  6 Nov 2025 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAx+GvTt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B89324B10;
	Thu,  6 Nov 2025 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452226; cv=fail; b=dX4GkMjRfwQkqAdVUaIkMz7eM/TtpRrfms7ZJYcTpNAUPmsa0ZOmpPsIIPgn++IjiOMckLF4W8G/pHokPAibTluA+q+CmpzbQ4Ms5rruPVosn/O9o7itJ1u4NwK7I+xJpr5/7sl+r6rpSOdWTp2FLmIGB1YhJM1/LQ3Ikbl4J34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452226; c=relaxed/simple;
	bh=TZe89ilvoe0F5D7fb3pKpcOFFc29UmvWR3vtw1hfLPc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q75h7opHxHfo8FY/274/TqjumT4jmifZ/H2HHlDt4CmFii3ia3TLnerx3812zgVRtpm2JYNm2k4NBvfLtd85b0Lcu62tO8zi/rthNU04ccQQOo+mHvM+VRjP/nvY67fGyBeX+mleJhOEdNfI6ga9qmClLovp2Tw+a+4LLfdeKlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAx+GvTt; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762452224; x=1793988224;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TZe89ilvoe0F5D7fb3pKpcOFFc29UmvWR3vtw1hfLPc=;
  b=MAx+GvTtr97poIBRNH7tm8NrmhP1SxFKb41NYplE/lMo/PYa6yvDyHbU
   IPudXhsnJjESz0MtjdSF7/0/Nhijj7MfrMOGqM+WD/snbZECoVN/Ew1+9
   G6ooY6CzN82r3tSCcfBberVWvQ9xJkDqzi4ncwJeqRdOXWW2CY6nlPKbl
   Y/Evv7M9TxZfwVq5hLe6xGOvMlKNv5dzkBLGUi55b02jbDInr9HBer7rM
   D20nj3k3KDXHbSdie5ejQffSM6kP8BNDdE2a9Gl+Zsb2O73W2vmVBhcea
   6j/R9jV5WrmmgFosxbv6hAgEkrIEMZ6RDUmlydhTpeZXnzhrs+OPyV7SX
   w==;
X-CSE-ConnectionGUID: 4rbaJWtLRwuqxvxUpOXyvQ==
X-CSE-MsgGUID: CRDqgf2WREuv6RD3zPEd+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64750908"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64750908"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:03:43 -0800
X-CSE-ConnectionGUID: wofrrKB4Tu+m22HU87LQjA==
X-CSE-MsgGUID: OoqfgFrlSomikMyhY9jliQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="188264553"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:03:43 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 10:03:42 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 10:03:42 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 10:03:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKOV0HwXc5JcOFPQQkkckmsziJfVHlAh7OU1c1ei2m+Zo4suP+bg3VYpITkK341ktWjOYyuOniQtEn5/IAXygbp7osbgbGjjvB8ddPt4735N6vY7U7mpngNzSrlSqojWU1uMBMZIfzpS3/lezqtdeZ9DjFtb3GPR6FelWIwICMgnlvfJgSVZfhKbfOZvsM34M2XPcf8vf0Q2xLFlZY4iv6qlNZgjjfwJD4VJYwNIHl5vfXVtI+M5fCAR+A1b/XZtekF7SS/2fJ63Cj6p2/vVWzlnrdSC45zZUFHAGpVDe+0m9rJKa1KVdxXuZik4wi9LYYUcnMbI7T7p7UzvnpVRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plMlzNzT7MrU9Fgv+QgupHSQbxzgHwqcXUUppmNbXVU=;
 b=l5N5iKTapjbedUWpSCU4li6arPZ7BSOLEgGD1NxaIwc+YdzPj2a6UgWSE3XJQEzbET39oPWUmkHfNz1aBaWUPmYnukkrqkx84Xq4honuKvdEy4na0ie2R4MK74xwmrC/gTCyEZ06LE/LAHFGUBREWw177mkyceGlZY/cBz98KKWnZKkkTgyehXyLavMnlNqXyYhxg3CSwoisLUgD+hBkwJXZNClxKWP7WoPgmvaEwrrMR68BV/HalkF/tkJ0VyJtXB6j5BCztq/k19hWctuY25Fu/K+sjGvXSJIdDdlqZB/uwcEzGcGesXT68fEhWYf7n86G0p7eJj2v8iK76ySkFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7744.namprd11.prod.outlook.com (2603:10b6:208:409::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 18:03:34 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 18:03:33 +0000
Date: Thu, 6 Nov 2025 10:03:31 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>, Andi Kleen
	<andi.kleen@intel.com>
Subject: Re: [PATCH] ACPI: APEI: GHES: Improve ghes_notify_nmi() status check
Message-ID: <aQzi83dxBold4Rmy@agluck-desk3>
References: <20251103230547.8715-1-tony.luck@intel.com>
 <4ecbe3d3-71f0-47e9-8fad-35b16689d1fa@linux.alibaba.com>
 <aQwDd-Nhgxpkdrcb@agluck-desk3>
 <d49c1287-6a55-4eff-a908-b8a878bdd08a@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d49c1287-6a55-4eff-a908-b8a878bdd08a@linux.alibaba.com>
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 54461f62-0b06-4fa1-ede7-08de1d5eccd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUQvNXFYRVozZm5aaFJoZjlqZTBPZUJKcU43T2kvYnY1UHF4a2E2b3NVWDQ5?=
 =?utf-8?B?WEh6MERzN2d2bGRCUHB6SGdBc0x4MERzY0pCbmd5bjJ3TTRjbUNrVVhuTi9Q?=
 =?utf-8?B?MG9oeTJmeUxOK003VkRIY2Z6TVNFQjkwbkd0QnFBd3orTnlOYWY3dnFIS1JN?=
 =?utf-8?B?dHhNSGtkMExOd1VHdW0xY29RV1luY1Jqejcxb0JhVFhpWUszU2t1STBKaURs?=
 =?utf-8?B?TWFpeHVhTW9kanNlbGxDUXRaL2RjMW5yM0liS1oxdnB6WGl3RFI2N3MzVXgz?=
 =?utf-8?B?SjczRERkeElSaXNFNWtiWFhETWpFeU51eVdta0VBWEpGeTQzWFBOMlpPWG5C?=
 =?utf-8?B?TFo3LzRYRmRYYW5LYVIwdzNMSFRuN0pCSWIrVkwwTDRRU241dlhxZWplZTYz?=
 =?utf-8?B?TjRhbFVMZ1I2V1BUejlEU1RtYndjcHhESGxoZXJNZFZHME44L1R5UWpteDRK?=
 =?utf-8?B?WVUrRFhJUFJuQmdyWWJMU2Y1c3JTdnVaN2NMV3IzVVozUFpkOUR2OUcvelhL?=
 =?utf-8?B?dmhMVnBKOE4raFJKOWh5QlBpdWpnZk8wQ0NBdkRHeTNDWmI3OFU5cEE0eDJ5?=
 =?utf-8?B?Wlp6dUhTejNmenVSVG83WXlFaEJ3bDl2VlRiMmx5Wkt1aFRWcUhScllJTkM1?=
 =?utf-8?B?SFQ2YWFsUXZwMENTY1ZHaGhKMXhFbGVWcDZQdUdXRGRPZDZGWUFFQVdNeXFu?=
 =?utf-8?B?SHdFQU1EYVJqQXFLMStuVFJaeEQ5ODAvZGRqNi94MmxxQTFnMzZpTHpQL1ow?=
 =?utf-8?B?cnFyOTNMbVNGcnVNQ1lHTWV0bVVWMDdZNHU3dHdjVDkzek1WWkhsSkc2OVVH?=
 =?utf-8?B?M3ZQYk1UZUgxMjJYSWlaYkNiMEhlbTlQaFk1a1QydGZwcDRqWjdKTlg2TVg4?=
 =?utf-8?B?b0pQQ1JrVGFsVzNOeEdyUnd1RUVra2NHWmhYclVERWJ5Zm1adHNVdTJqdWtX?=
 =?utf-8?B?bFJOeTBaZjhyUkp5QVpRVzBqclhxbGJINjlQS1dXQzU0TDh5cDh4ZDhOQ0ls?=
 =?utf-8?B?MW5UdjhHeG05cnhBNUNXNm5XYTRmYk52YmtQOW9QV3dWa3IxZjAzendDbGlv?=
 =?utf-8?B?bjA0UkZ5R045MzEweUJEZk03SGR4WWJuWkxSaktJbW9pb01rY1dTRVNzdUdv?=
 =?utf-8?B?aWRqWFZ5djdLL2dtK0ZNVUx3SjFyeUc0OHEzdHl0elV6RUFaaGs4c2FnbXQy?=
 =?utf-8?B?UXBob3l5VWVRRWJEQ0xWK0RYVk1Yd2RROWV4MG9FNVdpV1MzUElWMkNDanl2?=
 =?utf-8?B?SGFwa29LQktMMk9GNG5LSjRLU1kvZExjY04zSEJLMTgweW11QStPTTU0UzJJ?=
 =?utf-8?B?WlB4NDhmSTNXdThTWVhNMEpHVkJQdkVON1NKbU5WTWNkbG5XUzdJSmhXbWRi?=
 =?utf-8?B?QW5ZMUpleTZwVFZDNkdMS2dUTEFsMFM4ditXb3JUSVVWbjlIVzBYaUNYVFVT?=
 =?utf-8?B?VTZCWWpwV2NtS3lhQ0FPRWVUa2ZSSC91VGJSTGFqdThyUCtIMEpSa0xSdzh1?=
 =?utf-8?B?UURTVnQzQ2U2alJrZkdKWCtlTEFZTWxjTEVGM3dKOWwvM0l6eE5IcWtKTkQr?=
 =?utf-8?B?cDh2OEZxeWY3VFE4alBYbzhydkxzVTJDN2dHN3NiWFZhMlhieTJld0MwUmNG?=
 =?utf-8?B?eUpDTkdHWjJ3V2tJZTR1cGw2WS9DSTA0cVkxMHNTaDRYZDl5Z3U4bXQ5TjVC?=
 =?utf-8?B?S1lwcXBTb0ppVFpvNUtRUlp1ZFNQSGxhRG0ramN1T0tBMzFNMEJRYkN2NVlr?=
 =?utf-8?B?RmVyS1UyYVp5Y1pKdjB0UTA5cHJ3Y2NhTjFvODJtdnZZaU52TDVBY0ZnSjFm?=
 =?utf-8?B?eTBOZjlCbkFHaXBKNS93TnE5U0JFd2RMR1dVR04xNklnWXdlbWdHOU8rRUxP?=
 =?utf-8?B?dTV2MW9GL0x6ZFpob1NjeldBSU8zZ1hkNHM4Q3B0eWdtZno3MUxlTi80cC9V?=
 =?utf-8?Q?NF1detsCmRL2dSYPfotUxSx5D9VPSSIB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnBZU3g2WnNzRnFFdzRaY1c0Q3pFem8wamkzMzNuSU13aFZvT0drK2RiSmVj?=
 =?utf-8?B?RnV1MXRkOWdjRjdkMU9MNG1SOHo3Y2ZvbXljS2F4ZFgzbE42ZDZKcEJXOW8v?=
 =?utf-8?B?aHBPZCtpc0tkbnRFczFRYkc5RWtaRUtSMW1RTHgrd3U2QmV4RWpXZlRyUnJR?=
 =?utf-8?B?TXFVVjMydE10NmJZWUI4QnlJWFhpSjkxSUxpaVZhQVBkdWloK0UyMEltSEFi?=
 =?utf-8?B?SENSVjM0bUNKN1R1ZnphcWlGUUtnOEt5QzJTL3E5MTJkRk5YNWloaDlNYVEv?=
 =?utf-8?B?T2liRTIzVlA3czhNb1V6NitjUEtpdHY4clQwQXpjdEZZTGNqUmt4d1Q5eTFY?=
 =?utf-8?B?cmQ2RzRrY1NzZjZ0Q2htLzJlY083eGtRNmVjVHZBcTdDRTN6YjN2MEFwNm9I?=
 =?utf-8?B?amZIbXZIQnd5YVltVWc3MnRqRVJtNXFEYi9tWFZEenVhbW9Zc2htb012N21N?=
 =?utf-8?B?T2c4V01wbVlOcS8yMGtWcUZQS1RHaTFNRkhNL1dzQmhxVkR6K2tlNGEzT2ow?=
 =?utf-8?B?OXgzZGhQaWwvb2RJL25Fc1AwbXZaRjd4WHZzMlBPSG9DVDNDVVJrc05RSGY5?=
 =?utf-8?B?cDU3T0g2NnIvTGNOMWtQSHJNbzJvTWJFWEFDcUtOVEpCNWpDQjJKaXpCUFF5?=
 =?utf-8?B?VC9oaE5oNWdNbjZ5OStTaW9YZ216bFB2cHBVV2J5WDZMUmYzaEsxY3lWa2M0?=
 =?utf-8?B?SEd1Q002Vm9USUNMM1hWb09wU1pGWGdidjlUUWpuZytFc2tQSUlrNGtkTXBG?=
 =?utf-8?B?cjF5d29ISWFpS01FNG1leXlGVDJTVnR6MWZKLzdCb1RlRkw5N3g4M2lNVjlL?=
 =?utf-8?B?VnhRYXZ4RFdRSFVzVXMvaHdzNVUrS1NmTEEwTll2dHNIaS9KN0JUSzR1UzhV?=
 =?utf-8?B?akNRUyt2bFBIWDJRTlV2K3BBTWsvbEpSL3VSejFSRWtucDRrejB5Y1FSYXJ1?=
 =?utf-8?B?K3NoZm9ENjEzdmswNlVBYXF1OWVhVW9takJwMmhDUlVjejQyenFIKzArUlJo?=
 =?utf-8?B?RHNsWnF3RUhMTW5DZHR0Rkc2V21xR2dIbDVldXZMaCtGVFZCdzRBQkp3TkZn?=
 =?utf-8?B?RUxaVkdWSzdvbnp5cWFqS0RiYWw2ckZEM3R6Z2hZUktKRml4dnkrR3NaQWxX?=
 =?utf-8?B?L010TURVZ0F2TTRQVmNlakRsYjVKb1FILzZBbDlJOGFhUFJxMlBWRjlZR1M0?=
 =?utf-8?B?NWcrMTRwRmJlbHIyeXdxaEc0UUZSMTBBMTNQcXl1d3ZoMEVTdVBVa1A5U2pE?=
 =?utf-8?B?dU9jd00ramJ4N2k3L0s4eDVhRWZXYm5iZTFKL0tLdUYwT2pOME5wWUlJVVhG?=
 =?utf-8?B?N0pEZi9LWUpOUUo4OUh0aW1mNGpwSzBMMUhxTjY4cTdzSDVxbXhVd2VjeG5L?=
 =?utf-8?B?aUVKTm1kd1BTdWxWR1VsZnNBekYxc1JoSGlDQ2hpWDM2aUJ0aTNiWkFMWHVX?=
 =?utf-8?B?TzdabEx2VWM5em0vditFV2duYnJnYWJVbVVScWx1YUgrNHkrSEJBZm1BUHRU?=
 =?utf-8?B?SXlRdU5tOVQ2blRkWW5zNXhJczY4WXB4ME5sR1BTLzY2MitkWnNsQ2xBOCtz?=
 =?utf-8?B?MmovSVNFN3BNdzJlV3pQYjVicjIrOXljNFl2WGkrMFJjZytsdml0dVRjWGdy?=
 =?utf-8?B?TUlCUHlyZllzWUZKa3FybS81bUFYMWJLRXBIc1BQWnlCNXhuZlFIQmxXR1Vh?=
 =?utf-8?B?aTNYQkdXc2ZoaDRUa1dFbkhHYU1sK3Z3N1A2U0orQm14U1c5WE9HTXJkb0Z0?=
 =?utf-8?B?MTNvYmxraC9yd1B2Z1pGRTNkd0JPWWJHUFJOSmhnWUFBT1N0S3ZPUlM3WElT?=
 =?utf-8?B?cUJUdnI2YTdOUzlkeWI5cWZvend0Tmx2SXUxYi9ERHZXUzJFdEhuSXgwY2hC?=
 =?utf-8?B?UkpDL09iKzcxdUVtMVAvaVJOZUVUUEM5NXdnYXVncUpUdENIM1VwOGEzS2JV?=
 =?utf-8?B?K0NPTVJKRWZVdTROUGpIVGhVclpKdHRoek5HVi9JVnFqcEQxbUNiNGNBYnpr?=
 =?utf-8?B?VmVLQkpDaFIreVB6dFU0Tit0TThicVhIMEs1eVBQKzdqaHNCZjZueStHOXJJ?=
 =?utf-8?B?dndwbHd5TWZhZDA5NDdPTlRRZHVnMERGQkUveUNCa1BHaUR5bkV5eEVzUlI0?=
 =?utf-8?Q?HZ//Icymp/hBi4sOWcA5HphxP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54461f62-0b06-4fa1-ede7-08de1d5eccd4
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 18:03:33.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WKGeM1iEVeC1e/9CH1qNIIRxl5Y4pa67N/B8sCvLWcGRsKZ2CvEoMFfSTf51oUpGvTybe7cr+yaEAT5Jm+6iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7744
X-OriginatorOrg: intel.com

On Thu, Nov 06, 2025 at 01:04:05PM +0800, Shuai Xue wrote:
> 
> 
> 在 2025/11/6 10:09, Luck, Tony 写道:
> > On Thu, Nov 06, 2025 at 09:46:33AM +0800, Shuai Xue wrote:
> > > 
> > > 
> > > 在 2025/11/4 07:05, Tony Luck 写道:
> > > > ghes_notify_nmi() is called for every NMI and must check whether the NMI was
> > > > generated because an error was signalled by platform firmware.
> > > > 
> > > > This check is very expensive as for each registered GHES NMI source it reads
> > > > from the acpi generic address attached to this error source to get the physical
> > > > address of the acpi_hest_generic_status block.  It then checks the "block_status"
> > > > to see if an error was logged.
> > > > 
> > > > The ACPI/APEI code must create virtual mappings for each of those physical
> > > > addresses, and tear them down afterwards. On an Icelake system this takes around
> > > > 15,000 TSC cycles. Enough to disturb efforts to profile system performance.
> > > 
> > > Hi, Tony
> > > 
> > > Interesting.
> > > 
> > > If I understand correctly, you mean ghes_peek_estatus() and
> > > ghes_clear_estatus().
> > > 
> > > I conducted performance testing on our system (ARM v8) and found the
> > > following average costs:
> > > 
> > > - ghes_peek_estatus(): 8,138.3 ns (21,160 cycles)
> > > - ghes_clear_estatus(): 2,038.3 ns (5,300 cycles)
> > 
> > ARM doesn't use the NMI path (HAVE_ACPI_APEI_NMI is only set on X86).
> > But maybe you are looking at ghes_notify_sea() which seems similar?
> 
> Yes. It is measured in ghes_notify_sea().
> 
> > > 
> > > > 
> > > > If that were not bad enough, there are some atomic accesses in the code path
> > > > that will cause cache line bounces between CPUs. A problem that gets worse as
> > > > the core count increases.
> > > 
> > > Could you elaborate on which specific atomic accesses you're referring to?
> > 
> > ghes_notify_nmi() starts with code to ensure only one CPU executes the
> > GHES NMI path.
> > 
> > 	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
> > 		return ret;
> > 
> > Looks like an optimization to avoid having a bunch of CPUs queue up
> > waiting for this spinllock:
> > 
> > 	raw_spin_lock(&ghes_notify_lock_nmi);
> > 
> > when the first one to get it will find and handle the logged error.
> 
> If an NMI issued, at last one status block is active. I don't see how
> the code path is different.

On X86 NMI doesn't include a vector. There is just one interrupt entry
point for any NMI.

Linux deals with this with each subsystem that may expect an NMI
registering on an NMI notify chain. When an NMI happens the core
code calls each subsystem function to ask:

	Was this NMI for you?
	Was this NMI for you?
	Was this NMI for you?
	Was this NMI for you?
	Was this NMI for you?
	Was this NMI for you?
	Was this NMI for you?
	Was this NMI for you?

This is a problem when profiling the system with "perf" as there are
thousands of NMIs, and each one calls ghes_notify_nmi() which will look
to see if an error was logged, and (after all the ACPI/APEI mapping
physical addresses, reading, and unmapping) will return NMI_DONE to
indicate that no error was found, so this NMI came from some other
source.
> 
> > > 
> > > > 
> > > > But BIOS changes neither the acpi generic address nor the physical address of
> > > > the acpi_hest_generic_status block. So this walk can be done once when the NMI is
> > > > registered to save the virtual address (unmapping if the NMI is ever unregistered).
> > > > The "block_status" can be checked directly in the NMI handler. This can be done
> > > > without any atomic accesses.
> > > > 
> > > > Resulting time to check that there is not an error record is around 900 cycles.
> > > > 
> > > > Reported-by: Andi Kleen <andi.kleen@intel.com>
> > > > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > > > 
> > > > ---
> > > > N.B. I only talked to an Intel BIOS expert about this. GHES code is shared by
> > > > other architectures, so it would be wise to get confirmation on whether this
> > > > assumption applies to all, or is Intel (or X86) specific.
> > > 
> > > The assumption is "BIOS changes neither the acpi generic address nor the
> > > physical address of the acpi_hest_generic_status block."?
> > > 
> > > I've consulted with our BIOS experts from both ARM and RISC-V platform
> > > teams, and they confirmed that error status blocks are reserved at boot
> > > time and remain unchanged during runtime.
> > 
> > Thanks. Good to have this confirmation.
> > 
> > > > ---
> > > >    include/acpi/ghes.h      |  1 +
> > > >    drivers/acpi/apei/ghes.c | 39 ++++++++++++++++++++++++++++++++++++---
> > > >    2 files changed, 37 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> > > > index ebd21b05fe6e..58655d313a1f 100644
> > > > --- a/include/acpi/ghes.h
> > > > +++ b/include/acpi/ghes.h
> > > > @@ -29,6 +29,7 @@ struct ghes {
> > > >    	};
> > > >    	struct device *dev;
> > > >    	struct list_head elist;
> > > > +	void __iomem *error_status_vaddr;
> > > >    };
> > > >    struct ghes_estatus_node {
> > > > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > > > index 97ee19f2cae0..62713b612865 100644
> > > > --- a/drivers/acpi/apei/ghes.c
> > > > +++ b/drivers/acpi/apei/ghes.c
> > > > @@ -1425,7 +1425,21 @@ static LIST_HEAD(ghes_nmi);
> > > >    static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
> > > >    {
> > > >    	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_nmi);
> > > > +	bool active_error = false;
> > > >    	int ret = NMI_DONE;
> > > > +	struct ghes *ghes;
> > > > +
> > > > +	rcu_read_lock();
> > > > +	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
> > > > +		if (ghes->error_status_vaddr && readl(ghes->error_status_vaddr)) {
> > > > +			active_error = true;
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +	rcu_read_unlock();
> > > > +
> > > > +	if (!active_error)
> > > > +		return ret;
> > > 
> > > Shoud we put active_error into struct ghes? If we know it is active, we
> > > do not need to call __ghes_peek_estatus() to estatus->block_status().
> > 
> > That might be a useful addition. I was primarily concerned in fixing the
> > "no erroor" case that happens at a very high rate while profiling the
> > system with "perf".
> 
> Do you mean you see "NMI received for unknown reason" when profiling with
> "perf"? And the unknown error is handled by ghes_notify_nmi().

This message is printed when every handler on the NMI chain says "not
my interrupt" with the NMI_DONE return value.
> 
> I see some unknown NMI in production in Intel platform, but I did not
> figure out how it happend. Can you help to explain it?
> 
> > But skipping (or just removing?
> > __ghes_peek_estatus()) if you have already confirmed that there is
> > a logged error would be good.
> > 
> > If you can use the same technique for ghes_notify_sea() then it would be
> > sensible to move the code I added to ghes_nmi_add() to ghes_new() to
> > save the virtual address for every type of GHES notification.
> 
> Sure, I'd like to add it for ghes_notify_sea().

Great. Take my patch and fix it up to cover ghes_notify_sea() as well. I
don't have a system that I can test that on. When you are done I can
retest the ghes_notify_nmi() to check that it still works.
> 
> Thanks.
> Shuai

-Tony
> 

