Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91612D0221
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 10:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgLFJHC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 04:07:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgLFJHC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 6 Dec 2020 04:07:02 -0500
Date:   Sun, 6 Dec 2020 11:06:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607245581;
        bh=s+w0DJiO0lLkfTm14BP/G28WyCllLXEdBVKQ6c423Ag=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=gagO/krH5WjoJg2V+3NWtbbaWM9kYMbV6eKBL2Ee/hDqf7FozNpVol+hrpDbIrtzB
         4/F5hCSHkP7ZCztYSosF/OFCNjQ8oUE1NR5roXgLNT/yx7h/iAoBYWUxXCB1/zr7EK
         eZ5Zy13XqlwZop+t0NGSqQwlAcBb68iNRQgLcAn8Y2fIVgXOHC6cQxAoLlQaft8hrT
         yuZDmYadfJGWBNMYXpGRffTk+vGVMaG+bYk/GxtDiSljdpNyjry2rDM9v85xszhavW
         QsZz1nQYp3O2Y3htOOOXGHGcSeT5O3fnmHTDf6KOV/G3/UfK9NfoUPsIElNKcruTMR
         46FyyPilulOEg==
From:   Leon Romanovsky <leon@kernel.org>
To:     =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
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
Message-ID: <20201206090614.GA693271@unreal>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201206070705.GA686270@unreal>
 <052ecf4d-9e08-2c08-8a06-c30ba2b28d82@redhat.com>
 <1b4fe1fd-592d-4a88-b156-fbf6af2df428@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b4fe1fd-592d-4a88-b156-fbf6af2df428@www.fastmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Dec 06, 2020 at 05:58:32PM +0900, Blaž Hrastnik wrote:
> >
> > > More on that, the whole purpose of proposed interface is to debug and
> > > not intended to be used by any user space code.
> >
> > The purpose is to provide raw access to the Surface Serial Hub protocol,
> > just like we provide raw access to USB devices and have hidraw devices.
> >
> > So this goes a litle beyond just debugging; and eventually the choice
> > may be made to implement some functionality with userspace drivers,
> > just like we do for some HID and USB devices.
> >
> > Still I agree with you that adding new userspace API is something which
> > needs to be considered carefully. So I will look at this closely when
> > reviewing this set.
>
> To add to that: this was previously a debugfs interface but was moved to misc after review on the initial RFC:
> https://lkml.org/lkml/2020/9/24/96

There is a huge difference between the suggestion and final implementation.

Greg suggested to add new debug module to the drivers/misc that will
open char device explicitly after user loaded that module to debug this
hub. However, the author added full blown char device as a first citizen
that has all not-break-user constrains.

Thanks

