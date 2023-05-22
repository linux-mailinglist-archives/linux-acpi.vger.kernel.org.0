Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6664570CDD5
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 00:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjEVWZn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 May 2023 18:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjEVWZk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 18:25:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E3E12B;
        Mon, 22 May 2023 15:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684794337; x=1716330337;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=evGWS+j5x2TNvHm6NLj+sfHQmVPEHmFMCEY2sd1i9Uw=;
  b=N27Nho2xlXFfemRQZNxOcJ04ucm6BRHqBbDI+Pu+m8tcbWgunXXIDtAz
   rW7o7YZIUSlhhLmoSmPuf61zMRoovSxDZIkoh2H0xKGxmxm269SMuuAzI
   Db1nd+rQC1lQ2OYDRfriC/pOeHzkd0MTu+RnhR85BbZTUaN7MXuWjMErs
   ln6vrzmv/X78djeN0WMeol2z5plbFW/cl82aknArxHoqXabTRFh25ywKj
   w8mr/1OhI81ANZfhS8Frp9bmlmWBfP2cTu7ilghDhx5yGsdndxMzvDC8M
   NUFUGRYO9+KmfAfstSJj+s6Wk/r4Mxr/iWXkZbczzX5Kc/e3Xc5wpZopB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="342514458"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="342514458"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 15:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="827851498"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="827851498"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 22 May 2023 15:25:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 15:25:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 15:25:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 15:25:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 15:25:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJtkIqOXXFA2Fr1osSlM1PVdQqd5//IW42oY7c5ysa26UH3reRbEx5bqVE8prs4H1DlYfO8zY5nC9nXgoTJGc83LoFPkYhXb9Sz2QNKIwY12O6+ummLUOoI4bvLwCo/3V5ALG/nfK4NKe9n8N4qbjjYItaPOxwwde7iuMSOw6RWqkkc3FgYdMZa5guZYrNm4CxLAwQ2fxemzdZpb1i13AbUS6CAR8MLe304XXrEYZMgri4ygc9Su7pKjXbL1wViWPcbNYB1hfmmUQyA0uRWXgJZJoYlNytmlBPHelL8iyl13Bd2DxDA0BqBgcJyEXMA+WE7UO3OquL2kvUTllsp2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnpiNbjaQDtjlvEyZ0fWMRE8hBOhHstYXXFvOPpFLxU=;
 b=XLBqF/CpzKE6CM7CG4hKySRMQRNbS2QwmGUMd7WydTez6szrSzJmhyKQbuh32Rf2GQRHDSBVg6SfEw1Y67J2GrtclvtWyK+vuS9TAtnoV9z3mGKgspNFcU1MmdcgopAvQvdlZFG+9xkUcTGFPFdJjoU+iauC8eLqJGGl7cNvFhPUNBISo4kTJOpwE5jkjevSnWNM5BkT+fLCsHvyJImu9ITEEuFM7VbeYgcuRlnZi/VKMoK6llaEfmjR+vso8lOWKq9x6yvSvtJl+8mNwIAkDm/szx1RlLA66RE68LAP/1wPqU5cB/12fOaEff1w+NtMVirx+zHrbTP5Ma3rD0K4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6327.namprd11.prod.outlook.com (2603:10b6:8:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 22:25:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 22:25:28 +0000
Date:   Mon, 22 May 2023 15:25:26 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <lukas@wunner.de>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/4] acpi: Move common tables helper functions to
 common lib
Message-ID: <646bebd5ebaac_33fb3294df@dwillia2-xfh.jf.intel.com.notmuch>
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
 <168443478260.2966470.6881416930240756285.stgit@djiang5-mobl3>
 <646bdf21b9329_33fb329410@dwillia2-xfh.jf.intel.com.notmuch>
 <19907ea8-85bf-6e31-0798-ef8a1e4b842a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <19907ea8-85bf-6e31-0798-ef8a1e4b842a@intel.com>
X-ClientProxiedBy: SJ0PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: e546e065-8f14-4d3b-1f9d-08db5b137243
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33Xxdf8lA9zExe3BK34fJtDtqpeSOpTvrvYxPqui12LMuT7iUAdBGjV4/YfMrkW/vnHmUWSdCO4NpexYh5XDO7pIFdNl3Z8ToWrn/CxbMuINuzFx+e6XwaZ/GJYzIqxtl6h0ckTfUU+oVi1nEmhgJY92tIkaG+KYciLw0etZYzZwDpaNwtmK1bWDV0v0pOUGzQImysLO3dcjQQib20uO/jq+P8ulx+qTw+SsAm4BCIFiYKUPqWKnpz3ghmLCBZooVbklbSeV1LknL/gM/hsEg4/BO3SSQelODpZvp8JRvHj9zgpaRWPhyaIx4RVbFcAZd+P4r0D6pORYS3A+sLzdlhNj/FHQha3RkYKg3a+Fdv24oGeCdVFBqi9QRnzIfJvZ5wmCMOsvEgRx8oAJPJQ67RMeV+lHkH53qPzijb+aOH4g7sKy0OF4kjibLiF3TdZDs5J6nzXw9lepF4Nsv9RvvGt3FY+sXzkzksa+9Wf5IHFzBgLTOtKgend2o5JT3waU4Z+L5wdLqe5DY4uh7NQZkjzkfUIGR1zn/u8IA2I7tbjpl++12v4KKbOOFpIfwFiN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(8676002)(8936002)(5660300002)(83380400001)(9686003)(6512007)(186003)(6506007)(26005)(86362001)(53546011)(82960400001)(38100700002)(478600001)(41300700001)(4326008)(66476007)(6486002)(66946007)(66556008)(110136005)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VmSPQrFg704Dps1whfALlvXwnyXsrTtYw0o6ncS+NLd5bZfJ5Zp9oelJ0AXH?=
 =?us-ascii?Q?0jyF63dG0cqB280WmJsOYekFjTuMmiqk6Rd9h1xKbyIzyKKHosM4KHcoE4S+?=
 =?us-ascii?Q?2bYIJf5TXOARmqnsuAD5cv2i1XPQMyT43s8w8Q6KQMB8UCOB+jPrpiZqcK7c?=
 =?us-ascii?Q?55sb+gi5UaM5vvknhH81PW9RP2MwXMwA+JIF6KI13F9txVDdGuofDWBH9GaC?=
 =?us-ascii?Q?7SPRE0MpMhRrBbwg6eyO2h7ECKSXtzH6kL2ZI3RZzmVmXwNAKcNNUfYxuy+V?=
 =?us-ascii?Q?9RH2ABMKsdHuExv2MPEtzWM7/pP+PVX52wuEiHZ81OZ2+WRX+XQ9RO4qcPcq?=
 =?us-ascii?Q?LWNF9uowlHeolVP+jhSR5R1IVl1ytVWE9Gkji25v7lJwOSSnBjxZDQUyO1uH?=
 =?us-ascii?Q?CshCYb44Qto5WBzETbZ2R0emNaTX6ivH8zOdsfTIUsJ+F4VGYdX7rbAuRglf?=
 =?us-ascii?Q?ahV03h4A1mdCxJSQx92B+TLY9y6sv0ZuiIV+7Fqt9m+qYxg8Ex/6/eXyMTsq?=
 =?us-ascii?Q?6IP8UvukUp8pNG5UPAtFnpNflbmPiMJy+kIIl+0CVPWeLDh5q0M/Us/k+b1Q?=
 =?us-ascii?Q?PdSk/wneMveK5paAd6cakij0rkkZmQpBEaKKL1cPyNN5EhbBu5LnN1Az9hkw?=
 =?us-ascii?Q?5AZvEnGFTlf4hrgp219RlHdJGyZrMoukzjxtH3HwnZ/pOcF3xDS5MhOwPPKX?=
 =?us-ascii?Q?6UAe0t7xh3YKm0IF5ziKRiY2Rdy1f4xXJYmfA0ke2EzPGD6aqoLBsT+Zr3DG?=
 =?us-ascii?Q?P2f2taZEhCXPBai+q9ei9/L3PuiQVIKaqZnGBqZUnMs85GsAy5PV4MCwFi+M?=
 =?us-ascii?Q?DMwJeL0FLhrcfthHRbDW4uMsNG9oUvz/tHdhsNOAetvIO6pYqbn2EAvmlQsu?=
 =?us-ascii?Q?J9DooJyvGJoA9Sm0FphwF6rNt8MVXTNdI9rRlC4sYJ6v6GGRUK7xZTxlKNF8?=
 =?us-ascii?Q?zEMzwpAkiOw+oneGl7l6PZ69H0xT+5x4BMAh4uw0O2lzCQZhLF9YdPv5MiWS?=
 =?us-ascii?Q?rrWq0AQeBDqx+3Sckn7VBxUgiE/6gOrnzk0MS8BxgJMAYzc1/KDcBSHKxMdJ?=
 =?us-ascii?Q?dHT3ctj46kIfcNTy/nM+NPvRXga7TcPf/ulfJSLHZvlqpKwfEGqNvtzHZ84S?=
 =?us-ascii?Q?41Od3DHAGBtqHKyTe4Wv0YS9sycYSzkgSMdmIS0BYrHQVu0+QzNkJCo83UOF?=
 =?us-ascii?Q?lA3R4f0bEZYdzyIXIO72HWDntaUnoxgNjY6xOaw77++JZei2SIjVWcf44yDH?=
 =?us-ascii?Q?DAS2Q1HgbvWx9YUiEG32snRlGfwC+FuUxdtum9aWt0uo1xTmRFENE6/djvdy?=
 =?us-ascii?Q?vtKHAin3o5j1vdBXpLV40KO1slZKwJeQ0o1rcn0SFj40rq5dagifG8eGTpD/?=
 =?us-ascii?Q?tEHOa1T4p24TgAfPoKwDvWwwtaX2WZ9CQ6fdxVfDQ1oHS8zZ3EqMdrlBN1iC?=
 =?us-ascii?Q?58HGGGQna32sXuF18ttkg8VAPZi56ucxtxpk57VbKXpbDemudVnDKSQ0QCU5?=
 =?us-ascii?Q?CAn2vHD2Sk65ONkdeURnB1BDfC+Gu+LR91zNuU987pa2cG2KO8BGG+QPZZ4Y?=
 =?us-ascii?Q?Qrs88RtWjQrvoDdS3ozNuOFEY0eBvsn1i6dFlO2fg76+LoD3wrISNSQMrenJ?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e546e065-8f14-4d3b-1f9d-08db5b137243
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 22:25:28.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTudN0f/V3TKGBVNbELBa6fKyCT/wP8QyqthMXmHrRLyqpKsh5GmYvPYqJnNu8gJP71yB7BvcQMAZRNbXQ/3kEN8p6kRznK0LZe0g0E5GX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6327
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> 
> On 5/22/23 14:31, Dan Williams wrote:
> > Dave Jiang wrote:
> >> Some of the routines in ACPI tables.c can be shared with parsing CDAT.
> > s,ACPI tables.c,driver/acpi/tables.c,
> >
> >> However, CDAT is used by CXL and can exist on platforms that do not use
> >> ACPI.
> > Clarify that CDAT is not an ACPI table:
> >
> > CDAT is a device-provided data structure that is formatted similar to a
> > platform-provided ACPI table.
> >
> >> Split out the common routine from ACPI to accomodate platforms that
> >> do not support ACPI. The common routines can be built outside of ACPI if
> >> ACPI_TABLES_LIB is selected.
> > Might be just me but I get confused where this is indicating "ACPI" the
> > platform vs "CONFIG_ACPI" the code. How about just:
> >
> > Refactor the table parsing routines in driver/acpi/tables.c into helpers
> > that can be shared with the CXL driver even in the CONFIG_ACPI=n case.
> >
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >>   drivers/Makefile          |    2
> >>   drivers/acpi/Kconfig      |    4 +
> >>   drivers/acpi/Makefile     |    3 +
> >>   drivers/acpi/tables.c     |  173 ----------------------------------------
> >>   drivers/acpi/tables_lib.c |  194 +++++++++++++++++++++++++++++++++++++++++++++
> >>   include/linux/acpi.h      |   63 +++++++++------
> >>   6 files changed, 241 insertions(+), 198 deletions(-)
> >>   create mode 100644 drivers/acpi/tables_lib.c
> > Conversion looks ok to me. Even though the cover letter said "Hi Rafael,
> > Please consider these for 6.5 merge window" my expectation is to take
> > these through CXL with ACPI acks.
> 
> I thought you wanted Rafael to take the ACPI patches. But going to the 
> CXL tree works.

Ultimately up to Rafael. Either need a stable ACPI tree baseline to base
the CDAT work upon, or take this all through CXL.

> 
> >
> > One question below:
> >
> >> diff --git a/drivers/Makefile b/drivers/Makefile
> >> index 20b118dca999..1824797f7dfe 100644
> >> --- a/drivers/Makefile
> >> +++ b/drivers/Makefile
> >> @@ -31,7 +31,7 @@ obj-y				+= idle/
> >>   # IPMI must come before ACPI in order to provide IPMI opregion support
> >>   obj-y				+= char/ipmi/
> >>   
> >> -obj-$(CONFIG_ACPI)		+= acpi/
> >> +obj-y				+= acpi/
> >>   
> >>   # PnP must come after ACPI since it will eventually need to check if acpi
> >>   # was used and do nothing if so
> >> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> >> index ccbeab9500ec..ce74a20dc42f 100644
> >> --- a/drivers/acpi/Kconfig
> >> +++ b/drivers/acpi/Kconfig
> >> @@ -6,12 +6,16 @@
> >>   config ARCH_SUPPORTS_ACPI
> >>   	bool
> >>   
> >> +config ACPI_TABLES_LIB
> >> +	bool
> >> +
> >>   menuconfig ACPI
> >>   	bool "ACPI (Advanced Configuration and Power Interface) Support"
> >>   	depends on ARCH_SUPPORTS_ACPI
> >>   	select PNP
> >>   	select NLS
> >>   	select CRC32
> >> +	select ACPI_TABLES_LIB
> >>   	default y if X86
> >>   	help
> >>   	  Advanced Configuration and Power Interface (ACPI) support for
> >> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> >> index feb36c0b9446..4558e2876823 100644
> >> --- a/drivers/acpi/Makefile
> >> +++ b/drivers/acpi/Makefile
> >> @@ -13,6 +13,9 @@ tables.o: $(src)/../../include/$(CONFIG_ACPI_CUSTOM_DSDT_FILE) ;
> >>   
> >>   endif
> >>   
> >> +obj-$(CONFIG_ACPI_TABLES_LIB)	+= acpi_tables_lib.o
> >> +acpi_tables_lib-y := tables_lib.o
> > Why is a separate object name needed?
> 
> Not all code in tables.c will be shared. There are ACPI table parsing 
> specific code in tables.c that CXL does not care about. Or do you mean 
> just do
> 
> obj-$(CONFIG_ACPI_TABLES_LIB) += tables_lib.o

Yes, this.
