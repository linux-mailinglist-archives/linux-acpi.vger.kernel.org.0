Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484552D0CBA
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 10:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgLGJMG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 04:12:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgLGJMG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Dec 2020 04:12:06 -0500
Date:   Mon, 7 Dec 2020 10:12:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607332289;
        bh=pVcQnzFdOBdk2G2zSGbi6yAHzkwoQI7eBtrtT4e8Gk8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=tocgW9/ZyJWYiEYa4KssrRl5HhEvRADojlLiDNxdpZFIBoEFdowIeJ34n671JFHA3
         fSB+Em92Tm4ThDbPeYos1NroDMEoxpzHGtvPqdHt7tqav59vBUKFFLRKTm9W/dX1d5
         O9+qIzi4fMSld3PcefFR0YpVuw8EGUNwREUa6pnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <X83yB9/RbosOIdbm@kroah.com>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201206070705.GA686270@unreal>
 <9dd05a66-efb7-74d2-4f5b-347655b710be@gmail.com>
 <aecfdbf2-32bf-1ee5-fe72-0c0923773507@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aecfdbf2-32bf-1ee5-fe72-0c0923773507@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 07, 2020 at 09:49:03AM +0100, Hans de Goede wrote:
> Note if in the future you do see benefit in switching the auxiliary bus
> I have no problems with that. But atm I don't really see any benefits of
> doing so, so then we would just be switching over for the sake of switching
> over which does not seem productive.

I too do not see the benefit at this time to switch either.

thanks,

greg k-h
