Return-Path: <linux-acpi+bounces-2906-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1723D82FDDB
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 00:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B065285570
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jan 2024 23:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF8D67C69;
	Tue, 16 Jan 2024 23:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WIgh5LxV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5981D68B;
	Tue, 16 Jan 2024 23:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705449431; cv=fail; b=SkAndQA3gF1htsCdOPUiHTZ/Udcy/BqBqIFppWXTu6dE/oPXrA6bBSUYPwu9jBs2QNTFaLrCptoub1ZuXBC9PbaBYJW/NMCwwV0uOVF3kfoakT6qM3HiKFJMOGfzrmLBA0prRrFR8HxYA8NTf2aWcLApCC0R1clxX6dxhim2FyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705449431; c=relaxed/simple;
	bh=G+xLmmcQoBwD/oRFOQQ270FwDrb7qD0LxVGwqfYUZ3g=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=ftutPCuYbjlTmSptOZVjKdJF3vpGm7qmENS6JC94RX/DHYsm22sIFRuA3G3hY3CpQOivY94t+uU6QJo78cnIzLWfK5uhsN95gGcJ9qoUZqZ8ANNdQ89Y7+Fvim9eP5aO2JsEulEnZIoqSKX7jxiD+nLHLQxPZ7k4Bk5NsHLLHug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WIgh5LxV; arc=fail smtp.client-ip=134.134.136.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705449430; x=1736985430;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G+xLmmcQoBwD/oRFOQQ270FwDrb7qD0LxVGwqfYUZ3g=;
  b=WIgh5LxV+dCwkwnhfd5D0tcM/m9mtBKxhly4yoIPxH9B9oDaiBPiGyI4
   pDeDzxjRJlV9jPmizyVILnI1bPTtdaovi78jSorlbIM5i0UbtdxNVYkvJ
   DAxveQ1Bgbfh3FTQ2vomJemz077hWhsqGL4vctp/JX/xIrrYsRaYVUV1A
   +leHJx0VfO2s33fdeX/VOVZ5sG/piDwcvSmLwANiElizDkGjpLJA1mT82
   UIEyeVvNkHFZtkHo3GiCIBo79OT+zi82Kp4nCWHVL5UdIGUGqEWexGgTW
   uzDC1FrV6cx5GmR/mR5MJFiRTiUx0eSjU4DY+kPV1aD25Jhz3yF1ToO+V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="466402015"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="466402015"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 15:57:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="784306959"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="784306959"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 15:57:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 15:57:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 15:57:08 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 15:57:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcTRI3LkTYu8D2NkWFj0AsMVNLWPu9VKt/JKFFqhfLlleHBY/A3VpanvmUENKYYLQOEijBiWoz4h1nrXUs8a5br0N3A34WhuTqy+svWdm1D3Uoj1fU8JBDzls4PfUbpkGb95uQ/C2dHz1CQzPiGEiYgVYLNJ4OuQh/egwVz3mjxAoHWccPsZxlVfG+aeUBGg4kmCpqZuHoCmzjRFKlo4bghp0kthtdlvEafzMMIUWQj9CPIsp79OoRNOL2XMd3pSA5WnEBtJFOqok940LwUrBNpKA6VnDyC3SPi97G1tY+yW7Bpm4YYUNbL93R9YsRuTav1kMr9Axnz7JlvAMLdYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeX2SykBT5yVJP2xMqDiswzT0lwYNAehApbesuY+VdY=;
 b=mpgmh0iNe8NWtdfxBr+TjAZrnur56HMJ7mHkJV3S4iRLXXRn2kgchzWulxEbftZtj1TdkAILinF2hBR8XJmJY72tfO0IACszISubQ61zFmGj/XBeNaTjFHO3k1BcfYFaQKZQgXOwHqqBJwbxncUcWB73Pc+cc+cVpganpf9EAJKimzMDK8FA5Ctf7Qmgytw3ckTx2cIvS5KFFEZI+yu2KFk5pPzvpq68UO6PPpyCSmRO3DvoebaaDZTU5+TYvzLIY92GYQOUBV253T5+EWEEWD3w9DArMY0SmEO+dkW6ABzVyaGSCVX7M4bjvxf5ygkUEQQxwg6O4Et+bTkaVGIhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Tue, 16 Jan
 2024 23:57:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Tue, 16 Jan 2024
 23:57:05 +0000
Date: Tue, 16 Jan 2024 15:57:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<dave@stogolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: RE: [PATCH v9 5/5] EINJ, Documentation: Update EINJ kernel doc
Message-ID: <65a717cf9d6cb_3b8e294ec@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240115172007.309547-1-Benjamin.Cheatham@amd.com>
 <20240115172007.309547-6-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240115172007.309547-6-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM8PR11MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: b581eb9c-624d-460e-c56d-08dc16eed7c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrAujv7oJpcON7AwZaXPfmKPAG3VvqUXsCT3dIpQeexXyK50nS/FAPvGbMd7HstNJDfkHi4df8KkCFc56VvRQJ4c1vNLKGnh/tWXCBQChTOUSLootnPfOunhmxyhCE7in2riuUf3d/Xy3yyfquDVQ+Ju8uCJUeHRv5NWPkg03mKs3pGPwiHTNXC3po3uSlsU5pNM1EvqjzCxk0nopCQp5AhwT7cGWBUDpYRk5kOPyuBCoMmboN9yTQSD7+r6sJV7nfYSt/IrzEl4pr3f1CisvUlzsbqwXBV2qaILtpUnVsC8byTI246M+yVtTLcDK5ihSKhiryR/DsV0fHG15JhOYfoZf7iiHeRO1QA/xkdMGRflHRuE85HZuR23GxaJrh4YFOGtt2su9GrFukaRh5qpcLgca5ROPerZPFtSU46Z6ZFUpvx/YQL7I6EIRbSUCD5Mask8KkOI/vJNbUqJ5UkgXvll/ZjUIFfDCztexMsBdo/EYYiEAesO26wEd8/Hm7sU81aE6qmBkE0YZ08fI6PgRZldI0yRA54pfJMYhbl/ryJpRFOXUStr9PArsg6oKU5L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(26005)(9686003)(15650500001)(478600001)(5660300002)(316002)(8936002)(8676002)(6486002)(2906002)(66946007)(66476007)(66556008)(6506007)(6512007)(38100700002)(4326008)(19627235002)(41300700001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aUcPQE10Xx1ARxHFNYIuMJnyJNSsj/g/L9rfEWIavXU+Fs/kvd6m5vGey31B?=
 =?us-ascii?Q?m0d7vlvs52AljGDcVyFhYzRr1hlsIkjRxq2CBqq+7ljxgN7nEN3b1ZEUta4X?=
 =?us-ascii?Q?7DP+y715CHYkdBUbkauKToeZ/9q3JbzC8wnB/0F2PaxdoUrtCrifr/jLCNnn?=
 =?us-ascii?Q?uD7FKRxq7lqgRrSu70QgRt+XfqeHpAY198NmdUZDvHIwex/7GUZI+oeNrHS+?=
 =?us-ascii?Q?YZrPWyXW2BQBZeTLP0bI+OLwMTgZSjB7O7ogDBW8+FI1Sc2BxGoQ2e6t0QO6?=
 =?us-ascii?Q?TNkOhOZ0SRdtpOrmjBl1MSL0F1mgVYFkVociDPpflzHz8AbxTrL/3jKigef3?=
 =?us-ascii?Q?1LU3cWA0o5sHzW22m0X6OLovWQEzvS4U0jIiO+TOkWCHW1Doyah8GNT4SDLQ?=
 =?us-ascii?Q?fWZq0PiSzGHoxM1pO0cqr7lM/WjPXkhS3ofXdnFdVgWGXIMOzIwrftciB9aZ?=
 =?us-ascii?Q?0m2kbqPOUQVxiY9VyjYqZqgt0pvhK1tJp0NIp6wXtrpZCETzKl7r1iQRO51U?=
 =?us-ascii?Q?3paB7S9YICQwDY+BghQBhLtsql2SwUxH5FFycZ+vcOTv8xyd73gwr5bO6kfl?=
 =?us-ascii?Q?bC1o+i2doMfI6RciCbxYGhOPFmC3qNSg7FjzSM7+9eC0ymlphjERLvp2T+Pw?=
 =?us-ascii?Q?2dhsg3jYSfou43C4gcU1W0blZzyfLj/5IndSHHwa6Oa8xCCSN5583PqUURZD?=
 =?us-ascii?Q?W/xt/ll7uULii8C05L0tjf8w6CIcUHAg/ytNlswvzcLGyD4oX3bJaf0Puw77?=
 =?us-ascii?Q?3vEcB5Jqah6mDbRO5EVT3vBpUOG/X6pR5eIvZ7RJGyq6QKdao3Hyev6ONaNm?=
 =?us-ascii?Q?fpO2cYl55xGze/+XLfEf5F/crH3llzvTOMWvNvgoS/36Gh6ZdJMwWDMLg8px?=
 =?us-ascii?Q?RC+S01zfmKfF87SwwWqMiZC94JE855GuLqx1ohM/bg0nLoGKM+bT3jYmFuY9?=
 =?us-ascii?Q?Czvj0Mm2svUcO36nbLROoxlPnpPPhFHHy9Ql+Brm9SwdkEkzaAMyB3XYOC/X?=
 =?us-ascii?Q?VeLJEndELTbNySsgP/PMzOt9tVDaVa9B1ZbDHQ3IS+yluTAgWIviaN4+z5Zb?=
 =?us-ascii?Q?uOoWTsN08U6bpYyT2Z620/Jb0qn5z1V326siGvqQQE+5UjpVGtWNc2v3MpIm?=
 =?us-ascii?Q?+fVxEILja50BMUE6CGgSABxTfpp+Bmg/Q/tK9ZoiYRFED5KHRGlhRNwmJfRw?=
 =?us-ascii?Q?K9QjUwzoFW6LXWo6pH6I91CHWeD+RMKdKjzEr/yZMRhUC4xspniqucV3bi4G?=
 =?us-ascii?Q?POcaJeXQM+WCkpc05BnVC4lNmxOfOQCSRj1sX/FHi6QsYTL6yZ5U0t291DAR?=
 =?us-ascii?Q?65E+MzmPdDXKzAVa7m9XQhgVdw4MYNCcMClnc7jDib1lTNGHB1STXqyq7a4I?=
 =?us-ascii?Q?0/3/RdFbXcDS5C7Mx3j7WRjwBulOUZwAOGS7nTeUm7P940KC2lmEonzWMb3+?=
 =?us-ascii?Q?TGqkOipPJLzkfXumuDH9apFhQEIgtpTMn5Hnxukb3i9W/ey/lpKs4eBwsbVT?=
 =?us-ascii?Q?vCUvdvpJpm5Ak8uu88w72zogl6gGV5QUUuhzzkfGhQuQ1FRDPUITWz1zFssK?=
 =?us-ascii?Q?FZBWxWfaz5uUYvZXNPbzVOwYlKJSlatP3yThuy09nywS94wKARI0HmJAgHSL?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b581eb9c-624d-460e-c56d-08dc16eed7c8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 23:57:05.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: at2dEwUFbxe5VRJ1KRnkMjS+eqWYQdogsFAgih8tiMZYjX96U2z3xp/1REW+SGXSvTvr42RTGehsz6TLUHJzcM25CaH41Xw0yrx/Uz/xO98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5591
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Update EINJ kernel document to include how to inject CXL protocol error
> types, build the kernel to include CXL error types, and give an example
> injection.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  .../firmware-guide/acpi/apei/einj.rst         | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
> index d6b61d22f525..a8f26845682a 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -181,6 +181,25 @@ You should see something like this in dmesg::
>    [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
>    [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
>  
> +CXL error types are supported from ACPI 6.5 onwards. These error types
> +are not available in the legacy interface at /sys/kernel/debug/apei/einj,
> +and are instead at /sys/kernel/debug/cxl/. There is a file under debug/cxl
> +called "einj_type" that is analagous to available_error_type under debug/cxl.

s/analagous/analogous/

Other than that, looks good.

