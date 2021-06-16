Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F92E3AA1B5
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 18:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhFPQqH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 12:46:07 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3257 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhFPQqH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 12:46:07 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G4rP54mvYz6K6NX;
        Thu, 17 Jun 2021 00:34:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 18:43:59 +0200
Received: from localhost (10.52.123.249) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 17:43:58 +0100
Date:   Wed, 16 Jun 2021 17:43:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] cxl/acpi: Use the ACPI CFMWS to create static
 decoder objects
Message-ID: <20210616174351.000023e6@Huawei.com>
In-Reply-To: <48f1b59105e46f04b38347fc1555bb5c8d654cff.1623800340.git.alison.schofield@intel.com>
References: <cover.1623800340.git.alison.schofield@intel.com>
        <48f1b59105e46f04b38347fc1555bb5c8d654cff.1623800340.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.249]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 15 Jun 2021 17:20:39 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> The ACPI CXL Early Discovery Table (CEDT) includes a list of CXL memory
> resources in CXL Fixed Memory Window Structures (CFMWS). Retrieve each
> CFMWS in the CEDT and add a cxl_decoder object to the root port (root0)
> for each memory resource.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index b6d9cd45428c..e3aa356d4dcd 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -8,8 +8,120 @@
>  #include <linux/pci.h>
>  #include "cxl.h"
>  
> +/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> +#define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
> +#define CFMWS_INTERLEAVE_GRANULARITY(x)	((x)->granularity + 8)
> +
>  static struct acpi_table_header *cedt_table;
>  
> +static unsigned long cfmws_to_decoder_flags(int restrictions)
> +{
> +	unsigned long flags = 0;
> +
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
> +		flags |= CXL_DECODER_F_TYPE2;
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
> +		flags |= CXL_DECODER_F_TYPE3;
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
> +		flags |= CXL_DECODER_F_RAM;
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM)
> +		flags |= CXL_DECODER_F_PMEM;
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
> +		flags |= CXL_DECODER_F_LOCK;
> +
> +	return flags;
> +}
> +
> +static int cxl_acpi_cfmws_verify(struct device *dev,
> +				 struct acpi_cedt_cfmws *cfmws)
> +{
> +	int expected_len;
> +
> +	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
> +		dev_err(dev, "CFMWS Unsupported Interleave Arithmetic\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!IS_ALIGNED(cfmws->base_hpa, SZ_256M)) {
> +		dev_err(dev, "CFMWS Base HPA not 256MB aligned\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!IS_ALIGNED(cfmws->window_size, SZ_256M)) {
> +		dev_err(dev, "CFMWS Window Size not 256MB aligned\n");
> +		return -EINVAL;
> +	}
> +
> +	expected_len = struct_size((cfmws), interleave_targets,
> +				   CFMWS_INTERLEAVE_WAYS(cfmws));
> +
> +	if (expected_len != cfmws->header.length) {
> +		dev_err(dev, "CFMWS interleave ways and targets mismatch\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cxl_add_cfmws_decoders(struct device *dev,
> +				   struct cxl_port *root_port)
> +{
> +	struct acpi_cedt_cfmws *cfmws;
> +	struct cxl_decoder *cxld;
> +	acpi_size len, cur = 0;
> +	void *cedt_base;
> +	int rc;
> +
> +	len = cedt_table->length - sizeof(*cedt_table);
> +	cedt_base = cedt_table + 1;
> +
> +	while (cur < len) {
> +		struct acpi_cedt_header *c = cedt_base + cur;
> +
> +		if (c->type != ACPI_CEDT_TYPE_CFMWS) {
> +			cur += c->length;
> +			continue;
> +		}
> +
> +		cfmws = cedt_base + cur;
> +
> +		if (cfmws->header.length < sizeof(*cfmws)) {
> +			dev_err(dev, "Invalid CFMWS header length %u\n",
> +				cfmws->header.length);
> +			dev_err(dev, "Failed to add decoders\n");
> +			return;
> +		}
> +
> +		rc = cxl_acpi_cfmws_verify(dev, cfmws);
> +		if (rc) {
> +			dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
> +				cfmws->base_hpa, cfmws->base_hpa +
> +				cfmws->window_size - 1);
> +			cur += c->length;
> +			continue;
> +		}
> +
> +		cxld = devm_cxl_add_decoder(dev, root_port,
> +				CFMWS_INTERLEAVE_WAYS(cfmws),
> +				cfmws->base_hpa, cfmws->window_size,
> +				CFMWS_INTERLEAVE_WAYS(cfmws),
> +				CFMWS_INTERLEAVE_GRANULARITY(cfmws),
> +				CXL_DECODER_EXPANDER,
> +				cfmws_to_decoder_flags(cfmws->restrictions));
> +
> +		if (IS_ERR(cxld)) {
> +			dev_err(dev, "Failed to add decoder for %#llx-%#llx\n",
> +				cfmws->base_hpa, cfmws->base_hpa +
> +				cfmws->window_size - 1);
> +		} else {
> +			dev_dbg(dev, "add: %s range %#llx-%#llx\n",
> +				dev_name(&cxld->dev), cfmws->base_hpa,
> +				 cfmws->base_hpa + cfmws->window_size - 1);
> +		}
> +		cur += c->length;
> +	}
> +}
> +
>  static struct acpi_cedt_chbs *cxl_acpi_match_chbs(struct device *dev, u32 uid)
>  {
>  	struct acpi_cedt_chbs *chbs, *chbs_match = NULL;
> @@ -251,6 +363,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	if (rc)
>  		goto out;
>  
> +	cxl_add_cfmws_decoders(host, root_port);
> +
>  	/*
>  	 * Root level scanned with host-bridge as dports, now scan host-bridges
>  	 * for their role as CXL uports to their CXL-capable PCIe Root Ports.

