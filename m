Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C426ED812
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Apr 2023 00:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjDXWjP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 18:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDXWjO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 18:39:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1ED6A41;
        Mon, 24 Apr 2023 15:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682375953; x=1713911953;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=diW8llOK6GpX/LY3Bx4qINspuJeLTQkkG2Pn/6tNq88=;
  b=YT07nlGjrBtdP1Ywut+zRlzU90U25ptht2L6J4mR7fcMWreJgZ4WH1Ls
   6wphM9XSXaRh+yzyOdSh+9wiBVWRrkEnPgscR/J/OSYNLXnYWJceb5LI3
   DXmBOItC4411IRf4A8bEYhwIpIMQKhUOkN1i/qWIN1hl2Z7y0DXBnfoLd
   UBIFId+j4o6qeIXn3elHCRoMFM/6G07AvGmEMipWJjT33H6u2131yGI7z
   Fm0ufFTiNeUWoqScU/sR05fgeam+3fEIRzI7TCRiUwW0kIICv3nu/ta7n
   cGl+FE3VXOqKaYPxlsydpyJNlTCDfYXxQ39t55ztrXKtyRugIEcVfiGWy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="409518671"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="409518671"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 15:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="782585392"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="782585392"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Apr 2023 15:39:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 15:39:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 15:39:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 15:39:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjSsZgOvXNbOsKHLH/XYUhmPOhIb4983abhwUGgYpimgFuZ/czzJ+j6l+nYx1Nlu+AQNIKXfbtAUWmXbN48zIyTr1A9iLu22TpOMSfFjw0Zc23gCCVyDmGtlIgb18BjgITtHeWAZiLh14lXXrQMyVUGfe2Bpd/3eoy46FhOQxXoWuCiO3o9oP3Y59I2BJw3C5FZJBiinDdwEsGGg6zYW5bboT9rb2mbwxsw2KKrPkCMCHN0owZZTUmUb4lzip7Qq3erIGAicwt8b3X88BEz/PIq/TF14qYp3QOlIOeahiGzbJty1ZzxgZuoxlCxulgqRcCULY5z/emIpo4mP1YKJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oILiCcq/S6tpIBtCifFe91dwj7qYq5pznudGqqHYxAc=;
 b=b95sDovb3NhU/SpHQ4Ir1Jszd7GrHSKeUkIXKbZPL9hCC0cz/y79WkUhI3MatPAnH8022vcVRHzjv2B5fP1R83M3B8ewZ8uksuJ47lIbABUPPzwaXilbz9pJ9OQtelyurOJkJBSztGAKtDdsWcmQ9vq2C9PQX94rUFNH5UjPlWdHthHt0pAErdya6qYXosugSKnZu0QkcFXW6ZhZKueq4zH5nsvtG56/YZg4YnrjrTRaxVIb/4t/3/NN0tCHVRIrj+nl3hRXTfGS/7HZxCq7wAV/21GGjnyZK7stl/BWUi896IeSJ6YT89cf+u8UCNXXctKKEYOKDbnXJqsb3dv6jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8000.namprd11.prod.outlook.com (2603:10b6:8:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 22:38:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 22:38:57 +0000
Date:   Mon, 24 Apr 2023 15:38:53 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v4 05/23] cxl: Add callback to parse the DSMAS subtables
 from CDAT
Message-ID: <644704fdcad4d_1b66294a4@dwillia2-xfh.jf.intel.com.notmuch>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193569130.1178687.11664485128816659216.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168193569130.1178687.11664485128816659216.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 2391058b-69c7-4835-2e4b-08db4514b091
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gkfHb3kn5fGTOLfx/vtvHSUciqm5CfrkEikIjMVrm/p5Nbi7PD3aDfQTRh3uj5smsoaJl4HPHFPkd7qO4N92jPn9PSFqcc44CJzZD060cVX7BRvDNHM/MXu+R91m5NEHo73L7iPu3PWASTvMb/7ig26NaLYDEpnVUwN26zwLpec+K2v5jIybLJN1VIDFFLmL5O5ft6Le2F0rNODM5IU2ZAJ0RIkoq/kA/SwI0g+1qG5l3zMkU38+FMWudrc+qWhXB2xTm7nS1bX9nwk+DMJ8equTRX76yGnmi4geHNkLlYJbwp7EnwLGpBgtC+WZtPTh8zsXI4R77ImxDOK9hSvOlpoN844nlotcLwAvHlsCeZaoVf9gcTdiB4kxkr2mqL42loHKYH8REHSa+0BqX7FUpqnuYxQQ57mxCSY2CkpV/oPrpuC8I1M9/fER9z2nsz9ZlJadmACoiNAR4VBhzIf+kcsQlgTd55QuDGQKZnK4fcVIZDldcjiJHaN16llc+2Z9lo02WOUUIMl6H+GeidVrsw+weiFKobWXyTxRM5MGRqxVPjUufcf1XYuScdFYLPim
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(478600001)(86362001)(186003)(6486002)(26005)(9686003)(6512007)(6506007)(6666004)(4326008)(66476007)(66556008)(316002)(82960400001)(83380400001)(66946007)(2906002)(38100700002)(8676002)(41300700001)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1CvWzJW6rm6gG4WLIgKM7RwUANiUAfAAp8zGdNy+EmP+3HwYmOoZvFvXg7sK?=
 =?us-ascii?Q?XjZegma2a7v14BaQLt2jANfv3DzVP7aEj4OFleqW56BHdo5xzNvcMkXI7vPz?=
 =?us-ascii?Q?0qsxcYQN1imAjlajQKxN30hlDSJJ9Z+UUMtYVFlmrEbc9LLjNrhfcHFXhVkK?=
 =?us-ascii?Q?MkfrtJ3Y5UdGoCF4/UeZ40IdW1qBLCCiZKjQ7oocoL6p7jO+mOOiJgx42Y7t?=
 =?us-ascii?Q?VPnMnybzw8ZulHjK3NUBuqzz1Gf1AwRuGMCncxiEuRHq8Ktc1XlVyRT8AWuQ?=
 =?us-ascii?Q?V28rXVu6FOLLg8ozz8Z8lDoBPdjYnwfrAiF+JxWi5s+2lCoOvRoe4S4ZEF5s?=
 =?us-ascii?Q?gkUCD3d7e7ukIgMp7QbD2nTAbxrd7tlcnE7aggtMndtoV3mCnXIXBs7SZ4HM?=
 =?us-ascii?Q?I4e5o3dApr7q+PyCx0nz4ue6yPBQVWA0x1A8Ynghm2jdWT3dORnBtvt5CzjR?=
 =?us-ascii?Q?vt5HwfrIMEbfjDVDPnx3gBOPA4UnPDSBBXk4zq8Lz8MfZ7Mz++KzLLiUruum?=
 =?us-ascii?Q?2xgVeAquzWvH8ZnJLFHc7izUSrZh8GHcDiVLS5LAna72pNKseobN8FYtBR8l?=
 =?us-ascii?Q?WnabfliIHdhbnGm0tplrvAYHPuqazsUngrT+ZSQyDE09MuLzDAFHIz+Nz/cF?=
 =?us-ascii?Q?FFLaAGkiudyAMKueW2gsA7oFrCmbQueYhOXzTETKuyz1XfBggLz+zHguBmWg?=
 =?us-ascii?Q?KcBVnCp+s/qLOhMcEDOLbRCkeO2J3AtACPfn8GlpaeF5+tQ/WiQEgSX99diF?=
 =?us-ascii?Q?0sxc2oSgf4vxuG7qW6BuPIefjcKmEksi6uARrp0+LmuzqJ8F+8Tq9KJMlTfD?=
 =?us-ascii?Q?GXnL8tx98DnY2Pyyjw6HRz2GG4RJlziqaBuc7aTt/9XzIrFaDopwPT0C8aOV?=
 =?us-ascii?Q?2D82CBAdwVtbASJ1Ploy/TIsbi7fbB3TlLhL8syNeS+aD2W6O5weNIsrQZjN?=
 =?us-ascii?Q?Atqq/Yq/pnFlj7jmZuAzPZHi9acAPsMiqv7LU4YwFC5iuyZ3pi+z+ltVkJUi?=
 =?us-ascii?Q?dIQzl2HTbYPCElqLzeShQxCcpYdTcYxSTTRxwLyYHY84TL9ngxN0XtVHSXpd?=
 =?us-ascii?Q?wJwHbBJnrr6oc0Gw7SqeXbn5hWGDYT+ZtGuuIL46sSfoGzykjZ9NiZFAF3OE?=
 =?us-ascii?Q?lPfBQdS5Gk1FeWzszc0GXwB76VbGdm8oGDfOEVg5NMBkn8swd0AAmb9Rz/SQ?=
 =?us-ascii?Q?mPbpfj8wooRLpeKXyA4e0VOwrpXwZ347tezXfI/YDZNTjuqMXzWRyrJwmT9n?=
 =?us-ascii?Q?LriXOfeVMOA1tpbr+manJyuWCWbXvykHn3a2Exct2QT0+N8ELu6n2rDqlz2K?=
 =?us-ascii?Q?fKviNMdfs5M5xnA7xDO1mtxExvVgU4ANkk/3AusywBZRlwuxAiYnoiA8pjXO?=
 =?us-ascii?Q?9PNR7Sp1FN9GeXRKDUWqJRQG0DWFbNv0iIbFxegZfDB5QekRj04cLXq5NwIi?=
 =?us-ascii?Q?hmcAjXXSIHqwe8GNF9NMJkl83v4ugP3ejul08gJvHk3sj6Cm89obZ6IOI0VK?=
 =?us-ascii?Q?i8aCfjKvXDLECQKUdkO4e1UuiLTZxLgB+OFkDAaC7gq25KVnvxU88X3M3nuf?=
 =?us-ascii?Q?LuZX5qkxKp+nWoMVUMaSjKmQXUDWXyrIXGT0YOWKRL5mGvmxNGgm74AQNV+D?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2391058b-69c7-4835-2e4b-08db4514b091
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:38:57.0115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEfcxaRqew9oQy2wYjAOFg48OhKaY5YI5cPvWM56cU3yDQlfrEJdM/eZu3CBQypf1LPhHxn32W9FTrtRtueQEzpDkvxkLje1CQBwCY5Yqzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8000
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> Provide a callback function to the CDAT parser in order to parse the Device
> Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
> DPA range and its associated attributes in each entry. See the CDAT
> specification for details.
> 
> Coherent Device Attribute Table 1.03 2.1 Device Scoped memory Affinity
> Structure (DSMAS)
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v3:
> - Add spec section number. (Alison)
> - Remove cast from void *. (Alison)
> - Refactor cxl_port_probe() block. (Alison)
> - Move CDAT parse to cxl_endpoint_port_probe()
> 
> v2:
> - Add DSMAS table size check. (Lukas)
> - Use local DSMAS header for LE handling.
> - Remove dsmas lock. (Jonathan)
> - Fix handle size (Jonathan)
> - Add LE to host conversion for DSMAS address and length.
> - Make dsmas_list local
> ---
>  drivers/cxl/core/cdat.c |   26 ++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |    1 +
>  drivers/cxl/cxlpci.h    |   18 ++++++++++++++++++
>  drivers/cxl/port.c      |   22 ++++++++++++++++++++++
>  4 files changed, 67 insertions(+)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 210f4499bddb..6f20af83a3ed 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -98,3 +98,29 @@ int cdat_table_parse_sslbis(struct cdat_header *table,
>  	return cdat_table_parse_entries(CDAT_TYPE_SSLBIS, table, &proc);
>  }
>  EXPORT_SYMBOL_NS_GPL(cdat_table_parse_sslbis, CXL);
> +
> +int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg)
> +{
> +	struct cdat_dsmas *dsmas = (struct cdat_dsmas *)header;
> +	struct list_head *dsmas_list = arg;
> +	struct dsmas_entry *dent;
> +
> +	if (dsmas->hdr.length != sizeof(*dsmas)) {
> +		pr_warn("Malformed DSMAS table length: (%lu:%u)\n",
> +			 (unsigned long)sizeof(*dsmas), dsmas->hdr.length);
> +		return -EINVAL;
> +	}
> +
> +	dent = kzalloc(sizeof(*dent), GFP_KERNEL);
> +	if (!dent)
> +		return -ENOMEM;
> +
> +	dent->handle = dsmas->dsmad_handle;
> +	dent->dpa_range.start = le64_to_cpu(dsmas->dpa_base_address);
> +	dent->dpa_range.end = le64_to_cpu(dsmas->dpa_base_address) +
> +			      le64_to_cpu(dsmas->dpa_length) - 1;
> +	list_add_tail(&dent->list, dsmas_list);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dsmas_parse_entry, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 278ab6952332..18ca25c7e527 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -8,6 +8,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/log2.h>
> +#include <linux/list.h>
>  #include <linux/io.h>
>  
>  /**
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 45e2f2bf5ef8..9a2468a93d83 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -104,6 +104,22 @@ struct cdat_subtable_entry {
>  	enum cdat_type type;
>  };
>  
> +struct dsmas_entry {
> +	struct list_head list;
> +	struct range dpa_range;
> +	u8 handle;
> +};
> +
> +/* Sub-table 0: Device Scoped Memory Affinity Structure (DSMAS) */
> +struct cdat_dsmas {
> +	struct cdat_entry_header hdr;
> +	u8 dsmad_handle;
> +	u8 flags;
> +	__u16 reserved;
> +	__le64 dpa_base_address;
> +	__le64 dpa_length;
> +} __packed;
> +
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> @@ -119,4 +135,6 @@ int cdat_table_parse_##x(struct cdat_header *table, \
>  cdat_table_parse(dsmas);
>  cdat_table_parse(dslbis);
>  cdat_table_parse(sslbis);
> +
> +int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 615e0ef6b440..3022bdd52439 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -57,6 +57,16 @@ static int discover_region(struct device *dev, void *root)
>  	return 0;
>  }
>  
> +static void dsmas_list_destroy(struct list_head *dsmas_list)
> +{
> +	struct dsmas_entry *dentry, *n;
> +
> +	list_for_each_entry_safe(dentry, n, dsmas_list, list) {
> +		list_del(&dentry->list);
> +		kfree(dentry);
> +	}
> +}
> +
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -125,6 +135,18 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	device_for_each_child(&port->dev, root, discover_region);
>  	put_device(&root->dev);
>  
> +	if (port->cdat.table) {
> +		LIST_HEAD(dsmas_list);
> +
> +		rc = cdat_table_parse_dsmas(port->cdat.table,
> +					    cxl_dsmas_parse_entry,
> +					    (void *)&dsmas_list);
> +		if (rc < 0)
> +			dev_warn(&port->dev, "Failed to parse DSMAS: %d\n", rc);
> +
> +		dsmas_list_destroy(&dsmas_list);
> +	}
> +

Do these entries need to be cached in a list? For example all the table
walking in drivers/acpi/numa/srat.c injects the data directly into their
final kernel data structure location, it's all self contained in the
parse handler.
