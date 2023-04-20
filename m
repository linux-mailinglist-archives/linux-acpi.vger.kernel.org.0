Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980B26E8D65
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 11:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjDTJAu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 05:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjDTJAE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 05:00:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C173C05;
        Thu, 20 Apr 2023 01:56:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2BL65LXTz67lH6;
        Thu, 20 Apr 2023 16:54:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Apr
 2023 09:55:47 +0100
Date:   Thu, 20 Apr 2023 09:55:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v4 02/23] cxl: Add checksum verification to CDAT from
 CXL
Message-ID: <20230420095546.00005def@Huawei.com>
In-Reply-To: <168193567363.1178687.9185773070266307121.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
        <168193567363.1178687.9185773070266307121.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Wed, 19 Apr 2023 13:21:13 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> A CDAT table is available from a CXL device. The table is read by the
> driver and cached in software. With the CXL subsystem needing to parse the
> CDAT table, the checksum should be verified. Add checksum verification
> after the CDAT table is read from device.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> v3:
> - Just return the final sum. (Alison)
> v2:
> - Drop ACPI checksum export and just use local verification. (Dan)
> ---
>  drivers/cxl/core/pci.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 25b7e8125d5d..9c7e2f69d9ca 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -528,6 +528,16 @@ static int cxl_cdat_read_table(struct device *dev,
>  	return 0;
>  }
>  
> +static unsigned char cdat_checksum(void *buf, size_t size)
> +{
> +	unsigned char sum, *data = buf;
> +	size_t i;
> +
> +	for (sum = 0, i = 0; i < size; i++)
> +		sum += data[i];
> +	return sum;
> +}
> +
>  /**
>   * read_cdat_data - Read the CDAT data on this port
>   * @port: Port to read data from
> @@ -573,6 +583,12 @@ void read_cdat_data(struct cxl_port *port)
>  	}
>  
>  	port->cdat.table = cdat_table + sizeof(__le32);
> +	if (cdat_checksum(port->cdat.table, cdat_length)) {
> +		/* Don't leave table data allocated on error */
> +		devm_kfree(dev, cdat_table);
> +		dev_err(dev, "CDAT data checksum error\n");
> +	}
> +
>  	port->cdat.length = cdat_length;
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> 
> 

