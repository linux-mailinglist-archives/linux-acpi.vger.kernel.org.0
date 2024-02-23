Return-Path: <linux-acpi+bounces-3926-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD37861C55
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Feb 2024 20:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91421B2156D
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Feb 2024 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803CB143C59;
	Fri, 23 Feb 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljnRkXet"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411691420C1;
	Fri, 23 Feb 2024 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715699; cv=fail; b=Q4E/xKTRxCIItiAH/bJpZWDBoGYQL0gnoV62X9rIaGRX3fFOCoi5nB2WzhX3zPVSZ0FR5fPhFwZF/8hGjjq1Vv04R/CHtDdwgmycAqMmwKJOX8ewW0acbVdLsUaTxpuIX0+oiDsaUCF06VzXEEYOrAZb+tS5dzmsBUKarwwy6ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715699; c=relaxed/simple;
	bh=UwFCMlha8iSSTFkkF+oHGg1jBS4CBjei2+wEXj3K8Sk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S7ACHdg46SjRDBjUn/3FDyD6Kyy4NWY7kePoV6sIUT0yN7L8l+eNqcdZRnNHb8D8w7G5s+MykP+Cu8YTTZoIt3kiNI3bp02BTAUYRo6sHM0DBkAexYkl5rwGitTEubFA+bsGD39PQzxwvKn6LYAgGdKW7m4idXk1lGIYMcI0fCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljnRkXet; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708715697; x=1740251697;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UwFCMlha8iSSTFkkF+oHGg1jBS4CBjei2+wEXj3K8Sk=;
  b=ljnRkXetb6LlEBX81Nw35q5AbTJMOYuRo2kUtg3n6U84TLiXjqMbEDhW
   SuvDcK7vHqLa6i55ol22jILl6AQGjt4SjHufgj1YhtmgLGLRu9YubEeJc
   F/+2XJZNNsPvODk686+QtcmYHUfXKV7LZ9QtYskrFV5vIELZI1grEOVW8
   1oyhF458jEF0EhaO4Ws9rZuJRN+dZDOnYpXpURrs0vTT3Fs9pqZN0VIuz
   5PhAJ3Q9FoeMYsBwhARqwmRWJiCxWZacylbmNH/0flpqcKsLvqnryMeQh
   V2VsBdJnHqIT+aAdDYf1SDkOLZzVJmoKD67jTHDcFDxPlINBocPMMsWvw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3210564"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3210564"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 11:14:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6148057"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 11:14:56 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 11:14:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 11:14:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 11:14:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV+/SR6Blm3FI73BalQLDutBpywN5tzHCE1ur4s6rUU+YALHz05Di38AtyfXyZSdXCSyp6VGpD2WR6VzyAlEbmUM6W0eJ9Gk1sd7zFdaGnVFEk59NF2jWOlB9qPRhPYHUnUNTNw9e80kvPO3Blk9QrnTKtQKJCxdNKC727lpp3Wm0CV6qrfZDAwKta4GjKVdzFZWneDz7OKXH/tAMpDuSfNoDviHHj+48J59ZK8QV0SvoWoKPlvWa1+Lqr9TDwG/xbdFADLiHZAPSiKoez5dNIov7ZiC235MvnTGG2cUz8WuG9lxZy+PEPYUcz5ZxcJy+TEZLYF+ObDPCPD9PCJvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24LHrWoLPS57JYpow5VlbQgq48B5JUBaJtA5Y+orbF4=;
 b=UvoIMZ1aWu410rykvQFikDpK6lY2dQmUqRjLz7Icw79p/Zb1CRJUIpm9FIogaAAemVVxYRONfl1puntZ+qG+0VkmtbVY0SU3PKedp5heeajgKOrWDRJr+rV1DAMOqxkqcxG+QUSso/C8DFn3fA412Oz9P+JG9OaCuN80791nHU9wkUkiu22gr/KmsZej3xd2D2x5+GA59rRPQA6yhcr0TF+3g25hhUzRdT1O84E0kn796gSbglgNrW43sKz0IL0L3tSRvxdSz439LPIJvhvToOlrwDGcSQTy4J28lBYvNexm4W7lql1RcTC4pzbM7paL0HiW96S3RveOg9cpGUyH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB5992.namprd11.prod.outlook.com (2603:10b6:8:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 19:14:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 19:14:53 +0000
Date: Fri, 23 Feb 2024 11:14:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Fix load failures due to single window
 creation failure
Message-ID: <65d8eeaaeb302_2509b294f3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170820177238.631006.1012639681618409284.stgit@dwillia2-xfh.jf.intel.com>
 <20240219124041.00002bda@Huawei.com>
 <65d6335ea74ac_6c745294a8@dwillia2-xfh.jf.intel.com.notmuch>
 <20240223132829.00007741@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240223132829.00007741@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:303:dd::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a34b9a-a971-47b2-90cd-08dc34a3b6be
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ghh5FAA8P6+harrQrnIFq9EBwSkA21BT0fw4k4pCZ6TGgZ6y6AaThVxkUryGNErQF34MeFlbkywwI5ZqXEXlenPszu2yyo7Nqp4Axi/HcZivIhAoUCZR01Ix07K7yFbuEJr/pe3Ouwssu5+LJX2jw8FxtSAyUWRfvmM3D1YvjGzzr4/1vNk/aeAD+oghV2WfpyCMWUvUeYBp6xvl5gXxSv92ZqhunhRgBdf9+UK24Qme233ap5jX6Fxjw09GYCR/uiV00mmXDulTabuWFOqy7T2QBPiYcbydvZwiLJKfy++mUV+Jish4MIYGTMpFbxgDVCr2WllpUNa1MPbm/WzPwJtb1NYxebtC/d8NpMyjf0DVoauAarwo8RvlDGLZQ+Y1Mdn2T6jaXrPKKVGkRdLafWb6QJEtfkg1yJbDOixfQ70K6Gwf575tyXYz5ni2yzCaocScAIcbhTUbj/M9dv/XIUKnl7Ir3Pi2MIJzo4TtSwgU9mppxRjgKDLh6/4x9QWZEx0G3QnhQSw6T/TIB95sGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kYbsOQkYdplzCtAk71rw1vQllW1Rw9GBcjmaJrL45CekJnuUGtBgx9nMsR9H?=
 =?us-ascii?Q?2EvjAuznPor5/0kzYAhqV5OuP9bnN5MZKJXc+b9tfYuPqaFce2XbNIkyHVZw?=
 =?us-ascii?Q?Dixv66j80SyP0UMHgj66xgEh3q5XFYzwnxL3aafTzG+Vv0815EY8tj6nehaD?=
 =?us-ascii?Q?bTcFEP8mjMM6ZDW/irlIBehsm+Pbdis7p9zQMvXKzVGFSwE0CYijThuKcIK0?=
 =?us-ascii?Q?/Ykj6ksxtijgKAv8kBioXNRDC7ic0VACX5JJmm1xCDDGU5PxtZ8rlszO4eYj?=
 =?us-ascii?Q?bLdm/ju3WXCqL3GCfMepCs9k+EFauqswP3LAJBOxTJAJD+ss4u+i2scgCnpP?=
 =?us-ascii?Q?Sot6sP7IhVf+yIQE0diqT6LA8w5CDtoVKLus3qymY84awJR6cL6Mit8F43Uw?=
 =?us-ascii?Q?YiLRQxs3/0doPKqBB1dYgjl/HQOs/wEl6VhqnqyUtyNnabwyOOSzyDX66zB4?=
 =?us-ascii?Q?0KbPZV7lZIC7tmCI9RSTG+1DL4F9qKZOz3PokKLGnRLypliNBqGrua4YqaLK?=
 =?us-ascii?Q?rICgiW8fE7DRrt/GGOdM721DP3kwPwpiWxf97qV1eUOoqZ8OZXLPpSjA4525?=
 =?us-ascii?Q?OL1kGkywCjwmoKPieRyQIrBzsTfxdDuY4Svj1yMqk+kxGHILlKXHYrjFrg/n?=
 =?us-ascii?Q?jpXyLyNtZhFWNHCRLRnN5mvnWrIwwPuPpfYdFlQP/cG7R6twT7d2y/vQeDdC?=
 =?us-ascii?Q?CGJMTDTzYd15tDrlZY5+gPEIg1gHWZc4jkhF7Z6F4ZsowC+VLE4qORbEG6Ch?=
 =?us-ascii?Q?Czeg2PtR7/BMHP1ECbphDRbG2wigwFoOjyzuhQeFj7OwsZXM9GiR+rCf/ou2?=
 =?us-ascii?Q?hNbfndBWa0WNZpSydjzIjz56f/7gVafWdEBssUyVfRbsu2/hHTmLnDl6IiO8?=
 =?us-ascii?Q?ZF/9nBGU550vF8TcXmydNTlzz8KxiyLEE6Ba3LqEcM8x9Zl0ffpp30BeDKV3?=
 =?us-ascii?Q?jOdFiQJfH7NxS2Y43Lza7CeC3hdjPUHGonURuIj0r+xfIBzMLGRP+bUeG3w5?=
 =?us-ascii?Q?ko40yGOo5Xc+bo3Kv2djPkpWCW47Zco4/BUyEAU+ahuvSIhED2aa74BA5iHt?=
 =?us-ascii?Q?gQ6lR8C/FQzCFUocwygRD0C8tbtdwYB8+VEFBSnibrELYleGisOrgPmcr5+O?=
 =?us-ascii?Q?0qUGCqrCIGQtXWlzWkI9eyZqMsPSgFiuME0AxoMlzflZ5KAUwuOVTmuDIwFf?=
 =?us-ascii?Q?Z+64Sk9O7JXRUTv5WQHSpQ2jGW0rg7Dq/GEGf7PL3hxtW1tjpFLfiEtwS1BT?=
 =?us-ascii?Q?+GpBaFcYhl53mBAnDsoUDDTF7O1Zoo4LmIRz7VzKWiyXcJbxO38aBN+o/i8k?=
 =?us-ascii?Q?J6E1oSUx0mKhfZHgEXv93q46s/QvoZFunnIFEKvCaD3+5TAYS/8z0ue05TO3?=
 =?us-ascii?Q?jVXD31aJwXi3V+L83wYtPUsu3vfGrBzuVmDQhZBEG38Xnni2bmlDyvSDnsz4?=
 =?us-ascii?Q?So5XV7V9swK0+KFnFcHImRmHG+vryUK0DXz+VFW158Tpr7qabc54Qgqi7E+T?=
 =?us-ascii?Q?kzSgyIRwpKPfks+xXV/tMY2sNLVuWlqqUbwCKNKS0mwJOMAyzIlCrSRMk+at?=
 =?us-ascii?Q?4613EWRyb8e9QFW4Ip1HgJR9SNYLRVg5OGuhtlxY60MWhoKSf3saRIFfTF0d?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a34b9a-a971-47b2-90cd-08dc34a3b6be
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:14:53.2333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55DZye9yFf7wJZN+B42YIvs8Dy51/1iDP2BPedHdyIpWwsYdXH7zQ+45res+EHpf2yDvoJW1QUArR4KJ4sH3caxl5tBeH7yzK0NqhPFvMNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5992
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 21 Feb 2024 09:31:10 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > > On Sat, 17 Feb 2024 12:29:32 -0800
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >   
> > > > The expectation is that cxl_parse_cfwms() continues in the face the of
> > > > failure as evidenced by code like:
> > > > 
> > > >     cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
> > > >     if (IS_ERR(cxlrd))
> > > >     	return 0;
> > > > 
> > > > There are other error paths in that function which mistakenly follow
> > > > idiomatic expectations and return an error when they should not. Most of
> > > > those mistakes are innocuous checks that hardly ever fail in practice.
> > > > However, a recent change succeed in making the implementation more
> > > > fragile by applying an idiomatic, but still wrong "fix" [1]. In this
> > > > failure case the kernel reports:
> > > > 
> > > >     cxl root0: Failed to populate active decoder targets
> > > >     cxl_acpi ACPI0017:00: Failed to add decode range: [mem 0x00000000-0x7fffffff flags 0x200]
> > > > 
> > > > ...which is a real issue with that one window (to be fixed separately),
> > > > but ends up failing the entirety of cxl_acpi_probe().
> > > > 
> > > > Undo that recent breakage while also removing the confusion about
> > > > ignoring errors. Update all exits paths to return an error per typical
> > > > expectations and let an outer wrapper function handle dropping the
> > > > error.
> > > > 
> > > > Fixes: 91019b5bc7c2 ("cxl/acpi: Return 'rc' instead of '0' in cxl_parse_cfmws()") [1]
> > > > Cc: <stable@vger.kernel.org>
> > > > Cc: Breno Leitao <leitao@debian.org>
> > > > Cc: Alison Schofield <alison.schofield@intel.com>
> > > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > > 
> > > General idea makes a lot of sense to me.
> > > 
> > > A few comments on specific implementation inline
> > >   
> > > > ---
> > > >  drivers/cxl/acpi.c |   45 +++++++++++++++++++++++++++------------------
> > > >  1 file changed, 27 insertions(+), 18 deletions(-)
> > > > 
> > > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > > index dcf2b39e1048..53d2dff0c7a3 100644
> > > > --- a/drivers/cxl/acpi.c
> > > > +++ b/drivers/cxl/acpi.c
> > > > @@ -316,31 +316,27 @@ static const struct cxl_root_ops acpi_root_ops = {
> > > >  	.qos_class = cxl_acpi_qos_class,
> > > >  };
> > > >  
> > > > -static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > > > -			   const unsigned long end)
> > > > +static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> > > > +			     struct cxl_cfmws_context *ctx)
> > > >  {
> > > >  	int target_map[CXL_DECODER_MAX_INTERLEAVE];
> > > > -	struct cxl_cfmws_context *ctx = arg;
> > > >  	struct cxl_port *root_port = ctx->root_port;
> > > >  	struct resource *cxl_res = ctx->cxl_res;
> > > >  	struct cxl_cxims_context cxims_ctx;
> > > >  	struct cxl_root_decoder *cxlrd;
> > > >  	struct device *dev = ctx->dev;
> > > > -	struct acpi_cedt_cfmws *cfmws;
> > > >  	cxl_calc_hb_fn cxl_calc_hb;
> > > >  	struct cxl_decoder *cxld;
> > > >  	unsigned int ways, i, ig;
> > > >  	struct resource *res;
> > > >  	int rc;
> > > >  
> > > > -	cfmws = (struct acpi_cedt_cfmws *) header;
> > > > -
> > > >  	rc = cxl_acpi_cfmws_verify(dev, cfmws);
> > > >  	if (rc) {
> > > >  		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
> > > >  			cfmws->base_hpa,
> > > >  			cfmws->base_hpa + cfmws->window_size - 1);  
> > > 
> > > Why keep this error print?  
> > 
> > True, that can go.
> > 
> > > > -		return 0;
> > > > +		return rc;
> > > >  	}
> > > >  
> > > >  	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
> > > > @@ -376,7 +372,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > > >  
> > > >  	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
> > > >  	if (IS_ERR(cxlrd))
> > > > -		return 0;
> > > > +		return PTR_ERR(cxlrd);
> > > >  
> > > >  	cxld = &cxlrd->cxlsd.cxld;
> > > >  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> > > > @@ -420,16 +416,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > > >  		put_device(&cxld->dev);
> > > >  	else
> > > >  		rc = cxl_decoder_autoremove(dev, cxld);
> > > > -	if (rc) {
> > > > -		dev_err(dev, "Failed to add decode range: %pr", res);
> > > > -		return rc;  
> > > 
> > > As no longer sharing this message. Might be neater to have this lot as
> > > 	rc = cxl_decoder_add(cxld, target_map);
> > > err_xormap:
> > > 	if (rc) {
> > > 		put_device(&cxld->dev);
> > > 		return rc;
> > > 	}
> > > 
> > > 	return cxl_decoder_autoremove(dev, cxld);
> > > 
> > > or a second error exit path.
> > > 
> > > 	rc = cxl_decoder_add(cxld, target_map);
> > > 	if (rc)
> > > 		goto err_put_devie;
> > > 
> > > 	return cxl_decoder_autoremove(dev, cxld;
> > > 
> > > err_put_device;
> > > 	put_device(&cxld->dev);
> > > 	return rc;
> > > 
> > > err_insert:
> > > 	kfree(res->name); ...  
> > 
> > True, there's enough here to do an even deeper cleanup... below.
> > 
> > > 
> > >   
> > > > -	}
> > > > -	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
> > > > -		dev_name(&cxld->dev),
> > > > -		phys_to_target_node(cxld->hpa_range.start),
> > > > -		cxld->hpa_range.start, cxld->hpa_range.end);
> > > > -
> > > > -	return 0;
> > > > +	return rc;
> > > >  
> > > >  err_insert:
> > > >  	kfree(res->name);
> > > > @@ -438,6 +425,28 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > > >  	return -ENOMEM;
> > > >  }
> > > >  
> > > > +static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > > > +			   const unsigned long end)
> > > > +{
> > > > +	struct acpi_cedt_cfmws *cfmws = (struct acpi_cedt_cfmws *)header;
> > > > +	struct cxl_cfmws_context *ctx = arg;
> > > > +	struct device *dev = ctx->dev;
> > > > +	int rc;
> > > > +
> > > > +	dev_dbg(dev, "decode range: node: %d range [%#llx - %#llx]\n",
> > > > +		phys_to_target_node(cfmws->base_hpa), cfmws->base_hpa,
> > > > +		cfmws->base_hpa + cfmws->window_size - 1);  
> > > 
> > > Could maybe put this in an else below?
> > >   
> > > > +	rc = __cxl_parse_cfmws(cfmws, ctx);
> > > > +	if (rc)
> > > > +		dev_err(dev,
> > > > +			"Failed to add decode range: [%#llx - %#llx] (%d)\n",
> > > > +			cfmws->base_hpa,
> > > > +			cfmws->base_hpa + cfmws->window_size - 1, rc);
> > > > +  
> > > else 
> > > 	dev_dbg();
> > > 
> > > so we only give the dbg version on success?  
> > 
> > Yeah, I will switch to this since the previous state was also skipping
> > the debug messages on success.
> > 
> > Follow-on cleanup:
> > 
> > -- 8< --
> > From e30c267c0b69d5e4531d8f65ec86e4fa32d72340 Mon Sep 17 00:00:00 2001
> > From: Dan Williams <dan.j.williams@intel.com>
> > Date: Tue, 20 Feb 2024 22:44:34 -0800
> > Subject: [PATCH] cxl/acpi: Cleanup __cxl_parse_cfmws() error exits
> > 
> > As a follow on to the recent rework of __cxl_parse_cfmws() to always
> > return errors, use cleanup.h helpers to remove goto and other cleanups
> > now that logging is moved to the cxl_parse_cfmws() wrapper.
> 
> This runs into the question of where the declarations should be for
> cleanup.h changes.  I can dig out the Linus comment on this but
> I'm feeling lazy ;)
> 
> In general I like this stuff, but in this case I think it's ended
> up harder to read than the original code.
> 
> > 
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Closes: http://lore.kernel.org/r/20240219124041.00002bda@Huawei.com
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/acpi.c | 45 +++++++++++++++++++--------------------------
> >  1 file changed, 19 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 1a3e6aafbdcc..b1ea2d152c65 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -319,25 +319,23 @@ static const struct cxl_root_ops acpi_root_ops = {
> >  static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> >  			     struct cxl_cfmws_context *ctx)
> >  {
> > +	struct device *cxld_dev __free(put_device) = NULL;
> >  	int target_map[CXL_DECODER_MAX_INTERLEAVE];
> >  	struct cxl_port *root_port = ctx->root_port;
> > +	struct resource *res __free(kfree) = NULL;
> >  	struct resource *cxl_res = ctx->cxl_res;
> > +	const char *name __free(kfree) = NULL;
> 
> Linus has expressed that he prefers these done inline
> so the allocation and clearing are obviously associated - there
> is an ordering related factor as well as they will unwind
> in the reverse of declaration order, not allocation order.

I considered that, yeah I came to the wrong conclusion, will move the
declarations down.

> 
> 
> >  	struct cxl_cxims_context cxims_ctx;
> >  	struct cxl_root_decoder *cxlrd;
> >  	struct device *dev = ctx->dev;
> >  	cxl_calc_hb_fn cxl_calc_hb;
> >  	struct cxl_decoder *cxld;
> >  	unsigned int ways, i, ig;
> > -	struct resource *res;
> >  	int rc;
> >  
> >  	rc = cxl_acpi_cfmws_verify(dev, cfmws);
> > -	if (rc) {
> > -		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
> > -			cfmws->base_hpa,
> > -			cfmws->base_hpa + cfmws->window_size - 1);
> > +	if (rc)
> >  		return rc;
> > -	}
> >  
> >  	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
> >  	if (rc)
> > @@ -352,10 +350,11 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> >  	if (!res)
> >  		return -ENOMEM;
> >  
> > -	res->name = kasprintf(GFP_KERNEL, "CXL Window %d", ctx->id++);
> > -	if (!res->name)
> > -		goto err_name;
> 
> const char *name __free(kfree) = kasprintf(...);
> 
> same for the others.
> > +	name = kasprintf(GFP_KERNEL, "CXL Window %d", ctx->id++);
> > +	if (!name)
> > +		return -ENOMEM;
> >  
> > +	res->name = name;
> >  	res->start = cfmws->base_hpa;
> >  	res->end = cfmws->base_hpa + cfmws->window_size - 1;
> >  	res->flags = IORESOURCE_MEM;
> > @@ -363,7 +362,9 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> >  	/* add to the local resource tracking to establish a sort order */
> >  	rc = insert_resource(cxl_res, res);
> >  	if (rc)
> > -		goto err_insert;
> > +		return rc;
> > +	name = NULL;
> 
> I guess we'll get used to this.  Kind of annoying that no_free_ptr() is
> defined as __must_check. Otherwise would be good to use that to document
> the 'why' of these are being set to NULL.

This is the main part I am unhappy about as well.

What I would love is some way to declare that if a given statement is
successfull then "list of variables" cleanup-scope has ended. Something
like:

   cond_no_free_ptr(condition, fail_statement, ...);

...to be able to write:

   cond_no_free_ptr(rc == 0, return rc, name, res);

...where it handles setting all passed VA_ARG pointers to NULL.

> 
> > +	res = NULL;
> >  
> >  	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO)
> >  		cxl_calc_hb = cxl_hb_modulo;
> > @@ -375,11 +376,12 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> >  		return PTR_ERR(cxlrd);
> >  
> >  	cxld = &cxlrd->cxlsd.cxld;
> > +	cxld_dev = &cxld->dev;
> 
> This I find odd, there is no allocation as such in here so the matching of
> the unwind and the allocation isn't clear. 

Yes, another moment of weakness, every time I write this pattern it
really indicates the need for a new DEFINE_FREE(). I will add one for
cxl_root_decoder_alloc().

> >  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> >  	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> >  	cxld->hpa_range = (struct range) {
> > -		.start = res->start,
> > -		.end = res->end,
> > +		.start = cfmws->base_hpa,
> > +		.end = cfmws->base_hpa + cfmws->window_size - 1,
> >  	};
> >  	cxld->interleave_ways = ways;
> >  	/*
> > @@ -399,11 +401,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> >  			rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CXIMS,
> >  						   cxl_parse_cxims, &cxims_ctx);
> >  			if (rc < 0)
> > -				goto err_xormap;
> > +				return rc;
> >  			if (!cxlrd->platform_data) {
> >  				dev_err(dev, "No CXIMS for HBIG %u\n", ig);
> > -				rc = -EINVAL;
> > -				goto err_xormap;
> > +				return -EINVAL;
> >  			}
> >  		}
> >  	}
> > @@ -411,18 +412,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> >  	cxlrd->qos_class = cfmws->qtg_id;
> >  
> >  	rc = cxl_decoder_add(cxld, target_map);
> > -err_xormap:
> >  	if (rc)
> > -		put_device(&cxld->dev);
> > -	else
> > -		rc = cxl_decoder_autoremove(dev, cxld);
> > -	return rc;
> > -
> > -err_insert:
> > -	kfree(res->name);
> > -err_name:
> > -	kfree(res);
> > -	return -ENOMEM;
> > +		return rc;
> > +	cxld_dev = NULL;
> 
> This is definitely not nice to read.  We are randomly setting an
> apparently unrelated pointer to NULL.  At very least the __free
> should operating on cxld then we can use
> 
> return cxl_decoder_autoremove(dev, no_free_ptr(cxld));

That looks nice, and would look even nicer as:

   return cxl_root_decoder_autoremove(dev, no_free_ptr(cxlrd));

...i.e. paired with the new DEFINE_FREE() for cxl_root_decoder_alloc().

