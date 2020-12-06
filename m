Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E295E2D02D7
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 11:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgLFKe1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 05:34:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgLFKe1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 6 Dec 2020 05:34:27 -0500
Date:   Sun, 6 Dec 2020 12:33:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607250825;
        bh=FFP6fQBmDCHm8swKoWnJVTxbDk9GrPHUWUpo9tW5yY0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ekmrj4KTjNC1cgofE0oq5OF0cOcTyXji6tWvq7WBdjH8hxRcasbbJPoF0emiydafR
         zYtiK9R/KI1pj6KdZjei7X4VncEwZTkF0Vb3A6pms8fveA/XlYAMm28d+FxQQitnJl
         gJ79AHy3i7JfE4SP2q56oYBQvDTzMfJmznQQUp70xO8XV9NPy0X8DDm09apDp6E9sE
         94K207uVjdFifSOWFV7dNouJeKHBcd6uA0jSUnRKYBpCzdK6R5TKv3KariwC5J2Xfy
         J87Pfu2p8EFtaNxTyc2mtzb46IJp11o3tbE8x51kHJCox8excX9K/YMY24xYPlXTvl
         DNjPW7wmCDhRw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20201206103339.GB693271@unreal>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201206070705.GA686270@unreal>
 <052ecf4d-9e08-2c08-8a06-c30ba2b28d82@redhat.com>
 <20201206085631.GE210929@unreal>
 <f76b329a-b6f5-486d-b06a-452ec4c51979@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f76b329a-b6f5-486d-b06a-452ec4c51979@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Dec 06, 2020 at 11:04:06AM +0100, Hans de Goede wrote:
> Hi,
>
> On 12/6/20 9:56 AM, Leon Romanovsky wrote:
> > On Sun, Dec 06, 2020 at 09:41:21AM +0100, Hans de Goede wrote:
> >> Hi Leon,
> >>
> >> On 12/6/20 8:07 AM, Leon Romanovsky wrote:
> >>> On Thu, Dec 03, 2020 at 10:26:31PM +0100, Maximilian Luz wrote:
> >>>> Hello,
> >>>>
> >>>> Here is version two of the Surface System Aggregator Module (SAM/SSAM)
> >>>> driver series, adding initial support for the embedded controller on 5th
> >>>> and later generation Microsoft Surface devices. Initial support includes
> >>>> the ACPI interface to the controller, via which battery and thermal
> >>>> information is provided on some of these devices.
> >>>>
> >>>> The previous version and cover letter detailing what this series is
> >>>> about can be found at
> >>>>
> >>>>   https://lore.kernel.org/platform-driver-x86/20201115192143.21571-1-luzmaximilian@gmail.com/
> >>>>
> >>>> This patch-set can also be found at the following repository and
> >>>> reference, if you prefer to look at a kernel tree instead of these
> >>>> emails:
> >>>>
> >>>>   https://github.com/linux-surface/kernel tags/s/surface-aggregator/v2
> >>>>
> >>>> Thank you all for the feedback to v1, I hope I have addressed all
> >>>> comments.
> >>>
> >>>
> >>> I think that it is too far fetched to attempt and expose UAPI headers
> >>> for some obscure char device that we are all know won't be around in
> >>> a couple of years from now due to the nature of how this embedded world
> >>> works.
> >>
> >> This is not for an embedded device, but for the popular line of
> >> Microsoft Surface laptops / 2-in-1s...
> >
> > It is the naming, we don't have char device for every "laptop" vendor.
> > Why is Microsoft different here?
>
> Because their hardware department has invented a whole new way of dealing
> with a bunch of things at the hardware level (for some reason).

They are not different from any other vendor, it is much cheaper and easier
to do not follow standard implementations.

>
> Also almost all laptop vendors have a whole bunch of laptop vendor
> specific userspace API in the form of sysfs files exported by
> drivers/platform/x86/laptop-vendor.c drivers. E.g. do:
>
> ls /sys/bus/platform/devices/thinkpad_acpi/

It is different from the proposed /dev/surface... char device.

>
> An any IBM/Lenovo Thinkpad (and only on a Thinkpad) to see a bunch
> of laptop vendor specific UAPI.

Yes, it is gross, IBM did it in early days of Linux. Other vendors don't
have anything like that.

>
> Since I've become the pdx86 subsys maintainer I've actually been
> pushing back against adding more of this, instead trying to
> either use existing UAPIs, or defining new common UAPIs which can
> be shared between vendors.
>
> So I agree very much with you that we need to be careful about
> needlessly introducing new UAPI.
>
> But there is a difference between being careful and just nacking
> it because no new UAPI may be added at all (also see GKH's response).

I saw, the author misunderstood the Greg's comments.

>
> >>> More on that, the whole purpose of proposed interface is to debug and
> >>> not intended to be used by any user space code.
> >>
> >> The purpose is to provide raw access to the Surface Serial Hub protocol,
> >> just like we provide raw access to USB devices and have hidraw devices.
> >
> > USB devices implement standard protocol, this surface hub is nothing
> > even close to that.
>
> The USB protocol just defines a transport layer, outside of the USB classes
> there are plenty of proprietary protocols on top of that transport.
>
> And this chardev just offers access to the Surface Serial Hub transport
> protocol. And if you want something even closer the i2cdev module offers
> raw I2C transfer access and I2C defines no protocol other then
> how to read or write a number of bytes.
>
> I do a lot of hw enablement work and being able to poke HID / USB / I2C
> devices directly from userspace is very useful for this.

Greg wrote how to do it.

>
> >> So this goes a litle beyond just debugging; and eventually the choice
> >> may be made to implement some functionality with userspace drivers,
> >> just like we do for some HID and USB devices.
> >
> > I don't know how it goes in device/platform area, but in other large
> > subsystems, UAPI should be presented with working user-space part.
> >
> >>
> >> Still I agree with you that adding new userspace API is something which
> >> needs to be considered carefully. So I will look at this closely when
> >> reviewing this set.
>
> So this ^^^ still stands, I agree with you that adding new UAPI needs
> to be considered carefully and when I get around to reviewing this
> that is exactly what I will do.
>
> Maximilian, can you perhaps explain a bit more of what you want / expect
> to use the chardev for, and maybe provide pointers to the matching
> userspace utilities (which I presume you have) ?
>
> >>> Also the idea that you are creating new bus just for this device doesn't
> >>> really sound right. I recommend you to take a look on auxiliary bus and
> >>> use it or come with very strong justifications why it is not fit yet.
> >>
> >> AFAIK the auxiliary bus is for sharing a single device between multiple
> >> drivers, while the main device-driver also still offers functionality
> >> (beyond the providing of access) itself.
> >
> > The idea behind auxiliary bus is to slice various functionalities into
> > different sub-drivers, see it as a way to create subsystem inside one
> > driver.
>
> AFAIK the idea is to be able to combine multiple physical devices, e.g.
> a PCI device + an ACPI enumerated platform device and then slice the
> combination of those 2 up in new devices which may use parts of both
> parent devices, quoting from:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/tree/Documentation/driver-api/auxiliary_bus.rst?h=driver-core-next&id=7de3697e9cbd4bd3d62bafa249d57990e1b8f294
>
> "multiple devices might implement a common intersection of functionality"

It is one way, another is to take one device and create many small
devices out of it.
https://lore.kernel.org/alsa-devel/20201026111849.1035786-1-leon@kernel.org/

>
> IOW this is for cases where the simpler bus + devices model does not
> work well. AFAICT in this case the simpler bus + devices does work
> well, so there is no need to use the auxiliary bus.

It is designed to replace invention of custom buses.

>
> >> This is more akin to how the WMI driver also models different WMI
> >> functions as a bus + devices on the bus.
> >>
> >> Or how the SDIO driver multiplex a single SDIO device into its
> >> functions by again using a bus + devices on the bus model.
> >>
> >> Also this has been in the works for quite a while now, the Linux on
> >> Microsoft Surface devices community has been working on this out of
> >> tree for a long time, see:
> >> https://github.com/linux-surface/
> >
> > It is not relevant, the code is merged than it is ready.
>
> It is relevant, you cannot expect drivers which were written during
> the last 6 months to use functionality which is not even in the
> mainline kernel yet (yes it is in -next, but not in mainline).
>
> Now if that new functionality where to provide major benefits to
> the code making it much cleaner / better then yes asking to rewrite
> it to use that new functionality would make sense.

And who will rewrite it? My experience shows that right code should be
written from the beginning otherwise the code has too many chances to be
abandoned.

Thanks
