Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45243665F1
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Apr 2021 09:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhDUHB4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Apr 2021 03:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbhDUHBx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Apr 2021 03:01:53 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF4DC06138B
        for <linux-acpi@vger.kernel.org>; Wed, 21 Apr 2021 00:01:18 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 65so46021967ybc.4
        for <linux-acpi@vger.kernel.org>; Wed, 21 Apr 2021 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bKgB7JiZwc4vgVkRBcbHea3g47Hab58/tBD/C4XU4M=;
        b=OEgGH/vIkSE1eIGDm/azD5/DxoZjhOcM87MNX1nFCuCS4h+Kq6OcixIp0TKvka7/kS
         F/Xw4tQIcPchwAuQ6Q7qj7lOsd2DfmrZCtn59zdAKtoLY963ij+xMkutbVgnxwT9fvrU
         27dRJRyK4jG18ZrB1u5TZ98zFX0gIBn5XneOoGcekW6JggAPoV13mLaEELc2AoSXW1sf
         gFAfbkQH0y0E/QutPfuPe5TQcKHMJ6TSuX+8YhVlhA3PyvDUgD1/QlboL+yVIlgd8uQH
         soB/sBSDXVp4JI9suLovHaRHOFID5r+ssqKUgyfkkR4eGu91kyya9ccIdgt+7HFykRdi
         dO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bKgB7JiZwc4vgVkRBcbHea3g47Hab58/tBD/C4XU4M=;
        b=aUrCcfs/WHoNIS51sMqTVjRBh03q46LPNpO/aV9HfsTMLcJ1MnCt5ZvdxK/8INvCLS
         R5u30iF0FyCD0Ly5ZIlHhIGX0TLC28x5kIfIgAj8aNjf5cboF3p/ydvqH3UgUdjixVn4
         0cwX2CyOj/NYItE2kJKx8NEIwmrK3SwGKW3PzAyG+H8vHn7MZIPk9Boy1hQpO1PzLJNd
         vwhvc5qkkx9Wh/FIXnv4/je5uxF2XIPMU18kVqyvzxdBZOjDDsbbBTc/ymKPrKtgM8VC
         rY25rHxkNB0w5SyG6Ejjof/2jpbXpPNOufW8CpV05DCStcAVyGq6kIdoDJgDwkoVXZXv
         RpyQ==
X-Gm-Message-State: AOAM530S4fpSaEXUTI3YAZKB0sITocHiSxJn5V11KgzS+lMcQnoM33Pp
        EhOILHqmCFAp/pHLOQ/GA43B2UYsQWN3WOQK8tY5tg==
X-Google-Smtp-Source: ABdhPJyH9+ZJbkD7iNParB2kAQl6tKzUxYtAjmBvRxVXuWS16qiin3xx7TOsJ4dZn4d6+rHgImxNhOaRF8VRiNeX6UU=
X-Received: by 2002:a5b:ed2:: with SMTP id a18mr31248849ybs.466.1618988477848;
 Wed, 21 Apr 2021 00:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210205222644.2357303-9-saravanak@google.com>
 <20210210114435.122242-1-tudor.ambarus@microchip.com> <20210210114435.122242-2-tudor.ambarus@microchip.com>
 <20210421032653.GA179924@roeck-us.net>
In-Reply-To: <20210421032653.GA179924@roeck-us.net>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 21 Apr 2021 00:00:41 -0700
Message-ID: <CAGETcx_nb4HTGqAME_pVu3gjZ9UQabsi7hsXzB47_Qsp7vRcdA@mail.gmail.com>
Subject: Re: [PATCH] clk: Mark fwnodes when their clock provider is added
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Brown, Len" <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 20, 2021 at 8:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> On Wed, Feb 10, 2021 at 01:44:35PM +0200, Tudor Ambarus wrote:
> > This is a follow-up for:
> > commit 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/removed")
> >
> > The above commit updated the deprecated of_clk_add_provider(),
> > but missed to update the preferred of_clk_add_hw_provider().
> > Update it now.
> >
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>
> This patch still causes a crash when booting a raspi2 image in linux-next.

Stephen,

Can we please just pick any one of the proposed fixes? This bug has
been unfixed for so long!

-Saravana

>
> [   21.456500] Unable to handle kernel NULL pointer dereference at virtual address 00000028
> [   21.456750] pgd = (ptrval)
> [   21.456927] [00000028] *pgd=00000000
> [   21.457567] Internal error: Oops: 5 [#1] SMP ARM
> [   21.457882] Modules linked in:
> [   21.458077] CPU: 0 PID: 77 Comm: kworker/u8:10 Not tainted 5.12.0-rc8-next-20210420 #1
> [   21.458291] Hardware name: BCM2835
> [   21.458525] Workqueue: events_unbound deferred_probe_work_func
> [   21.458997] PC is at of_clk_add_hw_provider+0xbc/0xe8
> [   21.459176] LR is at of_clk_add_hw_provider+0xa8/0xe8
> ...
> [   21.477603] [<c0a32aec>] (of_clk_add_hw_provider) from [<c0a32b60>] (devm_of_clk_add_hw_provider+0x48/0x80)
> [   21.477861] [<c0a32b60>] (devm_of_clk_add_hw_provider) from [<c0a471e4>] (raspberrypi_clk_probe+0x260/0x388)
> [   21.478087] [<c0a471e4>] (raspberrypi_clk_probe) from [<c0c1c4d0>] (platform_probe+0x5c/0xb8)
> [   21.478287] [<c0c1c4d0>] (platform_probe) from [<c0c19d84>] (really_probe+0xf0/0x39c)
> [   21.478471] [<c0c19d84>] (really_probe) from [<c0c1a098>] (driver_probe_device+0x68/0xc0)
> [   21.478659] [<c0c1a098>] (driver_probe_device) from [<c0c17f54>] (bus_for_each_drv+0x84/0xc8)
> [   21.478860] [<c0c17f54>] (bus_for_each_drv) from [<c0c19c20>] (__device_attach+0xec/0x158)
> [   21.479050] [<c0c19c20>] (__device_attach) from [<c0c18de8>] (bus_probe_device+0x88/0x90)
> [   21.479236] [<c0c18de8>] (bus_probe_device) from [<c0c16a68>] (device_add+0x398/0x8ac)
> [   21.479421] [<c0c16a68>] (device_add) from [<c0c1c1b4>] (platform_device_add+0xf0/0x200)
> [   21.479607] [<c0c1c1b4>] (platform_device_add) from [<c0c1ccc0>] (platform_device_register_full+0xd0/0x110)
> [   21.479836] [<c0c1ccc0>] (platform_device_register_full) from [<c104c130>] (rpi_firmware_probe+0x1a4/0x20c)
> [   21.480061] [<c104c130>] (rpi_firmware_probe) from [<c0c1c4d0>] (platform_probe+0x5c/0xb8)
> [   21.480255] [<c0c1c4d0>] (platform_probe) from [<c0c19d84>] (really_probe+0xf0/0x39c)
> [   21.480437] [<c0c19d84>] (really_probe) from [<c0c1a098>] (driver_probe_device+0x68/0xc0)
> [   21.480626] [<c0c1a098>] (driver_probe_device) from [<c0c17f54>] (bus_for_each_drv+0x84/0xc8)
> [   21.480829] [<c0c17f54>] (bus_for_each_drv) from [<c0c19c20>] (__device_attach+0xec/0x158)
> [   21.481018] [<c0c19c20>] (__device_attach) from [<c0c18de8>] (bus_probe_device+0x88/0x90)
> [   21.481205] [<c0c18de8>] (bus_probe_device) from [<c0c192bc>] (deferred_probe_work_func+0x8c/0xbc)
> [   21.481413] [<c0c192bc>] (deferred_probe_work_func) from [<c036802c>] (process_one_work+0x268/0x798)
> [   21.481624] [<c036802c>] (process_one_work) from [<c0368774>] (worker_thread+0x218/0x4f4)
> [   21.481822] [<c0368774>] (worker_thread) from [<c0370f28>] (kthread+0x140/0x174)
> [   21.481999] [<c0370f28>] (kthread) from [<c030017c>] (ret_from_fork+0x14/0x38)
> [   21.482185] Exception stack(0xc42b7fb0 to 0xc42b7ff8)
>
> Updated bisect log is attached.
>
> Guenter
>
> ---
> # bad: [50b8b1d699ac313c0a07a3c185ffb23aecab8abb] Add linux-next specific files for 20210419
> # good: [bf05bf16c76bb44ab5156223e1e58e26dfe30a88] Linux 5.12-rc8
> git bisect start 'HEAD' 'v5.12-rc8'
> # good: [c4bb91fc07e59241cde97f913d7a2fbedc248f0d] Merge remote-tracking branch 'crypto/master'
> git bisect good c4bb91fc07e59241cde97f913d7a2fbedc248f0d
> # good: [f15bbf170b40b48a43ed7076ce9f8ac9380e5752] Merge remote-tracking branch 'edac/edac-for-next'
> git bisect good f15bbf170b40b48a43ed7076ce9f8ac9380e5752
> # bad: [550a78090dcc4061e191312a757a127f0b6e6323] Merge remote-tracking branch 'vfio/next'
> git bisect bad 550a78090dcc4061e191312a757a127f0b6e6323
> # bad: [9f074d2a7bf49b2c9e1609703757b18de7611aef] Merge remote-tracking branch 'usb/usb-next'
> git bisect bad 9f074d2a7bf49b2c9e1609703757b18de7611aef
> # good: [855b2fdb7c543c94e7623e6ad0b492f04a5317db] Merge remote-tracking branch 'percpu/for-next'
> git bisect good 855b2fdb7c543c94e7623e6ad0b492f04a5317db
> # good: [1d08ed588c6a85a35a24c82eb4cf0807ec2b366a] usbip: vudc: fix missing unlock on error in usbip_sockfd_store()
> git bisect good 1d08ed588c6a85a35a24c82eb4cf0807ec2b366a
> # good: [1b7ce8fab5fd0c406dbf165b12d44b301decf589] Merge remote-tracking branch 'ipmi/for-next'
> git bisect good 1b7ce8fab5fd0c406dbf165b12d44b301decf589
> # good: [fe8e488058c47e9a8a2c85321f7198a0a17b0131] dt-bindings: usb: mtk-xhci: add wakeup interrupt
> git bisect good fe8e488058c47e9a8a2c85321f7198a0a17b0131
> # bad: [3c652132ce9052e626bf509932fcacfebed1ccb4] platform-msi: fix kernel-doc warnings
> git bisect bad 3c652132ce9052e626bf509932fcacfebed1ccb4
> # bad: [7f2fac70b729d68a34e5eba8d1fb68eb69b05169] device property: Add test cases for fwnode_property_count_*() APIs
> git bisect bad 7f2fac70b729d68a34e5eba8d1fb68eb69b05169
> # good: [38f087de8947700d3b06d3d1594490e0f611c5d1] devtmpfs: fix placement of complete() call
> git bisect good 38f087de8947700d3b06d3d1594490e0f611c5d1
> # good: [b6f617df4fa936c1ab1831c2b23563f6c1add6c4] driver core: Update device link status properly for device_bind_driver()
> git bisect good b6f617df4fa936c1ab1831c2b23563f6c1add6c4
> # bad: [6579c8d97ad7fc5671ee60234f3b8388abee5f77] clk: Mark fwnodes when their clock provider is added
> git bisect bad 6579c8d97ad7fc5671ee60234f3b8388abee5f77
> # good: [ea718c699055c8566eb64432388a04974c43b2ea] Revert "Revert "driver core: Set fw_devlink=on by default""
> git bisect good ea718c699055c8566eb64432388a04974c43b2ea
> # first bad commit: [6579c8d97ad7fc5671ee60234f3b8388abee5f77] clk: Mark fwnodes when their clock provider is added
