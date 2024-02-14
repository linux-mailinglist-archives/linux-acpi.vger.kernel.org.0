Return-Path: <linux-acpi+bounces-3479-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEC1854CAE
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 16:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CA71F2202C
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923FE5C910;
	Wed, 14 Feb 2024 15:28:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED65A0FB;
	Wed, 14 Feb 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924493; cv=none; b=f7P/IQ4r9HZ6p8FmD5q3+N3O7wAmUieAMjz7Az/CI2CFdhYEVswzIlMHyD3ujX6v3HtEaEXIF/KaZMJ6SzL+dJrBvjaj+PrS1BgeyCwZ2HHKTMm39Aho0X1SLwNkPYrrYmWSYgU1nTDyCsabDBTROU03kXRbzceAqHFgTX2zAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924493; c=relaxed/simple;
	bh=A+eIbjDvHi7UOEnnI9wJLmH8/uiMsd9GBXZynJdJOMU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgmlAijp26zBCNTPwuHgiMpwtHnACZb7OJXABn+2xdzjXGRHa3KApb2s/leJrBHsmPbwVMngu/Tvz6+2pKaEatzD+FjXLlqhtU5UMLRFszJzHLV2xN/RqgUxNqv8IczhvT6h2eh7nPeb2IP2/V2onQ3SDjHrLM2pY6TGJp4dMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZhnd6bCxz6K8t3;
	Wed, 14 Feb 2024 23:24:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A505140DD4;
	Wed, 14 Feb 2024 23:28:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 15:28:00 +0000
Date: Wed, 14 Feb 2024 15:27:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <dan.j.williams@intel.com>, <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v11 3/4] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
Message-ID: <20240214152759.000076ec@Huawei.com>
In-Reply-To: <20240208200042.432958-4-Benjamin.Cheatham@amd.com>
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
	<20240208200042.432958-4-Benjamin.Cheatham@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 8 Feb 2024 14:00:41 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Implement CXL helper functions in the EINJ module for getting/injecting
> available CXL protocol error types and export them to sysfs under
> kernel/debug/cxl.
> 
> The kernel/debug/cxl/einj_types file will print the available CXL
> protocol errors in the same format as the available_error_types
> file provided by the EINJ module. The
> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
> error_type and error_inject files provided by the EINJ module, i.e.:
> writing an error type into $dport_dev/einj_inject will inject said error
> type into the CXL dport represented by $dport_dev.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Hi Ben,

Sorry I've not looked at this sooner.

Anyhow, some comments inline. Mostly looks good to me.

Jonathan

> ---
>  Documentation/ABI/testing/debugfs-cxl |  22 ++++
>  MAINTAINERS                           |   1 +
>  drivers/acpi/apei/einj.c              | 158 ++++++++++++++++++++++++--
>  drivers/cxl/core/port.c               |  39 +++++++
>  include/linux/einj-cxl.h              |  45 ++++++++
>  5 files changed, 255 insertions(+), 10 deletions(-)
>  create mode 100644 include/linux/einj-cxl.h
> 
> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> index fe61d372e3fa..bcd985cca66a 100644
> --- a/Documentation/ABI/testing/debugfs-cxl
> +++ b/Documentation/ABI/testing/debugfs-cxl
> @@ -33,3 +33,25 @@ Description:
>  		device cannot clear poison from the address, -ENXIO is returned.
>  		The clear_poison attribute is only visible for devices
>  		supporting the capability.
> +
> +What:		/sys/kernel/debug/cxl/einj_types
> +Date:		January, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Prints the CXL protocol error types made available by
> +		the platform in the format "0x<error number>	<error type>".
> +		The <error number> can be written to einj_inject to inject
> +		<error type> into a chosen dport.

I think it's a limited set, so docs could include what the error_type values can
be?  From this description it's not obvious they are human readable strings.

> +
> +What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
> +Date:		January, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) Writing an integer to this file injects the corresponding
> +		CXL protocol error into $dport_dev ($dport_dev will be a device
> +		name from /sys/bus/pci/devices). The integer to type mapping for
> +		injection can be found by reading from einj_types. If the dport
> +		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
> +		a CXL 2.0 error is injected.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9104430e148e..02d7feb2ed1f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5246,6 +5246,7 @@ L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	drivers/cxl/
>  F:	include/uapi/linux/cxl_mem.h
> +F:  include/linux/einj-cxl.h
>  F:	tools/testing/cxl/
>  
>  COMPUTE EXPRESS LINK PMU (CPMU)
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 73dde21d3e89..9137cc01f791 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -21,6 +21,7 @@
>  #include <linux/nmi.h>
>  #include <linux/delay.h>
>  #include <linux/mm.h>
> +#include <linux/einj-cxl.h>
>  #include <linux/platform_device.h>
>  #include <asm/unaligned.h>
>  
> @@ -37,6 +38,20 @@
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>  				ACPI_EINJ_MEMORY_FATAL)
> +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
> +#endif
> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
> +				ACPI_EINJ_CXL_CACHE_FATAL | \
> +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
> +				ACPI_EINJ_CXL_MEM_FATAL)
>  
>  /*
>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
> @@ -543,8 +558,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	if (type & ACPI5_VENDOR_BIT) {
>  		if (vendor_flags != SETWA_FLAGS_MEM)
>  			goto inject;
> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>  		goto inject;
> +	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
> +		goto inject;
> +	}
>  
>  	/*
>  	 * Disallow crazy address masks that give BIOS leeway to pick
> @@ -596,6 +614,9 @@ static const char * const einj_error_type_string[] = {
>  	"0x00000200\tPlatform Correctable\n",
>  	"0x00000400\tPlatform Uncorrectable non-fatal\n",
>  	"0x00000800\tPlatform Uncorrectable fatal\n",
> +};
> +
> +static const char * const einj_cxl_error_type_string[] = {
>  	"0x00001000\tCXL.cache Protocol Correctable\n",
>  	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
>  	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
> @@ -621,29 +642,44 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  
>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>  
> -static int error_type_get(void *data, u64 *val)
> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>  {
> -	*val = error_type;
> +	int cxl_err, rc;
> +	u32 available_error_type = 0;
> +
> +	if (!einj_initialized)
> +		return -ENXIO;
> +
> +	rc = einj_get_available_error_type(&available_error_type);
> +	if (rc)
> +		return rc;
> +
> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {

Trivial so feel free to ignore but, I'd stick to local styles and have pos
declared in more traditional c style.

> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;

Maybe clearer as
		cxl_err = FIELD_PREP(CXL_ERROR_MASK, BIT(pos));

> +
> +		if (available_error_type & cxl_err)
> +			seq_puts(m, einj_cxl_error_type_string[pos]);
> +	}
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
>  
> -static int error_type_set(void *data, u64 val)
> +static int validate_error_type(u64 type)
>  {
> +	u32 tval, vendor, available_error_type = 0;
>  	int rc;
> -	u32 available_error_type = 0;
> -	u32 tval, vendor;
>  
>  	/* Only low 32 bits for error type are valid */
> -	if (val & GENMASK_ULL(63, 32))
> +	if (type & GENMASK_ULL(63, 32))
>  		return -EINVAL;
>  
>  	/*
>  	 * Vendor defined types have 0x80000000 bit set, and
>  	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
>  	 */
> -	vendor = val & ACPI5_VENDOR_BIT;
> -	tval = val & 0x7fffffff;
> +	vendor = type & ACPI5_VENDOR_BIT;
> +	tval = type & 0x7fffffff;

Could flip this to GENMASK whilst you are here.
I don't much like counting fs :)


>  
>  	/* Only one error type can be specified */
>  	if (tval & (tval - 1))
> @@ -652,9 +688,105 @@ static int error_type_set(void *data, u64 val)
>  		rc = einj_get_available_error_type(&available_error_type);
>  		if (rc)
>  			return rc;
> -		if (!(val & available_error_type))
> +		if (!(type & available_error_type))
>  			return -EINVAL;
>  	}
> +
> +	return 0;
> +}
> +
> +static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
> +{
> +	struct pci_bus *pbus;
> +	struct pci_host_bridge *bridge;
> +	u64 seg = 0, bus;
> +
> +	pbus = dport_dev->bus;
> +	bridge = pci_find_host_bridge(pbus);
> +
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)

Ah. x86 is not using the CONFIG_PCI_DOMAINS_GENERIC
so I guess we can't just use pci_domain_nr(pbus)?
(for the generic case bus->domain_nr is filled in when
the host bridge is registered). Pity.

> +		seg = bridge->domain_nr << 24;
> +
> +	bus = pbus->number << 16;
I'd do the shifts whilst building sbpf.
AS it stands you end up with what look to be wrong values in
seg and bus because you'd shifted them in the local variables.

> +	*sbdf = seg | bus | dport_dev->devfn;
	*sbdf = (seg << 24) | (bus << 16) | dport_dev->devfn;

(with shifts dropped where seg and bus are set)
> +
> +	return 0;
> +}
> +
> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
> +{
> +	u64 param1 = 0, param2 = 0, param4 = 0;
> +	u32 flags;
> +	int rc;
> +
> +	if (!einj_initialized)
> +		return -ENXIO;
> +
> +	/* Only CXL error types can be specified */
> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))

As below - a utility function would unify the 3 uses of this and
avoid need for comment.

> +		return -EINVAL;
> +
> +	rc = validate_error_type(type);
> +	if (rc)
> +		return rc;
> +
> +	param1 = (u64) rcrb;
already a u64
> +	param2 = 0xfffffffffffff000;
No need to initialize these to 0 above.
> +	flags = 0x2;
> +
> +	return einj_error_inject(type, flags, param1, param2, 0, param4);

	return einj_error_inject(type, flags,
				 rcrb, 0xfffffffffffff000, 0, 0);

> +}
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
> +
> +int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
> +{
> +	u64 param1 = 0, param2 = 0, param4 = 0;
> +	u32 flags;
> +	int rc;
> +
> +	if (!einj_initialized)
> +		return -ENXIO;
> +
> +	/* Only CXL error types can be specified */
> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))

As below a utility function would do this nicely (and avoid need
for comment).
	if (!is_cxl_error(type))

> +		return -EINVAL;
> +
> +	rc = validate_error_type(type);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_dport_get_sbdf(dport, &param4);
> +	if (rc)
> +		return rc;
> +
> +	flags = 0x4;
> +
> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
Why not
	return einj_error_injecT(type, 0x4, 0, 0, 0, param4);
?

Maybe flags is useful as "documentation" but given the parameters are nicely
in order and you already didn't bother with param3, I can't see why
keeping param1 and param2 as local variables is useful.

> +}
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);



> +
> +static int error_type_set(void *data, u64 val)
> +{
> +	int rc;
> +
> +	/* CXL error types have to be injected from cxl debugfs */
> +	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))

Given you have inverse of this above, maybe it's worth a little
helper function to have the logic only once?

	if (is_cxl_error(val))

> +		return -EINVAL;
> +
> +	rc = validate_error_type(val);
> +	if (rc)
> +		return rc;
> +
>  	error_type = val;
>  
>  	return 0;
> @@ -690,6 +822,12 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
>  	return 0;
>  }


> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8c00fd6be730..c52c92222be5 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c

> +static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
> +{
> +	struct dentry *dir;
> +
> +	/*
> +	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
> +	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
> +	 */
> +	if (!einj_is_initialized() ||
> +	    (!dport->rch && !dev_is_pci(dport->dport_dev)))
> +		return;

Trivial: Even though it's a little more code I'd break this up so that it's clear
exactly what the comment refers to.

	if (!einj_is_initialized)
		return;

	/*
	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
	 */
	if (!dport->rch && !dev_is_pci(dport->dport_dev))
		return;
> +
> +	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
> +
> +	debugfs_create_file("einj_inject", 0200, dir, dport,
> +			    &cxl_einj_inject_fops);
> +}
> +
>  static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  					    struct device *uport_dev,
>  					    resource_size_t component_reg_phys,

...

> @@ -2220,6 +2254,11 @@ static __init int cxl_core_init(void)
>  
>  	cxl_debugfs = debugfs_create_dir("cxl", NULL);
>  
> +	if (einj_is_initialized()) {
> +		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
> +				    &einj_cxl_available_error_type_fops);
> +	}
> +
>  	cxl_mbox_init();
>  
>  	rc = cxl_memdev_init();


> diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
> new file mode 100644
> index 000000000000..af57cc8580a6
> --- /dev/null
> +++ b/include/linux/einj-cxl.h


> +
> +#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
> +int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
> +bool einj_is_initialized(void);
> +#else

It's trivial but if you are respinning, I'd like to see a comment for the
else and the endif to let us trivially see what they match with.
Lack of indenting for this preprocessor conditions can make this really
hard to undwind once a file grows more complex over time.

> +static inline int einj_cxl_available_error_type_show(struct seq_file *m,
> +						     void *v)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline int einj_cxl_type_show(struct seq_file *m, void *data)

A stub for a function that doesn't exist otherwise.  Left
over from refactors?

> +{
> +	return -ENXIO;
> +}
> +
> +static inline int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline bool einj_is_initialized(void) { return false; }
> +#endif
> +
> +#endif


