Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D437A79D30D
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 16:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjILOAx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 12 Sep 2023 10:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjILOAw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 10:00:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FA310CE;
        Tue, 12 Sep 2023 07:00:48 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlQFr6Dbbz6FGWH;
        Tue, 12 Sep 2023 22:00:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 15:00:46 +0100
Date:   Tue, 12 Sep 2023 15:00:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Cheatham <Benjamin.Cheatham@amd.com>
CC:     <rafael@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <bhelgaas@google.com>, <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type
 support
Message-ID: <20230912150045.00004137@Huawei.com>
In-Reply-To: <20230907191956.674833-3-Benjamin.Cheatham@amd.com>
References: <20230907191956.674833-1-Benjamin.Cheatham@amd.com>
        <20230907191956.674833-3-Benjamin.Cheatham@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 7 Sep 2023 14:19:55 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add support for CXL EINJ error types for CXL 1.1 hosts added in ACPI
> v6.5. Because these error types target memory-mapped CXL 1.1 compliant
> downstream ports and not physical (normal/persistent) memory, these
> error types are not currently  allowed through the memory range
> validation done by the EINJ driver.
> 
> The MMIO address of a CXL 1.1 downstream port can be found in the
> cxl_rcrb_addr file in the corresponding dport directory under
> /sys/bus/cxl/devices/portX. CXL 1.1 error types follow the same
> procedure as a memory error type, but with param1 set to the
> downstream port MMIO address.
> 
> Example usage:
> $ cd /sys/kernel/debug/apei/einj
> $ cat available_error_type
>     0x00000008      Memory Correctable
>     0x00000010      Memory Uncorrectable non-fatal
>     0x00000020      Memory Uncorrectable fatal
>     0x00000040      PCI Express Correctable
>     0x00000080      PCI Express Uncorrectable non-fatal
>     0x00000100      PCI Express Uncorrectable fatal
>     0x00008000      CXL.mem Protocol Correctable
>     0x00020000      CXL.mem Protocol Uncorrectable fatal
> $ echo 0x8000 > error_type
> $ echo 0xfffffffffffff000 > param2
> $ echo 0x3 > flags

From einj.rst (and the ACPI spec) bit 0 here is
Processor APIC field valid.  Why is that relevant here?
If it were you'd be writing param3 I think.  So probably
harmless, but I think this should be 0x2 > flags

> $ cat /sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
> 0xb2f00000
> $ echo 0xb2f00000 > param1
> $ echo 1 > error_inject
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Hi Ben,

Why bother with the config dependent build?
It doesn't save that much in code built and right now there
are no non ACPI CXL systems so in reality it's always built
anyway.

Otherwise this LGTM


> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 001ab8742e21..f8f300496140 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1122,6 +1122,25 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_rch_dport, CXL);
>  
> +#if IS_ENABLED(CONFIG_CXL_ACPI)
I'm not a particular fan processor magic down in c files.

Do we really care about the saving of not having this in builds where
CONFIG_CXL_ACPI isn't set?  I'm thinking those don't really exist.

> +struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base)
> +{
> +	struct cxl_dport *dport;
> +	unsigned long index;
> +
> +	if (!cxl_root)
> +		return ERR_PTR(-ENODEV);
> +
> +	xa_for_each(&cxl_root->dports, index, dport)
> +		if ((dport->rch && dport->rcrb.base != CXL_RESOURCE_NONE)
> +		    && dport->rcrb.base == rcrb_base)
> +			return dport;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_find_rch_dport_by_rcrb, CXL);
> +#endif
> +
>  static int add_ep(struct cxl_ep *new)
>  {
>  	struct cxl_port *port = new->dport->port;

