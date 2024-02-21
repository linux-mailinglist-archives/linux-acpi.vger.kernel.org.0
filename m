Return-Path: <linux-acpi+bounces-3788-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1991A85E4CA
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 18:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48282869B8
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 17:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CAF85277;
	Wed, 21 Feb 2024 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7km9JpC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207CF84FCF;
	Wed, 21 Feb 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537427; cv=fail; b=KQmGHrB75I3moTt5eK1MvYY0/pGDrGSLnm4l9oLg2Di0NpbD9KMFTPtNcnW//7xyx4Y9u8xEohP9Xm1UfObz+4CYZIeIWukpXp+ZI1BYYhCIDzXqkAKrLiuxK/gxy3NWM97XEpQxf7dB4Zbma2QqA8Aw/L+9+zEBbVvEBQ0PKnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537427; c=relaxed/simple;
	bh=CDrgnrajDMLIjIm9LGfCLVuzTzMBlh5fWS1KVzoPR7Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tV5s0msy1TAeDfmL1FT+hW78zsAVv2eIgujiwfgjfMdPPcPGcISmvZ+Yqz9A+vK26kexm4+TgN7MhU1ifqSPcEc3GRlzq+JSJ5AIPU+SxccOr9iGL5Cu5P2LeviVNZs1yECYNpPu01mSxg3XvbdQeHV/zJFgZ6ND3p7TCoH3Zx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7km9JpC; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708537425; x=1740073425;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CDrgnrajDMLIjIm9LGfCLVuzTzMBlh5fWS1KVzoPR7Q=;
  b=Q7km9JpCPwnmd7lRg3tvdwVKcvgGAk7eY2DHLxAFXtu9zWom7ODlQ+fx
   QzHrxsjyQltvXyMdq82B16cq1LIHmg/xSUDADldB/4axZlmA7Se3ftwx4
   CtxTkQdZlAA91D79PajWR0/rItjj93kL8xwXWQZEqWAHRSSP1Izj88XUX
   sSBGGQyysBRvwvmtWyc28Aoi42MTNVoTE+/VieTl7tGMxjUgZ5ycSyEi6
   gsS5hQD4Fn41QovbxGT1F5y/Cth8sonjNz0feRALQrmg05L6yJk+dUl4K
   1aCWPusQukYe+J/Id9+rk2L9FVqJAy03d5V0A3gOrWTPfUEtubiChD3QI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="20258127"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="20258127"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 09:43:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5205884"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 09:43:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 09:43:43 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 09:43:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 09:43:42 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 09:43:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhUGUUMEdHAnqKmeCvE9kiiz2EiwXnPten40kKxxG8Rav8twLD/5GeqGm5ndDN1JK6SVLzSGWs11Dog9RM9kSbJTII+Gn9T2KC1ICUsx8YD0yoPxXtREf32eM5s4tTLeDN9v3nzgCq4TY4ydh5Ok9L9HN8OAeoxLn4+2zGHM1i7j12VMwn1BU8U/zKpcXmY55p68IqgG+o7FGcryGwqUrODPAMNiQDeMUExyQuFVe6C3OD+FWR3kz04oVH1782Vt/vz//u1mAlDDuGwLKCd3OMT5zUtWGHLrpqfbYOcObh46lWm4Cjub6YO2EsHRr01T11bbZUAvSYOmTcX9H7Tb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzK7X5p9Bkk3LNOtZaR8J9KTt2uKDrvLHZr8PbMsZ54=;
 b=TB91ULrqNLn/2PH/lPKE2Gh0fOEN51S+QtCm0mWbYhEEWA2xzhRpvc/fHKHDW+CA9tVOJuyh28OS8hcLKgZw3S4IIk2JjkY/NGv1TS1e8SehBhP44fLIagwrgoncGur0RtgFZSDJz+rSuy1LGEGrzvJwue9HbCLTM+fUMWGjfW57jz8RSuwNSfXfscoBUBEeF6yFJS4Cu+sS2V5D3g0jJXgCpg7TVQCoBmn40S5dxzVjs1Qn43fzc9HSbHjvuZT3o6yW2spnI0wqxNSchWt4QVp53/2ez9dzeh97235nrDLSw0Agx40KUKibjDDoEcWR8QOI6XD99Oo5F80PhfF92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7501.namprd11.prod.outlook.com (2603:10b6:a03:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 17:43:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 17:43:39 +0000
Date: Wed, 21 Feb 2024 09:43:36 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: RE: [PATCH v13 2/4] EINJ: Add CXL error type support
Message-ID: <65d63647ecdb1_5e9bf294d6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
 <20240220221146.399209-3-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240220221146.399209-3-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:303:b5::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 656f95d2-cc29-4cc5-bf22-08dc3304a2f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9TrGx7+Vg5KuOMAd6gpi8jRO6EPSwGawpoFC92+r5ljLXJ4DMTcqc6f5TXblVmVRMj3i9cO15Y/dbwYOi0shhRkOYn8+VVgm3aaFBKFBDcvL2FmuJ4h6sEVhN6YXd9ZNNgkbkOC4UvfgMABYdfyJ8JYuVMmszoycJds5rsXD/DG1mrA1/E/3a9XeZmhc+GvsFAN2gsr/X4I0wczqyVqg0gK/+6QYhxDhsYHtcqIG49gkFW/G8SeX4oiW5coyN0R3eSPm/5UySLpuIj0XwhQ34AuXK4IUYsDBryUHYg3CztBktxWlMxfB/nvgOlassgk1iBS2OIMrwxBQXIPffHRZa/Y5/A99s+GoMnGs6ZvGqOH5ZIm0mPVQkYYWwhTyLp2wQY3sLkJZTwkNa1NNip+uK25r9/kbU13Ypq6nTxDBz2aC+YWtR460DCF6G4aEZ1lgCPCb0qj/bhgArrhHo3Bf2pihDIazFpVKayh3nhi19qt4iSY7iVmhfyq+aGR2g6jYHGJ1AN5bLMKD1Zqg+Tu4LIGsZlZ+U7MQpNzm+XGafY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nz4yCDKDNk2415Q3FMTi4mC3+q43PoqlMbmbltENzZnmSZp36jIgpqLr6EtD?=
 =?us-ascii?Q?BD6PsmO/uNggrBQoH6uJL34k42iEhtu9NCmmW+3kOtPLvNWsDS1KglpShEOc?=
 =?us-ascii?Q?i+HO8pfFkNzBFWX4Ibgv35FDljPMJTI6Q/DoSRVDTi+JxUKQpGCJervcwTe5?=
 =?us-ascii?Q?KZ7Uo4Ken9758jhPy8rUOUzL21/XVQeFlMMFUAs21ns7XTZHi7a0qEbWe4qi?=
 =?us-ascii?Q?4yrRRoWGiiPtKhON+Q3SklauT8vxHWOPfatdeVwvDdbe9UP1Ie0yYkStE/IA?=
 =?us-ascii?Q?xRTAl1M9Kwze9Bd2LuWg9U/nXEDBsuG4P64NNCnvY0aCXaPLcKhBzdrZTBrB?=
 =?us-ascii?Q?D4eO+Eik634qSRl2u0pvZc3+PkuMjX/YvvyZKNJ0MyHQ4XSRQAZYkSjQbhn3?=
 =?us-ascii?Q?4nXT2PayVrg5EdtA0KHQMfzKHHMI2pBPDlJD30mgL320RGm8GKLE7JvTjPLO?=
 =?us-ascii?Q?+h1hdhMl++avOwvwtcDIelM1kj6CnsTWcONm5XFr1gLAuQIrfuWn1z839khR?=
 =?us-ascii?Q?E5jZrwP9M6PfKpI0hFwBNTxzxqA+UHFdkM0jkRXPo9rxXIuv94q4/GlkcN8B?=
 =?us-ascii?Q?7cJfcwDeG4cWEdFFGcW4P13upEbDqJVyULrM2RwJZrvQcKZVkQXezt8U0B4O?=
 =?us-ascii?Q?nxKAJdoWCjHMw7eqiBdMEvSsGnXFM1BJWa36lmfnbqbcQICN5X0V7KeGqpf5?=
 =?us-ascii?Q?s7z33RxXCQL81e6QQjnYUc8osSWacxV7wquGlH0RKJi1KhdTBbJ96V0T7yvG?=
 =?us-ascii?Q?eFCZwE0QImi9A2ewNH+1YnseaK7P5uYBWjBRGu+lXMRSgSFGNWkXvWriK5+0?=
 =?us-ascii?Q?bjlymnYdgAEglmS+mUFcWCH0a8WdovzywTmQlLNMlcyfVm7mo6t+0VAzoV+9?=
 =?us-ascii?Q?yc8O8EPX7SNiYImodhXsAms8rmNjHvO+q2QrDNRK1baDRz2Zp/oPuTZLlAkb?=
 =?us-ascii?Q?hoKT3Duqsqf1l9u5BJ1ejBM6VxVDsqX6qUa/RXsOrHIr5y5pxmTlMrBvytib?=
 =?us-ascii?Q?cn+EIAxCFVjC4CWBzHUkHWEi+QGo/aqwyEAlKPnXgh/QwvaVUFQsN8AVSUV2?=
 =?us-ascii?Q?Ipn0/9TG305IPrACFXcz3eQwAlQXFuHfYGjXNQMgzjiu5ytNkqqPkgDpaIuy?=
 =?us-ascii?Q?8gxzaOxzedTP3UMws8xkwTaQPi9Lm9DRGM8FVCnpzjncbZMsonAvfjLZ/zd/?=
 =?us-ascii?Q?1AifCA67J954/8G/0D8f7UcE5DEXzFBX05WHrRfBsAkAFvVIeZw1L/N2UL0q?=
 =?us-ascii?Q?LSAyLCkcBMBNIvPLW98x0XgULVKUJQqPjNGtXwTC0yqbwy0Rc0JIsJ2MbnfT?=
 =?us-ascii?Q?z1dPGki4s0fj60Kq4ba4Mjfve31zpAnKyEDMbn8RNue1citTHGZPTUjylL6G?=
 =?us-ascii?Q?tjNYFxApH3wepqC5PZFCN+TM0WXUQhlfqzot1m75ghhgmIL05bBGcgcPBMYP?=
 =?us-ascii?Q?TXVFrRJepdLrEsqXriF7FPXy9dCzPKqnCEC7T70ppRR6LQYozx0NoYtOY1Tq?=
 =?us-ascii?Q?Vms9x0LOBD2LKWF/XIViuOPuNdA/z+gvtT3UWC80fGAq5qFa+I9VGT7CInGd?=
 =?us-ascii?Q?7yP1HFYp8Qsv0CuETWbph0qq1jCZunuJceo/99TZRT530SJF6Snw+Qzm7h2m?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 656f95d2-cc29-4cc5-bf22-08dc3304a2f9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:43:38.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmMc663UCRFwQAt7GSjzK6K/pfi+zqubw0S86EZMUo2V6sfONgCDMhaZ62zXX+J/p2N1Cx60Y/h34/wAh6c2XQiEllqxQY9v2gtEGDCyMGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7501
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Remove CXL protocol error types from the EINJ module and move them to
> a new einj_cxl module. The einj_cxl module implements the necessary
> handling for CXL protocol error injection and exposes an API for the
> CXL core to use said functionality. Because the CXL error types
> require special handling, only allow them to be injected through the
> einj_cxl module and return an error when attempting to inject through
> "regular" EINJ.

So Robustness Principle says be conservative in what you send and
liberal in what you accept. So cleaning up the reporting of CXL
capabilities over to the new interface is consistent with that
principle, but not removing the ability to inject via the legacy
interface. Especially since that has been the status quo for a few
kernel cycles is there a good reason to actively prevent usage of that
path?

> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  MAINTAINERS                       |   1 +
>  drivers/acpi/apei/Kconfig         |  12 +++
>  drivers/acpi/apei/Makefile        |   1 +
>  drivers/acpi/apei/apei-internal.h |  17 +++++
>  drivers/acpi/apei/einj-cxl.c      | 121 ++++++++++++++++++++++++++++++
>  drivers/acpi/apei/einj.c          |  81 ++++++++++++++------
>  include/linux/einj-cxl.h          |  40 ++++++++++
>  7 files changed, 249 insertions(+), 24 deletions(-)
>  create mode 100644 drivers/acpi/apei/einj-cxl.c
>  create mode 100644 include/linux/einj-cxl.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 73d898383e51..51f9a0da57d7 100644
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
> index 6b18f8bc7be3..040a9b2de235 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -60,6 +60,18 @@ config ACPI_APEI_EINJ
>  	  mainly used for debugging and testing the other parts of
>  	  APEI and some other RAS features.
>  
> +config ACPI_APEI_EINJ_CXL
> +	tristate "CXL Error INJection Support"

This should still be a boolean because it is add-on functionality to the
cxl_core.ko module which has its own tristate configuration.

> +	default ACPI_APEI_EINJ
> +	depends on ACPI_APEI_EINJ

The dependency still needs to be:

    depends on ACPI_APEI_EINJ && CXL_BUS >= ACPI_APEI_EINJ

...because CXL_BUS can not tolerate being built-in when ACPI_APEI_EINJ
is not.

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
> index 4dfac2128737..c18e96d342b2 100644
> --- a/drivers/acpi/apei/Makefile
> +++ b/drivers/acpi/apei/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_ACPI_APEI)		+= apei.o
>  obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
>  obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
> +obj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o

No new module needed. It only needs another compilation unit optionally
added to einj.ko. Something like this:

diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 4dfac2128737..2c474e6477e1 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -2,6 +2,8 @@
 obj-$(CONFIG_ACPI_APEI)                += apei.o
 obj-$(CONFIG_ACPI_APEI_GHES)   += ghes.o
 obj-$(CONFIG_ACPI_APEI_EINJ)   += einj.o
+einj-y                         := einj-core.o
+einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
 obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
 
 apei-y := apei-base.o hest.o erst.o bert.o
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj-core.c
similarity index 100%
rename from drivers/acpi/apei/einj.c
rename to drivers/acpi/apei/einj-core.c

>  obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
>  
>  apei-y := apei-base.o hest.o erst.o bert.o
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
> index 67c2c3b959e1..336408f4f293 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -130,4 +130,21 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>  }
>  
>  int apei_osc_setup(void);
> +
> +int einj_get_available_error_type(u32 *type);
> +int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
> +		      u64 param4);
> +bool einj_is_initialized(void);
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
> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
> new file mode 100644
> index 000000000000..607d4f6adb98
> --- /dev/null
> +++ b/drivers/acpi/apei/einj-cxl.c
> @@ -0,0 +1,121 @@
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
> +#include <linux/debugfs.h>
> +
> +#include "apei-internal.h"
> +
> +static struct { u32 mask; const char *str; } const einj_cxl_error_type_string[] = {
> +	{ BIT(12), "CXL.cache Protocol Correctable" },
> +	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
> +	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
> +	{ BIT(15), "CXL.mem Protocol Correctable" },
> +	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
> +	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
> +};
> +
> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
> +{
> +	int cxl_err, rc;
> +	u32 available_error_type = 0;
> +
> +	if (!einj_is_initialized())
> +		return -ENXIO;
> +
> +	rc = einj_get_available_error_type(&available_error_type);
> +	if (rc)
> +		return rc;
> +
> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
> +
> +		if (available_error_type & cxl_err)
> +			seq_printf(m, "0x%08x\t%s\n",
> +				   einj_cxl_error_type_string[pos].mask,
> +				   einj_cxl_error_type_string[pos].str);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
> +
> +static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
> +{
> +	struct pci_bus *pbus;
> +	struct pci_host_bridge *bridge;
> +	u64 seg = 0, bus;
> +
> +	pbus = dport_dev->bus;
> +	bridge = pci_find_host_bridge(pbus);
> +
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
> +		seg = bridge->domain_nr;
> +
> +	bus = pbus->number;
> +	*sbdf = (seg << 24) | (bus << 16) | dport_dev->devfn;
> +
> +	return 0;
> +}
> +
> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
> +{
> +	int rc;
> +
> +	if (!einj_is_initialized())
> +		return -ENXIO;
> +
> +	/* Only CXL error types can be specified */
> +	if (!einj_is_cxl_error_type(type))
> +		return -EINVAL;
> +
> +	rc = einj_validate_error_type(type);
> +	if (rc)
> +		return rc;
> +
> +	return einj_error_inject(type, 0x2, rcrb, GENMASK_ULL(63, 12), 0, 0);
> +}
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
> +
> +int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
> +{
> +	u64 param4 = 0;
> +	int rc;
> +
> +	if (!einj_is_initialized())
> +		return -ENXIO;
> +
> +	/* Only CXL error types can be specified */
> +	if (!einj_is_cxl_error_type(type))
> +		return -EINVAL;
> +
> +	rc = einj_validate_error_type(type);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_dport_get_sbdf(dport, &param4);
> +	if (rc)
> +		return rc;
> +
> +	return einj_error_inject(type, 0x4, 0, 0, 0, param4);
> +}
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
> +
> +bool einj_cxl_is_initialized(void)
> +{
> +	return einj_is_initialized();
> +}
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_is_initialized, CXL);
> +
> +MODULE_AUTHOR("Ben Cheatham");
> +MODULE_DESCRIPTION("CXL Error INJection support");
> +MODULE_LICENSE("GPL");

These go away when cxl-einj.ko is no longer its own module.

> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 6ea323b9d8ef..e76e64df97a7 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
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
> @@ -166,7 +172,7 @@ static int __einj_get_available_error_type(u32 *type)
>  }
>  
>  /* Get error injection capabilities of the platform */
> -static int einj_get_available_error_type(u32 *type)
> +int einj_get_available_error_type(u32 *type)
>  {
>  	int rc;
>  
> @@ -176,6 +182,7 @@ static int einj_get_available_error_type(u32 *type)
>  
>  	return rc;
>  }
> +EXPORT_SYMBOL_GPL(einj_get_available_error_type);

There should not be any need for new exports from the legacy einj.c.

>  
>  static int einj_timedout(u64 *t)
>  {
> @@ -536,8 +543,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
> @@ -560,8 +567,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	if (type & ACPI5_VENDOR_BIT) {
>  		if (vendor_flags != SETWA_FLAGS_MEM)
>  			goto inject;
> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>  		goto inject;
> +	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
> +		goto inject;
> +	}
>  
>  	/*
>  	 * Disallow crazy address masks that give BIOS leeway to pick
> @@ -592,6 +602,7 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  
>  	return rc;
>  }
> +EXPORT_SYMBOL_GPL(einj_error_inject);
>  
>  static u32 error_type;
>  static u32 error_flags;
> @@ -613,12 +624,6 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
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
> @@ -640,29 +645,21 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  
>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>  
> -static int error_type_get(void *data, u64 *val)
> -{
> -	*val = error_type;
> -
> -	return 0;
> -}
> -
> -static int error_type_set(void *data, u64 val)
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
> @@ -671,9 +668,39 @@ static int error_type_set(void *data, u64 val)
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
> +EXPORT_SYMBOL_GPL(einj_validate_error_type);
> +
> +bool einj_is_cxl_error_type(u64 type)
> +{
> +	return (type & CXL_ERROR_MASK) && (!(type & ACPI5_VENDOR_BIT));
> +}
> +EXPORT_SYMBOL_GPL(einj_is_cxl_error_type);
> +
> +static int error_type_get(void *data, u64 *val)
> +{
> +	*val = error_type;
> +
> +	return 0;
> +}
> +
> +static int error_type_set(void *data, u64 val)
> +{
> +	int rc;
> +
> +	/* CXL error types have to be injected from cxl debugfs */
> +	if (einj_is_cxl_error_type(val))
> +		return -EINVAL;
> +
> +	rc = einj_validate_error_type(val);
> +	if (rc)
> +		return rc;
> +
>  	error_type = val;
>  
>  	return 0;
> @@ -709,6 +736,12 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
>  	return 0;
>  }
>  
> +bool einj_is_initialized(void)
> +{
> +	return einj_initialized;
> +}
> +EXPORT_SYMBOL_GPL(einj_is_initialized);

The variable can be referenced directly as a global symbol.

