Return-Path: <linux-acpi+bounces-4306-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6300C87A2C9
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 06:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798401C21011
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 05:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB38712E5E;
	Wed, 13 Mar 2024 05:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTZfRGpb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBE712E4E;
	Wed, 13 Mar 2024 05:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710309283; cv=fail; b=awG/gnZ3rYnNhiBs0hULQQOHhiQmyWQ5eiP/nEgSPshHpEo/kyTPsRWo46wB/bzoVpyY0xU0fRDD3YFF8F83AWfx5uMjm2DG2TSC7pRVpvS1Os+RXDcJZrsEXWmI+oysaR5UgHvGCc3ywgDxX2UF93yZi3GJ/lV6uIv1Ny8yYP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710309283; c=relaxed/simple;
	bh=D2lBy3bq68eP32gFKZhEoQ/E0JOCYmz7gUCq7yJ1sWQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HvGdQhMW/FoRgdCKflyoUf8wgR0SV6tank10RHTl/M95UfxtRjfcvBHxp8t7s3ZUl2VMx25NvPNd+HsS6IRDM4WVv+p5JOrYFH5MvnWfUVwjVoIPJScab9OYQMOgWkqEAQtjTfGlAh9OdK1oUw7Xl4sUvn4+LEVKJlayeTOfR5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTZfRGpb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710309282; x=1741845282;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D2lBy3bq68eP32gFKZhEoQ/E0JOCYmz7gUCq7yJ1sWQ=;
  b=XTZfRGpbu8mkEaRODg38rMOlAkU+B5sJdHsnfyVLcKzA3/eizVLduAUt
   CRHO1DYkgke5DHL8EIYfOPieMPLu3zj4SSNPLmGyBfDxkoJjzNyD4mAk4
   illPjtPJn/wcEKCXIDFHweU2RvlSlqBqhAl3g2gTZ6yCXRNymUqx3lQ2O
   jtsO17SW/Yc7Wo08HsUcyiBYXVtXCX5fOr6CCb6ZMZNzmAt9/g3BGSkcH
   8ogYPuaV912AqKMt+55wbr/3AOT3RtETKqXWQnPJ4V2cUuNUjuk+lbY7A
   v/KZFh1BzwYvdIPSkRNuvv4rmzzTJjPVIQaJczWXg7854nqwqrUIGT5kK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5223493"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5223493"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 22:54:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16277962"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 22:54:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 22:54:29 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 22:54:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 22:54:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 22:54:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cay8zdEKVGe/YxlnQPIw2orEFhULDKponWptxFY21UNyUuRJ7xQ7f/QKOq7FrXsmaVvl8TEBdFZsNsZkpIapNpJzM8oYzqyfuDsrEPOwblVs+xEBU2nOI5TwltsKP5Q0I6mRB36z7OdzKUjhI5r+OyNHZV5+8CoblSidvrvhpy3vpJEfatlvPCaLmS6qQNCkPDFT7RQvze+Mbbb4M/Yr4n1+fWvDXzrtWlOa1Lgti/TVrI3oTNcT3fDrN55MwC6bfaSZNmp1S/Z44Miw4B7B9Iw81/UbIcAqrfwVqJjgzfdIYHCNGjdOWhRD76zcTOTVhH8yTMHire02gZXbowe2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3VKmvSh9N8isd+n1MNbWueg37X6o8GzzKo/XLEP44g=;
 b=aR2DIZgdLX6OhYRzC5/3ioIHTfueykVVML+XHlYFzVDXxSwK+GY1NmBEOoAKB19kywub2XWSrJeoiwsZYRdFSIuRxhD3hvNucYnLr2wqK6A3FUSJp9eGvhkhTeWKyz3cXUMSy7qb22wxbpgViIH/7TBv6taAfocGgNRTzldPkjKeSU9x40sX4uAJkH92zocdkj+fxAafgC+nQxkbo69HEA81fuby5P7L20Uhg5kryn9CJRaPdGNHERGntEtL9IMYpyv0WTy59ZFLt9Gdo6CQDt9UwnAPXyslq3cLESUZwkMEtMPvgu6OqtcEtrazNYRnoNufLyu73v94hn313FpBbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 05:54:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Wed, 13 Mar 2024
 05:54:26 +0000
Date: Tue, 12 Mar 2024 22:54:23 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v15 2/4] EINJ: Add CXL error type support
Message-ID: <65f13f8f15389_a9b42944a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240311142508.31717-1-Benjamin.Cheatham@amd.com>
 <20240311142508.31717-3-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240311142508.31717-3-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:303:dc::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4839:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8d3d23-3012-4f84-d9f5-08dc43220a34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZ3I5AXoxaeWOth6Vm6/gMlqMUmKU/+mHbQ1Iu5dYjgB/jtbXgvkq4CqMhXJKijXz44eTmxNMplmuFBcc1Nu/uOvICOnZRNhtL9TY8sahFAc6TmH71fzSIqdWk9OGc+4F6afJlToHL0szdMt+psBjhyyPU9ikgapUwEL6gxFh1YsciTmTqM9StpnWF5NQmd2mtDSouT7D6qInkErhWzLGykVnew/SPR4eWlB+fwaD/pqVWFeOA3l1itUklhmYJNdkLrKVRIkLYPs5RafiuCsI3PpvmYHkpJ9loeZ5LycZZ6u0x/83/5M2A4Rbd+sqrdTNCQWdgMKGZ7IcPnkL08FLg+sIvwA8C8J2K/g8LwX5ErPZhOXiGkQK3u8NUsgC92CTy9L89v3sy/p7bs/W1G7BmL4OU3G1QSuxXmAyDD2i5Ry68EaJTedJFLzdkij4m1ik62bX344AHiDurXjmnYsi7es3ErkrOGf+HORpojvRC4jm8793x+ho6mFBDrKrxNxfDzCjRpmsgntCUCYZXcmF+/oe+hxP1/b8a+qGlgWUQk9hHWrd/Myfz8djAaD6JsyhKnjmnJWiD06qTxfPRJsHgV2xSEiXmKs712k4ABUvbA5fiC7xjw6Tr4fJbEhwydtAZTktXfTY5VSFLnyrztbGYeDZeSQfR9wumsaeEtxpUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?szZJh7B183J8EHfayH+scey8eGYfjaeWhJGCezE0LuR2EQqKDRtz/1iS/APq?=
 =?us-ascii?Q?PtCEXdLbOznGOfJdrdeDC9RzHGJO1qBnNpTrYDibyteqb2KD77mgwklz7dd0?=
 =?us-ascii?Q?s6evNY7soFE6fAqwr6SE/TV9zUbJmlnpc+XK4DndOmpHZzQiUxokeDv4gIy/?=
 =?us-ascii?Q?3sokPrygUXcHZsbiCNHWxPOgpMeCVUOWUYF8VQ2texPd9pxrf3a51thqf7dh?=
 =?us-ascii?Q?2E7+FYhwkb7LkiYVew7E/XoDrIrBVAH5UinJIO1IoVnSYkvQ8GrmFgEw3hbj?=
 =?us-ascii?Q?5QPMYrZ0KzzuOjfYkJh962efdiFNEi2bGBlRDH2rAKA5N35dixPb5q2JhV2a?=
 =?us-ascii?Q?c2AaPymSAivkaO+ekB7gIUf1E2Aw/9O0vEOavvByQSmO8deqwaRp6L/5CFQh?=
 =?us-ascii?Q?4xcb83HI/j7B3C1jWk5YrGSP3tk63/j3RU0nTvkCEvBZEfxTjkuQH2LWw8YI?=
 =?us-ascii?Q?JLyUMyR/AoA+pKD0K17eDsjJ9OPmYOlehKfASN2bNHfTX3drrN2jkjrhup/l?=
 =?us-ascii?Q?c7azoKfh+MOxjy5Bh2m6OHrGhDzZUl4W4souSin0a0JseOkmUNGT1UlsSTat?=
 =?us-ascii?Q?z8K9ZsNpb7hrT7+AuysPs3Cw/PyheapuNai9qoPm3aCNJ2f7WcU1BBG30/eD?=
 =?us-ascii?Q?n2KKgthJ/oo3fvukZe0xEw7rlCErDC4kk9T/JlHpJqhKQXybcfIktMUs4CyI?=
 =?us-ascii?Q?Ob8NaaWpBGWgRdZhiUWQD1susYJxYlk4+f7m16iDeJJsGseKigAT7yoDgzEb?=
 =?us-ascii?Q?5sMUtAkGweWwGwGoMyDrfcanN6xxOY7DEMYOncF54Kvgbi+xy4z6KW65387x?=
 =?us-ascii?Q?7sgAfzvMkCNXVkZYTfm7c5XHz66uI0qS2KZYRdA6CyyYcXGb0vE7kTKJftKr?=
 =?us-ascii?Q?cLxJATqAzbj0kbYyMk3u6+x2/ZC4L5t3qawrD2IcpVeOU03NFR3lCnGkiF1B?=
 =?us-ascii?Q?oTAjhGVYE6/digAz5mEDp8xJ+okLS+hb28aDQfBZ/8S7li3r3iLGcoYSf9oW?=
 =?us-ascii?Q?bBOqIrhGtMU5nrFJev5LJQomm7p1xHMVqJoGOxDfbkco6PJlbcpZZy6eTYT/?=
 =?us-ascii?Q?PUHO7MqdwVXF/LvDswx2ltseW0RnX7pockwh0eJFiTfoFrX+I/wJK+actPlN?=
 =?us-ascii?Q?XMouVGUljDg8qQ1+hO/MOXAJQHvzFaEq3Ux2sOCsZKtfnGvGUJYajvOCYFO6?=
 =?us-ascii?Q?kZ0iFD40t5pOesezgo6rQdTW+e/c4PfZLTgZBjYKdKFfThjgJmH+oTDR33rd?=
 =?us-ascii?Q?b8nIbL5gWJZdNBUtQ8kEoaHUubVC5BYXrtNdFvx996MRAnk12bFH2a3/iCmy?=
 =?us-ascii?Q?kZHmhOfqB9YjWMBNeCMnejXq4BfySAQAsRKNNvl283goG6zFYF+maGm9j/55?=
 =?us-ascii?Q?gBisYQJGSNyjXpAHWj1sElaHkKRJIL/2SZa3HE3An842VON+8QYMKfJJcycC?=
 =?us-ascii?Q?Uvpyf41HyVSSKlNfBXCsPHfHO4XVxZr7B2S2jv0PyJThzDUp/e0D+axeeDyx?=
 =?us-ascii?Q?pXSkAZ8Kjtxr1stbKjv0Y/SVY44AQnpiRP97rVCj4am3AMhiN90/hfnawtAF?=
 =?us-ascii?Q?fZ8OaMKUEwPTuldUH8m+FWu6Yqt9TsKhXzynCb7AoxxhgrHrCDoZiQwN/hDW?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8d3d23-3012-4f84-d9f5-08dc43220a34
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 05:54:26.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWnx+sQfEV+64DbeFj0lr0P9LefQbNHid0DFDndZJD2/ISj5cfQ8nvAHoSXa3YVSGIEVIW2Q5IPvgu5/eAEt/sjyCF6fKlx347c5RkIT+48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4839
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Move CXL protocol error types from einj.c (now einj-core.c) to einj-cxl.c.
> einj-cxl.c implements the necessary handling for CXL protocol error
> injection and exposes an API for the CXL core to use said functionality,
> while also allowing the EINJ module to be built without CXL support.
> Because CXL error types targeting CXL 1.0/1.1 ports require special
> handling, only allow them to be injected through the new cxl debugfs
> interface (next commit) and return an error when attempting to inject
> through the legacy interface.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  MAINTAINERS                               |   1 +
>  drivers/acpi/apei/Kconfig                 |  12 +++
>  drivers/acpi/apei/Makefile                |   2 +
>  drivers/acpi/apei/apei-internal.h         |  18 ++++
>  drivers/acpi/apei/{einj.c => einj-core.c} |  77 ++++++++++----
>  drivers/acpi/apei/einj-cxl.c              | 116 ++++++++++++++++++++++
>  include/linux/einj-cxl.h                  |  44 ++++++++
>  7 files changed, 252 insertions(+), 18 deletions(-)
>  rename drivers/acpi/apei/{einj.c => einj-core.c} (93%)
>  create mode 100644 drivers/acpi/apei/einj-cxl.c
>  create mode 100644 include/linux/einj-cxl.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ecaaec6a6bf..90cf8403dd17 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5289,6 +5289,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	drivers/cxl/
> +F:	include/linux/cxl-einj.h
>  F:	include/linux/cxl-event.h
>  F:	include/uapi/linux/cxl_mem.h
>  F:	tools/testing/cxl/
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index 6b18f8bc7be3..f01afa2805be 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -60,6 +60,18 @@ config ACPI_APEI_EINJ
>  	  mainly used for debugging and testing the other parts of
>  	  APEI and some other RAS features.
>  
> +config ACPI_APEI_EINJ_CXL
> +	bool "CXL Error INJection Support"
> +	default ACPI_APEI_EINJ
> +	depends on ACPI_APEI_EINJ && CXL_BUS <= ACPI_APEI_EINJ
> +	help
> +	  Support for CXL protocol Error INJection through debugfs/cxl.
> +	  Availability and which errors are supported is dependent on
> +	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
> +	  EINJ documentation for more information.
> +
> +	  If unsure say 'n'
> +
>  config ACPI_APEI_ERST_DEBUG
>  	tristate "APEI Error Record Serialization Table (ERST) Debug Support"
>  	depends on ACPI_APEI
> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
> index 4dfac2128737..2c474e6477e1 100644
> --- a/drivers/acpi/apei/Makefile
> +++ b/drivers/acpi/apei/Makefile
> @@ -2,6 +2,8 @@
>  obj-$(CONFIG_ACPI_APEI)		+= apei.o
>  obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
>  obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
> +einj-y				:= einj-core.o
> +einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
>  obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
>  
>  apei-y := apei-base.o hest.o erst.o bert.o
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
> index 67c2c3b959e1..cd2766c69d78 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -130,4 +130,22 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>  }
>  
>  int apei_osc_setup(void);
> +
> +int einj_get_available_error_type(u32 *type);
> +int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
> +		      u64 param4);
> +int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> +			      u64 param3, u64 param4);
> +bool einj_is_cxl_error_type(u64 type);
> +int einj_validate_error_type(u64 type);
> +
> +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
> +#endif
> +
>  #endif
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj-core.c
> similarity index 93%
> rename from drivers/acpi/apei/einj.c
> rename to drivers/acpi/apei/einj-core.c
> index 937c69844dac..9affbe807ded 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -37,6 +37,12 @@
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>  				ACPI_EINJ_MEMORY_FATAL)
> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
> +				ACPI_EINJ_CXL_CACHE_FATAL | \
> +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
> +				ACPI_EINJ_CXL_MEM_FATAL)
>  
>  /*
>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
> @@ -141,7 +147,7 @@ static DEFINE_MUTEX(einj_mutex);
>  /*
>   * Exported APIs use this flag to exit early if einj_probe() failed.
>   */
> -static bool einj_initialized __ro_after_init;
> +bool einj_initialized __ro_after_init;
>  
>  static void *einj_param;
>  
> @@ -166,7 +172,7 @@ static int __einj_get_available_error_type(u32 *type)
>  }
>  
>  /* Get error injection capabilities of the platform */
> -static int einj_get_available_error_type(u32 *type)
> +int einj_get_available_error_type(u32 *type)
>  {
>  	int rc;
>  
> @@ -536,8 +542,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  }
>  
>  /* Inject the specified hardware error */
> -static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> -			     u64 param3, u64 param4)
> +int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
> +		      u64 param4)
>  {
>  	int rc;
>  	u64 base_addr, size;
> @@ -560,8 +566,18 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	if (type & ACPI5_VENDOR_BIT) {
>  		if (vendor_flags != SETWA_FLAGS_MEM)
>  			goto inject;
> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>  		goto inject;
> +	}
> +
> +	/*
> +	 * Injections targeting a CXL 1.0/1.1 port have to be injected
> +	 * via the einj_cxl_rch_error_inject() path as that does the proper
> +	 * validation of the given RCRB base (MMIO) address.
> +	 */
> +	if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM)) {
> +		return -EINVAL;
> +	}
>  
>  	/*
>  	 * Disallow crazy address masks that give BIOS leeway to pick
> @@ -593,6 +609,21 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	return rc;
>  }
>  
> +int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> +			      u64 param3, u64 param4)
> +{
> +	int rc;
> +
> +	if (!(einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM)))
> +		return -EINVAL;
> +
> +	mutex_lock(&einj_mutex);
> +	rc = __einj_error_inject(type, flags, param1, param2, param3, param4);
> +	mutex_unlock(&einj_mutex);
> +
> +	return rc;
> +}
> +
>  static u32 error_type;
>  static u32 error_flags;
>  static u64 error_param1;
> @@ -613,12 +644,6 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>  	{ BIT(9), "Platform Correctable" },
>  	{ BIT(10), "Platform Uncorrectable non-fatal" },
>  	{ BIT(11), "Platform Uncorrectable fatal"},
> -	{ BIT(12), "CXL.cache Protocol Correctable" },
> -	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
> -	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
> -	{ BIT(15), "CXL.mem Protocol Correctable" },
> -	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
> -	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
>  	{ BIT(31), "Vendor Defined Error Types" },
>  };
>  
> @@ -647,22 +672,26 @@ static int error_type_get(void *data, u64 *val)
>  	return 0;
>  }
>  
> -static int error_type_set(void *data, u64 val)
> +bool einj_is_cxl_error_type(u64 type)
> +{
> +	return (type & CXL_ERROR_MASK) && (!(type & ACPI5_VENDOR_BIT));
> +}
> +
> +int einj_validate_error_type(u64 type)
>  {
> +	u32 tval, vendor, available_error_type = 0;
>  	int rc;
> -	u32 available_error_type = 0;
> -	u32 tval, vendor;
>  
>  	/* Only low 32 bits for error type are valid */
> -	if (val & GENMASK_ULL(63, 32))
> +	if (type & GENMASK_ULL(63, 32))
>  		return -EINVAL;
>  
>  	/*
>  	 * Vendor defined types have 0x80000000 bit set, and
>  	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
>  	 */
> -	vendor = val & ACPI5_VENDOR_BIT;
> -	tval = val & 0x7fffffff;
> +	vendor = type & ACPI5_VENDOR_BIT;
> +	tval = type & GENMASK(30, 0);
>  
>  	/* Only one error type can be specified */
>  	if (tval & (tval - 1))
> @@ -671,9 +700,21 @@ static int error_type_set(void *data, u64 val)
>  		rc = einj_get_available_error_type(&available_error_type);
>  		if (rc)
>  			return rc;
> -		if (!(val & available_error_type))
> +		if (!(type & available_error_type))
>  			return -EINVAL;
>  	}
> +
> +	return 0;
> +}
> +
> +static int error_type_set(void *data, u64 val)
> +{
> +	int rc;
> +
> +	rc = einj_validate_error_type(val);
> +	if (rc)
> +		return rc;
> +
>  	error_type = val;
>  
>  	return 0;
> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
> new file mode 100644
> index 000000000000..bde7e20c7fbb
> --- /dev/null
> +++ b/drivers/acpi/apei/einj-cxl.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * CXL Error INJection support. Used by CXL core to inject
> + * protocol errors into CXL ports.
> + *
> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> + *
> + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
> + */
> +#include <linux/einj-cxl.h>
> +#include <linux/seq_file.h>
> +#include <linux/pci.h>
> +
> +#include "apei-internal.h"
> +
> +/* Defined in einj-core.c */
> +extern bool einj_initialized;
> +
> +static struct { u32 mask; const char *str; } const einj_cxl_error_type_string[] = {
> +	{ ACPI_EINJ_CXL_CACHE_CORRECTABLE, "CXL.cache Protocol Correctable" },
> +	{ ACPI_EINJ_CXL_CACHE_UNCORRECTABLE, "CXL.cache Protocol Uncorrectable non-fatal" },
> +	{ ACPI_EINJ_CXL_CACHE_FATAL, "CXL.cache Protocol Uncorrectable fatal" },
> +	{ ACPI_EINJ_CXL_MEM_CORRECTABLE, "CXL.mem Protocol Correctable" },
> +	{ ACPI_EINJ_CXL_MEM_UNCORRECTABLE, "CXL.mem Protocol Uncorrectable non-fatal" },
> +	{ ACPI_EINJ_CXL_MEM_FATAL, "CXL.mem Protocol Uncorrectable fatal" },
> +};
> +
> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
> +{
> +	int cxl_err, rc;
> +	u32 available_error_type = 0;
> +
> +	if (!einj_initialized)
> +		return -ENXIO;

One of the unnecessary einj_initialized checks leaked through...
removed it on applying.

