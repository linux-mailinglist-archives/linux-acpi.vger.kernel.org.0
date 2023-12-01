Return-Path: <linux-acpi+bounces-2046-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AC3800289
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 05:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71011C20A86
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 04:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A08882A
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 04:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXRXIIGk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014759555
	for <linux-acpi@vger.kernel.org>; Fri,  1 Dec 2023 03:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03048C433C8;
	Fri,  1 Dec 2023 03:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701400521;
	bh=Dp7B5vd2hVcODH9a2EoW3LvQCYVBsy+Yg/mVTlE9inU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QXRXIIGk3RVLPsM4TCRp2cn2iBCqITDx3AWfqYRl3Lln3cRggUuDlXWdreqcykGsL
	 W946LuhkL2qPLsf3/raIlDTPk3Drc5irqHJGg+oPby4lLnrTsYhV2sUc0Izv52YpnF
	 MRqsfAVPlzx8Bdl426zUVsiMIKfPvPR+8o0LbOwEsfebODMAxZ1AkXV6gzv5WvMGnE
	 vdvaGhSthObuKzxmpx6yuRcmH+6r9KHtlZT407gtbyKQMPFQvGGS8oyqREfhVDDmUp
	 wLcJikr7LGhwsoJ199+0r9HNU5FRwIsMBGlQY0omccS71m+/4uYUdIB17v3shmvoVW
	 FYAxePMeaTQbw==
Date: Thu, 30 Nov 2023 19:15:17 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
cc: Stefano Stabellini <sstabellini@kernel.org>, 
    Jiqian Chen <Jiqian.Chen@amd.com>, Juergen Gross <jgross@suse.com>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    Thomas Gleixner <tglx@linutronix.de>, 
    Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, xen-devel@lists.xenproject.org, 
    linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
    Stefano Stabellini <stefano.stabellini@amd.com>, 
    Alex Deucher <Alexander.Deucher@amd.com>, 
    Christian Koenig <Christian.Koenig@amd.com>, 
    Stewart Hildebrand <Stewart.Hildebrand@amd.com>, 
    Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
    Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>, 
    Huang Rui <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
In-Reply-To: <ZWiyBP4Lzz5lXraP@macbook>
Message-ID: <alpine.DEB.2.22.394.2311301912350.110490@ubuntu-linux-20-04-desktop>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com> <20231124103123.3263471-3-Jiqian.Chen@amd.com> <alpine.DEB.2.22.394.2311291950350.3533093@ubuntu-linux-20-04-desktop> <ZWiyBP4Lzz5lXraP@macbook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-351411740-1701400521=:110490"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-351411740-1701400521=:110490
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 30 Nov 2023, Roger Pau Monné wrote:
> On Wed, Nov 29, 2023 at 07:53:59PM -0800, Stefano Stabellini wrote:
> > On Fri, 24 Nov 2023, Jiqian Chen wrote:
> > > This patch is to solve two problems we encountered when we try to
> > > passthrough a device to hvm domU base on Xen PVH dom0.
> > > 
> > > First, hvm guest will alloc a pirq and irq for a passthrough device
> > > by using gsi, before that, the gsi must first has a mapping in dom0,
> > > see Xen code pci_add_dm_done->xc_domain_irq_permission, it will call
> > > into Xen and check whether dom0 has the mapping. See
> > > XEN_DOMCTL_irq_permission->pirq_access_permitted, "current" is PVH
> > > dom0 and it return irq is 0, and then return -EPERM.
> > > This is because the passthrough device doesn't do PHYSDEVOP_map_pirq
> > > when thay are enabled.
> > > 
> > > Second, in PVH dom0, the gsi of a passthrough device doesn't get
> > > registered, but gsi must be configured for it to be able to be
> > > mapped into a domU.
> > > 
> > > After searching codes, we can find map_pirq and register_gsi will be
> > > done in function vioapic_write_redirent->vioapic_hwdom_map_gsi when
> > > the gsi(aka ioapic's pin) is unmasked in PVH dom0. So the problems
> > > can be conclude to that the gsi of a passthrough device doesn't be
> > > unmasked.
> > > 
> > > To solve the unmaske problem, this patch call the unmask_irq when we
> > > assign a device to be passthrough. So that the gsi can get registered
> > > and mapped in PVH dom0.
> > 
> > 
> > Roger, this seems to be more of a Xen issue than a Linux issue. Why do
> > we need the unmask check in Xen? Couldn't we just do:
> > 
> > 
> > diff --git a/xen/arch/x86/hvm/vioapic.c b/xen/arch/x86/hvm/vioapic.c
> > index 4e40d3609a..df262a4a18 100644
> > --- a/xen/arch/x86/hvm/vioapic.c
> > +++ b/xen/arch/x86/hvm/vioapic.c
> > @@ -287,7 +287,7 @@ static void vioapic_write_redirent(
> >              hvm_dpci_eoi(d, gsi);
> >      }
> >  
> > -    if ( is_hardware_domain(d) && unmasked )
> > +    if ( is_hardware_domain(d) )
> >      {
> >          /*
> >           * NB: don't call vioapic_hwdom_map_gsi while holding hvm.irq_lock
> 
> There are some issues with this approach.
> 
> mp_register_gsi() will only setup the trigger and polarity of the
> IO-APIC pin once, so we do so once the guest unmask the pin in order
> to assert that the configuration is the intended one.  A guest is
> allowed to write all kind of nonsense stuff to the IO-APIC RTE, but
> that doesn't take effect unless the pin is unmasked.
> 
> Overall the question would be whether we have any guarantees that
> the hardware domain has properly configured the pin, even if it's not
> using it itself (as it hasn't been unmasked).
> 
> IIRC PCI legacy interrupts are level triggered and low polarity, so we
> could configure any pins that are not setup at bind time?

That could work.

Another idea is to move only the call to allocate_and_map_gsi_pirq at
bind time? That might be enough to pass a pirq_access_permitted check.
--8323329-351411740-1701400521=:110490--

