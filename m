Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878F1700A41
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241337AbjELO0E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241124AbjELO0D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:26:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0ED2D7C;
        Fri, 12 May 2023 07:26:01 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHrdL69l3z67Xd4;
        Fri, 12 May 2023 22:25:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 15:25:59 +0100
Date:   Fri, 12 May 2023 15:25:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH 4/4] cxl: Add callback to parse the DSMAS subtables from
 CDAT
Message-ID: <20230512152558.00002a56@Huawei.com>
In-Reply-To: <168330799471.2042604.1887260521284311424.stgit@djiang5-mobl3>
References: <168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3>
        <168330799471.2042604.1887260521284311424.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 05 May 2023 10:33:14 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Provide a callback function to the CDAT parser in order to parse the Device
> Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
> DPA range and its associated attributes in each entry. See the CDAT
> specification for details. The device handle and the DPA range is saved and
> to be associated with the DSLBIS locality data when the DSLBIS entries are
> parsed. The list is a local list. When the total path performance data is
> calculated and storred this list can be discarded.
> 
> Coherent Device Attribute Table 1.03 2.1 Device Scoped memory Affinity
> Structure (DSMAS)
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
A few trivials inline.

I've pretty much forgotten this since I last looked, so it's more than
possible I disagree with what I may have said for previous versions.

Jonathan

> ---
> v5:
> - Update commit log to indicate what list is used for. (Jonathan, Dan)
> - Use acpi_table_parse_cdat()
> - Isolate cdat code behind CONFIG_ACPI
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
>  drivers/cxl/core/Makefile |    1 +
>  drivers/cxl/core/cdat.c   |   40 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   18 ++++++++++++++++++
>  drivers/cxl/port.c        |   22 ++++++++++++++++++++++
>  4 files changed, 81 insertions(+)
>  create mode 100644 drivers/cxl/core/cdat.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ca4ae31d8f57..98ddfd110f9b 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -12,5 +12,6 @@ cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
>  cxl_core-y += hdm.o
> +cxl_core-$(CONFIG_ACPI) += cdat.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> new file mode 100644
> index 000000000000..61979f0789aa
> --- /dev/null
> +++ b/drivers/cxl/core/cdat.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
> +#include <linux/acpi.h>
> +#include "cxlpci.h"
> +#include "cxl.h"
> +
> +static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
> +			      const unsigned long end)
> +{
> +	struct acpi_cdat_dsmas *dsmas = (struct acpi_cdat_dsmas *)header;

No functional change, but I'd rather see the &header->cdat 
cast than the union.  Makes it more obvious why this is fine.

> +	struct list_head *dsmas_list = arg;
> +	struct dsmas_entry *dent;
> +	u16 len;
> +
> +	len = le16_to_cpu((__force __le16)dsmas->header.length);
> +	if (len != sizeof(*dsmas) || (unsigned long)header + len > end) {
> +		pr_warn("Malformed DSMAS table length: (%lu:%u)\n",
> +			(unsigned long)sizeof(*dsmas), len);
> +		return -EINVAL;
> +	}
> +
> +	dent = kzalloc(sizeof(*dent), GFP_KERNEL);
> +	if (!dent)
> +		return -ENOMEM;
> +
> +	dent->handle = dsmas->dsmad_handle;
> +	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
> +	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
> +			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
> +	list_add_tail(&dent->list, dsmas_list);
> +
> +	return 0;
> +}
> +
> +int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list)
> +{
> +	return acpi_table_parse_cdat(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
> +				     list, port->cdat.table);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cdat_endpoint_process, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 4577d808ac6d..dda7238b47f5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -7,6 +7,7 @@
>  #include <linux/libnvdimm.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/list.h>
>  #include <linux/log2.h>
>  #include <linux/io.h>
>  
> @@ -791,6 +792,23 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
>  }
>  #endif
>  
> +/* CDAT related bits */
> +struct dsmas_entry {
> +	struct list_head list;
> +	struct range dpa_range;
> +	u8 handle;
> +};
> +
> +#ifdef CONFIG_ACPI
> +int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list);
> +#else
> +static inline int cxl_cdat_endpoint_process(struct cxl_port *port,
> +					    struct list_head *list)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index a49f5eb149f1..da023feaa6e2 100644
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

I'd rather see this alongside the code that created it in core/cdat.c
than in here.

> +
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -131,6 +141,18 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	device_for_each_child(&port->dev, root, discover_region);
>  	put_device(&root->dev);
>  
> +	if (port->cdat.table) {
> +		LIST_HEAD(dsmas_list);
> +
> +		rc = cxl_cdat_endpoint_process(port, &dsmas_list);
> +		if (rc < 0)
> +			dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
> +
> +		/* Performance data processing */
> +
> +		dsmas_list_destroy(&dsmas_list);
> +	}
> +
>  	return 0;
>  }
>  
> 
> 
> 

