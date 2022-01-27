Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0751F49EE64
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jan 2022 00:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbiA0XC5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jan 2022 18:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbiA0XC5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jan 2022 18:02:57 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B0CC061714
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jan 2022 15:02:57 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q75so3648992pgq.5
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jan 2022 15:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/T3d3BHyHgSEeRHYbPalrQa/ABBLLusG6xLRPMZcck=;
        b=UgmfO85UkIvmyM+8UoKDDoHWDCmFMd4BEM5eU2Fh5alMiqP08m7IJYMcQHZJhqjr2D
         hr7ZMrljs4GkMHwRzC6+Pyp9i99uC245oEV53tzwecOyWhE+4e1JK0gbTll3yDemwUx4
         nk4rd7VBbADgZygkRxCIg5P57Xb75VETcaHJPX1n4VmfIYFAFiCtDD2n7/4LVAnNLUm+
         Hk6U/ZXC1UrMWtJF+mJlgAjYrr8nN9PiJkYQc+2z5CfZK4VtzXaCgMoyHugHcN/y4xpc
         6O8gtOsq0wRsuRzzTPsGZ00JVxW3CaIgDaqTNgC6W6WgcQbrth9mgHKzd9SkDTFXaqWW
         IYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/T3d3BHyHgSEeRHYbPalrQa/ABBLLusG6xLRPMZcck=;
        b=LiKAltphjFNMmkss30mn3N757Lg/CjAsoF+nXaWUIGIApkgHtEc27ChXAURaZVfZ98
         9y+XIK8PeI72NKQ2AYScyGitopbbSAECKDggC2zP/Bk6jzmSJvwCpPyNJp2gjU1UV2Wq
         ChIIgMHC3ZrSNS+/0/Z9nH+kG7Qxkw1mTkxG4bYuoj1bLlIwSZdPeDhXT9VuU+sftv9u
         JQvmbk7YOI+k/0GZnOcn/48S1GIrYk1bMWTNuGWOn3JzZNjSdUDc1DI6+N7VRw/JMuKS
         dkUBI8WuCQ+z68e/pA0l2A1/Y6DJa83d/Ee6tqwG6lSvofLP0by5TrFHohf5xtiW6uNe
         iB0A==
X-Gm-Message-State: AOAM532J5aNN66kj7iiXG6LAxuJU/YAo5ax490o4eSMbat0hgamn8nLC
        yaKBcv+DZqIBgnGmb+RnJ+bh0NuJbYaQVPDCDcHHgg==
X-Google-Smtp-Source: ABdhPJwP6mBgzYcmwq8apICTnPgaiSCnMvHi48jbQpS1tgltTYSr9JFSK9z+MsyfUOfecwjpyWzWOxd5MPJUaOrSBK4=
X-Received: by 2002:a05:6a00:d5c:: with SMTP id n28mr5360304pfv.9.1643324576267;
 Thu, 27 Jan 2022 15:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20220120000409.2706549-1-rajatja@google.com> <CAE_wzQ_XxONXx5bgDNLAWM_UbV0r8hP9fW6s5sgRYRVSHQWjLw@mail.gmail.com>
In-Reply-To: <CAE_wzQ_XxONXx5bgDNLAWM_UbV0r8hP9fW6s5sgRYRVSHQWjLw@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 27 Jan 2022 15:02:20 -0800
Message-ID: <CACK8Z6GCPU8ZYQgwCJ5jWJ5NLQM3y+g6Ry=59-oVV3CHGe_8Aw@mail.gmail.com>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as untrusted
To:     Dmitry Torokhov <dtor@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatxjain@gmail.com,
        jsbarnes@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Dmitry,

On Wed, Jan 19, 2022 at 6:25 PM Dmitry Torokhov <dtor@google.com> wrote:
>
> Hi Rajat,
>
> On Wed, Jan 19, 2022 at 4:04 PM Rajat Jain <rajatja@google.com> wrote:
> >
> > Today the pci_dev->untrusted is set for any devices sitting downstream
> > an external facing port (determined via "ExternalFacingPort" property).
> > This however, disallows any internal devices to be marked as untrusted.
> >
> > There are use-cases though, where a platform would like to treat an
> > internal device as untrusted (perhaps because it runs untrusted
> > firmware, or offers an attack surface by handling untrusted network
> > data etc).
> >
> > This patch introduces a new "UntrustedDevice" property that can be used
> > by the firmware to mark any device as untrusted.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/pci/pci-acpi.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index a42dbf448860..3d9e5fa49451 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1350,12 +1350,25 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
> >                 dev->external_facing = 1;
> >  }
> >
> > +static void pci_acpi_set_untrusted(struct pci_dev *dev)
> > +{
> > +       u8 val;
> > +
> > +       if (device_property_read_u8(&dev->dev, "UntrustedDevice", &val))
> > +               return;
> > +
> > +       /* These PCI devices are not trustworthy */
> > +       if (val)
> > +               dev->untrusted = 1;
>
> Should this all be replaced with:
>
> dev->untrusted = device_property_read_bool(&dev->dev, "UntrustedDevice");

The device_property_read_bool() seems to be merely checking for
property presence (and ignoring its value).

I checked with our BIOS / ACPI team. Per them, the ACPI properties
always have a value associated with them.

So if I switch to device_property_read_bool(),  "UntrustedDevice"
property with a value of "0" in ACPI shall be marked as an untrusted
device by the kernel. I understand that this may be a confusing corner
case of bad ACPI, but I was thinking it may be better to use the ACPI
value also in the kernel to decide. Thus I think the use of
device_property_read_u8() (the current code) may be better. WDYT?

Thanks & Best Regards,

Rajat

>
> ?
>
> Also, is this ACPI-specific? Why won't we need this for DT systems (or
> do we already have this)?.
>
> Thanks,
> Dmitry
