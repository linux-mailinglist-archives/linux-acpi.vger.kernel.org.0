Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E462D020C
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 09:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgLFI5T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 03:57:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:50084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgLFI5T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 6 Dec 2020 03:57:19 -0500
Date:   Sun, 6 Dec 2020 10:56:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607244998;
        bh=LH+RKt1fSfmVnZq0s40gHs8KqDpkIxtCMOOy7KLFL1k=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFMYqeq/BpYg9rtXwFWcwQZnMr12OV2oUfJNF5M8sS3PyiOTq0dihhJ1ax0ZpOoGG
         jq48s8G8dP8+y7dzseb6Lc5reeib2Y1l38pPOUSroHtGOZlgsbu1RHsQQSeNXNlZmS
         q/ccmhY6yOo2M9erSi3vMwjoZxyN7+FaPA4GdINKxGOxZQMOcloK8a0MoSlmCIwEZU
         T86advb+nqhWlk+hlWlAyqDuwNktShaQxesW93a3kbkk15vyCPc5e0PYElwatBqDxT
         BMSu1nR/brpFzqrkar7BX/oRhA08GZZmxR86hHYdv1joob5HrYbVZKNbEr/tEuf/1o
         pS/Fis4lxVKvw==
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
Message-ID: <20201206085631.GE210929@unreal>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201206070705.GA686270@unreal>
 <052ecf4d-9e08-2c08-8a06-c30ba2b28d82@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <052ecf4d-9e08-2c08-8a06-c30ba2b28d82@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Dec 06, 2020 at 09:41:21AM +0100, Hans de Goede wrote:
> Hi Leon,
>
> On 12/6/20 8:07 AM, Leon Romanovsky wrote:
> > On Thu, Dec 03, 2020 at 10:26:31PM +0100, Maximilian Luz wrote:
> >> Hello,
> >>
> >> Here is version two of the Surface System Aggregator Module (SAM/SSAM)
> >> driver series, adding initial support for the embedded controller on 5th
> >> and later generation Microsoft Surface devices. Initial support includes
> >> the ACPI interface to the controller, via which battery and thermal
> >> information is provided on some of these devices.
> >>
> >> The previous version and cover letter detailing what this series is
> >> about can be found at
> >>
> >>   https://lore.kernel.org/platform-driver-x86/20201115192143.21571-1-luzmaximilian@gmail.com/
> >>
> >> This patch-set can also be found at the following repository and
> >> reference, if you prefer to look at a kernel tree instead of these
> >> emails:
> >>
> >>   https://github.com/linux-surface/kernel tags/s/surface-aggregator/v2
> >>
> >> Thank you all for the feedback to v1, I hope I have addressed all
> >> comments.
> >
> >
> > I think that it is too far fetched to attempt and expose UAPI headers
> > for some obscure char device that we are all know won't be around in
> > a couple of years from now due to the nature of how this embedded world
> > works.
>
> This is not for an embedded device, but for the popular line of
> Microsoft Surface laptops / 2-in-1s...

It is the naming, we don't have char device for every "laptop" vendor.
Why is Microsoft different here?

>
> > More on that, the whole purpose of proposed interface is to debug and
> > not intended to be used by any user space code.
>
> The purpose is to provide raw access to the Surface Serial Hub protocol,
> just like we provide raw access to USB devices and have hidraw devices.

USB devices implement standard protocol, this surface hub is nothing
even close to that.

>
> So this goes a litle beyond just debugging; and eventually the choice
> may be made to implement some functionality with userspace drivers,
> just like we do for some HID and USB devices.

I don't know how it goes in device/platform area, but in other large
subsystems, UAPI should be presented with working user-space part.

>
> Still I agree with you that adding new userspace API is something which
> needs to be considered carefully. So I will look at this closely when
> reviewing this set.
>
> > Also the idea that you are creating new bus just for this device doesn't
> > really sound right. I recommend you to take a look on auxiliary bus and
> > use it or come with very strong justifications why it is not fit yet.
>
> AFAIK the auxiliary bus is for sharing a single device between multiple
> drivers, while the main device-driver also still offers functionality
> (beyond the providing of access) itself.

The idea behind auxiliary bus is to slice various functionalities into
different sub-drivers, see it as a way to create subsystem inside one
driver.

>
> This is more akin to how the WMI driver also models different WMI
> functions as a bus + devices on the bus.
>
> Or how the SDIO driver multiplex a single SDIO device into its
> functions by again using a bus + devices on the bus model.
>
> Also this has been in the works for quite a while now, the Linux on
> Microsoft Surface devices community has been working on this out of
> tree for a long time, see:
> https://github.com/linux-surface/

It is not relevant, the code is merged than it is ready.

>
> And an RFC and a v1 have been posted a while ago, while auxiliary
> bus support is not even in the mainline kernel yet. I would agree
> with you that this should switch to auxiliary bus, despite the timing,
> if that would lead to much better code. But ATM I don't really see
> switching to auxiliary bus offering much benefits here.

The auxiliary bus is merged and part of linux-next.
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/tag/?h=auxbus-5.11-rc1

>
> > I'm sorry to say, but this series is not ready to be merged yet.
> >
> > NAK: Leon Romanovsky <leon@kernel.org>
>
> See above, I believe that this all is a bit harsh and I have not
> really heard convincing arguments for not merging this.
>
> Moreover such a quick nack does not really promote working upstream,
> where as we actually want people to work upstream as much as possible.
> I know this is not a reason for taking bad code, but I'm not
> convinced that this is bad code.

I naked explicitly for two reasons: UAPI(chardev) and lack of rationale
for the custom bus, never said "bad code".

>
> I have not reviewed this myself yet, but once I have reviewed
> this and any review remarks have been addressed I do expect to
> merge this series through the platform-drivers-x86 tree.
>
> Regards,
>
> Hans de Goede
> (drivers/platform/x86 and drivers/platform/surface subsys maintainer)
>
