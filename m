Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B4B366411
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Apr 2021 05:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhDUD1d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Apr 2021 23:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbhDUD13 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Apr 2021 23:27:29 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F895C06174A;
        Tue, 20 Apr 2021 20:26:56 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id v6so13318713oiv.3;
        Tue, 20 Apr 2021 20:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MWK09kw+cZABiUewyDvRKqcNr5Wzfd1T9if6kGy1ACU=;
        b=ptMZMIkRBfbvDMtNiL/47XyoIRY0/jim8ZQBu+A/J93zDBYnxub/u8Wbel9O2EDqqr
         dzCKJktHtZRAgvf+KbqCaGkj8KW9htgeKKwN44cxgZULx+uwcY5O8oV8PymAASNdi4K5
         +Q+gTTtJyAj/DTb0ZejoV+cOlaHyN2NEjYMGrvtJmyZMqZ+mn/kB0yEeN0Mk8gJz9QoX
         L5RRXWtDo8jWyWJ49Ga+a+QYN4HitC+k0lifY0jU5unzcm/iSC8NzqMVbU5hBlvT4Mlb
         JIRrdVCgX4OwZCb1eUibJodHdLt6b+I9KwRUO3OSI8k+dMl6zomSkhKoI4oefCcv7MEL
         j8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MWK09kw+cZABiUewyDvRKqcNr5Wzfd1T9if6kGy1ACU=;
        b=c5OccDrmpypBLC+w6cniE05gHJC28sLBDu9ZK/QmREPjFCKJqaeLH7945ankRB4XhW
         dv1N22bLMDTdRNn4X9OaFK9GvV7HMoWuF5ll69udwPLMkQVv/EUqi+tsC6O35b/+yKyg
         L7ppj+9cmHn8XNDKVgxHHrYTRnYUajI/VfS8X4hExlduOkgbO+/w5z39AsJhRJf8SilS
         wqPVpAF1F25T2ct9mAwXCBl+w7f5aeSkbICsds2zNhmI0AtncHLiT/NhsqgeZbJ3EORJ
         7bfjd3iP5nXReByOVu6D7BR8nbDHvuOgrQZ8gcEMxHPs3WUK+TkvOGdvdjFi1mtzNKOO
         ToaA==
X-Gm-Message-State: AOAM5325JBBkWeAmc2H4IhDaLGGSK/gmEjtQI/EYM41i69bllaKAC3+z
        apkTW4GiVUmq6cS5XF6mgmQ=
X-Google-Smtp-Source: ABdhPJzBGPf2Jx0aPwkboV3X5V/3IZLEVS9eZVQ3647srnUE4TdLpLSWoZ0pSjT5NFquSXI0fjb7bA==
X-Received: by 2002:aca:d90a:: with SMTP id q10mr5421443oig.63.1618975615856;
        Tue, 20 Apr 2021 20:26:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d7sm245312oib.49.2021.04.20.20.26.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Apr 2021 20:26:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Apr 2021 20:26:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
        khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com,
        lenb@kernel.org, pavel@ucw.cz, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, frowand.list@gmail.com,
        maz@kernel.org, tglx@linutronix.de, saravanak@google.com,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        m.szyprowski@samsung.com, geert@linux-m68k.org,
        kernel-team@android.com
Subject: Re: [PATCH] clk: Mark fwnodes when their clock provider is added
Message-ID: <20210421032653.GA179924@roeck-us.net>
References: <20210205222644.2357303-9-saravanak@google.com>
 <20210210114435.122242-1-tudor.ambarus@microchip.com>
 <20210210114435.122242-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210114435.122242-2-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Wed, Feb 10, 2021 at 01:44:35PM +0200, Tudor Ambarus wrote:
> This is a follow-up for:
> commit 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/removed")
> 
> The above commit updated the deprecated of_clk_add_provider(),
> but missed to update the preferred of_clk_add_hw_provider().
> Update it now.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

This patch still causes a crash when booting a raspi2 image in linux-next.

[   21.456500] Unable to handle kernel NULL pointer dereference at virtual address 00000028
[   21.456750] pgd = (ptrval)
[   21.456927] [00000028] *pgd=00000000
[   21.457567] Internal error: Oops: 5 [#1] SMP ARM
[   21.457882] Modules linked in:
[   21.458077] CPU: 0 PID: 77 Comm: kworker/u8:10 Not tainted 5.12.0-rc8-next-20210420 #1
[   21.458291] Hardware name: BCM2835
[   21.458525] Workqueue: events_unbound deferred_probe_work_func
[   21.458997] PC is at of_clk_add_hw_provider+0xbc/0xe8
[   21.459176] LR is at of_clk_add_hw_provider+0xa8/0xe8
...
[   21.477603] [<c0a32aec>] (of_clk_add_hw_provider) from [<c0a32b60>] (devm_of_clk_add_hw_provider+0x48/0x80)
[   21.477861] [<c0a32b60>] (devm_of_clk_add_hw_provider) from [<c0a471e4>] (raspberrypi_clk_probe+0x260/0x388)
[   21.478087] [<c0a471e4>] (raspberrypi_clk_probe) from [<c0c1c4d0>] (platform_probe+0x5c/0xb8)
[   21.478287] [<c0c1c4d0>] (platform_probe) from [<c0c19d84>] (really_probe+0xf0/0x39c)
[   21.478471] [<c0c19d84>] (really_probe) from [<c0c1a098>] (driver_probe_device+0x68/0xc0)
[   21.478659] [<c0c1a098>] (driver_probe_device) from [<c0c17f54>] (bus_for_each_drv+0x84/0xc8)
[   21.478860] [<c0c17f54>] (bus_for_each_drv) from [<c0c19c20>] (__device_attach+0xec/0x158)
[   21.479050] [<c0c19c20>] (__device_attach) from [<c0c18de8>] (bus_probe_device+0x88/0x90)
[   21.479236] [<c0c18de8>] (bus_probe_device) from [<c0c16a68>] (device_add+0x398/0x8ac)
[   21.479421] [<c0c16a68>] (device_add) from [<c0c1c1b4>] (platform_device_add+0xf0/0x200)
[   21.479607] [<c0c1c1b4>] (platform_device_add) from [<c0c1ccc0>] (platform_device_register_full+0xd0/0x110)
[   21.479836] [<c0c1ccc0>] (platform_device_register_full) from [<c104c130>] (rpi_firmware_probe+0x1a4/0x20c)
[   21.480061] [<c104c130>] (rpi_firmware_probe) from [<c0c1c4d0>] (platform_probe+0x5c/0xb8)
[   21.480255] [<c0c1c4d0>] (platform_probe) from [<c0c19d84>] (really_probe+0xf0/0x39c)
[   21.480437] [<c0c19d84>] (really_probe) from [<c0c1a098>] (driver_probe_device+0x68/0xc0)
[   21.480626] [<c0c1a098>] (driver_probe_device) from [<c0c17f54>] (bus_for_each_drv+0x84/0xc8)
[   21.480829] [<c0c17f54>] (bus_for_each_drv) from [<c0c19c20>] (__device_attach+0xec/0x158)
[   21.481018] [<c0c19c20>] (__device_attach) from [<c0c18de8>] (bus_probe_device+0x88/0x90)
[   21.481205] [<c0c18de8>] (bus_probe_device) from [<c0c192bc>] (deferred_probe_work_func+0x8c/0xbc)
[   21.481413] [<c0c192bc>] (deferred_probe_work_func) from [<c036802c>] (process_one_work+0x268/0x798)
[   21.481624] [<c036802c>] (process_one_work) from [<c0368774>] (worker_thread+0x218/0x4f4)
[   21.481822] [<c0368774>] (worker_thread) from [<c0370f28>] (kthread+0x140/0x174)
[   21.481999] [<c0370f28>] (kthread) from [<c030017c>] (ret_from_fork+0x14/0x38)
[   21.482185] Exception stack(0xc42b7fb0 to 0xc42b7ff8)

Updated bisect log is attached.

Guenter

---
# bad: [50b8b1d699ac313c0a07a3c185ffb23aecab8abb] Add linux-next specific files for 20210419
# good: [bf05bf16c76bb44ab5156223e1e58e26dfe30a88] Linux 5.12-rc8
git bisect start 'HEAD' 'v5.12-rc8'
# good: [c4bb91fc07e59241cde97f913d7a2fbedc248f0d] Merge remote-tracking branch 'crypto/master'
git bisect good c4bb91fc07e59241cde97f913d7a2fbedc248f0d
# good: [f15bbf170b40b48a43ed7076ce9f8ac9380e5752] Merge remote-tracking branch 'edac/edac-for-next'
git bisect good f15bbf170b40b48a43ed7076ce9f8ac9380e5752
# bad: [550a78090dcc4061e191312a757a127f0b6e6323] Merge remote-tracking branch 'vfio/next'
git bisect bad 550a78090dcc4061e191312a757a127f0b6e6323
# bad: [9f074d2a7bf49b2c9e1609703757b18de7611aef] Merge remote-tracking branch 'usb/usb-next'
git bisect bad 9f074d2a7bf49b2c9e1609703757b18de7611aef
# good: [855b2fdb7c543c94e7623e6ad0b492f04a5317db] Merge remote-tracking branch 'percpu/for-next'
git bisect good 855b2fdb7c543c94e7623e6ad0b492f04a5317db
# good: [1d08ed588c6a85a35a24c82eb4cf0807ec2b366a] usbip: vudc: fix missing unlock on error in usbip_sockfd_store()
git bisect good 1d08ed588c6a85a35a24c82eb4cf0807ec2b366a
# good: [1b7ce8fab5fd0c406dbf165b12d44b301decf589] Merge remote-tracking branch 'ipmi/for-next'
git bisect good 1b7ce8fab5fd0c406dbf165b12d44b301decf589
# good: [fe8e488058c47e9a8a2c85321f7198a0a17b0131] dt-bindings: usb: mtk-xhci: add wakeup interrupt
git bisect good fe8e488058c47e9a8a2c85321f7198a0a17b0131
# bad: [3c652132ce9052e626bf509932fcacfebed1ccb4] platform-msi: fix kernel-doc warnings
git bisect bad 3c652132ce9052e626bf509932fcacfebed1ccb4
# bad: [7f2fac70b729d68a34e5eba8d1fb68eb69b05169] device property: Add test cases for fwnode_property_count_*() APIs
git bisect bad 7f2fac70b729d68a34e5eba8d1fb68eb69b05169
# good: [38f087de8947700d3b06d3d1594490e0f611c5d1] devtmpfs: fix placement of complete() call
git bisect good 38f087de8947700d3b06d3d1594490e0f611c5d1
# good: [b6f617df4fa936c1ab1831c2b23563f6c1add6c4] driver core: Update device link status properly for device_bind_driver()
git bisect good b6f617df4fa936c1ab1831c2b23563f6c1add6c4
# bad: [6579c8d97ad7fc5671ee60234f3b8388abee5f77] clk: Mark fwnodes when their clock provider is added
git bisect bad 6579c8d97ad7fc5671ee60234f3b8388abee5f77
# good: [ea718c699055c8566eb64432388a04974c43b2ea] Revert "Revert "driver core: Set fw_devlink=on by default""
git bisect good ea718c699055c8566eb64432388a04974c43b2ea
# first bad commit: [6579c8d97ad7fc5671ee60234f3b8388abee5f77] clk: Mark fwnodes when their clock provider is added
