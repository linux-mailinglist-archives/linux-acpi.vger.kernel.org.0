Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FDC341A4C
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 11:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCSKpJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 06:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229687AbhCSKon (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Mar 2021 06:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616150682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qs9EeR/YBbvQEPV7MXxyCJxJlPGrpYgS2009fU7smZw=;
        b=QF8l/FDACXIly1mY9DfGWo5u+o3hrDXJ+C95UWBvGap0hV1T9MJ4P5qQMJfJJxr9cKuAL7
        cU/xQYhOB6Aufx1sBWM8mZrbgxJWwnsucdpT+tvUFg9oYHHmE4oV+4RQkM0pDnkoyQBLxJ
        K9bkiLBPoRM3dIvFt+SVl1BCy43qTGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-THRhhNBqNNa59QyCHTodaQ-1; Fri, 19 Mar 2021 06:44:38 -0400
X-MC-Unique: THRhhNBqNNa59QyCHTodaQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E26D2190A7A2;
        Fri, 19 Mar 2021 10:44:35 +0000 (UTC)
Received: from [10.36.113.141] (ovpn-113-141.ams2.redhat.com [10.36.113.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67FD460C13;
        Fri, 19 Mar 2021 10:44:29 +0000 (UTC)
Subject: Re: [PATCH 2/3] ACPI: Add driver for the VIOT table
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     will@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-3-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <cea43eef-35d2-b6c5-2bf0-ab7ba8473fb6@redhat.com>
Date:   Fri, 19 Mar 2021 11:44:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210316191652.3401335-3-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

On 3/16/21 8:16 PM, Jean-Philippe Brucker wrote:
> The ACPI Virtual I/O Translation Table describes topology of
> para-virtual platforms. For now it describes the relation between
> virtio-iommu and the endpoints it manages. Supporting that requires
> three steps:
> 
> (1) acpi_viot_init(): parse the VIOT table, build a list of endpoints
>     and vIOMMUs.
> 
> (2) acpi_viot_set_iommu_ops(): when the vIOMMU driver is loaded and the
>     device probed, register it to the VIOT driver. This step is required
>     because unlike similar drivers, VIOT doesn't create the vIOMMU
>     device.
> 
> (3) acpi_viot_dma_setup(): when the endpoint is initialized, find the
>     vIOMMU and register the endpoint's DMA ops.
> 
> If step (3) happens before step (2), it is deferred until the IOMMU is
> initialized, then retried.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/acpi/Kconfig         |   3 +
>  drivers/iommu/Kconfig        |   1 +
>  drivers/acpi/Makefile        |   2 +
>  include/linux/acpi_viot.h    |  26 +++
>  drivers/acpi/bus.c           |   2 +
>  drivers/acpi/scan.c          |   6 +
>  drivers/acpi/viot.c          | 406 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/virtio-iommu.c |   3 +
>  MAINTAINERS                  |   8 +
>  9 files changed, 457 insertions(+)
>  create mode 100644 include/linux/acpi_viot.h
>  create mode 100644 drivers/acpi/viot.c
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index eedec61e3476..3758c6940ed7 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -526,6 +526,9 @@ endif
>  
>  source "drivers/acpi/pmic/Kconfig"
>  
> +config ACPI_VIOT
> +	bool
> +
>  endif	# ACPI
>  
>  config X86_PM_TIMER
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 192ef8f61310..2819b5c8ec30 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -403,6 +403,7 @@ config VIRTIO_IOMMU
>  	depends on ARM64
>  	select IOMMU_API
>  	select INTERVAL_TREE
> +	select ACPI_VIOT if ACPI
>  	help
>  	  Para-virtualised IOMMU driver with virtio.
>  
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 700b41adf2db..a6e644c48987 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -118,3 +118,5 @@ video-objs			+= acpi_video.o video_detect.o
>  obj-y				+= dptf/
>  
>  obj-$(CONFIG_ARM64)		+= arm64/
> +
> +obj-$(CONFIG_ACPI_VIOT)		+= viot.o
> diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
> new file mode 100644
> index 000000000000..1f5837595488
> --- /dev/null
> +++ b/include/linux/acpi_viot.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ACPI_VIOT_H__
> +#define __ACPI_VIOT_H__
> +
> +#include <linux/acpi.h>
> +
> +#ifdef CONFIG_ACPI_VIOT
> +void __init acpi_viot_init(void);
> +int acpi_viot_dma_setup(struct device *dev, enum dev_dma_attr attr);
> +int acpi_viot_set_iommu_ops(struct device *dev, struct iommu_ops *ops);
> +#else
> +static inline void acpi_viot_init(void) {}
> +static inline int acpi_viot_dma_setup(struct device *dev,
> +				      enum dev_dma_attr attr)
> +{
> +	return 0;
> +}
> +static inline int acpi_viot_set_iommu_ops(struct device *dev,
> +					  struct iommu_ops *ops)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
> +#endif /* __ACPI_VIOT_H__ */
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index be7da23fad76..f9a965c6617e 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -27,6 +27,7 @@
>  #include <linux/dmi.h>
>  #endif
>  #include <linux/acpi_iort.h>
> +#include <linux/acpi_viot.h>
>  #include <linux/pci.h>
>  #include <acpi/apei.h>
>  #include <linux/suspend.h>
> @@ -1338,6 +1339,7 @@ static int __init acpi_init(void)
>  
>  	pci_mmcfg_late_init();
>  	acpi_iort_init();
> +	acpi_viot_init();
>  	acpi_scan_init();
>  	acpi_ec_init();
>  	acpi_debugfs_init();
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a184529d8fa4..4af01fddd94c 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/acpi_iort.h>
> +#include <linux/acpi_viot.h>
>  #include <linux/signal.h>
>  #include <linux/kthread.h>
>  #include <linux/dmi.h>
> @@ -1506,12 +1507,17 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>  {
>  	const struct iommu_ops *iommu;
>  	u64 dma_addr = 0, size = 0;
> +	int ret;
>  
>  	if (attr == DEV_DMA_NOT_SUPPORTED) {
>  		set_dma_ops(dev, &dma_dummy_ops);
>  		return 0;
>  	}
>  
> +	ret = acpi_viot_dma_setup(dev, attr);
> +	if (ret)
> +		return ret > 0 ? 0 : ret;
> +
>  	iort_dma_setup(dev, &dma_addr, &size);
>  
>  	iommu = iort_iommu_configure_id(dev, input_id);
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> new file mode 100644
> index 000000000000..57a092e8551b
> --- /dev/null
> +++ b/drivers/acpi/viot.c
> @@ -0,0 +1,406 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Virtual I/O topology
> + */
> +#define pr_fmt(fmt) "ACPI: VIOT: " fmt
> +
> +#include <linux/acpi_viot.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/dma-map-ops.h>
> +#include <linux/fwnode.h>
> +#include <linux/iommu.h>
> +#include <linux/list.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +
> +struct viot_dev_id {
> +	unsigned int			type;
> +#define VIOT_DEV_TYPE_PCI		1
> +#define VIOT_DEV_TYPE_MMIO		2
> +	union {
> +		/* PCI endpoint or range */
> +		struct {
> +			u16		segment_start;
> +			u16		segment_end;
> +			u16		bdf_start;
> +			u16		bdf_end;
> +		};
> +		/* MMIO region */
> +		u64			base;
> +	};
> +};
> +
> +struct viot_iommu {
> +	unsigned int			offset;
maybe add a comment to explain offset to what
> +	struct viot_dev_id		dev_id;
> +	struct list_head		list;
> +
> +	struct device			*dev; /* transport device */
> +	struct iommu_ops		*ops;
> +	bool				static_fwnode;
> +};
> +
> +struct viot_endpoint {
> +	struct viot_dev_id		dev_id;
> +	u32				endpoint_id;
> +	struct list_head		list;
> +	struct viot_iommu		*viommu;
> +};
> +
> +static struct acpi_table_viot *viot;
> +static LIST_HEAD(viot_iommus);
> +static LIST_HEAD(viot_endpoints);
> +static DEFINE_MUTEX(viommus_lock);
> +
> +/*
> + * VIOT parsing functions
> + */
> +
> +static int __init viot_check_bounds(const struct acpi_viot_header *hdr)
> +{
> +	struct acpi_viot_header *start, *end, *hdr_end;
> +
> +	start = ACPI_ADD_PTR(struct acpi_viot_header, viot,
> +			     max_t(size_t, sizeof(*viot), viot->node_offset));
> +	end = ACPI_ADD_PTR(struct acpi_viot_header, viot, viot->header.length);
> +	hdr_end = ACPI_ADD_PTR(struct acpi_viot_header, hdr, sizeof(*hdr));
> +
> +	if (hdr < start || hdr_end > end) {
> +		pr_err("Node pointer overflows, bad table\n");
> +		return -EOVERFLOW;
> +	}
> +	if (hdr->length < sizeof(*hdr)) {
> +		pr_err("Empty node, bad table\n");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static struct viot_iommu * __init viot_get_iommu(unsigned int offset)
> +{
> +	struct viot_iommu *viommu;
> +	struct acpi_viot_header *hdr = ACPI_ADD_PTR(struct acpi_viot_header,
> +						    viot, offset);
> +	union {
> +		struct acpi_viot_virtio_iommu_pci pci;
> +		struct acpi_viot_virtio_iommu_mmio mmio;
> +	} *node = (void *)hdr;
> +
> +	list_for_each_entry(viommu, &viot_iommus, list)
> +		if (viommu->offset == offset)
> +			return viommu;
> +
> +	if (viot_check_bounds(hdr))
> +		return NULL;
> +
> +	viommu = kzalloc(sizeof(*viommu), GFP_KERNEL);
> +	if (!viommu)
> +		return NULL;
> +
> +	viommu->offset = offset;
> +	switch (hdr->type) {
> +	case ACPI_VIOT_NODE_VIRTIO_IOMMU_PCI:
> +		if (hdr->length < sizeof(node->pci))
> +			goto err_free;
> +
> +		viommu->dev_id.type = VIOT_DEV_TYPE_PCI;
> +		viommu->dev_id.segment_start = node->pci.segment;
> +		viommu->dev_id.segment_end = node->pci.segment;
> +		viommu->dev_id.bdf_start = node->pci.bdf;
> +		viommu->dev_id.bdf_end = node->pci.bdf;
> +		break;
> +	case ACPI_VIOT_NODE_VIRTIO_IOMMU_MMIO:
> +		if (hdr->length < sizeof(node->mmio))
> +			goto err_free;
> +
> +		viommu->dev_id.type = VIOT_DEV_TYPE_MMIO;
> +		viommu->dev_id.base = node->mmio.base_address;
> +		break;
> +	default:
> +		kfree(viommu);
> +		return NULL;
> +	}
> +
> +	list_add(&viommu->list, &viot_iommus);
> +	return viommu;
> +
> +err_free:
> +	kfree(viommu);
> +	return NULL;
> +}
> +
> +static int __init viot_parse_node(const struct acpi_viot_header *hdr)
> +{
> +	int ret = -EINVAL;
> +	struct viot_endpoint *ep;
> +	union {
> +		struct acpi_viot_mmio mmio;
> +		struct acpi_viot_pci_range pci;
> +	} *node = (void *)hdr;
> +
> +	if (viot_check_bounds(hdr))
> +		return -EINVAL;
> +
> +	if (hdr->type == ACPI_VIOT_NODE_VIRTIO_IOMMU_PCI ||
> +	    hdr->type == ACPI_VIOT_NODE_VIRTIO_IOMMU_MMIO)
> +		return 0;
> +
> +	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	switch (hdr->type) {
> +	case ACPI_VIOT_NODE_PCI_RANGE:
> +		if (hdr->length < sizeof(node->pci))
> +			goto err_free;
> +
> +		ep->dev_id.type = VIOT_DEV_TYPE_PCI;
> +		ep->dev_id.segment_start = node->pci.segment_start;
> +		ep->dev_id.segment_end = node->pci.segment_end;
> +		ep->dev_id.bdf_start = node->pci.bdf_start;
> +		ep->dev_id.bdf_end = node->pci.bdf_end;
> +		ep->endpoint_id = node->pci.endpoint_start;
> +		ep->viommu = viot_get_iommu(node->pci.output_node);
> +		break;
> +	case ACPI_VIOT_NODE_MMIO:
> +		if (hdr->length < sizeof(node->mmio))
> +			goto err_free;
> +
> +		ep->dev_id.type = VIOT_DEV_TYPE_MMIO;
> +		ep->dev_id.base = node->mmio.base_address;
> +		ep->endpoint_id = node->mmio.endpoint;
> +		ep->viommu = viot_get_iommu(node->mmio.output_node);
> +		break;
> +	default:
> +		goto err_free;
> +	}
> +
> +	if (!ep->viommu) {
> +		ret = -ENODEV;
> +		goto err_free;
> +	}
> +
> +	list_add(&ep->list, &viot_endpoints);
> +	return 0;
> +
> +err_free:
> +	kfree(ep);
> +	return ret;
> +}
> +
add some kernel-doc comments matching the explanation in the commit message?
> +void __init acpi_viot_init(void)
> +{
> +	int i;
> +	acpi_status status;
> +	struct acpi_table_header *hdr;
> +	struct acpi_viot_header *node;
> +
> +	status = acpi_get_table(ACPI_SIG_VIOT, 0, &hdr);
> +	if (ACPI_FAILURE(status)) {
> +		if (status != AE_NOT_FOUND) {
> +			const char *msg = acpi_format_exception(status);
> +
> +			pr_err("Failed to get table, %s\n", msg);
> +		}
> +		return;
> +	}
> +
> +	viot = (void *)hdr;
> +
> +	node = ACPI_ADD_PTR(struct acpi_viot_header, viot, viot->node_offset);
> +	for (i = 0; i < viot->node_count; i++) {
in iort_scan_node() the node is checked against the table end. Wouldn't
that make sense here too?
> +		if (viot_parse_node(node))
> +			return;
> +
> +		node = ACPI_ADD_PTR(struct acpi_viot_header, node,
> +				    node->length);
> +	}
> +}
> +
> +/*
> + * VIOT access functions
> + */
> +
the epid_base semantics may deserve a comment too, ie. the fact it is an
offset. Maybe also document that dev can be an EP or an IOMMU
> +static bool viot_device_match(struct device *dev, struct viot_dev_id *id,
> +			      u32 *epid_base)
> +{
> +	if (id->type == VIOT_DEV_TYPE_PCI && dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +		u16 dev_id = pci_dev_id(pdev);
> +		u16 domain_nr = pci_domain_nr(pdev->bus);
> +
> +		if (domain_nr >= id->segment_start &&
> +		    domain_nr <= id->segment_end &&
> +		    dev_id >= id->bdf_start &&
> +		    dev_id <= id->bdf_end) {
> +			*epid_base = ((u32)(domain_nr - id->segment_start) << 16) +
> +				dev_id - id->bdf_start;
> +			return true;
> +		}
> +	} else if (id->type == VIOT_DEV_TYPE_MMIO && dev_is_platform(dev)) {
> +		struct platform_device *plat_dev = to_platform_device(dev);
> +		struct resource *mem;
> +
> +		mem = platform_get_resource(plat_dev, IORESOURCE_MEM, 0);
> +		if (mem && mem->start == id->base) {
> +			*epid_base = 0;
> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
> +static const struct iommu_ops *viot_iommu_setup(struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct viot_iommu *viommu = NULL;
> +	struct viot_endpoint *ep;
> +	u32 epid;
> +	int ret;
> +
> +	/* Already translated? */
> +	if (fwspec && fwspec->ops)
> +		return NULL;
> +
> +	mutex_lock(&viommus_lock);
> +	list_for_each_entry(ep, &viot_endpoints, list) {
> +		if (viot_device_match(dev, &ep->dev_id, &epid)) {
> +			epid += ep->endpoint_id;
> +			viommu = ep->viommu;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&viommus_lock);
> +	if (!viommu)
> +		return NULL;
> +
> +	/* We're not translating ourself */
> +	if (viot_device_match(dev, &viommu->dev_id, &epid))
> +		return NULL;
maybe check that first?
> +
> +	/*
> +	 * If we found a PCI range managed by the viommu, we're the one that has
> +	 * to request ACS.
> +	 */
> +	if (dev_is_pci(dev))
> +		pci_request_acs();
> +
> +	if (!viommu->ops || WARN_ON(!viommu->dev))
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	ret = iommu_fwspec_init(dev, viommu->dev->fwnode, viommu->ops);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	iommu_fwspec_add_ids(dev, &epid, 1);
> +
> +	/*
> +	 * If we have reason to believe the IOMMU driver missed the initial
> +	 * add_device callback for dev, replay it to get things in order.
> +	 */
> +	if (dev->bus && !device_iommu_mapped(dev))
> +		iommu_probe_device(dev);
> +
> +	return viommu->ops;
> +}
> +
> +/**
> + * acpi_viot_dma_setup - Configure DMA for an endpoint described in VIOT
> + * @dev: the endpoint
> + * @attr: coherency property of the endpoint
> + *
> + * Setup the DMA and IOMMU ops for an endpoint described by the VIOT table.
> + *
> + * Return:
> + * * 0 - @dev doesn't match any VIOT node
> + * * 1 - ops for @dev were successfully installed
> + * * -EPROBE_DEFER - ops for @dev aren't yet available
the returned value is not very conventional. Isn't it possible to make
it easier?
> + */
> +int acpi_viot_dma_setup(struct device *dev, enum dev_dma_attr attr)
> +{
> +	const struct iommu_ops *iommu_ops = viot_iommu_setup(dev);
> +
> +	if (IS_ERR_OR_NULL(iommu_ops)) {
> +		int ret = PTR_ERR(iommu_ops);
> +
> +		if (ret == -EPROBE_DEFER || ret == 0)
> +			return ret;
> +		dev_err(dev, "error %d while setting up virt IOMMU\n", ret);
> +		return 0;
why 0 in case of error != -EPROBE_DEFER
> +	}
> +
> +#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> +	arch_setup_dma_ops(dev, 0, ~0ULL, iommu_ops, attr == DEV_DMA_COHERENT);
> +#else
> +	iommu_setup_dma_ops(dev, 0, ~0ULL);
> +#endif
> +	return 1;
> +}
> +
> +static int viot_set_iommu_ops(struct viot_iommu *viommu, struct device *dev,
> +			      struct iommu_ops *ops)
> +{
> +	/*
> +	 * The IOMMU subsystem relies on fwnode for identifying the IOMMU that
> +	 * manages an endpoint. Create one if necessary, because PCI devices
> +	 * don't always get a fwnode.
> +	 */
> +	if (!dev->fwnode) {
> +		dev->fwnode = acpi_alloc_fwnode_static();
> +		if (!dev->fwnode)
> +			return -ENOMEM;
> +		viommu->static_fwnode = true;
> +	}
> +	viommu->dev = dev;
> +	viommu->ops = ops;
> +
> +	return 0;
> +}
> +
> +static int viot_clear_iommu_ops(struct viot_iommu *viommu)
> +{
> +	struct device *dev = viommu->dev;
> +
> +	viommu->dev = NULL;
> +	viommu->ops = NULL;
> +	if (dev && viommu->static_fwnode) {
> +		acpi_free_fwnode_static(dev->fwnode);
> +		dev->fwnode = NULL;
> +		viommu->static_fwnode = false;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * acpi_viot_set_iommu_ops - Set the IOMMU ops of a virtual IOMMU device
> + * @dev: the IOMMU device (transport)
> + * @ops: the new IOMMU ops or NULL
> + *
> + * Once the IOMMU driver is loaded and the device probed, associate the IOMMU
> + * ops to its VIOT node. Before disabling the IOMMU device, dissociate the ops
> + * from the VIOT node.
> + *
> + * Return 0 on success, an error otherwise
> + */
> +int acpi_viot_set_iommu_ops(struct device *dev, struct iommu_ops *ops)
> +{
> +	int ret = -EINVAL;
> +	struct viot_iommu *viommu;
> +
> +	mutex_lock(&viommus_lock);
> +	list_for_each_entry(viommu, &viot_iommus, list) {
> +		u32 epid;
> +
> +		if (!viot_device_match(dev, &viommu->dev_id, &epid))
> +			continue;
> +
> +		if (ops)
> +			ret = viot_set_iommu_ops(viommu, dev, ops);
> +		else
> +			ret = viot_clear_iommu_ops(viommu);
> +		break;
> +	}
> +	mutex_unlock(&viommus_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(acpi_viot_set_iommu_ops);
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 2bfdd5734844..054d8405a2db 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -7,6 +7,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/acpi_viot.h>
>  #include <linux/amba/bus.h>
>  #include <linux/delay.h>
>  #include <linux/dma-iommu.h>
> @@ -1065,6 +1066,7 @@ static int viommu_probe(struct virtio_device *vdev)
>  	if (ret)
>  		goto err_free_vqs;
>  
> +	acpi_viot_set_iommu_ops(parent_dev, &viommu_ops);
>  	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
>  	iommu_device_set_fwnode(&viommu->iommu, parent_dev->fwnode);
>  
> @@ -1111,6 +1113,7 @@ static void viommu_remove(struct virtio_device *vdev)
>  {
>  	struct viommu_dev *viommu = vdev->priv;
>  
> +	acpi_viot_set_iommu_ops(vdev->dev.parent, NULL);
>  	iommu_device_sysfs_remove(&viommu->iommu);
>  	iommu_device_unregister(&viommu->iommu);
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa84121c5611..799c020fca87 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -432,6 +432,14 @@ W:	https://01.org/linux-acpi
>  B:	https://bugzilla.kernel.org
>  F:	drivers/acpi/acpi_video.c
>  
> +ACPI VIOT DRIVER
> +M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
> +L:	linux-acpi@vger.kernel.org
> +L:	iommu@lists.linux-foundation.org
> +S:	Maintained
> +F:	drivers/acpi/viot.c
> +F:	include/linux/acpi_viot.h
> +
>  ACPI WMI DRIVER
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Orphan
> 
Thanks

Eric

