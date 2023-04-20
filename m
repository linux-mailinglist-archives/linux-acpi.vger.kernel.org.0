Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B06C6E8E07
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 11:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjDTJZ4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 05:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDTJZz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 05:25:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D3DEC;
        Thu, 20 Apr 2023 02:25:53 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2C0p2rT7z67L0F;
        Thu, 20 Apr 2023 17:24:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Apr
 2023 10:25:51 +0100
Date:   Thu, 20 Apr 2023 10:25:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v4 03/23] cxl: Add support for reading CXL switch CDAT
 table
Message-ID: <20230420102550.00000139@Huawei.com>
In-Reply-To: <168193567959.1178687.13133878561024203176.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
        <168193567959.1178687.13133878561024203176.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Wed, 19 Apr 2023 13:21:19 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Move read_cdat_data() from endpoint probe to general port probe to
> allow reading of CDAT data for CXL switches as well as CXL device.
> Add wrapper support for cxl_test to bypass the cdat reading.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

It might be worth a wrapper at somepoint for that dance
from port to the PCI device with the actual DOE etc.

Such a wrapp would provide somewhere to add a bit of
documentation on why the uport might be a platform device
(memX) or might be a PCI device thus explaining the two
different way it is handled.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> v4:
> - Remove cxl_test wrapper. (Ira)
> ---
>  drivers/cxl/core/pci.c |   20 +++++++++++++++-----
>  drivers/cxl/port.c     |    6 +++---
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9c7e2f69d9ca..1c415b26e866 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -546,16 +546,26 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>   */
>  void read_cdat_data(struct cxl_port *port)
>  {
> -	struct pci_doe_mb *cdat_doe;
> -	struct device *dev = &port->dev;
>  	struct device *uport = port->uport;
> -	struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct device *dev = &port->dev;
> +	struct cxl_dev_state *cxlds;
> +	struct pci_doe_mb *cdat_doe;
> +	struct cxl_memdev *cxlmd;
> +	struct pci_dev *pdev;
>  	size_t cdat_length;
>  	void *cdat_table;
>  	int rc;
>  
> +	if (is_cxl_memdev(uport)) {
> +		cxlmd = to_cxl_memdev(uport);
> +		cxlds = cxlmd->cxlds;          
> +		pdev = to_pci_dev(cxlds->dev); 
> +	} else if (dev_is_pci(uport)) {
> +		pdev = to_pci_dev(uport);
> +	} else {
> +		return;
> +	}
> +
>  	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
>  					CXL_DOE_PROTOCOL_TABLE_ACCESS);
>  	if (!cdat_doe) {
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 22a7ab2bae7c..615e0ef6b440 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -93,9 +93,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (IS_ERR(cxlhdm))
>  		return PTR_ERR(cxlhdm);
>  
> -	/* Cache the data early to ensure is_visible() works */
> -	read_cdat_data(port);
> -
>  	get_device(&cxlmd->dev);
>  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
>  	if (rc)
> @@ -135,6 +132,9 @@ static int cxl_port_probe(struct device *dev)
>  {
>  	struct cxl_port *port = to_cxl_port(dev);
>  
> +	/* Cache the data early to ensure is_visible() works */
> +	read_cdat_data(port);
> +
>  	if (is_cxl_endpoint(port))
>  		return cxl_endpoint_port_probe(port);
>  	return cxl_switch_port_probe(port);
> 
> 

