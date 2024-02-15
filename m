Return-Path: <linux-acpi+bounces-3512-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D438558F2
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 03:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 774AAB23A55
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 02:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED031C01;
	Thu, 15 Feb 2024 02:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="deNgscMo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA9F1362;
	Thu, 15 Feb 2024 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707963954; cv=fail; b=Qmlxil+Dv34UrNNKuuPtwwvpb+A38WT/Um/4Rry1YMUcX9Nuy1iG2fUfuT9klxMDnCxqugv/IwrMHIKDaTYr0h8OvzjNAvf/AVf655HbnNt7SYwrHG8ZyJhgtPwLvihuCX2/kIml0VJjhSn4hD3fMpjNzti3NzAWrIrmShwG6PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707963954; c=relaxed/simple;
	bh=nAyVceiBfSAOIlP+3EXVWGUsbE9RQQ/VsTYAwt/2y2Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LAdJGw0Y14NHyoT0JJ6VFCr/cEzZV0b/ZZMRv9cLjxc7JEYHtpidyBy2jlzYjwUqS86LI+xBeQnSrqcRguIXcdq5/3PePAzQpIj7/U4j9QgjiStEUm24NYx9cCyMvLNUhpqz5/t+cCftwb0UKQrvq2EednH252s++3wqwcj1kNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=deNgscMo; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707963952; x=1739499952;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nAyVceiBfSAOIlP+3EXVWGUsbE9RQQ/VsTYAwt/2y2Y=;
  b=deNgscMouy6qhRzhuEAucvEBX8/rRs5tOsZjfWdDydGAN8k404XLMfzI
   u5SiEKPHMaqjxci9WuHeq6bP54ll+f8j68tUjVOTLKEpFYaIgCCc1gtEP
   x/xQ2hcVejv4DolXKdlNdgmCPz5RUA2QcdJRA64ogdpp/TSAJlS1b+/Sw
   wM6Jn9herRzs8NFnGgbDwx1pGf2EfFHXaYGbHOEP8BrZGDiRfwcYEuZLb
   PcfrEKo2X84jo7P5859yA7iPtfkUsodeI6UZm33aD9KL4PcbbJwOA/+D3
   njxWnf7au6c4h1BpmGabk9C95lm0GEgTfVvPVerUs+9QyO6xQ4H472GjQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="12756185"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="12756185"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 18:25:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8045931"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 18:25:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 18:25:49 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 18:25:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 18:25:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QizELwx67Uz4bCigxGXYIUJBeG5U7zEWg9AXcgXqp66lffm9bGXO3E9+ymMCWfi/NEe05n+KLq48Et/SSbKX35l/awSNnV96f/Lox7g+Hejq2JFW75bILVOvqSChaA1t6sr0C8F6VF8lkXt/4yz8iR/cymmbcuLSXW4oOOQ30DqF56DeMV8cU3ALe3+D3AmY6CDosQl86KdjdlM+AksIIvRDQRyL4tXR5PM1Ysr6OvNk/d0/QZ+fG3NYxpZicmw8RXkIjqQNxo4D4qkxc1R3PGjkyV6uMrHIAqIPJjtBZbzQX70hfZTerXGpDXvwYQdicy5HV8GA+qVdyq/+uM7L9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2oIB91cB5og4Yz7WENT7x8bfWvLhcNQ9YTDm5rUeWM=;
 b=hrlF4B8ucsWx098ncO1nshhwsnhsHbCpz8orcSSYO67GYSef/WB5Fn/rji6SLZtbq3horROxIHa+kfv3iYH30UcJhbe8mncUxgzU4v86YxBG5KSn2yR4HmSZO0ZckglK7buceltr47T54IZw5nWrynyk6kMoWYr0HQRxdb+Ah5xjVUjsnHgo7vq+13XXGgRIaYs/P8EdAXANyPp68gVbfUfyQvgn5Aul0nvEUJkdbhiTHq+y/ErxBoQYTkpGHWqiyEUN1tgjHKtveGZXMwYQXDaZaA3rsaePLKrHzs9Cr70XVsuy13Uwuqm2Vt2XY3jhUmEXYxZyvBO2208C8YOMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7622.namprd11.prod.outlook.com (2603:10b6:8:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 02:25:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 02:25:47 +0000
Date: Wed, 14 Feb 2024 18:25:44 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 2/3] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
Message-ID: <65cd76286de08_29b129412@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
 <20240214200709.777166-3-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240214200709.777166-3-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR04CA0309.namprd04.prod.outlook.com
 (2603:10b6:303:82::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea0c9a0-83fc-498f-ef0f-08dc2dcd6b46
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9JnljWrwxYFOvC91V2M1Zqh4dcl6mX57awKRw2qlhOcb0KZGxJiIG/kajkIXlYDLuk7S2zeMjpX35z/v9siFTNwZTH3LfsMjcNzXUG1U4/tiJ//auXSALuCeccQwJkVq2PVPUOy4j1I6aDXH4HgWCQX5e/SX6PlXuYGi7hNwB6K24v3QHew03UvHMJVirezdcvFTXvz7uqxxmg+rH21GK8pEcnqy7IZrkpcf36ivTFol0w2JfU96a3AUS6FsXH22237IybZY9yQmFJ2UW1b4gRyEWzY3+xfIDBp9MldHl6OlEOiUvgdK4Wx2v3nKyp52b1lVIhWCNyJwyAMuGI1p4xZWt6yuOFpdSwmcOwlCDFtTHDgNHWOIQQJoVhqgTcjohyWjvkhCVZ3REH/ErW3D7SJ+Q6pAKmcnLhpS9Vxrhn7MG0b2eYxCS5Qm3mJ+2oaL+BOyVU4i0TdWo3U/jzFG/ZB30LKmFkbfsi3Vls+EJX6uw5CKotm25TUVwrIfhHwNiaeOds73WJBZAhPohx1R63NyDParGjiJAdg93E/a4pIregFbtPrwwPuSO1fkhZj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(26005)(41300700001)(82960400001)(38100700002)(8676002)(8936002)(66946007)(5660300002)(2906002)(4326008)(6486002)(6506007)(66476007)(9686003)(6512007)(478600001)(316002)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P472nIxkEwvqjwkj1E37b8OwfTh+/Ih1Q6rSdY6h+yoylddwtZErUVaLyF1r?=
 =?us-ascii?Q?oT5hO0ZbRGf6ltzssYMGc2IiKotk6NMGMSBwMg+TX8uOqXGeMRvP53V8juhK?=
 =?us-ascii?Q?7NAvj5W5M2hoekBeTwFkrFdrdVdCkEAZZN5mEgOzl5vjHHY5bUe1/vzcboix?=
 =?us-ascii?Q?Tvt/kB2owgyW6lNsYZWyEqQW4k1+kBPbElDD714HXv4XPYvIWNX2wt5cyLxQ?=
 =?us-ascii?Q?7Lq+JVy1RVVxqcFiOuJDCpA8un1e3JU6dmRq2C9t5WX0cPw/O7b1se5EUFPV?=
 =?us-ascii?Q?ROW4Fs9v9aCnEDL7ypPBZgXr9ABBG/zWJYNZfztyQj3nwdoT4bcs5uCJa4pO?=
 =?us-ascii?Q?z0UAEG1GQfeMWHtdhWl5xyfK0TEHfppZ8VWYeAywjpd9BIqqpqiBaYdFy4/i?=
 =?us-ascii?Q?9lVc+2fcfxwbNW+XDROK84AK9mwfBI3OQuLoIukG2jcMWStHzEA6EhXE9BVp?=
 =?us-ascii?Q?6cUN5nIK7yjPX/PeNOx/BkdFjB/7eIYoiADui906LV8pgW+Sihcfc1mfro1M?=
 =?us-ascii?Q?syLXaMKJ52XkHY7c9waYOL+gEw9DsUd6Jbttx6uZ1WAVg2PAsxeeHAT31+ZU?=
 =?us-ascii?Q?q8ruvwOTeOtIFwQvH96LbYhfoU41kdkCalJepg04CiDqvS4EcGiHOly2Zx1k?=
 =?us-ascii?Q?fC7KZzlOouoCVEhsqJrPBfVLf5yFurznDGFHJmhKOv/NnFArMLNCjVvR5yFl?=
 =?us-ascii?Q?I6xJpLHZShtXLMAVBvctRwiEiKYCLz+7UeEcyi+VsIRLDgS+PKYC4wJJeXhg?=
 =?us-ascii?Q?2YRykvsO4CNVLzwiaFzhfc49Umpch9m2CzWc9nxNsmg0BZuedkTxoCJ3b+z6?=
 =?us-ascii?Q?y7r3hh01GP8CFo2GOD7AmQ4Fs/nabfzsrfajfghvgcWRqZCZMSmT9IMcnAq7?=
 =?us-ascii?Q?vTOKyKDmj2kw0/1ADJbRA0xw4Xq1+M4aGpT7fdQgZ9+bobJDgah3EdL/fnM0?=
 =?us-ascii?Q?d7na6zfUM7wTcvV81xjIpCXPX/FE/SWW0qn7xY2nx4N8NMN3T8AJXJxougjL?=
 =?us-ascii?Q?7bIUTmGuM59m0yV1v5RV0iL0PPE/xRkxYrYXrEQTdw/hgV399GGJGmVmP5WU?=
 =?us-ascii?Q?+39sQUOhMcxrT4nhWdz8CeBKm64Lybqt+wnhjLXUBTW/7Ya0LXVWZpVNk7aL?=
 =?us-ascii?Q?rI3ArJcJna+mq+xrztWCZXNEzT7R0/mdFXA3dLMNTBHgvst9EUzZMZjA6m6y?=
 =?us-ascii?Q?NWRY/XLAfULjpd/BpqVkZUHjkq1yvJf//VVJQEfGZW9dxoIY/+GMLK117Y52?=
 =?us-ascii?Q?UKX/V6A8mvcvXpJORLlgppM/v0TXJxtnEDTJsr3xaaEO2CpsCxV1YopF4AXZ?=
 =?us-ascii?Q?Y8iRj+RwBREDfYkDmaqEFugMLKi+qYemQCVHhUEZa8Al71C/xsJlHSnRECU6?=
 =?us-ascii?Q?RXhys2+ZN3OsVgFdqCJpDRNrEBPhAya2ah1rHw75mjEXe6WR6YAVWratcYb8?=
 =?us-ascii?Q?T1UsdIyXXBpm6527lX9DMWRF4WFilJKp7NC5BSICUvbPB8ywuMGqwIU0wrZB?=
 =?us-ascii?Q?wReJS7/rBPK8dni/WQj80uwrRwLLUNKunkouTPn1pxPZkIqBzd1k+xmowJdM?=
 =?us-ascii?Q?2pmYmUfTvOjydRMqKY4X4GZN/+co/J8glnJjDlMFTRLV9Htl6JkEt6qFIMpU?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea0c9a0-83fc-498f-ef0f-08dc2dcd6b46
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 02:25:47.3387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNxOBdHKpJnFWgb4mZvTOSeSWLnkDtYnobMe1MsTfiHDkaBXXwzqN4Xj+H0xzjfFphD0KmdipQKmHauJSC7vJ0mABRPgDaVn++yXRpZvbkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Implement CXL helper functions in the EINJ module for getting/injecting
> available CXL protocol error types and export them to sysfs under
> kernel/debug/cxl.
> 
> The kernel/debug/cxl/einj_types file will print the available CXL
> protocol errors in the same format as the available_error_types
> file provided by the EINJ module. The
> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
> error_type and error_inject files provided by the EINJ module, i.e.:
> writing an error type into $dport_dev/einj_inject will inject said error
> type into the CXL dport represented by $dport_dev.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
[..]
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 67998dbd1d46..d1fc3ce31fbb 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -157,4 +157,16 @@ config CXL_PMU
>  	  monitoring units and provide standard perf based interfaces.
>  
>  	  If unsure say 'm'.
> +
> +config CXL_EINJ
> +	bool "CXL Error INJection Support"
> +	default ACPI_APEI_EINJ
> +	depends on ACPI_APEI_EINJ = CXL_BUS

So I do not see CONFIG_CXL_EINJ used anywhere, not in a Makefile, not in
a header file. My expectation is that if this variable is not set then
no symbols from einj.ko are consumed by cxl_core.ko.

> +	help
> +	  Support for CXL protocol Error INJection through debugfs/cxl.
> +	  Availability and which errors are supported is dependent on
> +	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
> +	  EINJ documentation for more information.
> +
> +	  If unsure say 'n'
>  endif
[..]
> diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
> new file mode 100644
> index 000000000000..92c0e2e37ad9
> --- /dev/null
> +++ b/include/linux/einj-cxl.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * CXL protocol Error INJection support.
> + *
> + * Copyright (c) 2023 Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
> + */
> +#ifndef CXL_EINJ_H
> +#define CXL_EINJ_H
> +
> +#include <linux/pci.h>
> +
> +#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ)

Per above this needs to be IS_ENABLED(CONFIG_CXL_EINJ), otherwise what's
the point of the config symbol?

> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
> +int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
> +bool einj_is_initialized(void);
> +#else // !IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
> +static inline int einj_cxl_available_error_type_show(struct seq_file *m,
> +						     void *v)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline bool einj_is_initialized(void) { return false; }
> +#endif // CONFIG_ACPI_APEI_EINJ
> +
> +#endif // CXL_EINJ_H
> -- 
> 2.34.1
> 
> 



