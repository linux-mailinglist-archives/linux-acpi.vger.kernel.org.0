Return-Path: <linux-acpi+bounces-2306-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D981680E69F
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 09:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F4B1C21398
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BAB21376;
	Tue, 12 Dec 2023 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="VfxYjRpC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED191CD
	for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 00:49:15 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3332e351670so4884164f8f.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 00:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1702370954; x=1702975754; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6uZzm+Qo9kyEz193letIHfqz7iKse8Vcx14IHv462OI=;
        b=VfxYjRpCnjM/k0+8JnMAv1EHfq0A+Ttqtsk+bvbP0ONX86EoRk3Eax/HeP93qeQA5T
         cvQV2jJLQNorkK5RUq0JxKZZiF3jwtFbJd5Mty0GY31EH88l5hfF4CHTwtILUM1xKU3r
         KhHBYi9ILlkG+LPTStq+YUW//zCHD53nUYz28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702370954; x=1702975754;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uZzm+Qo9kyEz193letIHfqz7iKse8Vcx14IHv462OI=;
        b=pTajq4wJjJUlFjDZSzUe+33w4x9FtvaeqF1f4vY9SvnjkmL2aXJ0JYbB8xmumcWMME
         +N2JI567v/UviRqyEizfsIVyqS4ogwcThB0IE9DFnS9ugSDg9wt3D3/CL4wRzeterXx+
         /eDC/HIyrGlSjNMPLMnPwo5ANfZM2IbRgfuV6ubgRpw/HwVEnEqWpVt8SgtWtzbS9vYS
         iJjvVvTEql+8+AIgepVIjyb3peHYFWXQxl2OsUnAo+j/HNdeJQXSZ6WE3mWbeXQErHHJ
         oSh0jm+igyQRl6NSlo03fRQeISJ7lrpK10LvRqnakm+P0d4O1h14BAtHZekvaiiwfUwI
         Fg+A==
X-Gm-Message-State: AOJu0Yyjk7jlmQzrxfs1YNiKLwY9OrLm977rDb6cPpa8JRrjalrK0V0Z
	ouGmL1KcZal0WLskbHkbGo63kg==
X-Google-Smtp-Source: AGHT+IEZFnrGwnWVMUa8WqvQ1kBpf2Ui1ZoWTnehWdJvArdWdni7kizYW7qHE4fznbzxBvAlLIdv1A==
X-Received: by 2002:a05:6000:1012:b0:333:174f:edd8 with SMTP id a18-20020a056000101200b00333174fedd8mr1089314wrx.50.1702370954354;
        Tue, 12 Dec 2023 00:49:14 -0800 (PST)
Received: from localhost ([213.195.113.99])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d590d000000b003363469490asm503631wrd.111.2023.12.12.00.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 00:49:13 -0800 (PST)
Date: Tue, 12 Dec 2023 09:49:13 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Jan Beulich <jbeulich@suse.com>, Juergen Gross <jgross@suse.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"Stabellini, Stefano" <stefano.stabellini@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>,
	"Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
	"Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>,
	"Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
Message-ID: <ZXgeieg4E8UN0KoN@macbook>
References: <alpine.DEB.2.22.394.2311301912350.110490@ubuntu-linux-20-04-desktop>
 <ZWmgJNidFsfkDp7q@macbook>
 <alpine.DEB.2.22.394.2312011857260.110490@ubuntu-linux-20-04-desktop>
 <ZW2ptexPQXrWBiOS@macbook>
 <alpine.DEB.2.22.394.2312041413000.110490@ubuntu-linux-20-04-desktop>
 <ZW7rDjjC0gxEI1cq@macbook>
 <15275706-5c31-4e29-aa29-9f5e90526219@suse.com>
 <BL1PR12MB5849C871B0B9577D1E0BF576E784A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXculMdLgwGaRC7i@macbook>
 <BL1PR12MB584997DDE6839F2340022976E78EA@BL1PR12MB5849.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR12MB584997DDE6839F2340022976E78EA@BL1PR12MB5849.namprd12.prod.outlook.com>

On Tue, Dec 12, 2023 at 06:16:43AM +0000, Chen, Jiqian wrote:
> On 2023/12/11 23:45, Roger Pau Monné wrote:
> > On Wed, Dec 06, 2023 at 06:07:26AM +0000, Chen, Jiqian wrote:
> >>
> >> When PVH dom0 enable a device, it will get trigger and polarity from ACPI (see acpi_pci_irq_enable)
> >> I have a version of patch which tried that way, see below:
> >>
> >> diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
> >> index ada3868c02c2..43e1bda9f946 100644
> >> --- a/arch/x86/xen/enlighten_pvh.c
> >> +++ b/arch/x86/xen/enlighten_pvh.c
> >> @@ -1,6 +1,7 @@
> >>  // SPDX-License-Identifier: GPL-2.0
> >>  #include <linux/acpi.h>
> >>  #include <linux/export.h>
> >> +#include <linux/pci.h>
> >>
> >>  #include <xen/hvc-console.h>
> >>
> >> @@ -25,6 +26,127 @@
> >>  bool __ro_after_init xen_pvh;
> >>  EXPORT_SYMBOL_GPL(xen_pvh);
> >>
> >> +typedef struct gsi_info {
> >> +       int gsi;
> >> +       int trigger;
> >> +       int polarity;
> >> +       int pirq;
> >> +} gsi_info_t;
> >> +
> >> +struct acpi_prt_entry {
> >> +       struct acpi_pci_id      id;
> >> +       u8                      pin;
> >> +       acpi_handle             link;
> >> +       u32                     index;          /* GSI, or link _CRS index */
> >> +};
> >> +
> >> +static int xen_pvh_get_gsi_info(struct pci_dev *dev,
> >> +                                                               gsi_info_t *gsi_info)
> >> +{
> >> +       int gsi;
> >> +       u8 pin = 0;
> >> +       struct acpi_prt_entry *entry;
> >> +       int trigger = ACPI_LEVEL_SENSITIVE;
> >> +       int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
> >> +                                     ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
> >> +
> >> +       if (dev)
> >> +               pin = dev->pin;
> >> +       if (!pin) {
> >> +               xen_raw_printk("No interrupt pin configured\n");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       entry = acpi_pci_irq_lookup(dev, pin);
> >> +       if (entry) {
> >> +               if (entry->link)
> >> +                       gsi = acpi_pci_link_allocate_irq(entry->link,
> >> +                                                        entry->index,
> >> +                                                        &trigger, &polarity,
> >> +                                                        NULL);
> >> +               else
> >> +                       gsi = entry->index;
> >> +       } else
> >> +               return -EINVAL;
> >> +
> >> +       gsi_info->gsi = gsi;
> >> +       gsi_info->trigger = trigger;
> >> +       gsi_info->polarity = polarity;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int xen_pvh_map_pirq(gsi_info_t *gsi_info)
> >> +{
> >> +       struct physdev_map_pirq map_irq;
> >> +       int ret;
> >> +
> >> +       map_irq.domid = DOMID_SELF;
> >> +       map_irq.type = MAP_PIRQ_TYPE_GSI;
> >> +       map_irq.index = gsi_info->gsi;
> >> +       map_irq.pirq = gsi_info->gsi;
> >> +
> >> +       ret = HYPERVISOR_physdev_op(PHYSDEVOP_map_pirq, &map_irq);
> >> +       gsi_info->pirq = map_irq.pirq;
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static int xen_pvh_unmap_pirq(gsi_info_t *gsi_info)
> >> +{
> >> +       struct physdev_unmap_pirq unmap_irq;
> >> +
> >> +       unmap_irq.domid = DOMID_SELF;
> >> +       unmap_irq.pirq = gsi_info->pirq;
> >> +
> >> +       return HYPERVISOR_physdev_op(PHYSDEVOP_unmap_pirq, &unmap_irq);
> >> +}
> >> +
> >> +static int xen_pvh_setup_gsi(gsi_info_t *gsi_info)
> >> +{
> >> +       struct physdev_setup_gsi setup_gsi;
> >> +
> >> +       setup_gsi.gsi = gsi_info->gsi;
> >> +       setup_gsi.triggering = (gsi_info->trigger == ACPI_EDGE_SENSITIVE ? 0 : 1);
> >> +       setup_gsi.polarity = (gsi_info->polarity == ACPI_ACTIVE_HIGH ? 0 : 1);
> >> +
> >> +       return HYPERVISOR_physdev_op(PHYSDEVOP_setup_gsi, &setup_gsi);
> >> +}
> > 
> > Hm, why not simply call pcibios_enable_device() from pciback?  What
> pcibios_enable_device had been called when using cmd "xl pci-assignable-add sbdf" from pciback. But it didn't do map_pirq and setup_gsi.
> Because pcibios_enable_device-> pcibios_enable_irq-> __acpi_register_gsi(acpi_register_gsi_ioapic PVH specific)
> > you are doing here using the hypercalls is a backdoor into what's done
> > automatically by Xen on IO-APIC accesses by a PVH dom0.
> But the gsi didn't be unmasked, and vioapic_hwdom_map_gsi is never called.
> So, I think in pciback, if we can do what vioapic_hwdom_map_gsi does.
>

I see, it does setup the IO-APIC pin but doesn't unmask it, that's
what I feared.

> > It will be much more natural for the PVH dom0 model to simply use the
> > native way to configure and unmask the IO-APIC pin, and that would
> > correctly setup the triggering/polarity and bind it to dom0 without
> > requiring the usage of any hypercalls.
> Do you still prefer that I called unmask_irq in pcistub_init_device, as this v2 patch do?
> But Thomas Gleixner think it is not suitable to export unmask_irq.

Yeah, that wasn't good.

> > 
> > Is that an issue since in that case the gsi will get mapped and bound
> > to dom0?
> Dom0 do map_pirq is to pass the check xc_domain_irq_permission()-> pirq_access_permitted(), 

Can we see about finding another way to fix this check?

One option would be granting permissions over the IRQ in
PHYSDEVOP_setup_gsi?

Otherwise we could see about modifying the logic in PHYSDEVOP_map_pirq
so that the hardware domain can map IRQs to other domains without
having it mapped to itself first?

I think the call to PHYSDEVOP_setup_gsi in pciback is fine, but I
would really like to avoid the usage of PHYSDEVOP_{,un}map_pirq on a
PVH dom0 against itself.

> > 
> > Otherwise I would prefer if the gsi is just configured from pciback
> > (PHYSDEVOP_setup_gsi) but not mapped, as allowing a PVH dom0 to map
> > interrupts using PHYSDEVOP_{,un}map_pirq to itself introduces a new
> > interface to manage interrupts that clashes with the native way that a
> > PVH dom0 uses.
> This method does map_pirq and setup_gsi only when a device is assigned to passthrough, it won't affect the other device using native way.

It's not affected because of the specific usage in Linux, but allowing
the interface to be used against itself (so to manage interrupts
from assigned to dom0) is opening a whole new way to setup interrupts,
and it's unclear to me how that will affect the current way we use to
manage interrupts on a PVH dom0.

Thanks, Roger.

