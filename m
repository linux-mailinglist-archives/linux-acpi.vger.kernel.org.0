Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE12D015D
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 08:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgLFHHu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 02:07:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgLFHHu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 6 Dec 2020 02:07:50 -0500
Date:   Sun, 6 Dec 2020 09:07:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607238429;
        bh=frMp0i5OpTH7HSUYeC01Dasv3H7b3wML3u9DwCjWj3w=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=bwMT/cW+KW6zqLO3YOCneaKPvDm56TNcQtB9kMsKrNH49p2tA6QkEpdod8LjgHEOM
         GQBH/7BUBG4rL1nhbt0fTApg/ZBaPO7DZsXGJAsxCYTL7edTnEF7a65AbM3brxKGtH
         G/wXtdHhkarYMJhplyFCDFQ77HQ50w7UeZNzDQKRu6xeB0/wC/XS+DLkWIm5eM8EMo
         hXpaydi6gFWNL4q+I2rHsAwJWXnfycJXP4Dxfps6VB8+a/LDC7noWfknLcWqiMbfxg
         /4KhkQUFjmQKoI5kMiCdUpZptE+HrWC+pLgwnVL+zADX4WvRXHfBpeliVI7fQiTX+1
         kSJ7PskK8V6rA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
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
Message-ID: <20201206070705.GA686270@unreal>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203212640.663931-1-luzmaximilian@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 03, 2020 at 10:26:31PM +0100, Maximilian Luz wrote:
> Hello,
>
> Here is version two of the Surface System Aggregator Module (SAM/SSAM)
> driver series, adding initial support for the embedded controller on 5th
> and later generation Microsoft Surface devices. Initial support includes
> the ACPI interface to the controller, via which battery and thermal
> information is provided on some of these devices.
>
> The previous version and cover letter detailing what this series is
> about can be found at
>
>   https://lore.kernel.org/platform-driver-x86/20201115192143.21571-1-luzmaximilian@gmail.com/
>
> This patch-set can also be found at the following repository and
> reference, if you prefer to look at a kernel tree instead of these
> emails:
>
>   https://github.com/linux-surface/kernel tags/s/surface-aggregator/v2
>
> Thank you all for the feedback to v1, I hope I have addressed all
> comments.


I think that it is too far fetched to attempt and expose UAPI headers
for some obscure char device that we are all know won't be around in
a couple of years from now due to the nature of how this embedded world
works.

More on that, the whole purpose of proposed interface is to debug and
not intended to be used by any user space code.

Also the idea that you are creating new bus just for this device doesn't
really sound right. I recommend you to take a look on auxiliary bus and
use it or come with very strong justifications why it is not fit yet.

I'm sorry to say, but this series is not ready to be merged yet.

NAK: Leon Romanovsky <leon@kernel.org>

Thanks
