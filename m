Return-Path: <linux-acpi+bounces-695-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DE47CC5F9
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 16:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A2ECB210BC
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 14:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7ED4446E
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stjnb6o+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA3A43A84;
	Tue, 17 Oct 2023 14:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DADC433C8;
	Tue, 17 Oct 2023 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697552392;
	bh=etij5pZieyxCI6aPKwj5dh6CqdwJgHYWaSOg3qL4NPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stjnb6o+/89QUpAww8JudSzBURcKih0pKr/3wc2EIbkqWTsOkzfs/cz2RGdvsnx06
	 XsObkhHsz47OkrxKINmiYoMmedfSZ/9asTmcwHEg936zha5X3UFm+OyNOhO7LsbF0m
	 t4oC5W/g6di4MMKpItQJh3zCfd50Slq27wlcCaXgSNkWCtvL61ws/Gj/x9RsyjyIuP
	 R6WHrb0HTU5MT389BVtuZuFHFyfSxC6m/2IIUcmKtCZ3pmBurT4h6664fl2YrTW84c
	 jRg+I0td3OfpmTIcHmSOZnw+E9A8xNsG/lv2i5xPl3C9J8C3wGFNLPK65H2ssvd/7D
	 u8Z17ZIa1F1yQ==
Date: Tue, 17 Oct 2023 16:19:46 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org, maz@kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Fang Xiang <fangxiang3@xiaomi.com>
Subject: Re: [PATCH v3 5/5] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes ACPI probing
Message-ID: <ZS6YAvoz3JApFtOo@lpieralisi>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231006125929.48591-1-lpieralisi@kernel.org>
 <20231006125929.48591-6-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006125929.48591-6-lpieralisi@kernel.org>

On Fri, Oct 06, 2023 at 02:59:29PM +0200, Lorenzo Pieralisi wrote:
> The GIC architecture specification defines a set of registers
> for redistributors and ITSes that control the sharebility and
> cacheability attributes of redistributors/ITSes initiator ports
> on the interconnect (GICR_[V]PROPBASER, GICR_[V]PENDBASER,
> GITS_BASER<n>).
> 
> Architecturally the GIC provides a means to drive shareability
> and cacheability attributes signals and related IWB/OWB/ISH barriers
> but it is not mandatory for designs to wire up the corresponding
> interconnect signals that control the cacheability/shareability
> of transactions.
> 
> Redistributors and ITSes interconnect ports can be connected to
> non-coherent interconnects that are not able to manage the
> shareability/cacheability attributes; this implicitly makes
> the redistributors and ITSes non-coherent observers.
> 
> So far, the GIC driver on probe executes a write to "probe" for
> the redistributors and ITSes registers shareability bitfields
> by writing a value (ie InnerShareable - the shareability domain the
> CPUs are in) and check it back to detect whether the value sticks or
> not; this hinges on a GIC programming model behaviour that predates the
> current specifications, that just define shareability bits as writeable
> but do not guarantee that writing certain shareability values
> enable the expected behaviour for the redistributors/ITSes
> memory interconnect ports.
> 
> To enable non-coherent GIC designs on ACPI based systems, parse the MADT
> GICC/GICR/ITS subtables non-coherent flags to determine whether the
> respective components are non-coherent observers and force the shareability
> attributes to be programmed into the redistributors and ITSes registers.
> 
> An ACPI global function (acpi_get_madt_revision()) is added to retrieve
> the MADT revision, in that it is essential to check the MADT revision
> before checking for flags that were added with MADT revision 7 so that
> if the kernel is booted with ACPI tables (MADT rev < 7) it skips parsing
> the newly added flags (that should be zeroed reserved values for MADT
> versions < 7 but they could turn out to be buggy and should be ignored).
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/acpi/processor_core.c    | 21 +++++++++++++++++++++
>  drivers/irqchip/irq-gic-common.h |  8 ++++++++
>  drivers/irqchip/irq-gic-v3-its.c |  4 ++++
>  drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
>  include/linux/acpi.h             |  3 +++
>  5 files changed, 45 insertions(+)

Hi Marc,

just a quick note to ask if, from an ACPI binding POW
this patch and related approach make sense to you.

If so, we can start the process to get the ACPI changes drafted
in:

https://bugzilla.tianocore.org/show_bug.cgi?id=4557

and deployed in this patch into the ACPI specs, I can log
an "ACK" in the tianocoreBZ entry above (we will be able to
rework the code as much as we want, this is just for the
bindings).

Thanks,
Lorenzo

> 
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index 7dd6dbaa98c3..d3c7c6b0bb23 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -215,6 +215,27 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
>  	return rv;
>  }
>  
> +u8 __init acpi_get_madt_revision(void)
> +{
> +	static u8 madt_revision __initdata;
> +	static bool madt_read __initdata;
> +	struct acpi_table_header *madt = NULL;
> +
> +	if (!madt_read) {
> +		madt_read = true;
> +
> +		acpi_get_table(ACPI_SIG_MADT, 0, &madt);
> +		if (!madt)
> +			return madt_revision;
> +
> +		madt_revision = madt->revision;
> +
> +		acpi_put_table(madt);
> +	}
> +
> +	return madt_revision;
> +}
> +
>  static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
>  {
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
> index f407cce9ecaa..8dffee95f7e8 100644
> --- a/drivers/irqchip/irq-gic-common.h
> +++ b/drivers/irqchip/irq-gic-common.h
> @@ -6,6 +6,7 @@
>  #ifndef _IRQ_GIC_COMMON_H
>  #define _IRQ_GIC_COMMON_H
>  
> +#include <linux/acpi.h>
>  #include <linux/of.h>
>  #include <linux/irqdomain.h>
>  #include <linux/irqchip/arm-gic-common.h>
> @@ -29,6 +30,13 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
>  void gic_enable_of_quirks(const struct device_node *np,
>  			  const struct gic_quirk *quirks, void *data);
>  
> +#ifdef CONFIG_ACPI
> +static inline bool gic_acpi_non_coherent_flag(u32 flags, u32 mask)
> +{
> +	return (acpi_get_madt_revision() >= 7) && (flags & mask);
> +}
> +#endif
> +
>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
>  #define RDIST_FLAGS_RD_TABLES_PREALLOCATED     (1 << 1)
>  #define RDIST_FLAGS_FORCE_NON_SHAREABLE        (1 << 2)
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 75a2dd550625..72ae9422a26f 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -5574,6 +5574,10 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
>  		goto node_err;
>  	}
>  
> +	if (gic_acpi_non_coherent_flag(its_entry->flags,
> +				       ACPI_MADT_ITS_NON_COHERENT))
> +		its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
> +
>  	err = its_probe_one(its);
>  	if (!err)
>  		return 0;
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index f59ac9586b7b..720d76790ada 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -2364,6 +2364,11 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
>  		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
>  		return -ENOMEM;
>  	}
> +
> +	if (gic_acpi_non_coherent_flag(redist->flags,
> +				       ACPI_MADT_GICR_NON_COHERENT))
> +		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> +
>  	gic_request_region(redist->base_address, redist->length, "GICR");
>  
>  	gic_acpi_register_redist(redist->base_address, redist_base);
> @@ -2389,6 +2394,10 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
>  		return -ENOMEM;
>  	gic_request_region(gicc->gicr_base_address, size, "GICR");
>  
> +	if (gic_acpi_non_coherent_flag(gicc->flags,
> +				       ACPI_MADT_GICC_NON_COHERENT))
> +		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> +
>  	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
>  	return 0;
>  }
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index a73246c3c35e..56e4e5f39a62 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -298,6 +298,9 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
>  	return phys_id == PHYS_CPUID_INVALID;
>  }
>  
> +
> +u8 __init acpi_get_madt_revision(void);
> +
>  /* Validate the processor object's proc_id */
>  bool acpi_duplicate_processor_id(int proc_id);
>  /* Processor _CTS control */
> -- 
> 2.34.1
> 

