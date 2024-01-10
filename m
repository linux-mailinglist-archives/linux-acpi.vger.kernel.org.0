Return-Path: <linux-acpi+bounces-2746-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A8B826AF7
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jan 2024 10:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2611C21EF2
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jan 2024 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EF211CAE;
	Mon,  8 Jan 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipC7q4tS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D53513FE7;
	Mon,  8 Jan 2024 09:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A900C433C7;
	Mon,  8 Jan 2024 09:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704707008;
	bh=Aih2F5cGcoamxFoc0gYVcyJ3Nz3k9bzZVYeZ861YObY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipC7q4tSwNaPCRH5iOVzwf38SH76rPNQgW24odvmVa1A6slnfi2qw6IWskVCDu/04
	 BORoo3359AR07a1TepmlvGD35dPZPhtD2MoHLLcmtMsIMMiFItiRfDRvCcf5SMWf07
	 dTuvbs/KG/WRWBgIeSffl3DExldEAw4lwe5ok4i86PGRF3cPoOYtiPHe+LhabUsJ6Y
	 1r7UINyhXE6c3jwVYS/kodtI/gnOdYHOgKm/9znBfB8CWiRlSJozcPkrFCl1VlkvBJ
	 g8dP1BGq/uXGcmmRn5eYjVyNiRFNT2p40/29TFwJzAIo9lzCByn0Xm2QhbqMJpwXKV
	 oWxxChuKI3B9Q==
Date: Mon, 8 Jan 2024 10:43:23 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, Fang Xiang <fangxiang3@xiaomi.com>,
	Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v4 3/3] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes ACPI probing
Message-ID: <ZZvDuz1w8St+uyRK@lpieralisi>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231227110038.55453-1-lpieralisi@kernel.org>
 <20231227110038.55453-4-lpieralisi@kernel.org>
 <86il499wtf.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86il499wtf.wl-maz@kernel.org>

On Thu, Jan 04, 2024 at 11:12:28AM +0000, Marc Zyngier wrote:
> On Wed, 27 Dec 2023 11:00:38 +0000,
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > 
> > The GIC architecture specification defines a set of registers
> > for redistributors and ITSes that control the sharebility and
> > cacheability attributes of redistributors/ITSes initiator ports
> > on the interconnect (GICR_[V]PROPBASER, GICR_[V]PENDBASER,
> > GITS_BASER<n>).
> > 
> > Architecturally the GIC provides a means to drive shareability
> > and cacheability attributes signals and related IWB/OWB/ISH barriers
> 
> IWB/OWB *barriers*? Unless you're talking about something else,
> IWB/OWB refers to cacheability, and only that.

Yes, it should be expressed differently. Unfortunately this sentence made
it into the kernel with the DT counterpart - commit 3a0fff0fb6a3 log,
apologies.

> > but it is not mandatory for designs to wire up the corresponding
> > interconnect signals that control the cacheability/shareability
> > of transactions.
> > 
> > Redistributors and ITSes interconnect ports can be connected to
> > non-coherent interconnects that are not able to manage the
> > shareability/cacheability attributes; this implicitly makes
> > the redistributors and ITSes non-coherent observers.
> > 
> > So far, the GIC driver on probe executes a write to "probe" for
> > the redistributors and ITSes registers shareability bitfields
> > by writing a value (ie InnerShareable - the shareability domain the
> > CPUs are in) and check it back to detect whether the value sticks or
> > not; this hinges on a GIC programming model behaviour that predates the
> > current specifications, that just define shareability bits as writeable
> > but do not guarantee that writing certain shareability values
> > enable the expected behaviour for the redistributors/ITSes
> > memory interconnect ports.
> > 
> > To enable non-coherent GIC designs on ACPI based systems, parse the MADT
> > GICC/GICR/ITS subtables non-coherent flags to determine whether the
> > respective components are non-coherent observers and force the shareability
> > attributes to be programmed into the redistributors and ITSes registers.
> > 
> > An ACPI global function (acpi_get_madt_revision()) is added to retrieve
> > the MADT revision, in that it is essential to check the MADT revision
> > before checking for flags that were added with MADT revision 7 so that
> > if the kernel is booted with ACPI tables (MADT rev < 7) it skips parsing
> > the newly added flags (that should be zeroed reserved values for MADT
> > versions < 7 but they could turn out to be buggy and should be ignored).
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/acpi/processor_core.c    | 21 +++++++++++++++++++++
> >  drivers/irqchip/irq-gic-common.h |  8 ++++++++
> >  drivers/irqchip/irq-gic-v3-its.c |  4 ++++
> >  drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
> >  include/linux/acpi.h             |  3 +++
> >  5 files changed, 45 insertions(+)
> > 
> > diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> > index b203cfe28550..c253d151275e 100644
> > --- a/drivers/acpi/processor_core.c
> > +++ b/drivers/acpi/processor_core.c
> > @@ -215,6 +215,27 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
> >  	return rv;
> >  }
> >  
> > +u8 __init acpi_get_madt_revision(void)
> > +{
> > +	static u8 madt_revision __initdata;
> > +	static bool madt_read __initdata;
> > +	struct acpi_table_header *madt = NULL;
> > +
> > +	if (!madt_read) {
> > +		madt_read = true;
> 
> Huh. Why do we need this hack? What's the issue with accessing the
> MADT? Can it disappear from under our feet? While we're walking it?

It is an awkward attempt at stashing the revision instead of
calling acpi_get_table() repeatedly (and from multiple files
for the same reason - ie get an MADT rev number).

Side note: get_madt_table() does the same thing and I followed
it - I am not sure it is very helpful either (or maybe
there is something I don't know behind that reasoning).

I will remove it (or leave it there without the madt_read hack).

> > +
> > +		acpi_get_table(ACPI_SIG_MADT, 0, &madt);
> > +		if (!madt)
> > +			return madt_revision;
> 
> What does this mean? Can we have a revision 0 of MADT?

No obviously you are right, it should have just returned an
error code and that's what it wanted to signal.

> > +
> > +		madt_revision = madt->revision;
> > +
> > +		acpi_put_table(madt);
> > +	}
> > +
> > +	return madt_revision;
> > +}
> > +
> >  static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
> >  {
> >  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> > diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
> > index f407cce9ecaa..8dffee95f7e8 100644
> > --- a/drivers/irqchip/irq-gic-common.h
> > +++ b/drivers/irqchip/irq-gic-common.h
> > @@ -6,6 +6,7 @@
> >  #ifndef _IRQ_GIC_COMMON_H
> >  #define _IRQ_GIC_COMMON_H
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/of.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/irqchip/arm-gic-common.h>
> > @@ -29,6 +30,13 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
> >  void gic_enable_of_quirks(const struct device_node *np,
> >  			  const struct gic_quirk *quirks, void *data);
> >  
> > +#ifdef CONFIG_ACPI
> > +static inline bool gic_acpi_non_coherent_flag(u32 flags, u32 mask)
> > +{
> > +	return (acpi_get_madt_revision() >= 7) && (flags & mask);
> > +}
> 
> Given that this checks *any* flag (or a combination of flags), the
> name of the helper is extremely misleading. Also, GICC flags are not
> necessarily tied to revision 7 of MADT.
> 
> To be honest, I don't think this helper bring much, and I'd rather see
> an explicit check (or 3) for the revision in the driver code.

I will do, you have a point.

Thanks,
Lorenzo

> > +#endif
> > +
> >  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
> >  #define RDIST_FLAGS_RD_TABLES_PREALLOCATED     (1 << 1)
> >  #define RDIST_FLAGS_FORCE_NON_SHAREABLE        (1 << 2)
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index 9a7a74239eab..8d088fca65a1 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -5578,6 +5578,10 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
> >  		goto node_err;
> >  	}
> >  
> > +	if (gic_acpi_non_coherent_flag(its_entry->flags,
> > +				       ACPI_MADT_ITS_NON_COHERENT))
> > +		its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
> > +
> >  	err = its_probe_one(its);
> >  	if (!err)
> >  		return 0;
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 98b0329b7154..48e02838fdc8 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -2356,6 +2356,11 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
> >  		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
> >  		return -ENOMEM;
> >  	}
> > +
> > +	if (gic_acpi_non_coherent_flag(redist->flags,
> > +				       ACPI_MADT_GICR_NON_COHERENT))
> > +		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> > +
> >  	gic_request_region(redist->base_address, redist->length, "GICR");
> >  
> >  	gic_acpi_register_redist(redist->base_address, redist_base);
> > @@ -2380,6 +2385,10 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
> >  		return -ENOMEM;
> >  	gic_request_region(gicc->gicr_base_address, size, "GICR");
> >  
> > +	if (gic_acpi_non_coherent_flag(gicc->flags,
> > +				       ACPI_MADT_GICC_NON_COHERENT))
> > +		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> > +
> >  	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
> >  	return 0;
> >  }
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 54189e0e5f41..a292f2bdb693 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -283,6 +283,9 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
> >  	return phys_id == PHYS_CPUID_INVALID;
> >  }
> >  
> > +
> > +u8 __init acpi_get_madt_revision(void);
> > +
> >  /* Validate the processor object's proc_id */
> >  bool acpi_duplicate_processor_id(int proc_id);
> >  /* Processor _CTS control */
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

