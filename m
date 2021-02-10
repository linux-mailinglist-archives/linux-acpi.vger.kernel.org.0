Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C343169C8
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 16:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhBJPJr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 10:09:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2531 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhBJPJp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 10:09:45 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DbNNc26LJz67lvc;
        Wed, 10 Feb 2021 23:05:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 16:09:01 +0100
Received: from localhost (10.47.67.2) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Feb
 2021 15:09:00 +0000
Date:   Wed, 10 Feb 2021 15:07:59 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Chris Browy" <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Jon Masters" <jcm@jonmasters.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH v2 2/8] cxl/mem: Find device capabilities
Message-ID: <20210210150759.00005684@Huawei.com>
In-Reply-To: <20210210133252.000047af@Huawei.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
        <20210210000259.635748-3-ben.widawsky@intel.com>
        <20210210133252.000047af@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.67.2]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 10 Feb 2021 13:32:52 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 9 Feb 2021 16:02:53 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > Provide enough functionality to utilize the mailbox of a memory device.
> > The mailbox is used to interact with the firmware running on the memory
> > device. The flow is proven with one implemented command, "identify".
> > Because the class code has already told the driver this is a memory
> > device and the identify command is mandatory.
> > 
> > CXL devices contain an array of capabilities that describe the
> > interactions software can have with the device or firmware running on
> > the device. A CXL compliant device must implement the device status and
> > the mailbox capability. Additionally, a CXL compliant memory device must
> > implement the memory device capability. Each of the capabilities can
> > [will] provide an offset within the MMIO region for interacting with the
> > CXL device.
> > 
> > The capabilities tell the driver how to find and map the register space
> > for CXL Memory Devices. The registers are required to utilize the CXL
> > spec defined mailbox interface. The spec outlines two mailboxes, primary
> > and secondary. The secondary mailbox is earmarked for system firmware,
> > and not handled in this driver.
> > 
> > Primary mailboxes are capable of generating an interrupt when submitting
> > a background command. That implementation is saved for a later time.
> > 
> > Link: https://www.computeexpresslink.org/download-the-specification
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>  
> 
> Hi Ben,
> 
> 
> > +/**
> > + * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
> > + * @cxlm: The CXL memory device to communicate with.
> > + * @mbox_cmd: Command to send to the memory device.
> > + *
> > + * Context: Any context. Expects mbox_lock to be held.
> > + * Return: -ETIMEDOUT if timeout occurred waiting for completion. 0 on success.
> > + *         Caller should check the return code in @mbox_cmd to make sure it
> > + *         succeeded.  
> 
> cxl_xfer_log() doesn't check mbox_cmd->return_code and for my test it currently
> enters an infinite loop as a result.
> 
> I haven't checked other paths, but to my mind it is not a good idea to require
> two levels of error checking - the example here proves how easy it is to forget
> one.
> 
> Now all I have to do is figure out why I'm getting an error in the first place!

For reference this seems to be our old issue of arm64 memcpy_fromio() only doing 8 byte
or 1 byte copies.  The hack in QEMU to allow that to work, doesn't work.
Result is that 1 byte reads replicate across the register
(in this case instead of 0000001c I get 1c1c1c1c)

For these particular registers, we are covered by the rules in 8.2 which says that
a 1, 2, 4, 8 aligned reads of 64 bit registers etc are fine.

So we should not have to care.  This isn't true for the component registers where
we need to guarantee 4 or 8 byte reads only.

For this particular issue the mailbox_read_reg() function in the QEMU code
needs to handle the size 1 case and set min_access_size = 1 for
mailbox_ops.  Logically it should also handle the 2 byte case I think,
but I'm not hitting that.

Jonathan

> 
> Jonathan
> 
> 
> 
> > + *
> > + * This is a generic form of the CXL mailbox send command, thus the only I/O
> > + * operations used are cxl_read_mbox_reg(). Memory devices, and perhaps other
> > + * types of CXL devices may have further information available upon error
> > + * conditions.
> > + *
> > + * The CXL spec allows for up to two mailboxes. The intention is for the primary
> > + * mailbox to be OS controlled and the secondary mailbox to be used by system
> > + * firmware. This allows the OS and firmware to communicate with the device and
> > + * not need to coordinate with each other. The driver only uses the primary
> > + * mailbox.
> > + */
> > +static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> > +				 struct mbox_cmd *mbox_cmd)
> > +{
> > +	void __iomem *payload = cxlm->mbox_regs + CXLDEV_MBOX_PAYLOAD_OFFSET;
> > +	u64 cmd_reg, status_reg;
> > +	size_t out_len;
> > +	int rc;
> > +
> > +	lockdep_assert_held(&cxlm->mbox_mutex);
> > +
> > +	/*
> > +	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
> > +	 *   1. Caller reads MB Control Register to verify doorbell is clear
> > +	 *   2. Caller writes Command Register
> > +	 *   3. Caller writes Command Payload Registers if input payload is non-empty
> > +	 *   4. Caller writes MB Control Register to set doorbell
> > +	 *   5. Caller either polls for doorbell to be clear or waits for interrupt if configured
> > +	 *   6. Caller reads MB Status Register to fetch Return code
> > +	 *   7. If command successful, Caller reads Command Register to get Payload Length
> > +	 *   8. If output payload is non-empty, host reads Command Payload Registers
> > +	 *
> > +	 * Hardware is free to do whatever it wants before the doorbell is rung,
> > +	 * and isn't allowed to change anything after it clears the doorbell. As
> > +	 * such, steps 2 and 3 can happen in any order, and steps 6, 7, 8 can
> > +	 * also happen in any order (though some orders might not make sense).
> > +	 */
> > +
> > +	/* #1 */
> > +	if (cxl_doorbell_busy(cxlm)) {
> > +		dev_err_ratelimited(&cxlm->pdev->dev,
> > +				    "Mailbox re-busy after acquiring\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
> > +			     mbox_cmd->opcode);
> > +	if (mbox_cmd->size_in) {
> > +		if (WARN_ON(!mbox_cmd->payload_in))
> > +			return -EINVAL;
> > +
> > +		cmd_reg |= FIELD_PREP(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK,
> > +				      mbox_cmd->size_in);
> > +		memcpy_toio(payload, mbox_cmd->payload_in, mbox_cmd->size_in);
> > +	}
> > +
> > +	/* #2, #3 */
> > +	writeq(cmd_reg, cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
> > +
> > +	/* #4 */
> > +	dev_dbg(&cxlm->pdev->dev, "Sending command\n");
> > +	writel(CXLDEV_MBOX_CTRL_DOORBELL,
> > +	       cxlm->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET);
> > +
> > +	/* #5 */
> > +	rc = cxl_mem_wait_for_doorbell(cxlm);
> > +	if (rc == -ETIMEDOUT) {
> > +		cxl_mem_mbox_timeout(cxlm, mbox_cmd);
> > +		return rc;
> > +	}
> > +
> > +	/* #6 */
> > +	status_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_STATUS_OFFSET);
> > +	mbox_cmd->return_code =
> > +		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
> > +
> > +	if (mbox_cmd->return_code != 0) {
> > +		dev_dbg(&cxlm->pdev->dev, "Mailbox operation had an error\n");
> > +		return 0;  
> 
> I'd return some sort of error in this path.  Otherwise the sort of missing
> handling I mention above is too easy to hit.
> 
> > +	}
> > +
> > +	/* #7 */
> > +	cmd_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
> > +	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
> > +
> > +	/* #8 */
> > +	if (out_len && mbox_cmd->payload_out)
> > +		memcpy_fromio(mbox_cmd->payload_out, payload, out_len);
> > +
> > +	mbox_cmd->size_out = out_len;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * cxl_mem_mbox_get() - Acquire exclusive access to the mailbox.
> > + * @cxlm: The memory device to gain access to.
> > + *
> > + * Context: Any context. Takes the mbox_lock.
> > + * Return: 0 if exclusive access was acquired.
> > + */
> > +static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
> > +{
> > +	struct device *dev = &cxlm->pdev->dev;
> > +	int rc = -EBUSY;
> > +	u64 md_status;
> > +
> > +	mutex_lock_io(&cxlm->mbox_mutex);
> > +
> > +	/*
> > +	 * XXX: There is some amount of ambiguity in the 2.0 version of the spec
> > +	 * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
> > +	 * bit is to allow firmware running on the device to notify the driver
> > +	 * that it's ready to receive commands. It is unclear if the bit needs
> > +	 * to be read for each transaction mailbox, ie. the firmware can switch
> > +	 * it on and off as needed. Second, there is no defined timeout for
> > +	 * mailbox ready, like there is for the doorbell interface.
> > +	 *
> > +	 * Assumptions:
> > +	 * 1. The firmware might toggle the Mailbox Interface Ready bit, check
> > +	 *    it for every command.
> > +	 *
> > +	 * 2. If the doorbell is clear, the firmware should have first set the
> > +	 *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
> > +	 *    to be ready is sufficient.
> > +	 */
> > +	rc = cxl_mem_wait_for_doorbell(cxlm);
> > +	if (rc) {
> > +		dev_warn(dev, "Mailbox interface not ready\n");
> > +		goto out;
> > +	}
> > +
> > +	md_status = readq(cxlm->memdev_regs + CXLMDEV_STATUS_OFFSET);
> > +	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
> > +		dev_err(dev,
> > +			"mbox: reported doorbell ready, but not mbox ready\n");
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * Hardware shouldn't allow a ready status but also have failure bits
> > +	 * set. Spit out an error, this should be a bug report
> > +	 */
> > +	rc = -EFAULT;
> > +	if (md_status & CXLMDEV_DEV_FATAL) {
> > +		dev_err(dev, "mbox: reported ready, but fatal\n");
> > +		goto out;
> > +	}
> > +	if (md_status & CXLMDEV_FW_HALT) {
> > +		dev_err(dev, "mbox: reported ready, but halted\n");
> > +		goto out;
> > +	}
> > +	if (CXLMDEV_RESET_NEEDED(md_status)) {
> > +		dev_err(dev, "mbox: reported ready, but reset needed\n");
> > +		goto out;
> > +	}
> > +
> > +	/* with lock held */
> > +	return 0;
> > +
> > +out:
> > +	mutex_unlock(&cxlm->mbox_mutex);
> > +	return rc;
> > +}
> > +
> > +/**
> > + * cxl_mem_mbox_put() - Release exclusive access to the mailbox.
> > + * @cxlm: The CXL memory device to communicate with.
> > + *
> > + * Context: Any context. Expects mbox_lock to be held.
> > + */
> > +static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
> > +{
> > +	mutex_unlock(&cxlm->mbox_mutex);
> > +}
> > +
> > +/**
> > + * cxl_mem_setup_regs() - Setup necessary MMIO.
> > + * @cxlm: The CXL memory device to communicate with.
> > + *
> > + * Return: 0 if all necessary registers mapped.
> > + *
> > + * A memory device is required by spec to implement a certain set of MMIO
> > + * regions. The purpose of this function is to enumerate and map those
> > + * registers.
> > + */
> > +static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> > +{
> > +	struct device *dev = &cxlm->pdev->dev;
> > +	int cap, cap_count;
> > +	u64 cap_array;
> > +
> > +	cap_array = readq(cxlm->regs + CXLDEV_CAP_ARRAY_OFFSET);
> > +	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
> > +	    CXLDEV_CAP_ARRAY_CAP_ID)
> > +		return -ENODEV;
> > +
> > +	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
> > +
> > +	for (cap = 1; cap <= cap_count; cap++) {
> > +		void __iomem *register_block;
> > +		u32 offset;
> > +		u16 cap_id;
> > +
> > +		cap_id = readl(cxlm->regs + cap * 0x10) & 0xffff;
> > +		offset = readl(cxlm->regs + cap * 0x10 + 0x4);
> > +		register_block = cxlm->regs + offset;
> > +
> > +		switch (cap_id) {
> > +		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
> > +			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
> > +			cxlm->status_regs = register_block;
> > +			break;
> > +		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
> > +			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
> > +			cxlm->mbox_regs = register_block;
> > +			break;
> > +		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
> > +			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
> > +			break;
> > +		case CXLDEV_CAP_CAP_ID_MEMDEV:
> > +			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
> > +			cxlm->memdev_regs = register_block;
> > +			break;
> > +		default:
> > +			dev_dbg(dev, "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!cxlm->status_regs || !cxlm->mbox_regs || !cxlm->memdev_regs) {
> > +		dev_err(dev, "registers not found: %s%s%s\n",
> > +			!cxlm->status_regs ? "status " : "",
> > +			!cxlm->mbox_regs ? "mbox " : "",
> > +			!cxlm->memdev_regs ? "memdev" : "");
> > +		return -ENXIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > +{
> > +	const int cap = readl(cxlm->mbox_regs + CXLDEV_MBOX_CAPS_OFFSET);
> > +
> > +	cxlm->payload_size =
> > +		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
> > +
> > +	/*
> > +	 * CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register
> > +	 *
> > +	 * If the size is too small, mandatory commands will not work and so
> > +	 * there's no point in going forward. If the size is too large, there's
> > +	 * no harm is soft limiting it.
> > +	 */
> > +	cxlm->payload_size = min_t(size_t, cxlm->payload_size, SZ_1M);
> > +	if (cxlm->payload_size < 256) {
> > +		dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> > +			cxlm->payload_size);
> > +		return -ENXIO;
> > +	}
> > +
> > +	dev_dbg(&cxlm->pdev->dev, "Mailbox payload sized %zu",
> > +		cxlm->payload_size);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> > +				      u32 reg_hi)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct cxl_mem *cxlm;
> > +	void __iomem *regs;
> > +	u64 offset;
> > +	u8 bar;
> > +	int rc;
> > +
> > +	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
> > +	if (!cxlm) {
> > +		dev_err(dev, "No memory available\n");
> > +		return NULL;
> > +	}
> > +
> > +	offset = ((u64)reg_hi << 32) | FIELD_GET(CXL_REGLOC_ADDR_MASK, reg_lo);
> > +	bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> > +
> > +	/* Basic sanity check that BAR is big enough */
> > +	if (pci_resource_len(pdev, bar) < offset) {
> > +		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
> > +			&pdev->resource[bar], (unsigned long long)offset);
> > +		return NULL;
> > +	}
> > +
> > +	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
> > +	if (rc != 0) {
> > +		dev_err(dev, "failed to map registers\n");
> > +		return NULL;
> > +	}
> > +	regs = pcim_iomap_table(pdev)[bar];
> > +
> > +	mutex_init(&cxlm->mbox_mutex);
> > +	cxlm->pdev = pdev;
> > +	cxlm->regs = regs + offset;
> > +
> > +	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> > +	return cxlm;
> > +}
> >  
> >  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> >  {
> > @@ -28,10 +423,85 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> >  	return 0;
> >  }
> >  
> > +/**
> > + * cxl_mem_identify() - Send the IDENTIFY command to the device.
> > + * @cxlm: The device to identify.
> > + *
> > + * Return: 0 if identify was executed successfully.
> > + *
> > + * This will dispatch the identify command to the device and on success populate
> > + * structures to be exported to sysfs.
> > + */
> > +static int cxl_mem_identify(struct cxl_mem *cxlm)
> > +{
> > +	struct cxl_mbox_identify {
> > +		char fw_revision[0x10];
> > +		__le64 total_capacity;
> > +		__le64 volatile_capacity;
> > +		__le64 persistent_capacity;
> > +		__le64 partition_align;
> > +		__le16 info_event_log_size;
> > +		__le16 warning_event_log_size;
> > +		__le16 failure_event_log_size;
> > +		__le16 fatal_event_log_size;
> > +		__le32 lsa_size;
> > +		u8 poison_list_max_mer[3];
> > +		__le16 inject_poison_limit;
> > +		u8 poison_caps;
> > +		u8 qos_telemetry_caps;
> > +	} __packed id;
> > +	struct mbox_cmd mbox_cmd = {
> > +		.opcode = CXL_MBOX_OP_IDENTIFY,
> > +		.payload_out = &id,
> > +		.size_in = 0,
> > +	};
> > +	int rc;
> > +
> > +	/* Retrieve initial device memory map */
> > +	rc = cxl_mem_mbox_get(cxlm);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> > +	cxl_mem_mbox_put(cxlm);
> > +	if (rc)
> > +		return rc;
> > +
> > +	/* TODO: Handle retry or reset responses from firmware. */
> > +	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS) {
> > +		dev_err(&cxlm->pdev->dev, "Mailbox command failed (%d)\n",
> > +			mbox_cmd.return_code);
> > +		return -ENXIO;
> > +	}
> > +
> > +	if (mbox_cmd.size_out != sizeof(id))
> > +		return -ENXIO;
> > +
> > +	/*
> > +	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
> > +	 * For now, only the capacity is exported in sysfs
> > +	 */
> > +	cxlm->ram.range.start = 0;
> > +	cxlm->ram.range.end = le64_to_cpu(id.volatile_capacity) - 1;
> > +
> > +	cxlm->pmem.range.start = 0;
> > +	cxlm->pmem.range.end = le64_to_cpu(id.persistent_capacity) - 1;
> > +
> > +	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> > +
> > +	return rc;
> > +}
> > +
> >  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct device *dev = &pdev->dev;
> > -	int regloc;
> > +	struct cxl_mem *cxlm;
> > +	int rc, regloc, i;
> > +	u32 regloc_size;
> > +
> > +	rc = pcim_enable_device(pdev);
> > +	if (rc)
> > +		return rc;
> >  
> >  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
> >  	if (!regloc) {
> > @@ -39,7 +509,44 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  		return -ENXIO;
> >  	}
> >  
> > -	return 0;
> > +	/* Get the size of the Register Locator DVSEC */
> > +	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> > +	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> > +
> > +	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> > +
> > +	rc = -ENXIO;
> > +	for (i = regloc; i < regloc + regloc_size; i += 8) {
> > +		u32 reg_lo, reg_hi;
> > +		u8 reg_type;
> > +
> > +		/* "register low and high" contain other bits */
> > +		pci_read_config_dword(pdev, i, &reg_lo);
> > +		pci_read_config_dword(pdev, i + 4, &reg_hi);
> > +
> > +		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> > +
> > +		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> > +			rc = 0;
> > +			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> > +			if (!cxlm)
> > +				rc = -ENODEV;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = cxl_mem_setup_regs(cxlm);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = cxl_mem_setup_mailbox(cxlm);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return cxl_mem_identify(cxlm);
> >  }
> >  
> >  static const struct pci_device_id cxl_mem_pci_tbl[] = {
> > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > index f135b9f7bb21..ffcbc13d7b5b 100644
> > --- a/drivers/cxl/pci.h
> > +++ b/drivers/cxl/pci.h
> > @@ -14,5 +14,18 @@
> >  #define PCI_DVSEC_ID_CXL		0x0
> >  
> >  #define PCI_DVSEC_ID_CXL_REGLOC_OFFSET		0x8
> > +#define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
> > +
> > +/* BAR Indicator Register (BIR) */
> > +#define CXL_REGLOC_BIR_MASK GENMASK(2, 0)
> > +
> > +/* Register Block Identifier (RBI) */
> > +#define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
> > +#define CXL_REGLOC_RBI_EMPTY 0
> > +#define CXL_REGLOC_RBI_COMPONENT 1
> > +#define CXL_REGLOC_RBI_VIRT 2
> > +#define CXL_REGLOC_RBI_MEMDEV 3
> > +
> > +#define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
> >  
> >  #endif /* __CXL_PCI_H__ */
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index e709ae8235e7..6267ca9ae683 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -1080,6 +1080,7 @@
> >  
> >  /* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
> >  #define PCI_DVSEC_HEADER1		0x4 /* Designated Vendor-Specific Header1 */
> > +#define PCI_DVSEC_HEADER1_LENGTH_MASK	0xFFF00000
> >  #define PCI_DVSEC_HEADER2		0x8 /* Designated Vendor-Specific Header2 */
> >  
> >  /* Data Link Feature */  
> 

