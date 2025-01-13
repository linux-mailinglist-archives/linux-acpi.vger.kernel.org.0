Return-Path: <linux-acpi+bounces-10577-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30218A0C2DE
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 22:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3737F1697F0
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 21:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EE61D47C6;
	Mon, 13 Jan 2025 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YB9D8Xhz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8801D417C;
	Mon, 13 Jan 2025 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802008; cv=fail; b=NYTsX1uCMxphXQ6U4OeThyX45WYFyU6Ufh6vveW1RIHnXv1dDO1gYUHmC9Dzd7a1FdFb44dQnqdFT1jvWjXB2+J3DjbtPs0hW+0nX1yKBOMXXKUpKXSlnctdxFzmIqLMdZNf4NJIpIj5Thc66bgyjqlb3yIxiR6B3wWXNZDnaiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802008; c=relaxed/simple;
	bh=lZ5bMz0Q0KMiwm23/Qg8ziGYcr70r/MfZR59JZO6TSA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EotyM+Cl95rjQLiHTx9ll1sPLBSVWzz3QJbIe5pH6U3T4nJG6BnVoGYNCX6Mqxfv9bbynQyRLhdkO2esF6x9G4YiDYb8DgNqmW9MvnwY0DemXIP8YZNHogSfNrxTES0+3EFdOw1Cz9G4i2OcD7rFkn/rzIK6AYID0ESTPTgpBS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YB9D8Xhz; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736802007; x=1768338007;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lZ5bMz0Q0KMiwm23/Qg8ziGYcr70r/MfZR59JZO6TSA=;
  b=YB9D8Xhz6Ad31ptcIfD27WTiVow3UMM46w0yYYXahZuevh5Kgx5BEjBR
   Ci5D0YQaRoGoDXbnChp4U7ZCLPrfrbB+Cg0mpocgv5Lm54Vv5z7AmkhiG
   ejc0cGV5HPZxJesPXhjDScRWdimjAODbRh0Cj6YpJXXkyD048JcCdAZQe
   fLDR7u2pujIRsdyTSHRrwqbc5+lErnE329pkUznAnd/PuZ+56ecnJ+x9m
   Tl18O5hnhaPEEN7yXqPzImPOXtBq3MRWwMU0wNekB9TE31jF8ydSfZR9l
   rYvEieCfZZto0aWvTQzs70fZNocJ0RKtk9m4jZK0SCQMq3p+SVCpnPqWi
   g==;
X-CSE-ConnectionGUID: 8duB8k5NSGadSeDsANhvzg==
X-CSE-MsgGUID: hLe+S+m/RjSQ9Tko9cY+Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36993609"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="36993609"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 12:59:59 -0800
X-CSE-ConnectionGUID: GJci3ctIRSmZj/0W2QSgWQ==
X-CSE-MsgGUID: LZjWkKtBSZ+pFBqh3f73jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105099449"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 12:59:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 12:59:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 12:59:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 12:59:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4lQF7k/X05Ts9sN84GE0A+i91nGLcq/lGo8P3Q2ms+T9tjM4LjDEfoUp+rFq075ge6t2aE9JtdxaEbext67b9DkBr086gnizDx00QYJuFCdTmLGDI0B6vBlJ3hfmn3xpX+bxjaEU1/i/jHqZMjW+o4UmgAY291DmyByiYaY3q7zQO99dwpbmwRBS6dqlF1ZA1uqrxQ4ywzvG4gLYVsprIQyfwraqY8QvzlHB3VoBTGG3JAgsdGSY24pttXkYaQkKWchabJ8C6hb25BI7S7wa7qADUbYA3+KtdrsK8y7UK56D6sHRIw0opV5O6omN5GNVafmdSQVmLx+Lj5ox4y8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2g5yRbY0OwxSS2+riKbA2Y67G2SbVeeV31vZh5D4n1Y=;
 b=mdZtAcfqEBrpPkCqPE+JUXRClmmbPcXxPFs8kQAURikJ/cdhlfEiJFmKn7jNTtyQk07QeYeg4ZQZPpWGbW7ZtZ/Hg6jZzYRPIXhbTrKZSM7zhWgWTdxLFILfT69ClmFrNVrgLVzFx2xJ+XvM1KmXWQANk7uRRCxR3mV6NmoEOI2daN6FLZSvIDn6pMvbU0E+wvPJ5bFV+yFdJRsmL4PhMHFf4YpWMaVHKhsFzJm3bmcheoyJ5mSsW/PxBO03IbQZ8DNfr2pj9s2jsoLMDSGLj6Dm4B3L+lTdsDAhzvMtDEN8BgE7vkpq2zN+V4nB4pljfFb0Scp/aAddNB3Nw/lyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB5065.namprd11.prod.outlook.com (2603:10b6:806:115::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 20:59:29 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Mon, 13 Jan 2025
 20:59:29 +0000
Date: Mon, 13 Jan 2025 14:59:22 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Gregory Price <gourry@gourry.net>, <linux-mm@kvack.org>,
	<linux-acpi@vger.kernel.org>
CC: <kernel-team@meta.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <david@redhat.com>,
	<osalvador@suse.de>, <gregkh@linuxfoundation.org>,
	<akpm@linux-foundation.org>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <alison.schofield@intel.com>,
	<rrichter@amd.com>, <rppt@kernel.org>, <gourry@gourry.net>,
	<bfaccini@nvidia.com>, <haibo1.xu@intel.com>, <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>
Subject: Re: [RESEND v7 3/3] acpi,srat: give memory block size advice based
 on CFMWS alignment
Message-ID: <67857eaa6e284_1863f329487@iweiny-mobl.notmuch>
References: <20250113174439.1965168-1-gourry@gourry.net>
 <20250113174439.1965168-4-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250113174439.1965168-4-gourry@gourry.net>
X-ClientProxiedBy: MW4PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:303:b8::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: 5314e49d-5290-4028-e4bb-08dd34152c16
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TNKt9XYSixl5rO/ZGvaDOyf0tqNODQrSnRvHIcMXCzJPqH09xLIlEda9eyPa?=
 =?us-ascii?Q?dK2UMxTb0fFdIQ2mVfKN1d6o40mo4Yw/RmyUmec2l/mQGLTnPH3olZcX+UIA?=
 =?us-ascii?Q?ULl6+n9ORQsYkE58gdKo5TpYhWYkDZI056QyCCxmT8+NxLea2ldewPjR293+?=
 =?us-ascii?Q?OegUveuQXj2eOP3+eqeuifptUeoJYCeuRfwMIvaqEBg1Cp/I8+6Vtu4/3rpU?=
 =?us-ascii?Q?SQHKuF6zmzgGnrUdCOIf6HqXy965OESKqw6nsPyr6Tr0UsBkJVfT64BO7pct?=
 =?us-ascii?Q?v9vTOKOS2nuxFOjC0QHt4Sut+XnmlKbpr5S73zlBmOqE3HtjinOwgZAzAHeg?=
 =?us-ascii?Q?PXuiWqp+V4oK9H6jqjy7WRhjTy/aBCzmc1zvvfsaD5qfoT15dd2ip2yomLH1?=
 =?us-ascii?Q?mrMqNfgWr3+eLqDVTF5H8niY2NgzoC3MC4Wm2/1NpW08Y9TO2U0dx1ztcKKY?=
 =?us-ascii?Q?pdp7Sgz02BSHXd255Fd1U7fQoBDryjzTNJeVugfJEO744gfASxM295ZnPEr5?=
 =?us-ascii?Q?LjNjkvsBgerpmm7KLMTvnVRfe5aoaSmix0GCOxE1tLPJyWpk/ifiF41t7+xm?=
 =?us-ascii?Q?ollc1lKEV/ZHGjjPH+xS8Vo3LIoyU/YtWyVgldaxXOrEl32Kk307N8RCpSto?=
 =?us-ascii?Q?wcRT9/K4O+HK+DlXU9andOkO9Bqjd8/p9AdTbQN2QyHCZ8TSfxg5AB+2L0KC?=
 =?us-ascii?Q?tS4YXgksFgKchcSEsLd56A67sxpTGf0LlI7ptXuvUIBtX9OAhM9uZ/CfZEWW?=
 =?us-ascii?Q?33NTLy92qHOcycA7qJlAnREtmefKBXpQVimvpIi8EEWtMNJ0DLisNGfbAEbU?=
 =?us-ascii?Q?eF1dnejyPRxBh4OnDYSKWhc+bJ0vPWUIUuOz8G8qFy6+ElYBqa+ffQ272Wkq?=
 =?us-ascii?Q?jCSLIQRLnA0ozwAEUiXhMPm9ziUBinKiV7J+2yXYJwEaPxAR9Ktsjjzo91I7?=
 =?us-ascii?Q?KJi6ltq0pO/XMAi/7bvzdZ9u31lSvFK2YjpvNkiGdsqmnAs5DdijMxSn0DSM?=
 =?us-ascii?Q?Z1oCeGU6iA8QexXm7myEW+C+iW3MNGGJetMReJm6t57DrCgs72leRMPuDpCp?=
 =?us-ascii?Q?gosCYGypKkbx0lobipV9SwlpSCxlOxzBYOI1OjPzXuHib4adQ86RdJsZntZg?=
 =?us-ascii?Q?YaX+Wr76cEF8OxH07UrrewLLYWGwq3NB+rV9f5Wzd0xU+xe92MDb9GB1pPxV?=
 =?us-ascii?Q?SZ1yPPwpnJAraAdmaco7P8DFKvegkHDZU6gP5n10T2lmr7FKY9VxhRG10v/9?=
 =?us-ascii?Q?X/VrpcWHh6hJCgrDKTDLPlvQf5d3x5Ff5E/6q8Cu8Qzb/l9sqDdIfuKiunfQ?=
 =?us-ascii?Q?jXo2t5Ii1iVVl6c5/IvrlzMfJbu/JthMi1hgiSNSYQN85WrSZVMd45iXuk5u?=
 =?us-ascii?Q?sm+eUZXODt+UFkzBjUYV094ptLhF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wRBIHUG5kDOlKXpzntvM+FF5P/kiQuHpzv5r46ZvV9YGdwBy0QLmTn8uCYhQ?=
 =?us-ascii?Q?DVZEQ6Yf0LP6354XN7bnM4hEGb65YaWMBf/S5gRO7vfZuOwmc6sak0zAT1ga?=
 =?us-ascii?Q?BfwnmwHIxQXVFEWWAk2wgybOcRuPyKqOc0ygNsW8BONbG/K7BtcmloZrUYVS?=
 =?us-ascii?Q?sHjv+naPfGZbAYrStIAQYCdzM7TSS490xSbGZdUm7zagCq+nKOL4aUBf3A4d?=
 =?us-ascii?Q?2h8S9BR8jipPo0TCUpH/Y25wq59FBHtnmXAJQ/jUlaOKDl+mgI53fUpyXeb5?=
 =?us-ascii?Q?l6ni1IJVQfZHPaNedBIRdjQ7DiydvHSUH8hkjHDPa6cJcuv3LznvVi4netJL?=
 =?us-ascii?Q?zpzutoV1NafKGGJmxVS95G5UyUAiLEcZJk1wmeTa7znoUCN+EBGiENbO6UI+?=
 =?us-ascii?Q?Fxk6SAI1G8PYXz8G2aWLSGmA+VsGpMgExqegf2LeK2AUIzPerruos+vaQ/7h?=
 =?us-ascii?Q?mnVmAB4zFwwYsaT07OecuWZfHbArQL0scUqmdBmUSVnLXy/ZVizPhc3esIxc?=
 =?us-ascii?Q?hCYkohmUFQ+DrtFhYz0G4DJoIQYpZInduN1q9aVRbjixXMidtFJRyYFQyx8p?=
 =?us-ascii?Q?pw5QMruBvFrTTVLHUmeG1+g73Q70mOwassOYe3qF2VCuUelkmzE2hKSiuRvI?=
 =?us-ascii?Q?V+/zSmvPLBExdSnXLvzI70ZZ0oCMzwMUKolkDeLaUswnmdCpBw3AVrEEy2Vo?=
 =?us-ascii?Q?23FgmOqipoyPw+yxPxSbqTkcOzXGXeK/G/L4b3BdFDG9ihzmlb5nfNQ/6s8y?=
 =?us-ascii?Q?pfJkkmyfXqSKeU+Iw4aGOJg4EQO5v375QTbT0PcRJlnq+k3x4jFcN1eYfUAF?=
 =?us-ascii?Q?d+fNaWaJH5skuJU2KHDuByDIOplCe352GIsREYD8dLUXOJmRy2nc4oj0t8wX?=
 =?us-ascii?Q?uLOaPKMEd1ZNUcsxiqxq5rusKsnz1yMQV6oXZHuhbLomfmKsgZ34G26nL2fE?=
 =?us-ascii?Q?P4j89q/Gjq4QwBAAcbyyD4d489VDCxMBcRqjK4720tI4Uv9cLcG6x0rNbVU0?=
 =?us-ascii?Q?3EB+lIyoZ90QGVYAOnpB1a6CBQsBuH/hgQoIFR+aP6Ia2qkWaVFAmvRnYw2l?=
 =?us-ascii?Q?VWeTXNlxYHAQhI2fMs6cbwmC56op5cafXaGLsxGkA1Mx+t1GveEaCyj0PWgL?=
 =?us-ascii?Q?O/JvWx7zL1w3CNMFB2KuZvWzi4AokAAtOWkiwMxx+BYBAu3BzockZEH1pNR1?=
 =?us-ascii?Q?HuJNIi4DovGYOppRuwv8R2T3tbNpPYIWl5WL5zXNnSHLLyD3AzGftMGMmbYW?=
 =?us-ascii?Q?bcS6/zKsC2Gc/2rJi/vALkOo+l+ZC6Oknexr1reHaRlgeUE9FehN0EO5Llsv?=
 =?us-ascii?Q?dFmG/uCOPzXZgau2pI0uxmZpIKtt3TwAD8MI+LU1ElBNqPvXqaB+B1hTkvwU?=
 =?us-ascii?Q?iOw7BWW6u0S4HbGq9qWUoxDgr2todMPEgtH+xgGdrPeZae5ibciRdCIyr6UT?=
 =?us-ascii?Q?L30Qjp1l5BP7J1Uxt5hdaXUOAGyqLnCfKxllKRBGEoXY0DJ76JM1/eQ+p9vT?=
 =?us-ascii?Q?LmjJ1Zw/zy4c7VV1ONDb+6+9z/KMP/stTU+7lCQC669bKaQuFz+RfP9fZpgF?=
 =?us-ascii?Q?lI/hpkfukSD+jXw+yrinUWZGTVd7tpupWpn2hUdt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5314e49d-5290-4028-e4bb-08dd34152c16
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 20:59:29.6889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXR3S0G2W0DPQgPOUQuQ7YNSXfaj42K0EodASLYR0WIKdBrtKWlLoIiUOVzeKNF89hmK0l7Hoa+KMfDvQFKkSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5065
X-OriginatorOrg: intel.com

Gregory Price wrote:
> Capacity is stranded when CFMWS regions are not aligned to block size.
> On x86, block size increases with capacity (2G blocks @ 64G capacity).
> 
> Use CFMWS base/size to report memory block size alignment advice.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Fan Ni <fan.ni@samsung.com>
> ---
>  drivers/acpi/numa/srat.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 59fffe34c9d0..7526119fe945 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -14,6 +14,7 @@
>  #include <linux/errno.h>
>  #include <linux/acpi.h>
>  #include <linux/memblock.h>
> +#include <linux/memory.h>
>  #include <linux/numa.h>
>  #include <linux/nodemask.h>
>  #include <linux/topology.h>
> @@ -425,13 +426,22 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  {
>  	struct acpi_cedt_cfmws *cfmws;
>  	int *fake_pxm = arg;
> -	u64 start, end;
> +	u64 start, end, align;
>  	int node;
>  
>  	cfmws = (struct acpi_cedt_cfmws *)header;
>  	start = cfmws->base_hpa;
>  	end = cfmws->base_hpa + cfmws->window_size;
>  
> +	/* Align memblock size to CFMW regions if possible */
> +	align = 1UL << __ffs(start | end);
> +	if (align >= SZ_256M) {
> +		if (memory_block_advise_max_size(align) < 0)
> +			pr_warn("CFMWS: memblock size advise failed\n");

I wonder if it would be good to print the return value here so the user
knows why this failed?

But either way.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> +	} else {
> +		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
> +	}
> +
>  	/*
>  	 * The SRAT may have already described NUMA details for all,
>  	 * or a portion of, this CFMWS HPA range. Extend the memblks
> -- 
> 2.47.1
> 
> 



