Return-Path: <linux-acpi+bounces-18572-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00878C38D23
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 03:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19EB1A25E68
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 02:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B167222584;
	Thu,  6 Nov 2025 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QksvvXld"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018E225A3B;
	Thu,  6 Nov 2025 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395009; cv=fail; b=rhLFAYDucnM/y5J3C0GK8Z+ZN2jzVqndBZrqEqvtz1LOLJ4OvRALxqNokYzYDYbfvaVf4JmX8n1gawhg8JTr/TJCfHO3ejFeL3NqTtxFfHRSSBBkWP156A7k0nxN1qMwIokK242XgXlnxnRLdTiqhIVSX7RoQehr62EgNRu1Z9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395009; c=relaxed/simple;
	bh=t1Mu0I6FinTqL1b7HC7eAUOp2RZ27l3+n1M2JKCEHZY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sYwtVf+YJOoqUKCpspVMB/wEBMBY/zYHnBfaKUDZRhz68xZVmagCs7P5wJZgEzHtMO84sfMZCqFR03ZcgY3w34H9S6BzIOwm+jp1VNmpcYZt5Zp9vjYwwlWaZPa1CcwAnzAsnwjE8IKymcO0e99/M1gGlDXwQQ0re2fz8WG5z8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QksvvXld; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762395007; x=1793931007;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=t1Mu0I6FinTqL1b7HC7eAUOp2RZ27l3+n1M2JKCEHZY=;
  b=QksvvXldUVkUHQRsu/tsyRk7KN2Sh3uNs4z1mtmbzAOn6eBOUIg6eOeu
   h+2mE8IXZHtPccgjFJlOS4LUr1T45Aodw2jfQcA6GTc/KAa+vrs9BY9TY
   hXYFamt59OlWajxBofJTUA+04xULZmIJJcbLRR53lMoDCT/BHvYDcKSRW
   BkJvgbdethVZzaQsfKcQaYcVRqqALdou3rL9JmcltoCmJMRll4F+8S72n
   iglpcA2LAsWfySKti73jLjcDPRZpUKsh0X5l6CUUUq/PKKGs6VMwQpJrC
   1VWwXZqKCOnu/9BQRDGG3d6qklT9SJWXzjBLFMm5vHeCqbvlEFBsCWItu
   g==;
X-CSE-ConnectionGUID: AD9RRyMGTwy/PX8k6Gr8kw==
X-CSE-MsgGUID: 0HtLksYmSz+wMIrLSOSb2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75207489"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="75207489"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 18:10:04 -0800
X-CSE-ConnectionGUID: 6z7nbEdOSZ6Pf1tMvguGag==
X-CSE-MsgGUID: HK4VkPGxQBSiUARnLGffFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="191725760"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 18:10:03 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 18:10:03 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 18:10:03 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 18:10:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q18apiO3tkzMSqYoWaxkwrvBGzxf6YGTZQW4X5Y4u1+AG2cUHQvTunUNxtAz6khFnDEqJShaCaVIIp7EmBMLnZT4exFJ8Ncec7krM256nsBXrN34B5kxoJgVuwUHwAaHziPNPRfVFatUMKRxkCLEYYhZJahnGtuQIvJA/3mQaYyoMMp5IoQTmEph6ZSe9tWzXpAf5MPDPzOS4+0NpA5pR5aO7lavHi3S0H2H+SsnhQpHD8idN9KuzT7mPvSJwHSWcQ7XfwI4P2V33zSQDPPxAkpQkfYi0hxjeL68BPlt9yh0qJ81C8DmcW+ETLwwcCRQxZfD0WK600Y0II7NeURR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fv2lZw/qcsIx7ONnkaz0VCGQ5xDsZZo1Oh39dKWNX4=;
 b=A9cdgXJs9hJ1SnkxRTr1mkPQ+HYQWNhsLLNhf/9bbBkjhwS+WwsbVsMpXd9GehaooSjOyw/HNOMQQto1S5kdWWGGeb3KYuUqwZKHEQkFEvKPlI2A2HYGf7cEpsQyuPOz7sUYXiwUoM3ek+S8wo1ubljH1fj4QFGMXvRlZj0iLSn4wBYRYEYgbkoOnWtOgJmE+z4BzidANMY7bU7oHnLBs9xHFlBd3LaKdM6kmT3ZZaICS+PTubr5oFlY73RjY1UnKo3XFu3lQXdWhgFYo+TpR816Zbn/SWG7AIRDt59EjwJS17Bg7G4XD1YpF9rZS993CP9x7U4d4J9XtTxaP8Ki8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA3PR11MB7611.namprd11.prod.outlook.com (2603:10b6:806:304::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 02:10:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 02:10:00 +0000
Date: Wed, 5 Nov 2025 18:09:59 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>, Andi Kleen
	<andi.kleen@intel.com>
Subject: Re: [PATCH] ACPI: APEI: GHES: Improve ghes_notify_nmi() status check
Message-ID: <aQwDd-Nhgxpkdrcb@agluck-desk3>
References: <20251103230547.8715-1-tony.luck@intel.com>
 <4ecbe3d3-71f0-47e9-8fad-35b16689d1fa@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ecbe3d3-71f0-47e9-8fad-35b16689d1fa@linux.alibaba.com>
X-ClientProxiedBy: BYAPR08CA0070.namprd08.prod.outlook.com
 (2603:10b6:a03:117::47) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|SA3PR11MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b718003-69d7-48f6-2afd-08de1cd99743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2RyUHhRT01LU1RiYkpNU2R5NXZiYnp4WnhBTVdSZjc3MmVuZW45WVBYZ0ho?=
 =?utf-8?B?WW0veUtVVW1FUDdkTDYvZlRrTFRNdU9LMG5HS2dYOWlQa1llTFVscXF0VGY4?=
 =?utf-8?B?cGd3Sy8vd2xFY1dOSzJGdU1mMFExd2pTL0N4MTBKRllScGZTM2VTMWN2Uk5j?=
 =?utf-8?B?VkRNU1FERG5HelY1YnBYQUE2aDRVWGFUVGdlTWp3QU45d1I5b20yZHc5azNw?=
 =?utf-8?B?SWRiK3M5MUZZRjZwbFBLcjJzeG1iZnkvbE0vRVhxUkhCdnRnL0wxYXlqWXlY?=
 =?utf-8?B?VlRQVGthSjYxRS92SE5IMUR6VVVhRFdOcDBXNWJSelZtb3UwSm5UU1B5NWtF?=
 =?utf-8?B?eXBZT1dQNFREYzZ3d1Q3UG9NdVgrdGM4TkUveHRYdmZaMzhRcFlFNnpIdXJG?=
 =?utf-8?B?VUx3cWU1WnIrUFBNQmcwMzJJOFBGUlVpZVMxL2xoakRMLzE1ZVNYUW1uNHRj?=
 =?utf-8?B?cDVBaHN0MUpYMkgyb044TFQ5M2FwczJQUlFKRkVxQzFKWTF1bFd3N2t5MUho?=
 =?utf-8?B?ODhYSVZmZkp4RDkvVXVLS1FIUUx0YUcvdFNFK3BuOGdibTRqbW9IVGh2T05x?=
 =?utf-8?B?RnhZYzlyQ2RlaHNERVBnNFZIMko0VnRPSjJBc0VlWEFCQ093WGhvNDBsZzRo?=
 =?utf-8?B?eEk2NUJwTzViQjhTT3V0TktNM3drOHZ5VE41S3JMOEovZUNBN2dZNVdOWHRo?=
 =?utf-8?B?bmpKanhnRTh2SWNNclU5Z1ZDNEdncUQ3VkV1eDFsdEZ3c1F3Sm5JenppYi8y?=
 =?utf-8?B?c2R5cVdJUmIxelpjTXIrNHo0SDZ5VGdOZloyUUVsb2hGY3ZCOTZWK2JFbDVx?=
 =?utf-8?B?MWZSQm12ZTFsVVUzUXJiOUQ4aTl6alcwdWxJYVJjMkc1dW5FWjFaUXhyQnRw?=
 =?utf-8?B?ZG5GOXVNdkF6NDhUV1lONCtZWFgrZ0h5ODZOUUtieEsxSGJXcW5kQ1ZDWlM1?=
 =?utf-8?B?TzZqcFBBbTI0eFdQNDBtRlFWWUFvMzR5R0V2ZnZRRGZTOHRselV1MTJSclh5?=
 =?utf-8?B?T2hOU2x1dlljeG9LMWswL1d3UG04R1dCTEhpYkZ5bERMV1piMFZaaUhLa1dr?=
 =?utf-8?B?WlFFSmFoeFpQTHRvSG40WVQ5NGU3cld1d1U4VXF0NGRCb2IvZDhCeGFZWkNy?=
 =?utf-8?B?dXd1ZXpNekJGMEpsRDRwWFBSSHVIaGwyZ2dTSFhDSnJiSmdFNUVIM3FaMkFq?=
 =?utf-8?B?RU9naU1WMjl3ZFVYUFpIZTVLUXBkTVFhYXFZVndyTy9KMmN0VmgxS3AyUU9Y?=
 =?utf-8?B?ZWFaTFMwTTlKTjgxM1dZU2hkcjRlb0N2YzVjcXZOSkRsMVdqWENudFRlUUg0?=
 =?utf-8?B?U1Nna0dpdVVPWlUxSVRadStJV3BDTklFeVV6VGZ1M2YzWXA5em42ZUZkQnhr?=
 =?utf-8?B?aFQ0WEJUUHd2Yzc3SGV5aFoyZWM1UzZXZWhIZzJnVVVTeUhrd3lmYk9EdHp0?=
 =?utf-8?B?aUJkRTlnb1hRRTdVL3IxL0t0eTY3NVNDd1BDNzhOTEpMMlR3U1NEQ2NNWi9J?=
 =?utf-8?B?UWVTY1Q4azdKYWhldHd4OXBMMmc0cFBqMVVvY3hBNkhHc0ZoWmVLNFVPN0pv?=
 =?utf-8?B?ZSt5TzVmb004dGFLdlpKU0MwQ0o5TG9DckNGUmhlM1RnVnYxRkEvOEJCSkR3?=
 =?utf-8?B?bmQydE5FdVptYUVER0JXb1NxV2RLK1ZOUFBRdWtmTGFiSjNnR2lQYjZxZ2Nz?=
 =?utf-8?B?MEhSbFJDN0hRUlVhRkxQMHlDVUJRM09SS0dIeElBL3pGRGcwamZYQ3ZDbVRv?=
 =?utf-8?B?TjFCMTh6Rm15WVJBMWRhN1pNaGNIeXozcFBhQlBRNXF0TE1aOWM5bS9qUCtM?=
 =?utf-8?B?ZUVndDRJSjRxQnI4S2gwZzR1cUhVRUVXK3pwNVJmYTR1SVNQZS9jcGhoSzl1?=
 =?utf-8?B?RWx0c2ZHUkNYQWJWYXRGTHBGRmpIRGZiQ2FvV1NqMXhUWFpJL3doQ3duUE1D?=
 =?utf-8?Q?rbGs0wVNP65KUPWRLr7u70QCsMeU4KKU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TldBUW9YQWRMUTlmM29pUFYweHQrdGdKMkszMVVUMGppaHdBd25WRG1iTWZ2?=
 =?utf-8?B?Y1RkYVRZcWlZVElxcG1lQlV6aU5EY2JMM1labHNFNmFRdS9GRjNrVFdUb1pQ?=
 =?utf-8?B?N2NhcHd4dkQ2bVdsaDhSekVIaXhqZEZQSkJ4b1pVK1U1N2Vhdklsd1ZVM2NI?=
 =?utf-8?B?N01QNUpINTFxL1JKOGZzRWJEa3d2SEtUSlg1MW5ZM2QrTlp4MkllNGdVdTRS?=
 =?utf-8?B?SE5QcFhta245U2I3cWd4ZUZzV2QrQmV2MmJ0TC96aUxGOW50OUR5RUpNelhB?=
 =?utf-8?B?R014bFJnYWZyQmlGTFpjUUw1RVBvZUFjYWw1ZzdVNDNtU0NyS2RDeWVDVmUw?=
 =?utf-8?B?Ti9iSG05R0l3U1hTOElCL2pCY3l1WGwxWTJRY1NPQkxtbXE0bG1KSlRub0Mr?=
 =?utf-8?B?a0Jrd1lDcm5iOW1NNGowVUVZM05WVzFOSEpQRCtsRHhGd2l1WU1sNUxjY1ly?=
 =?utf-8?B?UWQydStyd0pCNm15L1ZBSjRsRUdrRFE5cjhxanMrM2Z4ZHp0RVd3RjR5NWo4?=
 =?utf-8?B?ejhFWHJCSUR5WndtWEw4NFdjQ3JRSjhDRm5IMGNkRjRKc015WWV0MEkyY1ZX?=
 =?utf-8?B?UWlXaXdqTVRTNXhsdm9iNGRDMEF3aEJUSG9kR0R4a2NzbFN4eEdEdGhSWUJt?=
 =?utf-8?B?YmFQeXE0anB3bXJ5d0wrMGV1ekdtRlFQbFVXT1BUUnR2TDBYNjd4UkVhL2NN?=
 =?utf-8?B?MlRUVTRkWDZyVWR0Wm1rZ2FpNlQ5amJmMWFRa2VNYjA0VG80cEl6NXpIVWFQ?=
 =?utf-8?B?Z0JrRzVyaGZYZjRXOHVZRk5kOE92dVlwRWJRU3NsQnE4MDRtU3hwTUtUU2Mz?=
 =?utf-8?B?RitldDNUWk94QkY5bTZQdHorL0NzZ3o5dFhaTERyamlBaGUrMjJIRU1zTm8y?=
 =?utf-8?B?YnhhZ1dSNE94ZGMxcXBxdDVHWk0yUHZHYWsxc3QweDR4M2dsU01uM1JCdzN5?=
 =?utf-8?B?bTBLeTdzaWF2cnVGS3N3N2NGUVBHRjlNRy9XY0dKMno4cHljbENwS3pMY1Bo?=
 =?utf-8?B?MWs1WTh3TmgwT0FCNS9XWUdYYUNGVlNwQ0hHLzB6SE1RejJXK3hCZW9ZT2Nh?=
 =?utf-8?B?Vm4yaHJiVldjcml5YWcyZDNocU5KVHVxWU9oMjloanp5ZUNTUWZISlQ4aitZ?=
 =?utf-8?B?SlNuK0R3WDc5amhPTWprNWFkTmxMazV5cTFJWkxYWG8yVjJReEVxTzRzQ1cw?=
 =?utf-8?B?OHYvSHdGa0FQWXRzVndIMHlNTjlXd1VaSVFFRVhkU0Z5akJSbHJmeTVrRzNL?=
 =?utf-8?B?anZPZnREalV5WDFIV3M0eThBS0h4RExobUlnMzlDNko1cGFmYkZ5SkF6ejEr?=
 =?utf-8?B?M0JBRmFpLzJsU0NKSFY1RXJsbkkyM3FxMEc3M1BBejdaTkhRR1o0RnBvanoy?=
 =?utf-8?B?a1VyUnFSS1Zaa0oxN0ppQXdmZFQ3d0syZTlRN2MrRFhnVWM4Nm91eXJYazlO?=
 =?utf-8?B?Y1NMdFFlLytEWEZuUXYwcWgrRTFNTGVtZWlibHM5UFc1am5VY3duVVp4SHJM?=
 =?utf-8?B?VWtCRXNLczYvckRUb20vQjhveVJ4aERoNWJmSFh2cVcwZmpyVmVPeDlRSGcr?=
 =?utf-8?B?QUlSUGozOUNTM3I3ZHFncGdoakRtZFh0RThpOGF6RFZhNFdCZXE1RHZhY2tz?=
 =?utf-8?B?Q1hETXJBVGNNV2FTTzJ5MElueFF1ZW1aL1piTUFCSU5XQmVicUVmQTZTd2JL?=
 =?utf-8?B?MWtSQmE3KzVQYVNWb2dVSzVCZGc4NFhVckZXS3crblp1dit0TUljTjBMY2Ur?=
 =?utf-8?B?czBaUFFJY0lBeCsraGYyQy92S0k3U3BUL0ZGUUJPRGJ2U1cxcHRrQnQ4YnZy?=
 =?utf-8?B?ZVRBb3g0Q1d0NitvQ0ZvdE5yNGtsNWVqN1NtcUo3bHMxekF4RytweG5nQ0wx?=
 =?utf-8?B?WnhENXIyRkxXWHNCcWpjQWJwSTZOZ0tWVjVLZ25sdE9SR0ttVWxuS3lYdmpy?=
 =?utf-8?B?b0Fxbm81Z1daVFVRUjZMZmsxUUppQ3NlZ1cwZU1nOHQ2UFA0MVEvU1AreVU0?=
 =?utf-8?B?RllhVzBRZjlRQVdjTWFCVHR3ZXZhVlZvOEd1dU9qaWhSdXRESzh0TDFPQlhv?=
 =?utf-8?B?Z21VYllRVm1Sa2JEUDdHQkVGcFpmcSt3T2ZwQ3hUL1IwNm5XZCtPOXNESHBE?=
 =?utf-8?Q?WzJWLCEG2VvWRHGHgg+YUgpI5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b718003-69d7-48f6-2afd-08de1cd99743
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 02:10:00.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69kxvMs/VOzCSg7Wh45+QeYxX/G/zvpfD4jpcWapQxfn4QTrk636LAimjfEDezOyGlsetpR1H/ixqgCKGJWvBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7611
X-OriginatorOrg: intel.com

On Thu, Nov 06, 2025 at 09:46:33AM +0800, Shuai Xue wrote:
> 
> 
> 在 2025/11/4 07:05, Tony Luck 写道:
> > ghes_notify_nmi() is called for every NMI and must check whether the NMI was
> > generated because an error was signalled by platform firmware.
> > 
> > This check is very expensive as for each registered GHES NMI source it reads
> > from the acpi generic address attached to this error source to get the physical
> > address of the acpi_hest_generic_status block.  It then checks the "block_status"
> > to see if an error was logged.
> > 
> > The ACPI/APEI code must create virtual mappings for each of those physical
> > addresses, and tear them down afterwards. On an Icelake system this takes around
> > 15,000 TSC cycles. Enough to disturb efforts to profile system performance.
> 
> Hi, Tony
> 
> Interesting.
> 
> If I understand correctly, you mean ghes_peek_estatus() and
> ghes_clear_estatus().
> 
> I conducted performance testing on our system (ARM v8) and found the
> following average costs:
> 
> - ghes_peek_estatus(): 8,138.3 ns (21,160 cycles)
> - ghes_clear_estatus(): 2,038.3 ns (5,300 cycles)

ARM doesn't use the NMI path (HAVE_ACPI_APEI_NMI is only set on X86).
But maybe you are looking at ghes_notify_sea() which seems similar?
> 
> > 
> > If that were not bad enough, there are some atomic accesses in the code path
> > that will cause cache line bounces between CPUs. A problem that gets worse as
> > the core count increases.
> 
> Could you elaborate on which specific atomic accesses you're referring to?

ghes_notify_nmi() starts with code to ensure only one CPU executes the
GHES NMI path.

	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
		return ret;

Looks like an optimization to avoid having a bunch of CPUs queue up
waiting for this spinllock:

	raw_spin_lock(&ghes_notify_lock_nmi);

when the first one to get it will find and handle the logged error.
> 
> > 
> > But BIOS changes neither the acpi generic address nor the physical address of
> > the acpi_hest_generic_status block. So this walk can be done once when the NMI is
> > registered to save the virtual address (unmapping if the NMI is ever unregistered).
> > The "block_status" can be checked directly in the NMI handler. This can be done
> > without any atomic accesses.
> > 
> > Resulting time to check that there is not an error record is around 900 cycles.
> > 
> > Reported-by: Andi Kleen <andi.kleen@intel.com>
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > 
> > ---
> > N.B. I only talked to an Intel BIOS expert about this. GHES code is shared by
> > other architectures, so it would be wise to get confirmation on whether this
> > assumption applies to all, or is Intel (or X86) specific.
> 
> The assumption is "BIOS changes neither the acpi generic address nor the
> physical address of the acpi_hest_generic_status block."?
> 
> I've consulted with our BIOS experts from both ARM and RISC-V platform
> teams, and they confirmed that error status blocks are reserved at boot
> time and remain unchanged during runtime.

Thanks. Good to have this confirmation.

> > ---
> >   include/acpi/ghes.h      |  1 +
> >   drivers/acpi/apei/ghes.c | 39 ++++++++++++++++++++++++++++++++++++---
> >   2 files changed, 37 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> > index ebd21b05fe6e..58655d313a1f 100644
> > --- a/include/acpi/ghes.h
> > +++ b/include/acpi/ghes.h
> > @@ -29,6 +29,7 @@ struct ghes {
> >   	};
> >   	struct device *dev;
> >   	struct list_head elist;
> > +	void __iomem *error_status_vaddr;
> >   };
> >   struct ghes_estatus_node {
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 97ee19f2cae0..62713b612865 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -1425,7 +1425,21 @@ static LIST_HEAD(ghes_nmi);
> >   static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
> >   {
> >   	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_nmi);
> > +	bool active_error = false;
> >   	int ret = NMI_DONE;
> > +	struct ghes *ghes;
> > +
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
> > +		if (ghes->error_status_vaddr && readl(ghes->error_status_vaddr)) {
> > +			active_error = true;
> > +			break;
> > +		}
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	if (!active_error)
> > +		return ret;
> 
> Shoud we put active_error into struct ghes? If we know it is active, we
> do not need to call __ghes_peek_estatus() to estatus->block_status().

That might be a useful addition. I was primarily concerned in fixing the
"no erroor" case that happens at a very high rate while profiling the
system with "perf". But skipping (or just removing?
__ghes_peek_estatus()) if you have already confirmed that there is
a logged error would be good.

If you can use the same technique for ghes_notify_sea() then it would be
sensible to move the code I added to ghes_nmi_add() to ghes_new() to
save the virtual address for every type of GHES notification.
> 
> Thanks.
> Shuai

-Tony

