Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA43791BA
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 16:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhEJPAf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 11:00:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3045 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhEJO7G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 May 2021 10:59:06 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ff3m45dT2z70gF7;
        Mon, 10 May 2021 22:46:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 16:57:57 +0200
Received: from localhost (10.52.123.16) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 15:57:56 +0100
Date:   Mon, 10 May 2021 15:56:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 5/8] cxl/acpi: Introduce ACPI0017 driver and cxl_root
Message-ID: <20210510155615.000001fc@Huawei.com>
In-Reply-To: <162042790793.1202325.13507889482183963289.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
        <162042790793.1202325.13507889482183963289.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.16]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 7 May 2021 15:51:47 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> While CXL builds upon the PCI software model for dynamic enumeration and
> control, a static platform component is required to bootstrap the CXL
> memory layout. In addition to identifying the host bridges ACPI is
> responsible for enumerating the CXL memory space that can be addressed
> by decoders. This is similar to the requirement for ACPI to publish
> resources reported by _CRS for PCI host bridges.
> 
> Introduce the cxl_root object as an abstract "port" into the CXL.mem
> address space described by HDM decoders identified by the ACPI
> CEDT.CHBS.
> 
> For now just establish the initial boilerplate and sysfs attributes, to
> be followed by enumeration of the ports within the host bridge.
> 
> Note the allocation of CXL core device objects is split into separate
> alloc and add steps in order to separate the alloc error path (kfree())
> from the device add error path (put_device()).
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Hi Dan

Just one bit in here that confused me (assuming I'm reading the code correctly).
You have is_visible for the dev_attr_supports_pmem etc to only show them if
the particular space supports that memory type. That's fine. You also have
the actual sysfs function checking the same flag to decide to return "1" or "0"
which would also be fine, but in combination it's rather odd as the sysfs
read function can never return "0" (sysfs attribute isn't visible in that
condition). Probably deserves at least a comment.

This also needs some documentation for the new sysfs ABI
(Documentation/ABI/...) but that can be in a separate patch.

Otherwise looks good to me.

Jonathan

> ---
>  drivers/cxl/Kconfig  |   14 ++
>  drivers/cxl/Makefile |    2 
>  drivers/cxl/acpi.c   |   39 +++++
>  drivers/cxl/core.c   |  356 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h    |   65 +++++++++
>  5 files changed, 476 insertions(+)
>  create mode 100644 drivers/cxl/acpi.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 97dc4d751651..fb282af84afd 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -50,4 +50,18 @@ config CXL_MEM_RAW_COMMANDS
>  	  potential impact to memory currently in use by the kernel.
>  
>  	  If developing CXL hardware or the driver say Y, otherwise say N.
> +
> +config CXL_ACPI
> +	tristate "CXL ACPI: Platform Support"
> +	depends on ACPI
> +	help
> +	  Enable support for host managed device memory (HDM) resources
> +	  published by a platform's ACPI CXL memory layout description.
> +	  See Chapter 9.14.1 CXL Early Discovery Table (CEDT) in the CXL
> +	  2.0 specification. The CXL core consumes these resource to
> +	  publish port and address_space objects used to map regions
> +	  that represent System RAM, or Persistent Memory regions to be
> +	  managed by LIBNVDIMM.
> +
> +	  If unsure say 'm'.
>  endif
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index 3808e39dd31f..f429ca6b59d9 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -1,7 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
>  obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> +obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  
>  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
>  cxl_core-y := core.o
>  cxl_mem-y := mem.o
> +cxl_acpi-y := acpi.o
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> new file mode 100644
> index 000000000000..d54c2d5de730
> --- /dev/null
> +++ b/drivers/cxl/acpi.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/acpi.h>
> +#include "cxl.h"
> +
> +static int cxl_acpi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cxl_root *cxl_root;
> +
> +	cxl_root = devm_cxl_add_root(dev, NULL, 0);
> +	if (IS_ERR(cxl_root))
> +		return PTR_ERR(cxl_root);
> +	dev_dbg(dev, "register: %s\n", dev_name(&cxl_root->port.dev));
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id cxl_acpi_ids[] = {
> +	{ "ACPI0017", 0 },
> +	{ "", 0 },
> +};
> +MODULE_DEVICE_TABLE(acpi, cxl_acpi_ids);
> +
> +static struct platform_driver cxl_acpi_driver = {
> +	.probe = cxl_acpi_probe,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.acpi_match_table = cxl_acpi_ids,
> +	},
> +};
> +
> +module_platform_driver(cxl_acpi_driver);
> +MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index d94c4c2dee8f..347824a62a66 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -2,6 +2,8 @@
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/idr.h>
>  #include "cxl.h"
>  
>  /**
> @@ -11,6 +13,360 @@
>   * point for cross-device interleave coordination through cxl ports.
>   */
>  
> +static DEFINE_IDA(cxl_port_ida);
> +
> +static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", dev->type->name);
> +}
> +static DEVICE_ATTR_RO(devtype);
> +
> +static struct attribute *cxl_base_attributes[] = {
> +	&dev_attr_devtype.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group cxl_base_attribute_group = {
> +	.attrs = cxl_base_attributes,
> +};
> +
> +static struct cxl_address_space *dev_to_address_space(struct device *dev)
> +{
> +	struct cxl_address_space_dev *cxl_asd = to_cxl_address_space(dev);
> +
> +	return cxl_asd->address_space;
> +}
> +
> +static ssize_t start_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct cxl_address_space *space = dev_to_address_space(dev);
> +
> +	return sysfs_emit(buf, "%#llx\n", space->range.start);
> +}
> +static DEVICE_ATTR_RO(start);
> +
> +static ssize_t end_show(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct cxl_address_space *space = dev_to_address_space(dev);
> +
> +	return sysfs_emit(buf, "%#llx\n", space->range.end);
> +}
> +static DEVICE_ATTR_RO(end);
> +
> +#define CXL_ATTR_SUPPORTS(name, flag)                                  \
> +static ssize_t supports_##name##_show(                                 \
> +	struct device *dev, struct device_attribute *attr, char *buf)  \
> +{                                                                      \
> +	struct cxl_address_space *space = dev_to_address_space(dev);   \
> +                                                                       \
> +	return sysfs_emit(buf, "%s\n",                                 \
> +			  (space->flags & (flag)) ? "1" : "0");        \
> +}                                                                      \
> +static DEVICE_ATTR_RO(supports_##name)

I think this can only return 1 if it is possible to read it. See below.

> +
> +CXL_ATTR_SUPPORTS(pmem, CXL_ADDRSPACE_PMEM);
> +CXL_ATTR_SUPPORTS(ram, CXL_ADDRSPACE_RAM);
> +CXL_ATTR_SUPPORTS(type2, CXL_ADDRSPACE_TYPE2);
> +CXL_ATTR_SUPPORTS(type3, CXL_ADDRSPACE_TYPE3);
> +
> +static struct attribute *cxl_address_space_attributes[] = {
> +	&dev_attr_start.attr,
> +	&dev_attr_end.attr,
> +	&dev_attr_supports_pmem.attr,
> +	&dev_attr_supports_ram.attr,
> +	&dev_attr_supports_type2.attr,
> +	&dev_attr_supports_type3.attr,
> +	NULL,
> +};
> +
> +static umode_t cxl_address_space_visible(struct kobject *kobj,
> +					 struct attribute *a, int n)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct cxl_address_space *space = dev_to_address_space(dev);
> +
> +	if (a == &dev_attr_supports_pmem.attr &&
> +	    !(space->flags & CXL_ADDRSPACE_PMEM))
> +		return 0;
> +
> +	if (a == &dev_attr_supports_ram.attr &&
> +	    !(space->flags & CXL_ADDRSPACE_RAM))
> +		return 0;
> +
> +	if (a == &dev_attr_supports_type2.attr &&
> +	    !(space->flags & CXL_ADDRSPACE_TYPE2))
> +		return 0;
> +
> +	if (a == &dev_attr_supports_type3.attr &&
> +	    !(space->flags & CXL_ADDRSPACE_TYPE3))
> +		return 0;

Why control visibility for these given they are boolean sysfs attributes
that say if the thing is supported or not?  Hiding them if not supported
seems an odd thing to do whilst also allowing them to take a value of 0.

> +
> +	return a->mode;
> +}
> +
> +static struct attribute_group cxl_address_space_attribute_group = {
> +	.attrs = cxl_address_space_attributes,
> +	.is_visible = cxl_address_space_visible,
> +};
> +
> +static const struct attribute_group *cxl_address_space_attribute_groups[] = {
> +	&cxl_address_space_attribute_group,
> +	&cxl_base_attribute_group,
> +	NULL,
> +};
> +
> +static void cxl_address_space_release(struct device *dev)
> +{
> +	struct cxl_address_space_dev *cxl_asd = to_cxl_address_space(dev);
> +
> +	remove_resource(&cxl_asd->res);
> +	kfree(cxl_asd);
> +}
> +
> +static const struct device_type cxl_address_space_type = {
> +	.name = "cxl_address_space",
> +	.release = cxl_address_space_release,
> +	.groups = cxl_address_space_attribute_groups,
> +};
> +
> +struct cxl_address_space_dev *to_cxl_address_space(struct device *dev)
> +{
> +	if (dev_WARN_ONCE(dev, dev->type != &cxl_address_space_type,
> +			  "not a cxl_address_space device\n"))
> +		return NULL;
> +	return container_of(dev, struct cxl_address_space_dev, dev);
> +}
> +
> +static void cxl_root_release(struct device *dev)
> +{
> +	struct cxl_root *cxl_root = to_cxl_root(dev);
> +
> +	ida_free(&cxl_port_ida, cxl_root->port.id);
> +	kfree(cxl_root);
> +}
> +
> +static ssize_t target_id_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct cxl_port *cxl_port = to_cxl_port(dev);
> +
> +	return sysfs_emit(buf, "%d\n", cxl_port->target_id);
> +}
> +static DEVICE_ATTR_RO(target_id);
> +
> +static struct attribute *cxl_port_attributes[] = {
> +	&dev_attr_target_id.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group cxl_port_attribute_group = {
> +	.attrs = cxl_port_attributes,
> +};
> +
> +static const struct attribute_group *cxl_port_attribute_groups[] = {
> +	&cxl_port_attribute_group,
> +	&cxl_base_attribute_group,
> +	NULL,
> +};
> +
> +static const struct device_type cxl_root_type = {
> +	.name = "cxl_root",
> +	.release = cxl_root_release,
> +	.groups = cxl_port_attribute_groups,
> +};
> +
> +struct cxl_root *to_cxl_root(struct device *dev)
> +{
> +	if (dev_WARN_ONCE(dev, dev->type != &cxl_root_type,
> +			  "not a cxl_root device\n"))
> +		return NULL;
> +	return container_of(dev, struct cxl_root, port.dev);
> +}
> +
> +struct cxl_port *to_cxl_port(struct device *dev)
> +{
> +	if (dev_WARN_ONCE(dev, dev->type != &cxl_root_type,
> +			  "not a cxl_port device\n"))
> +		return NULL;
> +	return container_of(dev, struct cxl_port, dev);
> +}
> +
> +static void unregister_dev(void *dev)
> +{
> +	device_unregister(dev);
> +}
> +
> +static struct cxl_root *cxl_root_alloc(struct device *parent,
> +				       struct cxl_address_space *cxl_space,
> +				       int nr_spaces)
> +{
> +	struct cxl_root *cxl_root;
> +	struct cxl_port *port;
> +	struct device *dev;
> +	int rc;
> +
> +	cxl_root = kzalloc(struct_size(cxl_root, address_space, nr_spaces),
> +			   GFP_KERNEL);
> +	if (!cxl_root)
> +		return ERR_PTR(-ENOMEM);
> +
> +	memcpy(cxl_root->address_space, cxl_space,
> +	       flex_array_size(cxl_root, address_space, nr_spaces));
> +	cxl_root->nr_spaces = nr_spaces;
> +
> +	rc = ida_alloc(&cxl_port_ida, GFP_KERNEL);
> +	if (rc < 0)
> +		goto err;
> +	port = &cxl_root->port;
> +	port->id = rc;
> +
> +	/*
> +	 * Root does not have a cxl_port as its parent and it does not
> +	 * have any corresponding component registers. It is only a
> +	 * logical anchor to the first level of actual ports that decode
> +	 * the root address spaces.
> +	 */
> +	port->port_host = parent;
> +	port->target_id = -1;
> +	port->component_regs_phys = -1;
> +
> +	dev = &port->dev;
> +	device_initialize(dev);
> +	device_set_pm_not_required(dev);
> +	dev->parent = parent;
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_root_type;
> +
> +	return cxl_root;
> +
> +err:
> +	kfree(cxl_root);
> +	return ERR_PTR(rc);
> +}
> +
> +static struct cxl_address_space_dev *
> +cxl_address_space_dev_alloc(struct device *parent,
> +			    struct cxl_address_space *space)
> +{
> +	struct cxl_address_space_dev *cxl_asd;
> +	struct resource *res;
> +	struct device *dev;
> +	int rc;
> +
> +	cxl_asd = kzalloc(sizeof(*cxl_asd), GFP_KERNEL);
> +	if (!cxl_asd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	res = &cxl_asd->res;
> +	res->name = "CXL Address Space";
> +	res->start = space->range.start;
> +	res->end = space->range.end;
> +	res->flags = IORESOURCE_MEM;
> +
> +	rc = insert_resource(&iomem_resource, res);
> +	if (rc)
> +		goto err;
> +
> +	cxl_asd->address_space = space;
> +	dev = &cxl_asd->dev;
> +	device_initialize(dev);
> +	device_set_pm_not_required(dev);
> +	dev->parent = parent;
> +	dev->type = &cxl_address_space_type;
> +
> +	return cxl_asd;
> +
> +err:
> +	kfree(cxl_asd);
> +	return ERR_PTR(rc);
> +}
> +
> +
> +/**
> + * cxl_address_space_dev_add() - Name and add the cxl address space device
> + * @host: devm context to trigger device removal at @host ->remove()
> + * @cxl_asd: address space device to add
> + * @id: index in the root array of address spaces and name component
> + */
> +static int cxl_address_space_dev_add(struct device *host,
> +				     struct cxl_address_space_dev *cxl_asd,
> +				     int id)
> +{
> +	struct device *dev = &cxl_asd->dev;
> +	int rc;
> +
> +	rc = dev_set_name(dev, "address_space%d", id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(host, "%s: register %s\n", dev_name(dev->parent),
> +		dev_name(dev));
> +
> +	return devm_add_action_or_reset(host, unregister_dev, dev);
> +
> +err:
> +	put_device(dev);
> +	return rc;
> +}
> +
> +struct cxl_root *devm_cxl_add_root(struct device *host,
> +				   struct cxl_address_space *cxl_space,
> +				   int nr_spaces)
> +{
> +	struct cxl_root *cxl_root;
> +	struct cxl_port *port;
> +	struct device *dev;
> +	int i, rc;
> +
> +	cxl_root = cxl_root_alloc(host, cxl_space, nr_spaces);
> +	if (IS_ERR(cxl_root))
> +		return cxl_root;
> +
> +	port = &cxl_root->port;
> +	dev = &port->dev;
> +	rc = dev_set_name(dev, "root%d", port->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	rc = devm_add_action_or_reset(host, unregister_dev, dev);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	for (i = 0; i < nr_spaces; i++) {
> +		struct cxl_address_space *space = &cxl_root->address_space[i];
> +		struct cxl_address_space_dev *cxl_asd;
> +
> +		if (!range_len(&space->range))
> +			continue;
> +
> +		cxl_asd = cxl_address_space_dev_alloc(dev, space);
> +		if (IS_ERR(cxl_asd))
> +			return ERR_CAST(cxl_asd);
> +
> +		rc = cxl_address_space_dev_add(host, cxl_asd, i);
> +		if (rc)
> +			return ERR_PTR(rc);
> +	}
> +
> +	return cxl_root;
> +
> +err:
> +	put_device(dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_GPL(devm_cxl_add_root);
> +
>  /**
>   * cxl_setup_device_regs() - Detect CXL Device register blocks
>   * @dev: Host device of the @base mapping
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d49e0cb679fa..5cd1173151e5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -6,6 +6,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/range.h>
>  #include <linux/io.h>
>  
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
> @@ -69,5 +70,69 @@ struct cxl_regs {
>  void cxl_setup_device_regs(struct device *dev, void __iomem *base,
>  			   struct cxl_device_regs *regs);
>  
> +/*
> + * Address space properties derived from:
> + * CXL 2.0 8.2.5.12.7 CXL HDM Decoder 0 Control Register
> + */
> +#define CXL_ADDRSPACE_RAM   BIT(0)
> +#define CXL_ADDRSPACE_PMEM  BIT(1)
> +#define CXL_ADDRSPACE_TYPE2 BIT(2)
> +#define CXL_ADDRSPACE_TYPE3 BIT(3)
> +#define CXL_ADDRSPACE_MASK  GENMASK(3, 0)
> +
> +struct cxl_address_space {
> +	struct range range;
> +	int interleave_size;
> +	unsigned long flags;
> +	unsigned long targets;
> +};
> +
> +struct cxl_address_space_dev {
> +	struct device dev;
> +	struct resource res;
> +	struct cxl_address_space *address_space;
> +};
> +
> +/**
> + * struct cxl_port - object representing a root, upstream, or downstream port
> + * @dev: this port's device
> + * @port_host: PCI or platform device host of the CXL capability
> + * @id: id for port device-name
> + * @target_id: this port's HDM decoder id in the parent port
> + * @component_regs_phys: component register capability array base address
> + */
> +struct cxl_port {
> +	struct device dev;
> +	struct device *port_host;
> +	int id;
> +	int target_id;
> +	resource_size_t component_regs_phys;
> +};
> +
> +/*
> + * struct cxl_root - platform object parent of CXL host bridges
> + *
> + * A cxl_root object represents a set of address spaces that are
> + * interleaved across a set of child host bridges, but never interleaved
> + * to another cxl_root object. It contains a cxl_port that is a special
> + * case in that it does not have a parent port and related HDMs, instead
> + * its decode is derived from the root (platform firmware defined)
> + * address space description. Not to be confused with CXL Root Ports
> + * that are the PCIE Root Ports within PCIE Host Bridges that are
> + * flagged by platform firmware (ACPI0016 on ACPI platforms) as having
> + * CXL capabilities.
> + */
> +struct cxl_root {
> +	struct cxl_port port;
> +	int nr_spaces;
> +	struct cxl_address_space address_space[];
> +};
> +
> +struct cxl_root *to_cxl_root(struct device *dev);
> +struct cxl_port *to_cxl_port(struct device *dev);
> +struct cxl_address_space_dev *to_cxl_address_space(struct device *dev);
> +struct cxl_root *devm_cxl_add_root(struct device *parent,
> +				   struct cxl_address_space *cxl_space,
> +				   int nr_spaces);
>  extern struct bus_type cxl_bus_type;
>  #endif /* __CXL_H__ */
> 

