Return-Path: <linux-acpi+bounces-8474-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6824E988CF1
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Sep 2024 01:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2FD282D9F
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 23:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5061B2EF5;
	Fri, 27 Sep 2024 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nea+dCQD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A527C18A6D0;
	Fri, 27 Sep 2024 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727479303; cv=fail; b=UC6Hn2PQQt/pMByZYr2tRfie+VGcJquYd+g1qdYL9RElan/vMH0FV5IpN6/phX5LA0lBP88dird02PnA3AzaKoMGbWshR9wihNWWJw/8Eo9TgNx1+0WM/k/w5zYT/TZgA8h/p5JO0qWVIWdCd4Waye+SFNdop6RMJ4hZqA41GWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727479303; c=relaxed/simple;
	bh=CG88S1jYdFrYELjxeB/iUcy5TBQikStcYFOawj+AC88=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FRGbTo2pWoxUmNGOCCBYeFVAXzo/ZyGMVwwG+YiPQzwg1InThFgeMFfaKjHWe6CdsbkE2alenuAeRjFpABQ2NGeTaILhaPVh7j5y22rSYKgfwDCPHPoFhC4rItTVaRMkKp37ACV4Sfm+5mmxjiGGgbVvQ95r5HsfvMTlZgb0HPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nea+dCQD; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727479301; x=1759015301;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CG88S1jYdFrYELjxeB/iUcy5TBQikStcYFOawj+AC88=;
  b=Nea+dCQDyTegZU58gFM8Jv4695D8o4OSI/5MoF63zHJFf0LeYMHsU+oW
   d2k1vGWl9rgujROMCXm7ow36Z3WHBVZJ58e7cGFESJ9NZXIw44HBVcHlu
   XtKKpnHF9yKCTqfAcOsA6lcrr61E1ge9KASaIX8qzXRmUD2AA0vw+Kc8a
   Xn7tBj1DioENJDgVy5Bdzt22LoXDdEdZWiGP4sDYUS7jejyvB/jJExu7X
   LbBX0uKsdwECf9wQajU+u9PP6IR+3weQre6EWqD+K+qGrq99IkhCM6w/x
   NaSSyzJVzR9J0mIesUgZ7crGD3L1as8WcIBuGgYOKlBWHhdWnVwy0Vodo
   Q==;
X-CSE-ConnectionGUID: WFJMli63Su6ZQi4Tw4brjA==
X-CSE-MsgGUID: O68m/2YGQ4qpLtJ/En1Gkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="26815533"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="26815533"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 16:21:40 -0700
X-CSE-ConnectionGUID: WEsLluy3RPCDODPern4mhA==
X-CSE-MsgGUID: lbINGNrfTyKWkqCDoMXgGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="77061943"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2024 16:21:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 16:21:35 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 16:21:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 16:21:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 16:21:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfICK7SuEiZNTcYDHNdQ/qAp46JnIIIWUsYgPpptaySSal7omRyxUw+S03Gxccmsr0UsnrGYQRn99d458nt9Ulg9pHaMKtQ/CuxaqdpiS8+GS2g5V8hu/Z4g6ijGed3WBddyB1ayTUsePNnfKmBFHXJKRgXCW79wx9JSU7U3YHtzcU22MqY0xMVQAzAkeJ5MhcV6n8PI3aQWzi4DrVZMX4cDNDD0EmXjYUd3eGljUWow4c+NK3kIJKdswx0RrkSxiEi68pHWkVXXg3P6t1qw6lo35Q4+s1rnafR0IB1m48SGPzR8Iz0H6FmHB1wvhhQRp7Aj2q80VEM9U6vufqlfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clavWhdAuSThNY8StZkVAeB8yuBtIbN7uxXCgUWKcO0=;
 b=mE4PlwdGapkND1guxY+wFg1aR8CCKiwHRaGxJ/84Xh7/LMliOxhra2fCLrHu3SKeRZuJ8LCTM++k3mmpC4lGhtxitEGB9sV6RNs1dJAgrNYzuBOosp1f1ZPeEPrEShNkeWvfceZbQhAyqhGWAysU/DOwvc+akN1CfGOcXpQ+JE9FT8DEVfG5CYqbB1SlFpL3RJWxrpMeOrWwNC/sLUIyXFdicbCW/GADzUptc08v7C83PAqLLZhls2Okk8PgY6aNNWQff5oRd7qPxU107Ldn2b4Wh3bUqGiSgh3dNE0ucq3xRzFnRJ1mUy+6KB6gtUG72BNtsA+BN1W0PVBFIqtHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYXPR11MB8691.namprd11.prod.outlook.com (2603:10b6:930:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 23:21:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 23:21:23 +0000
Date: Fri, 27 Sep 2024 16:21:20 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<sthanneeru@micron.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: Re: [RESEND][PATCH] EINJ, CXL: Fix CXL device SBDF calculation
Message-ID: <66f73df0dd80e_964fe2943@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240927163428.366557-1-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240927163428.366557-1-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR04CA0252.namprd04.prod.outlook.com
 (2603:10b6:303:88::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYXPR11MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 0124d697-d354-4114-dfd2-08dcdf4b1a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W1GrQJhZHF+VFDU3dIv5ag1u8UhJQlChav1TnPNIEiYi97rmQRB1KdmVQSAc?=
 =?us-ascii?Q?E1e97INeqnpaBnyo6P1TT14Ao8WfmxfjOMouNiXNMLgKQPdyjmh8oeGrAGeD?=
 =?us-ascii?Q?4TFHRqpGyjTj62U7JI3STyfOiu0KRVtunuVvLHFrrjqr46VizVWmb5D5PHLh?=
 =?us-ascii?Q?wUXdZv+lwRftEFGq+9WcnpnLrMoqTvkSBTh+3NIhSVpWuNdNiTcchX2OC0S2?=
 =?us-ascii?Q?FTtslYyyintPfF4tsEu0YxYFmT5ahYAY+q9Kkkm7HFUzjdjjoro42yxaTD67?=
 =?us-ascii?Q?2xaKZaURPW/mHJki/JsDAfe7MDeZsk/lnh8MkQt2z8f7xcYn/+KhYuPofpm9?=
 =?us-ascii?Q?5SYtbEwpqqjwos2pLSSPVUliqn46V6Lk2tEZI5Wrz261f6XoZTIZs1LIwM6W?=
 =?us-ascii?Q?qN5HbslvwZgIDV+8ITHRz/TK2mhgYFVCJS+jkzjHaDSIzg40H6XE/YAvAVTS?=
 =?us-ascii?Q?e7Yqj2nEZXZTqeLpb2omt2+X5oYBs/ggOyjbPqnVkgWW18IeGiZUWDVAx7Qg?=
 =?us-ascii?Q?87M3Swr2wNfJKWyFv1KlH+pZjicSGsoFykZXlCZ+3bMwYnmooS8gHjnLZU0R?=
 =?us-ascii?Q?IzrBnqLgzH/GedSaZvDt5b41N/zyWuPeVkKG+DkxO3CLxJ+jHyKYTDu7g/HM?=
 =?us-ascii?Q?CkmsP10HBMWuS0bkUAQBwjSFOdtLz+OvlclABmL/4lEXDtJ9H/dR4uQDAnq1?=
 =?us-ascii?Q?rmFVmdYnrLZiqkjLA3wicqOMfVLDT3TZdkBsEB4ZgcnOFyh5nFTh2RtswglL?=
 =?us-ascii?Q?Fh6OIZq4NFXVdj9YzVV5tt00gx271BP5dUpoKbuTjc/dYwfafDk4zBtktCFo?=
 =?us-ascii?Q?wzSDyfRiyZlSI4ALxyu94WNHtsV4cZTuG81N7oCgGFbvawbfkRZMqxlAgnBa?=
 =?us-ascii?Q?/fUT6ioRYGQs4HC63dtRwZsXC38ZaeASb1tGT3G29F6MSj/UQgyHFJcs8ane?=
 =?us-ascii?Q?WJBu479X8bQI9w9HO/RZp5c/mHeCwVU8CGYOjPWsDHl3Tt70PEAd6rB/CnZX?=
 =?us-ascii?Q?Uk8JuqXaEvVrzsrRUtw1mQ+q5j0nJ1JMnzqXJaIBoyvAxHmrwBrPW/RtVSyL?=
 =?us-ascii?Q?Um+/Zn1rmPlm41HlJSvHahK2yloyOP7mOnxVt7BnXt/mgs+InOCY2u6E6TYl?=
 =?us-ascii?Q?tXWTLgNv5ieo3ngnuQZphOxrzWvTcvXbmYUwb/OfKhvVgojhFMvzpxLlZ4Zl?=
 =?us-ascii?Q?tm9d7vyGLsmwXkpWzIpqjShwVDPoUbfneZuZRGCJ8j3teMK+VAQKcIxNxYTv?=
 =?us-ascii?Q?LhsrXyqimmPoGdKP+8Smx89ljsenRWFBpGLMAgzv7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kmsDVV5VLZfjLGWNGgDcgBggwvgkUNwlx2jzcrUzF+aoVkK5CYunuG9Ldzza?=
 =?us-ascii?Q?xsWt2BbXqdVLGjI5H2YSliuMQwiSJhYgU9lpXhTGC2joEMQfr/gMKbk59Fx3?=
 =?us-ascii?Q?dkSIfl0NiyXl8WHd0HXMySuDp+ZdaylDU7IktpTI7yAQqWA1hNDtD5SZe0GT?=
 =?us-ascii?Q?sG7XyxvqUf2zPqL2CXCEL97n2hNuheDpKdE+Vv2r+iJ1n/j0ForrO4frL90y?=
 =?us-ascii?Q?X+7D5T4ak0uKWrmGZQF608YREAnb2igCafQDFOfkF+VoPeM3pKiT1NHmgmEM?=
 =?us-ascii?Q?Vj/FNQnH+KH0ftvQu0AUlX8RxyoskqKVyNSsqQ6xCbO2kMaie78AXJEZlUcX?=
 =?us-ascii?Q?SBgee9ARmJUvIsfyg8zmX+0wJ+bi0rNRee/CUHKiS1h8KsqwOwjmxoSD3bHO?=
 =?us-ascii?Q?cNSfd7zzhuukslzouW1eK6n0lDEalFpzdUc/YpOVZl4zzfBbBeP+F95xLbzO?=
 =?us-ascii?Q?UUec1fXmLbuAPy5jwuCPTQuYO0xP4Q9y3MFajUm9FDX+T5G045VLzjZqKwfS?=
 =?us-ascii?Q?vyAbEBcEXy3MZKf113uTa/K0Or+LGfX7bnXqBasIm9BFJbd8fvv6BAzvagn8?=
 =?us-ascii?Q?XiRbeGI/vMdtcGKhwInKr/V+qe4CJ1p0h/0vw0cEHH4lAUTWqipASZ4JEv8x?=
 =?us-ascii?Q?ORIfjSI4Pc754CjkhLoctDjOOvHMj8f5DcO/IrycUJujS5tK72n3tZrHb+5f?=
 =?us-ascii?Q?7+9frGga+FIVknSvVsftkTjUsQs8DBvVCyQ5ovYAFiIyCA4AsKtrSolM2NMf?=
 =?us-ascii?Q?glnPWrx1Rh/QuQSwdsinTADOalCObw5Y+SlLcHYVE1RuFQlN4dgkoJS7mbdR?=
 =?us-ascii?Q?BJyFSNEKumEE1L66/Dv5viTvPQCSvWDLWO01uzqngGh7DtldKfxtUKq4xiVU?=
 =?us-ascii?Q?U6kQYN/4RGyjgvZ2h5Rd06WlrKSVubtDjdvGIm1RMTl22b2h27VJI0GuNvgU?=
 =?us-ascii?Q?LdYbgZMybK4wW19GgRCQS3m8G0wO+rGMC55SOXxDsv+jHPRTB2qXZqS55y3H?=
 =?us-ascii?Q?0YJju+8FpxLxO8Zy9G3EMWMloj881X3qaqdfNST2DNCOWRD4cnp+szaaSS9B?=
 =?us-ascii?Q?hHLv96unspP2cUI65xA40D3XDCNGeB7R09DwBpefLGKL1iMnxUUWdeOKZX0w?=
 =?us-ascii?Q?FTFE4rmTLzVkJ+8Nwgb8G7bnMGmpCebM2frgb4WjaU7Y7iKmZHGBOsFHOBu3?=
 =?us-ascii?Q?r2EcLL/YT99bvzFSGY+dLb+4sIP+UZM/yP+CdW4L9bg5cDZmylmqHsoxvKNG?=
 =?us-ascii?Q?Xr94usljZa+Y/KuV9NsfCBZlC3oYXAjyEyi+Jtr4VVKjBA593CrpJsoT9aT3?=
 =?us-ascii?Q?16ZinHuCc8qsfPxUmauNKHMe+7Ky0IaY13yg4OfC2dUGYaqBeRJR4/AefNVL?=
 =?us-ascii?Q?43aIgD1K56bpjT3R9YM73lK2ckfk/ie5765m7IHpaIquGfqxtXW81vd/ofBP?=
 =?us-ascii?Q?RWB2Gt5E0x5PtqVPOj7AkSNUmALBaseomykM+j34pLOPGSRVtnqFNiOX1T9q?=
 =?us-ascii?Q?j60ywRoKqzVmohdTEKNKWi5Lp0QkLJqCwV1zuImp2bKVBjeCuaIt4CTov7QK?=
 =?us-ascii?Q?WFJb3OiuGuwA3eHt1/TBOTU2mwR3wyrdDSDVcXsUhiVD8UvTkFMiVklPdzXD?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0124d697-d354-4114-dfd2-08dcdf4b1a10
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 23:21:23.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cr120Lk19Rjmi3kdSxpye+PYOOZ3CmLILDJwiP0GVevKqRbjbg9akBECVZ5uRSvGnSF9y3OFu5XHne9T5RPMJNfdD+RhL5G2r7IyPsNmgMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8691
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> The SBDF of the target CXL 2.0 compliant root port is required to inject a CXL
> protocol error as per ACPI 6.5. The SBDF given has to be in the
> following format:
> 
> 31     24 23    16 15    11 10      8  7        0
> +-------------------------------------------------+
> | segment |   bus  | device | function | reserved |
> +-------------------------------------------------+
> 
> The SBDF calculated in cxl_dport_get_sbdf() doesn't account for
> the reserved bits currently, causing the wrong SBDF to be used.
> Fix said calculation to properly shift the SBDF.
> 
> Without this fix, error injection into CXL 2.0 root ports through the
> CXL debugfs interface (<debugfs>/cxl) is broken. Injection
> through the legacy interface (<debugfs>/apei/einj/) will still work
> because the SBDF is manually provided by the user.
> 
> Fixes: 12fb28ea6b1cf ("EINJ: Add CXL error type support")
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

