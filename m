Return-Path: <linux-acpi+bounces-2216-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFE0809742
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 01:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC811C20BAF
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 00:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02C85234
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDLRc6r2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128091716;
	Thu,  7 Dec 2023 16:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701993806; x=1733529806;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zItYMTPp65m5Va0sdkI6i8+KZV/8thJa1VPyIFXJNkQ=;
  b=JDLRc6r2ukcbYIILojhi4L+tlAyEBdqTMSS3nayDeYg343+WDAFNRNwH
   LdiOFoYJGisIwryxA2A/A1MLdCbjcRqQBJWMyOAmugisSD6qr2bDur6Qk
   IdQMMIv8dykVdEeP+M86rBsTtdWHfYZw1drfykGI/ofe59ytEKXjiGZIa
   R0eIpAWalGQn0EIjcW52PjaWnDbO+9IGwVTha2K9YVEgEUgArs5tx3El0
   AO37UNP1kpmR+3PRNUA1r70Hh5aeP1ONOS5utKOEdXZVvOw5w4M+HIJrk
   Y4Sen9B9yugkI6NdpomAr/1c2iIJjPjV7NTlWTKGtITLTTFEKg4+obMDZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="379333748"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="379333748"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 16:03:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="915753264"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="915753264"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 16:03:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 16:03:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 16:03:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 16:03:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 16:03:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PevSAkbczFkT6FU1uA/klfrxAD60/8C7n9kzc4UlAb7o6buA2pVjAItDpl03DLlZ0sxLKPkVaA7tMw5i27e1lf/gZz5NKaZxFr7o3wDwj6BlKuHRX5rkjjERMTYoIw7assTPUo6nzobUz1mRPxxxD8BSMpamdJ0Zo4R7/URukd0jOFTjHoCg8iHZe6CpfTHzHnjUmXi9UXon9Yu01zdVFE3zgqDAD3BeRHM/v4DjKR6jiH3FSbmhU3ZO05WmVFyCEnknFz9uiu5spwpMBXyv5nRGVMPZqgpoTglabElElL4Uy8/XeBMha0au1WDzTWatYK3NPzvrUtebIlqd8kGi8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/eITzwIjF7DoBKQFjXj2V73vstsw5XNZE7isDAa8/o=;
 b=aJT/yY5tDHiKJWRE4jgU667Bt0OXIExqIbCFEyefnaElyUU37CeksV0tUHNvdzF4jRn8pTT7i/CPVjz+s+SnmECw9rtpTClxPSSCHZwTDSwLIVPRmDQS89Hbk2Tw4XWYkLV/vk9vLE7K0XGYYh4UhEem7NS0RXZ2pVrRS8cAdCYEtVP+qALNEeUF0qxxahdnMp68XeP9yR5dNuBGPVIqvHrBhK9u7jWMyxN4Ij41ROiySjillApZ/UEvGOu96BDL2y4NZZJcVNJM8yTfIlh6GQsQ6aAIrcH5LrRn9ez2SCqYZQqZ9aowZmc1pC262ZV2LuNf8XJztOLmrwHaMLZ7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7052.namprd11.prod.outlook.com (2603:10b6:510:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Fri, 8 Dec
 2023 00:03:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.025; Fri, 8 Dec 2023
 00:03:20 +0000
Date: Thu, 7 Dec 2023 16:03:12 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rafael@kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v7 4/5] cxl/port, EINJ: Add CXL EINJ callback functions
Message-ID: <65725d405abf3_45e01294f2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
 <20231128160656.166609-5-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231128160656.166609-5-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 222b58c3-d849-4be5-a8b3-08dbf781165b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alGfFNZTxqEhmTSslF91WZ6ZG6gKW75Px7ZwvcKFThiCOORunKDLu5jYNRUHc6MJwxlr5YJpXIepw0KRxEQj/UOn3V1D2yAmt2exAwh2ljdkhxaVZTpuaC41+BXdv7f2MyKDNv2anAMZ3Wx1TRZLnmEssNfK/rgxwXS/GaR7t7/+0srhQ4BUc56Hd7iFokf0J1PVOU39DDOzkKIqn0vvtSbARk09p8lKBEkro+hrnkSjC4jAbetZs6tw8T1xKVMuF/Gkt17ohbVnnobwGeVnwwOAg41Rkyx3TW7OLOPFAtvT6T7Y9oyXWtX+sCxxde79x4EYWIc2AJ8gzvmy3cVkqavFbLVHMwQkvrslkMQsjYVyTy9yyK6XXBPSvu7uvmbBqxG8Pfk6mmzo0qtlyT5zk7Uh404JLAJJKWQYB/rzsS5nueYX27Rs5ibHx1lZ1Ii5diea58pMN2DaoZlZgclUo1NfQDaBiBknvtI2dQOhCQE8cuK4nXlAtc5EOiKibP+zv/KoWrrEGMLAfxi/SUY+xbYwdIe/hQQuxGuFYaixEwj0fdZ7wdh1GvAF6JpEZwMW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66476007)(66556008)(86362001)(316002)(8936002)(8676002)(4326008)(66946007)(478600001)(6486002)(41300700001)(82960400001)(2906002)(83380400001)(5660300002)(38100700002)(26005)(6506007)(9686003)(6666004)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?83NWKmxpQdH/KqQQ/YPgqwqOM4y6GIffPg3TOsd6PtbZMu1g7oQD52s9yAfE?=
 =?us-ascii?Q?ZU+oBvNlrfbCo6pIEs6kDVnuRqdhQf/iKkZV6N92yxskq4HRRT/Rd9rjkHrD?=
 =?us-ascii?Q?U1xYh2SnITySlCtBQ1LT27XCKGr8D6M3CFM0p46lHFUzyFSDYxXS/72rBZNr?=
 =?us-ascii?Q?Vusyxr8dysCs+3SmBszf+ekwQJy8oJycdTvbG909yF5SyPgWSQh+a3N2eYWK?=
 =?us-ascii?Q?byL5xrplsNREIFqkH/RmO75xpNI1QpVxWwWGjD5RNJQictLj1H2xGg/BqzJz?=
 =?us-ascii?Q?ydr9ojvir1jon62ab7wFRR5Gy7axl7qgYCfvt9sl9bm+zUdJCeg7I/77Gat2?=
 =?us-ascii?Q?/exNLWrtYz3JaSDRmKUYGq0tK+zZJQMgS8JmJMux20ZIH+6vxmD85CXw8egF?=
 =?us-ascii?Q?//PS1JZKdXPyZEhOO8fUppo4r1MAg78rA0uCEQcOAJr8dxxmtxkQf4IebAJC?=
 =?us-ascii?Q?VuDEjoAy3tFmePYIyIEzrBC7Ni8Hu5rvvRb/DxmBMXvvJFkDvtc1SBG05Cnh?=
 =?us-ascii?Q?dWPwcWjBUpGC8h94ROCFm/R0WplbJY0F4wHNJwH/IrlU3GtNzZO9i5CILdt0?=
 =?us-ascii?Q?mYQafjHi8eO68Ja9ngzPWdfWj6wACdSJlqTWvagzg2Likxuid5ZeYU4DRwiC?=
 =?us-ascii?Q?Um/esp3NTk+tEDzpvWhVDJNoojqAtiFTDHGt3n6u6yiuXs1kJgRvOVha6Rdy?=
 =?us-ascii?Q?2gshf16vN64yjAXJwl8tF/10FaX2c5SqrW8UcbhTl7tQJdJ8k57BdaKj9iLW?=
 =?us-ascii?Q?xQBIFs22mwOOQmr6FDD7fIkY8Qe1zhg0g5DePSuzG71joO94u788ab7qcofM?=
 =?us-ascii?Q?/HCr2picYHgKeLBajzwN7CyU63SCtLQ1ONubmB4N99JN1+jVaSzjI4VaU/hG?=
 =?us-ascii?Q?Y+k4XalA8Fc9VO4fvS88Z+oKczOxjJC/tWlrQeR4ivonXH0wk33HuBmOO9S0?=
 =?us-ascii?Q?8ppjn9o1A9BlFavrqLsSausuaF0q7EbiB2W6h8xgTRgflJ/f7PO1m+i19kVt?=
 =?us-ascii?Q?snTDlLNIlqYtsB1E0gu8OGgIoCCOsYkihGA7owh7/WCfceXEhfrJd7E+u6QD?=
 =?us-ascii?Q?kz2NBT0b625T06kuxEfKIUSuH1I0VwszbhRLhm2vg5zRVHN8pue2Or4ae/TJ?=
 =?us-ascii?Q?4j4oWN+9+bDYyyJH/5nkkKcjqEoBsdGguU+1E3r3zmBYd6kn1gTiiP2+MJGq?=
 =?us-ascii?Q?BlQ1CT3mIUQqyKQlET50qw0OgaFL3pbPAfxV+xdRuiFG4EkX4mxONNxbNon/?=
 =?us-ascii?Q?9EiLlK6XCY9FhVWUlzlSDHalf6WM5ZiPjbNo4qYJhRBtOnDd34pZqZiymls9?=
 =?us-ascii?Q?73meFWFvi1S/OlmvKX//jMbGfO4+1o1p7lynD6wjKFKyyzxsKx6BcLbTe/R+?=
 =?us-ascii?Q?iNnDFM7h5744sJZTpzyv+8CD5cKooGYIpGFsZ4mU5SS1XBPNM+/6c8KPWzUp?=
 =?us-ascii?Q?T/fApPSWOX9IWa4mSvqEHXbsIIH8CMEcb3f1YRGU/rTdMsmBB0KK231N+k5/?=
 =?us-ascii?Q?tpG+3T4McUuPPOB16pX8pUfq1GaF3oEpNK4d+ejTmx9rcKPl91BZIRLqbLFl?=
 =?us-ascii?Q?h2XZ319FmUgM0zXZopvhLhSmMdNyxBNVG5v2VU/dMIyZYbgDbzwSOwi7Ky2k?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 222b58c3-d849-4be5-a8b3-08dbf781165b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 00:03:20.2288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2F6GEeKOMRloSFNZftloG9zXCHrqYq8LABbt/VkAkm5dMe7BqsFy0eeInfZ53gHoeo4T1KCH+QlFRRUKcCg1PPcwztf/4ieu34GMqRzYL0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7052
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Add functions to the EINJ module to be used in the CXL module for CXL
> protocol error injection. The callbacks implement the einj_types and
> einj_inject files under /sys/kernel/debug/cxl/portX/dportY. These two
> files work in the same way as the available_error_types and error_inject
> files under /sys/kernel/debug/apei/einj, but only for CXL error types.
> If the dport is enumerated in RCH (CXL 1.1) mode, a CXL 1.1 error is
> injected into the dport; a CXL 2.0 error is injected otherwise.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/acpi/apei/Kconfig |   3 ++
>  drivers/acpi/apei/einj.c  | 105 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)
> 
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index 6b18f8bc7be3..100c27beb581 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -11,6 +11,9 @@ config ACPI_APEI
>  	select PSTORE
>  	select UEFI_CPER
>  	depends on HAVE_ACPI_APEI
> +	imply CXL_BUS
> +	imply CXL_ACPI
> +	imply CXL_PORT

This goes away with the CONFIG_CXL_EINJ scheme proposed on patch1.

>  	help
>  	  APEI allows to report errors (for example from the chipset)
>  	  to the operating system. This improves NMI handling
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 330329ac2f1f..98d5e6d60a02 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -21,9 +21,11 @@
>  #include <linux/nmi.h>
>  #include <linux/delay.h>
>  #include <linux/mm.h>
> +#include <linux/pci.h>
>  #include <asm/unaligned.h>
>  
>  #include "apei-internal.h"
> +#include "../../cxl/cxl.h"

EINJ has no business knowing all of the details in cxl.h. In fact all
EINJ cares about is dport->dport_dev and dport->rch. I think just add
those to the calling convention, see below:

>  #undef pr_fmt
>  #define pr_fmt(fmt) "EINJ: " fmt
> @@ -627,6 +629,25 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  
>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>  
> +static int cxl_einj_available_error_type(struct seq_file *m, void *v)
> +{
> +	int cxl_err, rc;
> +	u32 available_error_type = 0;
> +
> +	rc = einj_get_available_error_type(&available_error_type);
> +	if (rc)
> +		return rc;
> +
> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
> +
> +		if (available_error_type & cxl_err)
> +			seq_puts(m, einj_cxl_error_type_string[pos]);
> +	}
> +
> +	return 0;
> +}
> +
>  static int validate_error_type(u64 type)
>  {
>  	u32 tval, vendor, available_error_type = 0;
> @@ -657,6 +678,68 @@ static int validate_error_type(u64 type)
>  	return 0;
>  }
>  
> +static int cxl_dport_get_sbdf(struct cxl_dport *dport, u64 *sbdf)
> +{
> +	struct pci_dev *pdev;
> +	struct pci_bus *pbus;
> +	struct pci_host_bridge *bridge;
> +	u64 seg = 0, bus;
> +
> +	if (!dev_is_pci(dport->dport_dev))
> +		return -EINVAL;
> +
> +	pdev = to_pci_dev(dport->dport_dev);
> +	pbus = pdev->bus;
> +	bridge = pci_find_host_bridge(pbus);
> +
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
> +		seg = bridge->domain_nr << 24;
> +
> +	bus = pbus->number << 16;
> +	*sbdf = seg | bus | pdev->devfn;
> +
> +	return 0;
> +}
> +
> +static int cxl_einj_inject_error(struct cxl_dport *dport, u64 type)

If you split this into cxl_einj_inject_error() and
cxl_einj_inject_rch_error() with following prototypes:

static int cxl_einj_inject_error(struct pci_dev *dport_dev, u64 type)
static int cxl_einj_inject_rch_error(u64 rcrb, u64 type)

...then you don't need any of the cxl.h definitions. The dev_is_pci()
and rch determination details can remain private to CXL.

> +{
> +	u64 param1 = 0, param2 = 0, param4 = 0;
> +	u32 flags;
> +	int rc;
> +
> +	/* Only CXL error types can be specified */
> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
> +		return -EINVAL;
> +
> +	rc = validate_error_type(type);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * If dport is in restricted mode, inject a CXL 1.1 error,
> +	 * otherwise inject a CXL 2.0 error
> +	 */
> +	if (dport->rch) {
> +		if (dport->rcrb.base == CXL_RESOURCE_NONE)
> +			return -EINVAL;
> +
> +		param1 = (u64) dport->rcrb.base;
> +		param2 = 0xfffffffffffff000;
> +		flags = 0x2;
> +	} else {
> +		rc = cxl_dport_get_sbdf(dport, &param4);
> +		if (rc)
> +			return rc;
> +
> +		flags = 0x4;
> +	}
> +
> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
> +}
> +
>  static int error_type_get(void *data, u64 *val)
>  {
>  	*val = error_type;
> @@ -668,6 +751,7 @@ static int error_type_set(void *data, u64 val)
>  {
>  	int rc;
>  
> +	/* CXL error types have to be injected from cxl debugfs */
>  	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
>  		return -EINVAL;
>  
> @@ -714,6 +798,7 @@ static int __init einj_init(void)
>  {
>  	int rc;
>  	acpi_status status;
> +	struct cxl_einj_ops cxl_ops;
>  	struct apei_exec_context ctx;
>  
>  	if (acpi_disabled) {
> @@ -793,6 +878,15 @@ static int __init einj_init(void)
>  				   einj_debug_dir, &vendor_flags);
>  	}
>  
> +	if (IS_REACHABLE(CONFIG_CXL_ACPI) || IS_REACHABLE(CONFIG_CXL_PORT)) {
> +		cxl_ops = (struct cxl_einj_ops) {
> +			.einj_type = cxl_einj_available_error_type,
> +			.einj_inject = cxl_einj_inject_error,
> +		};
> +
> +		cxl_einj_set_ops_cbs(&cxl_ops);
> +	}

This goes away with the new Kconfig dependency scheme.

> +
>  	pr_info("Error INJection is initialized.\n");
>  
>  	return 0;
> @@ -810,8 +904,18 @@ static int __init einj_init(void)
>  
>  static void __exit einj_exit(void)
>  {
> +	struct cxl_einj_ops cxl_ops;
>  	struct apei_exec_context ctx;
>  
> +	if (IS_REACHABLE(CONFIG_CXL_ACPI) || IS_REACHABLE(CONFIG_CXL_PORT)) {
> +		cxl_ops = (struct cxl_einj_ops) {
> +			.einj_type = NULL,
> +			.einj_inject = NULL,
> +		};
> +
> +		cxl_einj_set_ops_cbs(&cxl_ops);
> +	}
> +
>  	if (einj_param) {
>  		acpi_size size = (acpi5) ?
>  			sizeof(struct set_error_type_with_address) :
> @@ -832,4 +936,5 @@ module_exit(einj_exit);
>  
>  MODULE_AUTHOR("Huang Ying");
>  MODULE_DESCRIPTION("APEI Error INJection support");
> +MODULE_IMPORT_NS(CXL);

EINJ never references a CXL symbol in the new proposed scheme.

