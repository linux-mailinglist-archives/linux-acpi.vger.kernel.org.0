Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48647378E0B
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 15:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhEJNDR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 09:03:17 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41478 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344134AbhEJMPJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 May 2021 08:15:09 -0400
Received: by mail-oi1-f176.google.com with SMTP id c3so15524498oic.8;
        Mon, 10 May 2021 05:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fboLOkjk/hCDtSPTcX8AIWJRE0a8Sh94lkTCPCuCvzg=;
        b=O/X8TuXlQj7afHpX1g+oIXWNckciWLZOUzQeHB3rGSX5xc52rmJMOg4NZRQAkvDKAZ
         3PaQxdobT/KN9BwNps3BbFDMxIDpTQYWL/sC9T30Q9ePPMuJ2QvtovKm5weHkk5thGRp
         3315Vr/Ghvy1TYkgoqp+tQ93p7cTYs2MQYwiKWHxdvslM8LQVjF0qlFxLEI4blnlEogZ
         0CYXI6g7AK0hJPqi4YPHMv9lg98TsEB+4AGUFWancEUOg3Jud+HVIIwIvd0+RRWLdu6j
         vTCvcLF5iqvMoVDHcx1ctzdfaZDR/OzVtcYTBL7Z258txgRJjaAB6Pa1Nbb6vwxsk3fQ
         YGoQ==
X-Gm-Message-State: AOAM532TmBQftsEVH9lvHcq+vq2yRBLtuhfJHxmJZ06UTTu0g9348yWB
        /OHIt2cDFlONqJO65zLcE3XCqqLTLAHrqwoqLEdyCsRq3m4=
X-Google-Smtp-Source: ABdhPJz3udHKEZEtCKdmIXd3gLsK2mVjtPhiKbN4zQKQ9Rllse+OVvsnuVslH/wXNfxFDkhzgXSWz8M5SGM27RUp/V8=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr17025935oib.69.1620648844947;
 Mon, 10 May 2021 05:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210430124224.6383-1-wsj20369@163.com> <0e480ceabe4d42d79bf49a1989c0f95f@intel.com>
In-Reply-To: <0e480ceabe4d42d79bf49a1989c0f95f@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 May 2021 14:13:49 +0200
Message-ID: <CAJZ5v0i8RnOg2HgEmLze7d3rYvofVDFDQORMOigNc0vEhLW16Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "ACPI: power: Turn off unused power resources unconditionally"
To:     "Zhang, Rui" <rui.zhang@intel.com>, Shujun Wang <wsj20369@163.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 10, 2021 at 8:37 AM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> Hi, Shujun,
>
> I'm experiencing similar problem, and it should be a BIOS problem,

Right, and I confused things.  Sorry about that.

If commit 7e4fdeafa61f2b653f ("ACPI: power: Turn off unused power
resources unconditionally") causes problems to happen, this means that
the platform firmware implementation doesn't follow the ACPI
specification.

> which can be fixed by a customized DSDT.
> Can you please attach the full acpidump output on this machine? I just want to make sure if it is the same problem.

Yes, please.

Rui, can you create a BZ for this please and can you both attach
dmidecode output from the affected systems?

I don't want to revert this commit completely, so the default behavior
is spec-compliant, but there can be a DMI-based blacklist for systems
having problems with it.

> > -----Original Message-----
> > From: Shujun Wang <wsj20369@163.com>
> > Sent: Friday, April 30, 2021 8:42 PM
> > To: rjw@rjwysocki.net; lenb@kernel.org; linux-acpi@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Cc: Shujun Wang <wsj20369@163.com>
> > Subject: [PATCH] Revert "ACPI: power: Turn off unused power resources
> > unconditionally"
> >
> > This reverts commit 7e4fdeafa61f2b653fcf9678f09935e55756aed2.
> > It may cause some NVMe device probes to fail, and the system may get stuck
> > when using an NVMe device as the root filesystem.
> >
> > In the function nvme_pci_enable(struct nvme_dev *dev), as shown below,
> > readl(NVME_REG_CSTS) always returns -1 with the commit, which results in
> > the probe failed.
> >
> >   if (readl(dev->bar + NVME_REG_CSTS) == -1) {
> >       result = -ENODEV;
> >       goto disable;
> >   }
> >
> > dmesg:
> >   [    1.106280] nvme 0000:04:00.0: platform quirk: setting simple suspend
> >   [    1.109111] nvme nvme0: pci function 0000:04:00.0
> >   [    1.113066] nvme 0000:04:00.0: enabling device (0000 -> 0002)
> >   [    1.121040] nvme nvme0: Removing after probe failure status: -19
> >
> > lspci:
> >   Non-Volatile memory controller: KIOXIA Corporation Device 0001
> >
> > device uevent:
> >   DRIVER=nvme
> >   PCI_CLASS=10802
> >   PCI_ID=1E0F:0001
> >   PCI_SUBSYS_ID=1E0F:0001
> >   PCI_SLOT_NAME=0000:04:00.0
> >   MODALIAS=pci:v00001E0Fd00000001sv00001E0Fsd00000001bc01sc08i02
> >
> > This patch was tested in Lenovo Thinkpad X1.
> >
> > Signed-off-by: Shujun Wang <wsj20369@163.com>
> > ---
> >  drivers/acpi/power.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c index
> > 56102eaaa2da..8bf10abeb2e0 100644
> > --- a/drivers/acpi/power.c
> > +++ b/drivers/acpi/power.c
> > @@ -1004,9 +1004,18 @@ void
> > acpi_turn_off_unused_power_resources(void)
> >       mutex_lock(&power_resource_list_lock);
> >
> >       list_for_each_entry_reverse(resource, &acpi_power_resource_list,
> > list_node) {
> > +             int result, state;
> > +
> >               mutex_lock(&resource->resource_lock);
> >
> > -             if (!resource->ref_count) {
> > +             result = acpi_power_get_state(resource->device.handle,
> > &state);
> > +             if (result) {
> > +                     mutex_unlock(&resource->resource_lock);
> > +                     continue;
> > +             }
> > +
> > +             if (state == ACPI_POWER_RESOURCE_STATE_ON
> > +                 && !resource->ref_count) {
> >                       dev_info(&resource->device.dev, "Turning OFF\n");
> >                       __acpi_power_off(resource);
> >               }
> > --
> > 2.25.1
>
