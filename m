Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27B343D060
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbhJ0SO6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 14:14:58 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:46789 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhJ0SO5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 14:14:57 -0400
Received: by mail-oo1-f43.google.com with SMTP id d144-20020a4a5296000000b002b6cf3f9aceso1201164oob.13;
        Wed, 27 Oct 2021 11:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjEQ77XSghrAblLCs5DCFzh+Qp3AEG6d63rVimhWv+U=;
        b=XQ5mKviQlz98y+2c/CC3cDJBA+Q+KhcXKFfh64ZItQx42tTIzqAtudfD/FQA9Y0aHZ
         yc5U1vE3VAqDEFBI4h3RIcQSroYLTcU2t/r9qw/XbiOn0TdFgYC+R5RKgFZDBIy1CE+G
         CmoqW9i2U7+QGY29tM148nx52Oo1jcLvXEXqbnxyCrFdLFCtLbAaw6O+wtJxYJljRVEy
         wGzJIAry6a+LXox+6Cl7ZaqF539P94Tbsqw41UcN4BzcTnwpbjx0GBvo66VH3I5xwtg9
         GrEwLcjabbJ7s6X2uPKznFd2DM3w2+JmlftblLk+QZV7PBWqHfNRp4+jhxIE5Qwt/Myb
         BMWg==
X-Gm-Message-State: AOAM531QBidmfjC+8G6hTkdcDlRzTkyLjSkPuTvhXLRDyvI/g0ETnavC
        AiZ6N1Umf1tVFDxtcuiJL+M58u1nrchlqB4xl/c=
X-Google-Smtp-Source: ABdhPJyEd9vjtOEh2yNcn9EI/SyMHVF7Bonc4ZK8vfYutoTOiZRAx1InIWfS4mAszqZP85+Q0RVxG89PzCN7Noy66Js=
X-Received: by 2002:a4a:e544:: with SMTP id s4mr23513695oot.0.1635358351635;
 Wed, 27 Oct 2021 11:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <11860508.O9o76ZdvQC@kreacher> <YXhX/cTjH/H9UOnQ@smile.fi.intel.com>
 <YXmNuKIXjnhOx/Gi@smile.fi.intel.com>
In-Reply-To: <YXmNuKIXjnhOx/Gi@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Oct 2021 20:12:20 +0200
Message-ID: <CAJZ5v0hwA0sEUafiTUQL_BaKnxdiBD_ASMh_5MkWT_pjr6f1zA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] ACPI: scan: Honor certain device identification rules
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 27, 2021 at 7:35 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 26, 2021 at 10:33:17PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 26, 2021 at 08:51:49PM +0200, Rafael J. Wysocki wrote:
> > > Hi All,
> > >
> > > There are some rules in the ACPI spec regarding which device identification
> > > objects can be used together etc., but they are not followed by the kernel
> > > code.
> > >
> > > This series modifies the code to follow the spec more closely (see patch
> > > changelogs for details).
> >
> > I understand the motivation, but afraid about consequences on the OEM cheap
> > devices that are not always follow letter of the specification.
> >
> > As per Intel platforms I would look into Baytrail / Cherrytrail devices for
> > the past (I think Hans may help here a lot) and into Elkhart Lake in the
> > present (for the letter I mostly refer to CSRT + DSDT cooperation to get
> > GP DMA devices enumerated, so I _hope_ DSDT shouldn't have _ADR and _HID
> > together).
> >
> > Hence, from the code perspective
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > From the practice I would wait for some tests. I will try to find any new
> > information about latest firmware tables on Elkhart Lake machines.
>
> So, what I see in Elkhart Lake
>
> Case 1 - Sound Wire devices (2 times):
>
>     Name (_ADR, 0x40000000)  // _ADR: Address

No _HID, so the IDs returned by the _CID below won't be used.

>     Name (_CID, Package (0x02)  // _CID: Compatible ID
>     {
>         "PRP00001",

The above device ID is invalid (one 0 too many).

>         "PNP0A05" /* Generic Container Device */

Without the change this causes a container device to be created, but
the only purpose of it may be offline/online (if the child devices
support offline/online).

This change should not be functionally relevant.

>     })
>
> Case 2 - GP DMA devices (3 times):
>
>     Name (_ADR, 0x001D0003)  // _ADR: Address

_ADR will be ignored which may not be expected.  Is this a PCI device?

>     Name (_HID, "80864BB4")  // _HID: Hardware ID
>
> Case 3 - Camera PMIC devices (5 x 2 (CLPn/DSCn) + 1 (PMIC) times = 11x):
>
>     Name (_ADR, Zero)  // _ADR: Address

_ADR will be ignored, which shouldn't matter.

>     Name (_HID, "INT3472")  // _HID: Hardware ID
>     Name (_CID, "INT3472")  // _CID: Compatible ID
>
> Case 4 - LNK devices (6 times):
>
>     Name (_ADR, Zero)  // _ADR: Address

Same here.

>     ...
>
>     Name (_UID, One)  // _UID: Unique ID
>     Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
>     {
>         Return (HCID (One))
>     }
>
> Case 5 - Camera sensors (2 times):
>
>     Name (_ADR, Zero)  // _ADR: Address

And same here.

>     Name (_HID, "INT34xx")  // _HID: Hardware ID
>     Name (_CID, "INT34xx")  // _CID: Compatible ID
>
>
> I have no idea about cameras or audio devices, but what I'm worrying about
> is GP DMA. This kind of devices are PCI, but due to Microsoft hack, called
> CSRT, we have to have a possibility to match DSDT with CSRT ot retrieve
> the crucial information from the latter while being enumerated by the former.
>
> While it may be against the specification, there is no other way to achieve
> that as far as I understand (without either breaking things in Linux or
> getting yellow bang in Windows).

I'm not really sure why _HID is needed for this.  The PCI device ID
could be used for CRST matching just fine.

> Can you confirm that your change won't modify behaviour for these devices?

Well, the GP DMA thing may be broken by patch [2/2], but does Windows
actually use _ADR if _HID is provided?
