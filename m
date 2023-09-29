Return-Path: <linux-acpi+bounces-295-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4FA7B3B3F
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 22:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DC27B280E77
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 20:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E7F37150
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 20:31:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1C405F3
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 19:06:16 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA61C195;
	Fri, 29 Sep 2023 12:06:14 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-57bc11c197aso1279582eaf.1;
        Fri, 29 Sep 2023 12:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696014374; x=1696619174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVer6uvPHCtf/HTMUWD6KTJ1ltbk7x4bE84VkT63hEQ=;
        b=YMlso6DTv1jv1UNJvjSHifDgc6rfJ2cmmv3Ti+NElRPMLgHYXzdT18JfNQlNC1kFKS
         08lPSNb4yMEiBKy5j4I1e4CvrtdDy1fCb3JIKlndtiI27rgFgfQL/xC5nVYUnwX4S3ws
         OTChLYM7Cd1PBGDDS2NFeGQeMJb3LPsicAzBNCED8KGmxsJvUm8j4PPZuN9ThaqQ8UJP
         W0HOg4BVjBijpx7aTJy17uBy/agm0SaCtOHP5IryI86zlPbE+7mOYUAm230q+oPGtcHx
         YxvY27T1zMjzK7nP2pn9PSYgnTrgyxjFGdC25IyxkQD7TZ9sF0hdyb99VJSnmWNoSMLx
         SFuw==
X-Gm-Message-State: AOJu0YwRB64q5RORgRxoBAYeFKNtodwysO6ZgIrmOZVshExtNYjhWyLa
	WSJ9rQsJL3YdfKT1AMZwI723B1GpRTXYgY0bdqM=
X-Google-Smtp-Source: AGHT+IFAE7exkSvkEz769ZW360a8v7ReoFJMsoE/IfxftUeB0GmO+2TM0PqbKJx6ZFE+ijkVcHKoana+guEGrgnZlkM=
X-Received: by 2002:a4a:ee1a:0:b0:56e:94ed:c098 with SMTP id
 bd26-20020a4aee1a000000b0056e94edc098mr5644121oob.0.1696014374101; Fri, 29
 Sep 2023 12:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927202347.2795170-1-scott@os.amperecomputing.com> <20230928154720.GA462358@bhelgaas>
In-Reply-To: <20230928154720.GA462358@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Sep 2023 21:06:02 +0200
Message-ID: <CAJZ5v0j9hvhboyfmgs1CXkUqpmrMryNjwWGV+kJB-FCMfXaM_g@mail.gmail.com>
Subject: Re: [PATCH] PCI: hotplug: Add extension driver for Ampere Altra
 hotplug LED control
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: D Scott Phillips <scott@os.amperecomputing.com>, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	Darren Hart <darren@os.amperecomputing.com>, patches@amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 5:47=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Sep 27, 2023 at 01:23:47PM -0700, D Scott Phillips wrote:
> > On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface=
 is
> > also present to request system firmware control of attention LEDs. Add =
an
> > ACPI PCI Hotplug companion driver to support attention LED control.
> >
> > Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> > ---
> >  drivers/pci/hotplug/Kconfig                |  13 ++
> >  drivers/pci/hotplug/Makefile               |   3 +-
> >  drivers/pci/hotplug/acpiphp_ampere_altra.c | 141 +++++++++++++++++++++
> >  3 files changed, 156 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/pci/hotplug/acpiphp_ampere_altra.c
> >
> > diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> > index 48113b210cf93..9fde600a9ad3e 100644
> > --- a/drivers/pci/hotplug/Kconfig
> > +++ b/drivers/pci/hotplug/Kconfig
> > @@ -61,6 +61,19 @@ config HOTPLUG_PCI_ACPI
> >
> >         When in doubt, say N.
> >
> > +config HOTPLUG_PCI_ACPI_AMPERE_ALTRA
> > +     tristate "ACPI PCI Hotplug driver Ampere Altra extensions"
> > +     depends on HOTPLUG_PCI_ACPI
> > +     depends on HAVE_ARM_SMCCC_DISCOVERY
> > +     depends on m
>
> Why is this restricted to being a module?  It's not unprecedented, but
> unless this only works as a module for some reason, I would leave that
> choice up to the user.
>
> > +     help
> > +       Say Y here if you have an Ampere Altra system.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called acpiphp_ampere_altra.
> > +
> > +       When in doubt, say N.
> > +
> >  config HOTPLUG_PCI_ACPI_IBM
> >       tristate "ACPI PCI Hotplug driver IBM extensions"
> >       depends on HOTPLUG_PCI_ACPI
> > diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefil=
e
> > index 5196983220df6..29d7f6171b305 100644
> > --- a/drivers/pci/hotplug/Makefile
> > +++ b/drivers/pci/hotplug/Makefile
> > @@ -21,8 +21,9 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR) +=3D rpadlpar_io.=
o
> >  obj-$(CONFIG_HOTPLUG_PCI_ACPI)               +=3D acpiphp.o
> >  obj-$(CONFIG_HOTPLUG_PCI_S390)               +=3D s390_pci_hpc.o
> >
> > -# acpiphp_ibm extends acpiphp, so should be linked afterwards.
> > +# acpiphp_ibm extend acpiphp, so should be linked afterwards.
> >
> > +obj-$(CONFIG_HOTPLUG_PCI_ACPI_AMPERE_ALTRA)  +=3D acpiphp_ampere_altra=
.o
> >  obj-$(CONFIG_HOTPLUG_PCI_ACPI_IBM)   +=3D acpiphp_ibm.o
> >
> >  pci_hotplug-objs     :=3D      pci_hotplug_core.o
> > diff --git a/drivers/pci/hotplug/acpiphp_ampere_altra.c b/drivers/pci/h=
otplug/acpiphp_ampere_altra.c
> > new file mode 100644
> > index 0000000000000..8692b939dea78
> > --- /dev/null
> > +++ b/drivers/pci/hotplug/acpiphp_ampere_altra.c
> > @@ -0,0 +1,141 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ACPI PCI Hot Plug Ampere Altra Extension
>
> Would be helpful to include a hint about what this module *does*.
> IIUC, it controls the attention indicator.
>
> > + *
> > + * Copyright (C) 2023 Ampere Computing LLC
> > + *
>
> Spurious blank line.
>
> > + */
> > +
> > +#define pr_fmt(fmt) "acpiphp_ampere_altra: " fmt
> > +
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/pci_hotplug.h>
> > +
> > +#include "acpiphp.h"
> > +
> > +#define HANDLE_OPEN  0xb0200000
> > +#define HANDLE_CLOSE 0xb0300000
> > +#define REQUEST              0xf0700000
> > +#define LED_CMD              0x00000004
> > +#define LED_ATTENTION        0x00000002
> > +#define LED_SET_ON   0x00000001
> > +#define LED_SET_OFF  0x00000002
> > +#define LED_SET_BLINK        0x00000003
> > +
> > +static const struct acpi_device_id acpi_ids[] =3D {
> > +     {"AMPC0008", 0}, {}
> > +};
> > +MODULE_DEVICE_TABLE(acpi, acpi_ids);
> > +
> > +static u32 led_service_id[4];
> > +
> > +static int led_status(u8 status)
> > +{
> > +     switch (status) {
> > +     case 1: return LED_SET_ON;
> > +     case 2: return LED_SET_BLINK;
> > +     default: return LED_SET_OFF;
> > +     }
> > +}
> > +
> > +static int set_attention_status(struct hotplug_slot *slot, u8 status)
> > +{
> > +     struct arm_smccc_res res;
> > +     struct pci_bus *bus;
> > +     struct pci_dev *root_port;
> > +     unsigned long flags;
> > +     u32 handle;
> > +     int ret =3D 0;
> > +
> > +     bus =3D slot->pci_slot->bus;
> > +     root_port =3D pcie_find_root_port(bus->self);
> > +     if (!root_port)
> > +             return -ENODEV;
> > +
> > +     local_irq_save(flags);
> > +     arm_smccc_smc(HANDLE_OPEN, led_service_id[0], led_service_id[1],
> > +                   led_service_id[2], led_service_id[3], 0, 0, 0, &res=
);
> > +     if (res.a0) {
> > +             ret =3D -ENODEV;
> > +             goto out;
> > +     }
> > +     handle =3D res.a1 & 0xffff0000;
> > +
> > +     arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION=
,
> > +                   pci_domain_nr(bus) | ((root_port->devfn >> 3) << 4)=
, 0, 0,
>
> PCI_SLOT(root_port->devfn)
>
> > +                   handle, &res);
> > +     if (res.a0)
> > +             ret =3D -ENODEV;
> > +
> > +     arm_smccc_smc(HANDLE_CLOSE, handle, 0, 0, 0, 0, 0, 0, &res);
> > +
> > + out:
> > +     local_irq_restore(flags);
> > +     return ret;
> > +}
> > +
> > +static int get_attention_status(struct hotplug_slot *slot, u8 *status)
> > +{
> > +     return -EINVAL;
> > +}
> > +
> > +static struct acpiphp_attention_info ampere_altra_attn =3D {
> > +     .set_attn =3D set_attention_status,
> > +     .get_attn =3D get_attention_status,
> > +     .owner =3D THIS_MODULE,
> > +};
> > +
> > +static acpi_status __init get_acpi_handle(acpi_handle handle, u32 leve=
l,
> > +                                       void *context, void **return_va=
lue)
> > +{
> > +     *(acpi_handle *)return_value =3D handle;
> > +     return AE_CTRL_TERMINATE;
> > +}
> > +
> > +static int __init acpiphp_ampere_altra_init(void)
> > +{
> > +     struct fwnode_handle *fwnode;
> > +     acpi_handle leds_handle =3D NULL;
> > +     struct acpi_device *leds;
> > +     acpi_status status;
> > +     int ret;
> > +
> > +     status =3D acpi_get_devices("AMPC0008", get_acpi_handle, NULL,
> > +                               &leds_handle);
>
> Rafael, can you comment on whether we should use acpi_get_devices(),
> acpi_bus_register_driver(), acpi_acpi_scan_add_handler(), or something
> else here?

Personally, I would go for a platform driver, because the ACPI core
should create a platform device for this object.

acpi_get_devices() carries out a namespace walk that is costly and
entirely avoidable.

>  I try to avoid pci_get_device() because it subverts the
> driver model (no hotplug support, no driver/device binding).
>
> I see Documentation/driver-api/acpi/scan_handlers.rst, but I'm not
> clear on when to use acpi_bus_register_driver() vs

Never.

> acpi_acpi_scan_add_handler().

When you don't want the ACPI core to create a platform device for your
ACPI device object.  There are cases like that, but they are rare.

> I guess the only ACPI connection here is to retrieve the "uuid"
> property once, and there's no need for any ACPI services after that.

That's in agreement with my understanding.

