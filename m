Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C0646E158
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Dec 2021 04:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhLIDtN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Dec 2021 22:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhLIDtN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Dec 2021 22:49:13 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7F3C061746
        for <linux-acpi@vger.kernel.org>; Wed,  8 Dec 2021 19:45:40 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id 8so4200738qtx.5
        for <linux-acpi@vger.kernel.org>; Wed, 08 Dec 2021 19:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qp+fhQqb63jtEJIb0aiVqToUshtJVOsAaFogxfuvcdY=;
        b=WAqRJ30t793jmukhjFhh/tffATf4sExSXMo6XdQtr/7tlbisCy0hGGjQVOfVV1KeQB
         EiioaBisTTNnkTusNB0q2JpdNCshwzogMXiRWHqttAeiyCo7yS6nb+IOurcrJRJF9ohC
         t9zAZOOjhjFhbEOQ4i/04DdYPLr9uPGnPtSj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qp+fhQqb63jtEJIb0aiVqToUshtJVOsAaFogxfuvcdY=;
        b=vGN3oPEWgq/1/F8IJ9J2GoQArjODiCGCEqPenYRVJRiazW6Eoj1TJWzo6e3s1rVyLd
         iX537Xl1JBJzD7S18pKS/t/59HiOynEejkZ7ixryoqbEC25u3Wg6gqC+yUVdrPoEVdUB
         xr+WZXYzovgzPul8HzouZScMWjUf4aebr4Ll/lNHoPmuOJ6+GeMU/Euvhdk811fuJXLp
         3wHmYHCKYPcnIM6RuJyOzdg5J2hkpS01iXITksjnMpHtmTxPjT9dX+atjsTIDC56r7Od
         +cTB6V783ksxYOW6mO9EDJqW117oxxaMi8LBAOpFpbbQaqUA/1bIYw9lMSkn1+N7SR1j
         WL4Q==
X-Gm-Message-State: AOAM530tpy+zYR4ex4MCw6TqTtmMuj2/z5rMBUsb7gX3akY2X4m+VmKT
        UXDqAx7tIeSSactonfRB9mgziXfte6qx1BYActsk8Q==
X-Google-Smtp-Source: ABdhPJx6O9m7818KPPCtox6xAOqjmZRE2jJ7uIJUczKPqaLyqP5nbELSNY9udKMJ7DAY/iW7URcRoAoIyj9GNeCC158=
X-Received: by 2002:a05:622a:120d:: with SMTP id y13mr13465739qtx.155.1639021539383;
 Wed, 08 Dec 2021 19:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20211207143757.21895-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20211207143757.21895-1-heikki.krogerus@linux.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 8 Dec 2021 19:45:26 -0800
Message-ID: <CACeCKaf3_sqGbqh22Qe+7xEcajCTZt=WziqtPuzgGxW=-TPXbg@mail.gmail.com>
Subject: Re: [PATCH 0/5] acpi: Store _PLD information and convert users
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Heikki,

On Tue, Dec 7, 2021 at 6:37 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> This removes the need for the drivers to always separately evaluate
> the _PLD. With the USB Type-C connector and USB port mapping this
> allows us to start using the component framework and remove the custom
> APIs.
>
> So far the only users of the _PLD information have been the USB
> drivers, but it seems it will be used also at least in some camera
> drivers later. These nevertheless touch mostly USB drivers.
>
> Rafael, is it still OK if Greg takes these?
>
> Prashant, can you test these?

I've applied the patches to a system with the requisite _PLD entries
in firmware, and I'm not sure I can see the connectors getting created
correctly.

My setup is:

Chromebook ------> Dell WD19TB dock (in USB+DisplayPort Alternate
Mode) ----> USB Thumb drive.

Here is the lsusb -t output before connecting the dock (omitting
unrelated busses):
localhost ~ # lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/3p, 10000M/x2

Here is the lsusb -t output (omitting unrelated busses):
localhost ~ # lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/3p, 10000M/x2
    |__ Port 2: Dev 15, If 0, Class=Hub, Driver=hub/4p, 10000M
        |__ Port 3: Dev 16, If 0, Class=Hub, Driver=hub/4p, 5000M
            |__ Port 3: Dev 18, If 0, Class=Mass Storage,
Driver=usb-storage, 5000M
        |__ Port 4: Dev 17, If 0, Class=Vendor Specific Class,
Driver=r8152, 5000M

I see the connector symlink for the root hub:

localhost ~ # cd /sys/bus/usb/devices
localhost /sys/bus/usb/devices # ls 2-2/port/connector
data_role  device  firmware_node  port1-cable  port1-partner  power
power_operation_mode  power_role  preferred_role  subsystem
supported_accessory_modes  uevent  usb2-port2  usb3-port2
usb_power_delivery_revision  usb_typec_revision  vconn_source

But for none of the children devices:

localhost /sys/bus/usb/devices # ls 2-2.3/port/connector
ls: cannot access '2-2.3/port/connector': No such file or directory
localhost /sys/bus/usb/devices # ls 2-2.3.3/port/connector
ls: cannot access '2-2.3.3/port/connector': No such file or directory
localhost /sys/bus/usb/devices # ls 2-2.3\:1.0/port/connector
ls: cannot access '2-2.3:1.0/port/connector': No such file or directory
localhost /sys/bus/usb/devices # ls 2-2.3.3\:1.0/port/connector
ls: cannot access '2-2.3.3:1.0/port/connector': No such file or directory

Is this as you intended with the series? My interpretation was that
each connected usb device would get a "connector" symlink, but I may
have misinterpreted this.

Best regards,

-Prashant
