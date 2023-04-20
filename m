Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B556E9480
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 14:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbjDTMd3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 08:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjDTMdT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 08:33:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E8872A8;
        Thu, 20 Apr 2023 05:32:59 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2H6m6q6Vz6J79L;
        Thu, 20 Apr 2023 20:30:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Apr
 2023 13:32:57 +0100
Date:   Thu, 20 Apr 2023 13:32:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v4 12/23] cxl: Add helper function that calculate QoS
 values for PCI path
Message-ID: <20230420133256.00006cbd@Huawei.com>
In-Reply-To: <168193573330.1178687.2727689734216767954.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
        <168193573330.1178687.2727689734216767954.stgit@djiang5-mobl3>
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

On Wed, 19 Apr 2023 13:22:13 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Calculate the link bandwidth and latency for the PCIe path from the device
> to the CXL Host Bridge. This does not include the CDAT data from the device
> or the switch(es) in the path.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Same comment on _qos naming and one trivial comment inline.


> ---
> v4:
> - 0-day fix, remove unused var. Fix checking < 0 for unsigned var.
> - Rework port hierachy walk to calculate the latencies correctly
> ---
>  drivers/cxl/core/port.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |    2 +
>  2 files changed, 85 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 770b540d5325..8da437e038b9 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2002,6 +2002,89 @@ int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 *rd_lat,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_port_get_switch_qos, CXL);
>  
> +/**
> + * cxl_port_get_downstream_qos - retrieve QoS data for PCIE downstream path
> + * @port: endpoint cxl_port
> + * @bandwidth: writeback value for min bandwidth
> + * @latency: writeback value for total latency
> + *
> + * Return: Errno on failure, 0 on success.
> + */
> +int cxl_port_get_downstream_qos(struct cxl_port *port, u64 *bandwidth,
> +				u64 *latency)
> +{
> +	u64 min_bw = ULONG_MAX;
> +	struct pci_dev *pdev;
> +	struct cxl_port *p;
> +	struct device *dev;
> +	u64 total_lat = 0;
> +	long lat;
> +
> +	*bandwidth = 0;
> +	*latency = 0;
> +
> +	/* Grab the device that is the PCI device for CXL memdev */
> +	dev = port->uport->parent;
> +	/* Skip if it's not PCI, most likely a cxl_test device */
> +	if (!dev_is_pci(dev))
> +		return 0;
> +
> +	pdev = to_pci_dev(dev);
> +	min_bw = pcie_bandwidth_available(pdev, NULL, NULL, NULL);
> +	if (min_bw == 0)
> +		return -ENXIO;
> +
> +	/* convert to MB/s from Mb/s */
> +	min_bw >>= 3;

/ BITS_PER_BYTE; (well MEGABITS_PER_MEGABYTE but still better than >>= 3;)

> +
> +	/*
> +	 * Walk the cxl_port hierachy to retrieve the link latencies for
> +	 * each of the PCIe segments. The loop will obtain the link latency
> +	 * via each of the switch downstream port.
> +	 */
> +	p = port;
> +	do {
> +		struct cxl_dport *dport = p->parent_dport;
> +		struct device *dport_dev, *uport_dev;
> +		struct pci_dev *dport_pdev;
> +
> +		if (!dport)
> +			break;
> +
> +		dport_dev = dport->dport;
> +		if (!dev_is_pci(dport_dev))
> +			break;
> +
> +		p = dport->port;
> +		uport_dev = p->uport;
> +		if (!dev_is_pci(uport_dev))
> +			break;
> +
> +		dport_pdev = to_pci_dev(dport_dev);
> +		pdev = to_pci_dev(uport_dev);
> +		lat = cxl_pci_get_latency(dport_pdev);
> +		if (lat < 0)
> +			return lat;
> +
> +		total_lat += lat;
> +	} while (1);
> +
> +	/*
> +	 * pdev would be either the cxl device if there are no switches, or the
> +	 * upstream port of the last switch.
> +	 */
> +	lat = cxl_pci_get_latency(pdev);
> +	if (lat < 0)
> +		return lat;
> +
> +	total_lat += lat;
> +	*bandwidth = min_bw;
> +	*latency = total_lat;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_get_downstream_qos, CXL);
> +
>  /* for user tooling to ensure port disable work has completed */
>  static ssize_t flush_store(struct bus_type *bus, const char *buf, size_t count)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 76ccc815134f..6a6387a545db 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -811,6 +811,8 @@ struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
>  acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev);
>  int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 *rd_lat,
>  			    u64 *wr_bw, u64 *wr_lat);
> +int cxl_port_get_downstream_qos(struct cxl_port *port, u64 *bandwidth,
> +				u64 *latency);
>  
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
> 
> 

