Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B462D01E8
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 09:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgLFIdQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 03:33:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgLFIdP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 6 Dec 2020 03:33:15 -0500
Date:   Sun, 6 Dec 2020 09:32:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607243554;
        bh=GXJm5wXx19bdayV5tehHD37cgj11o0PkdMCfpnOysQc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=18PEp3AoTxKv4zeBeNwAVAm8B8FcItzu5/UENCO2jU1XDxr3xLjaSpLmHK7/boFQT
         Ja2JG5F14ro4HpBYVmiXBU3K2OCCvj2Kg+pGsDDm1nlVChJuISF+S/Eb6XGPZJySe9
         RHpRqbxDc3grZg4ofl3VoJxIOokXuwpUqyhcgLUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
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
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Add support for Microsoft Surface System
 Aggregator Module
Message-ID: <X8yXHvWcBFGu1PIo@kroah.com>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201206070705.GA686270@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206070705.GA686270@unreal>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Dec 06, 2020 at 09:07:05AM +0200, Leon Romanovsky wrote:
> On Thu, Dec 03, 2020 at 10:26:31PM +0100, Maximilian Luz wrote:
> > Hello,
> >
> > Here is version two of the Surface System Aggregator Module (SAM/SSAM)
> > driver series, adding initial support for the embedded controller on 5th
> > and later generation Microsoft Surface devices. Initial support includes
> > the ACPI interface to the controller, via which battery and thermal
> > information is provided on some of these devices.
> >
> > The previous version and cover letter detailing what this series is
> > about can be found at
> >
> >   https://lore.kernel.org/platform-driver-x86/20201115192143.21571-1-luzmaximilian@gmail.com/
> >
> > This patch-set can also be found at the following repository and
> > reference, if you prefer to look at a kernel tree instead of these
> > emails:
> >
> >   https://github.com/linux-surface/kernel tags/s/surface-aggregator/v2
> >
> > Thank you all for the feedback to v1, I hope I have addressed all
> > comments.
> 
> 
> I think that it is too far fetched to attempt and expose UAPI headers
> for some obscure char device that we are all know won't be around in
> a couple of years from now due to the nature of how this embedded world
> works.

No, that's not ok, we do this for loads of devices out there.  If there
is a device that wants to be supported for Linux, and a developer that
wants to support it, we will take it.

> More on that, the whole purpose of proposed interface is to debug and
> not intended to be used by any user space code.

I thought that debugfs was going to be used for most of the debugging
code, or has that changed in newer versions of this patchset?

thanks,

greg k-h
