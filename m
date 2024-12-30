Return-Path: <linux-acpi+bounces-10324-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDBB9FE330
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 08:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF4D1881D20
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 07:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F2B19EEC2;
	Mon, 30 Dec 2024 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klw89KTJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D412A19E966;
	Mon, 30 Dec 2024 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735543536; cv=fail; b=QzpqsU8TeK0hMBiWStfGQToV4gpodb132b/uqZAWyBNtbMYP8vUesZp6GpeDgbq8JcB21Krnsdfi62CX3GTi1a4QL0wSWUiovwKMWIrrBhAvMTgW/Hafuy7rLnf2jPMqqXB6SSf7KYHorgzKKGOwLEzEN/6FLMtJ2TRMEOqepQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735543536; c=relaxed/simple;
	bh=6VImpxOfQxGe9JDhbD1cOWwdDMruoiNTUNkXvn4s8x0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qex1+v1jiiz92vseY9tFY6RXU9TqtlZAnDOu9Vp4wFWHAfIzJLZf05DCHGJanX+wpDZBtqgKDOrsY5qf7BGqN6OHZphQMsO5J2GTgeTURMNRONvMmSgN9cK3LYGph8JQU2yScAJdDDQo+6wgw5Xu3bjGQqRXdRNfgS9/qHTwzPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klw89KTJ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735543534; x=1767079534;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6VImpxOfQxGe9JDhbD1cOWwdDMruoiNTUNkXvn4s8x0=;
  b=klw89KTJFJWcPQTSAbxHlyCMV3dvCMRH8ERcyCqjf6rjrAvnUOOGv5nr
   9Myczve8o+7HeHuql+t8d/SMxGRBp2eKZ3U0ct2vjn4BaY8dKGv68eyCG
   IIoqB+dQBJ/AOyAYT1SHJZpcBXBTedVKoMy0KXXsWYTxtnTNjfjB8ditK
   pC4/kBeeIxgxn0zqhYWGHBqT4VuiiLKpTrPuvjQBY7qou18cuRKeR0Ln8
   LAzLfuEj7G4+D5yojQ2Hfys3Xn+wlmibCf0UEdvdBFYRh1UbXMBNCbAVd
   UwJvKM+Cow5BHsRSKX6DHdHZ/CKytQMzduUb1+J9dyhQaW9idDk502hRC
   w==;
X-CSE-ConnectionGUID: WxCl/DFKSrG8e5po4YUb5A==
X-CSE-MsgGUID: UASPECFbRNKGbTsLS8UxHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39513959"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="39513959"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 23:25:34 -0800
X-CSE-ConnectionGUID: 5O59YBpJSQiKr+UdXbI8xw==
X-CSE-MsgGUID: gz7kGIa+Tb2wV3eDVC2wyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104786291"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Dec 2024 23:25:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 29 Dec 2024 23:25:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 29 Dec 2024 23:25:32 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 29 Dec 2024 23:25:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNtvLLtd+WuBOsW3/a7r5gM1q2gN7XhViZPQZEKch13Dl4lWPswBPJmPcyDmR4iagFFvvnA2Ig11PJlDiXYzhJPJjLeEzek7XOXE3tjoNF5kxBNLuPPfJOvkfgiZBVvIGT6KI1hVxm0wHjBBPiOLFCPsImTYdudUlEj6p5J/37OYRHlVSKNi1Jyy01DZSF8H+bUrvXzs5ggHl0j1SFGS1Du0UmYhibqmrNAbwKEhBaGHSsirdjd2+qS/hWYgX9KfcVsbMnva/OMFdI/UFSxTi4AvqYy3rKdgzR+Q2Nb/5zLY42TB3Jeg/Zk+i/Qpux+Jj1PfeMJ8vY7RrdW2uksmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+ADohJDAuhobCFfAGyXvj5GO6W4TgJ5kiKNyiJixs8=;
 b=wcuqXbhh8W/u0/Jzm70pK+6V8BLa8TbogMdN6t0T6MON9sb5h+tjOBLDjB5OQjtVBa8g1HRR98wsBunVzJGqtpu2Z2LHszpmj/t+NOtQMecDXcB5fA+dRkMvuRW1gY52cxUgGWF6FnzLEckTCyArnztUcGT9CkPks/vIHKi1uBU92k297Rn+LBbSvisbklIExziDq317xw5pSXVxqbVkfhteugX+tjyGAaOQIrXa1nefwB29IvrDp7NgF67pNCPkKv3yxf5dxu/rjnVJpeDw0kZ1wxcAQzVOdvLBBrA0s1Gjb5gm/3b8tSVN+xX45d/ncVStYGCzn7EQb8Nvh3V1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 07:25:25 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 07:25:24 +0000
Date: Mon, 30 Dec 2024 15:25:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Joerg Roedel <jroedel@suse.de>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Christoph Hellwig <hch@lst.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>, "Jerry
 Snitselaar" <jsnitsel@redhat.com>, <iommu@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<oliver.sang@intel.com>
Subject: [linus:master] [iommu]  17de3f5fdd:
 kernel-selftests.iommu.iommufd_fail_nth.fail
Message-ID: <202412301525.87d1422b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 021b3bd8-ca31-4cd7-1576-08dd28a32055
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PtHfadPXDXdoPqegaElQ6Hf9r13zhhuky3UxSvwhINwJ8gqR+T32mucSsVnb?=
 =?us-ascii?Q?B4V3Fl5yW1J6cR8WceXYF3Kg6MmYdXfaQ21+Rs+7tel9+KnY9AnK0P0N+fSe?=
 =?us-ascii?Q?fxKBaEcKGb+xzl8KI5q0SMKwGOm+5e1ljxmF0pJZEP4IblAD1swzSC1gozDe?=
 =?us-ascii?Q?/1zhPx6zfuQ/PmRFMZo1o10vtgPRDMUx8qdjGPzL188QiYmPl1+sjiQYMLYb?=
 =?us-ascii?Q?Rzq6x5qn9zza1QezwtZh5jMPq+4wr+2GmW64QhgdkUBxgGZdIhP5zTwsvrj5?=
 =?us-ascii?Q?Jkx/cvZiAMwd3WG2rB4ZyHoBaZIZbEbQYYMiyaaCzlzimvE1MET1F/HuRyZq?=
 =?us-ascii?Q?Dm0wNoKOpw49tM99ePsw/K3lj+7lJarNDJhev2XUFHeL1l1c9ijcsyt6JnUw?=
 =?us-ascii?Q?TGURObtdfPGwMfFxkwWR6XwwjLbjye7040EBfyKKh+nbBlUuqRmi/NI91Mvk?=
 =?us-ascii?Q?shoVoUeJ/tpmtRgA9puYthlEDcHA2zk25A1nLYPluPh3LzkulXRqdOi3F7WK?=
 =?us-ascii?Q?86pwCNg6LM9nn85d/CvDA68HppeNX7nMu+rXaZ5eIMiFQ0rB8ZqOBX5jEkCA?=
 =?us-ascii?Q?7rk9UYO/GWTbu8VTxsMRYlqKh9oA10pZed3728kDbEU9svL7BARz7Nks52XW?=
 =?us-ascii?Q?yMG/i2ZaglETIJdEzsh2gD3uf/p4PnNxwXfWEHXD2y5Sgyta7orKfhtsQxJp?=
 =?us-ascii?Q?waeZKENhR0y0z9fFSPi2UvNl55vTbVbF2V71CLEqyJGPspPglQj7RMEf46bE?=
 =?us-ascii?Q?pQ6CoQQloaH+g5wqE1iu0mJeDAXJRU7tzq/fHKyr9wikBgOK53yn3WPtk8cV?=
 =?us-ascii?Q?sMThcX8fM+H9LiIrn3qvkRwHGbv1jA4Psu2EAbxa8pHr7Nv0NdRdYTO9soIi?=
 =?us-ascii?Q?7g+icu8kSmWdWp2hfeZCEVxL1XjFSESyBVcoAyAEC2KX4f9H8QqIOig5uSSF?=
 =?us-ascii?Q?10v/TUj06jHGiMTw5DOBk/hduH/G1acSk/27H9RbH+sDXqPbm5ZXMozMTFoC?=
 =?us-ascii?Q?rrlZpGIa7NAauz+wgTwBYDWdVtkmFUxLWZFIqeNXLi5kvWIDon7rF+E8pvgr?=
 =?us-ascii?Q?wr7rD6wYeuLkw06HTLKi/44kJ5eDXcWT2GIcY62C92HfzENbSSmE7q/jXXVp?=
 =?us-ascii?Q?QByhZ+2r2IIVNnpQ1NyjVSjr5/Q7UZ2IR99OdnHjNL1JhwAtTbjiadRZsQQp?=
 =?us-ascii?Q?MbKyLg/TDA1Ys9833Gt4mHdK9wWD+VghGbJOsKlEylYFfQYUaQX9CHr8Fm+k?=
 =?us-ascii?Q?e8oPtn+/92crMje68Zw3hG2ioltH2wZFCx2yI7oUyxCTlEiHz9sD94+dirHT?=
 =?us-ascii?Q?iGshrS7N4lmZHPYpcirRc9FULG6ED6c/ip+29SE+Kjn6Hw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HGCAwSeRHqdVnZGTxFJgyHvoovPUA1PSJkl8av59c+1W8VlGFR69mhZv8Owv?=
 =?us-ascii?Q?GOdNQia9OYooNJ7axDHdXojhETk/cI08v38q/sFahycHgWGPVIxOqfu5wi5+?=
 =?us-ascii?Q?fX6gzWPYX+FzzZjT9V3DdUvuEFmzyZgORJZ4KwFPkWddViPfDqtEtiTgADdb?=
 =?us-ascii?Q?pa3qQJIW/0hKePAOAgVOXK/htbZnwJRiitNb1l5VEJ/9LfjmVMXp/gGLdyy/?=
 =?us-ascii?Q?2OIxJ8o3LUBrEcC9J5Oeu3E1TjTdEhubIfajyT8wnbyOFV8THUAaxfWMosWX?=
 =?us-ascii?Q?caGrEGP74bFGln1oM6jSeRHp1f3LfQDZqJewOv8bK+H4Tf6CZibjb/kbsEgW?=
 =?us-ascii?Q?OUXOdXofogfCcK3LjmS/Bk1baQ3CokkBxZDE+Zc2UeHsW326XYEytHMc7bfZ?=
 =?us-ascii?Q?xXK1vIveY90ogNo8qVdZU7WH0TtDFc0owvHfPXseNYTMatDmG9Q3wYi2T7Nw?=
 =?us-ascii?Q?8xEMp8fm0HKMOfvX7yHLpIbfXLfo9sokQNDHi6GtyscrUPiKQ3imcBLdL5k+?=
 =?us-ascii?Q?3nqeGCsKtp/uhnU5AuXB36oUJm8P/c4xCgWhsLzFaiE3uNKRXrb0/kMkSRNc?=
 =?us-ascii?Q?uW2NYSk4Y3B1SHJxUCed5Fzc0NQB18elxuwVkEZKuTtXGSM8Jeq9SKe5nHtR?=
 =?us-ascii?Q?AV/kDTh0Oc+81qZNP01eogHLYn50Z4W+MYK81YJjszcyI7UZEuk9jZLY834l?=
 =?us-ascii?Q?9XtlfWsqkkj9OrcfP3+1b2a5c9G95P/C2T52HqVS8xMWEvQjdC2+x9DDcDWZ?=
 =?us-ascii?Q?PkJhJHm3z0peinea0IgCwQ5QSFkEFVhx2UuAuN85Cgw38PaALxLCK5pZZYhW?=
 =?us-ascii?Q?ijXrr6yyundi0dw3XXBLvNNokRaEekvV7VV21ksGELIHWZtt5rwfdVrw3eSG?=
 =?us-ascii?Q?eKlmedv8ofrjnaLnr8mKYXXj6CPi+NqPVsN07ffeijM/A/HasGucQG/M5S0d?=
 =?us-ascii?Q?0NJpB4FxqsUYkXcELuOeDhRoEkGjtxUxHBhlXKYn5D/TuB34+Dt/L0aC5c5y?=
 =?us-ascii?Q?21X0tsBlr8tslPmxU2QGCvQ61LBbORd2Bz+ui+zlyxTp47iPebwFV0kdoiBj?=
 =?us-ascii?Q?5521x+IM8KePfuD6XhW2ombIkDyI22HBliNx5+ME3TDylVep6IFWpEOAh8nB?=
 =?us-ascii?Q?0EUSZkr0m/JfiDw8K6MCLyhaNr4X8SNjUe94oeu68PD0ua22Ws0qFZn7Nwig?=
 =?us-ascii?Q?cid4qZ6zKqkW+dsKpKA8FIOtFvrPQiv+oErfFEOv5V8w3rC70oHqTwPB7Hv1?=
 =?us-ascii?Q?ZvN9v9HxdWwoq4zxE2duBRio6ktuznQ6VRyRm+WxKWzPyWsLvDdN4jB/0rrR?=
 =?us-ascii?Q?yr1CVraZeB9/ZjzDkJj5gxCqYjZnQHajL6EJrFdHivdeQIhCeW+iE6key+9z?=
 =?us-ascii?Q?jznTlwpNWHBRYvpdxGSKZYklBuOe0GDZz3MegK5BVD/QBZEtxEHCw4uzusii?=
 =?us-ascii?Q?e1SarHoKOSoKEJ4hth/TFdKmdOks7WG9V6P2DqMCECb+GEs1UJArC/c6s2h/?=
 =?us-ascii?Q?zfNFrRPx4Ui39EWE1HC+uivzlCE3PEoKrAPiGW4lk75vrOVIvfIjThfzjuNK?=
 =?us-ascii?Q?hCmnaufVC82UvSR5eMhNObL/F8DzJpO9aGTzcOpx+LrAICqP0UXkEBFWPQn9?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 021b3bd8-ca31-4cd7-1576-08dd28a32055
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 07:25:24.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C43zmXa4hltnwRJcEW7SMY5HZD+SlIEkQVsXV9n1saMBSFTeR4XJqwYUxSMks+1wCWLtG5be9WYWErHG93rSYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.iommu.iommufd_fail_nth.fail" on:

commit: 17de3f5fdd35676b0e3d41c7c9bf4e3032eb3673 ("iommu: Retire bus ops")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      fd0584d220fe285dc45be43eede55df89ad6a3d9]
[test failed on linux-next/master 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7503345ac5f5-1_20241208
with following parameters:

	group: iommu



config: x86_64-dcg_x86_64_defconfig-kselftests
compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412301525.87d1422b-lkp@intel.com


# timeout set to 300
# selftests: iommu: iommufd_fail_nth
# TAP version 13
# 1..7
# # Starting 7 tests from 1 test cases.
# #  RUN           basic_fail_nth.basic ...
# #            OK  basic_fail_nth.basic
# ok 1 basic_fail_nth.basic
# #  RUN           basic_fail_nth.map_domain ...
# # iommufd_fail_nth.c:299:map_domain:Expected 0 (0) == test_nth_map_domain(_metadata, self, variant, &nth_state) (-1)
# # map_domain: Test terminated by assertion
# #          FAIL  basic_fail_nth.map_domain
# not ok 2 basic_fail_nth.map_domain
# #  RUN           basic_fail_nth.map_two_domains ...
# # iommufd_fail_nth.c:334:map_two_domains:Expected 0 (0) == test_nth_map_two_domains(_metadata, self, variant, &nth_state) (-1)
# # map_two_domains: Test terminated by assertion
# #          FAIL  basic_fail_nth.map_two_domains
# not ok 3 basic_fail_nth.map_two_domains
# #  RUN           basic_fail_nth.access_rw ...
# #            OK  basic_fail_nth.access_rw
# ok 4 basic_fail_nth.access_rw
# #  RUN           basic_fail_nth.access_pin ...
# #            OK  basic_fail_nth.access_pin
# ok 5 basic_fail_nth.access_pin
# #  RUN           basic_fail_nth.access_pin_domain ...
# # iommufd_fail_nth.c:515:access_pin_domain:Expected 0 (0) == test_nth_access_pin_domain(_metadata, self, variant, &nth_state) (-1)
# # access_pin_domain: Test terminated by assertion
# #          FAIL  basic_fail_nth.access_pin_domain
# not ok 6 basic_fail_nth.access_pin_domain
# #  RUN           basic_fail_nth.device ...
# # iommufd_fail_nth.c:577:device:Expected 0 (0) == test_nth_device(_metadata, self, variant, &nth_state) (-1)
# # device: Test terminated by assertion
# #          FAIL  basic_fail_nth.device
# not ok 7 basic_fail_nth.device
# # FAILED: 3 / 7 tests passed.
# # Totals: pass:3 fail:4 xfail:0 xpass:0 skip:0 error:0
not ok 2 selftests: iommu: iommufd_fail_nth # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241230/202412301525.87d1422b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


