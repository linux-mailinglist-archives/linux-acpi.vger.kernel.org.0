Return-Path: <linux-acpi+bounces-3787-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6E485E499
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 18:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2CA28620F
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB180610;
	Wed, 21 Feb 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWcK4aj0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559783CBA;
	Wed, 21 Feb 2024 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536683; cv=fail; b=BZzSgTJGu2ycsl0B27Vz2vqaFMZwJ+S8kNUypVi9sWuohZ0dHhSNxj9YZMq/lqZiwP6IMJJoehts7ahpzO9HtukJyuylwT5LpUGHZRTQKt9CfvLiervqDiDMVrC+fgy6KUF7tmnTJX4yHvBRCnK24v5DFl2vfJq8He7sVs7MUDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536683; c=relaxed/simple;
	bh=tGEOlIUGTmiQFq8YJKFc2kGyxOgl19SzLHWijaUoBpE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OWsLJpE/skB7T096d8FzWOS9tVtEqMZH/ftrbc2IJlz0S0Ucvzii1Osr2nVIjBvRJYcr6k+XhNlLOg3MUkLIZ3KH9QoYLynhWIPmOeYi/2SDi0hVruU4zKbkPx2N8LYr8x4+UfQQvzRTpyYZirIwgs5yD8HhH8HSEB8vCBAyhEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWcK4aj0; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708536678; x=1740072678;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tGEOlIUGTmiQFq8YJKFc2kGyxOgl19SzLHWijaUoBpE=;
  b=lWcK4aj0tYuZZlUS5DLJFYPrUX05WUjLo+puxY3Hqrt147NXyIQSfG2/
   37ghJPFCDaS1yt7dON3WmWy4syWqn2fwcTO3ff07E/fKxSa6DwvehpUxd
   AEx4ee+q7BAOJzNfyN836odgX12hnLQDTmeySLyIrk2m4sLCav1LMZKtK
   nEl7v1v4pRn/nSsvPoXvHKVxL+CAwK5vCWhcUflPE1I3cMlrNQ2YPFwWm
   KgwWApuvE9fqxIzyKepoBg+NBTdBUYLw77pt2ARfOzUFnm1J0w2Oj/B84
   UQ1C5GDpRYoXpdQh5uxcG1jdW2Vj9dsIQ3wgR+ET8RkmAH6HDs2Po15jb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13333949"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="13333949"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 09:31:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913341918"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="913341918"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 09:31:17 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 09:31:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 09:31:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 09:31:16 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 09:31:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJj4ejO65E64t5RLm29WzktQ0dHXF6rzcwiP2URjrvWvkGzVs9LkGjGbsI5p99QOSVKQB40SacrNMaT9It5k5xnU8s3j2ke3I9wnivyHVMfbRFmlmp6HeT4i0HJ+5018fvekNCAhgdACXgjNoGmjkT0rZnzLRWgr203kMUbL2a2TDp05658C8UbEqfGerTOjiBgBmzKRHzu1phquekGZvkMfDYPrEOQKbeSofHmuyT69EHCSq88r085Ck3OAeJInbUqPeAGpPFDsVASKElA+pnEZ9j68FRfeTT7BflMy23NHkVF5U2s335dtBal3JipX4pgbpR55yAeFYmhJLvGDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASKGVFqh8CIJ72Laf9q70S4uw+WHLtoDVTdYXj+4NVo=;
 b=N1ne9SvlRZ676XoPu7OFuGL50rz1NYm85wtyD7XgS0nJRm5RFd2KLT3j9sEtP9kpw42ZLCTibWJ3jeyjpCsgbwgmINoH19Bfr334TiInxMxdAmsgeUv1wsaFp3wozbklj6jEs0JJlfTfVLaerZsnJHM+s7sjatE1LCZGpWnuXcIuBS+7cIL0JMyC4KqB/cPxvzzDIbustYfI1iGQjwOIspJ2nQ17Y1SAam849LFzw1KJzJeNifkAoJIhP98mQYTiRtlRaxrueYPmdyWFNGNX94v56BD7NkYTceEwJG0g1paOGEu3xODYA07Gx1L4/s+mbhYof3iE/QCMK7zA60McbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5346.namprd11.prod.outlook.com (2603:10b6:610:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Wed, 21 Feb
 2024 17:31:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 17:31:13 +0000
Date: Wed, 21 Feb 2024 09:31:10 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Fix load failures due to single window
 creation failure
Message-ID: <65d6335ea74ac_6c745294a8@dwillia2-xfh.jf.intel.com.notmuch>
References: <170820177238.631006.1012639681618409284.stgit@dwillia2-xfh.jf.intel.com>
 <20240219124041.00002bda@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240219124041.00002bda@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0269.namprd04.prod.outlook.com
 (2603:10b6:303:88::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5346:EE_
X-MS-Office365-Filtering-Correlation-Id: 29419e8a-49d6-46b1-a5ae-08dc3302e66b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbC58/YiJ7/RvWZA+sX6ojRpG841XnpnhL+MgU7mjlVN4ykeNET4F3s4c415jp92LvlTe5gW41D+y2BcHYom49/eojBMa4G1auGAsdYrpVwSEJaXxfoGml2klAe+eakVhbEoqoPehURiC1R85YOYzZKf1opTXk650hFgUGtix++Y3f33NMNQGyzj7VTlTi/1wowqjzDiRMcvHmfthQJ4TTisk5l9IlgBJsEzRAf/61DE4fEivjLiTLxNFZIJ4AMjQaYiSNdRhCe08/Hh1+/x2hIAPcvthLkTlniSYoQjLvb9zg5OPE50mKSgsVnHpkVOxNUFU7HNGFUL1BsjKxFfpZ9dLb7MqsIp/kN2YbFN1S/PL8yRPBn5yGFFhOhRcr/vTFZd5+IDKG9DpPil+6xBAxEEGhqWZkqBEjUAIbhhKdazkwsP3O+tNin8LPOMrBCKf+aZcxIm7N/4xcLJniIOiC2BmSQQQAUgYPGwoDym2U1nOYWBImSX5k2+7PFTLJXZ1Rd9H6FJXvPnYIFD5hvkDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zpmIXFLe281EVRpmRI9VLIKpKLn9hqpsdV7EIEwq5e8ao1nb0itxbnypvQ64?=
 =?us-ascii?Q?D9YYhCPvwRVudgE6a3VCgGXAp53pEykwcvF90r5jG7d9NwEF+cHmMpZpDJEB?=
 =?us-ascii?Q?9Q/RHwOhdho2tnp9yJjbPHRK2k4A4CPtOQArCP31wVS9zu231eZTeSQfvF5p?=
 =?us-ascii?Q?Bz5MuCqlIZzUTagzf+bLSqBIJJCVqGE49ATwhJoaKzM9afe2WslvDJy0L6qv?=
 =?us-ascii?Q?J5B30BfmjcHXA0AQ7g2P/i0BSsApbtBBp2onLn9zoYOYGoyT5oUlVsXzXg7B?=
 =?us-ascii?Q?PgJ+kzOpTiXkLrmghipqxLvsKBEHD2YXX5WobrcPcq7zThftibRhBiqj2YjP?=
 =?us-ascii?Q?lA4Vv7ZDkwq0FLCvTeKX3qsmE2sDoOZzCKmFBFwxjf60L7aPfPLSkWKjhCkp?=
 =?us-ascii?Q?qbujbrcufn0QCY9B0WXQ19m38/C40iBi7Z7uw8bGs/PKXEaJKk68NDCIxlT0?=
 =?us-ascii?Q?jzuDn8XZP/rPtoLamCAZndUlbwjm8B0HVM6b5hQxMOTaFoY2ggrCdxyvGPZE?=
 =?us-ascii?Q?che5SfN5gQbmWN8UG36WnfMreP0/Do4Y0oQ1FGOi0Cs6QJ7wV5UzkqxHpUYV?=
 =?us-ascii?Q?ye9C2uPho9/dCxxgkZ9k48x6JpP/ZtCJ5n9rHI9s5N5vHFBvveaaFOz4XJI9?=
 =?us-ascii?Q?gOw3sXz6db4SCydKK1wFm7yU47HAmLJNlbMQx0Pn8IKaoC54WM3besaoGBD6?=
 =?us-ascii?Q?BkImNjdthzGNGowiHNYOb06ZKHa1R9yR23SNmgpyCpDrXlZSDZSEFB+/pMOR?=
 =?us-ascii?Q?g6U/OYdNSdUbCIlZvgr/rhtr+5AGJj9v130bW9x9F0O5iHHEUCXWsX7eNZa2?=
 =?us-ascii?Q?rEb3Th3RWQv2BoCOCuqoWBygBP09QifegGzGwxPlIN0TDp/uy+LijcU17wTX?=
 =?us-ascii?Q?AlUP2vWxLa12WmsLogJJ75I5jy8r6arGmQXP6YCVLs2P24OQeqJk+pgpnM/Y?=
 =?us-ascii?Q?rZqQ1a9b95yzhCCHcfEkhYrYw9lYydDrO1n/nEyFcZ1BKclHHrUV7LkGUQdD?=
 =?us-ascii?Q?3eM77m9knmsq144u78ChgA8oFU7TvyCD9DuAuElaRPAnDSL64U0w/b4v5C7T?=
 =?us-ascii?Q?Jel8oKWJu4PrXURjLSw5m8RaEi9UoXRHsqhs4dl9KHiEkpef8FSe+ILhzjM9?=
 =?us-ascii?Q?dDOqE312waB5RyXdCd44f4JG3eIu2XYT9QecvpxHb59JtSWrEHHL8ib1Gk71?=
 =?us-ascii?Q?wHYo9NWdbnhBc8QUTrKbQ6RSpndi8YRh0DRnvvLeGmxgqjSJAVA4jjv06b+/?=
 =?us-ascii?Q?EEZF8ptSQleYsTjjGE7IB+wf/YjGYvmVMuMXQNoAXbVSjuZU2OJVM08Sq3ik?=
 =?us-ascii?Q?exMgwjQnlMmFmbHMU2pIVJPXJyt+RBjCCGSi28eJkP7d56LXFNQc4QEe2Zmo?=
 =?us-ascii?Q?6I4abYhPAQXl6/VOLkqnXvts6/nEPQ0oZKmATQQBThn9TyghA09cKiI5Zl6G?=
 =?us-ascii?Q?F79TgXLFkvTcd3xmyRAUPzyezeN845pkGkr8cMPNAuQeXwnxo6tzYBxyQdIj?=
 =?us-ascii?Q?tG2IUw2mXSZnJtnMMinwPqpWhS216tF54t21q38w+2vwKF3kZ/pDuAsy5vMG?=
 =?us-ascii?Q?TWBkiTRuQL9lRr+ZWhz1846V3/GWgfntA5I2a/yWgr3J71cT79iFL95Q/4QH?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29419e8a-49d6-46b1-a5ae-08dc3302e66b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:31:13.0365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZvGgWVUK22iu2yMTM3sTFErvFd5AhcTdcA6/F1VCI3xKK9aMRalShmsDz0y3tfmg05nUAvklfsY84S4GGvFyHOvtMMGkGaQVTPQRw3OyKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5346
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Sat, 17 Feb 2024 12:29:32 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The expectation is that cxl_parse_cfwms() continues in the face the of
> > failure as evidenced by code like:
> > 
> >     cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
> >     if (IS_ERR(cxlrd))
> >     	return 0;
> > 
> > There are other error paths in that function which mistakenly follow
> > idiomatic expectations and return an error when they should not. Most of
> > those mistakes are innocuous checks that hardly ever fail in practice.
> > However, a recent change succeed in making the implementation more
> > fragile by applying an idiomatic, but still wrong "fix" [1]. In this
> > failure case the kernel reports:
> > 
> >     cxl root0: Failed to populate active decoder targets
> >     cxl_acpi ACPI0017:00: Failed to add decode range: [mem 0x00000000-0x7fffffff flags 0x200]
> > 
> > ...which is a real issue with that one window (to be fixed separately),
> > but ends up failing the entirety of cxl_acpi_probe().
> > 
> > Undo that recent breakage while also removing the confusion about
> > ignoring errors. Update all exits paths to return an error per typical
> > expectations and let an outer wrapper function handle dropping the
> > error.
> > 
> > Fixes: 91019b5bc7c2 ("cxl/acpi: Return 'rc' instead of '0' in cxl_parse_cfmws()") [1]
> > Cc: <stable@vger.kernel.org>
> > Cc: Breno Leitao <leitao@debian.org>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> General idea makes a lot of sense to me.
> 
> A few comments on specific implementation inline
> 
> > ---
> >  drivers/cxl/acpi.c |   45 +++++++++++++++++++++++++++------------------
> >  1 file changed, 27 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index dcf2b39e1048..53d2dff0c7a3 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -316,31 +316,27 @@ static const struct cxl_root_ops acpi_root_ops = {
> >  	.qos_class = cxl_acpi_qos_class,
> >  };
> >  
> > -static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > -			   const unsigned long end)
> > +static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> > +			     struct cxl_cfmws_context *ctx)
> >  {
> >  	int target_map[CXL_DECODER_MAX_INTERLEAVE];
> > -	struct cxl_cfmws_context *ctx = arg;
> >  	struct cxl_port *root_port = ctx->root_port;
> >  	struct resource *cxl_res = ctx->cxl_res;
> >  	struct cxl_cxims_context cxims_ctx;
> >  	struct cxl_root_decoder *cxlrd;
> >  	struct device *dev = ctx->dev;
> > -	struct acpi_cedt_cfmws *cfmws;
> >  	cxl_calc_hb_fn cxl_calc_hb;
> >  	struct cxl_decoder *cxld;
> >  	unsigned int ways, i, ig;
> >  	struct resource *res;
> >  	int rc;
> >  
> > -	cfmws = (struct acpi_cedt_cfmws *) header;
> > -
> >  	rc = cxl_acpi_cfmws_verify(dev, cfmws);
> >  	if (rc) {
> >  		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
> >  			cfmws->base_hpa,
> >  			cfmws->base_hpa + cfmws->window_size - 1);
> 
> Why keep this error print?

True, that can go.

> > -		return 0;
> > +		return rc;
> >  	}
> >  
> >  	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
> > @@ -376,7 +372,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >  
> >  	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
> >  	if (IS_ERR(cxlrd))
> > -		return 0;
> > +		return PTR_ERR(cxlrd);
> >  
> >  	cxld = &cxlrd->cxlsd.cxld;
> >  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> > @@ -420,16 +416,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >  		put_device(&cxld->dev);
> >  	else
> >  		rc = cxl_decoder_autoremove(dev, cxld);
> > -	if (rc) {
> > -		dev_err(dev, "Failed to add decode range: %pr", res);
> > -		return rc;
> 
> As no longer sharing this message. Might be neater to have this lot as
> 	rc = cxl_decoder_add(cxld, target_map);
> err_xormap:
> 	if (rc) {
> 		put_device(&cxld->dev);
> 		return rc;
> 	}
> 
> 	return cxl_decoder_autoremove(dev, cxld);
> 
> or a second error exit path.
> 
> 	rc = cxl_decoder_add(cxld, target_map);
> 	if (rc)
> 		goto err_put_devie;
> 
> 	return cxl_decoder_autoremove(dev, cxld;
> 
> err_put_device;
> 	put_device(&cxld->dev);
> 	return rc;
> 
> err_insert:
> 	kfree(res->name); ...

True, there's enough here to do an even deeper cleanup... below.

> 
> 
> > -	}
> > -	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
> > -		dev_name(&cxld->dev),
> > -		phys_to_target_node(cxld->hpa_range.start),
> > -		cxld->hpa_range.start, cxld->hpa_range.end);
> > -
> > -	return 0;
> > +	return rc;
> >  
> >  err_insert:
> >  	kfree(res->name);
> > @@ -438,6 +425,28 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >  	return -ENOMEM;
> >  }
> >  
> > +static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > +			   const unsigned long end)
> > +{
> > +	struct acpi_cedt_cfmws *cfmws = (struct acpi_cedt_cfmws *)header;
> > +	struct cxl_cfmws_context *ctx = arg;
> > +	struct device *dev = ctx->dev;
> > +	int rc;
> > +
> > +	dev_dbg(dev, "decode range: node: %d range [%#llx - %#llx]\n",
> > +		phys_to_target_node(cfmws->base_hpa), cfmws->base_hpa,
> > +		cfmws->base_hpa + cfmws->window_size - 1);
> 
> Could maybe put this in an else below?
> 
> > +	rc = __cxl_parse_cfmws(cfmws, ctx);
> > +	if (rc)
> > +		dev_err(dev,
> > +			"Failed to add decode range: [%#llx - %#llx] (%d)\n",
> > +			cfmws->base_hpa,
> > +			cfmws->base_hpa + cfmws->window_size - 1, rc);
> > +
> else 
> 	dev_dbg();
> 
> so we only give the dbg version on success?

Yeah, I will switch to this since the previous state was also skipping
the debug messages on success.

Follow-on cleanup:

-- 8< --
From e30c267c0b69d5e4531d8f65ec86e4fa32d72340 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 20 Feb 2024 22:44:34 -0800
Subject: [PATCH] cxl/acpi: Cleanup __cxl_parse_cfmws() error exits

As a follow on to the recent rework of __cxl_parse_cfmws() to always
return errors, use cleanup.h helpers to remove goto and other cleanups
now that logging is moved to the cxl_parse_cfmws() wrapper.

Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Closes: http://lore.kernel.org/r/20240219124041.00002bda@Huawei.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 1a3e6aafbdcc..b1ea2d152c65 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -319,25 +319,23 @@ static const struct cxl_root_ops acpi_root_ops = {
 static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 			     struct cxl_cfmws_context *ctx)
 {
+	struct device *cxld_dev __free(put_device) = NULL;
 	int target_map[CXL_DECODER_MAX_INTERLEAVE];
 	struct cxl_port *root_port = ctx->root_port;
+	struct resource *res __free(kfree) = NULL;
 	struct resource *cxl_res = ctx->cxl_res;
+	const char *name __free(kfree) = NULL;
 	struct cxl_cxims_context cxims_ctx;
 	struct cxl_root_decoder *cxlrd;
 	struct device *dev = ctx->dev;
 	cxl_calc_hb_fn cxl_calc_hb;
 	struct cxl_decoder *cxld;
 	unsigned int ways, i, ig;
-	struct resource *res;
 	int rc;
 
 	rc = cxl_acpi_cfmws_verify(dev, cfmws);
-	if (rc) {
-		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
-			cfmws->base_hpa,
-			cfmws->base_hpa + cfmws->window_size - 1);
+	if (rc)
 		return rc;
-	}
 
 	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
 	if (rc)
@@ -352,10 +350,11 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	if (!res)
 		return -ENOMEM;
 
-	res->name = kasprintf(GFP_KERNEL, "CXL Window %d", ctx->id++);
-	if (!res->name)
-		goto err_name;
+	name = kasprintf(GFP_KERNEL, "CXL Window %d", ctx->id++);
+	if (!name)
+		return -ENOMEM;
 
+	res->name = name;
 	res->start = cfmws->base_hpa;
 	res->end = cfmws->base_hpa + cfmws->window_size - 1;
 	res->flags = IORESOURCE_MEM;
@@ -363,7 +362,9 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	/* add to the local resource tracking to establish a sort order */
 	rc = insert_resource(cxl_res, res);
 	if (rc)
-		goto err_insert;
+		return rc;
+	name = NULL;
+	res = NULL;
 
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO)
 		cxl_calc_hb = cxl_hb_modulo;
@@ -375,11 +376,12 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 		return PTR_ERR(cxlrd);
 
 	cxld = &cxlrd->cxlsd.cxld;
+	cxld_dev = &cxld->dev;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
 	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->hpa_range = (struct range) {
-		.start = res->start,
-		.end = res->end,
+		.start = cfmws->base_hpa,
+		.end = cfmws->base_hpa + cfmws->window_size - 1,
 	};
 	cxld->interleave_ways = ways;
 	/*
@@ -399,11 +401,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 			rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CXIMS,
 						   cxl_parse_cxims, &cxims_ctx);
 			if (rc < 0)
-				goto err_xormap;
+				return rc;
 			if (!cxlrd->platform_data) {
 				dev_err(dev, "No CXIMS for HBIG %u\n", ig);
-				rc = -EINVAL;
-				goto err_xormap;
+				return -EINVAL;
 			}
 		}
 	}
@@ -411,18 +412,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	cxlrd->qos_class = cfmws->qtg_id;
 
 	rc = cxl_decoder_add(cxld, target_map);
-err_xormap:
 	if (rc)
-		put_device(&cxld->dev);
-	else
-		rc = cxl_decoder_autoremove(dev, cxld);
-	return rc;
-
-err_insert:
-	kfree(res->name);
-err_name:
-	kfree(res);
-	return -ENOMEM;
+		return rc;
+	cxld_dev = NULL;
+	return cxl_decoder_autoremove(dev, cxld);
 }
 
 static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
-- 
2.43.0

