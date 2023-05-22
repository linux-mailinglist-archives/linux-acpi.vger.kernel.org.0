Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E6470CC6E
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 23:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjEVVb0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 May 2023 17:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjEVVbX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 17:31:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC370CF;
        Mon, 22 May 2023 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684791080; x=1716327080;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oUe9epGSS06InU/IPFeHAeewis7hVroQaJ+pID5BafY=;
  b=mdASMPWV4CMfkn5PEMv6kI6i4RDgWp5AHjAhivRVeLxFWo1BHzuHaG2v
   a9YAE+QZVVojDBEU0k5PrVkVKDcYWUsfJRv3e8pGZmNWdmPd/kekdOME7
   9/67khRVcpHploZT7n1vpfwAuOQX2a9llYi8z2jWuD6iDbpuRNI2SzOQj
   jr1TiqEMSK6LTrTm9li9b6KdpVvFvZ7JT/tUN0FJsn+ERHZPXQencMNUd
   guimQ/cSvklegFmlY5ScBpMPVp2tZ7u6MRd5qG7495tdoxRzwbj4XiAqB
   E+smEfW5zggWQcHND+ZmvOlVbxkKbxsaiAm29JuRqmjHmkmtQxNFx3ltZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="418754574"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="418754574"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 14:31:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="877911296"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="877911296"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 22 May 2023 14:31:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 14:31:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 14:31:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 14:31:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 14:31:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a38r8e80GQE8plP4Capez9g05OkvsMneOGxp73J/SKnCRM+PllcHl+CrvaxuHIYNoR7vdg2CCskyc0K7yZTu/TNQxMhibje4NNdFv8Q9HduOPM2EEaadW/MyfX3TIagDU62IaUno9nU5GrSpoYDYCUx6cOrvP08oLjQ/+FLpzVfUTAP5/sYHEuWmnWDRtGJ/RJvAM1wwNBPqzZus48I30R5x7jUDFF90+p4EjGw/I0G7U6EaA7PxeicYB+65YM6D+g8ENYEzda0hKo462sq00GsZVFHqvWKWyU/+38C+Wy7yDyJ6DfBSSoS3wmWmzsLbWXDI2bP9LDw8ug2H8pnV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH1ofa3VmUlNZv4btGU2alMEpupldoDhE0j5bWK4/l0=;
 b=Cqov9tsiuolEaCbk5aSwL2iB4tCVFMMnvDUP9/1BTDWaynjidhgF4UFY1LeA7ihwv8wgbnGGlngYBIZMN8swm053JU1Norg4RMsPsRA+RoG444UbgyACl0YL+LUGj3uNMipLOUmGY37BQiiktdIgA/Sn4vKG/fNFvZYGU8wzT+LDRTpfsgxRIBgoZ3OLWGtKubcaQR2OCK+I+yKJ1ZbDx2TI79JmiH9o6TB4Wal8pikzMr5HxDDpreeYiKP7VorDmPCM7BUd+mVRckxMkYSzwgFcDKKZneY0yQoPVXkk1b2Ton0VzJFzS8ajZi/3V3KAPFA5dSofq3zX0BxdwLFTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7946.namprd11.prod.outlook.com (2603:10b6:930:7e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 21:31:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 21:31:16 +0000
Date:   Mon, 22 May 2023 14:31:13 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2 1/4] acpi: Move common tables helper functions to
 common lib
Message-ID: <646bdf21b9329_33fb329410@dwillia2-xfh.jf.intel.com.notmuch>
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
 <168443478260.2966470.6881416930240756285.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168443478260.2966470.6881416930240756285.stgit@djiang5-mobl3>
X-ClientProxiedBy: BYAPR07CA0095.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::36) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: d83c0935-c68a-4f29-c5e7-08db5b0bdfd1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y93z43P/GohyiSXfjcoLW4HQTSPqH92R9GtQ2c4E49YCnlD9aXTrph7t0HbiAyYr+I/3prFD0cxRZya2qE4ppQPWQUPpSDdCVST026mZiV7/3vlV1EL80M2dYkM+ewH9zFP6lRP0oC1mM0tUiqr1aOVsSULMgzPkvRY5BKQK1kNJ5862MVDHsd5qqmKMgdSVy1tNXkKZiiiFrSwkErrwvkZtStHMZoa+gunQJn2jemHV8dZrlzK1UYjTfo/GLyJrvmjFeiIcStWZX6stFhtieMvUVmMZSKCbPpU9tVzuFIqHm3icdQGt0WcUO6z8ttnpObQNKs1RgUKHrUzmDg12RqaOa0HpiV1VjOeotiAocIV1M+/rZlO2mSHjm/lekdMnyigaQGd8g4geihqGI8ylpnzeZ9Ynwz1KdAcJWtIFcs+ttiTYjJ5dJOoUF8g8Q1jNnrOzbX1Dx8VZTXf5RhFwzOcv7FSxRd5xNurSP7qMhEt3OB9MHEk5ShdJ2uBPLQ/jTK3GeeEb3hrpRfBYjmvx4Pdw4iO7Yziki3G5abpgsPjHQ7dWErjPsB9T882LJK13
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(186003)(83380400001)(6512007)(6506007)(9686003)(26005)(86362001)(38100700002)(82960400001)(41300700001)(6486002)(6666004)(66556008)(66476007)(66946007)(316002)(4326008)(478600001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3pFcNCOOcTZtbVUO0qs89rQanhbOIw6Posr5/A/D6+qIZ2+ft+uI17oQpeSV?=
 =?us-ascii?Q?KE6x/lDNiVrNEen6krX9IID0wiMv3oMqNu8e2UcSaMuY19LA1JWCrOCTHmMw?=
 =?us-ascii?Q?9hbSeviw10TdF+uUGNJ2RSYG6QVU0CJYHwElkKSvsfNwSJ47l17g/t8t4JW2?=
 =?us-ascii?Q?q+pNBY3QahjnIHIXIifYXrC3G7Xc3s9A9hTp8v1Y2isqwNPyNEcWY+L4eb8R?=
 =?us-ascii?Q?f/z2LVPaixO7OKzZ4hI8fCaEPUOvJYIeltY+IAsIATkRDetuLdXFWR3ohdZE?=
 =?us-ascii?Q?/IIueCTTrp+rApfLbBqGFCjGaqtHpG+P8eKwY+GLhP8E/IZg19F89wbI8Fqa?=
 =?us-ascii?Q?Y/LJWVrOQOnpWAFWRVqq1SqDWKjLPatPPsaVoB2zgAUG/Ag422yISxY3QxJo?=
 =?us-ascii?Q?a1iqcycjSlPrRKoro7W1ptRSBgPDFfmy5PP76WeEknOhN9Lnuw2I4U5ceRv3?=
 =?us-ascii?Q?vIuQ+4+b6XyqS2MxmUbSI07/JkBJAKRFtElpwHjddXrRHoeAJIHEqb2CwZZh?=
 =?us-ascii?Q?/+5XUmYJJjKLx7LIwp2lNS5UvBk2/Kn++AVQRchSa5OdvfmDbPOhHVqsOUUy?=
 =?us-ascii?Q?4umoVSSlpFbzNjIWSfxeJtWbAWuBZ5I1A7xIMHA6kWzqtQuQYRiK/q0meQ7v?=
 =?us-ascii?Q?WtZe5G9a1NVbtBlSvliEt4QtBmZnx+MJGGGEhPHJuqNfnMqNiV2KcvXTjqFl?=
 =?us-ascii?Q?RgiwRhT9DSoFt1UIwiwTGtJL12JBCbxdFpRY3UfE5g2iFpd4ec4jUVd11/B1?=
 =?us-ascii?Q?Ns8LNat0ddHZMj7VAqcM/7S04OBs/lJgEocvVlFIGj56iuhffRRuiOqADbt6?=
 =?us-ascii?Q?0p+olJ8yHsnJKXkpTwANeDQt+DvlLFqUtWNPLYcKgQMm14EjRb7fPoG6YK95?=
 =?us-ascii?Q?mrRbsZ/6iYgeUIHGrpBWAWCGJQUTv796H0TlvPRNYTSm2n5Uxg249qLhWy3G?=
 =?us-ascii?Q?7W/x4BiAVFBL3LuR0uFIIpRGuNRv2/xUJx71Y2Lh7UIDGaf4YTBamKyDyf/r?=
 =?us-ascii?Q?NRjd0jTWE0uVAKHrplaywRK0yizg+1GJ6UFLcqKv/FNE/qt1r2OxqYVekhiE?=
 =?us-ascii?Q?dowF74n3sfm6g+qdzL+7u/t9zPkDHM0csqjFppKGrI0HwHV9HyQPP0PKKfQZ?=
 =?us-ascii?Q?T9iI9EKeZsol7ApHTc8Lv8B+28Db9AZ0PxhbkalRxFDKNyQ1CvQ4rdRBHvT3?=
 =?us-ascii?Q?swFj+Zbo0WnQ7Uaqhhap16y7Oh0aRPIa+PZbozGDy/5BudgdM5WSBO6jOJGb?=
 =?us-ascii?Q?+FqXPTgsb0bR3osZE1ieoTn0DioZLOtUaLI93+j+l93bLCOtBoVIDD17K5aA?=
 =?us-ascii?Q?o5J8++05vaNnXfgu+ow90GbyjpHhwQPU6MroqpwbS25qDzuiwuZGcyGSU0F6?=
 =?us-ascii?Q?k6RT0acJ4Qc8jcSxD5EHo/R1OVAbvE+ciM722qS6pIcX0d7YqkqYvRGOeVc2?=
 =?us-ascii?Q?1WyxnZofmwiJTOVkqgsLMj4JU1QXU32duYGXfsxUc8xcsfYt0KAAUdF0yL+H?=
 =?us-ascii?Q?WuBMZ2sBgKiBz9mSBMIvz3qcW65OVFP/qoJfg6+gLLTvj80N/W5/fft6slLl?=
 =?us-ascii?Q?61JD60DK2fBCrbqlRKqI9mHSMnuNg1KB96akpi1b6wlfIR0HFVA25Gn91Qlo?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d83c0935-c68a-4f29-c5e7-08db5b0bdfd1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 21:31:16.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwJDmwk5aw9m0fwWHSBp4Cz+rR0plPnhW1UIa7cvqtGcX2yC6D6c1LyvdR1qt5H/aJbZFFyORqUovHuwBRHRc8c28gJ0t/Qgy9huiNQjZuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7946
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> Some of the routines in ACPI tables.c can be shared with parsing CDAT.

s,ACPI tables.c,driver/acpi/tables.c,

> However, CDAT is used by CXL and can exist on platforms that do not use
> ACPI.

Clarify that CDAT is not an ACPI table:

CDAT is a device-provided data structure that is formatted similar to a
platform-provided ACPI table.

> Split out the common routine from ACPI to accomodate platforms that
> do not support ACPI. The common routines can be built outside of ACPI if
> ACPI_TABLES_LIB is selected.

Might be just me but I get confused where this is indicating "ACPI" the
platform vs "CONFIG_ACPI" the code. How about just:

Refactor the table parsing routines in driver/acpi/tables.c into helpers
that can be shared with the CXL driver even in the CONFIG_ACPI=n case.

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/Makefile          |    2 
>  drivers/acpi/Kconfig      |    4 +
>  drivers/acpi/Makefile     |    3 +
>  drivers/acpi/tables.c     |  173 ----------------------------------------
>  drivers/acpi/tables_lib.c |  194 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h      |   63 +++++++++------
>  6 files changed, 241 insertions(+), 198 deletions(-)
>  create mode 100644 drivers/acpi/tables_lib.c

Conversion looks ok to me. Even though the cover letter said "Hi Rafael,
Please consider these for 6.5 merge window" my expectation is to take
these through CXL with ACPI acks.

One question below:

> diff --git a/drivers/Makefile b/drivers/Makefile
> index 20b118dca999..1824797f7dfe 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -31,7 +31,7 @@ obj-y				+= idle/
>  # IPMI must come before ACPI in order to provide IPMI opregion support
>  obj-y				+= char/ipmi/
>  
> -obj-$(CONFIG_ACPI)		+= acpi/
> +obj-y				+= acpi/
>  
>  # PnP must come after ACPI since it will eventually need to check if acpi
>  # was used and do nothing if so
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ccbeab9500ec..ce74a20dc42f 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -6,12 +6,16 @@
>  config ARCH_SUPPORTS_ACPI
>  	bool
>  
> +config ACPI_TABLES_LIB
> +	bool
> +
>  menuconfig ACPI
>  	bool "ACPI (Advanced Configuration and Power Interface) Support"
>  	depends on ARCH_SUPPORTS_ACPI
>  	select PNP
>  	select NLS
>  	select CRC32
> +	select ACPI_TABLES_LIB
>  	default y if X86
>  	help
>  	  Advanced Configuration and Power Interface (ACPI) support for 
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index feb36c0b9446..4558e2876823 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -13,6 +13,9 @@ tables.o: $(src)/../../include/$(CONFIG_ACPI_CUSTOM_DSDT_FILE) ;
>  
>  endif
>  
> +obj-$(CONFIG_ACPI_TABLES_LIB)	+= acpi_tables_lib.o
> +acpi_tables_lib-y := tables_lib.o

Why is a separate object name needed?
