Return-Path: <linux-acpi+bounces-6186-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C318FC439
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 09:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F891C22C50
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 07:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2365818C332;
	Wed,  5 Jun 2024 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUB1c9gX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD6D18C32F;
	Wed,  5 Jun 2024 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571656; cv=none; b=qRtLUg1e3kme2HF1VCna6b6EsWrSah6kJc2i5zr9jkfEbJkWYaVIjmFubroWAWYfM1gcFlsKa/xfRLMMpdb6dSBLAXRWGNxSohhqZRv0tCCCbnVVIfCwLBHeJyaL3iXWEwYpaOXbZdnD0pVkiK3D1TT4ock49WUe4HFBqmVvuts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571656; c=relaxed/simple;
	bh=wUDOuDfSC1HxmhvTFKKgu/XL42Af+d6HJyAA09eVNxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhjLAYYKuPM9UnqMaan2n89WDH8a66VKfEfyyOk+qbA/HG3ySmJp0zDdtzcgTjpUYTB2MMupQii5tDKciqsKXJHJPfYhIpEBE5Iw5oHXskugOarjDz9y9nKg4GHKN6iCSvYB4ws1HK51coDEPSRihAIYtg9R70t5f41w2yPAN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUB1c9gX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA483C3277B;
	Wed,  5 Jun 2024 07:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717571655;
	bh=wUDOuDfSC1HxmhvTFKKgu/XL42Af+d6HJyAA09eVNxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUB1c9gXUTYywqYfJKSzAx5YO4wNPdp2dpNaN0sSw68gZgqh+v86hfGOOvN5mUhql
	 o709wqr0xyx+M5a10ybVVEVX8eQpjsi3ebNfzRZ2OrI3o+5GvCELWuWwPCSJBmqXYL
	 Xq0x5Iq+sGhd0gZqcV8JyVndXe7o6Ozlb9dnS3tVsotIomXGiM9idAR7fq7ptHSQPR
	 4w1iKicGjcTDxRqE7ztjgZ6L5HzfYdYjI4p4XVIJwck4+YkSA3WYCxCxdeRuqQ/IYj
	 jHtm1hwhmvT+9cFcGBaCgIVVms8wzKLCyC/XHqMn1UgbnI7kxe6uUueN5tvSxIY0ON
	 wwMIKx5AFPXKQ==
Date: Wed, 5 Jun 2024 09:14:09 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, Fang Xiang <fangxiang3@xiaomi.com>,
	Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v5 1/1] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes ACPI probing
Message-ID: <ZmAQQVR+inUJpJ7z@lpieralisi>
References: <20240123110332.112797-1-lpieralisi@kernel.org>
 <20240123110332.112797-2-lpieralisi@kernel.org>
 <ZiYi64/VBWkfM2E2@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiYi64/VBWkfM2E2@lpieralisi>

On Mon, Apr 22, 2024 at 10:42:19AM +0200, Lorenzo Pieralisi wrote:
> On Tue, Jan 23, 2024 at 12:03:32PM +0100, Lorenzo Pieralisi wrote:
> > The GIC architecture specification defines a set of registers for
> > redistributors and ITSes that control the sharebility and cacheability
> > attributes of redistributors/ITSes initiator ports on the interconnect
> > (GICR_[V]PROPBASER, GICR_[V]PENDBASER, GITS_BASER<n>).
> > 
> > Architecturally the GIC provides a means to drive shareability and
> > cacheability attributes signals but it is not mandatory for designs to
> > wire up the corresponding interconnect signals that control the
> > cacheability/shareability of transactions.
> > 
> > Redistributors and ITSes interconnect ports can be connected to
> > non-coherent interconnects that are not able to manage the
> > shareability/cacheability attributes; this implicitly makes the
> > redistributors and ITSes non-coherent observers.
> > 
> > To enable non-coherent GIC designs on ACPI based systems, parse the MADT
> > GICC/GICR/ITS subtables non-coherent flags to determine whether the
> > respective components are non-coherent observers and force the
> > shareability attributes to be programmed into the redistributors and
> > ITSes registers.
> > 
> > An ACPI global function (acpi_get_madt_revision()) is added to retrieve
> > the MADT revision, in that it is essential to check the MADT revision
> > before checking for flags that were added with MADT revision 7 so that
> > if the kernel is booted with an ACPI MADT table with revision < 7 it
> > skips parsing the newly added flags (that should be zeroed reserved
> > values for MADT versions < 7 but they could turn out to be buggy and
> > should be ignored).
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/acpi/processor_core.c    | 15 +++++++++++++++
> >  drivers/irqchip/irq-gic-v3-its.c |  4 ++++
> >  drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
> >  include/linux/acpi.h             |  3 +++
> >  4 files changed, 31 insertions(+)
> 
> Hi Marc, Rafael,
> 
> I would kindly ask you please what to do with this patch, it still
> applies to v6.9-rc5 - I can resend it if needed, ACPICA changes
> are already merged as-per the cover letter.

Hi Marc, Rafael,

I would kindly ask please what to do with this patch, rebased to v6.10-rc1,
I can resend it if that's preferred, please let me know.

Thanks,
Lorenzo

> > diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> > index b203cfe28550..915713c0e9b7 100644
> > --- a/drivers/acpi/processor_core.c
> > +++ b/drivers/acpi/processor_core.c
> > @@ -215,6 +215,21 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
> >  	return rv;
> >  }
> >  
> > +int __init acpi_get_madt_revision(void)
> > +{
> > +	struct acpi_table_header *madt = NULL;
> > +	int revision;
> > +
> > +	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_MADT, 0, &madt)))
> > +		return -EINVAL;
> > +
> > +	revision = madt->revision;
> > +
> > +	acpi_put_table(madt);
> > +
> > +	return revision;
> > +}
> > +
> >  static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
> >  {
> >  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index fec1b58470df..a60c560ce891 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -5591,6 +5591,10 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
> >  		goto node_err;
> >  	}
> >  
> > +	if (acpi_get_madt_revision() >= 7 &&
> > +	    (its_entry->flags & ACPI_MADT_ITS_NON_COHERENT))
> > +		its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
> > +
> >  	err = its_probe_one(its);
> >  	if (!err)
> >  		return 0;
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 98b0329b7154..8cb8dff86c12 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -2356,6 +2356,11 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
> >  		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
> >  		return -ENOMEM;
> >  	}
> > +
> > +	if (acpi_get_madt_revision() >= 7 &&
> > +	    (redist->flags & ACPI_MADT_GICR_NON_COHERENT))
> > +		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> > +
> >  	gic_request_region(redist->base_address, redist->length, "GICR");
> >  
> >  	gic_acpi_register_redist(redist->base_address, redist_base);
> > @@ -2380,6 +2385,10 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
> >  		return -ENOMEM;
> >  	gic_request_region(gicc->gicr_base_address, size, "GICR");
> >  
> > +	if (acpi_get_madt_revision() >= 7 &&
> > +	    (gicc->flags & ACPI_MADT_GICC_NON_COHERENT))
> > +		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> > +
> >  	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
> >  	return 0;
> >  }
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index b7165e52b3c6..4eedab0e51c3 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -284,6 +284,9 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
> >  	return phys_id == PHYS_CPUID_INVALID;
> >  }
> >  
> > +
> > +int __init acpi_get_madt_revision(void);
> > +
> >  /* Validate the processor object's proc_id */
> >  bool acpi_duplicate_processor_id(int proc_id);
> >  /* Processor _CTS control */
> > -- 
> > 2.34.1
> > 

