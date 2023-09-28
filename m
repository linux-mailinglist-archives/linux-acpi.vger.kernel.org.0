Return-Path: <linux-acpi+bounces-269-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78127B228D
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 18:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7CCF7280EA1
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6368B4D8F7
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 16:36:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA9F374D9
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 15:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB5AC433C8;
	Thu, 28 Sep 2023 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695916043;
	bh=iTnK8MDxmUCeM4LcH0nqfhMZ7LIf0bhet+kiDxHGJ3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b2Evauya60MUt1BnMeTMp61oNJd4o7AdO1h8ZgUJELHM+cgwJf0E9nhieyEWwfTGy
	 BRISVJ+aYiyMZ2VvFxEviV4LW/eAXu4TmWg8utTen0Vmw36vaph59cSE1RgM6TupMF
	 3fJVBW9Q1gVWBG/KXNBMSGUTUrGkgNnZ9QNBC2Uu5hEXymd3ABOiqw3gIwSos6YOMU
	 u1GQxY1qWnyVoQGeBIiSuwwwfCA4z1rRDCNXq9TzUWdETOaRja3Bdft8qFQ1sJESu/
	 qAR0+aKf9Mq8A2/ysldfPwZLxrJ2XETTY5VGIXy2+5TdEX/qa89CfLnj5Ml1G4DUzA
	 sJvW+At03KTtQ==
Date: Thu, 28 Sep 2023 10:47:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: D Scott Phillips <scott@os.amperecomputing.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Darren Hart <darren@os.amperecomputing.com>,
	patches@amperecomputing.com
Subject: Re: [PATCH] PCI: hotplug: Add extension driver for Ampere Altra
 hotplug LED control
Message-ID: <20230928154720.GA462358@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927202347.2795170-1-scott@os.amperecomputing.com>

On Wed, Sep 27, 2023 at 01:23:47PM -0700, D Scott Phillips wrote:
> On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
> also present to request system firmware control of attention LEDs. Add an
> ACPI PCI Hotplug companion driver to support attention LED control.
> 
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> ---
>  drivers/pci/hotplug/Kconfig                |  13 ++
>  drivers/pci/hotplug/Makefile               |   3 +-
>  drivers/pci/hotplug/acpiphp_ampere_altra.c | 141 +++++++++++++++++++++
>  3 files changed, 156 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/hotplug/acpiphp_ampere_altra.c
> 
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index 48113b210cf93..9fde600a9ad3e 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -61,6 +61,19 @@ config HOTPLUG_PCI_ACPI
>  
>  	  When in doubt, say N.
>  
> +config HOTPLUG_PCI_ACPI_AMPERE_ALTRA
> +	tristate "ACPI PCI Hotplug driver Ampere Altra extensions"
> +	depends on HOTPLUG_PCI_ACPI
> +	depends on HAVE_ARM_SMCCC_DISCOVERY
> +	depends on m

Why is this restricted to being a module?  It's not unprecedented, but
unless this only works as a module for some reason, I would leave that
choice up to the user.

> +	help
> +	  Say Y here if you have an Ampere Altra system.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called acpiphp_ampere_altra.
> +
> +	  When in doubt, say N.
> +
>  config HOTPLUG_PCI_ACPI_IBM
>  	tristate "ACPI PCI Hotplug driver IBM extensions"
>  	depends on HOTPLUG_PCI_ACPI
> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
> index 5196983220df6..29d7f6171b305 100644
> --- a/drivers/pci/hotplug/Makefile
> +++ b/drivers/pci/hotplug/Makefile
> @@ -21,8 +21,9 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+= rpadlpar_io.o
>  obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
>  obj-$(CONFIG_HOTPLUG_PCI_S390)		+= s390_pci_hpc.o
>  
> -# acpiphp_ibm extends acpiphp, so should be linked afterwards.
> +# acpiphp_ibm extend acpiphp, so should be linked afterwards.
>  
> +obj-$(CONFIG_HOTPLUG_PCI_ACPI_AMPERE_ALTRA)	+= acpiphp_ampere_altra.o
>  obj-$(CONFIG_HOTPLUG_PCI_ACPI_IBM)	+= acpiphp_ibm.o
>  
>  pci_hotplug-objs	:=	pci_hotplug_core.o
> diff --git a/drivers/pci/hotplug/acpiphp_ampere_altra.c b/drivers/pci/hotplug/acpiphp_ampere_altra.c
> new file mode 100644
> index 0000000000000..8692b939dea78
> --- /dev/null
> +++ b/drivers/pci/hotplug/acpiphp_ampere_altra.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ACPI PCI Hot Plug Ampere Altra Extension

Would be helpful to include a hint about what this module *does*.
IIUC, it controls the attention indicator.

> + *
> + * Copyright (C) 2023 Ampere Computing LLC
> + *

Spurious blank line.

> + */
> +
> +#define pr_fmt(fmt) "acpiphp_ampere_altra: " fmt
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pci_hotplug.h>
> +
> +#include "acpiphp.h"
> +
> +#define HANDLE_OPEN	0xb0200000
> +#define HANDLE_CLOSE	0xb0300000
> +#define REQUEST		0xf0700000
> +#define LED_CMD		0x00000004
> +#define LED_ATTENTION	0x00000002
> +#define LED_SET_ON	0x00000001
> +#define LED_SET_OFF	0x00000002
> +#define LED_SET_BLINK	0x00000003
> +
> +static const struct acpi_device_id acpi_ids[] = {
> +	{"AMPC0008", 0}, {}
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_ids);
> +
> +static u32 led_service_id[4];
> +
> +static int led_status(u8 status)
> +{
> +	switch (status) {
> +	case 1: return LED_SET_ON;
> +	case 2: return LED_SET_BLINK;
> +	default: return LED_SET_OFF;
> +	}
> +}
> +
> +static int set_attention_status(struct hotplug_slot *slot, u8 status)
> +{
> +	struct arm_smccc_res res;
> +	struct pci_bus *bus;
> +	struct pci_dev *root_port;
> +	unsigned long flags;
> +	u32 handle;
> +	int ret = 0;
> +
> +	bus = slot->pci_slot->bus;
> +	root_port = pcie_find_root_port(bus->self);
> +	if (!root_port)
> +		return -ENODEV;
> +
> +	local_irq_save(flags);
> +	arm_smccc_smc(HANDLE_OPEN, led_service_id[0], led_service_id[1],
> +		      led_service_id[2], led_service_id[3], 0, 0, 0, &res);
> +	if (res.a0) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +	handle = res.a1 & 0xffff0000;
> +
> +	arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
> +		      pci_domain_nr(bus) | ((root_port->devfn >> 3) << 4), 0, 0,

PCI_SLOT(root_port->devfn)

> +		      handle, &res);
> +	if (res.a0)
> +		ret = -ENODEV;
> +
> +	arm_smccc_smc(HANDLE_CLOSE, handle, 0, 0, 0, 0, 0, 0, &res);
> +
> + out:
> +	local_irq_restore(flags);
> +	return ret;
> +}
> +
> +static int get_attention_status(struct hotplug_slot *slot, u8 *status)
> +{
> +	return -EINVAL;
> +}
> +
> +static struct acpiphp_attention_info ampere_altra_attn = {
> +	.set_attn = set_attention_status,
> +	.get_attn = get_attention_status,
> +	.owner = THIS_MODULE,
> +};
> +
> +static acpi_status __init get_acpi_handle(acpi_handle handle, u32 level,
> +					  void *context, void **return_value)
> +{
> +	*(acpi_handle *)return_value = handle;
> +	return AE_CTRL_TERMINATE;
> +}
> +
> +static int __init acpiphp_ampere_altra_init(void)
> +{
> +	struct fwnode_handle *fwnode;
> +	acpi_handle leds_handle = NULL;
> +	struct acpi_device *leds;
> +	acpi_status status;
> +	int ret;
> +
> +	status = acpi_get_devices("AMPC0008", get_acpi_handle, NULL,
> +				  &leds_handle);

Rafael, can you comment on whether we should use acpi_get_devices(),
acpi_bus_register_driver(), acpi_acpi_scan_add_handler(), or something
else here?  I try to avoid pci_get_device() because it subverts the
driver model (no hotplug support, no driver/device binding).

I see Documentation/driver-api/acpi/scan_handlers.rst, but I'm not
clear on when to use acpi_bus_register_driver() vs
acpi_acpi_scan_add_handler().

I guess the only ACPI connection here is to retrieve the "uuid"
property once, and there's no need for any ACPI services after that.

> +	if (ACPI_FAILURE(status) || !leds_handle)
> +		return -ENODEV;

> +	leds = acpi_get_acpi_dev(leds_handle);
> +	if (!leds) {
> +		pr_err("can't find device\n");
> +		return -ENODEV;
> +	}
> +
> +	fwnode = acpi_fwnode_handle(leds);
> +	ret = fwnode_property_read_u32_array(fwnode, "uuid", led_service_id, 4);
> +	acpi_put_acpi_dev(leds);
> +	if (ret) {
> +		pr_err("can't find uuid\n");
> +		return -ENODEV;
> +	}
> +
> +	if (acpiphp_register_attention(&ampere_altra_attn)) {
> +		pr_err("can't register driver\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +module_init(acpiphp_ampere_altra_init);
> +
> +static void __exit acpiphp_ampere_altra_exit(void)
> +{
> +	acpiphp_unregister_attention(&ampere_altra_attn);
> +}
> +
> +module_exit(acpiphp_ampere_altra_exit);
> +
> +MODULE_AUTHOR("D Scott Phillips <scott@os.amperecomputing.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.41.0
> 

