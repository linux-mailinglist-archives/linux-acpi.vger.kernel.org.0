Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA653AB7D7
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhFQPsE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 11:48:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:28059 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233468AbhFQPsD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Jun 2021 11:48:03 -0400
IronPort-SDR: 6nXa9aKCOzrlXkHWXdPeNkFHMi3nkH/DN9TguQY++X05jPw9lshns4t/22hm9PKzbRpOUf6YHs
 qhUfQlOxr5BQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="204565833"
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="204565833"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 08:43:33 -0700
IronPort-SDR: cM++6v/5F8GNRQItj8P7rvTmxewnaKvYJz69NEzLtYBWlW7wpLk2kHbKj56G+DQ23ZzGyBM9kV
 gZhFug06MojA==
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="472449913"
Received: from mkalyani-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.138.30])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 08:43:32 -0700
Date:   Thu, 17 Jun 2021 08:43:29 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cxl/acpi: Use the ACPI CFMWS to create static
 decoder objects
Message-ID: <20210617154329.5dvwuktoiu72wi54@intel.com>
References: <cover.1623890468.git.alison.schofield@intel.com>
 <e6ed0f7d4859fb0d2369ed251ef2648a228c0d41.1623890468.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6ed0f7d4859fb0d2369ed251ef2648a228c0d41.1623890468.git.alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21-06-16 18:11:08, Alison Schofield wrote:
> The ACPI CXL Early Discovery Table (CEDT) includes a list of CXL memory
> resources in CXL Fixed Memory Window Structures (CFMWS). Retrieve each
> CFMWS in the CEDT and add a cxl_decoder object to the root port (root0)
> for each memory resource.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/acpi.c | 119 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 852b5c270464..018f5ac73b78 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -10,6 +10,123 @@
>  
>  static struct acpi_table_header *acpi_cedt;
>  
> +/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> +#define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
> +#define CFMWS_INTERLEAVE_GRANULARITY(x)	((x)->granularity + 8)
> +
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
> +	if (cfmws->header.length < expected_len) {
> +		dev_err(dev, "CFMWS length %d less than expected %d\n",
> +			cfmws->header.length, expected_len);
> +		return -EINVAL;
> +	}
> +
> +	if (cfmws->header.length > expected_len)
> +		dev_dbg(dev, "CFMWS length %d greater than expected %d\n",
> +			cfmws->header.length, expected_len);
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
> +	void *cedt_subtable;
> +	int rc;
> +
> +	len = acpi_cedt->length - sizeof(*acpi_cedt);
> +	cedt_subtable = acpi_cedt + 1;
> +
> +	while (cur < len) {
> +		struct acpi_cedt_header *c = cedt_subtable + cur;
> +
> +		if (c->type != ACPI_CEDT_TYPE_CFMWS) {
> +			cur += c->length;
> +			continue;
> +		}
> +
> +		cfmws = cedt_subtable + cur;
> +
> +		if (dev_WARN_ONCE(dev, cfmws->header.length < sizeof(*cfmws),
> +				  "CFMWS entry skipped: invalid length:%u\n",
> +				  cfmws->header.length)) {
> +			cur += c->length;
> +			continue;
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

checkpatch complains here for me.

CHECK: Alignment should match open parenthesis
#122: FILE: drivers/cxl/acpi.c:110:
+		cxld = devm_cxl_add_decoder(dev, root_port,
+				CFMWS_INTERLEAVE_WAYS(cfmws),


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
> @@ -271,6 +388,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	if (rc)
>  		goto out;
>  
> +	cxl_add_cfmws_decoders(host, root_port);
> +
>  	/*
>  	 * Root level scanned with host-bridge as dports, now scan host-bridges
>  	 * for their role as CXL uports to their CXL-capable PCIe Root Ports.
> -- 
> 2.26.2
> 
