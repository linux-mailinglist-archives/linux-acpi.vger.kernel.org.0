Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42C51488BF
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2020 15:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392430AbgAXOaa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jan 2020 09:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391600AbgAXOaa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Jan 2020 09:30:30 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C91282087E;
        Fri, 24 Jan 2020 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579876229;
        bh=W7lO1ExyLYPgIMx2LKTvXUHRHNshfBAvIQPztWzFrz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Or6o+qCRfXnqaie334CYOTROdK1t2f0MxIVWNGb7hGvetDK61Nrjb47yCak+jMbvk
         DaYOThmKR5EDrjDwftABJj0mZC3sQcr+dPCGSSzjO/cHfr4QRotAEwdUWms777/0Vc
         Y/w+gtZmVJQDyEFUFo19dB7OzvccBdb//xqhY+Xg=
Date:   Fri, 24 Jan 2020 08:30:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        bp@alien8.de, james.morse@arm.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, zhangliguang@linux.alibaba.com,
        tglx@linutronix.de, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        yangyicong@hisilicon.com
Subject: Re: [PATCH v2 2/2] PCI: hip: Add handling of HiSilicon hip PCIe
 controller's errors
Message-ID: <20200124143027.GA5575@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124123938.16524-3-shiju.jose@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 24, 2020 at 12:39:38PM +0000, Shiju Jose wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The error handling driver logs and reports hip PCIe controller's
> recoverable errors.
> Perform root port reset and restore link status for the recovery.

If the preceding is two paragraphs, there should be a blank line
between them.  If it's a single paragraph, it should be rewrapped to
use the entire line width.

> Following are some of the PCIe controller's recoverable errors
> 1. completion transmission timeout error.
> 2. CRS retry counter over the threshold error.
> 3. ECC 2 bit errors
> 4. AXI bresponse/rresponse errors etc.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> --
>  drivers/pci/controller/Kconfig           |   8 +
>  drivers/pci/controller/Makefile          |   1 +
>  drivers/pci/controller/pcie-hisi-error.c | 336 +++++++++++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-hisi-error.c
> ---
>  drivers/pci/controller/Kconfig           |   8 +
>  drivers/pci/controller/Makefile          |   1 +
>  drivers/pci/controller/pcie-hisi-error.c | 336 +++++++++++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-hisi-error.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index c77069c..769fce7 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -260,6 +260,14 @@ config PCI_HYPERV_INTERFACE
>  	  The Hyper-V PCI Interface is a helper driver allows other drivers to
>  	  have a common interface with the Hyper-V PCI frontend driver.
>  
> +config PCIE_HISI_ERR
> +	depends on ARM64 || COMPILE_TEST
> +	depends on (ACPI && PCI_QUIRKS)

Why does this depend on PCI_QUIRKS?  If it's needed, please mention
the reason somewhere (maybe in the commit log, since there's not
really a good way to do it in Kconfig itself).

> +	bool "HiSilicon hip PCIe controller error handling driver"
> +	help
> +	  Say Y here if you want error handling support
> +	  for the PCIe controller's errors on HiSilicon hip SoCs

"hip" above refers to the hardware device and should be capitalized
(two occurrences above and at least two below).

>  source "drivers/pci/controller/dwc/Kconfig"
>  source "drivers/pci/controller/cadence/Kconfig"
>  endmenu
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index 3d4f597..2d1565f 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
>  obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
>  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
>  obj-$(CONFIG_VMD) += vmd.o
> +obj-$(CONFIG_PCIE_HISI_ERR) += pcie-hisi-error.o
>  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
>  obj-y				+= dwc/
>  
> diff --git a/drivers/pci/controller/pcie-hisi-error.c b/drivers/pci/controller/pcie-hisi-error.c
> new file mode 100644
> index 0000000..27520ad
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-hisi-error.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for handling the PCIe controller's errors on
> + * HiSilicon hip SoCs.
> + *
> + * Copyright (c) 2018-2019 HiSilicon Limited.
> + */
> +
> +#include <linux/acpi.h>
> +#include <acpi/ghes.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/list.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/kfifo.h>
> +#include <linux/spinlock.h>

Why do you need bitfield.h, bitops.h, irq.h, irqdomain.h, list.h,
resource.h?  You *do* need bits.h, which is included by at least
bitops.h.  But if you don't need bitops.h itself, include bits.h
directly instead.

> +
> +#include "../pci.h"
> +
> +#define HISI_PCIE_ERR_RECOVER_RING_SIZE           16
> +#define	HISI_PCIE_ERR_INFO_SIZE	1024
> +
> +/* HISI PCIe controller's error definitions */
> +#define HISI_PCIE_ERR_MISC_REGS	33
> +
> +#define HISI_PCIE_SUB_MODULE_ID_AP	0
> +#define HISI_PCIE_SUB_MODULE_ID_TL	1
> +#define HISI_PCIE_SUB_MODULE_ID_MAC	2
> +#define HISI_PCIE_SUB_MODULE_ID_DL	3
> +#define HISI_PCIE_SUB_MODULE_ID_SDI	4
> +
> +#define HISI_PCIE_LOCAL_VALID_VERSION		BIT(0)
> +#define HISI_PCIE_LOCAL_VALID_SOC_ID		BIT(1)
> +#define HISI_PCIE_LOCAL_VALID_SOCKET_ID		BIT(2)
> +#define HISI_PCIE_LOCAL_VALID_NIMBUS_ID		BIT(3)
> +#define HISI_PCIE_LOCAL_VALID_SUB_MODULE_ID	BIT(4)
> +#define HISI_PCIE_LOCAL_VALID_CORE_ID		BIT(5)
> +#define HISI_PCIE_LOCAL_VALID_PORT_ID		BIT(6)
> +#define HISI_PCIE_LOCAL_VALID_ERR_TYPE		BIT(7)
> +#define HISI_PCIE_LOCAL_VALID_ERR_SEVERITY	BIT(8)
> +#define HISI_PCIE_LOCAL_VALID_ERR_MISC		9
> +
> +#define HISI_ERR_SEV_RECOVERABLE	0
> +#define HISI_ERR_SEV_FATAL		1
> +#define HISI_ERR_SEV_CORRECTED		2
> +#define HISI_ERR_SEV_NONE		3
> +
> +guid_t hisi_pcie_sec_type = GUID_INIT(0xB2889FC9, 0xE7D7, 0x4F9D, 0xA8, 0x67,
> +				       0xAF, 0x42, 0xE9, 0x8B, 0xE7, 0x72);
> +
> +#define HISI_PCIE_CORE_ID(v)             ((v) >> 3)
> +#define HISI_PCIE_PORT_ID(core, v)       (((v) >> 1) + ((core) << 3))
> +#define HISI_PCIE_CORE_PORT_ID(v)        (((v) % 8) << 1)
> +
> +struct hisi_pcie_err_data {
> +	u64   val_bits;
> +	u8    version;
> +	u8    soc_id;
> +	u8    socket_id;
> +	u8    nimbus_id;
> +	u8    sub_module_id;
> +	u8    core_id;
> +	u8    port_id;
> +	u8    err_severity;
> +	u16   err_type;
> +	u8    reserv[2];
> +	u32   err_misc[HISI_PCIE_ERR_MISC_REGS];
> +};
> +
> +struct hisi_pcie_err_info {
> +	struct hisi_pcie_err_data err_data;
> +	struct platform_device *pdev;
> +};
> +
> +static char *hisi_pcie_sub_module_name(u8 id)
> +{
> +	switch (id) {
> +	case HISI_PCIE_SUB_MODULE_ID_AP: return "AP Layer";
> +	case HISI_PCIE_SUB_MODULE_ID_TL: return "TL Layer";
> +	case HISI_PCIE_SUB_MODULE_ID_MAC: return "MAC Layer";
> +	case HISI_PCIE_SUB_MODULE_ID_DL: return "DL Layer";
> +	case HISI_PCIE_SUB_MODULE_ID_SDI: return "SDI Layer";
> +	}
> +
> +	return "unknown";
> +}
> +
> +static char *hisi_pcie_err_severity(u8 err_sev)
> +{
> +	switch (err_sev) {
> +	case HISI_ERR_SEV_RECOVERABLE: return "recoverable";
> +	case HISI_ERR_SEV_FATAL: return "fatal";
> +	case HISI_ERR_SEV_CORRECTED: return "corrected";
> +	case HISI_ERR_SEV_NONE: return "none";
> +	}
> +
> +	return "unknown";
> +}
> +
> +static int hisi_pcie_port_reset(struct platform_device *pdev,
> +					u32 chip_id, u32 port_id)
> +{
> +	acpi_status s;
> +	union acpi_object arg[3];
> +	unsigned long long data = 0;
> +	struct device *dev = &pdev->dev;
> +	struct acpi_object_list arg_list;
> +	acpi_handle handle = ACPI_HANDLE(dev);

Order these as:

  struct device *dev = &pdev->dev;
  acpi_handle handle = ACPI_HANDLE(dev);
  union acpi_object arg[3];
  ...

so they're in order of use.

> +
> +	if (!handle) {
> +		dev_err(dev, "No Reset method\n");

Technically it's not the RST *method* that's missing; it's the entire
object that would *enclose* the RST method.  I guess that would be the
HISI0361 device?  Is it even possible for that to not exist, since
this driver binds to that device?

> +		return -EINVAL;
> +	}
> +
> +	arg[0].type = ACPI_TYPE_INTEGER;
> +	arg[0].integer.value = chip_id;
> +	arg[1].type = ACPI_TYPE_INTEGER;
> +	arg[1].integer.value = HISI_PCIE_CORE_ID(port_id);
> +	arg[2].type = ACPI_TYPE_INTEGER;
> +	arg[2].integer.value = HISI_PCIE_CORE_PORT_ID(port_id);
> +
> +	arg_list.count = 3;
> +	arg_list.pointer = arg;
> +
> +	/* Call the ACPI handle to reset root port  */

s/root port  /root port / (mentioned last time as well)
(Remove the extra space after "root port")

This isn't actually "calling the ACPI handle"; the handle is a
reference to the HISI0361 device, which *contains* the RST method.
You could just drop the comment altogether since it's pretty obvious
what's going on.

> +	s = acpi_evaluate_integer(handle, "RST", &arg_list, &data);
> +	if (ACPI_FAILURE(s)) {
> +		dev_err(dev, "No Reset method\n");

I think it'd be better to use the exact method name ("RST") in the
message.

> +		return -EIO;
> +	}
> +
> +	if (data) {
> +		dev_err(dev, "Failed to Reset\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hisi_pcie_port_do_recovery(struct platform_device *dev,
> +				      u32 chip_id, u32 port_id)
> +{
> +	u32 busnr, devfn;
> +	struct pci_dev *pdev;
> +	struct pci_bus *root_bus;
> +
> +	devfn = PCI_DEVFN(port_id, 0);
> +	if (device_property_read_u32(&dev->dev, "busnr", &busnr))
> +		goto failed;
> +
> +	pdev = pci_get_domain_bus_and_slot(0, busnr, devfn);
> +	if (!pdev)
> +		goto failed;
> +
> +	root_bus = pdev->bus;
> +
> +	pci_stop_and_remove_bus_device_locked(pdev);
> +	pci_dev_put(pdev);
> +
> +	if (hisi_pcie_port_reset(dev, chip_id, port_id))
> +		return -EIO;
> +
> +	/**
> +	 * In pci_reset_secondary_bus(), using 1s delay before subordinates
> +	 * devices to be re-initialized. Use the same delay here to ensure
> +	 * we can get all the devices after root port reset.

Use normal comment style (no "**").  Include the specific spec section
reference, e.g., PCIe r5.0, sec XXX.

> +	 **/
> +	ssleep(1UL);
> +
> +	/* add root port and downstream devices */
> +	pci_lock_rescan_remove();
> +	pci_rescan_bus(root_bus);
> +	pci_unlock_rescan_remove();
> +
> +	return 0;
> +
> +failed:
> +	dev_info(&(dev->dev), "Fail to get root port device\n");

For debugging purposes, include the address of the root port you tried
to find, e.g., ssss:bb:dd.f from segment, busnr, and devfn.

Since you're using ACPI, the segment number should not have to be
hard-coded; it should come from the host bridge's _SEG method.  I
don't know how you *find* that.  Is the HISI0361 device in the scope
of the PNP0A08 device, so you could just search up the chain?  You
need some way to associate this with the host bridge device.

> +	return -ENODEV;
> +}
> +
> +static void hisi_pcie_handle_one_error(const struct hisi_pcie_err_data *err,
> +				    struct platform_device *pdev)
> +{
> +	char buf[HISI_PCIE_ERR_INFO_SIZE];
> +	char *p = buf, *end = buf + sizeof(buf);
> +	struct device *dev = &pdev->dev;
> +	u32 i;
> +	int rc;
> +
> +	if (err->val_bits == 0) {
> +		dev_warn(dev, "%s: no valid error information\n", __func__);
> +		return;
> +	}
> +
> +	/* Logging */
> +	p += snprintf(p, end - p, "[ Table version=%d ", err->version);
> +	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOC_ID)
> +		p += snprintf(p, end - p, "SOC ID=%d ", err->soc_id);
> +
> +	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOCKET_ID)
> +		p += snprintf(p, end - p, "socket ID=%d ", err->socket_id);
> +
> +	if (err->val_bits & HISI_PCIE_LOCAL_VALID_NIMBUS_ID)
> +		p += snprintf(p, end - p, "nimbus ID=%d ", err->nimbus_id);
> +
> +	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SUB_MODULE_ID)
> +		p += snprintf(p, end - p, "sub module=%s ",
> +			      hisi_pcie_sub_module_name(err->sub_module_id));
> +
> +	if (err->val_bits & HISI_PCIE_LOCAL_VALID_CORE_ID)
> +		p += snprintf(p, end - p, "core ID=core%d ", err->core_id);
> +
> +	if (err->val_bits & HISI_PCIE_LOCAL_VALID_PORT_ID)
> +		p += snprintf(p, end - p, "port ID=port%d ", err->port_id);
> +
> +	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_SEVERITY)
> +		p += snprintf(p, end - p, "error severity=%s ",
> +			      hisi_pcie_err_severity(err->err_severity));
> +
> +	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_TYPE)
> +		p += snprintf(p, end - p, "error type=0x%x ", err->err_type);
> +
> +	p += snprintf(p, end - p, "]\n");
> +	dev_info(dev, "\nHISI : hip : PCIe controller's error\n");
> +	dev_info(dev, "%s\n", buf);
> +
> +	dev_info(dev, "Reg Dump:\n");
> +	for (i = 0; i < HISI_PCIE_ERR_MISC_REGS; i++) {
> +		if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))
> +			dev_info(dev,
> +				 "ERR_MISC_%d=0x%x\n", i, err->err_misc[i]);
> +	}
> +
> +	/* Recovery for the PCIe controller's errors */
> +	if (err->err_severity == HISI_ERR_SEV_RECOVERABLE) {
> +		/* try reset PCI port for the error recovery */
> +		rc = hisi_pcie_port_do_recovery(pdev, err->socket_id,
> +				HISI_PCIE_PORT_ID(err->core_id, err->port_id));
> +		if (rc) {
> +			dev_info(dev, "fail to do hisi pcie port reset\n");
> +			return;
> +		}
> +	}
> +}
> +
> +static DEFINE_KFIFO(hisi_pcie_err_recover_ring, struct hisi_pcie_err_info,
> +		    HISI_PCIE_ERR_RECOVER_RING_SIZE);
> +static DEFINE_SPINLOCK(hisi_pcie_err_recover_ring_lock);
> +
> +static void hisi_pcie_err_recover_work_func(struct work_struct *work)
> +{
> +	struct hisi_pcie_err_info pcie_err_entry;
> +
> +	while (kfifo_get(&hisi_pcie_err_recover_ring, &pcie_err_entry)) {
> +		hisi_pcie_handle_one_error(&pcie_err_entry.err_data,
> +					pcie_err_entry.pdev);
> +	}
> +}
> +
> +static DECLARE_WORK(hisi_pcie_err_recover_work,
> +		    hisi_pcie_err_recover_work_func);
> +
> +static int hisi_pcie_error_handle(struct acpi_hest_generic_data *gdata,
> +				  int sev, void *data)
> +{
> +	const struct hisi_pcie_err_data *err_data =
> +					acpi_hest_get_payload(gdata);
> +	struct hisi_pcie_err_info err_info;
> +	struct platform_device *pdev = data;
> +	struct device *dev = &pdev->dev;
> +	u8 socket;
> +
> +	if (device_property_read_u8(dev, "socket", &socket))
> +		return GHES_EVENT_NONE;
> +
> +	if (err_data->socket_id != socket)
> +		return GHES_EVENT_NONE;
> +
> +	memcpy(&err_info.err_data, err_data, sizeof(*err_data));
> +	err_info.pdev = pdev;
> +
> +	if (kfifo_in_spinlocked(&hisi_pcie_err_recover_ring, &err_info, 1,
> +				&hisi_pcie_err_recover_ring_lock))
> +		schedule_work(&hisi_pcie_err_recover_work);
> +	else
> +		dev_warn(dev, "queue full when recovering PCIe controller's error\n");
> +
> +	return GHES_EVENT_HANDLED;
> +}
> +
> +static int hisi_pcie_err_handler_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = ghes_register_event_handler(hisi_pcie_sec_type,
> +					  hisi_pcie_error_handle, pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s : ghes_register_event_handler fail\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hisi_pcie_err_handler_remove(struct platform_device *pdev)
> +{
> +	ghes_unregister_event_handler(hisi_pcie_sec_type, pdev);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id hisi_pcie_acpi_match[] = {
> +	{ "HISI0361", 0 },
> +	{ }
> +};
> +
> +static struct platform_driver hisi_pcie_err_handler_driver = {
> +	.driver = {
> +		.name	= "hisi-pcie-err-handler",
> +		.acpi_match_table = hisi_pcie_acpi_match,
> +	},
> +	.probe		= hisi_pcie_err_handler_probe,
> +	.remove		= hisi_pcie_err_handler_remove,
> +};
> +module_platform_driver(hisi_pcie_err_handler_driver);
> +
> +MODULE_DESCRIPTION("HiSilicon hip PCIe controller's error handling driver");
> +MODULE_LICENSE("GPL v2");
> +
> -- 
> 1.9.1
> 
> 
