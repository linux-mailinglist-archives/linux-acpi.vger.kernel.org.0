Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AEE3AAF31
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 10:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhFQI7s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 04:59:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3261 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhFQI7r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 04:59:47 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G5G3Y3s8fz6H6ks;
        Thu, 17 Jun 2021 16:50:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 10:57:38 +0200
Received: from localhost (10.52.126.9) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 17 Jun
 2021 09:57:37 +0100
Date:   Thu, 17 Jun 2021 09:57:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] cxl/acpi: Add the Host Bridge base address to
 CXL port objects
Message-ID: <20210617095730.00002e3c@Huawei.com>
In-Reply-To: <d9ea1d724dc30add7b6e320a876681644633f49b.1623890468.git.alison.schofield@intel.com>
References: <cover.1623890468.git.alison.schofield@intel.com>
        <d9ea1d724dc30add7b6e320a876681644633f49b.1623890468.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.9]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 16 Jun 2021 18:11:07 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> The base address for the Host Bridge port component registers is located
> in the CXL Host Bridge Structure (CHBS) of the ACPI CXL Early Discovery
> Table (CEDT). Retrieve the CHBS for each Host Bridge (ACPI0016 device)
> and include that base address in the port object.
> 
> Co-developed-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c | 98 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 93 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 8a723f7f3f73..852b5c270464 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -8,6 +8,58 @@
>  #include <linux/pci.h>
>  #include "cxl.h"
>  
> +static struct acpi_table_header *acpi_cedt;
> +
> +static struct acpi_cedt_chbs *cxl_acpi_match_chbs(struct device *dev, u32 uid)
> +{
> +	struct acpi_cedt_chbs *chbs, *chbs_match = NULL;
> +	acpi_size len, cur = 0;
> +	void *cedt_subtable;
> +
> +	len = acpi_cedt->length - sizeof(*acpi_cedt);
> +	cedt_subtable = acpi_cedt + 1;
> +
> +	while (cur < len) {
> +		struct acpi_cedt_header *c = cedt_subtable + cur;
> +
> +		if (c->type != ACPI_CEDT_TYPE_CHBS) {
> +			cur += c->length;
> +			continue;
> +		}
> +
> +		chbs = cedt_subtable + cur;
> +
> +		if (dev_WARN_ONCE(dev, chbs->header.length < sizeof(*chbs),
> +				  "CHBS entry skipped: invalid length:%u\n",
> +				  chbs->header.length)) {
> +			cur += c->length;
> +			continue;
> +		}
> +
> +		if (chbs->uid != uid) {
> +			cur += c->length;
> +			continue;
> +		}
> +
> +		if (dev_WARN_ONCE(dev, chbs_match,
> +				  "CHBS entry skipped: duplicate UID:%u\n",
> +				  uid)) {
> +			cur += c->length;
> +			continue;
> +		}
> +
> +		chbs_match = chbs;
> +		cur += c->length;
> +	}
> +
> +	return chbs_match ? chbs_match : ERR_PTR(-ENODEV);
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
> @@ -50,6 +102,21 @@ static int match_add_root_ports(struct pci_dev *pdev, void *data)
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
> @@ -71,6 +138,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	struct acpi_pci_root *pci_root;
>  	struct cxl_walk_context ctx;
>  	struct cxl_decoder *cxld;
> +	struct cxl_dport *dport;
>  	struct cxl_port *port;
>  
>  	if (!bridge)
> @@ -80,8 +148,14 @@ static int add_host_bridge_uport(struct device *match, void *arg)
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
>  	if (IS_ERR(port))
>  		return PTR_ERR(port);
>  	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
> @@ -120,6 +194,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	int rc;
>  	acpi_status status;
>  	unsigned long long uid;
> +	struct acpi_cedt_chbs *chbs;
>  	struct cxl_port *root_port = arg;
>  	struct device *host = root_port->dev.parent;
>  	struct acpi_device *bridge = to_cxl_host_bridge(match);
> @@ -135,7 +210,12 @@ static int add_host_bridge_dport(struct device *match, void *arg)
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
> @@ -172,6 +252,7 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
>  static int cxl_acpi_probe(struct platform_device *pdev)
>  {
>  	int rc;
> +	acpi_status status;
>  	struct cxl_port *root_port;
>  	struct device *host = &pdev->dev;
>  	struct acpi_device *adev = ACPI_COMPANION(host);
> @@ -181,10 +262,14 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  		return PTR_ERR(root_port);
>  	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
>  
> +	status = acpi_get_table(ACPI_SIG_CEDT, 0, &acpi_cedt);
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
> @@ -193,11 +278,14 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
>  			      add_host_bridge_uport);
>  	if (rc)
> -		return rc;
> +		goto out;
>  
>  	if (IS_ENABLED(CONFIG_CXL_PMEM))
>  		rc = device_for_each_child(&root_port->dev, root_port,
>  					   add_root_nvdimm_bridge);
> +
> +out:
> +	acpi_put_table(acpi_cedt);
>  	if (rc < 0)
>  		return rc;
>  	return 0;

