Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5AA32C78C
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2019 15:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfE1NM5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 May 2019 09:12:57 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37218 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1NM5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 May 2019 09:12:57 -0400
Received: by mail-it1-f194.google.com with SMTP id m140so3790763itg.2
        for <linux-acpi@vger.kernel.org>; Tue, 28 May 2019 06:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGidpikOk3gFKCEpFN2Vpze39VdGj7YWoOUOht53ZfY=;
        b=oV86f4NqmhlHkcJh2rWNymzheFl8WV2TPMwq9FwNwZcPBEInGaL/uPUrCPKG/3KOhk
         2L+nSHnGap6rGYFoTnt1r+ThdpkRjZcbrg8OfEJ8XsZaZPjH6c0KWRlF7A0ziu3S5zpO
         XL1OwyFZHLBENGonYAc5AQ2cFXYOGMCE8WbvyVZfwot2KVjp/IOou112vdblLSdxxEox
         8MLlZ8h4zs9K8rtuiPinav5hcX3a6Gkl5x8ZR5lOBg+K50V3yg9etiiuJhi/0ny3bOwt
         9TzdVC9eYixxom6i85+fM4uRLAOD4BQ2PuFZ7uvCI60p43i8EM87ybRtbKBuZJN70p8H
         1ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGidpikOk3gFKCEpFN2Vpze39VdGj7YWoOUOht53ZfY=;
        b=qifOd4h3QwYvt/t6xdhCuORSFgOqR8beSxD6X1+MSzebyo6aTfXBMrAGZAMtSbuabR
         wbNx938XWDZzcR1plIWt9F8CWA2ZHS49DwqmIIkgckQXaUDsd56O43OYJzyHnFPXxu8D
         F2wGpdwtOH00SSEsHXxsZDXb5MP5ooYEfTznYtacGCQm0es+bJGP3+XI69wVefA0byyz
         X6aDJTiiZ65IJjlkWAONVB1KjrWX9SPIPCiH4aYd4XaYoEZ9mbCdsJHuvCaQLqUdqm4l
         7LVeYFhNb9Rs9o+eOYt6SnWqXKFW6ANkZW1KUTIoQrnZb32mrCSjR7KhABVQ305B5JLl
         ekLg==
X-Gm-Message-State: APjAAAXRjntmMOu8Bkf2hZkPLNTZ3V6EovQNs/6VTkocexORIm9ZcrJG
        /qz6YtbQrm7ORJFYJoHgndvbkecysDFVSDVoLhj/3g==
X-Google-Smtp-Source: APXvYqxh9xMHBYVyEjG0Z0MufOg7ad/5kV8XBfdSlA9dhu8netpmbxXVs3EleLkHkvEmdLU0lp0CSUw9JLEOfidkstg=
X-Received: by 2002:a24:d00e:: with SMTP id m14mr2792618itg.153.1559049176014;
 Tue, 28 May 2019 06:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190527112720.2266-1-ard.biesheuvel@linaro.org>
 <20190527112720.2266-2-ard.biesheuvel@linaro.org> <1c3213ed-bdd6-755e-9cb9-693943410326@arm.com>
In-Reply-To: <1c3213ed-bdd6-755e-9cb9-693943410326@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 28 May 2019 15:12:42 +0200
Message-ID: <CAKv+Gu898dbWjdE8a8_KrhcWfrDmOP81NxWwDpACMvER5LZ0=A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] acpi/irq: implement helper to create hierachical domains
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 28 May 2019 at 14:54, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> Hi Ard,
>
> On 27/05/2019 12:27, Ard Biesheuvel wrote:
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
> >
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
> > + */
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
> >
>
> Should we consider exporting this function to modules?
>

Good point, we probably should.


> Otherwise (and with Mika's comments addressed), looks good to me.
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
