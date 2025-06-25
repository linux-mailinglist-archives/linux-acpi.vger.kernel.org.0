Return-Path: <linux-acpi+bounces-14648-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEBBAE8F8F
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 22:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F29D4E01A2
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD92DECAB;
	Wed, 25 Jun 2025 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAhek4ri"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E62DCC1D;
	Wed, 25 Jun 2025 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750883596; cv=fail; b=TepdsCth66gLN4rdJfzGkaHAFSQH5lq4hZ2eStCAdOR3aRrVd33IpDZGeznHQRarWpDukbzZr96yMkwhcryi20FYVLO1In2Vxnd3q7uzcd5VnNWNnS+vtqIrzetcUJAlCqEuDKttTVXZ4upCYZArn9r9dzgk4zm8fIMlFlitlqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750883596; c=relaxed/simple;
	bh=4nMCByzHrMmkAUyG/HcimZ9+ff5DE0seZlddvgtm+0w=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=aEqFX8X5DeZHT6jEiPEVTYccxNwjNIVI8lWRFV/XpTVp6gsPduyNBh4KBD/VCC8A7ysCLVk42MctVTA44C8ACQ13Xqhfde1WKUQSxQNDRWxU5s2oojQhR0HDbR77zurNnBH2QNlis7mL9MsHGIFsOPkRGQaKhhBzoo+lNH8vQ6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAhek4ri; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750883595; x=1782419595;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=4nMCByzHrMmkAUyG/HcimZ9+ff5DE0seZlddvgtm+0w=;
  b=dAhek4riDfQX/TuNG9v4khuRzvYATDN6gMQqWc1aZhY7MyJKKDmqv2EI
   x4RtdRs+07JC7ANX6X9rBdrcAohwnNPDLwbbE2xecHbuep8LcCGCgh6mp
   2KHYGl52LACl/l4ptPe+OcV0xuSxahzmx/dPZPLdk244bpTwFxAKVzdNY
   KwKBZU3O/+9ObNJ8k36dbasryYbme5kAnilKDjrTtG7r/gMYUR1ONPsKY
   iX/7t5ENFZaMAgP6bmFIDSZJYVa09KnrqMR09cZObjw5e8gAELbqUFVlo
   F6JvSuLB6/imHCofs8WAAnlqqGJCfoqVzjRkw1FE64/9eOFJO3J0tVwc/
   g==;
X-CSE-ConnectionGUID: j+JhfyzTQX6KwEFJj8jOtQ==
X-CSE-MsgGUID: 2Muck1twT8WOcWR4VMYYbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="70601540"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="70601540"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 13:33:11 -0700
X-CSE-ConnectionGUID: sagblUUxRuagYEx0TjH/Uw==
X-CSE-MsgGUID: JjrAxyMdQx+XysohTsxrKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="152495932"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 13:33:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 13:33:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 13:33:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 13:33:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDG4HYa6I4ri00afhTQggV+EDax7jDCks6pg9nfmSn/Yu2bMmK36U6tAo4VxAYZBKnwOtedy7KNURDdxTUstP/hvYXBUi5xC3ZxuExwrd+f8GfJ8Q656caMh2+vkY3rLcWYvCuJN9i8M/kNvXWvhYx8jX7whABlkgXMxL8Qkv0vpuVNGed5R1jMQzR5nmpThkrSCSWIC2hzMaITw4rOb1yqEcq8773gM9dswyXlbvHm4N12by2mfaXr9DkK9ml9nICWmjHoEWqXBVpnPWE99pZV7GRFDmwiDSduHwgKngL4ZqR+LOEzJoRxF9bblmQ6To8/0fzmpzunZa1/2pv3A1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F5E9viwCJhV8wkdqZsvkZlgN9Y4yZzg8zgtEHaONek=;
 b=HGjTCkdYKssRpLokL8icj62Xv+SByqmPhcJ9Ac2xWFPB/X6u5u3CVhMWWsCbRPw0+wo62A5fHlE2qu2l6y2y9yPSz2GIJW5J3hFUkJRCTyrjZRsHoob6e2cZ5f8rXG/xPJvK9E6H9xTl9dQTN5+2/YYL0ksQFoqcEdtWjnTG/hyFkmVGIvAk8D3wRhGmoFCfubwSiT0ieu85HDLKcKwL5WA1l6cOk7QlqatdfSlXjIzvgMZnsONPdUrTH9AGxoWScIVQGX2qA6zVkggqDOCSKOE9e+bQSE71379a2YaZfpnvmYJ8o8OVNR6LGKzZ5RTzUcYLK32zH9oPxj8Fju663A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5175.namprd11.prod.outlook.com (2603:10b6:510:3d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 20:33:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8857.025; Wed, 25 Jun 2025
 20:33:06 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 25 Jun 2025 13:33:04 -0700
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook
	<kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Message-ID: <685c5d0062f2b_1608bd10051@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <e0adad17-5d4f-4309-9975-81971597da65@embeddedor.com>
References: <aEneid7gdAZr1_kR@kspp>
 <202506250950.31C8A58E@keescook>
 <e0adad17-5d4f-4309-9975-81971597da65@embeddedor.com>
Subject: Re: [PATCH v3][next] acpi: nfit: intel: avoid multiple
 -Wflex-array-member-not-at-end warnings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:a03:114::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ee5328-b43e-414f-8be1-08ddb4277dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlN1UnpxYnp1RitzVUFtQng5VHZsTjVVZTR2VTYvUWxMQmZlWkJHVThzc1B1?=
 =?utf-8?B?ZTBXc2Zyckw3enEvUm9BYTcwUWVJWk9DMStaRFhMK1czbUZGUEJkUUljSHM5?=
 =?utf-8?B?dEtRc2ZjSUhzM1czMDVjSG1IdlRBKzVUYkQ0RWdSdUNoVWgyOU9YN2JoQ3pY?=
 =?utf-8?B?dnBYNU5LWkdYQUIrUU9jczIrTVA3NEFzanhvUmZuTVBHendmMmcvQXE0am5K?=
 =?utf-8?B?dFFWVDVLUjhNUURDZHhIZWExSmtQNlo4ZE9BZXM2bGdDNktXcTFkb1A1Z1ZQ?=
 =?utf-8?B?VHRIcjh5TVdxS29lQ1VENFRGZHZ4RGpZZmY5YlU0TUswdFhOMTM2TmVURFhQ?=
 =?utf-8?B?RHFDYlNPdXRNYytjQVJJSlBMTEtyVDVCNWtIT09RSVhBbUxNME4vVDNhc2NL?=
 =?utf-8?B?QjZZSW9hQXZlWEpRVWtzdTAvWGFwUnJMRnZXRTdEL3oxUkZjRnY2TWwyblo5?=
 =?utf-8?B?S2ltV3N4RkZnSERYczNhbDJBYWNXcjRBUWdkL2JCOWlpL3gxQVVtL3dXWVJp?=
 =?utf-8?B?Y1RMYTdmTlBoRm1MOEVFbm0rRlVRb080OXZsdlFXNXY3N0x5WGdZZFUrQnNy?=
 =?utf-8?B?dkVUNzQ4cmxGY0dQNDlKUzFSd0FaS3hnSVUybjNmcGttNmhsL0hER1JMZHEz?=
 =?utf-8?B?aGFVd0JqM1pVRExLTCsvY05EeHBQZEJxMUpMNTVrazlPNFdaRTV5SEVpa1Rs?=
 =?utf-8?B?RkROUzEySC9jV3pXZTRwa2thVTAzNGl0cW1udkxudGJIRTN1dG1ZejJBRlZl?=
 =?utf-8?B?SS9LMTNwYll1QlNkTlZvYWRaKzUrUno4cFpoVzM0UzcvMlozN01qR2RPVzFx?=
 =?utf-8?B?WTRpTGxDSG9Ec0xaUGt5Q0lDV1lob1VLb3NPY2JTQnRHRU9RRGRMSFBDc1VH?=
 =?utf-8?B?UHR1SVZpcnVFRHVQazBOenlvN3lyL3d4RGdpU1VPRzdZeHZtTE44dHVBS0Ji?=
 =?utf-8?B?TlRSV05vc2dWSEJQOE91bzRKQlR5RFM3OG1iVnhOaUtVUndTaDVOblF4SlBM?=
 =?utf-8?B?c3dDMjJNRTErVkJQRXlFSGVXTXVVTlF2bk1SRmpSbU1OUnFKNUsyUkdPanN3?=
 =?utf-8?B?dU9Wb0huUDg5NTVvR3R2ZjRLa2MvRUNqc3ExVlBuMFZmZjQvUThwTWlGODBU?=
 =?utf-8?B?VFpUcjJ6L0RRc2pEY0QvNjFNWGNUOEcwd29Bd21kNDVKSXYyN25jQURSTndN?=
 =?utf-8?B?MWNLQUJlWVlZd0ZoODhkdk1tTTcxanhPS3NYR0g5WHkrdGxJdXI4RzJxczNi?=
 =?utf-8?B?Y21zcHJlSlE4Um9LTm9ySlJXbi9xM1hiRVlwdXdHejlrS2JWblRiTG42NWhN?=
 =?utf-8?B?cEZEZkVUMFgxcUZzeXpTMnJXMCtJNTRpM3QwOUZVMjlhMndjbkpvMXlMVldp?=
 =?utf-8?B?ZUd2QjN3Rkk5TjBuQ0doeWhudlNpM21vUWtWYnZnSHlaNnQxajd1WFBzelFT?=
 =?utf-8?B?WkYyK2ppUEh5Q3R2Ui9TTDVUY2lnZXJoMndOeGozQ2NyOGZtb2h1anhwWC8y?=
 =?utf-8?B?WlMrWEFvVGtKVFN1dGFORUFuUVY3d3FhcXlBTi9ZQUZwSjIyM3ZOdWZ5N2NX?=
 =?utf-8?B?Y2k2YlFVb09BenhITldwbThRRlgrV3ZNMU1aL3FtaVk1N0xMK1p2aHJwU0xl?=
 =?utf-8?B?enh1djdZeTFxTHpoOEM1akZGTUNlcHcwN0ZkbnJITWZ3N250a0krSmxkdkFD?=
 =?utf-8?B?RHlIbWI3K2llT04vL0QxSG9Jcko0YXFXdWg1ODg1TnRraCtlUFRXeTRRL1Q1?=
 =?utf-8?B?d1BDb2hkMVpoekwySDFsS2I1YTh2NkZsK0g5eVZhL1FrcFJTYnZubVFXZnQ4?=
 =?utf-8?B?aFJ6V1ZVK0JFbkpWZzFwTXM3RW95MytSUUdyRWFTR05zMUVySDlBVVVaRDFJ?=
 =?utf-8?B?ZUpCY3F1NnpNd052bEJFWFhGa3dDUjJJcjlXbUloZm1ZZnFMNy9BQktweGF0?=
 =?utf-8?Q?odFv0wvAJx4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ppQUx3K1JhcUdESk43dmw0WUd6dkduVVRMdFRhclVydmZVSE9pVDhKS1JQ?=
 =?utf-8?B?NUJEb1B2OVRKM3FJNVNRazBrc2ptRkZ3ZE8xNGJJeCtBY3RkcmtwMDVXdFlk?=
 =?utf-8?B?azRlanlnNmQ0Z3k4c3RoaGNVdllyTmFhUVlrM2FLSUJzdEtwTUZ6a294VVkz?=
 =?utf-8?B?RmhQbFdiRDZSU2tMc1hnNEM3V2p3WXR4eUhkRFMxempuRDRKaU5XU0FTTklU?=
 =?utf-8?B?V1VRajZFdlh1Qm1mbWZSNmNYTVlUdXIyZnZLRHJuYWtNRW1ZNGJub25WaEdC?=
 =?utf-8?B?V05FbFRENEg5WENWRWp4VzNCYzFPWnpna2hLeHFwbFQ5Mm91YnllRVhCcjZ0?=
 =?utf-8?B?QmVsSW9lSmhmb3p6S1R5VkJtTmczUS92MDdMMzBvN3o0M0JnSWQ3TCtJYTVN?=
 =?utf-8?B?ZmZFTnBPNXJaZHhWOGUyNXRleFZucVJ4RnpXbTRpSmhGS2ZqVTZHZmRoenlS?=
 =?utf-8?B?U0xvZ2h0UmR3czJXMUZjNlpuSWp2M3dJZTNzV3lva3FiSEh3S0JYdUZaMWJq?=
 =?utf-8?B?RDRBNTJNOHlBeTBtTU1ac051M0hPVnJpd002NS9saUVTTnJ5d1FnaVJIaHIz?=
 =?utf-8?B?NWdrZWtLRENXNUpReWxTenRpVy9TSEFrZ3IzbE1YSzNieVI2N0o5akx6V1N1?=
 =?utf-8?B?dzZkTXRRZG5pcE9QY2VXQWdjeC8zcGpiZFZHVFArc2J6eHFDMDczK0VqNUFt?=
 =?utf-8?B?UEZjbVJFTXZrZlRzUEpWQlF0QnZBNW5zTWhWWFErbStwcnJYOURhQzlrY24y?=
 =?utf-8?B?dUtpa2RDTXN5TkxZdVNlYVNwR2pCZ0pZdHZBMGFrZmErNTFFSlRsTDlsc05E?=
 =?utf-8?B?RTZFeWEzei80QnZ4OUdJOWJUOVdrUllBVnFEcG5laHkxOEFEVVhSOUdpK2x3?=
 =?utf-8?B?eXZqV0h1U3pPMHRTa0F6S2tOQ2VwODhCSkNNQ3FPdC9HMlVSbSt0eklNdFlm?=
 =?utf-8?B?N0VjZUxlU1p3ZlZxOWx1dWovNSt2Y2k3T242d0dmY3BWcHg1bk9Hb1VBdis4?=
 =?utf-8?B?YWJTNENyYmVEdFVCUzY2RkdmbzB5cnAwZjRpNTIzTkZadm43ajBMcEpEU3NG?=
 =?utf-8?B?enJRdCtNODE5dWwvV3c1Ung2Q1dQWURCVTN2ZDlsclZRWUx3bFpQeTU0bWdS?=
 =?utf-8?B?NkJEWVdnTThwRlU3OVdLdk9BWVlTRnB0UGt1SEpqVzI0ay91bHVZdUtPZDda?=
 =?utf-8?B?VnhJQzZlckxkSUhWeHBHNy81T3pkRFJQZEZlRWphVUEraDVvUGxwdXpBa1RY?=
 =?utf-8?B?UUxCR1hGUnNieU1WNjBTY0E5cnVubGc2YXNWQk9DWEdvU0U0VS8wN29uRUls?=
 =?utf-8?B?KzdOd29SZXFkb2liUW5XKy81QkIyK3JyYmN2UFFvTnltd2w1RUV0bUl1OVhk?=
 =?utf-8?B?SnVzODFibERlWEZDMWtCYlBjSWN5VnhIOEJyN1RZYjg2U1Y0cXo2OVk2ek1r?=
 =?utf-8?B?NWpGSkdjNEl3ODdCSTZsQTBKaHF3cll2RzlJK0l1V2dwdG5sTWJ1NWtYM3FB?=
 =?utf-8?B?TGI1Yzg5SXRUZ2tqN3cvOFJJcDY5cVpDRE1GNEJzbjY1Q0JqM1FLcDJ2QVhK?=
 =?utf-8?B?U3QwRmZmZ0Y4Tk4vNE1zUTNJcDFGU3RSZHpNZ1dUOGl2M0IyNmZVc0tUeHVC?=
 =?utf-8?B?OGZScVJJOGp4TXRzS1llTDdJYWV2N21scVlRNW5EdlVrRGROWmxtVmxtVzhy?=
 =?utf-8?B?YkkwbzlzUi8xR2hNdTM5VndQY1RuckJYQUNzc0xpVGl2a2xxaThqMkdSS3Va?=
 =?utf-8?B?N2U5TnpneUpGUGlzZENmek1OZm1RRng0RTF1ZTlYd0xiaDYyMG94Q2VjdytZ?=
 =?utf-8?B?TmR5WEVtZm81VENmMWlMYjhwNVBkeWYrUXU4Z1g2K3BoajROYVlZZ3N2R043?=
 =?utf-8?B?WHZmWE9xcjVBWVFpZURWVnVsOTZTUHJCa1ZiN2JoTFZDbkdUeUFTRitxL1RZ?=
 =?utf-8?B?bFk4M2E0eHloejlLallHTDlwRXBjNjFacXQvc1QzRmJTdDNweVlYbEVpS3dH?=
 =?utf-8?B?eHgwcVY4SDdZRWYxdG1KenZKbGlLMXovSHZoY3RKTFpqNDRCVzdlaStvUGtq?=
 =?utf-8?B?YmdMVHk4NGt1M000UVdCanJYRWxFWnZ6NVJYL3M5eW50NW1TY2hDRmRjVms1?=
 =?utf-8?B?anB4MmozYnhFN0tkZGpuUlorallQUEMvTzN1aGxvRXErMG5IOU5OTzZocWZZ?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ee5328-b43e-414f-8be1-08ddb4277dba
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 20:33:06.4998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chtFQ45kS+rgy5KQ3NJ3r8vYDrQsDrOCMssHNWmB3bKh7uJhp9zqgHLVSVSu79yrIHIh3EN8bQwjNAeKz+Vxzs4EhFQ5dqxYuxHGou0b7ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5175
X-OriginatorOrg: intel.com

Gustavo A. R. Silva wrote:
[..]
> > I think it would be a pretty small and direct replacement:
> > 
> > 	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> > 			 struct nd_intel_get_security_state cmd;
> > 	) nd_cmd = {
> > 		...
> 
> Yes, this works. Hopefully, maintainers will comment on this and let us
> know what they prefer. :)

Hey Gustavo, apologies for the latency here. I think TRAILING_OVERLAP()
looks lovely for this if only because I can read that and have an idea
what it means vs wondering what this _offset_to_fam is about and needing
to read the comment.

If you can get me that patch on top of the TRAILING_OVERLAP() branch I
can test it out and ack it to let it do in through the KSPP tree.

