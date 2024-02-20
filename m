Return-Path: <linux-acpi+bounces-3742-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CE585CBB8
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 00:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8FC28437B
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 23:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EF0154425;
	Tue, 20 Feb 2024 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvI7YX94"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8205C15442B;
	Tue, 20 Feb 2024 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470267; cv=fail; b=YWr7Ekhcb20tNiRNBqNlWLkkICa42hp15D+6IwjUlkNQRiENoxjft1Z4Sh1yiEFDVkmsmEZXrin+cWwvxz/S0VK9J0hNBKPHxIBGvRsmHdZtB/6PuJR49Uxkjda3jgLPJCyXe3bOcq53RP2aQ6tkjYqXwPYI6Hn7pfBTnCvWX9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470267; c=relaxed/simple;
	bh=v0WV2J7ZYrrNjcHZrgdSSKTagSrPhCZqCLqqzfayTt4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cJxrmMrTFUlfUZolztfLgYkXm9vHfuQSBuM/C9Ji3jm+Milmp4FY3vwlV+YZq4/vgxUpqum51eXLA5pBmvWJ+B85ZEln6rvrzsOYLel9yX/UCBUZSNumHArY2A+i65Zov0GdOY8G0/zECQHJKZVD4rTjy3ry3ibWy5mHVc1GLhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SvI7YX94; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708470266; x=1740006266;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v0WV2J7ZYrrNjcHZrgdSSKTagSrPhCZqCLqqzfayTt4=;
  b=SvI7YX94VRYEEV7N76LNNEeWnSi6KPDFsgauKLNBMe3H2zNsV4CO4uWf
   rv5J5P3qfvc6WG2S7zVavxsFbI1mnp7IPzdPB42ViIyftZHeh4lLS8dYd
   bcyk/enX31ppagyl9X+nHmUoURxfgx57olTeLfQA13Du7GqVc3AWS4U/h
   zRkwo2m3ADgLG45HcXi53hZtERs5FsLdA20OsWdSmvahIrWEhB8YR6wPk
   Fk0uuhw7Xwdji7TGEGdbViHzZkcboPp8iLU7Y/ZYLixodCtxj8Ds00a7C
   ppxBUPVnZDEjZKgaRnVgY3Cmj7cXDTeKGFYgMGhH9KC7Bu8dL1c6WMi2u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6380824"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="6380824"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 15:04:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="35693560"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 15:04:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 15:04:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 15:04:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 15:04:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 15:04:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcM2v4xL6AS3pJ769IBb9euPJraCu7YRiT8wc+yyY7MzJfkIXrfH8jftce/7OKJGL+V1K1o/+orylv8RVOGUwSXU7UPzX2FUTdBhykPB3VGGMSivjQIT20jan6CgLc/ahnOPUgmJWzNE86mdfqLhIzlWCN7K7z2mq+inHvSjTZDfSromWqo9rESG3xpTFsjpKgynZS7dwVpbzB81bZ5XnovAJt2MOdeB03cHVbNbwSatFv5UlJ/VU/ny+G1LxOw+m3iA0g0neS/OR9PTfdn/fCtH/p7CoKql/8MkKGYfBNfgKLZMvoDqFvviwfwWDdEbawdqW+ELhvEF7tgc5I7lWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg1zQZ5zpyNiJDoJEdglhlWV/4B10VqhnIajhTXpiNU=;
 b=FZVp90MtsnkUoHC11ozb1FMhkQdEGtWxyqtfPu9anD6UlkWAm5EHInPyb8CYuexoIQai6dFi6TjwWWvnR73xxBCajHH+nQ8UxyGrM7lo2PgZFEwfIgTc3NZsjxdpJP4ae63JN4eNv2CgIMfJAxlzEZMR0YzTnFbLVb45TUoAQbdTvzDR+bTJLUKm7DpAmi1P/0hUmLG+GtM2MyB0LXhHHwIR0rlnK2fkDEhDWGYyQ67ISkAKBrCqPehs1SVj1P5kummJyuE5pz+PloyB+5Lu3Ihrh40dHOSscErXM4eEDR9Ls0jVmiLpG8vn1ayQbW+ifyeQx1vDiu+nhp3Z8bUh4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4592.namprd11.prod.outlook.com (2603:10b6:806:98::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 23:04:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 23:04:20 +0000
Date: Tue, 20 Feb 2024 15:04:18 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: RE: [PATCH v13 0/4] cxl, EINJ: Update EINJ for CXL error types
Message-ID: <65d52ff24b250_5e9bf294d9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:303:87::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb1b4ed-2919-4a6a-48af-08dc3268459c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AeEI1K3IkYkrgUtUO1xpcsnReN5tOANSgYcgmNgxG3qHO/n6VFXKBzRZhyMOtS30HJbGusN0oJ3WlGy6ZJl8xrchMWYwmOLDXU1rzIVvRzdLux5TolNt83y/ySK6cGAIGYF9igwLlZ73uYdbq+35oFw/Fsylp2ky+UbJT2rlqrJrYM+XY2lCdYCu2SHlaMgVjelt4n+o8twp2XLfvPEUpfcLDX/Llww/dSLPbcUZ0UpikLY/TFa7OXFebulilY+Vnbhx/tPFVJ3UwfZS7fwJ5tI5ByP5cm1vti2g8ftyO6YDAxTEGyrj4yDeTPNJ1FqINh1kyiakbhcX5iiKsz7wT2I64ctB8OYrZH3EXghEvLlVvzJuGoNVJ/yRcbM2a7hpTXURdsAC+og4pVPTPlVhSBCtCgFXuMNpnA+FZugxMvuempals8Z4HttjHsHgj+GIr1JHb8tlPfJwtKWtiV/LN46RHLdSgKJjpMgm4bMyi9mvkLaEH6pYGD560+5MQ8TnXnDEIEYRTNuiknSnLA/nQCWUxXIhTIXy26bTM8ZDTo8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z9QF/7NJW7P0a6+YM3c1OsBb07h7F/fS8oHe6OVZ6ub35VcA47mfHTu8YvZd?=
 =?us-ascii?Q?MzqsTooq4VRiyMHdm6PxX/8wWdKdlomwC/A7RtXvnrB8azZ8WVJtn50CfBmZ?=
 =?us-ascii?Q?TPo+xS+V02DW0lcUuFjJVYsX0XQctYKH44dMja22lIfZIbm6X+1gc/CtPjjj?=
 =?us-ascii?Q?Xlw4VP0WJopuWTP9aYQ0esinLo4h3q/gl8vQ3fD/PxBL66zYw5AKUVvrJacY?=
 =?us-ascii?Q?QDuJzzeQqDCPWenRU/QR3TSDG8myrYlavmoPSaRo+3ZxW7E7Z3URkkFQXYEl?=
 =?us-ascii?Q?+aUYol2h49qCfPHNRbrwYupoGYlNRjfGZOZykdvZYNPGwITTPDqmNmnQdu+m?=
 =?us-ascii?Q?l+WtzngQM2w2U8X7kLHhekFZWu/OuSSTktBpRgu6B/r2E0mq+mN0VipSN0jd?=
 =?us-ascii?Q?XyIyJD+tK68YqorEcSv/W7LsvQNUtKvI6muN2mX5L0fUqUvjow2MjzeRiF8V?=
 =?us-ascii?Q?fTjH/mjSGo5opqX9y9dahHSion0+jyIKIogcHUrRmqmbXA7k9VbPPsFR5REc?=
 =?us-ascii?Q?jnQIFAKy/xbauoQZjfWYDzYNqMCfSxanwsxOpvyx43ZZUZa1ifRxa4fIedC7?=
 =?us-ascii?Q?pFJW8yPdw/6bqetuMv9w4/nNKC57BEfrB88DvbhDEqN+BUxTWh1laooxqAMo?=
 =?us-ascii?Q?n+uiEBhXbxAQBTQWsAkfMjRJEcyysRARgv4pjdCP+rxm9j1/xJjiAOv0TrUR?=
 =?us-ascii?Q?gTC8iUe2Kv2dfRdyOxflTYe5XE4xsvRr+GGFdWOvCAdc2lrAy0u5mgyz913v?=
 =?us-ascii?Q?/aFGukhY6QOonJBcrVp7QUyiK1HEkizsbZbDVw4a42Qmp+tbtW/oQZZj0hYV?=
 =?us-ascii?Q?Ohu4B0Ljlz13K7lME2dN9vHzGyViuJkGPSrCwlG0sxWu5lLDg0qKfFs3vxp/?=
 =?us-ascii?Q?gO/ysuEO2JXLown3X9hHqiwOl0mY5LXHuQEi0pYf7mm6hBt6DB9PHV5ykbTW?=
 =?us-ascii?Q?XDFWSNJBbNXzdpImlrJO8UTwC9vmUVWSJq02Uqs7TEBdCIMLZg8gWlZ6i+tW?=
 =?us-ascii?Q?GfUUMhgc85NGHEYjOibelia2qUl/WpV38fEiek7lSuLnwRg1wQ2XxcW1QhCG?=
 =?us-ascii?Q?QrpDCNkZHnD3P2unbR1Z2uAKx+bfjky7Vo5IqzTakbMNuVmboT1Sb+LhN3II?=
 =?us-ascii?Q?Uk0StugAXOyZ+C7kEfLwaKVE8qvnlJCsEIDLghFj7zAbioCHvhQSm0D57GdA?=
 =?us-ascii?Q?Rz/nhJO+jVT+3E012LEZZYMAEAF4Ma5HpJsITrsQQ89bH8F7SGYYN7uxh6yz?=
 =?us-ascii?Q?H9E0N+2t8v7rPG3JSlNvouZk7m6sjIZ1Pl7tFZtVdBcnbK3rTxwNo9gV4YAH?=
 =?us-ascii?Q?Wu8CQAGGnlyf8/BJpymUsuo/2/vYJuY5jfa2bDm58+I5bEJqA6EkNBiC+PB/?=
 =?us-ascii?Q?kOTvvSqSZswQcGnbCQm4zF/pxlAlcugBSQmHHANXQT7oCd4VjPtIkwKcf+1d?=
 =?us-ascii?Q?aaYV9DPnk3eXxsoDI9EGOkFXnyVtcE2hmBTZsL2+ItVEmUcYbcjW1BYWhyxp?=
 =?us-ascii?Q?YvqYJEZa2AhBtpwQpBCbROmnM2rFB5brx3CNmukxt7l31FxikEQ2uwDWglUK?=
 =?us-ascii?Q?Kuq8XmWqwQ/I5/BqOa39DSKG208BCHKfMy18Y0nqjNMVH7g1bBQ/aDXzrm7p?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb1b4ed-2919-4a6a-48af-08dc3268459c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 23:04:20.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEkLVlEPtDMvntARmJo+9VlwZoRWmQ49RerBiD0W4qEGLWji7WHYYcFHpWApPjV7ARHiw7c/slza4zPKhYjq833hnmKa++HVy5d6/PgIj9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4592
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> v13 Changes:
> 	- Create new einj-cxl module for EINJ CXL error type functionality
> 	- Rename CONFIG_CXL_EINJ to CONFIG_ACPI_APEI_EINJ_CXL
> 	- Move CONFIG_ACPI_APEI_CXL to be under CONFIG_ACPI_APEI_EINJ (due to
> 	  new CONFIG_CXL_BUS dependency)
> 	- Add an optional dependency to CONFIG_CXL_BUS on
> 	  CONFIG_ACPI_APEI_EINJ_CXL 
> 	- Change pr_warn("EINJ table not found.") to a pr_info() for when/if
> 	  EINJ probe fails (Tony)

pr_info() is too chatty once CXL starts triggering this module to
autoload. I will take a look for anything else that might trigger
another spin, but if that s/pr_info/pr_debug/ change is all that's
needed I can handle that on applying.

> 	- Add a clarification that a CXL port needs to be present for CXL 
> 	  EINJ error types to einj.rst (Davidlohr)
> 
> v12 Changes:
> 	- Rebase onto v6.8-rc4
> 	- Squash Kconfig patch into patch 2/3 (Jonathan)
> 	- Change CONFIG_CXL_EINJ from "depends on ACPI_APEI_EINJ >= CXL_BUS"
> 	  to "depends on ACPI_APEI_EINJ = CXL_BUS"
> 	- Drop "ACPI, APEI" part of commit message title and use just EINJ
> 	instead (Dan)
> 	- Add protocol error types to "einj_types" documentation (Jonathan)
> 	- Change 0xffff... constants to use GENMASK()
> 	- Drop param* variables and use constants instead in cxl error
> 	  inject functions (Jonathan)
> 	- Add is_cxl_error_type() helper function in einj.c (Jonathan)
> 	- Remove a stray function declaration in einj-cxl.h (Jonathan)
> 	- Comment #else/#endifs with corresponding #if/#ifdef in
> 	einj-cxl.h (Jonathan)
> 
> The new CXL error types will use the Memory Address field in the
> SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
> compliant memory-mapped downstream port. The value of the memory address
> will be in the port's MMIO range, and it will not represent physical
> (normal or persistent) memory.
> 
> Add the functionality for injecting CXL 1.1 errors to the EINJ module,
> but not through the EINJ legacy interface under /sys/kernel/debug/apei/einj.
> Instead, make the error types available under /sys/kernel/debug/cxl.
> This allows for validating the MMIO address for a CXL 1.1 error type
> while also not making the user responsible for finding it.
> 
> Ben Cheatham (4):
>   EINJ: Migrate to a platform driver
>   EINJ: Add CXL error type support
>   cxl/core: Add CXL EINJ debugfs files
>   EINJ, Documentation: Update EINJ kernel doc
> 
>  Documentation/ABI/testing/debugfs-cxl         |  30 +++++
>  .../firmware-guide/acpi/apei/einj.rst         |  21 +++
>  MAINTAINERS                                   |   1 +
>  drivers/acpi/apei/Kconfig                     |  12 ++
>  drivers/acpi/apei/Makefile                    |   1 +
>  drivers/acpi/apei/apei-internal.h             |  17 +++
>  drivers/acpi/apei/einj-cxl.c                  | 121 +++++++++++++++++
>  drivers/acpi/apei/einj.c                      | 127 ++++++++++++++----
>  drivers/cxl/Kconfig                           |   1 +
>  drivers/cxl/core/port.c                       |  41 ++++++
>  include/linux/einj-cxl.h                      |  40 ++++++
>  11 files changed, 385 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/acpi/apei/einj-cxl.c
>  create mode 100644 include/linux/einj-cxl.h
> 
> -- 
> 2.34.1
> 



