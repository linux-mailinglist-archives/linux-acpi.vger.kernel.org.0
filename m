Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E28A3A2A2A
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 13:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhFJL35 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 07:29:57 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3194 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJL35 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 07:29:57 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G11bd5DrKz6M4Yp;
        Thu, 10 Jun 2021 19:15:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 13:27:58 +0200
Received: from localhost (10.52.126.112) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 10 Jun
 2021 12:27:58 +0100
Date:   Thu, 10 Jun 2021 12:27:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v6 3/5] cxl/acpi: Add downstream port data to cxl_port
 instances
Message-ID: <20210610122755.00005fab@Huawei.com>
In-Reply-To: <20210610003458.GA6309@alison-desk.jf.intel.com>
References: <162325448982.2293126.16916114289970424561.stgit@dwillia2-desk3.amr.corp.intel.com>
        <162325450624.2293126.3533006409920271718.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20210610003458.GA6309@alison-desk.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.112]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 9 Jun 2021 17:34:58 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Wed, Jun 09, 2021 at 09:01:46AM -0700, Dan Williams wrote:
> > In preparation for infrastructure that enumerates and configures the CXL
> > decode mechanism of an upstream port to its downstream ports, add a
> > representation of a CXL downstream port.
> > 
> > On ACPI systems the top-most logical downstream ports in the hierarchy
> > are the host bridges (ACPI0016 devices) that decode the memory windows
> > described by the CXL Early Discovery Table Fixed Memory Window
> > Structures (CEDT.CFMWS).
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> 
> Looks good!
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Agreed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |   13 ++++
> >  drivers/cxl/acpi.c                      |   43 ++++++++++++
> >  drivers/cxl/core.c                      |  107 ++++++++++++++++++++++++++++++-
> >  drivers/cxl/cxl.h                       |   21 ++++++
> >  4 files changed, 180 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index bda2cc55cc38..f680da85fd44 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -44,3 +44,16 @@ Description:
> >  		CXL component registers. The 'uport' symlink connects the CXL
> >  		portX object to the device that published the CXL port
> >  		capability.
> > +
> > +What:		/sys/bus/cxl/devices/portX/dportY
> > +Date:		June, 2021
> > +KernelVersion:	v5.14
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		CXL port objects are enumerated from either a platform firmware
> > +		device (ACPI0017 and ACPI0016) or PCIe switch upstream port with
> > +		CXL component registers. The 'dportY' symlink identifies one or
> > +		more downstream ports that the upstream port may target in its
> > +		decode of CXL memory resources.  The 'Y' integer reflects the
> > +		hardware port unique-id used in the hardware decoder target
> > +		list.
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 556d25ab6966..5eb9543c587a 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -7,17 +7,58 @@
> >  #include <linux/acpi.h>
> >  #include "cxl.h"
> >  
> > +static struct acpi_device *to_cxl_host_bridge(struct device *dev)
> > +{
> > +	struct acpi_device *adev = to_acpi_device(dev);
> > +
> > +	if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0)
> > +		return adev;
> > +	return NULL;
> > +}
> > +
> > +static int add_host_bridge_dport(struct device *match, void *arg)
> > +{
> > +	int rc;
> > +	acpi_status status;
> > +	unsigned long long uid;
> > +	struct cxl_port *root_port = arg;
> > +	struct device *host = root_port->dev.parent;
> > +	struct acpi_device *bridge = to_cxl_host_bridge(match);
> > +
> > +	if (!bridge)
> > +		return 0;
> > +
> > +	status = acpi_evaluate_integer(bridge->handle, METHOD_NAME__UID, NULL,
> > +				       &uid);
> > +	if (status != AE_OK) {
> > +		dev_err(host, "unable to retrieve _UID of %s\n",
> > +			dev_name(match));
> > +		return -ENODEV;
> > +	}
> > +
> > +	rc = cxl_add_dport(root_port, match, uid, CXL_RESOURCE_NONE);
> > +	if (rc) {
> > +		dev_err(host, "failed to add downstream port: %s\n",
> > +			dev_name(match));
> > +		return rc;
> > +	}
> > +	dev_dbg(host, "add dport%llu: %s\n", uid, dev_name(match));
> > +	return 0;
> > +}
> > +
> >  static int cxl_acpi_probe(struct platform_device *pdev)
> >  {
> >  	struct cxl_port *root_port;
> >  	struct device *host = &pdev->dev;
> > +	struct acpi_device *adev = ACPI_COMPANION(host);
> >  
> >  	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
> >  	if (IS_ERR(root_port))
> >  		return PTR_ERR(root_port);
> >  	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
> >  
> > -	return 0;
> > +	return bus_for_each_dev(adev->dev.bus, NULL, root_port,
> > +				add_host_bridge_dport);
> >  }
> >  
> >  static const struct acpi_device_id cxl_acpi_ids[] = {
> > diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> > index dbbb34618d7d..8a3f3804f252 100644
> > --- a/drivers/cxl/core.c
> > +++ b/drivers/cxl/core.c
> > @@ -33,10 +33,22 @@ static struct attribute_group cxl_base_attribute_group = {
> >  	.attrs = cxl_base_attributes,
> >  };
> >  
> > +static void cxl_dport_release(struct cxl_dport *dport)
> > +{
> > +	list_del(&dport->list);
> > +	put_device(dport->dport);
> > +	kfree(dport);
> > +}
> > +
> >  static void cxl_port_release(struct device *dev)
> >  {
> >  	struct cxl_port *port = to_cxl_port(dev);
> > +	struct cxl_dport *dport, *_d;
> >  
> > +	device_lock(dev);
> > +	list_for_each_entry_safe(dport, _d, &port->dports, list)
> > +		cxl_dport_release(dport);
> > +	device_unlock(dev);
> >  	ida_free(&cxl_port_ida, port->id);
> >  	kfree(port);
> >  }
> > @@ -60,9 +72,22 @@ struct cxl_port *to_cxl_port(struct device *dev)
> >  	return container_of(dev, struct cxl_port, dev);
> >  }
> >  
> > -static void unregister_dev(void *dev)
> > +static void unregister_port(void *_port)
> >  {
> > -	device_unregister(dev);
> > +	struct cxl_port *port = _port;
> > +	struct cxl_dport *dport;
> > +
> > +	device_lock(&port->dev);
> > +	list_for_each_entry(dport, &port->dports, list) {
> > +		char link_name[CXL_TARGET_STRLEN];
> > +
> > +		if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d",
> > +			     dport->port_id) >= CXL_TARGET_STRLEN)
> > +			continue;
> > +		sysfs_remove_link(&port->dev.kobj, link_name);
> > +	}
> > +	device_unlock(&port->dev);
> > +	device_unregister(&port->dev);
> >  }
> >  
> >  static void cxl_unlink_uport(void *_port)
> > @@ -113,6 +138,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
> >  
> >  	port->uport = uport;
> >  	port->component_reg_phys = component_reg_phys;
> > +	INIT_LIST_HEAD(&port->dports);
> >  
> >  	device_initialize(dev);
> >  	device_set_pm_not_required(dev);
> > @@ -157,7 +183,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> >  	if (rc)
> >  		goto err;
> >  
> > -	rc = devm_add_action_or_reset(host, unregister_dev, dev);
> > +	rc = devm_add_action_or_reset(host, unregister_port, port);
> >  	if (rc)
> >  		return ERR_PTR(rc);
> >  
> > @@ -173,6 +199,81 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> >  }
> >  EXPORT_SYMBOL_GPL(devm_cxl_add_port);
> >  
> > +static struct cxl_dport *find_dport(struct cxl_port *port, int id)
> > +{
> > +	struct cxl_dport *dport;
> > +
> > +	device_lock_assert(&port->dev);
> > +	list_for_each_entry (dport, &port->dports, list)
> > +		if (dport->port_id == id)
> > +			return dport;
> > +	return NULL;
> > +}
> > +
> > +static int add_dport(struct cxl_port *port, struct cxl_dport *new)
> > +{
> > +	struct cxl_dport *dup;
> > +
> > +	device_lock(&port->dev);
> > +	dup = find_dport(port, new->port_id);
> > +	if (dup)
> > +		dev_err(&port->dev,
> > +			"unable to add dport%d-%s non-unique port id (%s)\n",
> > +			new->port_id, dev_name(new->dport),
> > +			dev_name(dup->dport));
> > +	else
> > +		list_add_tail(&new->list, &port->dports);
> > +	device_unlock(&port->dev);
> > +
> > +	return dup ? -EEXIST : 0;
> > +}
> > +
> > +/**
> > + * cxl_add_dport - append downstream port data to a cxl_port
> > + * @port: the cxl_port that references this dport
> > + * @dport_dev: firmware or PCI device representing the dport
> > + * @port_id: identifier for this dport in a decoder's target list
> > + * @component_reg_phys: optional location of CXL component registers
> > + *
> > + * Note that all allocations and links are undone by cxl_port deletion
> > + * and release.
> > + */
> > +int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
> > +		  resource_size_t component_reg_phys)
> > +{
> > +	char link_name[CXL_TARGET_STRLEN];
> > +	struct cxl_dport *dport;
> > +	int rc;
> > +
> > +	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
> > +	    CXL_TARGET_STRLEN)
> > +		return -EINVAL;
> > +
> > +	dport = kzalloc(sizeof(*dport), GFP_KERNEL);
> > +	if (!dport)
> > +		return -ENOMEM;
> > +
> > +	INIT_LIST_HEAD(&dport->list);
> > +	dport->dport = get_device(dport_dev);
> > +	dport->port_id = port_id;
> > +	dport->component_reg_phys = component_reg_phys;
> > +	dport->port = port;
> > +
> > +	rc = add_dport(port, dport);
> > +	if (rc)
> > +		goto err;
> > +
> > +	rc = sysfs_create_link(&port->dev.kobj, &dport_dev->kobj, link_name);
> > +	if (rc)
> > +		goto err;
> > +
> > +	return 0;
> > +err:
> > +	cxl_dport_release(dport);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_add_dport);
> > +
> >  /**
> >   * cxl_probe_component_regs() - Detect CXL Component register blocks
> >   * @dev: Host device of the @base mapping
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 5651e5bb8274..dd159fd6d692 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -154,6 +154,7 @@ int cxl_map_device_regs(struct pci_dev *pdev,
> >  			struct cxl_register_map *map);
> >  
> >  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
> > +#define CXL_TARGET_STRLEN 20
> >  
> >  /**
> >   * struct cxl_port - logical collection of upstream port devices and
> > @@ -162,19 +163,39 @@ int cxl_map_device_regs(struct pci_dev *pdev,
> >   * @dev: this port's device
> >   * @uport: PCI or platform device implementing the upstream port capability
> >   * @id: id for port device-name
> > + * @dports: cxl_dport instances referenced by decoders
> >   * @component_reg_phys: component register capability base address (optional)
> >   */
> >  struct cxl_port {
> >  	struct device dev;
> >  	struct device *uport;
> >  	int id;
> > +	struct list_head dports;
> >  	resource_size_t component_reg_phys;
> >  };
> >  
> > +/**
> > + * struct cxl_dport - CXL downstream port
> > + * @dport: PCI bridge or firmware device representing the downstream link
> > + * @port_id: unique hardware identifier for dport in decoder target list
> > + * @component_reg_phys: downstream port component registers
> > + * @port: reference to cxl_port that contains this downstream port
> > + * @list: node for a cxl_port's list of cxl_dport instances
> > + */
> > +struct cxl_dport {
> > +	struct device *dport;
> > +	int port_id;
> > +	resource_size_t component_reg_phys;
> > +	struct cxl_port *port;
> > +	struct list_head list;
> > +};
> > +
> >  struct cxl_port *to_cxl_port(struct device *dev);
> >  struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> >  				   resource_size_t component_reg_phys,
> >  				   struct cxl_port *parent_port);
> >  
> > +int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
> > +		  resource_size_t component_reg_phys);
> >  extern struct bus_type cxl_bus_type;
> >  #endif /* __CXL_H__ */
> >   

