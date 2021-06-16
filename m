Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961793AA0FA
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 18:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhFPQP1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 12:15:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:45566 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232231AbhFPQP1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 12:15:27 -0400
IronPort-SDR: eq2kV3cKSVqfhWCRBtW7Q41BvUPBfIHve7kTjhhZg2s++TLUbuQl24OWWDoaM1/aKZKyzIC5rr
 6PVznQIspNgg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206165341"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="206165341"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 09:08:19 -0700
IronPort-SDR: dpI9sMRx7HXt1pcIXScj9EafgJBFF+0nMCxi5eMbtG7q7VoUt/DzQdri+ok+mgMLALokxFYSei
 WFZ6AAWIp0NQ==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="472080648"
Received: from mlnelson-mobl3.amr.corp.intel.com (HELO intel.com) ([10.252.143.181])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 09:08:19 -0700
Date:   Wed, 16 Jun 2021 09:08:16 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl/acpi: Add the Host Bridge base address to CXL
 port objects
Message-ID: <20210616160816.ollsqeyhpnjm5oq2@intel.com>
References: <cover.1623800340.git.alison.schofield@intel.com>
 <e841b0283edcc281ff31e98e4d3512be3a131c6a.1623800340.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e841b0283edcc281ff31e98e4d3512be3a131c6a.1623800340.git.alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21-06-15 17:20:38, Alison Schofield wrote:
> The base address for the Host Bridge port component registers is located
> in the CXL Host Bridge Structure (CHBS) of the ACPI CXL Early Discovery
> Table (CEDT). Retrieve the CHBS for each Host Bridge (ACPI0016 device)
> and include that base address in the port object.
> 
> Co-developed-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/acpi.c | 105 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 99 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index be357eea552c..b6d9cd45428c 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -8,6 +8,61 @@
>  #include <linux/pci.h>
>  #include "cxl.h"
>  
> +static struct acpi_table_header *cedt_table;

cedt_header would really be a better name. "Table" is redundant as the 't' in
CEDT is table.

> +
> +static struct acpi_cedt_chbs *cxl_acpi_match_chbs(struct device *dev, u32 uid)
> +{
> +	struct acpi_cedt_chbs *chbs, *chbs_match = NULL;
> +	acpi_size len, cur = 0;
> +	void *cedt_base;

maybe "cedt_body", or "cedt_subtables"

> +	int rc = 0;
> +
> +	len = cedt_table->length - sizeof(*cedt_table);
> +	cedt_base = cedt_table + 1;

As per naming recommendation above, this looks really funny...

> +
> +	while (cur < len) {
> +		struct acpi_cedt_header *c = cedt_base + cur;

Okay, now I see why you may have not called the previous thing a header.

> +
> +		if (c->type != ACPI_CEDT_TYPE_CHBS) {
> +			cur += c->length;
> +			continue;
> +		}
> +
> +		chbs = cedt_base + cur;
> +
> +		if (chbs->header.length < sizeof(*chbs)) {
> +			dev_err(dev, "Invalid CHBS header length: %u\n",
> +				chbs->header.length);
> +			rc = -EINVAL;
> +			break;
> +		}

I'd just continue here. Maybe there will be another chbs with the correct size.

> +
> +		if (chbs->uid == uid && !chbs_match) {
> +			chbs_match = chbs;
> +			cur += c->length;
> +			continue;
> +		}
> +
> +		if (chbs->uid == uid && chbs_match) {
> +			dev_err(dev, "Duplicate CHBS UIDs %u\n", uid);
> +			rc = -EINVAL;
> +			break;
> +		}

I'd also just continue here. I think if we have a match, we can just use it and
ignore BIOS bugs. I'd probably write it like this:

if (chbs->uid == uid) {
	dev_WARN_ONCE(dev, chbs_match, "Duplicate CHBS UIDs %u\n", uid);
	chbs_match = chbs; /* last one wins */
	cur += c->length;
	continue;
}

Up to you how you actually write it, but do consider not failing here.

> +		cur += c->length;
> +	}
> +	if (!chbs_match)
> +		rc = -EINVAL;

Maybe ENODEV or something like it is more appropriate?

> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	return chbs_match;
> +}
> +
> +static resource_size_t get_chbcr(struct acpi_cedt_chbs *chbs)
> +{
> +	return IS_ERR(chbs) ? CXL_RESOURCE_NONE : chbs->base;
> +}
> +
>  struct cxl_walk_context {
>  	struct device *dev;
>  	struct pci_bus *root;
> @@ -50,6 +105,21 @@ static int match_add_root_ports(struct pci_dev *pdev, void *data)
>  	return 0;
>  }
>  
> +static struct cxl_dport *find_dport_by_dev(struct cxl_port *port, struct device *dev)
> +{
> +	struct cxl_dport *dport;
> +
> +	device_lock(&port->dev);
> +	list_for_each_entry(dport, &port->dports, list)
> +		if (dport->dport == dev) {
> +			device_unlock(&port->dev);
> +			return dport;
> +		}
> +
> +	device_unlock(&port->dev);
> +	return NULL;
> +}
> +
>  static struct acpi_device *to_cxl_host_bridge(struct device *dev)
>  {
>  	struct acpi_device *adev = to_acpi_device(dev);
> @@ -71,6 +141,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	struct acpi_pci_root *pci_root;
>  	struct cxl_walk_context ctx;
>  	struct cxl_decoder *cxld;
> +	struct cxl_dport *dport;
>  	struct cxl_port *port;
>  
>  	if (!bridge)
> @@ -80,8 +151,15 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	if (!pci_root)
>  		return -ENXIO;
>  
> -	/* TODO: fold in CEDT.CHBS retrieval */
> -	port = devm_cxl_add_port(host, match, CXL_RESOURCE_NONE, root_port);
> +	dport = find_dport_by_dev(root_port, match);
> +	if (!dport) {
> +		dev_dbg(host, "host bridge expected and not found\n");
> +		return -ENODEV;
> +	}
> +
> +	port = devm_cxl_add_port(host, match, dport->component_reg_phys,
> +				 root_port);
> +
>  	if (IS_ERR(port))
>  		return PTR_ERR(port);
>  	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
> @@ -120,6 +198,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	int rc;
>  	acpi_status status;
>  	unsigned long long uid;
> +	struct acpi_cedt_chbs *chbs;
>  	struct cxl_port *root_port = arg;
>  	struct device *host = root_port->dev.parent;
>  	struct acpi_device *bridge = to_cxl_host_bridge(match);
> @@ -135,7 +214,12 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  		return -ENODEV;
>  	}
>  
> -	rc = cxl_add_dport(root_port, match, uid, CXL_RESOURCE_NONE);
> +	chbs = cxl_acpi_match_chbs(host, uid);
> +	if (IS_ERR(chbs))
> +		dev_dbg(host, "No CHBS found for Host Bridge: %s\n",
> +			dev_name(match));
> +
> +	rc = cxl_add_dport(root_port, match, uid, get_chbcr(chbs));
>  	if (rc) {
>  		dev_err(host, "failed to add downstream port: %s\n",
>  			dev_name(match));
> @@ -148,6 +232,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  static int cxl_acpi_probe(struct platform_device *pdev)
>  {
>  	int rc;
> +	acpi_status status;
>  	struct cxl_port *root_port;
>  	struct device *host = &pdev->dev;
>  	struct acpi_device *adev = ACPI_COMPANION(host);
> @@ -157,17 +242,25 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  		return PTR_ERR(root_port);
>  	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
>  
> +	status = acpi_get_table(ACPI_SIG_CEDT, 0, &cedt_table);
> +	if (ACPI_FAILURE(status))
> +		return -ENXIO;
> +
>  	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
>  			      add_host_bridge_dport);
>  	if (rc)
> -		return rc;
> +		goto out;
>  
>  	/*
>  	 * Root level scanned with host-bridge as dports, now scan host-bridges
>  	 * for their role as CXL uports to their CXL-capable PCIe Root Ports.
>  	 */
> -	return bus_for_each_dev(adev->dev.bus, NULL, root_port,
> -				add_host_bridge_uport);
> +	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
> +			      add_host_bridge_uport);
> +
> +out:
> +	acpi_put_table(cedt_table);
> +	return rc;
>  }
>  
>  static const struct acpi_device_id cxl_acpi_ids[] = {
> -- 
> 2.26.2
> 
