Return-Path: <linux-acpi+bounces-3955-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A74867C7C
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 17:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21DE1C21C8B
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FE812E1CB;
	Mon, 26 Feb 2024 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K39tD7EG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BD12CDBF;
	Mon, 26 Feb 2024 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966185; cv=fail; b=nAM0HeFGgkUBrMm3JrHDH7J1IPCeNeDysP2sTwpyuhme4HEczGPZkxZ0sC6Ui4G4MZ/83tOihm20GapT9dqiLQ6orArFo48XfvZc/iHe+CHZhWYjqpoSEcd8sjIte1O1FAdJ6pjCNIz8BwetL4mlFiMdw+mdA5xCoLCLFM+A6oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966185; c=relaxed/simple;
	bh=6z7hBXYTIHGBjClkeR9mSrpd1le4Rk16wcW5rRwSNwE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CiZbHZs6jqr2PNRnd0z4GRlf4d56vK2KYwsRcR02q4uoXAcdw5JjWRVBido+G12LXp10Rt0JUW838EnTxbEEPtkul4z9SDmDX+9Rt5QokSJ2Akr5pklQSIM1FMNdZ4xROEHLxef4+GDXuHTHJy8oZBhR0+Dc1sA1GQ/qJtaLBS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K39tD7EG; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708966183; x=1740502183;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6z7hBXYTIHGBjClkeR9mSrpd1le4Rk16wcW5rRwSNwE=;
  b=K39tD7EGY2XQD3GoEDn093C5pYmITCOJb2tZoY45iANylzvQwWu6BgCu
   BJF2OoODIiG09mgSoDU7+mKcaqyHP21kw/YzMJcSU9QEkLRatSkyndj39
   EB+KXxPa9rn4yaEXAM1N/go3W0r2TBE36wHTo1YW2vwvS6qKcjjqYlNu/
   i5GMlc4g7JBOOu+BafbvPrzqxYHCyxeICrk2WckUIO1W0C3tXhlhukcXv
   RUIqg9efo7sUOEdxLJY64bPFw7dmJedxUkM98KgUyo3P5N4s7Ki/ZeI+4
   8rqUacHqsrmHFEeTYEEIH8vnZ7fcpCE8/J/aufzI8RVG1/6sT9HRCKlGx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="13967837"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="13967837"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:49:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6934089"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 08:49:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 08:49:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 08:49:40 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 08:49:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmTKKgA7bRVYP3SvG03AQVu1OX5vLkBsA0auXrWixRC/q/nvyn9/eczLxZSH5PFJktlM2B/vuFKHxP3uKF5JlNrJzQM+qUgmUU5oShUXFXLu5qkPgJ0BdLy+zpr2ARfV+aeELiMoyJBYIJWzYZF5XPXrl76VDyXGhTrYJR+iDylVIOX1eRVK4xtsvflCWyEYuhkJmjjdfI1hv/htWUgich2/qQxOyt8GJgdiAxJtRRO+lOU90UadhRKt5/a6YRy77LAPqRqMXKTt/3f0Dh38QzgQ1McGyCdZU1vybwdjWpk2hOsTHqx9qpxPO38CaMjsRf8PKHyJRIVGaaxxoCDx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx40cIZDX7TbEBO/ZQ1jSmn9nVBT24FhA93bdmLsjGM=;
 b=UnPn6X4LB+/xHcZortFz/haqoMaXnbkxikQChymUVkNVdM/K/qKsLM4SIc/3BAdx9hDoFMfT4MdqCwip4LuCDXAw0o/8Q0PoJ8+EHwSr561xb/Uxs1rxrvR84f/EbshVpJSIHnmW8mLHoJueLUjpKWqBbpNDzbtYylSmPeg9dXaWojQncEhUtnQqoW+3Mu2chmWqq5IrNDqQWvO6SHlsQooQlzTj2d5nwyuEgTTFGtC04VivBfD4si4RnxMqcgMfnvDKYsoGYgHkcOESuTla8nIC+yDeCoZ4aQaSh/lVC4DQsUmUIz2dbobGrU9lOi8POebV1iv0zYryLe4moH5NsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Mon, 26 Feb
 2024 16:49:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Mon, 26 Feb 2024
 16:49:38 +0000
Date: Mon, 26 Feb 2024 08:49:35 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Fix load failures due to single window
 creation failure
Message-ID: <65dcc11f608e8_2bce929446@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170820177238.631006.1012639681618409284.stgit@dwillia2-xfh.jf.intel.com>
 <20240219124041.00002bda@Huawei.com>
 <65d6335ea74ac_6c745294a8@dwillia2-xfh.jf.intel.com.notmuch>
 <20240223132829.00007741@Huawei.com>
 <65d8eeaaeb302_2509b294f3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <65d987b04e98b_2509b294e4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <65da43d38df20_2bca029483@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240226141025.00001acf@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240226141025.00001acf@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0205.namprd04.prod.outlook.com
 (2603:10b6:303:86::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0cb562-a721-43a6-ce28-08dc36eaeba9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnQ9irKPWfPBd2bFApV7CXLk9VImBX2tsJNPXVlv/9Aq0JQ/6s6Bz+f/seW0taNe15HU4XZaJp4XAJPRwanXyuwll0n+KKPhoeCSJXcZC8W0mzo2jTLhjZ7P781x8VB7kamsV4zIZAzSnXMUc29bSrgRHWOxD8NT8z3D+2M7IIK7ob3lm+WduB9wBfwwUAtaVpg1hQVR97cAh/biheq5jxoKhJrzgZ06+m/wbkcClBzBRE1s53QTe/PEYGKKUOWwJ+7cx9AyYGKi3NRUpXKGMRVuTXPSnMYa1MaMvAbIeSickNoGuFNHHmeVteWtxr33Zzdq/jdknIbBQ8xYIhoeBYxl/D2KabjPxjdq6gUFuFN+nS+PQK6G2tctIPatbFuT2ghgRLozAeKaL5xiMn5dzmrkGicp1SuKfWjSmdGKpGRltr1Popmi0a1biS7U0Z5++8R549OdlDeNFYXTNUHMnSxJMjL8jX0jXX7ENSqNQ27kzk6Un2HXsB1gC8D538qT7ribu6G4xbAiwPpmHGFSOuwLxBGdnFYSgTXNhxqsrd9tLExOqx+CfwQ8itZF7Bhnf7cUhxiXLkWHbyGQXXMstcmKGrmgzcUQNcPtD5uf+N0m8sp8vg5t3muWCWQzsAdB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zuUaNZxefDN34nnUJueOWv4LkTr7apUIA73GPf1qTzpUONApVf+qHYaOjhKx?=
 =?us-ascii?Q?HwOrNUTo7oi+z66FUxtoQFMz94Nfg1WPkFqLiCvfIbwbtqjfBwiXXueAYwow?=
 =?us-ascii?Q?61DCWUK1gcYelEgJZ0X1sImDKK55jAGNAPzrIquIsXw+P3uQ91KZamdRXOTA?=
 =?us-ascii?Q?ed8wa6B3oNzbfLN3L1A6GYEPpKbpS3g6l7DmBib7ehuMBxYPa2XlnhKwmYiB?=
 =?us-ascii?Q?h8JC8S3koUmDBm3eohQJaYelOI0tqEi1t9BaLb/L+no3lE4S2JFtUAjMYp6z?=
 =?us-ascii?Q?8nU9Y+NL3NhLZfRWvttQJht303Ftz48M1jdNVz9yGsGUuRcnY/BBNbuZk20r?=
 =?us-ascii?Q?SLRXJBJPPVVW1eYIRhlLapr81Dcrdi+prJnzgTujeYCNUeWkefuOO/dxYjfh?=
 =?us-ascii?Q?+aJ718+TTBna+6/ldpnLCzxIw4SAhxq+6ka87J8PZoiCpvLe2UIawwdgweDn?=
 =?us-ascii?Q?cCwhMrxjwKbRU9uIwaQc0/GSleSTNDG+ij3cM7deKRJHEeWCXzNwjO3WbNOW?=
 =?us-ascii?Q?vLSYiEWhmSZ7jgtouaSovGJH2f74qujijT6MX6GJ+folTq7rFk9gqwS1QDb5?=
 =?us-ascii?Q?3aRPP5hbi1IdRNvVuGXtX+dCFbx/XcxA4tXPpmwsZpnf4RqRkW/meqC8J1Cd?=
 =?us-ascii?Q?e04ZvrzQ0rM95orztLw8FI9cMwQ/d3qwyxh+hmzcAzFTYyv2v+W3nI8VeDb6?=
 =?us-ascii?Q?jWOqNpWfg6fjdhewY4ZtxUX9aHtYW63p8eP8yJaCY8u/aeoNH/6pPDXNvVxC?=
 =?us-ascii?Q?BP7bJoAJ38n8FgcNEuub/INcVXgv2t21F6WUqxl0OW1lKMi8wwEA6EXtfgWK?=
 =?us-ascii?Q?rxirKV4iGvrBF4OZwEPyo7/LPUOKU/8/TaIJJ8ZCoLgP6QUthbPj9zdq2kXw?=
 =?us-ascii?Q?5nDCMvwkxFJkVa4ijVw5kTsCrE44BYb47tUW9ojBT1gYfJ5NaY+VvgkF+aju?=
 =?us-ascii?Q?pq6QFToADFHBgm4tm5jcNAAnZGWbhIrVTvqgARTkTzY+6A7jIT+aGM6/99GQ?=
 =?us-ascii?Q?IoGycaqrcfBDkkjZjPzgrk4k5eTbcEKL138lEAc3ENXYUaCanwhEnSP7BX+G?=
 =?us-ascii?Q?O70N5UUAL4q/cOeaf0OlCdLjEAqmZMHmQm3r82AFUiKRntG6dB+wJPoQYk2N?=
 =?us-ascii?Q?9+8/KXD9hVG6PpjQesrLvWkFQoWClqTtKEDUU0SzC2vAvB2qTn/bv8M6MZug?=
 =?us-ascii?Q?ZXElQJU8BZLvrAZZf6MrEKYPdawZXI0Xiv9BKiZwIsGDbpCLV7tQxGc7OH+F?=
 =?us-ascii?Q?bGGipHeeBCGspgdshvDwO90oiBj6OmbTovS8Lm+tRxhV5/G5Mk3drPgh3dxR?=
 =?us-ascii?Q?bfd8GLg5dKszDMb+mjVK49cjp7QrKYc19LtU8zyJNvdY+2kBVOuNW/x/Q2iF?=
 =?us-ascii?Q?q6pvaYlYRmqUpK9qK3Ql7xFCDhN5fCpsuirsXR9Bgv7fPUvrxglcrqpSx/0o?=
 =?us-ascii?Q?jslyi0cWjsdb+NHc8BVyDY7hKu6Kqk+QM1A9PBweFe+X51bz9xnp1v4Oj6Kn?=
 =?us-ascii?Q?eiPoZG42Ln/0WQXnCMgRdvWXSWsaDpjuxAuMjkzgo/yu9n9oNcxi6mhST29E?=
 =?us-ascii?Q?86iKjPzvm0KafmZu/mwPlyA/vhzJrxYbcEXTTHY+S1GvggCP5Enl1PQXoDQ1?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0cb562-a721-43a6-ce28-08dc36eaeba9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:49:38.5218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FevVGoOn9++q37uyXO9ONCAaNox2FrNl6XZFUmo/aEI5hkP9B/cLYFx8mWCP4tvA4+lx2saqNb4SoqYlnl8HmaKwyElEeAKZrXr2rVvxIjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6375
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Sat, 24 Feb 2024 11:30:27 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Dan Williams wrote:
> > > Dan Williams wrote:
> > > [..]  
> > > > > This is definitely not nice to read.  We are randomly setting an
> > > > > apparently unrelated pointer to NULL.  At very least the __free
> > > > > should operating on cxld then we can use  
> > > 
> > > So, how about this... I don't hate it:  
> > 
> > ...and the version that actually compiles, fixed up cxl_root_decoder
> > declaration and dropped the BUILD_BUG_ON() since it will naturally fail
> > to compile if more than the supported number of variables is passed to
> > cond_no_free_ptr():
> > 
> > -- 8< --
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 1a3e6aafbdcc..5c1dc4adf80d 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -316,6 +316,8 @@ static const struct cxl_root_ops acpi_root_ops = {
> >  	.qos_class = cxl_acpi_qos_class,
> >  };
> >  
> > +DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
> > +	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
> >  static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> >  			     struct cxl_cfmws_context *ctx)
> >  {
> > @@ -323,21 +325,15 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> 
> 
> >  	/* add to the local resource tracking to establish a sort order */
> >  	rc = insert_resource(cxl_res, res);
> > -	if (rc)
> > -		goto err_insert;
> > +	cond_no_free_ptr(rc == 0, return rc, res, name);
> 
> I'm not convinced this is that much clearer than
> 	rc = insert_resource(cxl_res, res);
> 	if (rc)
> 		return rc;
> 	no_check_no_free_ptrs(res);
> 	no_check_no_free_ptrs(name);
> 
> with better naming and with that being defined in similar way to your
> __cond_no_free_ptrs()

Can keep that as a fallback, but if Peter / Linus agree to the syntax of
cond_guard(), which follows from scoped_cond_guard(), I would ask that
they consider cond_no_free_ptr() as well. Single statement termination
of variables paired with the single statement that took on ownership has
an appealing symmetry to me.

> Just keeping them in the same code block is probably enough to indicate
> that these are there because of success of insert_resource()
> + no need to handle bigger and bigger sets of params in the future.
> 
> 
> Rest looks good to me

Thanks for taking a look. I'll run cond_no_free_ptr() by more folks and
if it continues to get a cold reception I'll drop it, or maybe a third
way develops...

