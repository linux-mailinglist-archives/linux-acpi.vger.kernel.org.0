Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0CF513C87
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Apr 2022 22:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351287AbiD1UT1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Apr 2022 16:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351683AbiD1UTR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Apr 2022 16:19:17 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1B94EA13;
        Thu, 28 Apr 2022 13:16:01 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2f83983782fso65325387b3.6;
        Thu, 28 Apr 2022 13:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2P2jKLYZZOQU2ZB3TDiaxvOZqWuhDku45aifBchtso=;
        b=YgjF8yGo802hUQ0em8K5g4PcX+rBS14pHjpjg9F6Mk9HlZrVK1eFUhbbzQxFND9MOL
         6DkoCqkILjVpG9KEjnNsQ8H43S6ig6dBNzQUCDbgAUQ2/Dc9000hah80RPfZLDk/gyGm
         Um3JIRFB/hhp62k4y13rwAOo6R0z9BcmZ3BHC37M+MrHqNRP9Z5Jee9cCU6urqWTsazb
         ckS7qE+N3sXI8fStlQR23bVsZlvOs6ZsML8omTb3/4jGAgC6AONTggtKZFazGGLav7bT
         /PVIXn0/JRDw1hjI5wdAVfmKmQY7Yr1L5EAXL2RezISAtrZU7kFJz3qr08uUi+p4UwOJ
         tr1Q==
X-Gm-Message-State: AOAM531Mjj57xX6ubkksJn6jZUK/SWL6GDHySK5qZZ4GqxiswcroOGPk
        Rhn48N/8dnaJohjpwoAnBVxNLT+dXDOrvd2CIb0=
X-Google-Smtp-Source: ABdhPJwfTv8u+j9BwgRrJ/H4YWSW3pmz9A1MiIJpIS+p/w75SE98zlHzfFYWN9B7RvE4iUlv2ZrqTqrXXeo/Yxdnsco=
X-Received: by 2002:a81:8493:0:b0:2f7:d7c3:15f8 with SMTP id
 u141-20020a818493000000b002f7d7c315f8mr25057473ywf.196.1651176960566; Thu, 28
 Apr 2022 13:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220428142854.1065953-1-gregkh@linuxfoundation.org>
 <20220428155858.GA14614@bhelgaas> <Ymq/W+KcWD9DKQr/@kroah.com>
In-Reply-To: <Ymq/W+KcWD9DKQr/@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Apr 2022 22:15:49 +0200
Message-ID: <CAJZ5v0hCiO6_deYnUK-5pfqE+fy1XLSUiBvkBgWw2nbqu9ggXA@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: do not reference a pci device after it has been released
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        whitehat002 <hackyzh002@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 28, 2022 at 6:22 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 28, 2022 at 10:58:58AM -0500, Bjorn Helgaas wrote:
> > On Thu, Apr 28, 2022 at 04:28:53PM +0200, Greg Kroah-Hartman wrote:
> > > In acpi_get_pci_dev(), the debugging message for when a PCI bridge is
> > > not found uses a pointer to a pci device whose reference has just been
> > > dropped.  The chance that this really is a device that is now been
> > > removed from the system is almost impossible to happen, but to be safe,
> > > let's print out the debugging message based on the acpi root device
> > > which we do have a valid reference to at the moment.
> >
> > This code was added by 497fb54f578e ("ACPI / PCI: Fix NULL pointer
> > dereference in acpi_get_pci_dev() (rev. 2)").  Not sure if it's worth
> > a Fixes: tag.
>
> Can't hurt, I'll add it for the v2 based on this review.
>
> >
> > acpi_get_pci_dev() is used by only five callers, three of which are
> > video/backlight related.  I'm always skeptical of one-off interfaces
> > like this, but I don't know enough to propose any refactoring or other
> > alternatives.
> >
> > I'll leave this for Rafael, but if I were applying I would silently
> > touch up the subject to match convention:
> >
> >   PCI/ACPI: Do not reference PCI device after it has been released
>
> Much simpler, thanks.
>
> >
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: Len Brown <lenb@kernel.org>
> > > Cc: linux-pci@vger.kernel.org
> > > Cc: linux-acpi@vger.kernel.org
> > > Reported-by: whitehat002 <hackyzh002@gmail.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/acpi/pci_root.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > index 6f9e75d14808..ecda378dbc09 100644
> > > --- a/drivers/acpi/pci_root.c
> > > +++ b/drivers/acpi/pci_root.c
> > > @@ -303,7 +303,8 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
> > >              * case pdev->subordinate will be NULL for the parent.
> > >              */
> > >             if (!pbus) {
> > > -                   dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
> > > +                   dev_dbg(&root->device->dev,
> > > +                           "dev %d, function %d is not a PCI-to-PCI bridge\n", dev, fn);
> >
> > This should use "%02x.%d" to be consistent with the dev_set_name() in
> > pci_setup_device().
>
> Ah, missed that, will change it and send out a new version tomorrow.

I would make the change below (modulo the gmail-induced wthite space
breakage), though.

---
 drivers/acpi/pci_root.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/pci_root.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_root.c
+++ linux-pm/drivers/acpi/pci_root.c
@@ -295,8 +295,6 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
             break;

         pbus = pdev->subordinate;
-        pci_dev_put(pdev);
-
         /*
          * This function may be called for a non-PCI device that has a
          * PCI parent (eg. a disk under a PCI SATA controller).  In that
@@ -304,9 +302,12 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
          */
         if (!pbus) {
             dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
+            pci_dev_put(pdev);
             pdev = NULL;
             break;
         }
+
+        pci_dev_put(pdev);
     }
 out:
     list_for_each_entry_safe(node, tmp, &device_list, node)
