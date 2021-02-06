Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280E1312012
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Feb 2021 21:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhBFUs1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 6 Feb 2021 15:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhBFUsZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Feb 2021 15:48:25 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73007C061756
        for <linux-acpi@vger.kernel.org>; Sat,  6 Feb 2021 12:47:45 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id i6so10510135ybq.5
        for <linux-acpi@vger.kernel.org>; Sat, 06 Feb 2021 12:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+hjAXsPVbgElgRdj+BZ+6MVnNMTVzcYGHrvtwU1AcCs=;
        b=PivZDf7vbfBH6bSgHRaWMYMP8xN20P+lGSInQZfjmRrebl4zG19XOD81h4xHPsxfvN
         rrEa3VG5KM++VddLx0G0hTtcKmO3HR5nuYYQszPGx7j17MOYIXpprrMbnqMjHCQ16gnh
         vAAp8M7sh5ngMRXLEvCnpR0SE2eLb/b831luTAfpCMUIl/+mJcASqjF/vSQElaBpCa5G
         ILxRh/y64IoVeO+zKE/zafs6iW5iGJpNWNeiVO4o5xdYwVvhVcqNHRaL4XC6XStW1r/E
         jU8CFfUhqfItkbmKMgW8wP9A8yilwS0e3PFFDVjJn3PIqvllgunktYiSTLq9+arpDImJ
         yCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+hjAXsPVbgElgRdj+BZ+6MVnNMTVzcYGHrvtwU1AcCs=;
        b=V7ZGIpLVsqxQj7xd7mOokP0Ub1sdC5nIM8dqO0VTq4aFFGwa7D+QHDRlV1cUm7B00b
         8qbL6dK5hvIXh1EjRnV6rcZJbR+xPLuV/mQiyUJ8giPztYEUpPsrScNVV3nKYeQu07hK
         e5IXTj4nE5eMkfNam62uBK3akePbnrTwzw9za9rj2l75vrVPkfO32SgErYocj2ImBbDq
         hF0b9xVr238dNeqY1CPk4suZPgFPMC9zYeL8bf0/La6vikulEPXkT622FqcctDBtwSp5
         47vXUfvjuN9e4p2GHH93ULHA53rv9V+2CEm5C5e6297TPq+GYusNykbozqSKmjLK+WkM
         Et9Q==
X-Gm-Message-State: AOAM5323Vj8aYaqOtFQo4YWvPWlOW6+9Gg3htL91ille0/aI8a1iiJaz
        /JI3+B2E6bNHvbCUpnV0sFu+PK3IQkVhFMkVlIk4AA==
X-Google-Smtp-Source: ABdhPJyL0NcBX/RigrI99Osm8m1ZvOqxCkoIvfHxGEI93KNtJj0ymk4vExKY8KweKVKWPIOdql7mDcRKQHJIMzVuTpU=
X-Received: by 2002:a25:b74c:: with SMTP id e12mr16000102ybm.20.1612644464464;
 Sat, 06 Feb 2021 12:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com> <CAMuHMdXo+ShM3Ct2OSCscJwaLJ4rbytpA14=dR5q+3F9kJjNfw@mail.gmail.com>
In-Reply-To: <CAMuHMdXo+ShM3Ct2OSCscJwaLJ4rbytpA14=dR5q+3F9kJjNfw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 6 Feb 2021 12:47:08 -0800
Message-ID: <CAGETcx9j8YzcJa6-s4cuyTpwFsUAAaBD6H9mf1wfzafb_x+5tg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Make fw_devlink=on more forgiving
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Feb 6, 2021 at 11:41 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Fri, Feb 5, 2021 at 11:26 PM Saravana Kannan <saravanak@google.com> wrote:
> > There are a lot of devices/drivers where they never have a struct device
> > created for them or the driver initializes the hardware without ever
> > binding to the struct device.
> >
> > This series is intended to avoid any boot regressions due to such
> > devices/drivers when fw_devlink=on and also address the handling of
> > optional suppliers.
>
> Thanks for your series!
>
> > Patch 5 sets up a generic API to handle drivers that never bind with
> > their devices.
> >
> > Patch 6 through 8 update different frameworks to use the new API.
>
> >   driver core: fw_devlink: Handle suppliers that don't use driver core
> >   irqdomain: Mark fwnodes when their irqdomain is added/removed
> >   PM: domains: Mark fwnodes when their powerdomain is added/removed
> >   clk: Mark fwnodes when their clock provider is added/removed
>
> I take it this is an automatic alternative for letting drivers set the
> OF_POPULATED flag manually?

The frameworks can still continue setting it to avoid creating dead
"struct devices" that'll never be used. This new flag handles cases
where the device is already created, but will never bind to a driver.
So, they are meant to do slightly different things, but the end result
is removing the need for individual drivers to set OF_POPULATED (and
Rob hates that too).

> Is this actually safe?  It's not uncommon for a driver to register
> multiple providers, sometimes even of different types (clock, genpd,
> irq, reset[1], ...).

This flag is just an indication that the fwnode has been initialized
by a driver. It's okay if the flag gets set multiple times when a
driver is registering with multiple frameworks. It's also okay if the
flag is cleared multiple times as the driver is uninitializing the
hardware (although, this is very unlikely for drivers that don't use
device-driver model). When we actually try to create device links, we
just check if this happened without a driver actually binding to this
device. There's no "probing" race because the "status" I check goes
through NO_DRIVER -> PROBING -(registering happens)-> BOUND ->
UNBINDING -(deregistering happens) -> NO_DRIVER. So if the fwnode flag
is getting set as part of the driver's probe function, the "status"
value will never be NO_DRIVER.

> Can you be sure consumer drivers do not start probing while their
> dependency is still busy registering providers?

The code only acts on that flag when trying to create device links
from the consumer to the supplier. This is just a way to tell "hey,
don't bother creating a device link, this supplier will never bind".
So it just avoids blocking the consumer. Doesn't really make the
consumers probe earlier than they would have.

> [1] Which brings my attention to the fact that devlink does not consider
>     "resets" properties yet.
>

Yeah, we can add that and other bindings as we go.

-Saravana
