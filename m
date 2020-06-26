Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547F120B8F3
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jun 2020 21:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgFZTCR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jun 2020 15:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgFZTCP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2020 15:02:15 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEECBC03E97B
        for <linux-acpi@vger.kernel.org>; Fri, 26 Jun 2020 12:02:14 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q19so11446732lji.2
        for <linux-acpi@vger.kernel.org>; Fri, 26 Jun 2020 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CupTv356WOheWFFcn47AA78Bc8xE85sorZq/DL/d5ow=;
        b=PljCG4p1Fw8CHLh+rUo2wSWaKZbvtTK+SH69StUSy72aY4d1OYyiZUq/AaW6a5d1MI
         mq7+P723mcxuKFZJ5YT7j2sJC2nDwAp1KAMuq5VMYdluPT75VMQ3W97a14UhUtX4a1Q2
         Y7Br1N0WDugVyuoC8lYZ/SyVf6EN373Kqez82pnoO4DMI2ZgGgU2GH+Ppuhy6J6g/YUt
         1XpiIuatKtMKTEm14jT7CRjJOtuvbAALQKYB80RhD2Byety+zKHXncWQo4dJsh1SQeMA
         nSqGNi15sCpqApCXfW8JO5PL/hkt8la90/o6M5m9jJhBWq0yG5p6KMs8op0c3aNYsphn
         8wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CupTv356WOheWFFcn47AA78Bc8xE85sorZq/DL/d5ow=;
        b=fuAWnKWoehD8MKpM3lP1uFmoJ3aiJBr7U92ISyB/Kc09v07DUgjR405qYagVO+DCMG
         PqwrZZUfAjmgRi2UNQhnjm304gpQXhSiJ82n87Ma1K6pfUgSv4dcMNdulXCFY3iqqG6D
         JFdd7UShBJBEUNb7q8aFf1fDcYms4g3jYnzGRdpC/B7gOKR9M/t+GE+38s5n2uRvdTNs
         oGWr2AuFgC9UlLjAgdWsrgMl5lu/Iw60CeS4mod/fqMu0FTlFVsqUECqj7OB9QADbhYc
         gvId2PLCNgGAABOScBFKvOuWQgSWF2uCZbRFspE5q3+gHy8R0FJQwnt0l9VX0o9YTNUI
         vJtg==
X-Gm-Message-State: AOAM531FrMW5hUErUIEE78QG1bczLX5WwfpcgCFWlAeuB0gpb47pSP0D
        txXaTjWhn7q/TmuqUiJbFjQ1Rp5hdN8Si+inRder5g==
X-Google-Smtp-Source: ABdhPJwXqAgY35bZFXo6/B0G8JpMwZbJM19I1mNnWaLF8LNBfGwBsVegK/WyraehTX79S8Hc7skGI2IKEUUkez0pahs=
X-Received: by 2002:a2e:92cf:: with SMTP id k15mr2200496ljh.333.1593198132811;
 Fri, 26 Jun 2020 12:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200626002710.110200-1-rajatja@google.com> <20200626153906.GA2897118@bjorn-Precision-5520>
In-Reply-To: <20200626153906.GA2897118@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 26 Jun 2020 12:01:36 -0700
Message-ID: <CACK8Z6G7Pau3LTt2LYx=pezLcwxO5kKaM18_yis0w-UGYd675w@mail.gmail.com>
Subject: Re: [PATCH 1/2] pci: Add pci device even if the driver failed to attach
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 26, 2020 at 8:39 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Nit: when you update these patches, can you run "git log --oneline
> drivers/pci/bus.c" and make your subject lines match the convention?

Sorry, will do.

> E.g.,
>
>   PCI: Add device even if driver attach failed
>
> On Thu, Jun 25, 2020 at 05:27:09PM -0700, Rajat Jain wrote:
> > device_attach() returning failure indicates a driver error
> > while trying to probe the device. In such a scenario, the PCI
> > device should still be added in the system and be visible to
> > the user.
>
> Nit: please wrap logs to fill 75 characters.  "git log" adds 4 spaces
> at the beginning, so 75+4 still fits nicely in 80 columns without
> wrapping.

Sorry, will do.

>
> > This patch partially reverts:
> > commit ab1a187bba5c ("PCI: Check device_attach() return value always")
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/pci/bus.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 8e40b3e6da77d..3cef835b375fd 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -322,12 +322,8 @@ void pci_bus_add_device(struct pci_dev *dev)
> >
> >       dev->match_driver = true;
> >       retval = device_attach(&dev->dev);
> > -     if (retval < 0 && retval != -EPROBE_DEFER) {
> > +     if (retval < 0 && retval != -EPROBE_DEFER)
> >               pci_warn(dev, "device attach failed (%d)\n", retval);
> > -             pci_proc_detach_device(dev);
> > -             pci_remove_sysfs_dev_files(dev);
>
> Thanks for catching my bug!
>
> > -             return;
> > -     }
> >
> >       pci_dev_assign_added(dev, true);
> >  }
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
