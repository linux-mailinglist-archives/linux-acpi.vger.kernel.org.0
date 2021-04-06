Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C887D355AAB
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Apr 2021 19:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347067AbhDFRrP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 13:47:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2775 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347045AbhDFRrN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2021 13:47:13 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFFCn4ZK2z686vD;
        Wed,  7 Apr 2021 01:40:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 6 Apr 2021 19:47:03 +0200
Received: from localhost (10.47.87.56) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 6 Apr 2021
 18:47:03 +0100
Date:   Tue, 6 Apr 2021 18:00:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <ben.widawsky@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/8] cxl/mem: Introduce 'struct cxl_regs' for
 "composable" CXL devices
Message-ID: <20210406180037.00000474@Huawei.com>
In-Reply-To: <161728745324.2474040.14172040051810008737.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
        <161728745324.2474040.14172040051810008737.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Thu, 1 Apr 2021 07:30:53 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> CXL MMIO register blocks are organized by device type and capabilities.
> There are Component registers, Device registers (yes, an ambiguous
> name), and Memory Device registers (a specific extension of Device
> registers).
> 
> It is possible for a given device instance (endpoint or port) to
> implement register sets from multiple of the above categories.
> 
> The driver code that enumerates and maps the registers is type specific
> so it is useful to have a dedicated type and helpers for each block
> type.
> 
> At the same time, once the registers are mapped the origin type does not
> matter. It is overly pedantic to reference the register block type in
> code that is using the registers.
> 
> In preparation for the endpoint driver to incorporate Component registers
> into its MMIO operations reorganize the registers to allow typed
> enumeration + mapping, but anonymous usage. With the end state of
> 'struct cxl_regs' to be:
> 
> struct cxl_regs {
> 	union {
> 		struct {
> 			CXL_DEVICE_REGS();
> 		};
> 		struct cxl_device_regs device_regs;
> 	};
> 	union {
> 		struct {
> 			CXL_COMPONENT_REGS();
> 		};
> 		struct cxl_component_regs component_regs;
> 	};
> };
> 
> With this arrangement the driver can share component init code with
> ports, but when using the registers it can directly reference the
> component register block type by name without the 'component_regs'
> prefix.
> 
> So, map + enumerate can be shared across drivers of different CXL
> classes e.g.:
> 
> void cxl_setup_device_regs(struct device *dev, void __iomem *base,
> 			   struct cxl_device_regs *regs);
> 
> void cxl_setup_component_regs(struct device *dev, void __iomem *base,
> 			      struct cxl_component_regs *regs);
> 
> ...while inline usage in the driver need not indicate where the
> registers came from:
> 
> readl(cxlm->regs.mbox + MBOX_OFFSET);
> readl(cxlm->regs.hdm + HDM_OFFSET);
> 
> ...instead of:
> 
> readl(cxlm->regs.device_regs.mbox + MBOX_OFFSET);
> readl(cxlm->regs.component_regs.hdm + HDM_OFFSET);
> 
> This complexity of the definition in .h yields improvement in code
> readability in .c while maintaining type-safety for organization of
> setup code. It prepares the implementation to maintain organization in
> the face of CXL devices that compose register interfaces consisting of
> multiple types.
> 
> Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A few minor things inline.

> ---
>  drivers/cxl/cxl.h |   33 +++++++++++++++++++++++++++++++++
>  drivers/cxl/mem.c |   44 ++++++++++++++++++++++++--------------------
>  drivers/cxl/mem.h |   13 +++++--------
>  3 files changed, 62 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 2e3bdacb32e7..37325e504fb7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -34,5 +34,38 @@
>  #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>  
> +/* See note for 'struct cxl_regs' for the rationale of this organization */
> +#define CXL_DEVICE_REGS() \
> +	void __iomem *status; \
> +	void __iomem *mbox; \
> +	void __iomem *memdev
> +
> +/**
> + * struct cxl_device_regs - Common container of CXL Device register
> + * 			    block base pointers
> + * @status: CXL 2.0 8.2.8.3 Device Status Registers
> + * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
> + * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers

kernel-doc script is not going to be happy with documenting fields it can't see
+ not documenting the CXL_DEVICE_REGS() field it can.

I've no idea what the right way to handle this might be.

> + */
> +struct cxl_device_regs {
> +	CXL_DEVICE_REGS();
> +};
> +
> +/*
> + * Note, the anonymous union organization allows for per
> + * register-block-type helper routines, without requiring block-type
> + * agnostic code to include the prefix. I.e.
> + * cxl_setup_device_regs(&cxlm->regs.dev) vs readl(cxlm->regs.mbox).
> + * The specificity reads naturally from left-to-right.
> + */
> +struct cxl_regs {
> +	union {
> +		struct {
> +			CXL_DEVICE_REGS();
> +		};
> +		struct cxl_device_regs device_regs;
> +	};
> +};
> +
>  extern struct bus_type cxl_bus_type;
>  #endif /* __CXL_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 45871ef65152..6951243d128e 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -31,7 +31,7 @@
>   */
>  
>  #define cxl_doorbell_busy(cxlm)                                                \
> -	(readl((cxlm)->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET) &                  \
> +	(readl((cxlm)->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET) &                  \
>  	 CXLDEV_MBOX_CTRL_DOORBELL)
>  
>  /* CXL 2.0 - 8.2.8.4 */
> @@ -271,7 +271,7 @@ static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
>  static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
>  				   struct mbox_cmd *mbox_cmd)
>  {
> -	void __iomem *payload = cxlm->mbox_regs + CXLDEV_MBOX_PAYLOAD_OFFSET;
> +	void __iomem *payload = cxlm->regs.mbox + CXLDEV_MBOX_PAYLOAD_OFFSET;
>  	u64 cmd_reg, status_reg;
>  	size_t out_len;
>  	int rc;
> @@ -314,12 +314,12 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
>  	}
>  
>  	/* #2, #3 */
> -	writeq(cmd_reg, cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
> +	writeq(cmd_reg, cxlm->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
>  
>  	/* #4 */
>  	dev_dbg(&cxlm->pdev->dev, "Sending command\n");
>  	writel(CXLDEV_MBOX_CTRL_DOORBELL,
> -	       cxlm->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET);
> +	       cxlm->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
>  
>  	/* #5 */
>  	rc = cxl_mem_wait_for_doorbell(cxlm);
> @@ -329,7 +329,7 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
>  	}
>  
>  	/* #6 */
> -	status_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_STATUS_OFFSET);
> +	status_reg = readq(cxlm->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
>  	mbox_cmd->return_code =
>  		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
>  
> @@ -339,7 +339,7 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
>  	}
>  
>  	/* #7 */
> -	cmd_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
> +	cmd_reg = readq(cxlm->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
>  	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
>  
>  	/* #8 */
> @@ -400,7 +400,7 @@ static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
>  		goto out;
>  	}
>  
> -	md_status = readq(cxlm->memdev_regs + CXLMDEV_STATUS_OFFSET);
> +	md_status = readq(cxlm->regs.memdev + CXLMDEV_STATUS_OFFSET);
>  	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
>  		dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
>  		rc = -EBUSY;
> @@ -868,7 +868,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  	int cap, cap_count;
>  	u64 cap_array;
>  
> -	cap_array = readq(cxlm->regs + CXLDEV_CAP_ARRAY_OFFSET);
> +	cap_array = readq(cxlm->base + CXLDEV_CAP_ARRAY_OFFSET);
>  	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
>  	    CXLDEV_CAP_ARRAY_CAP_ID)
>  		return -ENODEV;
> @@ -881,25 +881,25 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  		u16 cap_id;
>  
>  		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
> -				   readl(cxlm->regs + cap * 0x10));
> -		offset = readl(cxlm->regs + cap * 0x10 + 0x4);
> -		register_block = cxlm->regs + offset;
> +				   readl(cxlm->base + cap * 0x10));
> +		offset = readl(cxlm->base + cap * 0x10 + 0x4);
> +		register_block = cxlm->base + offset;
>  
>  		switch (cap_id) {
>  		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>  			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
> -			cxlm->status_regs = register_block;
> +			cxlm->regs.status = register_block;
>  			break;
>  		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>  			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
> -			cxlm->mbox_regs = register_block;
> +			cxlm->regs.mbox = register_block;
>  			break;
>  		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>  			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_MEMDEV:
>  			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
> -			cxlm->memdev_regs = register_block;
> +			cxlm->regs.memdev = register_block;
>  			break;
>  		default:
>  			dev_dbg(dev, "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
> @@ -907,11 +907,11 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  		}
>  	}
>  
> -	if (!cxlm->status_regs || !cxlm->mbox_regs || !cxlm->memdev_regs) {
> +	if (!cxlm->regs.status || !cxlm->regs.mbox || !cxlm->regs.memdev) {
>  		dev_err(dev, "registers not found: %s%s%s\n",
> -			!cxlm->status_regs ? "status " : "",
> -			!cxlm->mbox_regs ? "mbox " : "",
> -			!cxlm->memdev_regs ? "memdev" : "");
> +			!cxlm->regs.status ? "status " : "",
> +			!cxlm->regs.mbox ? "mbox " : "",
> +			!cxlm->regs.memdev ? "memdev" : "");
>  		return -ENXIO;
>  	}
>  
> @@ -920,7 +920,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  
>  static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
>  {
> -	const int cap = readl(cxlm->mbox_regs + CXLDEV_MBOX_CAPS_OFFSET);
> +	const int cap = readl(cxlm->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
>  
>  	cxlm->payload_size =
>  		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
> @@ -980,7 +980,7 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
>  
>  	mutex_init(&cxlm->mbox_mutex);
>  	cxlm->pdev = pdev;
> -	cxlm->regs = regs + offset;
> +	cxlm->base = regs + offset;
>  	cxlm->enabled_cmds =
>  		devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
>  				   sizeof(unsigned long),
> @@ -1495,6 +1495,10 @@ static __init int cxl_mem_init(void)
>  	dev_t devt;
>  	int rc;
>  
> +	/* Double check the anonymous union trickery in struct cxl_regs */
> +	BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
> +		     offsetof(struct cxl_regs, device_regs.memdev));
> +
>  	rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
>  	if (rc)
>  		return rc;
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index daa9aba0e218..c247cf9c71af 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -53,10 +53,9 @@ struct cxl_memdev {
>  /**
>   * struct cxl_mem - A CXL memory device
>   * @pdev: The PCI device associated with this CXL device.
> - * @regs: IO mappings to the device's MMIO
> - * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
> - * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
> - * @memdev_regs: CXL 2.0 8.2.8.5 Memory Device Registers
> + * @base: IO mappings to the device's MMIO
> + * @cxlmd: Logical memory device chardev / interface

Unrelated missing docs fix?

> + * @regs: Parsed register blocks
>   * @payload_size: Size of space for payload
>   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
>   * @mbox_mutex: Mutex to synchronize mailbox access.
> @@ -67,12 +66,10 @@ struct cxl_memdev {
>   */
>  struct cxl_mem {
>  	struct pci_dev *pdev;
> -	void __iomem *regs;
> +	void __iomem *base;

Whilst I have no problem with the rename and fact you want to free it
up for other uses, perhaps call it out in the patch description?

>  	struct cxl_memdev *cxlmd;
>  
> -	void __iomem *status_regs;
> -	void __iomem *mbox_regs;
> -	void __iomem *memdev_regs;
> +	struct cxl_regs regs;
>  
>  	size_t payload_size;
>  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> 

