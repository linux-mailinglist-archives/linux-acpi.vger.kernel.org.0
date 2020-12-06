Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B5D2D0369
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 12:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgLFLbf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 06:31:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgLFLbf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 6 Dec 2020 06:31:35 -0500
Date:   Sun, 6 Dec 2020 13:30:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607254254;
        bh=s26aMf/IzsNVnCl+Dlv5oON6qFup41GchrFyzstf/94=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYnEahwGedCanw2qAYGHnwDLaBfgNY8QHJO4Nw1+NFSb+rE7BQ/psD1ebgsl6+QL/
         yqC3lhTUkHlydeTjrpohnMLVl58HjSuJ2v+K5/yaS6d3ewZVlO8m0/dBy+HSbokeq8
         vgKDYikLNxs7X/rfPKhN9gWkCErJwxfpcNKyxq0JtqAQu+WFOQfji4gY7RteeinUPn
         scqrzKx/HbtQI/dclsMRRcMl96hIKmyIIvvUkps2RBkcGCO9+2CmStzeYxZDn0oEf6
         D04EDx56jBdAjtKKAiGThSW24HkCaghhPXb9ODYDAv6vIn99mjIGtYlK7qVnc9DXwO
         r/fo510FRqzCw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
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
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Add support for Microsoft Surface System
 Aggregator Module
Message-ID: <20201206113047.GC693271@unreal>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201206070705.GA686270@unreal>
 <052ecf4d-9e08-2c08-8a06-c30ba2b28d82@redhat.com>
 <1b4fe1fd-592d-4a88-b156-fbf6af2df428@www.fastmail.com>
 <20201206090614.GA693271@unreal>
 <a1db4b23-8159-924a-a99b-2fa4b0eb6fff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1db4b23-8159-924a-a99b-2fa4b0eb6fff@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Dec 06, 2020 at 11:33:40AM +0100, Maximilian Luz wrote:
> On 12/6/20 10:06 AM, Leon Romanovsky wrote:> On Sun, Dec 06, 2020 at 05:58:32PM +0900, Blaž Hrastnik wrote:
> > > >
> > > > > More on that, the whole purpose of proposed interface is to debug and
> > > > > not intended to be used by any user space code.
> > > >
> > > > The purpose is to provide raw access to the Surface Serial Hub protocol,
> > > > just like we provide raw access to USB devices and have hidraw devices.
> > > >
> > > > So this goes a litle beyond just debugging; and eventually the choice
> > > > may be made to implement some functionality with userspace drivers,
> > > > just like we do for some HID and USB devices.
> > > >
> > > > Still I agree with you that adding new userspace API is something which
> > > > needs to be considered carefully. So I will look at this closely when
> > > > reviewing this set.
> > >
> > > To add to that: this was previously a debugfs interface but was moved to misc after review on the initial RFC:
> > > https://lkml.org/lkml/2020/9/24/96
> >
> > There is a huge difference between the suggestion and final implementation.
> >
> > Greg suggested to add new debug module to the drivers/misc that will
> > open char device explicitly after user loaded that module to debug this
> > hub. However, the author added full blown char device as a first citizen
> > that has all not-break-user constrains.
>
> This module still needs to be loaded explicitly. And (I might be wrong
> about this) the "not-break-user constraints" hold as soon as I register
> a misc device at all, no?

I don't think so, files in drivers/misc/* don't have such strict policy.

> than previously discussed with Greg and b) how the uapi header now
> introduces any not-break-user constraints that would not be there
> without it.

There is a huge difference between char device for the debug and
exposed UAPI header. The first requires from the user to build and
explicitly run it, while header allows to reliably build on top of
it various applications that we don't control. The not-break-rule
talks about the second.

>
> This interface is intended as a stable interface. That's something that
> I committed to as soon as I decided to implement this via a misc-device.
>
> Sure, I can move the definitions in the uapi header to the module
> itself, but I don't see any benefit in that. If someone really wants to
> use this interface, they can just as well copy the definitions from the
> module source itself. So why not be upfront about it and make life
> easier for everyone?

Because you are actually making life harder for everyone who cares about
UAPIs exposed by the Linux and they definitely different in numbers from
those who needs debug interface for the Microsoft Surface board.

Thanks

>
> Regards,
> Max
>
