Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720251D904E
	for <lists+linux-acpi@lfdr.de>; Tue, 19 May 2020 08:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgESGsq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 May 2020 02:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgESGsp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2020 02:48:45 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F33C061A0C
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2020 23:48:44 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o7so11430835oif.2
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2020 23:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2RoPzTCE8S7cwF+v2jtvlQuK5XUvcvijsX4mjuFShc=;
        b=gggXvY9pyKakUlPW6dVoQGoCc2pydoEkf1Jc1cWi7XdmsoWRKW5Kcc+9sW0HoCLFuS
         hjY9fpjOGLJZLG4cnvNl6TrU2TEKVh5DDll4ZLOuxilsUdBVZZMAMbXGRwcTIeWHs1Di
         8ylk296NeWvaZX3//w11TI1TqOJVVcgTbS5mCICOw0ee2/HKL9Z5sI5XuHxAa6puKiwl
         4MneA2Ryr/bVTRjhOy67FDRT41RVTBI5T7egfYCx30Mvx3YyFe+qWrFtDTmz6xdJsrib
         PKWydb61jfgfV7BJyfx/qM5hB4G3a0KFc/fHkCQirLIRGOYV3R28j24phO9y4S5ZHMD7
         3rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2RoPzTCE8S7cwF+v2jtvlQuK5XUvcvijsX4mjuFShc=;
        b=ZZt/aAg2gFrHuYPAZ1oyPhUOs3vkZQAOgq+RuIky6x4bMPDjF3ZY96mQT2gYTs+nb+
         V6EUXpCCDru7mbtvQV3el+i8DyI9s7sBho4AIyhnmJE/rgYCCSGNyHtBAtb2V7WLac89
         9SXDn6B2GRvOQx09pGHF6kyRo6KQmM25r0RTtlvwa4R5yYzIKVBxMOkeNvh9S+0Il2Pg
         M3HnB7H6KnxBAs5gTHKG93NINZv8gLl798r9PEzel9VjD2eWJKmsMftID7lPWcpMTjdq
         k9sNO3ToUAlgwO7CgnGBq5292p9lAdUFgH1V0ps8P3GtIJ0UOIWo3Uwx0uN2SzZLbug3
         PpgA==
X-Gm-Message-State: AOAM532uBqVGpJT08/ArYN8S8WPmbi5gTBFBKsySG32oVluDFyQx/diy
        UqroWjSdV2wNIErZKlv0XiKuPOdQuEkG0enbjuowDg==
X-Google-Smtp-Source: ABdhPJxFqxwtTYfMAsVr/n3EFChx59GX67RspQpq8QV99EAmFPgFEgysFnulZjGYlW9Dlh1Ojx6JpYo9TpNT3TtchwI=
X-Received: by 2002:aca:f1c2:: with SMTP id p185mr2190738oih.69.1589870923464;
 Mon, 18 May 2020 23:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com> <CGME20200519062510eucas1p27bc59da66e1b77534855103a27f87452@eucas1p2.samsung.com>
 <20200515053500.215929-5-saravanak@google.com> <e0f9211d-9cf6-a12d-eb63-df06910920ed@samsung.com>
In-Reply-To: <e0f9211d-9cf6-a12d-eb63-df06910920ed@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 18 May 2020 23:48:07 -0700
Message-ID: <CAGETcx_FOGgHdaNY8Dd-4rgT28U7_OHYeLsazbUE-1hyuatRSg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding all
 top level devices
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ji Luo <ji.luo@nxp.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 18, 2020 at 11:25 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Saravana,
>
> On 15.05.2020 07:35, Saravana Kannan wrote:
> > The fw_devlink_pause() and fw_devlink_resume() APIs allow batching the
> > parsing of the device tree nodes when a lot of devices are added. This
> > will significantly cut down parsing time (as much a 1 second on some
> > systems). So, use them when adding devices for all the top level device
> > tree nodes in a system.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> This patch recently landed in linux-next 20200518. Sadly, it causes
> regression on Samsung Exynos5433-based TM2e board:
>
> s3c64xx-spi 14d30000.spi: Failed to get RX DMA channel
> s3c64xx-spi 14d50000.spi: Failed to get RX DMA channel
> s3c64xx-spi 14d30000.spi: Failed to get RX DMA channel
> s3c64xx-spi 14d50000.spi: Failed to get RX DMA channel
> s3c64xx-spi 14d30000.spi: Failed to get RX DMA channel
>
> Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 50 Comm: kworker/0:1 Not tainted 5.7.0-rc5+ #701
> Hardware name: Samsung TM2E board (DT)
> Workqueue: events deferred_probe_work_func
> pstate: 60000005 (nZCv daif -PAN -UAO)
> pc : samsung_i2s_probe+0x768/0x8f0
> lr : samsung_i2s_probe+0x688/0x8f0
> ...
> Call trace:
>   samsung_i2s_probe+0x768/0x8f0
>   platform_drv_probe+0x50/0xa8
>   really_probe+0x108/0x370
>   driver_probe_device+0x54/0xb8
>   __device_attach_driver+0x90/0xc0
>   bus_for_each_drv+0x70/0xc8
>   __device_attach+0xdc/0x140
>   device_initial_probe+0x10/0x18
>   bus_probe_device+0x94/0xa0
>   deferred_probe_work_func+0x70/0xa8
>   process_one_work+0x2a8/0x718
>   worker_thread+0x48/0x470
>   kthread+0x134/0x160
>   ret_from_fork+0x10/0x1c
> Code: 17ffffaf d503201f f94086c0 91003000 (88dffc00)
> ---[ end trace ccf721c9400ddbd6 ]---
> Kernel panic - not syncing: Fatal exception
> SMP: stopping secondary CPUs
> Kernel Offset: disabled
> CPU features: 0x090002,24006087
> Memory Limit: none
>
> ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> Both issues, the lack of DMA for SPI device and Synchronous abort in I2S
> probe are new after applying this patch. I'm trying to investigate which
> resources are missing and why. The latter issue means typically that the
> registers for the given device has been accessed without enabling the
> needed clocks or power domains.

Did you try this copy-pasta fix that I sent later?
https://lore.kernel.org/lkml/20200517173453.157703-1-saravanak@google.com/

Not every system would need it (my test setup didn't), but it helps some cases.

If that fix doesn't help, then some tips for debugging the failing drivers.
What this pause/resume patch effectively (not explicitly) does is:
1. Doesn't immediately probe the devices as they are added in
of_platform_default_populate_init()
2. Adds them in order to the deferred probe list.
3. Then kicks off deferred probe on them in the order they were added.

These drivers are just not handling -EPROBE_DEFER correctly or
assuming probe order and that's causing these issues.

So, we can either fix that or you can try adding some code to flush
the deferred probe workqueue at the end of fw_devlink_resume().

Let me know how it goes.

Thanks,
Saravana
