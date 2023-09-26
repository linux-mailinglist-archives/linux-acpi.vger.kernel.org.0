Return-Path: <linux-acpi+bounces-126-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1513A7AECEB
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 14:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AF6D8280F51
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 12:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EDB27EC8
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 12:33:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12365107B9
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 11:04:24 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2C195;
	Tue, 26 Sep 2023 04:04:22 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rvxfx75XZz6K8Kl;
	Tue, 26 Sep 2023 19:03:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 26 Sep
 2023 12:04:19 +0100
Date: Tue, 26 Sep 2023 12:04:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<bhelgaas@google.com>, <yazen.ghannam@amd.com>
Subject: Re: [PATCH v5 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type
 support
Message-ID: <20230926120418.0000575d@Huawei.com>
In-Reply-To: <20230925200127.504256-3-Benjamin.Cheatham@amd.com>
References: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
	<20230925200127.504256-3-Benjamin.Cheatham@amd.com>
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
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 25 Sep 2023 15:01:26 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add support for CXL EINJ error types for CXL 1.1 hosts added in ACPI
> v6.5. Because these error types target memory-mapped CXL 1.1 compliant
> downstream ports and not physical (normal/persistent) memory, these
> error types are not currently  allowed through the memory range
> validation done by the EINJ driver.
> 
> The MMIO address of a CXL 1.1 downstream port can be found in the
> cxl_rcrb_addr file in the corresponding dport directory under
> /sys/bus/cxl/devices/portX. CXL 1.1 error types follow the same
> procedure as a memory error type, but with param1 set to the
> downstream port MMIO address.
> 
> Example usage:
> $ cd /sys/kernel/debug/apei/einj
> $ cat available_error_type
>     0x00000008      Memory Correctable
>     0x00000010      Memory Uncorrectable non-fatal
>     0x00000020      Memory Uncorrectable fatal
>     0x00000040      PCI Express Correctable
>     0x00000080      PCI Express Uncorrectable non-fatal
>     0x00000100      PCI Express Uncorrectable fatal
>     0x00008000      CXL.mem Protocol Correctable
>     0x00020000      CXL.mem Protocol Uncorrectable fatal
> $ echo 0x8000 > error_type
> $ echo 0xfffffffffffff000 > param2
> $ echo 0x2 > flags
> $ cat /sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
> 0xb2f00000
> $ echo 0xb2f00000 > param1
> $ echo 1 > error_inject
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Hi Ben

A few trivial things inline.

Jonathan

> ---
>  drivers/acpi/apei/Kconfig |  2 ++
>  drivers/acpi/apei/einj.c  | 24 +++++++++++++++++++++++-
>  drivers/cxl/acpi.c        |  1 +
>  drivers/cxl/core/port.c   | 17 +++++++++++++++++
>  drivers/cxl/cxl.h         |  1 +
>  include/linux/cxl.h       | 11 +++++++++++
>  6 files changed, 55 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/cxl.h
> 
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index 6b18f8bc7be3..eb9cc7157342 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -55,6 +55,8 @@ config ACPI_APEI_MEMORY_FAILURE
>  config ACPI_APEI_EINJ
>  	tristate "APEI Error INJection (EINJ)"
>  	depends on ACPI_APEI && DEBUG_FS
> +	imply CXL_BUS
> +	imply CXL_ACPI
>  	help
>  	  EINJ provides a hardware error injection mechanism, it is
>  	  mainly used for debugging and testing the other parts of
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 013eb621dc92..8000417a5f26 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -21,6 +21,7 @@
>  #include <linux/nmi.h>
>  #include <linux/delay.h>
>  #include <linux/mm.h>
> +#include <linux/cxl.h>
>  #include <asm/unaligned.h>
>  
>  #include "apei-internal.h"
> @@ -36,6 +37,7 @@
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>  				ACPI_EINJ_MEMORY_FATAL)
> +#define CXL_ERROR_MASK		GENMASK(17, 12)
>  
>  /*
>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
> @@ -512,6 +514,22 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	return rc;
>  }
>  
> +static int is_valid_cxl_addr(u64 addr)
> +{
> +	struct cxl_dport *dport;
> +
> +	if (IS_REACHABLE(CONFIG_CXL_ACPI))
> +		dport = cxl_find_rch_dport_by_rcrb((resource_size_t) addr);
> +	else
> +		return 0;
Flip this logic probably so the quick exit is the indented path.

	if (!IS_REACHABLE(CONFIG_CXL_ACPI))
		return 0

	dport = ...

> +
> +	if (!IS_ERR_OR_NULL(dport))
> +		return 1;
> +
> +	pr_info("Could not find dport with rcrb 0x%llx\n", addr);
> +	return 0;
> +}
> +
>  /* Inject the specified hardware error */
>  static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  			     u64 param3, u64 param4)
> @@ -537,8 +555,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	if (type & ACPI5_VENDOR_BIT) {
>  		if (vendor_flags != SETWA_FLAGS_MEM)
>  			goto inject;
> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>  		goto inject;
> +	} else if (type & CXL_ERROR_MASK && is_valid_cxl_addr(param1)) {
> +		goto inject;
> +	}
>  
>  	/*
>  	 * Disallow crazy address masks that give BIOS leeway to pick
> @@ -807,3 +828,4 @@ module_exit(einj_exit);
>  MODULE_AUTHOR("Huang Ying");
>  MODULE_DESCRIPTION("APEI Error INJection support");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3e2ca946bf47..a7adf3d9814e 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -756,6 +756,7 @@ static void __exit cxl_acpi_exit(void)
>  {
>  	platform_driver_unregister(&cxl_acpi_driver);
>  	cxl_bus_drain();
> +	set_cxl_root(NULL);

Why this patch rather than previous?

>  }
>  
>  /* load before dax_hmem sees 'Soft Reserved' CXL ranges */
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c3914e73f67e..cb653cb1a1ea 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1147,6 +1147,23 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_rch_dport, CXL);
>  
> +struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base)
> +{
> +	struct cxl_dport *dport;
> +	unsigned long index;
> +
> +	if (!cxl_root)
> +		return ERR_PTR(-ENODEV);
> +
> +	xa_for_each(&cxl_root->dports, index, dport)
> +		if ((dport->rch && dport->rcrb.base != CXL_RESOURCE_NONE)
> +		    && dport->rcrb.base == rcrb_base)

Local style in this file has && at end of line above.

> +			return dport;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_find_rch_dport_by_rcrb, CXL);
> +
>  static int add_ep(struct cxl_ep *new)
>  {
>  	struct cxl_port *port = new->dport->port;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 4d5bce4bae7e..3e6779dbcd23 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -8,6 +8,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/log2.h>
> +#include <linux/cxl.h>
>  #include <linux/io.h>
>  
>  /**
> diff --git a/include/linux/cxl.h b/include/linux/cxl.h
> new file mode 100644
> index 000000000000..6702caa78e7a
> --- /dev/null
> +++ b/include/linux/cxl.h

We have other code outside drivers/cxl that gets to the
CXL headers directly (to avoid this include being created before now).

https://elixir.bootlin.com/linux/v6.6-rc3/source/drivers/perf/cxl_pmu.c#L24

There wasn't much enthusiasm for creating a globally visible header hence
I did that ../cxl stuff for that.

Same probably applies here.

Jonathan

> @@ -0,0 +1,11 @@
> +#ifndef _LINUX_CXL_H
> +#define _LINUX_CXL_H
> +
> +#include <linux/xarray.h>
> +#include <linux/errno.h>
> +
> +struct cxl_dport;
> +
> +struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base);
> +
> +#endif


