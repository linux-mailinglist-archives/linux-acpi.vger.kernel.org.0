Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E4B43D08B
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 20:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbhJ0SUs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 14:20:48 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38562 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbhJ0SUn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 14:20:43 -0400
Received: by mail-ot1-f49.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso4862157otp.5;
        Wed, 27 Oct 2021 11:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wi1wqWtLknR9Z1R3U2RuJ5z/q7VnpnEhDqj4vPi01CM=;
        b=wBvcm3Ib0tpmxFA+B6azASuFgWzQKbBcQ1GqQ/XsTqbAG7hWcX4UmY8Qfs9I9I0uVQ
         4Y4mK/iuc62bVWTP4z5JSwdFr1NDIX/eXwWatUp0izraM2FQ6CH/wHLW1tMUUulbTUbJ
         ee3oaNOUghhG4LBktNbD/WtCkH/2o+JjcPNju7yb/1ffzUpxe246Mb9ZygNAyMWxX+1+
         3OzBOaHOIEe/qSXgd+cDrThckkuzg61RmWAEInmK33xcXcVasHURTUUO4Sk2IBBH5AWG
         FaJtFci9HBey1vyQ485wvsEw4Omsw8A4QDXALrqxl6E2d5IhwYIo6Uc7/cRKxhvhOd6U
         2rlA==
X-Gm-Message-State: AOAM532s7JbMJjsqAmsdf12Tq+ugu/DiPNTjxWvv9gP1bm9rxho/I+nr
        LMbf6PkqB3+RUNLElrw/cmi4uQ4HgI2dhtLwKtA=
X-Google-Smtp-Source: ABdhPJzezqrxkQeB36YsHtO3kRV91J7I/BVeBnpyGKPb5HJJgIvb1MFdF0Iutk9p6ODYzgp7cuOT8jt0B68JgK/2H/4=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr25532059oth.198.1635358697104;
 Wed, 27 Oct 2021 11:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <11860508.O9o76ZdvQC@kreacher> <YXhX/cTjH/H9UOnQ@smile.fi.intel.com>
 <YXmNuKIXjnhOx/Gi@smile.fi.intel.com> <YXmRgymVxl837yP0@smile.fi.intel.com>
In-Reply-To: <YXmRgymVxl837yP0@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Oct 2021 20:18:06 +0200
Message-ID: <CAJZ5v0jMeKo6HhtxL4iFjc44qae_J2C6B8qy+m8RSjL9hxLwqQ@mail.gmail.com>
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

On Wed, Oct 27, 2021 at 8:11 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 27, 2021 at 08:34:49PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 26, 2021 at 10:33:17PM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 26, 2021 at 08:51:49PM +0200, Rafael J. Wysocki wrote:
> > > > Hi All,
> > > >
> > > > There are some rules in the ACPI spec regarding which device identification
> > > > objects can be used together etc., but they are not followed by the kernel
> > > > code.
> > > >
> > > > This series modifies the code to follow the spec more closely (see patch
> > > > changelogs for details).
> > >
> > > I understand the motivation, but afraid about consequences on the OEM cheap
> > > devices that are not always follow letter of the specification.
> > >
> > > As per Intel platforms I would look into Baytrail / Cherrytrail devices for
> > > the past (I think Hans may help here a lot) and into Elkhart Lake in the
> > > present (for the letter I mostly refer to CSRT + DSDT cooperation to get
> > > GP DMA devices enumerated, so I _hope_ DSDT shouldn't have _ADR and _HID
> > > together).
> > >
> > > Hence, from the code perspective
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > From the practice I would wait for some tests. I will try to find any new
> > > information about latest firmware tables on Elkhart Lake machines.
> >
> > So, what I see in Elkhart Lake
> >
> > Case 1 - Sound Wire devices (2 times):
> >
> >     Name (_ADR, 0x40000000)  // _ADR: Address
> >     Name (_CID, Package (0x02)  // _CID: Compatible ID
> >     {
> >         "PRP00001",
> >         "PNP0A05" /* Generic Container Device */
> >     })
> >
> > Case 2 - GP DMA devices (3 times):
> >
> >     Name (_ADR, 0x001D0003)  // _ADR: Address
> >     Name (_HID, "80864BB4")  // _HID: Hardware ID
> >
> > Case 3 - Camera PMIC devices (5 x 2 (CLPn/DSCn) + 1 (PMIC) times = 11x):
> >
> >     Name (_ADR, Zero)  // _ADR: Address
> >     Name (_HID, "INT3472")  // _HID: Hardware ID
> >     Name (_CID, "INT3472")  // _CID: Compatible ID
> >
> > Case 4 - LNK devices (6 times):
> >
> >     Name (_ADR, Zero)  // _ADR: Address
> >     ...
> >
> >     Name (_UID, One)  // _UID: Unique ID
> >     Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
> >     {
> >         Return (HCID (One))
> >     }
> >
> > Case 5 - Camera sensors (2 times):
> >
> >     Name (_ADR, Zero)  // _ADR: Address
> >     Name (_HID, "INT34xx")  // _HID: Hardware ID
> >     Name (_CID, "INT34xx")  // _CID: Compatible ID
> >
> >
> > I have no idea about cameras or audio devices, but what I'm worrying about
> > is GP DMA. This kind of devices are PCI, but due to Microsoft hack, called
> > CSRT, we have to have a possibility to match DSDT with CSRT ot retrieve
> > the crucial information from the latter while being enumerated by the former.
> >
> > While it may be against the specification, there is no other way to achieve
> > that as far as I understand (without either breaking things in Linux or
> > getting yellow bang in Windows).
> >
> > Can you confirm that your change won't modify behaviour for these devices?
>
> Okay, I have looked into acpi_dma_parse_resource_group() and I don't see that
> we actually use _HID there. We definitely use _CRS. However, _HID is used in
> case when device is ACPI-enumerated (drivers/dma/dw/platform.c). Seems like
> firmware should provide this part runtime (either _HID or _ADR, but not both).

Right.

So after patch [2/2] _HID will always be used for the enumeration in
such cases which may not be what happens now - and what happens now
depends on the ordering in which the objects in question are seen
during the namespace walk.  If the DMA device is seen before the PCI
host bridge, it will be enumerated using the _HID.
