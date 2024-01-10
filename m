Return-Path: <linux-acpi+bounces-2722-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C8182430D
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jan 2024 14:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF21A287A85
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jan 2024 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFD623745;
	Thu,  4 Jan 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kNGgoupT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65F424218;
	Thu,  4 Jan 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F677DMlRFfuOUxBej40MkJ2lKltaDghuaAWCmf8gXQc=; b=kNGgoupTyPl+j4/PRccqDi2z3C
	0o9MWQTpGOF9dHAykolfZqHfEiToZnpkRso5xbWtzkg3c6smypF6KVEQyXOIMJfZWaEIyU9B/t4Ez
	Vc0KgQvROqJbwhRtmlZUZMcnagFha04mM+w+Cd4nmoPyIkpEAwuJnTyYYiSww9HBw6T6L8HUX3lxI
	B601V+ybZhS3eYHpfc1n9k6wqjo2XYc0mPMLI2GTaOAgRdEm0z4OWIedwaLyMFPxoCgWmRu8t/A/D
	d595mNaS9SnWqMG36YT9dxxDnBIBn3Cmutf5VkjtR8tSp+fjiY/3ClayKL14RMkEOBr5BFhdoj7ev
	8RseZWLA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48000)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rLO4W-00005k-1G;
	Thu, 04 Jan 2024 13:47:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rLO4W-0007Tl-A0; Thu, 04 Jan 2024 13:47:44 +0000
Date: Thu, 4 Jan 2024 13:47:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Fang Xiang <fangxiang3@xiaomi.com>,
	Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v4 0/3] irqchip/gic-v3: Enable non-coherent GIC designs
 probing
Message-ID: <ZZa3AMRmWUfYCROl@shell.armlinux.org.uk>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231227110038.55453-1-lpieralisi@kernel.org>
 <CAJZ5v0gUBU=VL8E34sjROssoGNbLnhmUQVHGWT60hgBG_ufTHw@mail.gmail.com>
 <86h6jt9vs7.wl-maz@kernel.org>
 <ZZaeyBXn85AnsIk6@shell.armlinux.org.uk>
 <CAJZ5v0jcZ4WEiNUs3sAQUyy1uVJRNWmVJx2j0e3hLwi7heK1+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jcZ4WEiNUs3sAQUyy1uVJRNWmVJx2j0e3hLwi7heK1+A@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 04, 2024 at 02:21:44PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 4, 2024 at 1:04 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Jan 04, 2024 at 11:34:48AM +0000, Marc Zyngier wrote:
> > > On Wed, 03 Jan 2024 13:43:16 +0000,
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > >
> > > > On Wed, Dec 27, 2023 at 12:00 PM Lorenzo Pieralisi
> > > > <lpieralisi@kernel.org> wrote:
> > > > >
> > > > > This series is v4 of previous series:
> > > > >
> > > > > v3: https://lore.kernel.org/all/20231006125929.48591-1-lpieralisi@kernel.org
> > > > > v2: https://lore.kernel.org/all/20230906094139.16032-1-lpieralisi@kernel.org
> > > > > v1: https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@kernel.org
> > > > >
> > > > > v3 -> v4:
> > > > >         - Dropped patches [1-3], already merged
> > > > >         - Added Linuxized ACPICA changes accepted upstream
> > > > >         - Rebased against v6.7-rc3
> > > > >
> > > > > v2 -> v3:
> > > > >         - Added ACPICA temporary changes and ACPI changes to implement
> > > > >           ECR https://bugzilla.tianocore.org/show_bug.cgi?id=4557
> > > > >         - ACPI changes are for testing purposes - subject to ECR code
> > > > >           first approval
> > > > >
> > > > > v1 -> v2:
> > > > >         - Updated DT bindings as per feedback
> > > > >         - Updated patch[2] to use GIC quirks infrastructure
> > > > >
> > > > > Original cover letter
> > > > > ---
> > > > > The GICv3 architecture specifications provide a means for the
> > > > > system programmer to set the shareability and cacheability
> > > > > attributes the GIC components (redistributors and ITSes) use
> > > > > to drive memory transactions.
> > > > >
> > > > > Albeit the architecture give control over shareability/cacheability
> > > > > memory transactions attributes (and barriers), it is allowed to
> > > > > connect the GIC interconnect ports to non-coherent memory ports
> > > > > on the interconnect, basically tying off shareability/cacheability
> > > > > "wires" and de-facto making the redistributors and ITSes non-coherent
> > > > > memory observers.
> > > > >
> > > > > This series aims at starting a discussion over a possible solution
> > > > > to this problem, by adding to the GIC device tree bindings the
> > > > > standard dma-noncoherent property. The GIC driver uses the property
> > > > > to force the redistributors and ITSes shareability attributes to
> > > > > non-shareable, which consequently forces the driver to use CMOs
> > > > > on GIC memory tables.
> > > > >
> > > > > On ARM DT DMA is default non-coherent, so the GIC driver can't rely
> > > > > on the generic DT dma-coherent/non-coherent property management layer
> > > > > (of_dma_is_coherent()) which would default all GIC designs in the field
> > > > > as non-coherent; it has to rely on ad-hoc dma-noncoherent property handling.
> > > > >
> > > > > When a consistent approach is agreed upon for DT an equivalent binding will
> > > > > be put forward for ACPI based systems.
> > > > >
> > > > > Lorenzo Pieralisi (3):
> > > > >   ACPICA: MADT: Add GICC online capable bit handling
> > > > >   ACPICA: MADT: Add new MADT GICC/GICR/ITS non-coherent flags handling
> > > > >   irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing
> > > > >
> > > > >  drivers/acpi/processor_core.c    | 21 +++++++++++++++++++++
> > > > >  drivers/irqchip/irq-gic-common.h |  8 ++++++++
> > > > >  drivers/irqchip/irq-gic-v3-its.c |  4 ++++
> > > > >  drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
> > > > >  include/acpi/actbl2.h            | 12 ++++++++++--
> > > > >  include/linux/acpi.h             |  3 +++
> > > > >  6 files changed, 55 insertions(+), 2 deletions(-)
> > > > >
> > > > > --
> > > >
> > > > I can apply the first 2 patches, but I would need an ACK for the 3rd one.
> > > >
> > > > Alternatively, feel free to add
> > > >
> > > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > to the first 2 patches and route them via ARM64.
> > >
> > > Thanks for that. I have some comments on the third patch, which I'd
> > > like to see addressed beforehand. This is probably all 6.9 material
> > > anyway (nobody is affected by this so far).
> >
> > From a purely selfish point of view, it would be useful to have the
> > first patch merged merely to reduce the burden of patches for vcpu
> > hotplug.
> 
> OK, since there will be at least one more iteration of patch [3/3]
> AFAICS, I'll queue up patches [1-2/3] for 6.8 (next week, though).

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

