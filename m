Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B0C355AA7
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Apr 2021 19:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347053AbhDFRrN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 13:47:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2774 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244858AbhDFRrM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2021 13:47:12 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFFCm4Yyrz686tp;
        Wed,  7 Apr 2021 01:40:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 6 Apr 2021 19:47:02 +0200
Received: from localhost (10.47.87.56) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 6 Apr 2021
 18:47:02 +0100
Date:   Tue, 6 Apr 2021 18:00:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <ben.widawsky@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] cxl/core: Refactor CXL register lookup for
 bridge reuse
Message-ID: <20210406180017.00000875@Huawei.com>
In-Reply-To: <161728746354.2474040.14531317270409827157.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
        <161728746354.2474040.14531317270409827157.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.56]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 1 Apr 2021 07:31:03 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> While CXL Memory Device endpoints locate the CXL MMIO registers in a PCI
> BAR, CXL root bridges have their MMIO base address described by platform
> firmware. Refactor the existing register lookup into a generic facility
> for endpoints and bridges to share.
> 
> Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Nice to make the docs kernel-doc, but otherwise this is simple and makes sense

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxl.h  |    3 +++
>  drivers/cxl/mem.c  |   50 +++++-----------------------------------------
>  3 files changed, 65 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index 7f8d2034038a..2ab467ef9909 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -1,7 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +/* Copyright(c) 2020-2021 Intel Corporation. All rights reserved. */
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include "cxl.h"
>  
>  /**
>   * DOC: cxl core
> @@ -10,6 +11,60 @@
>   * point for cross-device interleave coordination through cxl ports.
>   */
>  
> +/*
> + * cxl_setup_device_regs() - Detect CXL Device register blocks
> + * @dev: Host device of the @base mapping
> + * @base: mapping of CXL 2.0 8.2.8 CXL Device Register Interface

Not much to add to make this kernel-doc. Just the one missing parameter
and mark it /**  Given it's exported, it would be nice to tidy that up.


> + */
> +void cxl_setup_device_regs(struct device *dev, void __iomem *base,
> +			   struct cxl_device_regs *regs)
> +{
> +	int cap, cap_count;
> +	u64 cap_array;
> +
> +	*regs = (struct cxl_device_regs) { 0 };
> +
> +	cap_array = readq(base + CXLDEV_CAP_ARRAY_OFFSET);
> +	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
> +	    CXLDEV_CAP_ARRAY_CAP_ID)
> +		return;
> +
> +	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
> +
> +	for (cap = 1; cap <= cap_count; cap++) {
> +		void __iomem *register_block;
> +		u32 offset;
> +		u16 cap_id;
> +
> +		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
> +				   readl(base + cap * 0x10));
> +		offset = readl(base + cap * 0x10 + 0x4);
> +		register_block = base + offset;
> +
> +		switch (cap_id) {
> +		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
> +			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
> +			regs->status = register_block;
> +			break;
> +		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
> +			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
> +			regs->mbox = register_block;
> +			break;
> +		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
> +			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
> +			break;
> +		case CXLDEV_CAP_CAP_ID_MEMDEV:
> +			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
> +			regs->memdev = register_block;
> +			break;
> +		default:
> +			dev_dbg(dev, "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
> +			break;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(cxl_setup_device_regs);
> +
>  struct bus_type cxl_bus_type = {
>  	.name = "cxl",
>  };
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 37325e504fb7..cbd29650c4e2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -67,5 +67,8 @@ struct cxl_regs {
>  	};
>  };
>  
> +void cxl_setup_device_regs(struct device *dev, void __iomem *base,
> +			   struct cxl_device_regs *regs);
> +
>  extern struct bus_type cxl_bus_type;
>  #endif /* __CXL_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 6951243d128e..ee55abfa147e 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -865,53 +865,15 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode,
>  static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  {
>  	struct device *dev = &cxlm->pdev->dev;
> -	int cap, cap_count;
> -	u64 cap_array;
> +	struct cxl_regs *regs = &cxlm->regs;
>  
> -	cap_array = readq(cxlm->base + CXLDEV_CAP_ARRAY_OFFSET);
> -	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
> -	    CXLDEV_CAP_ARRAY_CAP_ID)
> -		return -ENODEV;
> -
> -	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
> -
> -	for (cap = 1; cap <= cap_count; cap++) {
> -		void __iomem *register_block;
> -		u32 offset;
> -		u16 cap_id;
> -
> -		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
> -				   readl(cxlm->base + cap * 0x10));
> -		offset = readl(cxlm->base + cap * 0x10 + 0x4);
> -		register_block = cxlm->base + offset;
> -
> -		switch (cap_id) {
> -		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
> -			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
> -			cxlm->regs.status = register_block;
> -			break;
> -		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
> -			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
> -			cxlm->regs.mbox = register_block;
> -			break;
> -		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
> -			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
> -			break;
> -		case CXLDEV_CAP_CAP_ID_MEMDEV:
> -			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
> -			cxlm->regs.memdev = register_block;
> -			break;
> -		default:
> -			dev_dbg(dev, "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
> -			break;
> -		}
> -	}
> +	cxl_setup_device_regs(dev, cxlm->base, &regs->device_regs);
>  
> -	if (!cxlm->regs.status || !cxlm->regs.mbox || !cxlm->regs.memdev) {
> +	if (!regs->status || !regs->mbox || !regs->memdev) {
>  		dev_err(dev, "registers not found: %s%s%s\n",
> -			!cxlm->regs.status ? "status " : "",
> -			!cxlm->regs.mbox ? "mbox " : "",
> -			!cxlm->regs.memdev ? "memdev" : "");
> +			!regs->status ? "status " : "",
> +			!regs->mbox ? "mbox " : "",
> +			!regs->memdev ? "memdev" : "");
>  		return -ENXIO;
>  	}
>  
> 

