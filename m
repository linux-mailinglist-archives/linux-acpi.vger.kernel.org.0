Return-Path: <linux-acpi+bounces-14238-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5456AD1BAC
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 12:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7133A2629
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 10:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2E11714B7;
	Mon,  9 Jun 2025 10:38:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165E02F37;
	Mon,  9 Jun 2025 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749465524; cv=none; b=uc5Ak3I6i0JP3QJEfSgGsFFkkEtOxp8qMqXjmLCVgyuvjSRpS7kBGNT6QbGOxheWzDuyhQIF36CF4wXhW9rf4IeTCOdKjOpOyziSSpfOdehAuXzS71+t26xMt3fSKXCD5sidCm8pT8nfYryHjTKFwfgYEzgZ8FPs09c/Fp8zDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749465524; c=relaxed/simple;
	bh=cvB3nlj+o9VLt57QzMSDSel/B0wzUOOU0GTqYv4eM0o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elLLqliAGYn8ahiOPOq7S6wLXQhWkFaJUlezWXhJsKTRLrqLB1idkZafHymI4aCe/gGBnlUmFedDlwUs1Vkiysf1nEWQsccNTisJhviMRgG30cK99d6UO0w6Vtvso5YDa3BzZNfNYJ2Acj9kyfLY4HuUVsUKdkM7BULZfJfWlug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bG7db5CXwz6L4s6;
	Mon,  9 Jun 2025 18:36:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F47814038F;
	Mon,  9 Jun 2025 18:38:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 12:38:37 +0200
Date: Mon, 9 Jun 2025 11:38:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] cxl: Remove core/acpi.c and cxl core dependency on ACPI
Message-ID: <20250609113836.0000558a@huawei.com>
In-Reply-To: <20250605001148.1698633-1-dave.jiang@intel.com>
References: <20250605001148.1698633-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 4 Jun 2025 17:11:47 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> It was a mistake to introduce core/acpi.c and putting ACPI dependency on
> cxl_core when adding the extended linear cache support. Add a callback
> in the cxl_root_decoder to retrieve the extended linear cache size from
> ACPI via the cxl_acpi driver.
> 
> In order to deal with cxl_test, a device parameter had to be introduced
> to the hmat_get_extended_linear_cache_size() call in order to help with
> the mock wrapped function from ACPI. Even though the 'struct device' is
> not used by the actual hmat_get_extended_linear_cache_size() function.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/numa/hmat.c      |  4 +++-
>  drivers/cxl/acpi.c            | 15 ++++++++++++++-
>  drivers/cxl/core/Makefile     |  1 -
>  drivers/cxl/core/acpi.c       | 11 -----------
>  drivers/cxl/core/core.h       |  2 --
>  drivers/cxl/core/port.c       |  5 ++++-
>  drivers/cxl/core/region.c     |  6 +++++-
>  drivers/cxl/cxl.h             | 12 +++++++++++-
>  include/linux/acpi.h          |  6 ++++--
>  tools/testing/cxl/Kbuild      |  2 +-
>  tools/testing/cxl/test/cxl.c  | 20 ++++++++++++++++++++
>  tools/testing/cxl/test/mock.c | 23 +++++++++++++++++++++++
>  tools/testing/cxl/test/mock.h |  4 ++++
>  13 files changed, 89 insertions(+), 22 deletions(-)
>  delete mode 100644 drivers/cxl/core/acpi.c
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 9d9052258e92..bc8441dc7fe2 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -110,6 +110,7 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
>  
>  /**
>   * hmat_get_extended_linear_cache_size - Retrieve the extended linear cache size
> + * @dev: device for debug output

This seems misleading given it isn't used for that.  Hmm. I guess we don't really want
to shout that we need it for stubbing.

I think we need acpi maintainer buy in for this. +CC linux-acpi, Len and Rafael.

>   * @backing_res: resource from the backing media
>   * @nid: node id for the memory region
>   * @cache_size: (Output) size of extended linear cache.
> @@ -117,7 +118,8 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
>   * Return: 0 on success. Errno on failure.
>   *
>   */
> -int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
> +int hmat_get_extended_linear_cache_size(struct device *dev,
> +					struct resource *backing_res, int nid,
>  					resource_size_t *cache_size)
>  {
>  	unsigned int pxm = node_to_pxm(nid);
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index cb14829bb9be..7076d471ada5 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -337,6 +337,19 @@ static int add_or_reset_cxl_resource(struct resource *parent, struct resource *r
>  	return rc;
>  }
>  
> +static int cxl_acpi_get_extended_linear_cache_size(struct cxl_root_decoder *cxlrd,
> +						   struct resource *backing_res,
> +						   int nid,
> +						   resource_size_t *size)
> +{
> +	return hmat_get_extended_linear_cache_size(&cxlrd->cxlsd.cxld.dev,
> +						   backing_res, nid, size);
> +}
> +
> +static const struct cxl_rcd_ops acpi_rcd_ops = {
> +	.get_extended_linear_cache_size = cxl_acpi_get_extended_linear_cache_size,
> +};
> +
>  DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
>  	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
>  DEFINE_FREE(del_cxl_resource, struct resource *, if (_T) del_cxl_resource(_T))
> @@ -375,7 +388,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  		return rc;
>  
>  	struct cxl_root_decoder *cxlrd __free(put_cxlrd) =
> -		cxl_root_decoder_alloc(root_port, ways);
> +		cxl_root_decoder_alloc(root_port, ways, &acpi_rcd_ops);
>  
>  	if (IS_ERR(cxlrd))
>  		return PTR_ERR(cxlrd);
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 086df97a0fcf..f67e879dbf9a 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -15,7 +15,6 @@ cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
>  cxl_core-y += ras.o
> -cxl_core-y += acpi.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
> diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
> deleted file mode 100644
> index f13b4dae6ac5..000000000000
> --- a/drivers/cxl/core/acpi.c
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> -#include <linux/acpi.h>
> -#include "cxl.h"
> -#include "core.h"
> -
> -int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
> -					    int nid, resource_size_t *size)
> -{
> -	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
> -}
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 17b692eb3257..719cee0de1ec 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -120,8 +120,6 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  int cxl_ras_init(void);
>  void cxl_ras_exit(void);
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> -int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
> -					    int nid, resource_size_t *size);
>  
>  #ifdef CONFIG_CXL_FEATURES
>  size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 726bd4a7de27..89b4cdc2bd8c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1800,6 +1800,7 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
>   * cxl_root_decoder_alloc - Allocate a root level decoder
>   * @port: owning CXL root of this decoder
>   * @nr_targets: static number of downstream targets
> + * @ops: root decoder callback operations
>   *
>   * Return: A new cxl decoder to be registered by cxl_decoder_add(). A
>   * 'CXL root' decoder is one that decodes from a top-level / static platform
> @@ -1807,7 +1808,8 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
>   * topology.
>   */
>  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> -						unsigned int nr_targets)
> +						unsigned int nr_targets,
> +						const struct cxl_rcd_ops *ops)
>  {
>  	struct cxl_root_decoder *cxlrd;
>  	struct cxl_switch_decoder *cxlsd;
> @@ -1846,6 +1848,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>  
>  	atomic_set(&cxlrd->region_id, rc);
>  	cxlrd->qos_class = CXL_QOS_CLASS_INVALID;
> +	cxlrd->ops = ops;
>  	return cxlrd;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, "CXL");
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3f4dc244df7..ac05fe7335c9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3239,7 +3239,11 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>  	resource_size_t cache_size, start;
>  	int rc;
>  
> -	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
> +	if (!cxlrd->ops || !cxlrd->ops->get_extended_linear_cache_size)
> +		return -EOPNOTSUPP;
> +
> +	rc = cxlrd->ops->get_extended_linear_cache_size(cxlrd, res, nid,
> +							&cache_size);
>  	if (rc)
>  		return rc;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a9ab46eb0610..899092835e04 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -420,6 +420,12 @@ struct cxl_switch_decoder {
>  struct cxl_root_decoder;
>  typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
>  
> +struct cxl_rcd_ops {
> +	int (*get_extended_linear_cache_size)(struct cxl_root_decoder *cxlrd,
> +					      struct resource *backing_res,
> +					      int nid, resource_size_t *size);
> +};
> +
>  /**
>   * struct cxl_root_decoder - Static platform CXL address decoder
>   * @res: host / parent resource for region allocations
> @@ -428,6 +434,7 @@ typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
>   * @platform_data: platform specific configuration data
>   * @range_lock: sync region autodiscovery by address range
>   * @qos_class: QoS performance class cookie
> + * @ops: root decoder specific operations
>   * @cxlsd: base cxl switch decoder
>   */
>  struct cxl_root_decoder {
> @@ -437,7 +444,9 @@ struct cxl_root_decoder {
>  	void *platform_data;
>  	struct mutex range_lock;
>  	int qos_class;
> +	const struct cxl_rcd_ops *ops;
>  	struct cxl_switch_decoder cxlsd;
> +	/* DO NOT ADD ANYTHING AFTER THIS LINE. cxlsd trails with a flex array */
Valid change, but not part of this patch.

>  };
>  
>  /*
> @@ -772,7 +781,8 @@ bool is_root_decoder(struct device *dev);
>  bool is_switch_decoder(struct device *dev);
>  bool is_endpoint_decoder(struct device *dev);
>  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> -						unsigned int nr_targets);
> +						unsigned int nr_targets,
> +						const struct cxl_rcd_ops *ops);
>  struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
>  						    unsigned int nr_targets);
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 3f2e93ed9730..507aa15913d2 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1095,10 +1095,12 @@ static inline acpi_handle acpi_get_processor_handle(int cpu)
>  #endif	/* !CONFIG_ACPI */
>  
>  #ifdef CONFIG_ACPI_HMAT
> -int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
> +int hmat_get_extended_linear_cache_size(struct device *dev,
> +					struct resource *backing_res, int nid,
>  					resource_size_t *size);
>  #else
> -static inline int hmat_get_extended_linear_cache_size(struct resource *backing_res,
> +static inline int hmat_get_extended_linear_cache_size(struct device *dev,
> +						      struct resource *backing_res,
>  						      int nid, resource_size_t *size)
>  {
>  	return -EOPNOTSUPP;
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 387f3df8b988..3e6e3c4ab797 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -15,6 +15,7 @@ ldflags-y += --wrap=devm_cxl_add_rch_dport
>  ldflags-y += --wrap=cxl_rcd_component_reg_phys
>  ldflags-y += --wrap=cxl_endpoint_parse_cdat
>  ldflags-y += --wrap=cxl_dport_init_ras_reporting
> +ldflags-y += --wrap=hmat_get_extended_linear_cache_size
>  
>  DRIVERS := ../../../drivers
>  CXL_SRC := $(DRIVERS)/cxl
> @@ -62,7 +63,6 @@ cxl_core-y += $(CXL_CORE_SRC)/hdm.o
>  cxl_core-y += $(CXL_CORE_SRC)/pmu.o
>  cxl_core-y += $(CXL_CORE_SRC)/cdat.o
>  cxl_core-y += $(CXL_CORE_SRC)/ras.o
> -cxl_core-y += $(CXL_CORE_SRC)/acpi.o
>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 1c3336095923..40d9f7b76d01 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -470,6 +470,24 @@ struct cxl_cedt_context {
>  	struct device *dev;
>  };
>  
> +static int mock_hmat_get_extended_linear_cache_size(struct device *dev,
> +						    struct resource *backing_res,
> +						    int nid, resource_size_t *size)
> +{
> +	struct cxl_decoder *cxld;
> +	struct cxl_port *port;
> +
> +	if (!is_root_decoder(dev))

Here is the real reason for the parameter and it's not debug...

> +		return -EINVAL;
> +
> +	cxld = to_cxl_decoder(dev);
> +	port = to_cxl_port(cxld->dev.parent);
> +	if (is_mock_port(&port->dev))
> +		return -EOPNOTSUPP;
> +
> +	return hmat_get_extended_linear_cache_size(dev, backing_res, nid, size);
> +}
> +
>  static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
>  				      acpi_tbl_entry_handler_arg handler_arg,
>  				      void *arg)
> @@ -1040,6 +1058,8 @@ static struct cxl_mock_ops cxl_mock_ops = {
>  	.devm_cxl_enumerate_decoders = mock_cxl_enumerate_decoders,
>  	.cxl_endpoint_parse_cdat = mock_cxl_endpoint_parse_cdat,
>  	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
> +	.hmat_get_extended_linear_cache_size =
> +		mock_hmat_get_extended_linear_cache_size,
>  };
>  
>  static void mock_companion(struct acpi_device *adev, struct device *dev)
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index af2594e4f35d..69aa3deee6c2 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -78,6 +78,29 @@ int __wrap_acpi_table_parse_cedt(enum acpi_cedt_type id,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_acpi_table_parse_cedt, "ACPI");
>  
> +int __wrap_hmat_get_extended_linear_cache_size(struct device *dev,
> +					       struct resource *backing_res,
> +					       int nid,
> +					       resource_size_t *size)
> +{
> +	int index;
> +	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> +	int rc;
> +
> +	if (ops)
> +		rc = ops->hmat_get_extended_linear_cache_size(dev,
> +							      backing_res, nid,
> +							      size);
> +	else
> +		rc = hmat_get_extended_linear_cache_size(dev, backing_res,
> +							 nid, size);
> +
> +	put_cxl_mock_ops(index);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(__wrap_hmat_get_extended_linear_cache_size, "CXL");
> +
>  acpi_status __wrap_acpi_evaluate_integer(acpi_handle handle,
>  					 acpi_string pathname,
>  					 struct acpi_object_list *arguments,
> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
> index d1b0271d2822..240ad3d3e6f9 100644
> --- a/tools/testing/cxl/test/mock.h
> +++ b/tools/testing/cxl/test/mock.h
> @@ -26,6 +26,10 @@ struct cxl_mock_ops {
>  	int (*devm_cxl_enumerate_decoders)(
>  		struct cxl_hdm *hdm, struct cxl_endpoint_dvsec_info *info);
>  	void (*cxl_endpoint_parse_cdat)(struct cxl_port *port);
> +	int (*hmat_get_extended_linear_cache_size)(struct device *dev,
> +						   struct resource *backing_res,
> +						   int nid,
> +						   resource_size_t *size);
>  };
>  
>  void register_cxl_mock_ops(struct cxl_mock_ops *ops);
> 
> base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca


