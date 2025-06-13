Return-Path: <linux-acpi+bounces-14359-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6E2AD934D
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 18:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16DA07B1851
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD3121B195;
	Fri, 13 Jun 2025 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ip7HvWyI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DED212D9D;
	Fri, 13 Jun 2025 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833789; cv=fail; b=TRVpYBCR6u5w9vraYfFDN1thChcYzwklPDRh7x8h7ba+yYnb+THxa38Jbhku0+73Lu1KE0EIH7se6vmzSgmgQnnFsZUClNLiGQlBA5JntYE4jL+q236dhBDHTV8SWLDnKlYgbXueODnD5KO79QIh8LwXOt0Ifw4rP14dQIix12A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833789; c=relaxed/simple;
	bh=3ZzVxZJDA8Y0nKqA13Adwgs3/67iIOVyHqQMi7rhnwk=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ctH9zETX2a1jhv8utk9X2eoV4B9nvfhNw90IdHHuylRShYndlQqJOMwatRhDHDC9OrEA/SZWX3Mm62t7tMwGh3FU4/tytoWxJzFhLmjMiDtM4Yp7iZkJi3W7wSzvGPndlKDXIAGR19A0qc5U/ReGA/9ZAOYitgRKMYGkGFzU05c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ip7HvWyI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749833787; x=1781369787;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=3ZzVxZJDA8Y0nKqA13Adwgs3/67iIOVyHqQMi7rhnwk=;
  b=ip7HvWyI1Q2n1gKlJJ+jF2BUYL/4RWiTilBbUvkudMUlRKF4vTNaZAbk
   kmoIvRMtUvw2h9fCyYeqQoMYU93O4WzVsu5xUDxLdb4pZ4hw00dn02qcz
   T9ivWmGrlacIFfnITn1wSSayfEp9n8E973DKh78To4NEV/H/NL1WFUJ8Z
   68izP2ss1cnsnvbYc4vfrhfmUbvUkwdMLEEVTiShdyeZ06LfcNqO/9Xai
   PzasEfb6DVfM0wft9cRyL2/UNjhvT/eCuIuDLSO8bQFrFLqKu7IWQyKvt
   Z0fsFi5gjkupPzU7GR7JKQIAVPRRDtT50BwAk1JKnOwAMvLVH/CMyfF56
   A==;
X-CSE-ConnectionGUID: AUCjksHIQh2CZwRMc9L+kQ==
X-CSE-MsgGUID: W8zfnQ+LT9+lSKjuYKOofQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="51973100"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="51973100"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 09:56:26 -0700
X-CSE-ConnectionGUID: mhxjyiPpQzWMS+WVgqrfTQ==
X-CSE-MsgGUID: m9QMVTr0Tb+2g0Z+ZZFRDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="152639687"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 09:56:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 09:56:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 09:56:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.88)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 09:56:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDqgy2ccRgiA01XNaKWjH8IfUVhBHyOuWYBcVY3vQ/ExJjD3ot398Rnktrmo1WwnhgTWKNyyQ1WxJUwjtyiXPEthAGdFJPNepacHprbAneVyIAZuW1Fd0rXprHnfYeB8Gi7qildGgylWF0PbXsTs7OxDWHFrWj0E1I3XOBEqum3BNnKmKwx0p8OeJ9x4mTDeg5ijTtUXIWVtBFVaK2uV/G+RxripMRatf9dpE63JMi9vlz90XvlMsi9H8qwaWI+CtnJ5Ruk6Sq70lPykzbk766+IKbR3OpiF/BDyTNbA5mHMVBYhzG2DhSQ7w15VUkY3PLo//gLyUDcO4hwNwocrpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFS5YeSMDYc546qD9IXGfGnYFai2eVd9MoqVibuxu9o=;
 b=i8SVfBxV7IBSxh5IyaPPw7QHEVJxwjhyFAuoo7LftF8V9sVoI4Jo6h1DEnBKp/Le+iDLauth+ScfpeL5rXakxDKHnfG8sRVWVB1e+SGlDDaxea71jpiV+ujN79tK9gsMEJCMDqMCgfGG5qLRseKw4jNgsxJ0xbPEa5uxUu1QUHrHCCdQXfaaEFlXfv1UhyIkH3mgPO8Co6uj9ER06AFu6SLTFNWT7RmArLnX4boXziViuCiZg/nZqfNB8wksJk7acqfSXNV8OrBZTk7SYhe71I69ICuoyKA8mG9wFvdy2lC50PJcrCHxZ1PGCmgrPA75Ozc4z7trMBUhCoYIPz1HSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by IA1PR11MB6099.namprd11.prod.outlook.com
 (2603:10b6:208:3d5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 16:56:09 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 16:56:09 +0000
Date: Fri, 13 Jun 2025 11:57:17 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<Jonathan.Cameron@huawei.com>, <sudeep.holla@arm.com>,
	<jonathanh@nvidia.com>, <u.kleine-koenig@baylibre.com>,
	<dan.carpenter@linaro.org>, <viro@zeniv.linux.org.uk>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<gregkh@linuxfoundation.org>, <peterz@infradead.org>, <dave.jiang@intel.com>,
	<Benjamin.Cheatham@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v9 4/7] ACPI: APEI: EINJ: Discover EINJv2 parameters
Message-ID: <684c586dc0268_224888294ae@iweiny-mobl.notmuch>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
 <20250612231327.84360-5-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250612231327.84360-5-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: MW4PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:303:83::14) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|IA1PR11MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fc34ef-f367-4c76-8c52-08ddaa9b323c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EL80MLyU/NkRJH3yoB6b9oHHNya8zGl7JUD4fNqbWTZLC6NkNXJp73zbYVog?=
 =?us-ascii?Q?qagQ0KBDSB80+6QRzb7nqO1s3vAwTGFmTxE6kRXOM/SKtnRT1iNe80bwTuND?=
 =?us-ascii?Q?EZL7fp7GPX8w3LNiPwegIOgzO6Kyrk5rjf+FiVR2DViWsfty7AbqqDHYkHka?=
 =?us-ascii?Q?kEjwor7o4nrX8FK4JEdLLtnh7eu0MUmvLJ3CJjBvd3uQ3+D2nyTWWtxxlTJO?=
 =?us-ascii?Q?kfMFeoQ7TgTCrQdPJpw8wmle/HibX7XSH9YRHLqrl5TzziaYjnIw2EqoAim0?=
 =?us-ascii?Q?zcyE784PWa2OKxDWA210XZE2p/ok9aKrP30Ck7uaiOUzY8I4QB0RVmlS6By+?=
 =?us-ascii?Q?g/RazERtMNbJQ8zTnh/P2d6kGLguueoPA6DWeS3x4wiTeRDxZqwC6zVv0Kap?=
 =?us-ascii?Q?s3GYpA4enwBF7ZlJWa0lcpt3DZTynJei04OJjK5zfJzeSBKAuZJpDLf6L6vs?=
 =?us-ascii?Q?JV4psh8TriswIHAtC+VlZOzxI2YYpsJr2QoQ55fP88T2IhrcROGXir2uAu/h?=
 =?us-ascii?Q?mchriibq8VpzndNeUcOYJIEXJ1RIUfgdNfwsMvGQJZVM1+4TfyiqseGJBEIf?=
 =?us-ascii?Q?IlwfSkDnmkbO1TWdbWrv93nVMmpfZOjArVwXkhXZ/6N2HDK6XTC1PKc2XbY6?=
 =?us-ascii?Q?2MQceXVSerUnz6ugTfCPMb2Tv6aWP3tbohuZtMBAQAHQ6qybD74Kf04ms1rp?=
 =?us-ascii?Q?TvD9ZLV5WjtN68QQU/rjZwqnJRGycP1vpUk/g7914VAB41LoxfruLGFq0iqP?=
 =?us-ascii?Q?9MDC5QQfQepCBV8JGw8PMSPh9VW4P+KpCl7WLJH9Ilz1HMAwP9wWRcmqRDDJ?=
 =?us-ascii?Q?HYLqeuqYIWsFkkoT82XGOY4R7nLJE3BzIKVaYxEP36YNFXJAZQm1LIjqraBV?=
 =?us-ascii?Q?Y/Uy13LKDxquZRMoO/NVOKBW1m1Etsmojo5HLhvYQIBCIQfn9bf4GeBtY5xI?=
 =?us-ascii?Q?WOEeWFDtLZXVIJUGCMYCL8/YVM6JoLb+vLWyhIwYOWqDi2jvRUhFVCOQnBnd?=
 =?us-ascii?Q?+G0rOXgmQfgG1Bjkn4Gkr5eGCsL/Y14pKcCRj01C++pQy6DYO4D+A900zfCT?=
 =?us-ascii?Q?oMyXg4YU/CdgOrhIiOTuvT5vIPi18MDV2ddVkRz0V/7lAL4vFalhPocP7IxR?=
 =?us-ascii?Q?Whq3d5wQVN8VDqQHF63FPd3uic56sK1Up8RYg6ULp6R0sVzpSZECNh1FFR0i?=
 =?us-ascii?Q?fh96JNWQJWfYMCcoU5NooVdzewQSTq+I/X4U+xU7UBp02XtQPFSauntbSCx3?=
 =?us-ascii?Q?+CckjNNzli32VDGPmd9zPW1WN3QU1kpLxC/qI97QEMDlya9rdkW5NgVljKgh?=
 =?us-ascii?Q?eTp3m/pb6Ygu16HK912/F8RMBFs1/KUrv9LaKKQzz0251oocxNybtxuEzWwC?=
 =?us-ascii?Q?5Rkrk3UQ5N9yGYWS6RcihJNu9lr9/OLM5N6HmeZGbBjQPOd66VSvCG40Q68q?=
 =?us-ascii?Q?+jZ/5AgQ9nyEhmaX+eU2uTUHntMmHW3b//dwWROgjQh9g+o6usj9mg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UmKz9kLGgCggS3nbeI24QOxxg1jnzrmQOVjIxj93EZNZdgypykSFfr9/vwgg?=
 =?us-ascii?Q?xOEEoPgpddxlUt5NjcpefG9HCdyQh+YFWt8P7S4Ht8bJGc7CHXN5VfzcsmWT?=
 =?us-ascii?Q?Qw4GvV2F+OPF1s+HnJFVexmIbQTYZPZBKVsxDSkKCmasBmWc+T9joa+liek2?=
 =?us-ascii?Q?AL3CEaBVJT1zG1hs/aDK0DGeONG8BpvKKnqZWwJJQIe886vUIjZpzw1Ku5o/?=
 =?us-ascii?Q?tnN3NIJg28ehzeAVgG7EaczBabcJwyPdZScwLJA0+p97/wnXntPcvqJp5Ju/?=
 =?us-ascii?Q?Mj8uc1eiRzn1Mx3veYn8Q9+xmwpq7nZ2B9X4hWajrmdH+a8zHdHe2nuLsMuv?=
 =?us-ascii?Q?qqxasgltA6MEYAzL/DkNGRTz4xcVC7+gOzNEbHzt77TbR4Wn59mhsp8SKa9A?=
 =?us-ascii?Q?xpkANgJMFxOZEsYhnDs7xa5briGrdInYbHtdAq95X0cw/emKLVQv0yBJIl3V?=
 =?us-ascii?Q?IZ3VVXeCPF05wrie8m3jVOPIdD2TfCt+YNc9bCC54ZzKWCEWvVPV0gwIUDwJ?=
 =?us-ascii?Q?tdpfLMvE2XgaV5JozY3YpoCZRvXwMfj/49nFWsK3un0B8Nl5gnhY23iOyJz7?=
 =?us-ascii?Q?zKjQPSj0b9HH76ykLKWdOAcWCmhIQpgWtJoQuaJrRfeSprsvttELFQKmagvj?=
 =?us-ascii?Q?HgV4fTZn7SRolXyiT7U6e9MsP3z6nxjv8Hu7hB08WjcIPZOrKUhCgQ0ZGVG0?=
 =?us-ascii?Q?s+PJc5EklyCjWM2sD/Vu8b07kLGFrJ23OE12E0qypEiDQIH8b5Zg6/cGGd+Z?=
 =?us-ascii?Q?sKWOKBC0BYsF/mLWz7byxZl3rH0w6Ek7p8xG5flQ5tAhld3Kloxjhv7Cdwoh?=
 =?us-ascii?Q?jfJ0ZFX7xKUEwhbG+twe0q4gDrHhDEclk+A70WlC44TWTP3EYBTjjxjX4hid?=
 =?us-ascii?Q?jdzTK48H/Zc8l3HSQtJiC4Nq8x02tL/Rd4A5jycohrXFTT5d+FCzVpV4V6MC?=
 =?us-ascii?Q?4dt1d+YsItihhmlc0QBmnSmLye1FyNldreMkOwTp+PGHIQrd/o1jntLQxTUg?=
 =?us-ascii?Q?zzn1c5DMyQI9Fjt+hNivcqOfHcF3Q/rMMGz9dvoqT6nIO11Z/DhTyGpLkIb0?=
 =?us-ascii?Q?N9GkgvnELsfv9u0jG2z1eewmXu/yN4kdlecRZFKyPwL++LLPgqBt2iBKlZ24?=
 =?us-ascii?Q?YF5oLm1sGuQAUVU0q9cbmeBRGzz1RamFyTEcsptleE0a/gvlScc67IGWVKRm?=
 =?us-ascii?Q?4fasKmpXYtyr+22Tq7SHnQqQXT4b4ceqhnIn+mn4lyQJR7gnX7U1+g7SYNKN?=
 =?us-ascii?Q?eykyyW3hYeOYPGrI9coJwlaAp9YOHA4LTNF7IeAeF8GPmLvbWZlUMhwcLTce?=
 =?us-ascii?Q?tXHETLn0hN1edr1S3McqGR5unxcONeXwaRx9udvy22gSOjCZ2zoXk8g5jQHo?=
 =?us-ascii?Q?Aw8cQBdaE0m05B9WoSVm2XQW+sAaYMBrHFIGIzeCM7ZEfYTVP8Mhq1bKu34R?=
 =?us-ascii?Q?WAM349gbwDPUU6ODGh8hWmx/iweLNUImX/MxH4xkp3rLovYfxGwY80IvPDTt?=
 =?us-ascii?Q?ORIuIdeO4OH2HyZQimPlZmtNbPL+4FNz8sCjj6NQwLsEdqlvKkJFO/yymAxf?=
 =?us-ascii?Q?LLiLYrKhIdxS5fivn2VNC55DbIr/Sz/NFInicvxE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fc34ef-f367-4c76-8c52-08ddaa9b323c
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 16:56:09.7086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGZkgfqZ+o0QJE1mGwihVyv1RmD5v/OhW/WWx5w15GN4KhybFOHtHLaasJ89D2AsOqC0RipSaCwkAxMQWDo79A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6099
X-OriginatorOrg: intel.com

Zaid Alali wrote:
> The EINJv2 set_error_type_with_address structure has a flex array
> to hold the component IDs and syndrome values used when injecting
> multiple errors at once.
> 
> Discover the size of this array by taking the address from the
> ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS entry in the EINJ table
> and reading the BIOS copy of the structure.
> 
> Derive the maximum number of components from the length field
> in the einjv2_extension_struct at the end of the BIOS copy.
> 
> Map the whole of the structure into kernel memory (and unmap
> on module unload).
> 
> [Tony: Code unchanged from Zaid's original. New commit message]
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

