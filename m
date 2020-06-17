Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD871FD4A7
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jun 2020 20:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgFQSg4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Jun 2020 14:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgFQSgw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jun 2020 14:36:52 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5275CC0613ED
        for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2020 11:36:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a21so2672951oic.8
        for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2020 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m743QY4j4N0DmjtOs9fMZ2T8zbdzv+0xDLVnEkgz8Xs=;
        b=R04g9HSVEDCQQpAj4Fk2rkQDJgelNkX6wYPlwKU4hWgdpTKguFVt0V0/I7rk+UWoC7
         y16mWHOEbe169ktuBkCp5ctFMIQnGqToadXzfD5XQGYb/+gRjCqWJfua2tV/HuvWGNmP
         EL9ZaGmrYL6uCuxqjTW4Uu36mEK9mu29OG+zh8dEJj2MKZTUGnOcT6bsRf3CwqdiGo5l
         rEqQrRnZzWxfp33TrhalkbIM24y97ZOLaoRuyfEqfsFm2ZPjy2Kg7OT2b12zzSWgg7Tn
         j7N6sWyQQoYrKctp+dnnTnqwJ0tFdObNQD+maCXc9VGKdFjrtD+nFF+2Tb6iCby/vR8A
         KDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m743QY4j4N0DmjtOs9fMZ2T8zbdzv+0xDLVnEkgz8Xs=;
        b=QM1/J3vB6XPP1J5fPD8SEyLhRxE0WGyyn9XD2thEIlSSe4OM6y9jfVkVh30DfiQFF3
         GrKacPQaJKZ8uLW6Fn51w1jbQ0WIy4mFysiv1v4yrKTMJOOMVZUbxuV3lGMSN8tuPyha
         Cu3YRh4ikuuL+j3bZrfJRDt01I1s0wmIucxclUHAKwwkaSFhr8rpeydC5I7J6f2MFYbd
         RS1I7KehP+Tx17AuMXHoFhEmjFPXnEGEBiEZYSIS42C6W1LpscRNFACOA8oADiHDRVXO
         8fCl/Ob9oJorfftXsnbhZyP0LPUXvr/YAx094W18tshKCv58ZAFItnhCnJZCpXgSv8t2
         /REw==
X-Gm-Message-State: AOAM531MNIlKNKUwtGCMenAfcdb7kuPbhYv/ByZES8ouOw7HFf8MHlt0
        kMNkH7v0NPTPVHCxG/6/xKDPynmDrWoYBOnlFnXJhg==
X-Google-Smtp-Source: ABdhPJy1DeZtFko5KqEH1OkAXfc+QWxNhghwaA9TZRXvML2oplG4BdrzrsqYZHmUTIvdb3uTTchPN7CNviG7SM1cpt0=
X-Received: by 2002:aca:530e:: with SMTP id h14mr86929oib.172.1592419011313;
 Wed, 17 Jun 2020 11:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com> <20200515053500.215929-5-saravanak@google.com>
 <CAMuHMdUnbDvn6GdK51MN-+5iRp6zYRf-yzKY+OwcQOGrYqOZPA@mail.gmail.com>
In-Reply-To: <CAMuHMdUnbDvn6GdK51MN-+5iRp6zYRf-yzKY+OwcQOGrYqOZPA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 17 Jun 2020 11:36:15 -0700
Message-ID: <CAGETcx9JKbNQWQwNah7pO5ppVSAe86R-OmMujZPYNkuTCLwKnQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding all
 top level devices
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ji Luo <ji.luo@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Geert,

On Wed, Jun 17, 2020 at 5:20 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Fri, May 15, 2020 at 7:38 AM Saravana Kannan <saravanak@google.com> wrote:
> > The fw_devlink_pause() and fw_devlink_resume() APIs allow batching the
> > parsing of the device tree nodes when a lot of devices are added. This
> > will significantly cut down parsing time (as much a 1 second on some
> > systems). So, use them when adding devices for all the top level device
> > tree nodes in a system.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> This is now commit 93d2e4322aa74c1a ("of: platform: Batch fwnode parsing
> when adding all top level devices") in v5.8-rc1, and I have bisected a
> regression to it: on r8a7740/armadillo and sh73a0/kzm9g, the system can
> no longer be woken up from s2ram by a GPIO key. Reverting the commit
> fixes the issue.
>
> On these systems, the GPIO/PFC block has its interrupt lines connected
> to intermediate interrupt controllers (Renesas INTC), which are in turn
> connected to the main interrupt controller (ARM GIC).  The INTC block is
> part of a power and clock domain.  Hence if a GPIO is enabled as a
> wake-up source, the INTC is part of the wake-up path, and thus must be
> kept enabled when entering s2ram.
>
> While this commit has no impact on probe order for me (unlike in Marek's
> case), it does have an impact on suspend order:
>   - Before this commit:
>       1. The keyboard (gpio-keys) is suspended, and calls
>          enable_irq_wake() to inform the upstream interrupt controller
>          (INTC) that it is part of the wake-up path,
>       2. INTC is suspended, and calls device_set_wakeup_path() to inform
>          the device core that it must be kept enabled,
>       3. The system is woken by pressing a wake-up key.
>
>   - After this commit:
>       1. INTC is suspended, and is not aware it is part of the wake-up
>          path, so it is disabled by the device core,
>       2. gpio-keys is suspended, and calls enable_irq_wake() in vain,
>       3. Pressing a wake-up key has no effect, as INTC is disabled, and
>          the interrupt does not come through.
>
> It looks like no device links are involved, as both gpio-keys and INTC have
> no links.
> Do you have a clue?
>
> Thanks!

That patch of mine defers probe on all devices added by the
of_platform_default_populate() call, and then once the call returns,
it immediately triggers a deferred probe.

So all these devices are being probed in parallel in the deferred
probe workqueue while the main "initcall thread" continues down to
further initcalls. It looks like some of the drivers in subsequent
initcalls are assuming that devices in the earlier initcalls always
probe and can't be deferred?

There are two options.
1. Fix these drivers.
2. Add a "flush deferred workqueue" in fw_devlink_resume()

I'd rather we fix the drivers so that they handle deferred probes
correctly. Thoughts?

-Saravana
