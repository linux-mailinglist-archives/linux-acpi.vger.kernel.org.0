Return-Path: <linux-acpi+bounces-756-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B3B7CF922
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 14:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540B21C20A02
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52AF225B7
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vut8FnJj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241B18C0A;
	Thu, 19 Oct 2023 11:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B454CC433C8;
	Thu, 19 Oct 2023 11:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697713969;
	bh=XTqMeSpKqcuasX9eby3qHv7gedznY2jckAT9FxyMVsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vut8FnJjXNgyZ7kXP3YKB2xGB0cR5yJAnVCUOZ1fOr2tcljAAqeR43RMuY7nLjwi+
	 MEU+dZyNp4FrqVRRObTJYfDii7w3STJTWj0lDBENOtxgc5tUWFXKSw437RKBtdn+Db
	 dIc5sNGIKpHAL6eN/GCr58GIYa/qsxUVeSs1SzlJ8sKEOv9f428fFmyh2GeoSXoyq2
	 rj+bTcyst/9KgEgUY9+goPaDOOemGn9te77MCajxs9zJqp2HMnRjnSzsDY0BA79BlU
	 XnPidvZcWLNwbIbA2Njr0M7hdWon5TFyyW3hpxtCSTXgYFsmSoxT/hg2I+xL2VPAtq
	 jMdjhFk2XptxQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1qtQxL-005ilA-7y;
	Thu, 19 Oct 2023 12:12:47 +0100
Date: Thu, 19 Oct 2023 12:12:45 +0100
Message-ID: <86lebyn9w2.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Fang Xiang <fangxiang3@xiaomi.com>
Subject: Re: [PATCH v3 5/5] irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing
In-Reply-To: <ZS+aZnRFkGkJ+vK9@lpieralisi>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
	<20231006125929.48591-1-lpieralisi@kernel.org>
	<20231006125929.48591-6-lpieralisi@kernel.org>
	<ZS6YAvoz3JApFtOo@lpieralisi>
	<86v8b5mc5v.wl-maz@kernel.org>
	<ZS+aZnRFkGkJ+vK9@lpieralisi>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: lpieralisi@kernel.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, mark.rutland@arm.com, rafael@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, robh+dt@kernel.org, fangxiang3@xiaomi.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 18 Oct 2023 09:42:14 +0100,
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> 
> On Tue, Oct 17, 2023 at 05:44:28PM +0100, Marc Zyngier wrote:
> > On Tue, 17 Oct 2023 15:19:46 +0100,
> > Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > > 
> > > On Fri, Oct 06, 2023 at 02:59:29PM +0200, Lorenzo Pieralisi wrote:
> > > > The GIC architecture specification defines a set of registers
> > > > for redistributors and ITSes that control the sharebility and
> > > > cacheability attributes of redistributors/ITSes initiator ports
> > > > on the interconnect (GICR_[V]PROPBASER, GICR_[V]PENDBASER,
> > > > GITS_BASER<n>).
> > > > 
> > > > Architecturally the GIC provides a means to drive shareability
> > > > and cacheability attributes signals and related IWB/OWB/ISH barriers
> > > > but it is not mandatory for designs to wire up the corresponding
> > > > interconnect signals that control the cacheability/shareability
> > > > of transactions.
> > > > 
> > > > Redistributors and ITSes interconnect ports can be connected to
> > > > non-coherent interconnects that are not able to manage the
> > > > shareability/cacheability attributes; this implicitly makes
> > > > the redistributors and ITSes non-coherent observers.
> > > > 
> > > > So far, the GIC driver on probe executes a write to "probe" for
> > > > the redistributors and ITSes registers shareability bitfields
> > > > by writing a value (ie InnerShareable - the shareability domain the
> > > > CPUs are in) and check it back to detect whether the value sticks or
> > > > not; this hinges on a GIC programming model behaviour that predates the
> > > > current specifications, that just define shareability bits as writeable
> > > > but do not guarantee that writing certain shareability values
> > > > enable the expected behaviour for the redistributors/ITSes
> > > > memory interconnect ports.
> > > > 
> > > > To enable non-coherent GIC designs on ACPI based systems, parse the MADT
> > > > GICC/GICR/ITS subtables non-coherent flags to determine whether the
> > > > respective components are non-coherent observers and force the shareability
> > > > attributes to be programmed into the redistributors and ITSes registers.
> > > > 
> > > > An ACPI global function (acpi_get_madt_revision()) is added to retrieve
> > > > the MADT revision, in that it is essential to check the MADT revision
> > > > before checking for flags that were added with MADT revision 7 so that
> > > > if the kernel is booted with ACPI tables (MADT rev < 7) it skips parsing
> > > > the newly added flags (that should be zeroed reserved values for MADT
> > > > versions < 7 but they could turn out to be buggy and should be ignored).
> > > > 
> > > > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > ---
> > > >  drivers/acpi/processor_core.c    | 21 +++++++++++++++++++++
> > > >  drivers/irqchip/irq-gic-common.h |  8 ++++++++
> > > >  drivers/irqchip/irq-gic-v3-its.c |  4 ++++
> > > >  drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
> > > >  include/linux/acpi.h             |  3 +++
> > > >  5 files changed, 45 insertions(+)
> > > 
> > > Hi Marc,
> > > 
> > > just a quick note to ask if, from an ACPI binding POW
> > 
> > I guess you mean POV. POW has an entirely different meaning... :-/
> > 
> > > this patch and related approach make sense to you.
> > > 
> > > If so, we can start the process to get the ACPI changes drafted
> > > in:
> > > 
> > > https://bugzilla.tianocore.org/show_bug.cgi?id=4557
> > > 
> > > and deployed in this patch into the ACPI specs, I can log
> > > an "ACK" in the tianocoreBZ entry above (we will be able to
> > > rework the code as much as we want, this is just for the
> > > bindings).
> > 
> > I'm OK with the overall shape of it. However, I wonder what the
> > rationale is for spreading the redistributor property all over the map
> > (in both GICC and GICR structures), while it could be set once and for
> > all in the core MADT flags (32 bits, of which only one is in use).
> > 
> > It is bad enough that there are two ways of getting the GICR regions.
> > Why can't the properties that apply to all of the be common?
> 
> I don't think we are allowed to add arch specific flags to the MADT
> since those, supposedly, are cross-architecture (and the only one
> defined is quite old, though x86 specific).

There is nothing that is truly cross-arch in this table. *everything*
in MADT is arch-specific.

> The reason behind spreading the property is the nature of GICC/GICR
> subtables themselves - we wanted to apply flags only in subtables
> relevant to the components in question.
>
> We could try to add a global flag to the MADT but I would not be
> surprised if the ECR would be rejected then for the reason I explained
> above.

I don't think that's much of a reason, but I really don't care enough
about this to argue otherwise.

	M.

-- 
Without deviation from the norm, progress is not possible.

