Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5543B31C179
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Feb 2021 19:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBOS0g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Feb 2021 13:26:36 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:45744 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhBOS0d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2021 13:26:33 -0500
Received: by mail-oi1-f170.google.com with SMTP id q186so4696791oig.12
        for <linux-acpi@vger.kernel.org>; Mon, 15 Feb 2021 10:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhK9Sy+sXj6zSCbmG0oRV4y2bv1YCu7KZPAcpn+xoFk=;
        b=M7o6eZeguUvG6DP7ooy7IenGqRkYBKTM8t6wsDnVXBISuM31MUpqSlZbmu8u5eqlzk
         kZp7SEau/aXXksLx1vQE6r8XahfPaHZbTuzc0Iv/zIWJBs6SqneD96SCecD46IKKYZi8
         MulgUPfE15tur8caCJKI7khIfbh4PEGM97YJHyh+ALPNid20vlZeAfVrh2lj8YU+cXLA
         sviRPeRwqE7v8KqwS53ic90nHiWxTCgKTW9X5T1tKmSoEIt74hiCapBp/GIvXBdRq2vZ
         OCiH99Dxw/pcxiwZ1hNyf39Z2qaw4kTpbueRmDQJxnBoOC1eWV2tdo0GHUxOHniY1rnV
         sR3Q==
X-Gm-Message-State: AOAM5318zHnoN7bEDPwSi4aUd4iYrZEiy3bRV/aCaAOxA0XCECRR39IJ
        QcPaFpOhA52Xd0yPI0yMiz3iYUM6qNBWRyltCzg=
X-Google-Smtp-Source: ABdhPJyA9hQoFi7GJbIYTmjKiYN6IIx9g51D1ODRp8aZOM0bQl2kWW+Zn22yYEafwY6kjs/OOqj/oxZbobWZs/eSoSw=
X-Received: by 2002:a05:6808:5cf:: with SMTP id d15mr129931oij.69.1613413552031;
 Mon, 15 Feb 2021 10:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20201226142830.48818-1-hdegoede@redhat.com> <ced43570-1e76-6f96-f9ab-83473b4adfb7@redhat.com>
In-Reply-To: <ced43570-1e76-6f96-f9ab-83473b4adfb7@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 15 Feb 2021 19:25:41 +0100
Message-ID: <CAJZ5v0g2mhrw56aAjafYAsRnOWjZTATyHyfi57ekuQyGs6O-MA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPICA: Fix a race in GenericSerialBus (I2C) and GPIO handling
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 15, 2021 at 6:52 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12/26/20 3:28 PM, Hans de Goede wrote:
> > Hi All,
> >
> > On one of my machines I noticed the following errors being logged:
> >
> > [   52.892807] i2c i2c-0: adapter quirk: no zero length (addr 0x0078, size 0, read)
> > [   52.893037] i2c i2c-0: i2c read 0 bytes from client@0x78 starting at reg 0x0 failed, error: -95
> >
> > The second line is coming from the Linux I2C ACPI OpRegion handling and
> > after a bunch of debugging I've found out that there is a rather obvious
> > (once you see it) and nasty race condition in the handling of I2C and GPIO
> > opregions in acpi_ev_address_space_dispatch(). See the first patch in this
> > series (the second patch is a follow-up cleanup patch removing some code
> > duplication).
> >
> > TBH I'm surprised that this issue has gone unnoticed as long as it has,
> > but I guess that it mostly leads to unreproducable sporadic problems
> > making it hard to debug and I got lucky that I had a machine where the
> > race seems to trigger about once every 20 seconds.
> >
> > I know that ACPICA patches are normally merged through the ACPICA upstream
> > but given that this is a serious bug, I believe that in this case it might
> > be best to add the fix directly to Linux and then port it to ACPICA from
> > there.
>
> ping ?
>
> This was submitted 2 full months ago; and despite this:
>
> 1. Fixing a serious bug in ACPICA
> 2. The fix being pretty simple (and AFAICT obviously correct)
>
> This is still awaiting review upstream:
> https://github.com/acpica/acpica/pull/658
>
> I must say that it feels to me that the upstream ACPICA process is broken here.
>
> I submitted a pull-req for this, as requested and after that there has
> been zero progress.
>
> The pull-req even has a 26 day old "this looks good to me" comment from Erik,
> followed by silence... ?
>
> Rafael, can you please consider just directly picking these 2 fixes into
> your acpi branch, so that we can get this nasty race condition fixed ?

I will do that later this week, thanks!
