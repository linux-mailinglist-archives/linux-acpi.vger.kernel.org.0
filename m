Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18C32D0A97
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 07:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgLGGPz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 01:15:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgLGGPz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Dec 2020 01:15:55 -0500
Date:   Mon, 7 Dec 2020 08:15:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607321712;
        bh=18W2/qNjQeeSJU11G9TKV5zWfuwhmeK3qs24Pr4Dd+I=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=CU8D+A5Oi/VE2TpOVyGjdsR7cBvAyEqDlSG5XIDrYpRnEhrDjUsiOFVPCobgLcnSL
         /KeYmDb2mDIIOg5FBnhtr6RjYKOb+lqwSGHIPP9IXKM+qi5/7ZOBW5Qkxe7iWwqFbP
         ZdNiYpC2gmGb+fXySlhGocAONT56UjwRFyGb10eZZ2MPKICSZ63m+7mVZFHZ4zN6hF
         deGouFwFtn63IG+jpFE7PRORLWO+6nwBPnmujjSMI8+r/XzGpKDmb3S0TRQbZFauZ0
         XocbQGA/HktgAyG4n43osfPur1gaV5Q3cJ8yddMEcsKoQSVgDZoHPDbVfjtWTm9Q4L
         s4F8W40lBt7og==
From:   Leon Romanovsky <leon@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Add support for Microsoft Surface System
 Aggregator Module
Message-ID: <20201207061506.GE693271@unreal>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201206070705.GA686270@unreal>
 <9dd05a66-efb7-74d2-4f5b-347655b710be@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd05a66-efb7-74d2-4f5b-347655b710be@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Dec 06, 2020 at 04:58:52PM +0100, Maximilian Luz wrote:
> On 12/6/20 8:07 AM, Leon Romanovsky wrote:
> > On Thu, Dec 03, 2020 at 10:26:31PM +0100, Maximilian Luz wrote:
> > > Hello,
> > >
> > > Here is version two of the Surface System Aggregator Module (SAM/SSAM)
> > > driver series, adding initial support for the embedded controller on 5th
> > > and later generation Microsoft Surface devices. Initial support includes
> > > the ACPI interface to the controller, via which battery and thermal
> > > information is provided on some of these devices.
> > >
> > > The previous version and cover letter detailing what this series is
> > > about can be found at
> > >
> > >    https://lore.kernel.org/platform-driver-x86/20201115192143.21571-1-luzmaximilian@gmail.com/
> > >
> > > This patch-set can also be found at the following repository and
> > > reference, if you prefer to look at a kernel tree instead of these
> > > emails:
> > >
> > >    https://github.com/linux-surface/kernel tags/s/surface-aggregator/v2
> > >
> > > Thank you all for the feedback to v1, I hope I have addressed all
> > > comments.
> >
> >
> > I think that it is too far fetched to attempt and expose UAPI headers
> > for some obscure char device that we are all know won't be around in
> > a couple of years from now due to the nature of how this embedded world
> > works.
> >
> > More on that, the whole purpose of proposed interface is to debug and
> > not intended to be used by any user space code.
>
> I believe this has already been extensively discussed. I want to focus
> more on the part below in this response:
>
> > Also the idea that you are creating new bus just for this device doesn't
> > really sound right. I recommend you to take a look on auxiliary bus and
> > use it or come with very strong justifications why it is not fit yet.
>
> I tend to agree that this is a valid concern to bring up, and adding a
> new bus is not something that should be done lightly.
>
> Let's ignore that this has been merged into -next after I've submitted
> this (and that I only recently became aware of this) for the time being.
> If I would see a clear benefit, I would not hesitate to switch the
> driver and subsystem over to this.
>
> What does concern me most, is the device/driver matching by string.
> Right now, this subsystem matches those via a device UID. This UID is
> directly tied to the EC functionality provided by the device. A bit of
> background to this:
>
> Requests sent to the EC contain an address, so to say. This consists of
>
>  - Target category (TC): Broad group of functionality, e.g. battery/AC,
>    thermal, HID input, ..., i.e. a subsystem of sorts.
>
>  - Target ID (TID): Some major device, e.g. the dual batteries on the
>    Surface Book 3 are addressed by target ID 1 and 2, some functionality
>    is only available at 2 and some only at 1. May be related to physical
>    parts of/locations on the device.
>
>  - Instance ID (IID): A device instance, e.g. for thermal sensors each
>    sensor is at TC=0x03 (thermal) and has a different instance ID.
>
> Those can be used to pretty much uniquely identify a sub-device on the
> EC.
>
> Note the "pretty much". To truly make them unique we can add a function
> ID (FN). With that, we can for example match for TC=0x03, TID=*, IID=*,
> FN=0x00 to load a driver against all thermal sensors. And this is
> basically the device UID that the subsystem uses for matching (modulo
> domain for virtual devices, i.e. device hubs). Sure, we can use some
> string, but that then leads to having to come up with creative names
> once we need some driver specific data, e.g. in the battery driver [1]:
>
>     const struct auxiliary_device_id my_auxiliary_id_table[] = {
>         { .name = "surface_aggregator_registry.battery", .driver_data = x },
>         { .name = "surface_aggregator_registry.battery_sb3", .driver_data = y },
>         { },
>     }
>
> Arguably, not _that_ big of a deal.
>
> What worries me more is that this will block any path of auto-detecting
> devices on a more general/global level. Right now, we hard-code devices
> because we haven't found any way to detect them via some EC query yet
> [2] (FYI the node groups contain all devices that will eventually be
> added to the bus, which are already 11 devices on the Surface Book 3
> without taking missing thermal sensors into account; also they are
> spread across a bunch of subsystems, so not just platform). That's of
> course not an ideal solution and one that I hope we can eventually fix.
> If we can auto-detect devices, it's very likely that we know or can
> easily get to the device UID. A meaningful string is somewhat more
> difficult.
>
> This registry, which is loaded against a platform device that, from what
> we can tell differentiates the models for some driver bindings by
> Windows (that's speculation), is also the reason why we don't register
> client devices directly under the main module, so instead of a nice
> "surface_aggregator.<devicename>", you'll get
> "surface_aggregator_registry.<devicename>". And it may not end there.
>
> Something that's currently not implemented is support for thermal
> sensors on 7th generation devices. With thermal sensors, we can already
> detect which sensors, i.e. which IIDs, are present. Naturally, that's
> part of the EC-API for thermal devices (TC=0x03), so would warrant a
> master driver that registers the individual sensor drivers (that's a
> place where I'd argue that in a normal situation, the auxiliary bus
> makes sense). So with the auxiliary bus we'd now end up with devices
> with "surface_thermal.sensor" for the sensors as well as
> "surface_aggregator_registry.<devicename>", both of type ssam_device
> (which then would be a wrapper around auxiliary_device with UID stored
> in that wrapper). Note that they need to be of type ssam_device (or
> another wrapper around that) as they again need the reference to the
> controller device, their UID for access, etc. With a proper bus, device,
> and the UID for matching, we can just add the sensor devices to the bus
> again, as they will have a meaningful and guaranteed unique UID.
>
> From some reports I've seen it looks like thermal sensors may also be
> available separately on TID=0x01 as well as TID=0x02 on some devices,
> at which point I believe you'd need to introduce some IDA for ID
> allocation to not cause a clash with IDs. At least if you separate the
> base drivers for each TC, which I guess should be preferred due to
> code-reuse. Then again they might use different event registries so you
> may end up needing "surface_thermal.sensor_tc1" and
> "surface_thermal.sensor_tc2" as device names to differentiate those
> for driver loading. Or store the registry in software node properties
> when registering the device.
>
> I'm repeating myself here, but to me it looks cleaner to have a single
> bus type as opposed to spreading the same base auxiliary device type
> over several namespaces.
>
> Which then leads me to the question of how a function like
> "is_ssam_device()", i.e. a function testing if the device is of a given
> type, would be implemented without enforcing and testing against some
> part of the device name. Something that, again, doesn't look clean to
> me. Although the use of such a function could probably avoided, but that
> then feels like working around the auxiliary bus.
>
> Unfortunately, there are a couple more hypotheticals at play than I'd
> like to have (making this not an easy decision), but it's a reverse
> engineered driver so I guess that comes with the territory. All in all,
> I believe it's possible to do this (i.e. use the auxiliary bus), but, to
> me at least, the implementation using a discrete bus feels tidier and
> more true to the hardware (or virtual hardware anyway) behind this. I'm
> happy to hear any arguments against this though.

I'm not so certain why you are so focused on the names and UIDs.
The names are simply the aliases and needed to match between major
device driver that is responsible for the discovery and triggering
sub-driver with implementation.

Nothing prohibits from the logic: "if uid = 123; trigger "sensor""

Different devices and separation between them (*_registry module)
are expected to be in that main driver.

As an outcome of it, you will get: proper module autoload, device
discover and power management.

Thanks

>
> Regards,
> Max
>
> [1]: https://github.com/linux-surface/surface-aggregator-module/blob/61b9bb859c30a8e17654c3a06696feb2691438f7/module/src/clients/surface_battery.c#L1075-L1079
> [2]: https://github.com/linux-surface/surface-aggregator-module/blob/61b9bb859c30a8e17654c3a06696feb2691438f7/module/src/clients/surface_aggregator_registry.c
