Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC3B2C78B
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2019 15:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfE1NMs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 May 2019 09:12:48 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51914 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1NMs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 May 2019 09:12:48 -0400
Received: by mail-it1-f194.google.com with SMTP id m3so4235202itl.1
        for <linux-acpi@vger.kernel.org>; Tue, 28 May 2019 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ch6XsF4UkVDwbCtK10AE8N7qp77v0YkcnUzTiE/e8Wo=;
        b=UDHPDd6eadbAHYaP04Cm1XVM2x1yZoC0tAY4rfUmppJ96IeB9CdtarAqp26BGa1wNm
         EIIaAqWORDZNx/Eon9VS6GbvD4pOEXFnggl0fe1H9zbqLNEQvdv44lP7kwOqgjoBVqEN
         g9k5/ha0yYhZdGCRp08+rNai+C+qISbz64aHwjZtFR+X+UbF2XArTc+0mJuVUr4rUMfg
         suuEWe8fn6oKmbciozq2nCYcHcnMDIUTFH/1fkFuJ4b/DNY/ZoRVuxlWrAJMVpS2Cv18
         1jCYgODJS/naqPgxQwREU6vqcws1Yfh78Hn6Qabwx1GpKYPF7Xm7HzK4f57BRLIyaGpQ
         sPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ch6XsF4UkVDwbCtK10AE8N7qp77v0YkcnUzTiE/e8Wo=;
        b=T7xJfZJyz7titvtsHpbf7MpcIKSCn6Lzz2VNQe5JMY5XDTsFCvj68XuKiLC6ID4uFF
         BDYBKneXXt7LnablCO05z0lD6+gUwtxcyqNSRg3vkHIZJ91Rj/NF0xFyF7lWM4yKxLe0
         GAlMPvpDFraHqycuiamGl9xdl6SUWw4lX8Ka5EW0qITjwS5ZHMAmT3S254H60OTLYcEj
         I+/r17avm7GYhzB28K166RZIfMRUPy7yfTusInuWDcSbVc3YC3FnW9m9b5yIkt7Sqtp2
         g7JREb3uJn0OzZPLAt46SfchpdgOuGgNAB5C0nGjRBTIoGkclls32cuOAPSog31kmiLf
         yhHA==
X-Gm-Message-State: APjAAAULE9+1nilCiPUXtkHT3aGqgVRi8QOHYVYVLaFy+kSjCC7OjupA
        6zLoBe9p/5VjcidIKkk1KOp/maCfremKHhHZYRJHV05oFuA=
X-Google-Smtp-Source: APXvYqxLB1pPADB1FNuibHAgC0X75X9+avjoPthNYmISUQ4GARPimb8jbgaZz2VKax2H1f0/5DqrH9zrGOFDmB0KMxQ=
X-Received: by 2002:a24:910b:: with SMTP id i11mr3270618ite.76.1559049166968;
 Tue, 28 May 2019 06:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190527112720.2266-1-ard.biesheuvel@linaro.org>
 <20190527112720.2266-2-ard.biesheuvel@linaro.org> <20190528130247.GA25151@redmoon>
In-Reply-To: <20190528130247.GA25151@redmoon>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 28 May 2019 15:12:34 +0200
Message-ID: <CAKv+Gu8ci4ksq0ZHi1Ngdejjx1dKsdfL3ruYjTwu+hyXigOHYQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] acpi/irq: implement helper to create hierachical domains
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 28 May 2019 at 15:02, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, May 27, 2019 at 01:27:17PM +0200, Ard Biesheuvel wrote:
> > ACPI permits arbitrary producer->consumer interrupt links to be
> > described in AML, which means a topology such as the following
> > is perfectly legal:
> >
> >   Device (EXIU) {
> >     Name (_HID, "SCX0008")
> >     Name (_UID, Zero)
> >     Name (_CRS, ResourceTemplate () {
> >       ...
> >     })
> >   }
> >
> >   Device (GPIO) {
> >     Name (_HID, "SCX0007")
> >     Name (_UID, Zero)
> >     Name (_CRS, ResourceTemplate () {
> >       Memory32Fixed (ReadWrite, SYNQUACER_GPIO_BASE, SYNQUACER_GPIO_SIZE)
> >       Interrupt (ResourceConsumer, Edge, ActiveHigh, ExclusiveAndWake, 0, "\\_SB.EXIU") {
> >         7,
> >       }
> >     })
> >     ...
> >   }
> >
> > The EXIU in this example is the external interrupt unit as can be found
> > on Socionext SynQuacer based platforms, which converts a block of 32 SPIs
> > from arbitrary polarity/trigger into level-high, with a separate set
> > of config/mask/unmask/clear controls.
> >
> > The existing DT based driver in drivers/irqchip/irq-sni-exiu.c models
> > this as a hierarchical domain stacked on top of the GIC's irqdomain.
> > Since the GIC is modeled as a DT node as well, obtaining a reference
> > to this irqdomain is easily done by going through the parent link.
> >
> > On ACPI systems, however, the GIC is not modeled as an object in the
> > namespace, and so device objects cannot refer to it directly. So in
> > order to obtain the irqdomain reference when driving the EXIU in ACPI
> > mode, we need a helper that implicitly grabs the default domain for
> > unqualified interrupts as the parent of the hierarchy.
>
> Nit: I do not think they are "unqualified".
>
> ACPI 6.3, table 6-237, Extended Interrupt Descriptor Definition:
>
> "Resource Source: (Optional) If present, the device that uses this
> descriptor consumes its resources from the resources produces by the
> named device object. If not present, the device consumes its resources
> out of a global pool."
>
> Where the global pool I _assume_ is the GSI domain, so it is the default
> expected behaviour (for once :))
>

By 'unqualified', I meant lacking an explicit description of the
producer of the resource. But I can change the wording if you prefer.

> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  drivers/acpi/irq.c   | 20 ++++++++++++++++++++
> >  include/linux/acpi.h |  7 +++++++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> > index c3b2222e2129..39824a6bbcd5 100644
> > --- a/drivers/acpi/irq.c
> > +++ b/drivers/acpi/irq.c
> > @@ -295,3 +295,23 @@ void __init acpi_set_irq_model(enum acpi_irq_model_id model,
> >       acpi_irq_model = model;
> >       acpi_gsi_domain_id = fwnode;
> >  }
> > +
> > +/**
> > + * acpi_irq_create_hierarchy - Create a hierarchical IRQ domain with the default
> > + *                             GSI domain as its parent.
>
> Yes please comment parameters even if it is just a wrapper around
> the IRQ domain API.
>
> > +struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
> > +                                          unsigned int size,
> > +                                          struct fwnode_handle *fwnode,
> > +                                          const struct irq_domain_ops *ops,
> > +                                          void *host_data)
> > +{
> > +     struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
> > +                                                     DOMAIN_BUS_ANY);
> > +
> > +     if (!d)
> > +             return NULL;
> > +
> > +     return irq_domain_create_hierarchy(d, flags, size, fwnode, ops,
> > +                                        host_data);
> > +}
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 98440df7fe42..70de4bc30cea 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -23,6 +23,7 @@
> >
> >  #include <linux/errno.h>
> >  #include <linux/ioport.h>    /* for struct resource */
> > +#include <linux/irqdomain.h>
> >  #include <linux/resource_ext.h>
> >  #include <linux/device.h>
> >  #include <linux/property.h>
> > @@ -327,6 +328,12 @@ int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
> >  void acpi_set_irq_model(enum acpi_irq_model_id model,
> >                       struct fwnode_handle *fwnode);
> >
> > +struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
> > +                                          unsigned int size,
> > +                                          struct fwnode_handle *fwnode,
> > +                                          const struct irq_domain_ops *ops,
> > +                                          void *host_data);
> > +
> >  #ifdef CONFIG_X86_IO_APIC
> >  extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
> >  #else
>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks,
