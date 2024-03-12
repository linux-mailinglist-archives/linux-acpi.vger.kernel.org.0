Return-Path: <linux-acpi+bounces-4285-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA4D879C8A
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 21:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8357B20D5B
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 20:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4D0142649;
	Tue, 12 Mar 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mczNI+Cm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03B139580;
	Tue, 12 Mar 2024 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273841; cv=fail; b=AsEnogl0jWy8EP1XQb20CBx2mkZhYf+38b1aS+RHewQJgY6ixxTOIH+/SOVWkGRpC2tChEzGe/oY9HwmeW4G3BrWYuIP5dOwXANKWnCSEVcco0agCJuAZ6xZ7CJGXE7PrEUdBOKOctyo5mGr3dxRlBzq6DRF88kdrvm78LYF/jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273841; c=relaxed/simple;
	bh=DjVPhU+ee23OsaiG1VDbT3TuKMBNxPLs+bR2LEw485Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rr2XxHZWSOUv+fabURdcTjjV8Vddo74ZXliFTrPCdzI7GK1TSVDyKYh4I0Wpf5egh2UKzC/RVZy803SQTkb0/HbuUrRuolHoSG5qB/QaFoIsMQzLMJ5mS6NowbNp/3yt8PASonGY+6aE04Dfkmo2+fxnmJx70jG4v89F+6GKbUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mczNI+Cm; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710273839; x=1741809839;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DjVPhU+ee23OsaiG1VDbT3TuKMBNxPLs+bR2LEw485Q=;
  b=mczNI+CmXcSRMuS1gLqRPKGl1pxFNP8KMYDR+KnC2YYgRYKsRGXsKlY2
   MsBTO8EYKM6T46lJ8ZOcV9Z8NMv6Q1ZLS094LWvDAUpMZvv6OpBQTSXtp
   M9U7j9sqYDEmzuJ6SNMpj207i0AGZLgclPxDIkoy4Ax2dFbhmupnTQlPd
   +gKMlScO1kXh1gWM0JzuPW5VhGLewpTgPvMv/C4rBWfhX0kwpgjnq1JZJ
   B1/Mji6kHa0vVrsx3H+0UWUbAJ5H78ztS2EoEVGMecxihPqHHX3x9G+h1
   GxhW7r2a7lTDVXL82jjOEWPa69uhebic+SXRuudxz1e72R10Ncji/i75E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22525101"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22525101"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 13:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="49089985"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 13:03:58 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 13:03:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 13:03:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 13:03:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGWRK6e9lVRztyhPEEUgD0SiIFBPKpHpI8kMdCce0W0yF/RGugGLD24O6HYxJ3fxIaP3YbyxVBfwHZ7np04CT9/dpSGWYsfnj7UvWtRi+Fdod+fIQ2ctYUKlF9BgTAzIXx0boDxqeqFzDiO2I8ddcTXBqGWKk/I8oDkEK9tkPEJv+ctOvfzss8cFAPmiavOKENql6D9zHdLXfjGR2Ah3hzv5nUnafD/U/IS2+vPVQyLCdvEQzlmHPA1W/d1xgVlyjN74Ss5+3D2OcNwYstsHlG6OONoyZOUW1RqcS7eIAu50vgDK+2ifV6W90U6zv8BQp3MYeC2YFKJ5bF1wp1TrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHmvUapKcGLGYV9QdFwqLuOlPOlAxdnUA+uiX0XjWNg=;
 b=oJhyf47/Np7ebk6VVG6IycQWGiDLUtD5QtX1PpUnl0kZ8wMfNeSXEWcNtutV23/RnKGC9DfpGRQsCCqKfeBBi5iYyOazPoo+lxU+aSE79pSWztMiyzR0XXqcKjc7pFjqfa8q0p9m8t/HzwwVl0lOVjUJ6alqXTBb19BoFMBeZUX6AWOSacuOwUCEGbr21zRzmjMlBsORx/jx7RjDcsiw9+cp5w2HOBVs8qg4URAHkeuPtTAxaA/H+C62g6vC4FX/sOgNCBK34tcpnboZ9TTiohztP+l9qDUhzm6bOsWep596rk26VvcBjudzYT/23fOUxaWBLj80N4Hb8iD1vlYo+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Tue, 12 Mar
 2024 20:03:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Tue, 12 Mar 2024
 20:03:54 +0000
Date: Tue, 12 Mar 2024 13:03:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <rafael@kernel.org>,
	<gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH v7 11/12] cxl/region: Add memory hotplug notifier for cxl
 region
Message-ID: <65f0b527de6b3_aa22294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240308220055.2172956-1-dave.jiang@intel.com>
 <20240308220055.2172956-12-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240308220055.2172956-12-dave.jiang@intel.com>
X-ClientProxiedBy: MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: d89bb8c0-0f33-4041-f407-08dc42cf8b5f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17SLMOvp0FX0F8BNVY8q3Il009f4gVcTQwnfko8qS0dIUpoq2jFCABObxqxFx/Nw9gj0Vna9xCB8SUwSfPnKGAUSRbtB03uWzz3jiysXYUsY1yfRzkciy9IROoM7wej399+wYfrRJhXUlA5udzD6LHx7daJfGCfKmCB8U74Nre8U9Ff72V9snc35uynqm3Ffq5j5PL7IoGRhaetLrocCQ2clETXIQNtYZhw93WKWP9k1lFIxWH8uefLyj+p1HK7+1LKm+tXmALyJwfaXlG0Cp9h+qxGPiOgSRD82Znb001Suhxy/vWUG/51+c1/UDQyonbpf2mXd7p2M0sjB9KAE0cCuv1ChFMtaQqb81UJR7a/bsmDlUVO9207wYZShCaeFgvL1m3Zk2lktdXn2UOLHTlsbf4gffka0qOURXof7IW/1yMutCFIp6nroaEBhPDkFwz9088w7g4wVUFfsepRn4amBmyYGFBWuaWJNnc6y0AWuKdZgjTBS/P5rpHweKCCNjiPSYkxKFOM2pmV2BN5rOSLba776GM1pBfznny5MyFQKUYhXlXGFyKccdEYdAJf5bBbzMfCHPafkzGVORRfnBQ9PVEQskWEIDRNXevXpBv14cSt+iOiLIlBpPw5XEy50SirKeFXIzmU08/f6EHOhZatTtN27A9TU4tW3cyqS2VM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8xky1c1ibu0D2pi9EaOwEzD7bfa7D9uX2KlFpAPhMZ5KCspIy1OSN77h6w3l?=
 =?us-ascii?Q?GGgCbGsvf/J59+8+sjEdXh1un+tXBCYyDmcJHgoP+AWDAPvyesylTx1y02Vt?=
 =?us-ascii?Q?ZJ873sq94M2ZpckvtTzdqblMwqg1Us7H8KgO5V1TtKr5Z5Iz0SDKLNcBST1l?=
 =?us-ascii?Q?rrxmXttQBAB+bOjhro92TNDmu86NB4f+GnU1p5AIi1b8h9y1TeyINWpR5c9Z?=
 =?us-ascii?Q?uWPdeyxdJlT0/Ss6i/qLj42c7qfsKfREmoE/bVeTjQgPM2oObFcfuq8nE+pt?=
 =?us-ascii?Q?j1uvXsWqSIL/V56U7MVbrvTvUsXTsz1JyYwWw8rJaDaXOfwdhzsnMwo6nrb4?=
 =?us-ascii?Q?LjL1SBDpR0RevuqdRVq30bUYo8awPQSe9NPloqgbC6/NMW0vudvvJUNUwOZE?=
 =?us-ascii?Q?25jF8c8sPCqsx2Aign58ntL/pQ5RxOQR+gjMyZoKisGgvd+ILoQnjFR3Ufkv?=
 =?us-ascii?Q?CRIeenkalIelPeArFg97FVKq13YENUGKG844cKuznrtJW5XBVuVM3tqNqks8?=
 =?us-ascii?Q?6qoG2kjMZziy3bdy86L6D5SStDLf6agXyUlrhAZkRqHi/rY2qC8rZu4GZ6aj?=
 =?us-ascii?Q?tkio+1mskO4M54UKI21U0oXL/sU137dxOX7f168Mfo5mqCXpNNgCYw+4LX+H?=
 =?us-ascii?Q?mwE6NaDgqLUW8rviQFoD/s8nrHMVNVByvQQ1LiUi+RctTszzUd7xeM/5aWMz?=
 =?us-ascii?Q?FdpKnG0Y+HCkygdZdL44hg/z7VBV6jAEkcckIvhBLPpPFoR/N13WclrdKnyJ?=
 =?us-ascii?Q?1mCjzYPJZTsbikx2p67Kmd/+zCOHgW/0dTVV4DwFPsgUkR/4di0qTnsDJJ3w?=
 =?us-ascii?Q?6Hcajd/oCUH+GHZN+5EokIsecsFTrIPF5Qwp0/cCRDXpPMGhlhyUV+GezoqV?=
 =?us-ascii?Q?k+J1lq7YqMswU4cMtnj8hUgLoKIA61oBKlF2AlOZJiLjUzIvKGy/BoOu4yo9?=
 =?us-ascii?Q?CG0pFSBrLYN3eu2pwGzO7af9F5GlafezcWU3Wx12Xlb88r63exeh7SCFqg9M?=
 =?us-ascii?Q?RQwRBQEGDfA5/Iaium/ds5cFiX0SbP0pj2bf4z3WZ+JwEClGE0e06NjQhPXF?=
 =?us-ascii?Q?q3loahVkiv0X5x+v6MEbsK3y9XWYy6xPeTcchnauSwZiwsRlQbhoi9E+rQX5?=
 =?us-ascii?Q?q4ixwsy34TbrvhL5xY5/oi+0crj37eZKMIvvN2zu3JVo3Exqcf4B6u86IN8D?=
 =?us-ascii?Q?1biVzrmN8tgOZn6Dd7xoP1YN58mt4MBu27/zt5HQTQ3DQpuYZSXmNreSNjZa?=
 =?us-ascii?Q?Wf+6e6/iho4MGd+JFSH/RFZN1AA9ZtCLWaDzY6aOxk+fppyC6JFFtFUnqbH+?=
 =?us-ascii?Q?YORIbiPwvTAOlYzAuUdCrMOeodHjXIR/5u2M1xk6a6iEuHyO+mKyAhGdXEUR?=
 =?us-ascii?Q?Y6NuqbVqXEVdy+K/2KSXtk2ZuGe1q7Su/bOFgrqI95y2yCUpOeO0t2mmRJvU?=
 =?us-ascii?Q?VC/lpeK188qvFT4R6rPIGSwh2RkCx0TYhOLhnyzo9FvOPGoHCZgPmy2gYphP?=
 =?us-ascii?Q?iSwhcYkpWoBRwivMShA+3EbIvNTQ/W+Cdv3mwuKwrKcOR6XS5TGgwa3SHv+K?=
 =?us-ascii?Q?azsiC1SwV9T/iQeNFojI/HMdDZOeDA4x48dfTHAaBEJiOISpfY9ptinJ4tfi?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d89bb8c0-0f33-4041-f407-08dc42cf8b5f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 20:03:54.6973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2juaMdjAvGjrhIdrNJsnIwCiTdFC78GMmLVjmOmGekNEHQBoYo0tVIlFTO2jYjlaSSFq9A1zYB0oJKLbNUJvGbaSxctZYsAZfVed69Aqus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7300
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> When the CXL region is formed, the driver would computed the performance

s/would computed/computes/

...fixed that up locally.

> data for the region. However this data is not available at the node data
> collection that has been populated by the HMAT during kernel
> initialization. Add a memory hotplug notifier to update the access
> coordinates to the 'struct memory_target' context kept by the
> HMAT_REPORTING code.
> 
> Add CXL_CALLBACK_PRI for a memory hotplug callback priority. Set the
> priority number to be called before HMAT_CALLBACK_PRI. The CXL update must
> happen before hmat_callback().
> 
> A new HMAT_REPORTING helper hmat_update_target_coordinates() is added in
> order to allow CXL to update the memory_target access coordinates.
> 
> A new ext_updated member is added to the memory_target to indicate that
> the access coordinates within the memory_target has been updated by an
> external agent such as CXL. This prevents data being overwritten by the
> hmat_update_target_attrs() triggered by hmat_callback().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v7:
> - Fix typo in commit log (Jonathan)
> - Move memory_notifier registration to devm_cxl_add_region(). (Dan)

With that change, looks good.

