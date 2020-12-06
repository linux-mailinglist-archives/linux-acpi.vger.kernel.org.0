Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0442D0408
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 12:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgLFLmm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 06:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbgLFLmk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 6 Dec 2020 06:42:40 -0500
Date:   Sun, 6 Dec 2020 13:41:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607254920;
        bh=oK2tHJvsR7FkpksxiOu5pP3zU4wD5WM5i2YAFE0jUOc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3EMXSgLaNW2HpBJow79E7MmJleXSizShtNmtAAZm0iDwAxmPwB8lWqyTj4JCsyT4
         NxQsnKFfWDUkODEXqkaGQ9hG9yVFPAFWNCXFlsyceF4UB97f8TiWhdlELpEcsYEzFB
         hAhK9lUFT0JVonyjQVnzDN4rwu+jidoDbYSr+5TISi1z/3z8Qci6BGgkFyfH4/PFnB
         EYi+ntUD/kxFbaWsGX1yGGzmXSqWR2jd/WhIQ8NWyZhba6BANR3jQ1DMb0xUoLFKUn
         6i+1bWwMH16bH0pbKSjo//95FkaqiiGpp6DAsQMlYVZDPxmLOrHRc/BGUjNv1eYou9
         P7Ck8CUTKfRUA==
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
Message-ID: <20201206114153.GD693271@unreal>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201206070705.GA686270@unreal>
 <052ecf4d-9e08-2c08-8a06-c30ba2b28d82@redhat.com>
 <20201206085631.GE210929@unreal>
 <f76b329a-b6f5-486d-b06a-452ec4c51979@redhat.com>
 <20201206103339.GB693271@unreal>
 <f2511463-3bb8-a640-7863-b206db136109@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2511463-3bb8-a640-7863-b206db136109@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Dec 06, 2020 at 11:41:46AM +0100, Hans de Goede wrote:
> Hi,
>
> On 12/6/20 11:33 AM, Leon Romanovsky wrote:
> > On Sun, Dec 06, 2020 at 11:04:06AM +0100, Hans de Goede wrote:
>
> <snip>
>
> >> But there is a difference between being careful and just nacking
> >> it because no new UAPI may be added at all (also see GKH's response).
> >
> > I saw, the author misunderstood the Greg's comments.
>
> Quoting from patch 8/9:
>
> "
> +==============================
> +User-Space EC Interface (cdev)
> +==============================
> +
> +The ``surface_aggregator_cdev`` module provides a misc-device for the SSAM
> +controller to allow for a (more or less) direct connection from user-space to
> +the SAM EC. It is intended to be used for development and debugging, and
> +therefore should not be used or relied upon in any other way. Note that this
> +module is not loaded automatically, but instead must be loaded manually.
> "
>
> If I'm not mistaken that seems to be pretty much what Greg asked for.

Right, unless you forget the end of his request.
 "
  The "joy" of creating a user api is that no matter how much you tell
  people "do not depend on this", they will, so no matter the file being
  in debugfs, or a misc device, you might be stuck with it for forever,
  sorry.
 "

So I still think that exposing user api for a development and debug of device
that has no future is wrong thing to do.

Thanks

>
> Regards,
>
> Hans
>
