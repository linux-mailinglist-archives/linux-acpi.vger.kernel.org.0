Return-Path: <linux-acpi+bounces-12485-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3FFA7273C
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 00:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F12188BFB7
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 23:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D621D5ADD;
	Wed, 26 Mar 2025 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7GO8M64"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C3818027;
	Wed, 26 Mar 2025 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743032941; cv=fail; b=fMtGy1mZVw0DUjAbj3pZjrKbZ/pIF7pd0xXG0xDo0XPUCUaobXseK7xxI4MR9M+eQhiq3lUiOvM04tQ9QMcensxFypXjo81wN+t435gAKiEuMsUWNob69oJzqa9/SUY9Wfd2GsAgO6uEyMnfcARdOXMUJLPtGpLXoBMmixk6tXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743032941; c=relaxed/simple;
	bh=RHGlvVMa1LsnQNO4ECi+6tmB3EWMVzAVc5onYNyVhgM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MnbDgPITVr1AN6QsFtoE8GuS3IrQ+gSdbuF0d9YAZm/WV2gdAeBPoBAbqVXpgtXHofbvZrgc0jRXDN5weXYvdQ2gH/4eNJ59adv1rm8z23MxMVgztgXq6S2nPQsV63cpr4Dd30ZsPxBCPwncUvRjm24kw2YsAdKQ5iMBxliZzPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7GO8M64; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743032939; x=1774568939;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RHGlvVMa1LsnQNO4ECi+6tmB3EWMVzAVc5onYNyVhgM=;
  b=l7GO8M64NzyJnHFM1WmoS8/QVX4tvkR+QWsWmcipoQNEABAnidNrUC9c
   DWBiS1kwtsXOX35u/3pH5ExuxEorGgaJf4eigGnlGsL8pK3MPeHLuTrv3
   Sg4icmQB/K2asaw1059Li5XO25gIkcY3bLenJ+vRQNmhwAVA3XDUwAD6k
   2wMbNz830fEsLdw8QWetkoUemVY8EHAA0xNE0vMMFnBcJbDBPTV5Gfa1V
   qbTVpwn7PSpqISSnFg2/neEKrT09DhQFS6YfnJlVx7nhRJ65DxuFwnc72
   8M25uEfgjnpFUYgCEs5EKULoBxup78ciaQ6Tizy0P4sZ8ya6UGgqORODn
   w==;
X-CSE-ConnectionGUID: 80J+HzUuTlixR2V0R4vg2Q==
X-CSE-MsgGUID: I1tB963bTH2N5yAYEyKuSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55721842"
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="55721842"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 16:48:58 -0700
X-CSE-ConnectionGUID: s6h/wvlrTJKFO7qhIOzVnA==
X-CSE-MsgGUID: VfkGshXKSdK2s7W11C3vSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="124707995"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 16:48:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 16:48:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 16:48:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 16:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRgFM7Ke8YjAYQn5p7fCUV9YcSq3l3TdvZda3xgbUJ3/zlDYkiFvaGFuY3cgv761wU45SepbBBWIPHWhSFnJc6EcuWPm34Pql052MgYBITZc4dMzRphvVz1Iro/vBiHZWtRgdFQw3cc+I9Q4oM5CHELTGr6T4QAS9o3YQqPk3EBoJ3kY5f2BNll5YQkynns9fXBiEhr6mwom0j+wqxvye3CMVBipV4cvmm+s0jIcFLx5CgdzdeizQM7vLkIG3u9xSh/nbmBxwNa44erXLcYt34Yrtpei4Tc8maUopktJP3/6i+TZw6Kn+3SFg2+RL60vUFww3f0ItIiPj3a0Lz74Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rGVTyne+pd7qP03st70JnTcyV8FPeeP3bI1Dc4AWKw=;
 b=TVclzTvesLujCGIi9RQwUfKsDkY1EG/bSh8HYpc+VzY03Iv3G7GWH6fqvGInubE9IPG1bINiKorlEk7Wj3Zxo5c/zzFUi744coeBv6JFuXtYUD3Rw9KKyLPj5WT0wFAgbQgAShGuxybCtMkQKZ6wluNdWMl65bok5LRWfGoEHq3lsuJTEaGMvSMnVpojDDkPZrbp1/R9LK/Bd9n959/++FSvnU1nWgFLs2SkA/0kY6GzCBgmDdhVZ3JNk+8/qvBNOsvvaxBD8zNw59lTE6HcjdWvioCl/u19qjYosMXzn7mrqC+zU37LHg1hgsIEFmCXpddWt17QyHhoEtlZf1aI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 23:48:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 23:48:53 +0000
Date: Wed, 26 Mar 2025 19:48:46 -0400
From: Dan Williams <dan.j.williams@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	<Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>, <rppt@kernel.org>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <bfaccini@nvidia.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <rrichter@amd.com>,
	<haibo1.xu@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chenbaozi@phytium.com.cn>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>
Subject: Re: [RFC PATCH v3 2/2] ACPI: NUMA: debug invalid unused PXM value
 for CFMWs
Message-ID: <67e4925eda2a5_13cb294fd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250321023602.2609614-1-wangyuquan1236@phytium.com.cn>
 <20250321023602.2609614-3-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250321023602.2609614-3-wangyuquan1236@phytium.com.cn>
X-ClientProxiedBy: MW4PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:303:dc::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cf0edc-95dd-45ee-cb1d-08dd6cc0c3ec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NQ+M0Vj90nj+6iE9Rt3jJmPLvHC9YS7ZzLR6DbHYsDzxahTzD5sxwULecFa8?=
 =?us-ascii?Q?YBS/WgRnkPXCWf9KcuAnciv9lgLjFo+7UI/B9Ja7pY9v0iXAqugh4vKU1H07?=
 =?us-ascii?Q?FK4HLfdsuVV1KcbzRfswd2Ii0LSzD74/n0ZS5vR/CZMnnXeugQ4RCkpqw6iR?=
 =?us-ascii?Q?3ARbXqi4AoAHydZlXWzFHqudxbzVcJg65kPjC/0fpSG8GC7RcBumooe1NX/3?=
 =?us-ascii?Q?dUsqFLMLm07zvvKPxURBMvnqSLrg+qyqln23A8FpzB1T87JZmgwBVYdjDV4O?=
 =?us-ascii?Q?ARcV24r49auoBNB/J9dRo7FQLDdY7cuvOHjDsPFtJIIc8P7EZ3QpPJnHoFVV?=
 =?us-ascii?Q?2TkSBZCSYyrg/l8fW7hjVgr0Kns2dKKeV1g9nYyaCHHu5GbQxRptbfYsG4uh?=
 =?us-ascii?Q?pMhnNfDBh39Q0pW74eT7+DZTyCCMqRWZ0k6zq5E7uC/C5oNnJ6/n4X+Kuv5X?=
 =?us-ascii?Q?iNWc25wUV594tFu3O0hl8mE8zWTIlpP7AcVt3u3mtbva38aAtYoaIHCGrTAY?=
 =?us-ascii?Q?4oHNbganBXXYgwfPxHkJwxXNT8Qqg+VnJqXCWDdO9/1QHp7hJ0q0HqelQ9nN?=
 =?us-ascii?Q?ma+i8htr4HUJI+fm/iqKiBKbe6knu3vGTwraDDU5ioTgVkAGOjFTlsP9e2RW?=
 =?us-ascii?Q?y8ZG/GgndVrM8ZO00biW/1iElXbWvneyt8MahLaRWBc0ruud5APFax3R73JU?=
 =?us-ascii?Q?E3MIhgR5/g+BvBjkAX0HptDtspBgpZXTEl3Ztbwe7tC6iWrK4DpBXQYSHrsM?=
 =?us-ascii?Q?uk8hIoQB7efQIg73NkOGjwpxVil90L0PwBto7AUw2oZnAOAI7Te3AptqRkkT?=
 =?us-ascii?Q?bJ3Ckwxcs4cFlFdGpZqKz1fkZ8KcQaYJ6S1/ifYNYrWhbr0F9qqXP5IQxU5K?=
 =?us-ascii?Q?8og/acBhnoiO1TdTH7jr3Y7Iylpcb7sMSYb6Vb7zCczsuWSpoq7LSZNTxrRE?=
 =?us-ascii?Q?V9nqHSvX81HI++dPuclVYdl+8skxj9BAZcZsFZfieQteK2F+mfLh02GlW5qH?=
 =?us-ascii?Q?Q0ZU0bMQTkVDF+voycO/Krs5V04UDp28SN4fhTRweH3r5NL1IITy6/s1Ytsj?=
 =?us-ascii?Q?FXJhjjxbx8PNJboWoJh2Q0R3aeuGACGMDnDS+4nRHoJfbcU18l9TfBNfKby4?=
 =?us-ascii?Q?naT6bmRergcLpKwZ45gYkH+fAze+y0feaOGqhfQd4tBxJ+LmWoXoBUPF1Tz3?=
 =?us-ascii?Q?qgsidcT1WWSxQewMwYETEeaQbXV03WD4fOV0n9mL7QhCcNvSQyDJ15braNq/?=
 =?us-ascii?Q?+kwihoM16OiaKJ5UAw+AZwjmkOt1f8zdHX9nl0gDcD4E+i+XA8eEb4d/iAC+?=
 =?us-ascii?Q?tDXqFt3vqLPzCY62V65Z/S8Bq7DmbCOiunZ+VJvUkV3iYlRbPr5mJNt1ZGzt?=
 =?us-ascii?Q?5ruGbU2Rr7Aky/F47rO9D9wtNcgLkDyZ4jq3hSKh5SeuBCL6uQpmtBilCDiS?=
 =?us-ascii?Q?XA8kd45hWPU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nm8TBpym3vzgSudZsgKljUqVHB326dc1/KG4yX+KFd1uqVrjhme/kZ0jEnrP?=
 =?us-ascii?Q?Y6wCHk5tX54SmMJJ1vGg4E+z4NluMWeymnnXM0N45uVgcK1KUbCn6vVUgF1+?=
 =?us-ascii?Q?Tc0DsMxC4wszGLD2eHePWcFHge4+/BSlCRaPqNMSMKvWgbOl3TF1ShY9iMEH?=
 =?us-ascii?Q?w+GnfEjNaXAAn9Z4TsKCRACuoR67S+0ZqiuxeqpoPoFM+uA0yadNN9Qy3tib?=
 =?us-ascii?Q?rBHjoik3b8ddZhWV/9SsDVxxPjpK8J3Y6wSzWiliZLrOKCt/3BV+/4luPRV9?=
 =?us-ascii?Q?/wO7KH6ChEj19Ep/ekx/EH2YggQSGSwfiD3vrM25OrYFW2TpsOmF5PMi3Cu1?=
 =?us-ascii?Q?9ArNHVI5O2/e3OUWm6Y90dKQAZG0eSoHzUXNFNLEn1Ru9MgxfAKFqj4DmSmd?=
 =?us-ascii?Q?VRItEkV5/P4zAXhzMY1v3Vou8+Z11lI14sQJYAOwRpMEjrmFboY25vDKzyho?=
 =?us-ascii?Q?qK4z5wntAaB+y4fPdpZwwZyjqX2CcvpiAfvRP83cv/BY/gIJT5IW7NfVdSQv?=
 =?us-ascii?Q?4KC1Ts+NAwk7RX5ge2sK4cmBWExUlCxGkv55XF65nwE1uQbZaKx4BjydN3e5?=
 =?us-ascii?Q?yrr66jK9CEozxp9cVqWC8zHXrXdyZ0hgS5OqKmJuIKZ8scAK7H8gxCowxYNp?=
 =?us-ascii?Q?c00PorSUd16dFxpWIKbtAKmNbExBpq3y6LdDNAWksUBJoYhfSC7OxvCWgk1M?=
 =?us-ascii?Q?X61iTGMjdYknSnqnOQsMdXSTzK/PwDtEqIded0csz+OwagVIvG5k4yixz53a?=
 =?us-ascii?Q?BscU4DLLCZ/QM2n4f5m8lZMt/q/1hA+4sFxYXbqKGdVTXkIaWYt+loq3/RF+?=
 =?us-ascii?Q?ynFdSheiJawBWVQApsu3DjfXFwjmr/jB6X2v4CIZy6sTHFpoBYzBsdmJSUho?=
 =?us-ascii?Q?ZpjRpz3YPvkK90drMPt85Z2YWdo85H7X+xLXYjYFfSNejgIwmJpxDX4MiREG?=
 =?us-ascii?Q?NC4juwN/U7DYhpL13tAlDgKWwLzgy7l6EjVB3fKlxlUReUrnMIbsG4gLgGN7?=
 =?us-ascii?Q?NxhVPVZFPKzgkiLuFA+Jjnpd6MEDcf9hVtDY7GFTyKBoDR+MuATjAZfUgp6f?=
 =?us-ascii?Q?+XPKZUr7ZRPrU2boNCFX6dZyUys+Sosc0cb2XtQlG4AZdc1DwW5p2Skrc6lg?=
 =?us-ascii?Q?3Q7/GC/phpMnfXLJQmp5OBpLlCKmMherG9MraxVGF+FFXgbFhAp9oM/xkCpF?=
 =?us-ascii?Q?5cNnBz46d7cCnQlG5sQSoD5b7XJDCEBMEPEI4L3m/O6OkRnu4VY7pjPJ5M2y?=
 =?us-ascii?Q?pQKdxLePEkSkQKWTZ4uB7nvKesoaxvXToutXKXCq+519yKUxHp2wwOAgT+h0?=
 =?us-ascii?Q?RCfshYe132junjykaaVnmaF6pmeJwsvJlocKHluWzfZKuXzGaz4uxpN6iM49?=
 =?us-ascii?Q?kxUNrP18+kB98dTo1Dwwt6Y3l0dMnrI2se2bzfsVVy1RovlzRvf4zTZb0d+X?=
 =?us-ascii?Q?7KWynTGh2WEh8RpaBKURRbEj/4LMz6R7YKFmXV8VgRh5pAa5ydHQfzQ8YXHl?=
 =?us-ascii?Q?VAIXBVrieg8CWibDQNztIFSfk/hw3k5gutLPRhypHcMzAaDgSY0PTruYUsaF?=
 =?us-ascii?Q?w3h8y6e2vrUP3bQvU24HdC6r2aBYdBzmgezq5Bti5jdAnB1EYw1loW78neUQ?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cf0edc-95dd-45ee-cb1d-08dd6cc0c3ec
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 23:48:53.4575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaOJBjSO1YuYgA6WSWCPd/h6H6IQ37ABmB/RbRmkQc/ZWCFmQrKk61YhLlmvHvsFneB10VIjebYdX7fmM1Rn2RBnhunPsskq5dTtXbXJghg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4523
X-OriginatorOrg: intel.com

Yuquan Wang wrote:
> The absence of SRAT would cause the fake_pxm to be -1 and increment
> to 0, then send to acpi_parse_cfmws(). If there exists CXL memory
> ranges that are defined in the CFMWS and not already defined in the
> SRAT, the new node (node0) for the CXL memory would be invalid, as
> node0 is already in "used", and all CXL memory might be online on
> node0.

It is still not clear to me why this is a problem. If there is no SRAT
and CXL is the first memory proximity domain in the system then it
should be 0.

In other words, if it is a problem that the kernel is picking node0 for
CXL memory when there is no SRAT, the problem is that there is no SRAT.


> This utilizes node_set(0, nodes_found_map) to set pxm&node map. With
> this setting, acpi_map_pxm_to_node() could return the expected node
> value even if no SRAT.
> 
> If SRAT is valid, the numa_memblks_init() would then utilize
> numa_move_tail_memblk() to move the numa_memblk from numa_meminfo to
> numa_reserved_meminfo in CFMWs fake node situation.
> 
> If SRAT is missing or bad, the numa_memblks_init() would fail since
> init_func() would fail. And it causes that no numa_memblk in
> numa_reserved_meminfo list and the following dax_cxl driver could
> find the expected fake node.
> 
> Use numa_add_reserved_memblk() to replace numa_add_memblk(), since
> the cxl numa_memblk added by numa_add_memblk() would finally be moved
> to numa_reserved_meminfo, and numa_add_reserved_memblk() here could
> add cxl numa_memblk into reserved list directly. Hence, no matter
> SRAT is good or not, cxl numa_memblk could be allocated to reserved
> list.

Do you not have other problems due to numa_register_meminfo() not being
called?

I would really like to say that the platform is buggy without an SRAT
and you should not expect anything useful from a NUMA perspective on
such a platform. Everything showing up in node0 in that case sounds
right.

> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  drivers/acpi/numa/srat.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 00ac0d7bb8c9..50bfecfb9c16 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -458,11 +458,12 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  		return -EINVAL;
>  	}
>  
> -	if (numa_add_memblk(node, start, end) < 0) {
> +	if (numa_add_reserved_memblk(node, start, end) < 0) {

This change can move to patch1 with the new justification I suggested.

...then we can have the pxm fixup discussion separately.

>  		/* CXL driver must handle the NUMA_NO_NODE case */
>  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
>  			node, start, end);
>  	}
> +
>  	node_set(node, numa_nodes_parsed);
>  
>  	/* Set the next available fake_pxm value */
> @@ -646,8 +647,12 @@ int __init acpi_numa_init(void)
>  		if (node_to_pxm_map[i] > fake_pxm)
>  			fake_pxm = node_to_pxm_map[i];
>  	}
> -	last_real_pxm = fake_pxm;
> -	fake_pxm++;
> +
> +	/* Make sure CFMWs fake node >= 1 */
> +	fake_pxm = max(fake_pxm, 0);
> +	last_real_pxm = fake_pxm++;
> +	node_set(0, nodes_found_map);
> +
>  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
>  			      &fake_pxm);
>  
> -- 
> 2.34.1
> 



