Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC872C1189
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 18:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390256AbgKWRGn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 12:06:43 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42018 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390255AbgKWRGn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 12:06:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id v202so17259212oia.9;
        Mon, 23 Nov 2020 09:06:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GhE+Hz/C6Yq6EYF+ALvxBcrI6I6TtR28uFh3arzp6A=;
        b=WJH2v9X65/xqkdf31BaKDWJIodDzghwzxR23ezWUPKUNl3RGWk2BIEJs98MxlQiCbC
         BIOAtPrxvp9JNpOTmqqeXAyDRAAScTA0EJwj1HB1m6Id4hnRbzegNtwNdrfgU6vN3UJK
         3pb4sfOOB/Ntcp6WuOajhffhv+VPXfhsBxbdkxTbOTFwIUJaEEonRraRsifvCnCIMiu2
         aL3T0hCw2syy8oAltm5VBbOBw0LrHgXo8VX05fFVAnN0qcSNnMY6aYotUm2alMWvJnjh
         hOJOY9YQgL1hBBPHn6ZMhkRG5qQv6EBmk+Pe+2pFqR789fyXab++0O3uVcrLiDJoW37V
         iMMA==
X-Gm-Message-State: AOAM532WLxuSFqyy7vvG0eoskh7dTzoqKIE4CJDIajmjPcSyZTRn+K+z
        S0w4mFB1H9UBFH/+OkL7hmkXrDdJdbxeRkw7kPD6++9LQAQ=
X-Google-Smtp-Source: ABdhPJxrgPMeeG6yYFBWiiRdn46rFNdHyl74XyAdkjIrVYGo9MKRiG9s3QIcH0K/kI7lt38BNdFY23kdKb7jEYgchK8=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr88001oib.69.1606151202299;
 Mon, 23 Nov 2020 09:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20201123153148.52647-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20201123153148.52647-1-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 18:06:31 +0100
Message-ID: <CAJZ5v0jAaz2zELkJoKjHtxyfuKEi=ORuCCad-F0yp6KephieGg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Remove one more platform_device_add_properties() call
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 23, 2020 at 4:32 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> I originally introduced these as part of my series where I was
> proposing PM ops for software nodes [1], but since that still needs
> work, I'm sending these two separately.
>
> So basically I'm only modifying dwc3-pci.c so it registers a software
> node directly at this point. That will remove one more user of
> platform_device_add_properties().
>
> [1] https://lore.kernel.org/lkml/20201029105941.63410-1-heikki.krogerus@linux.intel.com/
>
> thanks,
>
> Heikki Krogerus (2):
>   software node: Introduce device_add_software_node()
>   usb: dwc3: pci: Register a software node for the dwc3 platform device
>
>  drivers/base/swnode.c       | 69 ++++++++++++++++++++++++++++++++-----
>  drivers/usb/dwc3/dwc3-pci.c | 61 +++++++++++++++++++-------------
>  include/linux/property.h    |  3 ++
>  3 files changed, 100 insertions(+), 33 deletions(-)
>
> --

These look good to me.

If you want me to take them, though, I need an ACK from the dwc3 side.
