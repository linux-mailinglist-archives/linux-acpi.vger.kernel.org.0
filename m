Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E0346F437
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Dec 2021 20:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhLITtO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Dec 2021 14:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhLITtN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Dec 2021 14:49:13 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A803C061746
        for <linux-acpi@vger.kernel.org>; Thu,  9 Dec 2021 11:45:40 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id b11so6070251qvm.7
        for <linux-acpi@vger.kernel.org>; Thu, 09 Dec 2021 11:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvpmIkayqdMprhcCUS7F0gK4w6zIHIrz7QooN+hl7RM=;
        b=W+0r42S0CsGpyHEjtoj3tMnfoP29cGlOuVGVgGkr9jnO9r5IbEuOxc86Vt06mhf4zV
         lk1ciG1S9gNJDucFoa0ZpRLTZy6qtcmN54QyZtxhvkYX5BEYC6xrq1cDJEb6Cot/FFwr
         tI3ZQXGE6FUclTi5uX1VHjRVpvW3e6Hjz4Pog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvpmIkayqdMprhcCUS7F0gK4w6zIHIrz7QooN+hl7RM=;
        b=R+irv0RAdMSsgAi0z6XIOzJVV+04+DJJlIJ50P1Z8lt9xehvIqStxKmVDuJBO7G7pr
         t27UMiShlNeViRWCltj/d96Z3GzooLQN7K4DuZZgKiunqkFLzBz9jRL8Qjek1Qk9yYhe
         xymALCXqzmrt+3M3ySb62xx5iTdFMAftIWeVxiDqlXBOSB2hTdqQtNihuCcJeA9d46Fa
         OZMfLbVtrlut8slmdxVgpEP5nhKHx4B2XyJcIsUwEiLgPkIH4DZh3o8NGMn5XRS5+Gbf
         7jdQATaaheoEAJM0Q2i2b6AZ7dQS6s+OIrpgsQ70GnI5JD+E1ObzqJYH1VPi/b0xlJWK
         3tJg==
X-Gm-Message-State: AOAM532DiAcN8lXNbn42A/CltP6dO4n1UXHDDQ5+QgK4iJb6GDY1uQtD
        E0qQA91zadPLXRumTRM8WPbbJ8XD97HoEN9gXc3zYA==
X-Google-Smtp-Source: ABdhPJzs5sjxRU8nFJVhY9SA3aqJ+0AHPiUMPWexktLZKk76goFLPsJtkDhO3YuXPjKIxWV6Y1ZwWUNO46zO2amVVTU=
X-Received: by 2002:ad4:5cef:: with SMTP id iv15mr19084182qvb.82.1639079139150;
 Thu, 09 Dec 2021 11:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20211207143757.21895-1-heikki.krogerus@linux.intel.com>
 <CACeCKaf3_sqGbqh22Qe+7xEcajCTZt=WziqtPuzgGxW=-TPXbg@mail.gmail.com> <YbHVDikM6eodP/MR@kuha.fi.intel.com>
In-Reply-To: <YbHVDikM6eodP/MR@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 9 Dec 2021 11:45:27 -0800
Message-ID: <CACeCKaeYRWxS1kPX6TvQHvn_5H_u-+MKWmdh5XQeCdZ-Wj93Hw@mail.gmail.com>
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

Hey Heikki,

On Thu, Dec 9, 2021 at 2:06 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> Thanks for testing these..
>
> On Wed, Dec 08, 2021 at 07:45:26PM -0800, Prashant Malani wrote:
> > Hi Heikki,
> >
> > On Tue, Dec 7, 2021 at 6:37 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > Hi,
> > >
> > > This removes the need for the drivers to always separately evaluate
> > > the _PLD. With the USB Type-C connector and USB port mapping this
> > > allows us to start using the component framework and remove the custom
> > > APIs.
> > >
> > > So far the only users of the _PLD information have been the USB
> > > drivers, but it seems it will be used also at least in some camera
> > > drivers later. These nevertheless touch mostly USB drivers.
> > >
> > > Rafael, is it still OK if Greg takes these?
> > >
> > > Prashant, can you test these?
> >
> > I've applied the patches to a system with the requisite _PLD entries
> > in firmware, and I'm not sure I can see the connectors getting created
> > correctly.
> >
> > My setup is:
> >
> > Chromebook ------> Dell WD19TB dock (in USB+DisplayPort Alternate
> > Mode) ----> USB Thumb drive.
> >
> > Here is the lsusb -t output before connecting the dock (omitting
> > unrelated busses):
> > localhost ~ # lsusb -t
> > /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/3p, 10000M/x2
> >
> > Here is the lsusb -t output (omitting unrelated busses):
> > localhost ~ # lsusb -t
> > /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/3p, 10000M/x2
> >     |__ Port 2: Dev 15, If 0, Class=Hub, Driver=hub/4p, 10000M
> >         |__ Port 3: Dev 16, If 0, Class=Hub, Driver=hub/4p, 5000M
> >             |__ Port 3: Dev 18, If 0, Class=Mass Storage,
> > Driver=usb-storage, 5000M
> >         |__ Port 4: Dev 17, If 0, Class=Vendor Specific Class,
> > Driver=r8152, 5000M
> >
> > I see the connector symlink for the root hub:
> >
> > localhost ~ # cd /sys/bus/usb/devices
> > localhost /sys/bus/usb/devices # ls 2-2/port/connector
> > data_role  device  firmware_node  port1-cable  port1-partner  power
> > power_operation_mode  power_role  preferred_role  subsystem
> > supported_accessory_modes  uevent  usb2-port2  usb3-port2
> > usb_power_delivery_revision  usb_typec_revision  vconn_source
> >
> > But for none of the children devices:
> >
> > localhost /sys/bus/usb/devices # ls 2-2.3/port/connector
> > ls: cannot access '2-2.3/port/connector': No such file or directory
> > localhost /sys/bus/usb/devices # ls 2-2.3.3/port/connector
> > ls: cannot access '2-2.3.3/port/connector': No such file or directory
> > localhost /sys/bus/usb/devices # ls 2-2.3\:1.0/port/connector
> > ls: cannot access '2-2.3:1.0/port/connector': No such file or directory
> > localhost /sys/bus/usb/devices # ls 2-2.3.3\:1.0/port/connector
> > ls: cannot access '2-2.3.3:1.0/port/connector': No such file or directory
> >
> > Is this as you intended with the series? My interpretation was that
> > each connected usb device would get a "connector" symlink, but I may
> > have misinterpreted this.
>
> It is as intended. The usb ports on the board will have the connector
> symlink, not the devices attached to them - the firmware is only aware
> of the connectors on the board of course. It looks like this series is
> working as it should.

Thanks for clarifying my understanding here.

>
> If you want to extend this solution so that also every device in the
> usb topology will have the link to the connector on board, then that
> should be now possible, but that is out side of the scope of this
> series. You need to propose that separately.
>
> But I must ask, why can't you just walk down the topology until you
> reach the on-board ports that will have the connector links?
>

Right, we can certainly do that; having it in each device is just
convenient. But as you said, that's the subject of another series.

You mentioned there would be a v2, so I'll add my Tested-By then.

Best regards,
