Return-Path: <linux-acpi+bounces-2110-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7F980309A
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 11:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B7A1F20EE8
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 10:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A0722EE2
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="p+Cl6CQ7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A75FB6
	for <linux-acpi@vger.kernel.org>; Mon,  4 Dec 2023 02:28:08 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40bda47b7c1so22938945e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 04 Dec 2023 02:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1701685687; x=1702290487; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Xm7HNFkq0+Qbd6Uu1gKkNyeDxPZw3eWj43IaSy+UC4=;
        b=p+Cl6CQ78cBbuNn5og6nWCY9dDrOpH/9bgWAX6x2m7qIZO88irwClp4onv7dBzSLPA
         myD+9ULM3THU6QYkpi/qECknZLbM3a6Ey7nkIi5Jqh00a4QhtzF4vrUJzC3a+D7aemkK
         fKqNY1a/Vqi7ywR32Avd8Il98AGKgLmVRmMDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701685687; x=1702290487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xm7HNFkq0+Qbd6Uu1gKkNyeDxPZw3eWj43IaSy+UC4=;
        b=nAEJjq48Y73END5/bn3ryX9yF8dQFQny33InlaqJ2ptzK2DY02bF0MY7mYVALMnit9
         g/M4um3flTX/rOKxWoq1Tt811VBnkKTBX1qAHlpw4D+0n7bkohGftyPH7BqqQKBMr6eX
         8l26522euyElLtGvW1gXEotm6covl+FE7Hotq+uwG9DxqGsaovXPGTTndGnulUr/w41U
         fbYCPIxdg3jUHi5yJZsLSlbdLVQX4/3ucgD6arPB34qflP0/fzvj1FxwpX7jKtzUFODg
         ZLnH+e/ly+To0h2JNwEUrkdf3MA0Xhiwvc2Woo8pW+pHIzl4jv39z9XPUsVUv6Pf4h+l
         JyCQ==
X-Gm-Message-State: AOJu0YyVWs2SwBR218SDbX/4ZZKXgO8xS1SiptIMWlp90FMipMIi/6A+
	mEsSTYq2F4DLp8vA2YnvjD9vrg==
X-Google-Smtp-Source: AGHT+IHQrE6G9YfZt6YRb8WN3b3NCDEKLCWBQFePbbHf+vIbFNsdFKpqoANLbKTBhVnrWpsfjOX0Qw==
X-Received: by 2002:a05:600c:3d09:b0:40c:6bf:bdff with SMTP id bh9-20020a05600c3d0900b0040c06bfbdffmr879047wmb.355.1701685686722;
        Mon, 04 Dec 2023 02:28:06 -0800 (PST)
Received: from localhost ([213.195.113.99])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b0040b3e79bad3sm14462375wmq.40.2023.12.04.02.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 02:28:06 -0800 (PST)
Date: Mon, 4 Dec 2023 11:28:05 +0100
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
Message-ID: <ZW2ptexPQXrWBiOS@macbook>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-3-Jiqian.Chen@amd.com>
 <alpine.DEB.2.22.394.2311291950350.3533093@ubuntu-linux-20-04-desktop>
 <ZWiyBP4Lzz5lXraP@macbook>
 <alpine.DEB.2.22.394.2311301912350.110490@ubuntu-linux-20-04-desktop>
 <ZWmgJNidFsfkDp7q@macbook>
 <alpine.DEB.2.22.394.2312011857260.110490@ubuntu-linux-20-04-desktop>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.22.394.2312011857260.110490@ubuntu-linux-20-04-desktop>

On Fri, Dec 01, 2023 at 07:37:55PM -0800, Stefano Stabellini wrote:
> On Fri, 1 Dec 2023, Roger Pau Monné wrote:
> > On Thu, Nov 30, 2023 at 07:15:17PM -0800, Stefano Stabellini wrote:
> > > On Thu, 30 Nov 2023, Roger Pau Monné wrote:
> > > > On Wed, Nov 29, 2023 at 07:53:59PM -0800, Stefano Stabellini wrote:
> > > > > On Fri, 24 Nov 2023, Jiqian Chen wrote:
> > > > > > This patch is to solve two problems we encountered when we try to
> > > > > > passthrough a device to hvm domU base on Xen PVH dom0.
> > > > > > 
> > > > > > First, hvm guest will alloc a pirq and irq for a passthrough device
> > > > > > by using gsi, before that, the gsi must first has a mapping in dom0,
> > > > > > see Xen code pci_add_dm_done->xc_domain_irq_permission, it will call
> > > > > > into Xen and check whether dom0 has the mapping. See
> > > > > > XEN_DOMCTL_irq_permission->pirq_access_permitted, "current" is PVH
> > > > > > dom0 and it return irq is 0, and then return -EPERM.
> > > > > > This is because the passthrough device doesn't do PHYSDEVOP_map_pirq
> > > > > > when thay are enabled.
> > > > > > 
> > > > > > Second, in PVH dom0, the gsi of a passthrough device doesn't get
> > > > > > registered, but gsi must be configured for it to be able to be
> > > > > > mapped into a domU.
> > > > > > 
> > > > > > After searching codes, we can find map_pirq and register_gsi will be
> > > > > > done in function vioapic_write_redirent->vioapic_hwdom_map_gsi when
> > > > > > the gsi(aka ioapic's pin) is unmasked in PVH dom0. So the problems
> > > > > > can be conclude to that the gsi of a passthrough device doesn't be
> > > > > > unmasked.
> > > > > > 
> > > > > > To solve the unmaske problem, this patch call the unmask_irq when we
> > > > > > assign a device to be passthrough. So that the gsi can get registered
> > > > > > and mapped in PVH dom0.
> > > > > 
> > > > > 
> > > > > Roger, this seems to be more of a Xen issue than a Linux issue. Why do
> > > > > we need the unmask check in Xen? Couldn't we just do:
> > > > > 
> > > > > 
> > > > > diff --git a/xen/arch/x86/hvm/vioapic.c b/xen/arch/x86/hvm/vioapic.c
> > > > > index 4e40d3609a..df262a4a18 100644
> > > > > --- a/xen/arch/x86/hvm/vioapic.c
> > > > > +++ b/xen/arch/x86/hvm/vioapic.c
> > > > > @@ -287,7 +287,7 @@ static void vioapic_write_redirent(
> > > > >              hvm_dpci_eoi(d, gsi);
> > > > >      }
> > > > >  
> > > > > -    if ( is_hardware_domain(d) && unmasked )
> > > > > +    if ( is_hardware_domain(d) )
> > > > >      {
> > > > >          /*
> > > > >           * NB: don't call vioapic_hwdom_map_gsi while holding hvm.irq_lock
> > > > 
> > > > There are some issues with this approach.
> > > > 
> > > > mp_register_gsi() will only setup the trigger and polarity of the
> > > > IO-APIC pin once, so we do so once the guest unmask the pin in order
> > > > to assert that the configuration is the intended one.  A guest is
> > > > allowed to write all kind of nonsense stuff to the IO-APIC RTE, but
> > > > that doesn't take effect unless the pin is unmasked.
> > > > 
> > > > Overall the question would be whether we have any guarantees that
> > > > the hardware domain has properly configured the pin, even if it's not
> > > > using it itself (as it hasn't been unmasked).
> > > > 
> > > > IIRC PCI legacy interrupts are level triggered and low polarity, so we
> > > > could configure any pins that are not setup at bind time?
> > > 
> > > That could work.
> > > 
> > > Another idea is to move only the call to allocate_and_map_gsi_pirq at
> > > bind time? That might be enough to pass a pirq_access_permitted check.
> > 
> > Maybe, albeit that would change the behavior of XEN_DOMCTL_bind_pt_irq
> > just for PT_IRQ_TYPE_PCI and only when called from a PVH dom0 (as the
> > parameter would be a GSI instead of a previously mapped IRQ).  Such
> > difference just for PT_IRQ_TYPE_PCI is slightly weird - if we go that
> > route I would recommend that we instead introduce a new dmop that has
> > this syntax regardless of the domain type it's called from.
> 
> Looking at the code it is certainly a bit confusing. My point was that
> we don't need to wait until polarity and trigger are set appropriately
> to allow Dom0 to pass successfully a pirq_access_permitted() check. Xen
> should be able to figure out that Dom0 is permitted pirq access.

The logic is certainly not straightforward, and it could benefit from
some comments.

The irq permissions are a bit special, in that they get setup when the
IRQ is mapped.

The problem however is not so much with IRQ permissions, that we can
indeed sort out internally in Xen.  Such check in dom0 has the side
effect of preventing the IRQ from being assigned to a domU without the
hardware source being properly configured AFAICT.

> 
> So the idea was to move the call to allocate_and_map_gsi_pirq() earlier
> somewhere because allocate_and_map_gsi_pirq doesn't require trigger or
> polarity to be configured to work. But the suggestion of doing it a
> "bind time" (meaning: XEN_DOMCTL_bind_pt_irq) was a bad idea.
> 
> But maybe we can find another location, maybe within
> xen/arch/x86/hvm/vioapic.c, to call allocate_and_map_gsi_pirq() before
> trigger and polarity are set and before the interrupt is unmasked.
> 
> Then we change the implementation of vioapic_hwdom_map_gsi to skip the
> call to allocate_and_map_gsi_pirq, because by the time
> vioapic_hwdom_map_gsi we assume that allocate_and_map_gsi_pirq had
> already been done.

But then we would end up in a situation where the
pirq_access_permitted() check will pass, but the IO-APIC pin won't be
configured, which I think it's not what we want.

One option would be to allow mp_register_gsi() to be called multiple
times, and update the IO-APIC pin configuration as long as the pin is
not unmasked.  That would propagate each dom0 RTE update to the
underlying IO-APIC.  However such approach relies on dom0 configuring
all possible IO-APIC pins, even if no device on dom0 is using them, I
think it's not a very reliable option.

Another option would be to modify the toolstack to setup the GSI
itself using the PHYSDEVOP_setup_gsi hypercall.  As said in a previous
email, since we only care about PCI device passthrough the legacy INTx
should always be level triggered and low polarity.

> I am not familiar with vioapic.c but to give you an idea of what I was
> thinking:
> 
> 
> diff --git a/xen/arch/x86/hvm/vioapic.c b/xen/arch/x86/hvm/vioapic.c
> index 4e40d3609a..16d56fe851 100644
> --- a/xen/arch/x86/hvm/vioapic.c
> +++ b/xen/arch/x86/hvm/vioapic.c
> @@ -189,14 +189,6 @@ static int vioapic_hwdom_map_gsi(unsigned int gsi, unsigned int trig,
>          return ret;
>      }
>  
> -    ret = allocate_and_map_gsi_pirq(currd, pirq, &pirq);
> -    if ( ret )
> -    {
> -        gprintk(XENLOG_WARNING, "vioapic: error mapping GSI %u: %d\n",
> -                 gsi, ret);
> -        return ret;
> -    }
> -
>      pcidevs_lock();
>      ret = pt_irq_create_bind(currd, &pt_irq_bind);
>      if ( ret )
> @@ -287,6 +279,17 @@ static void vioapic_write_redirent(
>              hvm_dpci_eoi(d, gsi);
>      }
>  
> +    if ( is_hardware_domain(d) ) 
> +    {
> +        int pirq = gsi, ret;
> +        ret = allocate_and_map_gsi_pirq(currd, pirq, &pirq);
> +        if ( ret )
> +        {
> +            gprintk(XENLOG_WARNING, "vioapic: error mapping GSI %u: %d\n",
> +                    gsi, ret);
> +            return ret;
> +        }
> +    }
>      if ( is_hardware_domain(d) && unmasked )
>      {
>          /*

As said above, such approach relies on dom0 writing to the IO-APIC RTE
of likely each IO-APIC pin, which is IMO not quite reliable.  In there
are two different issues here that need to be fixed for PVH dom0:

 - Fix the XEN_DOMCTL_irq_permission pirq_access_permitted() call to
   succeed for a PVH dom0, even if dom0 is not using the GSI itself.

 - Configure IO-APIC pins for PCI interrupts even if dom0 is not using
   the IO-APIC pin itself.

First one needs to be fixed internally in Xen, second one will require
the toolstack to issue an extra hypercall in order to ensure the
IO-APIC pin is properly configured.

Thanks, Roger.

