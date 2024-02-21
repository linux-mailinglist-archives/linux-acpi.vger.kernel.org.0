Return-Path: <linux-acpi+bounces-3764-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4781385D057
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 07:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B503C1F21F5A
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 06:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A892239FFC;
	Wed, 21 Feb 2024 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nq5rv190"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFE439FEF;
	Wed, 21 Feb 2024 06:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496340; cv=fail; b=WHLmFfOOXchGjp1DRqi4V8VpxTDoO5O6vGjHKzk7hdpKSF8FoM45MRFFq82CF/Ad6g9p3VTaFIptoI8BwW6LLoyiQHArx26iuxW8qhCAllfruDvP/ancFcqtGJTqbgRRMmP11HbWH5ZFrprBinpcneyd+XyT/4FGllAWfVGfSqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496340; c=relaxed/simple;
	bh=tRZeNweNvx/9fsZK+XcIVWs2EtPUba147zp9Vr5WNKM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QiHpglIX6MquYIX9Kk8sWIVd2bLqXomWXdh65IUlFGHvezsQwruwz9R/wg6iucghRpNVoXVI9Wmgfsh/tAE2+npMexk0fr4YYeoK1I9a75KVOhcCbTfJR24pMXa7FUlO5MzHj8oKXZmbqMTqXEfH/vlO04J/I3BI0Fnui279o8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nq5rv190; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708496338; x=1740032338;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tRZeNweNvx/9fsZK+XcIVWs2EtPUba147zp9Vr5WNKM=;
  b=Nq5rv190+GIR0MNiDX/uNk+F801Xm6YU4shgyxwBATjU3hoKsHDD1umJ
   nq+daL6kvPUeg2/mLuq5yhVKtOd1YaTjqyU/ako3KoSp4L93SN8spl66B
   ewNUC956yaxCdf+kmTy26G9OjFGRzADyGA+6t8bZoRHiqzG7tQWK6DLp2
   SQsvqgr68FDtgZ7wJmCuDK8GjwWYeO7kyJ0nYqnAUT1C5ku+IKlM3ITSH
   k1s4WLLmYs26ssOZpCC1gs8cNF93tNLMCDH7vsAD6ncHVs+dpujNdExvr
   SGZ9K1pQcU4r1jhvIcLQKBf9zku0NzOOqdJH5fo9+057JChCkS0JF2BNV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6454669"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="6454669"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:18:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="28180817"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 22:18:57 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 22:18:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 22:18:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 22:18:56 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 22:18:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIhoEdM1nSWRWJvk/8Q9vo+cSECoYc/ZDOxoteOH+4AL2p48qnQdkv2emYmvuiFzcwnbyJBxbOJCUbqGGlaGC2EUE5xZMvudgW5katKaJdu3lMROCkQrO/e5JUgQNeR4pdj/a8JFL5o6x6FG4mE/2HkLmWZa7hbx0jGE7Cj7h8ry2PviSkXslwgeMtSkzLv7Z1YoTXYAEmHCV+HPqEUZvnDjfp/nMpHNX9MT5xHAraTiR7OLrirQ1r0ZL/F7N4hk+swwLuylB/R9wJSouU95N+lkzb9ntVD0hIMoUpFv78S5/Q/5J6JkHcDBRR4MfIOutzMP4/S1L333ijvP/FE3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz8DhllLN8mHB86O2q6B9jeC+91vouAxfiX3tKN+7aU=;
 b=d+l9OONsC8EAby9gkxcKqmJKkO5ey5k/xLeHVNdjNBQ0i1V06f6psus81AP/joBxD8F93PdoqIsqGfXHNU/7j6IdG1Iv6C9TvYOO85IQwyCIiVdc02B3KniWrA9bx8syGMTgKLuuDEMb4y7xVtXXafKsUemL79RkuC+Nd4wE9VgM3QDbJZ2y47BFWVUKGBhkjaqc1hfAjrCQ9i+Pbr+6Unf31nztZodnFfj5o0rP23vvBHwK0YBF9NNJfhJqk8Uto9AZaoUX6AQyNzPXktwwRQDcUDEiiyo0dTHATfG+Tyk6uNmxi6ttS8zG837/feMeGTzpsKbS4scp3Y1xLPKgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SJ2PR11MB8537.namprd11.prod.outlook.com (2603:10b6:a03:56f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 06:18:53 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::545:6a88:c8a8:b909]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::545:6a88:c8a8:b909%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 06:18:52 +0000
Date: Tue, 20 Feb 2024 22:18:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: RE: [PATCH v13 1/4] EINJ: Migrate to a platform driver
Message-ID: <65d595c990661_5e9bf294d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
 <20240220221146.399209-2-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240220221146.399209-2-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:303:b6::26) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SJ2PR11MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: d2637b56-9930-42d6-a201-08dc32a4f9d0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NG8Ke872m1g6CeeLW3KJkXMLuzimD2RPi/0Hpz9zkZMLTr4ifz7ctEl2f9yCOXlr+qSj2JiSkGKA4gSYBzoTBZ/ikff53BOHePhdJJej8Dd3+VtvC0hhzCI0gcyypQ5eQjV7E6cWY3k90ngewMV9bSUU6/pFt0zDXAeaB2eC3UAZ1cssM8JYnDJEGRYtWvW84sfztQpG0/poSi0T/lpfT3SsMOvlc7SoGZtYr1Pl+r5bDmHT39RdF1FkkdbipNU+sz2vlYYgKT+FeWGSwBA+okV6SPSW0+Hiqopb9M2aONWNF/E4akP5tqQuKikyY1WuK9swvWWtc/y0ishUkmSRjDoM071uP56H+MsvfZYZ+xvZhjk2ngS83UuZrCPf5eRgAV3/1CPaPfXoBKU2u3fbfWaDSdS7ETRtmh7lTIZ0HyISGFyZhsa9ALGodn6QzPra8qB3/Gl8dg9sFpf7jiQ/EDFjYsWl/H3Euwh3wdeOlnrkP17JpufbNuUznSp2bqgzo4wkuDD4OhgGsuk+wrJQwQsRpF5t3D2Z7psjJ1wmDtaKQsKzx4xmQYJeW/62oxTR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?byJ1f5WnzAHaqYkkdFOQAAEYqGLqysscQsPMLx/qt22KRixBATSdVeGlJXWh?=
 =?us-ascii?Q?9fdSvN6DDVX+FIKNBk0cCTXN7ZRbs07Q2iG+h2t/9fllrrfziWaqolfJSdGQ?=
 =?us-ascii?Q?rERUJT+Y/KsEOSIx3nl9tGz4B+IPFSJ/CYTXwDt0JaHZ7OVyzCFVEO34AcQd?=
 =?us-ascii?Q?pgrGbDpJ2RdP5IsBDTLyeoO8qLqoI013+uA/AY3av9toU4xmvRqxMYYm2Znr?=
 =?us-ascii?Q?OI03MKR6b6FrYkUo4z8EADNcTxE8FmQKoTGV3c8KLXa4AwHVEtLI+dzANDfP?=
 =?us-ascii?Q?JiGht4Kzn1hp711hzsz9W5ESEjm0FMxhCWOkiXLohrLrfPcYKF2mAIZVBIt6?=
 =?us-ascii?Q?J1EvnAigKdMXXO8keWwJGQp/tPIJnV8/n83RAXqNDm1W/3jX3gGBDKwtpH3d?=
 =?us-ascii?Q?NxCi48pKatRPOKr7wMH0qgWBnpmdI7PXov82SI5e34nGcNhgIqAlTdmW643V?=
 =?us-ascii?Q?+Zr+SBQ4e3TkrX+1KjhwjuWbf5bz957nmXtt3uXHV6fQkF6KHCVpn5rEcb8x?=
 =?us-ascii?Q?5e+jLz+mACRF65vgo7upAgHVpORi8HjymvS2ppa1vgOUuqcJ9uO2Ovc4pnuR?=
 =?us-ascii?Q?mAglNX7RCTGLehM6Fdn8zq5K01GaQ5wRmZ/XaoLAN8agkkg0h+SMGzrdny1G?=
 =?us-ascii?Q?NlqMDQq68Tz3wj4/rItJ/lxBK7kOEkcmeX7+RJLric/d5wi9ccjlGyru30Wu?=
 =?us-ascii?Q?c7Ou51B0KNflubbGWPgdHKkKIc5TUUV49Nwfs6Q8Wu8o7pDwIxw8dyKpshJA?=
 =?us-ascii?Q?aH3Xd964r+vm8ifaXrVTvztbtGxBIQHyflKWgkppqCUY3hz9wxwafdkaS3Pz?=
 =?us-ascii?Q?w891Le1P8+S0e9I4pCWjLxGVVGpd82/1WjeOmDm2EksKWp1flg7KdfQ7CUOk?=
 =?us-ascii?Q?wAHkzux/9Jf6WwdC41ehTtG6M/nEWKlGvFiKXP+NfeY0tMqOTVgw6vVSF71D?=
 =?us-ascii?Q?kg2KJDGz4HUyQ8aL4RxkV0XmWPg5ME6HZcBMvWmc3mzoeLnA2h4gLxF0uBPx?=
 =?us-ascii?Q?C4jh+FHxCY/p2BQgD/GMBk5uQposozfetCtILeO1CV191gOw36wQGkrYr9Cz?=
 =?us-ascii?Q?TwEtSVH8JW15kCUhwfgtPXekD+fqFCYvsg6ZdhR6uCGeClkVPlUIt3gO00Pa?=
 =?us-ascii?Q?9xdpQAxJCKAgfV5tu5xmVyy4Wmlkr0oD7qjfnS++Pfej1G4bQ5PRv1pRS1V9?=
 =?us-ascii?Q?TXwE3QVe+9K+EN8y+/HVTFjLSrffS/5l2CNnup1fXLHzMwXKbCQ4IEswwgSt?=
 =?us-ascii?Q?QY3LNdyV/vPU9hQFko21RSjuszcnGmViinieHbcMN+TU/ql9gWm468dyV1tU?=
 =?us-ascii?Q?3jVTgRBT+kNz3iDv5Mf38RREDpardXOGMZTmuOC8Og8j95z25d6pQBcN6jTp?=
 =?us-ascii?Q?i6vY0K0eLYk1pyxds2HVP3+rxGHoxVsERQbO+0vjG5dxSN2ywOfCaqoX8l+v?=
 =?us-ascii?Q?j0+06uKaRWC6V0Amymr4QJJi/bMukdAAJUmjs6ezNnf2oYywRz9yF10rY/u5?=
 =?us-ascii?Q?xNeV5z7jJw8+6eMihBX6sjCEn0EpS4a9y/74pKN3RYQeZ4DTx85rm5YTNcYK?=
 =?us-ascii?Q?ZLSP2I51alhRKeh9XbKpwcyLIkcTe09wN88yjLYEAojaJaXBlfKJSnMBFi6p?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2637b56-9930-42d6-a201-08dc32a4f9d0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 06:18:52.7921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9S45+jmqLN8ZFHVIO7X+71dnHQEZoYK/ocHt+mCCa411PcgCCp2MvT9s3YJMdeLoJoaXC9DNJxG0KocQJ1Rz4CcjmzZCUks8nUIqOnE4fgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8537
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Change the EINJ module to install a platform device/driver on module
> init and move the module init() and exit() functions to driver probe and
> remove. This change allows the EINJ module to load regardless of whether
> setting up EINJ succeeds, which allows dependent modules to still load
> (i.e. the CXL core).
> 
> Since EINJ may no longer be initialized when the module loads, any
> functions that are called from dependent/external modules should check
> the einj_initialized variable before calling any EINJ functions.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/acpi/apei/einj.c | 46 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 89fb9331c611..6ea323b9d8ef 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -21,6 +21,7 @@
>  #include <linux/nmi.h>
>  #include <linux/delay.h>
>  #include <linux/mm.h>
> +#include <linux/platform_device.h>
>  #include <asm/unaligned.h>
>  
>  #include "apei-internal.h"
> @@ -137,6 +138,11 @@ static struct apei_exec_ins_type einj_ins_type[] = {
>   */
>  static DEFINE_MUTEX(einj_mutex);
>  
> +/*
> + * Exported APIs use this flag to exit early if einj_probe() failed.
> + */
> +static bool einj_initialized __ro_after_init;
> +
>  static void *einj_param;
>  
>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
> @@ -703,7 +709,7 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
>  	return 0;
>  }
>  
> -static int __init einj_init(void)
> +static int __init einj_probe(struct platform_device *pdev)
>  {
>  	int rc;
>  	acpi_status status;
> @@ -717,7 +723,7 @@ static int __init einj_init(void)
>  	status = acpi_get_table(ACPI_SIG_EINJ, 0,
>  				(struct acpi_table_header **)&einj_tab);
>  	if (status == AE_NOT_FOUND) {
> -		pr_warn("EINJ table not found.\n");
> +		pr_info("EINJ table not found.\n");

Per comment on cover letter this should be pr_debug() to hide it given
that this module is no longer only loaded manually.

>  		return -ENODEV;
>  	} else if (ACPI_FAILURE(status)) {
>  		pr_err("Failed to get EINJ table: %s\n",
> @@ -805,7 +811,7 @@ static int __init einj_init(void)
>  	return rc;
>  }
>  
> -static void __exit einj_exit(void)
> +static void __exit einj_remove(struct platform_device *pdev)
>  {
>  	struct apei_exec_context ctx;
>  
> @@ -826,6 +832,40 @@ static void __exit einj_exit(void)
>  	acpi_put_table((struct acpi_table_header *)einj_tab);
>  }
>  
> +static struct platform_device *einj_dev;
> +struct platform_driver einj_driver = {

This can be static.

> +	.remove_new = einj_remove,
> +	.driver = {
> +		.name = "acpi-einj",
> +	},
> +};
> +
> +static int __init einj_init(void)
> +{
> +	struct platform_device_info einj_dev_info = {
> +		.name = "acpi-einj",
> +		.id = -1,
> +	};
> +	int rc;
> +
> +	einj_dev = platform_device_register_full(&einj_dev_info);
> +	if (IS_ERR_OR_NULL(einj_dev))

Given that platform_device_register_full() never returns NULL, this
should be IS_ERR().

> +		return PTR_ERR(einj_dev);
> +
> +	rc = platform_driver_probe(&einj_driver, einj_probe);
> +	einj_initialized = rc == 0;
> +
> +	return 0;
> +}
> +
> +static void __exit einj_exit(void)
> +{
> +	if (einj_initialized)
> +		platform_driver_unregister(&einj_driver);
> +
> +	platform_device_del(einj_dev);
> +}
> +
>  module_init(einj_init);
>  module_exit(einj_exit);
>  
> -- 
> 2.34.1
> 



