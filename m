Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B5641C515
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Sep 2021 14:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343935AbhI2NBe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Sep 2021 09:01:34 -0400
Received: from foss.arm.com ([217.140.110.172]:39114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343889AbhI2NBe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 Sep 2021 09:01:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA9626D;
        Wed, 29 Sep 2021 05:59:52 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E8223F70D;
        Wed, 29 Sep 2021 05:59:51 -0700 (PDT)
Date:   Wed, 29 Sep 2021 13:59:46 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Xuesong Chen <xuesong.chen@linux.alibaba.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, steve.capper@arm.com, mark.rutland@arm.com,
        rafael@kernel.org, james.morse@arm.com, linux-acpi@vger.kernel.org,
        tony.luck@intel.com, bp@alien8.de
Subject: Re: [PATCH] arm64/apei: Filter the apei GAS address from the ECAM
 space
Message-ID: <20210929125946.GA19100@lpieralisi>
References: <YThgHU7eeLo9wnMW@Dennis-MBP.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YThgHU7eeLo9wnMW@Dennis-MBP.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[+linux-acpi, Rafael, James, Tony, Borislav]

On Wed, Sep 08, 2021 at 03:02:53PM +0800, Xuesong Chen wrote:
> ECAM configuration memory space is reserved during the initializaion of the
> kernel, but sometimes the apei needs to access the GAS address within the
> ECAM space, thus the request_mem_region(...) will be failed in this case,
> the error message looks like:
> ...
> APEI: Can not request [mem 0x50100000-0x50100003] for APEI EINJ Trigger registers
> ...
> 
> This patch provides an arm64 specific filter function to remove the GAS address
> range from the reserved ECAM resource regions, which will make the apei's GAS
> address can pass the check while not affecting the original reserved ECAM area.
> 
> Signed-off-by: Xuesong Chen <xuesong.chen@linux.alibaba.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/kernel/pci.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1006ed2..6096165 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -19,6 +19,13 @@
>  #include <linux/slab.h>
>  
>  #ifdef CONFIG_ACPI
> +struct pci_mcfg_res_region {
> +	struct list_head list;
> +	struct resource res;
> +};
> +
> +static LIST_HEAD(pci_mcfg_res_list);
> +static DEFINE_MUTEX(pci_mcfg_lock);
>  /*
>   * Try to assign the IRQ number when probing a new device
>   */
> @@ -107,6 +114,58 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>  	return status;
>  }
>  
> +#ifdef CONFIG_ACPI_APEI
> +extern int (*arch_apei_filter_addr)(int (*func)(__u64 start, __u64 size,
> +		void *data), void *data);
> +
> +static int pci_mcfg_for_each_region(int (*func)(__u64 start, __u64 size,
> +		void *data), void *data)
> +{
> +	struct pci_mcfg_res_region *e;
> +	int rc = 0;
> +
> +	if (list_empty(&pci_mcfg_res_list))
> +		return 0;
> +
> +	list_for_each_entry(e, &pci_mcfg_res_list, list) {
> +		rc = func(e->res.start, resource_size(&e->res), data);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +#define set_apei_filter() \
> +	do { \
> +		if (!arch_apei_filter_addr) \
> +			arch_apei_filter_addr = pci_mcfg_for_each_region; \
> +	} while (0)
> +#else
> +#define set_apei_filter()
> +#endif
> +
> +static int pci_mcfg_res_add(struct resource *res)
> +{
> +	struct pci_mcfg_res_region *new;
> +
> +	if (!res)
> +		return -EINVAL;
> +
> +	new = kzalloc(sizeof(*new), GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;
> +
> +	new->res.start = res->start;
> +	new->res.end = res->end;
> +
> +	mutex_lock(&pci_mcfg_lock);
> +	list_add(&new->list, &pci_mcfg_res_list);
> +	mutex_unlock(&pci_mcfg_lock);
> +
> +	return 0;
> +}
> +
>  /*
>   * Lookup the bus range for the domain in MCFG, and set up config space
>   * mapping.
> @@ -144,6 +203,11 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>  		return NULL;
>  	}
>  
> +	/* insert the mcfg resource region of current segment into the list */
> +	ret = pci_mcfg_res_add(&cfgres);
> +	if (ret)
> +		dev_warn(dev, "add %pR into the mcfg res list failed\n", &cfgres);
> +
>  	return cfg;
>  }
>  
> @@ -204,6 +268,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	list_for_each_entry(child, &bus->children, node)
>  		pcie_bus_configure_settings(child);
>  
> +	set_apei_filter();
> +
>  	return bus;
>  }

This is an x86 code copy and paste. IIUC, the "arch" resources filtering
(that isn't arch specific at all) was introduced in:

commit d91525eb8ee6 ("ACPI, EINJ: Enhance error injection tolerance
level")

I don't believe though that there is anything arch specific in the
apei_get_arch_resources() implementation, after all what x86 does
is filtering out MCFG regions, with the arch_apei_filter_add(*) that
is not arch specific anyway (ie pci_mmcfg_for_each_region() on x86).

Should we take this opportunity to remove the arch hooks and just
filter out MCFG resources directly in APEI code (because that's what
the arch specific hook does _anyway_) ?

I see no reason to duplicate this for arm64, please let me know
if I am missing something.

Thanks,
Lorenzo
