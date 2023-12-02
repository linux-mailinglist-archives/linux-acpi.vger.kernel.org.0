Return-Path: <linux-acpi+bounces-2087-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E72C801AAA
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 05:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E69E1F2112C
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 04:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8EBA2B
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 04:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiQndPNG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B785C23AF
	for <linux-acpi@vger.kernel.org>; Sat,  2 Dec 2023 03:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87EFC433C7;
	Sat,  2 Dec 2023 03:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701488279;
	bh=NarBwsDGf+urCkR+0KsD6NtO/pJjqSgUz4O5m4o8FXo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=oiQndPNGfYaJ8uCgjjmlyJLqQ7AVNalarc+HVopht2uw+VBhjq9W4AVOdQgnF5Cwt
	 RszsMvfslq5zMX47pvgUJIl20b/wYQz4LMr7VR6waH+WRNKghSlzm4+5RkNLuVqw6V
	 dS01VAIPXzSKDnUDF+ufr1GbldmBmCJaoqaU/XBY9bIlWlqmrt5jDFWgkhhANCvIUh
	 /ul7L7hrFzaapLfSZ2qM3S/gPYyMOdzT/F3qrcXsjxrjy1FBVDw/gQVM8QcEsJ5Ww+
	 oFDstsugb2RJVa0mgqX2n5v+0ukvXsvJUqw9zkdksPihZm5vfmoVJ7PWI3YgX27AIV
	 fv31RAN9zZpXw==
Date: Fri, 1 Dec 2023 19:37:55 -0800 (PST)
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
In-Reply-To: <ZWmgJNidFsfkDp7q@macbook>
Message-ID: <alpine.DEB.2.22.394.2312011857260.110490@ubuntu-linux-20-04-desktop>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com> <20231124103123.3263471-3-Jiqian.Chen@amd.com> <alpine.DEB.2.22.394.2311291950350.3533093@ubuntu-linux-20-04-desktop> <ZWiyBP4Lzz5lXraP@macbook> <alpine.DEB.2.22.394.2311301912350.110490@ubuntu-linux-20-04-desktop>
 <ZWmgJNidFsfkDp7q@macbook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-579185399-1701486027=:110490"
Content-ID: <alpine.DEB.2.22.394.2312011923070.110490@ubuntu-linux-20-04-desktop>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-579185399-1701486027=:110490
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2312011923071.110490@ubuntu-linux-20-04-desktop>

On Fri, 1 Dec 2023, Roger Pau Monné wrote:
> On Thu, Nov 30, 2023 at 07:15:17PM -0800, Stefano Stabellini wrote:
> > On Thu, 30 Nov 2023, Roger Pau Monné wrote:
> > > On Wed, Nov 29, 2023 at 07:53:59PM -0800, Stefano Stabellini wrote:
> > > > On Fri, 24 Nov 2023, Jiqian Chen wrote:
> > > > > This patch is to solve two problems we encountered when we try to
> > > > > passthrough a device to hvm domU base on Xen PVH dom0.
> > > > > 
> > > > > First, hvm guest will alloc a pirq and irq for a passthrough device
> > > > > by using gsi, before that, the gsi must first has a mapping in dom0,
> > > > > see Xen code pci_add_dm_done->xc_domain_irq_permission, it will call
> > > > > into Xen and check whether dom0 has the mapping. See
> > > > > XEN_DOMCTL_irq_permission->pirq_access_permitted, "current" is PVH
> > > > > dom0 and it return irq is 0, and then return -EPERM.
> > > > > This is because the passthrough device doesn't do PHYSDEVOP_map_pirq
> > > > > when thay are enabled.
> > > > > 
> > > > > Second, in PVH dom0, the gsi of a passthrough device doesn't get
> > > > > registered, but gsi must be configured for it to be able to be
> > > > > mapped into a domU.
> > > > > 
> > > > > After searching codes, we can find map_pirq and register_gsi will be
> > > > > done in function vioapic_write_redirent->vioapic_hwdom_map_gsi when
> > > > > the gsi(aka ioapic's pin) is unmasked in PVH dom0. So the problems
> > > > > can be conclude to that the gsi of a passthrough device doesn't be
> > > > > unmasked.
> > > > > 
> > > > > To solve the unmaske problem, this patch call the unmask_irq when we
> > > > > assign a device to be passthrough. So that the gsi can get registered
> > > > > and mapped in PVH dom0.
> > > > 
> > > > 
> > > > Roger, this seems to be more of a Xen issue than a Linux issue. Why do
> > > > we need the unmask check in Xen? Couldn't we just do:
> > > > 
> > > > 
> > > > diff --git a/xen/arch/x86/hvm/vioapic.c b/xen/arch/x86/hvm/vioapic.c
> > > > index 4e40d3609a..df262a4a18 100644
> > > > --- a/xen/arch/x86/hvm/vioapic.c
> > > > +++ b/xen/arch/x86/hvm/vioapic.c
> > > > @@ -287,7 +287,7 @@ static void vioapic_write_redirent(
> > > >              hvm_dpci_eoi(d, gsi);
> > > >      }
> > > >  
> > > > -    if ( is_hardware_domain(d) && unmasked )
> > > > +    if ( is_hardware_domain(d) )
> > > >      {
> > > >          /*
> > > >           * NB: don't call vioapic_hwdom_map_gsi while holding hvm.irq_lock
> > > 
> > > There are some issues with this approach.
> > > 
> > > mp_register_gsi() will only setup the trigger and polarity of the
> > > IO-APIC pin once, so we do so once the guest unmask the pin in order
> > > to assert that the configuration is the intended one.  A guest is
> > > allowed to write all kind of nonsense stuff to the IO-APIC RTE, but
> > > that doesn't take effect unless the pin is unmasked.
> > > 
> > > Overall the question would be whether we have any guarantees that
> > > the hardware domain has properly configured the pin, even if it's not
> > > using it itself (as it hasn't been unmasked).
> > > 
> > > IIRC PCI legacy interrupts are level triggered and low polarity, so we
> > > could configure any pins that are not setup at bind time?
> > 
> > That could work.
> > 
> > Another idea is to move only the call to allocate_and_map_gsi_pirq at
> > bind time? That might be enough to pass a pirq_access_permitted check.
> 
> Maybe, albeit that would change the behavior of XEN_DOMCTL_bind_pt_irq
> just for PT_IRQ_TYPE_PCI and only when called from a PVH dom0 (as the
> parameter would be a GSI instead of a previously mapped IRQ).  Such
> difference just for PT_IRQ_TYPE_PCI is slightly weird - if we go that
> route I would recommend that we instead introduce a new dmop that has
> this syntax regardless of the domain type it's called from.

Looking at the code it is certainly a bit confusing. My point was that
we don't need to wait until polarity and trigger are set appropriately
to allow Dom0 to pass successfully a pirq_access_permitted() check. Xen
should be able to figure out that Dom0 is permitted pirq access.

So the idea was to move the call to allocate_and_map_gsi_pirq() earlier
somewhere because allocate_and_map_gsi_pirq doesn't require trigger or
polarity to be configured to work. But the suggestion of doing it a
"bind time" (meaning: XEN_DOMCTL_bind_pt_irq) was a bad idea.

But maybe we can find another location, maybe within
xen/arch/x86/hvm/vioapic.c, to call allocate_and_map_gsi_pirq() before
trigger and polarity are set and before the interrupt is unmasked.

Then we change the implementation of vioapic_hwdom_map_gsi to skip the
call to allocate_and_map_gsi_pirq, because by the time
vioapic_hwdom_map_gsi we assume that allocate_and_map_gsi_pirq had
already been done.

I am not familiar with vioapic.c but to give you an idea of what I was
thinking:


diff --git a/xen/arch/x86/hvm/vioapic.c b/xen/arch/x86/hvm/vioapic.c
index 4e40d3609a..16d56fe851 100644
--- a/xen/arch/x86/hvm/vioapic.c
+++ b/xen/arch/x86/hvm/vioapic.c
@@ -189,14 +189,6 @@ static int vioapic_hwdom_map_gsi(unsigned int gsi, unsigned int trig,
         return ret;
     }
 
-    ret = allocate_and_map_gsi_pirq(currd, pirq, &pirq);
-    if ( ret )
-    {
-        gprintk(XENLOG_WARNING, "vioapic: error mapping GSI %u: %d\n",
-                 gsi, ret);
-        return ret;
-    }
-
     pcidevs_lock();
     ret = pt_irq_create_bind(currd, &pt_irq_bind);
     if ( ret )
@@ -287,6 +279,17 @@ static void vioapic_write_redirent(
             hvm_dpci_eoi(d, gsi);
     }
 
+    if ( is_hardware_domain(d) ) 
+    {
+        int pirq = gsi, ret;
+        ret = allocate_and_map_gsi_pirq(currd, pirq, &pirq);
+        if ( ret )
+        {
+            gprintk(XENLOG_WARNING, "vioapic: error mapping GSI %u: %d\n",
+                    gsi, ret);
+            return ret;
+        }
+    }
     if ( is_hardware_domain(d) && unmasked )
     {
         /*
--8323329-579185399-1701486027=:110490--

