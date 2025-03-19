Return-Path: <linux-acpi+bounces-12354-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB538A6941F
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Mar 2025 16:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8370170CFC
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Mar 2025 15:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AABE1DD0E1;
	Wed, 19 Mar 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvb2ZzIK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B811B6CE0;
	Wed, 19 Mar 2025 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399656; cv=fail; b=Bfjaqy32SvOWPkA3CYBuXWSaMoWZOdapuoEzKge2M1KEXxYXYkEVK2zUAejM6Ed5qAuny431VPQ1a8n6gkCYvoywWyjha6auUiGYY82CG1auUA9s0YtN7HwUElzg3/RizXcLhhhne4+GIMlS/yPgIzsyD1zHpQuNW99MwfD/ojM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399656; c=relaxed/simple;
	bh=JRId6Norn6nqXoXCOl06l30f1JKXC6f9f/na1tHM/j0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QOvDcFx0gDjsqx5ZsSUqgLHQZMn0TE9f7Jzf7SVpxqwrOLn+dxlGIYsp/IoPmKxu2WvKiq7HAjoHB+EDtNCclzkWynpyGpgVquu1qxAvfnIZhnq0R8HZ3zBFED4YInmpXLRyTN2KsOjFqCJL4Nt5U+Ax7Z3NTYaDSVW7QBSEckg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvb2ZzIK; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742399654; x=1773935654;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JRId6Norn6nqXoXCOl06l30f1JKXC6f9f/na1tHM/j0=;
  b=cvb2ZzIKVj9eOX6jFgjPohDCjR5QN9fJ0LKlNLYMm2QLi/MdCYu+fsbd
   FyLM4USlf7DTh/+3TZ4xT3xSGRPS6ALsklotmi9HkN90tHQZ+/9Mg9YM4
   rDDH6u+YuBiT/tQP6XR0WJF4pUgRP+bNo25n1g+GcRfOPqrJ/ne83K3L5
   Yvyt8b9ZjpiELoMGe32Q5RcEOm7xBjc7uceRwnBjrwuqskH3a1AMuca+x
   H/vKyL3rUgAf7H8BFFEe2IfjSPSjumIL07rEdKOqivCa0UuECC2DS0K/E
   ceFEkQiAETUVPODX2yiTutnlutL4Zk17b2TY7YYFsOZkJeQSdm0QKmURH
   Q==;
X-CSE-ConnectionGUID: ZwwkrQHsR8Oz4EX/4UeqHA==
X-CSE-MsgGUID: 8TmhE4XJSwuPGMz7UP/Qzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="53812212"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="53812212"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 08:54:13 -0700
X-CSE-ConnectionGUID: X4rmT3J5R6+G1J5e9mQZug==
X-CSE-MsgGUID: N6BzpLgiQfOy15NeqCPIzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123602279"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 08:54:13 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Mar 2025 08:54:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Mar 2025 08:54:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 08:54:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imTZYV73gMsdrVbkjSkSVbJSeFuHOdc9FLjYwJdY2XygMt95/yjDv7YlxE3L85tWq6XERKbwS3pp9SV0jOXLjfN3uY6lpswrnoYijarpBuCn+ba5P2BJ85NJOCFSHqzj0MUHEv0HPRMsHByxoTz3aBX7iTP21N5t6PYwG55gqHd9OxthHvIYckYW+2YbY+uhnzFKIi1w3ge7qKtmn4K5ier2/BP4D2vUqWQYdCUOAl4XxdKJMOE4bvbVWSiZSjegds1Li4Iv49yLTnpa2hMnaDhlpKDWlgfT5Jkd9NKcEvpLyjIuSzMGiWuH7nHedWRDYO9/MPm35O8e6D7b5K127Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Lsjki2x7VCeKWjfwVdy+zwZ0xH5es1NYRnlTq7tGKA=;
 b=udIypYkCNuTnaqrg5ZsqF6utQEMnGpCCINp6cci2xRgDb0zqNJFNl3bqO5f1iFGRWuHUBxPngwJq0hGN6of57adRlzIGpe92CenS8MunYPOZwn1dV44qdu3JLt6m+vndJIa0tO1qBMZEN9HvxSIezk7PHghOJTPIlCfpEMw4NQbqGQuPaMZWnkOJezp+BJPR8sEzyBxFBtJQ1Z8CHtajGH3AcV2RP+UxLPnqgcMGU/3OIpTtAcQbUrDAHG4HmUHvOPhNJS/mW/bLwQwb3UbdjliX6am2MWPZpSoWE35t51LAjvINiKmm3uewyQbKN6gYf8KxJFDdW0eJH0RZhC47wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CH3PR11MB8210.namprd11.prod.outlook.com (2603:10b6:610:163::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 15:53:37 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 15:53:37 +0000
Message-ID: <b3a6493e-2dc7-4342-ad5f-9c4e91b0d35f@intel.com>
Date: Wed, 19 Mar 2025 08:53:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Prepare for new Intel Family numbers
To: Ingo Molnar <mingo@kernel.org>
CC: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Arnaldo Carvalho
 de Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Zhang Rui
	<rui.zhang@intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>, "David
 Laight" <david.laight.linux@gmail.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Tony Luck <tony.luck@intel.com>
References: <20250219184133.816753-1-sohil.mehta@intel.com>
 <df1b95d7-c953-4757-b742-3072f65539f7@intel.com> <Z9m9B7BmoItsfjiM@gmail.com>
 <6758e958-a4d7-48b8-83ff-4bcb98f87340@intel.com> <Z9nT8-7dPahdKgSQ@gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <Z9nT8-7dPahdKgSQ@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:a03:54::15) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CH3PR11MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9601ac-86d5-4f06-530a-08dd66fe3621
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGdINlpRVk5LZEpXaFVJWmxYVjFFMjNSL0JtNXFoK3VvVk9lWlg4UU9neWNM?=
 =?utf-8?B?ZDN1aENOdGNnaHFGYUNFZCszaThSNDB6dkN1aCswSUkyb1Vtc1U3cXlGZElW?=
 =?utf-8?B?Q0lWTUpqbUZlODV0bkliM3VhNjk3RUNjbHgzZlh4RWI5MDF0QUtpcXFqK2hD?=
 =?utf-8?B?MVRmKzhQdDlzMHBnelN4TUtsZElsS09pME01aDczbDU0cTJkSGRNeTJzeEZl?=
 =?utf-8?B?V05ZN3BXb2x6UmVNY0o0QzZRcUQrWjlDSDMvcmlQVHplQmhhM3Rjb0p2WUp0?=
 =?utf-8?B?MDVaTHhSNFFndUZ1RGxiT2Q0Z0I4Z24zN2x1V0ZsUjZwNUZFRFM1UnRKVWIy?=
 =?utf-8?B?Q1huSENDL3FjSmV6Z0NmTndXNERLZVkvb3RpbTlmTFE2ZWxqMk95eGRXM1RN?=
 =?utf-8?B?WXVxdSt0N0JseGNVVDZsejZtdGQ3VlZzbTdZa2kzL0Z3dkFIOXhZYjNoam5Q?=
 =?utf-8?B?NkZSN2ZKSVRTVUMxNllUNCt3WDBNVzVoK2t5RUJOSzVCYmFmS0Vpb3JHd09y?=
 =?utf-8?B?KzN3WVRjMW5oK0gweVpKWHYwbjRZalBaK3V1dkpxNlRSaldVZFNWWnQ3NS8x?=
 =?utf-8?B?SGxONjhkaWwzTEpGY0lrZGkvQTVYL2U5dkpxS1d3Qk91Tlg3aFROdkhGQkcy?=
 =?utf-8?B?TTFjZGVacTJWVndGSWpzMmxtTnVjbW5xNHJGTGwyd0xXc0RhYUFERkxsL3M1?=
 =?utf-8?B?bE1Md0xoTTh4d3cvcHFWRGJPdXFOODM2c1RMNk1DVXR0UTY0c01qMDJ3RE1s?=
 =?utf-8?B?OHRkR2VxYjFqZVUvRWRwbXZ6U0dVNkU5NGd6Qm0xQUlHbnc1V1FvejlRUXBz?=
 =?utf-8?B?SVJBSVFjVHZPWWhUUS9NRnJ6N2dKeXNZempWZGM3a0grRHdnbTdXNWtRYTAr?=
 =?utf-8?B?S2F3NG0zaUh3emk2QnREWnVsQ2RBeExxd3pZMHE2S0QvdEFzTlRMQ2dsN24y?=
 =?utf-8?B?ZGVYY3ZGTzN5OVNCQ1VZY3FIaVQ4VzUvcDZwTUtUN3F0alNCNWptdDlQL3FZ?=
 =?utf-8?B?SzJ3dy9EUHlBYUJzdGpCcHZMcGwybkJOQ0M0SXBMNDlzUFU5eTB2cXdKNi95?=
 =?utf-8?B?U25xditmYkhoTGxPUWhmZkJwdEw0SkZPWTBhcmxzenZ4ZkxhUkJQVVRobFkv?=
 =?utf-8?B?em9mOUNyQ3pQS2IwTU1BL0R6QmwvcnBDZXpPbzM2UlI1eU42a0FCNGJwbXpE?=
 =?utf-8?B?YVVSSVQzU3pCMllMUW9RcFIrbllsSldZcUlhMzFzWi9iY2FLUGhDOUxYSXp1?=
 =?utf-8?B?NHp6REV0TDF5cVpmbjR5VVZRM2dXY3g3SndHYWhGZFpTbUFjWWlvVURMYm5C?=
 =?utf-8?B?b0JrVWQxRU51WVVSRFBRQ04xUjJHUXgwVUQzZVhsdDZueDlGbHYzSDQ4dGkr?=
 =?utf-8?B?Skl1aE4xc3c1em1PZjhoYVpLNFliM0dkMFRXRHVkc1BIQUFKM2E5bFVuOHVh?=
 =?utf-8?B?OSt5bmxZZk1vbGhiODh2M21SMEpJdUNmbmhHYW84b0tYWksrVk1velZEeTFs?=
 =?utf-8?B?K040R0pvZmY0WExXa0FrREE4MWNGZldEWGxnUkovL0tRcEtJalBXUUVCOHB3?=
 =?utf-8?B?RlREMGJhUS9XSnFWdFZBS1JYQ0hBK3pzRlBka0RQRm5kYjl4MzV5UlJ4alBw?=
 =?utf-8?B?Qm1lNkxhNUhRbXpHR0YybVlHUG1idG01ZDROdVJoNWNnb1JZZlRjQ2VBUXNn?=
 =?utf-8?B?SlpmMW13eWZVOTIwM294UlZnYytsaldQZlcraktsVEh6UzJCY1hZd2ZQT2tl?=
 =?utf-8?B?cHFCM25zS2lFNW11TXhIQmdncXhDc0RCYW9CK29RZkMwb3BFaWIrd1JzV24y?=
 =?utf-8?B?VnJIWEZFUngvYWdHTFZvazFJMTlmamJHcHRQQzNIVm1SS0tycWNkejBtZ1Fw?=
 =?utf-8?Q?CH1EOcF7P1m/4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1AzZ2lRNFlnaUZWYlFoMzJ3dkR5TUt6TVNXNmEzWnAwcXE4YVpyWk9uanYz?=
 =?utf-8?B?STROQk9zaUtjVEhISmxONnNRWVlTRnlWOVpJMHM3bjdhTmFMQkdYWlFxSTVU?=
 =?utf-8?B?K3JvWTJUSWFUeVdLMkFVN2UrTkVrUmxFYldqV3Z1TWZOZDVuUVhUKzlrNXVt?=
 =?utf-8?B?bUttOTBoRkg0SVNTZmJSMSs3NXJZQzMzSnZraHRJU2VXRFVHVFRsUW1NaXY1?=
 =?utf-8?B?TTdzM0lSdVRITk1WSEVwSjg3OFRXVm44NDNuNGxiK0JOMHQvQWJtMkwxNW5W?=
 =?utf-8?B?dE5PVVg1QU82QUY1Z2ZsdmJ5VjJEejdhUE5iN1JEOHpWRlJTK3NqcjdUWkxK?=
 =?utf-8?B?VmVCVnFFeTRtdWZGdWdaeHBsR25BVlRKcDU0dGlTU0p4bGdWWmdFTmRZNktu?=
 =?utf-8?B?SVUraHhtcGowWXorb2xub1MrZU1UTzAvY1hUaU9vbmY4aWY0c1lmOVB3VDRO?=
 =?utf-8?B?akRtVHU2RlUrcTRBOWxhMDJYQU5GRlY5YzcyeUtyZ002N0RZVktuUnpJOWN3?=
 =?utf-8?B?dXRSZlV3VGJaTkU5MWk0Nm1xNVMzMGRLYVhzZm1UbXhvQkdzUEQvQnM2eld1?=
 =?utf-8?B?MUwzTXVqd3ZiVE4zOFhuaktnNE1ieU9TU2dScmFOcU9iQjBaUDVnb0xQTGtR?=
 =?utf-8?B?TzhMZzhpTVRweUw4SWhYdDJCWFQxWWp0K25aZDNtUGFRTGNwbVJQT1FEWVlh?=
 =?utf-8?B?NWFCckllNlMzNEt2ekgxemhyOGdLblJ0a1dMMGZ5KzJod0RtdmFxY1k0NHFj?=
 =?utf-8?B?TktCSHZEdHZiUVdOSThIQUh2aE5GRDlqSjFpUWhINDRRSjVtSkhGVzJ4RlRE?=
 =?utf-8?B?UHdsU0I5M2RiTkd1T21UekhRZWZEbWFYVG1pdnNOSDFjbnBsc3Vzczg5YzBo?=
 =?utf-8?B?ZWlKeHp3ZDl2VDh5K1NyNE9lMEM4V1huRnFhdVVYRU0rajdoYTJOMGdYbzRW?=
 =?utf-8?B?K2VuZzA1TDIrZ1dxcjFGVU5XbFlDUkczT2cwWkU2NVAwaDQwUEx4UWw3Nm5r?=
 =?utf-8?B?aHR5WU5hZzJJc1V6ZlJIaW9JdXFKZVZlUFNNUGlIcmlpVkVWTlZKSGRuTkZx?=
 =?utf-8?B?ZEcrb1JESHhQWmVCc1lJYm5FMHl1Q3JjUzZVZmJSOUx4Uno1K0JDbkR6dHBr?=
 =?utf-8?B?bjh3eTFqRWpQZE85blNicGI0YmV5M21RLzRra2JEMTQ2TmVOazNHWEtqdUNo?=
 =?utf-8?B?Y2pSUVhCbktVV2ZSQ3hFbThuc2tIN1J1ekN6VGlkcVZORGRmUi9QUFFGeFJG?=
 =?utf-8?B?Z1dTV1FlT0tGeFNpclBvREZabDNxQUx1ZHF2REduZlFsZEJrcVRpNUk2RlZJ?=
 =?utf-8?B?UFlHQWwrQ1ZiUFJKc1FidWJtZjh0Z01lVEU2SGg4RkYwcHMyWCtBV2JtNTdW?=
 =?utf-8?B?NUV5K0JJTHFQR1didllmSnZSWUFULzJTOGhZM2F4bVZsQlBaZEYvNEpsRWha?=
 =?utf-8?B?SXcxbDlsNWt1cURPTkhjRkk5MFFUZ1kyNnhnOGNsSVhUWTM3SUhqUUhGVHQw?=
 =?utf-8?B?OGVWMW9WMU9lM2N2M3l6QkliR3YrRGdycUp3Q1kyY2w5V3FidEFydVhrRU5U?=
 =?utf-8?B?L0VHRkVJUzFyK3EwMW5SaC92Mkp0T1dCR1RDTnFjZWxQSE1zZ3daR2pLRjNm?=
 =?utf-8?B?L3Q3Vmo4M3YrMWFMbTZ0QVVGTlluTmhYaWdqbE0yL1J6Q21EZC95d2d2ZjVj?=
 =?utf-8?B?eEFCK1c3a25hWnVaMEN0K2lYMUpBMHE3bEtvQTRLM21hVWp1aDB3aDFyYTNU?=
 =?utf-8?B?VDVDd2h5U1d1U0V5OTBOT3lLdHE4WFlqUkw0bnNtbUxQOElVTmRQdTQ3eHpv?=
 =?utf-8?B?anlrTUkvaExOYlBPaFhCd2thQ1RsWDFrTS81VmxmK1R6SnFrbUt1SHgvQkdn?=
 =?utf-8?B?SUFrMGd1OFZNSW9iTXNMT0V3ZElUcjI3WUhYTC82d2hkWi9SWW44WE5LSkZR?=
 =?utf-8?B?ZisrYVZhUlhjQzNOTDlvam5hYis4bWJzcDRuajFnaVcyRGl1VW9jWE82ZENI?=
 =?utf-8?B?QkI4TUxuUXJpRUkxZGdaYW5IazFLNVd6VUJ0Q0xEMVBKdnNmTXZ5ZGVNY1Rm?=
 =?utf-8?B?a0ZiVW1wNHF5akkxUytHa01kZzZtL2s0elk3dXFWOWs5N1NwVTdWUEl3Y3Jw?=
 =?utf-8?Q?8eHrv2Xz55nfBq73fpNccOHrF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9601ac-86d5-4f06-530a-08dd66fe3621
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 15:53:37.3915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFRIQ9EYMI7hxIdT0RfD6AA+hGaAOGOZpSlArEx0EcsgImfvL2vBAxPUo2UtSGqsGOXjgLvIKDnvEg8hEW7/oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8210
X-OriginatorOrg: intel.com

On 3/18/2025 1:13 PM, Ingo Molnar wrote:
> 
> * Sohil Mehta <sohil.mehta@intel.com> wrote:
> 
>>> I've applied the first 13 patches to tip:x86/cpu to help move this 
>>> along. I fixed a handful of typos, but haven't noticed any 
>>> functional problems so far, so unless there's problems in -next 
>>> this might be OK for the merge window. (Famous last words.)
>>>
>>
>> Many thanks.. Fingers crossed!
> 
> You are welcome, and please send the remaining patches in a day or so, 
> on top of tip:x86/cpu.
> 

Sent the v4 series with the couple of leftover patches. When sent, the
patches were based on tip:x86/cpu, but that seems to have been merged
into x86/core. I have verified that patches apply cleanly on updated
tip:x86/core as well.

Sohil



