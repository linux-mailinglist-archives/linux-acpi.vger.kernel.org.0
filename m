Return-Path: <linux-acpi+bounces-2063-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D075180084E
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 11:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DEAD1C20B28
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683FA20B18
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="aKHFTNha"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DC7A8
	for <linux-acpi@vger.kernel.org>; Fri,  1 Dec 2023 00:58:15 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50aabfa1b75so2725838e87.3
        for <linux-acpi@vger.kernel.org>; Fri, 01 Dec 2023 00:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1701421094; x=1702025894; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UaHw1hjCR3NxnrQY1ARKmRXnyrSrOCItNMW6PUMuMF4=;
        b=aKHFTNhazqfIS3FMXGPXNpmkaVYleivHvQl7U+QmHkEXDCbqNDyAOFa99XvwwuG9Sp
         Nz7NpEjJ8vGm6bwrKNaziZdtwDyWHDOHDUte6DFGRGJxO/FlTC9w1lyv2edMHum1I+HM
         eS6aJPVR/8wpsNjN2gpMPLb1PzIrg8C6b4MOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701421094; x=1702025894;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UaHw1hjCR3NxnrQY1ARKmRXnyrSrOCItNMW6PUMuMF4=;
        b=V/+HYMtpCKddfyoyFInV+2iD6weg2Z449n1V4xJLe8W4eSPNlXV2BiEEYPO2kuoq/t
         9i77r1OBdvhycLfVcX5I2ISbWzavPxhCzjoFXqlxKEN08xv/usWb2Az8BotdVA0E+v+l
         dS2RCbC60i/Adyx8K5WxkHbKu0WjO9JXkq2yiVoc5LTMRQ0t3EbReVd7DffSiU+xW6kj
         7H+v3u+c/3zZ+JmGbQ0xomIEPiK51MZSGEnPp3h6yEELtkH9S18paI1kUouitgMLHs10
         RiK+Q9AMRs4BHTxy5WY7wmOhUQ7IpSkxieVt/KdlIyi7NPSG3ThcJIVRhAeX3kKJDvms
         V2Ig==
X-Gm-Message-State: AOJu0YzXAVw4gRStDoVaEAiu+YpKCrTUw/B5nvTJzOYh3PnmECbWDZxE
	r7THohcHqAXWrHxN8atnKQnQCA==
X-Google-Smtp-Source: AGHT+IE4OhisR8OsQM44A4vQh8aBYtvo29xgVaO+teORZibTRNUQH3H3JBaKP/eUBwb826QuHOJKcg==
X-Received: by 2002:a05:6512:31cd:b0:50b:d763:fe5f with SMTP id j13-20020a05651231cd00b0050bd763fe5fmr728578lfe.122.1701421093872;
        Fri, 01 Dec 2023 00:58:13 -0800 (PST)
Received: from localhost ([213.195.113.99])
        by smtp.gmail.com with ESMTPSA id je18-20020a05600c1f9200b003feea62440bsm4755865wmb.43.2023.12.01.00.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:58:13 -0800 (PST)
Date: Fri, 1 Dec 2023 09:58:12 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Jiqian Chen <Jiqian.Chen@amd.com>, Juergen Gross <jgross@suse.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Stefano Stabellini <stefano.stabellini@amd.com>,
	Alex Deucher <Alexander.Deucher@amd.com>,
	Christian Koenig <Christian.Koenig@amd.com>,
	Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
	Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
	Honglei Huang <Honglei1.Huang@amd.com>,
	Julia Zhang <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
Message-ID: <ZWmgJNidFsfkDp7q@macbook>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-3-Jiqian.Chen@amd.com>
 <alpine.DEB.2.22.394.2311291950350.3533093@ubuntu-linux-20-04-desktop>
 <ZWiyBP4Lzz5lXraP@macbook>
 <alpine.DEB.2.22.394.2311301912350.110490@ubuntu-linux-20-04-desktop>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.22.394.2311301912350.110490@ubuntu-linux-20-04-desktop>

On Thu, Nov 30, 2023 at 07:15:17PM -0800, Stefano Stabellini wrote:
> On Thu, 30 Nov 2023, Roger Pau Monné wrote:
> > On Wed, Nov 29, 2023 at 07:53:59PM -0800, Stefano Stabellini wrote:
> > > On Fri, 24 Nov 2023, Jiqian Chen wrote:
> > > > This patch is to solve two problems we encountered when we try to
> > > > passthrough a device to hvm domU base on Xen PVH dom0.
> > > > 
> > > > First, hvm guest will alloc a pirq and irq for a passthrough device
> > > > by using gsi, before that, the gsi must first has a mapping in dom0,
> > > > see Xen code pci_add_dm_done->xc_domain_irq_permission, it will call
> > > > into Xen and check whether dom0 has the mapping. See
> > > > XEN_DOMCTL_irq_permission->pirq_access_permitted, "current" is PVH
> > > > dom0 and it return irq is 0, and then return -EPERM.
> > > > This is because the passthrough device doesn't do PHYSDEVOP_map_pirq
> > > > when thay are enabled.
> > > > 
> > > > Second, in PVH dom0, the gsi of a passthrough device doesn't get
> > > > registered, but gsi must be configured for it to be able to be
> > > > mapped into a domU.
> > > > 
> > > > After searching codes, we can find map_pirq and register_gsi will be
> > > > done in function vioapic_write_redirent->vioapic_hwdom_map_gsi when
> > > > the gsi(aka ioapic's pin) is unmasked in PVH dom0. So the problems
> > > > can be conclude to that the gsi of a passthrough device doesn't be
> > > > unmasked.
> > > > 
> > > > To solve the unmaske problem, this patch call the unmask_irq when we
> > > > assign a device to be passthrough. So that the gsi can get registered
> > > > and mapped in PVH dom0.
> > > 
> > > 
> > > Roger, this seems to be more of a Xen issue than a Linux issue. Why do
> > > we need the unmask check in Xen? Couldn't we just do:
> > > 
> > > 
> > > diff --git a/xen/arch/x86/hvm/vioapic.c b/xen/arch/x86/hvm/vioapic.c
> > > index 4e40d3609a..df262a4a18 100644
> > > --- a/xen/arch/x86/hvm/vioapic.c
> > > +++ b/xen/arch/x86/hvm/vioapic.c
> > > @@ -287,7 +287,7 @@ static void vioapic_write_redirent(
> > >              hvm_dpci_eoi(d, gsi);
> > >      }
> > >  
> > > -    if ( is_hardware_domain(d) && unmasked )
> > > +    if ( is_hardware_domain(d) )
> > >      {
> > >          /*
> > >           * NB: don't call vioapic_hwdom_map_gsi while holding hvm.irq_lock
> > 
> > There are some issues with this approach.
> > 
> > mp_register_gsi() will only setup the trigger and polarity of the
> > IO-APIC pin once, so we do so once the guest unmask the pin in order
> > to assert that the configuration is the intended one.  A guest is
> > allowed to write all kind of nonsense stuff to the IO-APIC RTE, but
> > that doesn't take effect unless the pin is unmasked.
> > 
> > Overall the question would be whether we have any guarantees that
> > the hardware domain has properly configured the pin, even if it's not
> > using it itself (as it hasn't been unmasked).
> > 
> > IIRC PCI legacy interrupts are level triggered and low polarity, so we
> > could configure any pins that are not setup at bind time?
> 
> That could work.
> 
> Another idea is to move only the call to allocate_and_map_gsi_pirq at
> bind time? That might be enough to pass a pirq_access_permitted check.

Maybe, albeit that would change the behavior of XEN_DOMCTL_bind_pt_irq
just for PT_IRQ_TYPE_PCI and only when called from a PVH dom0 (as the
parameter would be a GSI instead of a previously mapped IRQ).  Such
difference just for PT_IRQ_TYPE_PCI is slightly weird - if we go that
route I would recommend that we instead introduce a new dmop that has
this syntax regardless of the domain type it's called from.

Thanks, Roger.

