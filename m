Return-Path: <linux-acpi+bounces-18981-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDD6C66690
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 23:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53D5F3484FB
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 22:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100C9329C7F;
	Mon, 17 Nov 2025 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTQpEHWX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475C320CB8;
	Mon, 17 Nov 2025 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417301; cv=fail; b=eQf23RkcGQZzWV//YZtyQxOzDCBxV6baitgBVWJeOck3qMgfal+BGsj3MkcSMxBy8v5thYuyj+Dpy0t0tOo7JlJMKZMIBaHWSqb5oEQQJBdV8sIB0uG5AF3oxbQnITaBnv91wgnVZo9kxP5XMPLxTGlPCm3PguZlKOHUF3t8nys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417301; c=relaxed/simple;
	bh=f+1fYwW5M/7bj6oPLghogZlDOjTDQ/3wnjG0w3UDQbo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ci1tSpiTsrik+JLAidOeYnT/oGiRztn7TM2oimnM+fC9On35wbyDVJppw+fdr8Z/1z7gtHzFFpovxUU+yqFnIO6/YV9sT/bVO08ZoD+JprSSN3BX3In4XMWY1lU/Em18Z7B/le1ItWQ6HrSnE3UTj1lKf90ridegpmlYo/gGDC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTQpEHWX; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763417301; x=1794953301;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f+1fYwW5M/7bj6oPLghogZlDOjTDQ/3wnjG0w3UDQbo=;
  b=OTQpEHWXOLLVF2jBPLo0E0k2Q1fhvTfkjPQKpkcOv0E1Gq961noRUhlb
   mu1AWBO3G19Sef+hXz230HpBG+d6wU39EFJ1+vvhNIDet1/HQwRmkk1V5
   9jeOjns/XYJZE/Uukyx5RMXNpwPNnj82fazJqR5hHeWw1OvrE8IQrcBWn
   35JUSNA/u4JCXvE5/q0TU6vjQb7bXkEhTQI3YRb2osCx4yepNu3ZthDdU
   rCe0yjXCRefvV54Az7UbKXy01TBxKZEoqnq6hZOuhkQXzIZFHwHnEet0y
   AX/ztAPyBNfVHvUSCHGINg1k4dFxOlO+HsPX1JGY4Qc1aOawnBfOeO1vy
   w==;
X-CSE-ConnectionGUID: FtWlvpOKRKiilbvZ3GOQvw==
X-CSE-MsgGUID: 8zxYF2SeSgerw/Oi/0At/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="83054670"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="83054670"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 14:08:20 -0800
X-CSE-ConnectionGUID: 796iKpQXTXiW51fMTpHu0w==
X-CSE-MsgGUID: QAeQ3M3GRBa57hezx9glBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="191010645"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 14:08:19 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 14:08:19 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 14:08:19 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 14:08:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T13MXLi1lV1jDJEqH8PILpV8uN3UtHrgJC0tkpjTZOe76+U/m3BwyS2rbsrEi2BQKN1GbxTK4HAgaB8he5cr3Se3NrbhBs8/tHSdE9TFIFusIr/9av07+o6Nv1A/Auvm+44UsXgjlRbiB6zTyroSdpVmEc67gzeH+zWbuWZrSQDaqz9oGmngEuFyQ0HcCZOD6E3fGOi+k8LxxiFFFUohXv3aCnnIFMZ23hoS3vS5qM+oz/0est13N7UzO9vHnyCfgdv9dr9Ejn0UXm6oSUJ90AO5ka6WQFhGcxufC5rrjMV9fMJMFsAwZezGUYJatgXqqpRmZ+f1N/I3FINSPKL0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRkLY6/zaE0+MP27kL6g4QTlu+gIFB99ZuxJpSkoJRI=;
 b=gr3e5rRTy3eEo9dGg6fnw9WmH50OidARUnXd2vacqG3/63CuA6SzNNaHnYYvS8kCpT41U822ZX6izAFLVbwJJStBFEVYWF4u1Rea7IXU2xdNnBTjbbmCCWgbqiqhZlP9i4sWSqn/sLHuCbzF1bqucplqz1g4L2aaQ7vGwIBcmCs1PTR/BngR/4totymXwxVdcJ6KuZjnaplpWYbpl4JZzfYDYU+aJLOaQNUAx/wuB5AyUeRvLV/uz9hYKRU215ehe0wipMnk/ywcFmb6PnAxcu3HOhr8rBoyuaiujlXcEZzjXoIRjk5AVcklCcwMUpsFGIgpbszbUtaaJISAARy04w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 22:08:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 22:08:15 +0000
Message-ID: <5a2e41ac-1638-4661-8975-5e1603a15ae4@intel.com>
Date: Mon, 17 Nov 2025 14:08:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 34/34] MAINTAINERS: new entry for MPAM Driver
To: Catalin Marinas <catalin.marinas@arm.com>, <gregkh@linuxfoundation.org>,
	Tony Luck <tony.luck@intel.com>
CC: Ben Horgan <ben.horgan@arm.com>, <james.morse@arm.com>,
	<amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
	<baolin.wang@linux.alibaba.com>, <bobo.shaobowang@huawei.com>,
	<carl@os.amperecomputing.com>, <dakr@kernel.org>, <dave.martin@arm.com>,
	<david@redhat.com>, <dfustini@baylibre.com>, <fenghuay@nvidia.com>,
	<gshan@redhat.com>, <guohanjun@huawei.com>, <jeremy.linton@arm.com>,
	<jonathan.cameron@huawei.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-35-ben.horgan@arm.com> <aRt_S7HUIifgJF6W@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <aRt_S7HUIifgJF6W@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:303:6b::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ff15c0-d168-43ee-261b-08de2625ce59
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3MxYmlHQjNKaFFGRVZnb1dPQytKUDFpdFNrNWNFZktWSElGU2N1T1pPdVRE?=
 =?utf-8?B?TVljRVZtN0lRc3dKUlJzcVQ2ZVdkbWJOVC9PMmE1dG1zRmFnQUR5TWx1cEEr?=
 =?utf-8?B?NG5ELzV3WEJhQ05WbFNjaWtFT01RRnVPSzBXaEV5NU5mc21lQUZoYWZKSWxG?=
 =?utf-8?B?SWFZVTkxYWk3QnpuTmRubTBIbnZpZjllMGRLTW5NM3NiVGpGZ010MkRMMk5C?=
 =?utf-8?B?KzJxMW5ZUWdlNXBJelp5MGNqV05ZYkNWNXBBbU5obzdQZFJKa0ZQNzhjbU5D?=
 =?utf-8?B?UWtUenNHQUhWd3BaZUo2MW1UZ0xJY0Nkb3dJMmc0OHlES0JYbi9wL3c1RFhX?=
 =?utf-8?B?SHNCcGVyQ1U4bzJrQldyayt5MnN0b2ZMUGNmRWdvL0tPZG1qNW0yZlhkV2t0?=
 =?utf-8?B?Y0pyRktPeEJTUGhGcmdUNXVmMVd6OTl2R3JoQjMva3lYdTJqUTFocC9BOHdv?=
 =?utf-8?B?T1FPbG1ueVBqM0lscUNhMGYyalVpZ3R4ZDEyMWNtRUwyM21rc1RDTUo3YzBN?=
 =?utf-8?B?ODRsYWhROXVTblBtdWNXQkJzMmdKaXAvTHlOUHJuYkx5QnpLVlQwM2Q3THds?=
 =?utf-8?B?TmZqNjZSTUp1UmY2RWlmWDNiZCt4K0J0YXZQS1czQVhQNXBiNmhMWmJsaW1D?=
 =?utf-8?B?TXRaUEtkcTNML1cvZTF3NmVVT3Vld0dVT3J0UlFzaVVxK3QrTWFUdEc4eS9C?=
 =?utf-8?B?SUEvTHl5cGtRZ1RjN2p6RzkvVWM1TmIzUFNlczhvaFpnMDl5aVlXaWVXZDY1?=
 =?utf-8?B?amk2T2NiZG9qN295VEJ2WUZRUnluUHNDcGJoUHc0UEJhY2lUa1QwaExTcFAz?=
 =?utf-8?B?OUNUekxPZ2ljaWZsYVc1OGlLL05LeCs1MnpWN1FrTGhWdmFySnhmQ0J5UEda?=
 =?utf-8?B?YTJSZTdwbUs5VE1zZHg3U3ZBeVh5R1h3K1ZhczIyQVVHZXN2NDZTUG81OEZE?=
 =?utf-8?B?cGhJQUNYN0tqZ1IvVnlaamkrZCt6R0lzdTlvRTdKMmdDSXZRQmZpUUl5N3hG?=
 =?utf-8?B?Wlp4R3JZTnZaanJGeS9ZSVR0d3NENmhxOXltNmV2ZUlUWjBmU3J5NzVzV1Bw?=
 =?utf-8?B?RmtxZmZhb2t0Ym5DMzJuU1p1RDBoRVFTWVpFVDNZRkVaYTBMalN5ekRqNWFz?=
 =?utf-8?B?VEgzMm45dWY0NzBpUnNxMjRsTmRlazRiMjQwK2dqYWxSUWQrY1RLbncvT25R?=
 =?utf-8?B?T01jVmQ3UElGc3ZCOUlMMU9HTlJXVkh5N2pCZHFWbUlHRjgrOWhxSVJZZmV0?=
 =?utf-8?B?NXhKUTQrTXFiV3dFM01oWGV4c3lrd05NMWRhYktvQVpzVTVCczhIbmk1OEph?=
 =?utf-8?B?V3ZMUEdnNVFCU3c4ekNCbVlYMlV1REMwbXRDcjh4UjJTaWZQWmhyOFczMFlZ?=
 =?utf-8?B?Q0I1MWtCNTd6SGRzNTZsc3B1YS9tSVJEM254dVZ3Z1p6SUZhUmQ2UzR6R01M?=
 =?utf-8?B?WWQxU2FpMVpteG0rRGlXcWNVOWZoMm9QRmU4d3VmVkxDTzlyR1pWdENndDBC?=
 =?utf-8?B?V0oyT0ZmMWgvcEUwMThLVXROc1lpWGRoWjJURTVYallhUGh6SGdRM1hobVdW?=
 =?utf-8?B?Y0RtdmxqcHVHK2NET1BaTE5lTEovZHZLcjRPN21MTE9FMUlCdURPWHBTa1JT?=
 =?utf-8?B?RmVPR2FtZng2WWR5R2pQWVlxU0xWMUNXaEQrbjd5Tmo3TjJ6aXZoU0s3SmFV?=
 =?utf-8?B?QjdmenEwWnVNOURYUzd1N3dxT2IwWU4zbVQyY0c2MGNZbFprSk5lY3JkSTlY?=
 =?utf-8?B?L3owVGE5VDdPbEViUjZ1M2JFbFBTZFVPa2VEb00zaXVCUndsOTZseHZPY3Rt?=
 =?utf-8?B?WnhYSktEWk14UGptbTJFK0V1UnluYkhySnhCNC9KSkpROFAzc0NwYmlzNy9i?=
 =?utf-8?B?TEU1ZENRRmFycVBNM1ZDcTBSUHR4d0hzOUZ3MDVZUkQ1K0l3Q0J4QTk4Mkh5?=
 =?utf-8?B?UnR0RTV3NW05NVZndW1KZm1EVUIya0ZhdVU4MWwzYXMzYjdXUVdXVFltK1dX?=
 =?utf-8?B?M3B4MEFOOWxBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFcvU2piV3lLeHVpcjNlWDA4aHBDNWZ5VzJ2UFlGVFdzaHQzRW51SHYzdTdi?=
 =?utf-8?B?c05CWUczOTRUU2xjdXlBZloraWxYdnh6SHlwaFM1N1EyZVBESndSNFQreUVV?=
 =?utf-8?B?S2E2aE5HN0ZNNGpnUUx5d3R2WDRFQ1cvVVFnZ28vUUcwdkFEcjJoY2R1cUNs?=
 =?utf-8?B?VGtPbkxHakdnOWVNTUJOVHhvc2JpanNtTEdOOVY2MHI1K3YyS2J2aHp6Rmhp?=
 =?utf-8?B?Rm9NbG1JbENsWUQ0cXpCb3lpM0dSOWtKbXRFaXhpcTNWZ3Fzc1NFRjI3SVdt?=
 =?utf-8?B?SWNaQjBmY2toaUU2QXJWTFpGcVRtOHgza0U0R1hweDh0dXNHYStPWjIveUU4?=
 =?utf-8?B?ZTRJNDJBTXNyNjF6RmpRenFPOFdwYVZINFVianptOTRlVkVsNWhpVEdRT21y?=
 =?utf-8?B?SWsrc05jeWhjZFZtWWR2cnBRS1pFT0NVMlZ4K05ZaStzaW9JWllQazBXMld1?=
 =?utf-8?B?QzdyZDNMZFdzenoxNlJpTENib2N0eEZ1ZDVuODlqeXBvdzFwV2NnL2pod3ND?=
 =?utf-8?B?MCtYNlNsSkxrZU12bWgrUFAxZWNWbFpWUXFlVzZ0MjJDQmlSOFVDa2JQdGM4?=
 =?utf-8?B?UkV6ZVp1MU9iZ0Z4T0swN0dxc1B4M1F4UkNzWEUyUzB3SDFiay84WXhEZnBz?=
 =?utf-8?B?RWhQenE2OWpZeXFxUjRDQ3VDbXFHSlRsMWw2RDZROGNrN0ozN3ZTZmlSRCtr?=
 =?utf-8?B?dEVGN0JEQ3Rxb1pQcnRweGFpKzBMaCtYN0VaWGU2Y2VaSStIMWU4WEFNOVB5?=
 =?utf-8?B?WWFzSGwyWHUrWXg2dUc2aEJwRkdmSHg2dURHUmduVHFZNjZDbjlQeUpmbEJG?=
 =?utf-8?B?eU9NYVc0UjJRTWRaMDRVNVJydlpoRG51aWg1bmROdFJRMUkzRWtlUzYvZVhE?=
 =?utf-8?B?akc4U0xqSFJ0d2hCTExBY0hrcmZXL0VxcGhOSWs4TnE0SFgzcDFCKzcvbnVM?=
 =?utf-8?B?ZVpDaGxQVk9CeHM1ZGJQdGJuVFJrRlUvVnB6dEgydWZlMlZPNjBnYXdYL05Y?=
 =?utf-8?B?QWFITlVTanpSRE9kNzRQUU53TWhLeDM5OHlIcUUzNG5PWk04SkFEWGtOc0hr?=
 =?utf-8?B?amlLRXlmdnh6Y0NNWnhkSnVrNnZBeEdyMWd1UWUyQWFIZ0doc2plYWthSjlR?=
 =?utf-8?B?QUJnVFEzT1pFN1dHa09xQStUTFAxcUdqcWRzUWRlMCtpQldjeUVwc3ltNExZ?=
 =?utf-8?B?WHloOGZJczk2Q216ZHZuY21LZU93VHIydDFNRmUyNDhTTC9TUDUxTFpxM2pO?=
 =?utf-8?B?OXpyc2F3T2ZzMnVWQ0NCcHAvenpud1M5WFhlWUFRZGNuM3V4ZWJvTHpieUJO?=
 =?utf-8?B?ZFBQRDBZNm1mRnR4djBCeXpFUzI5NlJtbE95UllWeERRS3BXV0FLcFc2VnM0?=
 =?utf-8?B?WkdVZmNyMmVHVS8vT3VmdGl6NXA4MWR6MnByb2RkdkgyM3kyTFB5L2ZVdEdj?=
 =?utf-8?B?ZUYxTmljbkVpTWxqYjR3M1ZFVEtHY29oWmpnZnNDd1NlQUh2ODIzSElUbmRz?=
 =?utf-8?B?ci9wR1pkdnZkQnAzaTJaYXc0bTROd3lSUG9sVHVnRk93bVFGM0JTM3NJM21t?=
 =?utf-8?B?SVhsTFRVcnZIUUwwNnFWTzdmbm9jVW9xMENMN1NDbDdqd3FrclNpdUNHOE56?=
 =?utf-8?B?S1ViM0M1TEJjS0hPMk1ZTHo5WEw4Y0VlcksxTVN6emx2M0ZERzF6SHpzVmxu?=
 =?utf-8?B?ZnJmajdiWWdNalpZTEh0ekNMbFdqdng1MXVLWTM0VjRJR2prUzlzU21DVjRW?=
 =?utf-8?B?dUg1a2lNQVY5Tm14TGQ0QXBIbGtlbmVUT3pxRXlCcW8xQStUUEQ5eFM1K1FH?=
 =?utf-8?B?WEh6ajViVEh3YTRGM09CUmpHWTdQMWdNdThMZW03cXFhU0JXVWhSQzBhcmc4?=
 =?utf-8?B?VSthV2w0RnJlVWprS3ZYU2o0aGFkUmZwamdObzJKL2ZEODVrNWM4R1JORzBS?=
 =?utf-8?B?QzVNeDN2b2k0WlVveDlDTmxkeUpCSEVvRmlSOGxQYmlZY2djT1g3Q01VWXdN?=
 =?utf-8?B?aFF1RlI3QU5aR0J6cDU0dzR0SUZMNll3eERoUTZiT0pPeExnZFZYcHlRUXoz?=
 =?utf-8?B?a0FsMGFaaUJQdVhnL1pGNndzTGtFQUdTNU9IOGFUeDB1amJxTHZzdGl6YTFx?=
 =?utf-8?B?ZEh6c3o5WFFCa2lUUGdyeHdIZ0EyK1crSnBXNEpzV20zL09naEl3ZC92V24x?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ff15c0-d168-43ee-261b-08de2625ce59
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 22:08:15.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1LDeqD0U/cbFH99bVCX9N1i6AWwJZ4cUiXkS/Fopbj7lgSqSUry5+37DU+wN+E/jVYBVgF4a1cHN0UwFrn2N2jXzymZV4PB6BiOSFXxohU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com

Hi Catalin,

On 11/17/25 12:02 PM, Catalin Marinas wrote:
> On Mon, Nov 17, 2025 at 05:00:13PM +0000, Ben Horgan wrote:
>> Create a maintainer entry for the new MPAM Driver. Add myself and
>> James Morse as maintainers. James created the driver and I have
>> taken up the later versions of his series.
>>
>> Cc: James Morse <james.morse@arm.com>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
>> ---
>>  MAINTAINERS | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 46bd8e033042..ec9b2b255bef 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17463,6 +17463,14 @@ S:	Maintained
>>  F:	Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
>>  F:	drivers/video/backlight/mp3309c.c
>>  
>> +MPAM DRIVER
>> +M:	James Morse <james.morse@arm.com>
>> +M:	Ben Horgan <ben.horgan@arm.com>
>> +S:	Maintained
>> +F:	drivers/resctrl/mpam_*
>> +F:	drivers/resctrl/test_mpam_*
>> +F:	include/linux/arm_mpam.h
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Greg, are you ok with the above maintainers entry? Happy to queue
> patches for this via the arm64 tree (or at least the initial drop).
> 
> Reinette, Tony, I now realised you haven't been cc'ed on this series:
> 
> https://lore.kernel.org/r/20251117170014.4113754-1-ben.horgan@arm.com

Thank you for bringing this to our attention.

> 
> While it doesn't touch fs/resctrl/, it's going to be a user of that API.
> Are you ok with this maintainer setup? I wouldn't mind at all if you
> want to be a co-maintainers or reviewers of drivers/resctrl/* (e.g.
> adding this under the RDT entry) but I guess you would not be looking
> forward to more email traffic.

I am ok with this maintainer setup. Considering the different status roles and values
I think it best to keep these as separate entries in MAINTAINERS.

Even so, I would appreciate being aware how MPAM uses resctrl fs. Being a reviewer
(not maintainer) of the "MPAM DRIVER" should ensure that I am cc'd on future patches,
similar to the roles James and Dave (Martin) have in resctrl fs MAINTAINERS entry. I
understand this is a major addition so I can surely also just do what other folks
do when interested in following the work by using, for example, lei.

Reinette

