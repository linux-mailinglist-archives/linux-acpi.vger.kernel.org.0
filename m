Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FF06E9407
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 14:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbjDTMPn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 08:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjDTMPk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 08:15:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BB38F;
        Thu, 20 Apr 2023 05:15:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2GmC1vBGz67ZkM;
        Thu, 20 Apr 2023 20:14:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Apr
 2023 13:15:12 +0100
Date:   Thu, 20 Apr 2023 13:15:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v4 10/23] cxl: Add helpers to calculate pci latency for
 the CXL device
Message-ID: <20230420131511.00001fc1@Huawei.com>
In-Reply-To: <168193572162.1178687.9726045601551945413.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
        <168193572162.1178687.9726045601551945413.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Wed, 19 Apr 2023 13:22:01 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The latency is calculated by dividing the flit size over the bandwidth. Add
> support to retrieve the flit size for the CXL device and calculate the
> latency of the downstream link.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Totally trivial stuff about using defines that exist for the various multipliers.
Otherwise looks good

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> v2:
> - Fix commit log issues. (Jonathan)
> - Fix var declaration issues. (Jonathan)
> ---
>  drivers/cxl/core/pci.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h   |   15 +++++++++++
>  drivers/cxl/pci.c      |   13 ---------
>  3 files changed, 83 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 1c415b26e866..bb58296b3e56 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c


> +static int cxl_pci_mbits_to_mbytes(struct pci_dev *pdev)
> +{
> +	int mbits;
> +
> +	mbits = pci_bus_speed_to_mbps(pdev->bus->cur_bus_speed);
> +	if (mbits < 0)
> +		return mbits;
> +
> +	return mbits >> 3;

mbits / BITS_PER_BYTE; from linux/bits.h

maybe.

> +}

> +/**
> + * cxl_pci_get_latency - calculate the link latency for the PCIe link
> + * @pdev - PCI device
> + *
> + * return: calculated latency or -errno
> + *
> + * CXL Memory Device SW Guide v1.0 2.11.4 Link latency calculation
> + * Link latency = LinkPropagationLatency + FlitLatency + RetimerLatency
> + * LinkProgationLatency is negligible, so 0 will be used
> + * RetimerLatency is assumed to be negligible and 0 will be used
> + * FlitLatency = FlitSize / LinkBandwidth
> + * FlitSize is defined by spec. CXL rev3.0 4.2.1.
> + * 68B flit is used up to 32GT/s. >32GT/s, 256B flit size is used.
> + * The FlitLatency is converted to picoseconds.
> + */
> +long cxl_pci_get_latency(struct pci_dev *pdev)
> +{
> +	long bw;
> +
> +	bw = cxl_pci_mbits_to_mbytes(pdev);
> +	if (bw < 0)
> +		return bw;
> +
> +	return cxl_flit_size(pdev) * 1000000L / bw;

MEGA from include/linux/units.h perhaps though it's an oddity because output of this is
pico seconds, so maybe needs to be PICO / MEGA to act as documentation of why.

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_get_latency, CXL);


