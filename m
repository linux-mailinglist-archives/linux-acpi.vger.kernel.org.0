Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A52F6ED93A
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Apr 2023 02:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjDYAM0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 20:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjDYAMX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 20:12:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329CD4C16;
        Mon, 24 Apr 2023 17:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682381541; x=1713917541;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vVPLN9oVgBJlVe1VKzpr9a2A2yRxvGqqb8Q8FFCl5Es=;
  b=Prevh8VuO+ezzc1TpGb0ICURD86iPQpGPLXY3fRm0DpYrHlTkQMSrYA4
   lIaij88ybeSzMbcgjuMOOPE+wtdpNYdVthqnKA2FPIrQLxxBsY8+TSTmD
   5ebOVEbptTzEV63EnLcuLDBQ8uW6cOh36WiJwo4dHXr5pyNr/tGFqiAfp
   QjdGgXLsgsuZ5KSUIj8EM2X/PpZkEM9cN1bGbtJOEw7SsmxQrmuOfiDia
   Mdz6LItpL2OlBQ0EDEbSv9OTI8JVdsD88noQMhLhgqIkdngefKp4qTkES
   wXZLKzXo0ROnogkSZI0e8cU++hxSePV9kh0P711rQtXCk7ujtzPYloXaF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="326212202"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="326212202"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 17:12:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="693273299"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="693273299"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 24 Apr 2023 17:12:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 17:12:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 17:12:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 17:12:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE3TuNkZc3XUCKBZcov5oGoK1KjewNYg1Xdfpoagyy+Bji6IB18rT5F6+xOb9ymvN5GKFfseNOxxn6qe/HBEDLvHn07gizS6xPm9CD+Hw4cAHpD5KDA4aXT699FhdC7afFsB+TVU4Z2D1pdaVdroPUXie94jOxvVBfiAn8w6wi+LVlv/ruC6vgxaa2hWjygVfOkkM1Lc7ROH7+BzyoR5MuEKz+E56GeaFBFriwUlE8V9yJWPhOxESUpj5Sflb1uxn0vpneF/aBM+kydbla0PyZGCqlRK6BGSxSVi3MsRvFIPsmo7cG433oIMJPx/gkM3QsyA4YvpZOL3hKH9iD5yng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCHMsIM5/BO79EQOHcHsAydK+k68Ku0crMVUl91BUwA=;
 b=QHW1gti//hUjv4GtDN3KTq+FLTVP/H1NVxsLy+74o/Hf7znsPAxPRX7YGk3p6hL6OX8+Adlw/eKsO1FtsbxeV6MZEMTBCB8JPkn7W9Nuri10DMGfjqyhY0fuRAjIYjNyzaAhvBQcG/1ae9GL4LGP+UtsVuBabj79y4yWUNweodNCjYtzrwZc/1fwwx9CluBVhVShKObN73uqUQ+kSTuJXUMlfszPX4cbIYWx6bP88CMWwJpWcuzWeGMVOdiWKR1tJYlhnX9hLTK/uEapkIZ3RqnZsOXSkqITYRNYkLCLNcPeEjCbpMJvmRJmi9+92b0Vw6EcaYiJlgG1S9DU7Ji2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5939.namprd11.prod.outlook.com (2603:10b6:a03:42e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Tue, 25 Apr
 2023 00:12:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Tue, 25 Apr 2023
 00:12:17 +0000
Date:   Mon, 24 Apr 2023 17:12:15 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v4 08/23] cxl: Add support for _DSM Function for
 retrieving QTG ID
Message-ID: <64471adeee017_1b6629473@dwillia2-xfh.jf.intel.com.notmuch>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193570968.1178687.16632681494857661844.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168193570968.1178687.16632681494857661844.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR05CA0180.namprd05.prod.outlook.com
 (2603:10b6:a03:339::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: be9a6817-282d-49f7-ab34-08db4521bab0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRHCg97D48XRD8xmAuUo0Utsi2ac/FJiH+HpAuHRsmDnhCKyW2JrSCEeo6QOVLgo6tQOnJubp11/LWQttmQ/+rcJYaOJ/EYHIfr/3813crXttyjWeJThjFLhOriqP3FbcbeSrMNhP5V6GBH71E52slZXJKV3wQMZiDPxeqdQeGhVqq23/IjwM78excX3MiSPAOcHquxm9SWIlNdMduQfu4BuqTx8NjsLzIFliOxOFoGx822fjkeUCSz8ws2jnAeRDJl/AtcFGjA4jxyNlV7vOoC5K48XnU2smyHao62ow1bVz4QbqFdxQlccX2bGupVJhvkO2Jp7nGMKgM+OxnZJ1RwdSnipDN41yy9rnQdOOXeSkNIxpeGhEr6r6BJvlO0zup+XOOiUj9FqTyJl8iiYRBA+9ZEO4NZ/pI6t5Obe5L4wBMDgbGJNnkxuUfC7tMliGmpaleB9EsctWAm3KOrUYv1Sb5Yw6wZivdXA7NWxRBKY8EyxdX0zvH9AAwN1zlyt4AJdbSXW6baeHtWxDbme4OzlhtLZGNkaph/X98F9DKf3b6UvXsUB/M6YZHtdz1kV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(83380400001)(478600001)(6486002)(6506007)(6512007)(9686003)(26005)(316002)(82960400001)(4326008)(186003)(66946007)(66556008)(66476007)(5660300002)(38100700002)(8936002)(2906002)(8676002)(41300700001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LzeEhPjYdAc9WBbBgtPpmAzhSiLcrpBp2/zFvygXubSo2OHia8TOB3OaqKZt?=
 =?us-ascii?Q?45J63aABAZA6IEK46PDDwqHqj5+H6bIOaPzv6oy5JWb/985qMFrbuyaMUhlf?=
 =?us-ascii?Q?Iifp/JEHtGOa7aTQFbfSBW14vHwM2HJk2aOMyPZs0gPBKrtdACndmPrUehwU?=
 =?us-ascii?Q?LGqcqQ4F8dWmtvIDYPl8NTy32gjMm7kcq97YCXZzhd/jhvAyWn4FMbbQTTSh?=
 =?us-ascii?Q?Tans4vIq0Mgxkg8noIzeHVfiJb0ZQ2NTeouw44yG2A+3TMWjXPfOdEecufdi?=
 =?us-ascii?Q?Utoc97BUWeYQZ97TUAXjSqtKNbuI21zXwc8SbDdFBAT3CmAm17TPvBjQLl/l?=
 =?us-ascii?Q?ZWYIZOspELeOF0vtOds7JuHr3gVMcMzYTJgucAOHtIZwu5pYchW7trYEsFLp?=
 =?us-ascii?Q?hNV2fhIL/kZIN48H3r/aK6K+YBDcJtSNwoeEKK+ii3Ps/zvVy5HC5Tk4aSb/?=
 =?us-ascii?Q?kpPPS4RpmLDwg8r7nl2JJcAbBJURcL9fSnjjFg6ncd14mPAjDF8sr3iQ8Zae?=
 =?us-ascii?Q?ahRdzt47jLlMXIoXUSQ6/ow4UE2vCjZpOEKbJ0UDgTsTeiNx8oTqcWKcAc2C?=
 =?us-ascii?Q?Qc+Wqvrmg5O576N7JbJtZaHyi2o76j5LJOFhCtJ32obJnG7i3dwne8EfXGkg?=
 =?us-ascii?Q?SdKQqCndgQGCrYeXmuWmrNw9etnigfTGQJN0kthAex8/jSKSkdK5PZxauugG?=
 =?us-ascii?Q?bFxh8u8KyoS8SbBgnfsQOhhU6dNO5oTCnkdkZlDwgs1OkjXzGhootR1h65D3?=
 =?us-ascii?Q?t8AQgXNB3bMhWQpF5uhwTnRCQMWlpbGHT1NGJ2vMzDEkuMO74unQew5t1gVj?=
 =?us-ascii?Q?pKGyjeKQMKFDDc2AxxUrL/si1eUeCYi4kNwRqGiAkQVaNmI55hGNq/8eaRt0?=
 =?us-ascii?Q?OeMEYEjdk0ueVFQNLZ4nOvavZVxf2DOsSaygX8Hcy3tohoanXeb1tJRBHeqH?=
 =?us-ascii?Q?9w9/9J35h/NeEBcCcpuXAMjjMA/vmApX1voH4F2owxHkoHFw++URwpvRY/yW?=
 =?us-ascii?Q?wwb1tAuY/vJFVDrpdzcgISfiPbJ6ZOWDORbTrt6kqLwa3BlqWkD4FZLnkY3P?=
 =?us-ascii?Q?7qQmUmLnk8TWlKtp/JjA4YGX4Jq5PQP/9n4srfM4DgVck/eTwLXnaSaMIw5K?=
 =?us-ascii?Q?h7NqvrsYpzxNc2HlRFSCWF1itRqsneaaScuAcT3CvXAf33LwVSuYcR8tU0Xk?=
 =?us-ascii?Q?R1ur3lKMMbL9ysNSBsbHLyt9lLNKJp8G4cYQm7fIBbZdiya9A2Wd8F0AZDB4?=
 =?us-ascii?Q?V7Qzfrh0KX6H/37H4qfrXIqGXgH2G/vg2pXwKX3xnEfw52H0G/71iD1Ao1QM?=
 =?us-ascii?Q?75e/SzOiUiFNvIzvwds2Gvzy8lLmBefyFY0K6P4yZ9kPMuC95q2+mBtfDtrK?=
 =?us-ascii?Q?m1v5KbXdOwdsFkgZ07OZ7qeECRVrPuopwAJ2dbFO5ojfrGwRkeLLL/uXzOVJ?=
 =?us-ascii?Q?wMeILJUuQXEdJc1Rx4kQ2m+Thz4lSqdgyaf0PTKdnGhQ1B2opZeQ+aDZOmMq?=
 =?us-ascii?Q?ruaxZYwXbPUnOEepAvXdX8WvYEt4bUEmSkNZ1UEz2mxuO7hnx1BGGrX9vKYU?=
 =?us-ascii?Q?G0nSx0Q7obo59N9eb+w1Y0Cf7hj1+TTkYkcopKikHFeYTFQzznQ9cpK9R/6F?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be9a6817-282d-49f7-ab34-08db4521bab0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 00:12:17.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ST53vLQJJRnphC0643f8a1/LmGqmPnJAg07AIEP4T9CY+PaMi6hlJLmuoPuV7Sm/2wwnlsX5vY5pplT3uR86WI52fe8P3xtqFaQHDgd3D4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5939
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> CXL spec v3.0 9.17.3 CXL Root Device Specific Methods (_DSM)
> 
> Add support to retrieve QTG ID via ACPI _DSM call. The _DSM call requires
> an input of an ACPI package with 4 dwords (read latency, write latency,
> read bandwidth, write bandwidth). The call returns a package with 1 WORD
> that provides the max supported QTG ID and a package that may contain 0 or
> more WORDs as the recommended QTG IDs in the recommended order.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v2:
> - Reorder var declaration and use C99 style. (Jonathan)
> - Allow >2 ACPI objects in package for future expansion. (Jonathan)
> - Check QTG IDs against MAX QTG ID provided by output package. (Jonathan)
> ---
>  drivers/cxl/core/Makefile |    1 
>  drivers/cxl/core/acpi.c   |  116 +++++++++++++++++++++++++++++++++++++++++++++

Why a new core file? This seems something that only drivers/cxl/acpi.c
could ever care about.

Similar to the @calc_hb callback for root decoders this is another
platform specific callback that the endpoint drivers need not care that
it is an ACPI platform or not. They just ask their 'root' cxl_port
implementation for a qos_class and whether that is ACPI or not is
hidden.

>  drivers/cxl/cxl.h         |   16 ++++++
>  3 files changed, 133 insertions(+)
>  create mode 100644 drivers/cxl/core/acpi.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 867a8014b462..30d61c8cae22 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -13,5 +13,6 @@ cxl_core-y += mbox.o
>  cxl_core-y += pci.o
>  cxl_core-y += hdm.o
>  cxl_core-y += cdat.o
> +cxl_core-y += acpi.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
> new file mode 100644
> index 000000000000..6eda5cad8d59
> --- /dev/null
> +++ b/drivers/cxl/core/acpi.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/acpi.h>
> +#include <linux/pci.h>
> +#include <asm/div64.h>
> +#include "cxlpci.h"
> +#include "cxl.h"
> +
> +const guid_t acpi_cxl_qtg_id_guid =

static?

> +	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
> +		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
> +
> +/**
> + * cxl_acpi_evaluate_qtg_dsm - Retrieve QTG ids via ACPI _DSM
> + * @handle: ACPI handle
> + * @input: bandwidth and latency data
> + *
> + * Issue QTG _DSM with accompanied bandwidth and latency data in order to get
> + * the QTG IDs that falls within the performance data.
> + */
> +struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
> +						 struct qtg_dsm_input *input)
> +{
> +	union acpi_object *out_obj, *out_buf, *pkg;
> +	union acpi_object in_buf = {
> +		.buffer = {
> +			.type = ACPI_TYPE_BUFFER,
> +			.pointer = (u8 *)input,
> +			.length = sizeof(u32) * 4,
> +		},
> +	};
> +	union acpi_object in_obj = {
> +		.package = {
> +			.type = ACPI_TYPE_PACKAGE,
> +			.count = 1,
> +			.elements = &in_buf
> +		},
> +	};
> +	struct qtg_dsm_output *output = NULL;
> +	int len, rc, i;
> +	u16 *max_qtg;
> +
> +	out_obj = acpi_evaluate_dsm(handle, &acpi_cxl_qtg_id_guid, 1, 1, &in_obj);
> +	if (!out_obj)
> +		return ERR_PTR(-ENXIO);
> +
> +	if (out_obj->type != ACPI_TYPE_PACKAGE) {
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +
> +	/* Check Max QTG ID */
> +	pkg = &out_obj->package.elements[0];
> +	if (pkg->type != ACPI_TYPE_BUFFER) {
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +
> +	if (pkg->buffer.length != sizeof(u16)) {
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +	max_qtg = (u16 *)pkg->buffer.pointer;
> +
> +	/* Retrieve QTG IDs package */
> +	pkg = &out_obj->package.elements[1];
> +	if (pkg->type != ACPI_TYPE_PACKAGE) {
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +
> +	out_buf = &pkg->package.elements[0];
> +	if (out_buf->type != ACPI_TYPE_BUFFER) {
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +
> +	len = out_buf->buffer.length;
> +
> +	/* It's legal to have 0 QTG entries */
> +	if (len == 0)
> +		goto out;
> +
> +	/* Malformed package, not multiple of WORD size */
> +	if (len % sizeof(u16)) {
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
> +	output = kmalloc(len + sizeof(*output), GFP_KERNEL);

This feels more complicated than it needs to be. The only output from
this function that matters is a qos_class number for a given input. The
backup qtg-ids are not yet interesting without a real world example of
where selecting from the backup list vs any other id matters. In other
words the only recommendation is match or non-match. Whether a non-match
is in the backup list is still a platform-specific consideration that
Linux as of today has nothing to point to say that this distinction
matters.

That will be an end user call to their platform vendor to ask "there's
not enough capacity left in QoS class X what are the implications for
picking performance class Y", or "please increase capacity of the
window for QoS class X".

> +	if (!output) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	output->nr = len / sizeof(u16);
> +	memcpy(output->qtg_ids, out_buf->buffer.pointer, len);
> +
> +	for (i = 0; i < output->nr; i++) {
> +		if (output->qtg_ids[i] > *max_qtg)
> +			pr_warn("QTG ID %u greater than MAX %u\n",
> +				output->qtg_ids[i], *max_qtg);
> +	}
> +
> +out:
> +	ACPI_FREE(out_obj);
> +	return output;
> +
> +err:
> +	ACPI_FREE(out_obj);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_acpi_evaluate_qtg_dsm, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 318aa051f65a..6426c4c22e28 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -7,6 +7,7 @@
>  #include <linux/libnvdimm.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/acpi.h>
>  #include <linux/log2.h>
>  #include <linux/list.h>
>  #include <linux/io.h>
> @@ -793,6 +794,21 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
>  }
>  #endif
>  
> +struct qtg_dsm_input {
> +	u32 rd_lat;
> +	u32 wr_lat;
> +	u32 rd_bw;
> +	u32 wr_bw;
> +};
> +
> +struct qtg_dsm_output {
> +	int nr;
> +	u16 qtg_ids[];
> +};
> +
> +struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
> +						 struct qtg_dsm_input *input);
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> 
> 


