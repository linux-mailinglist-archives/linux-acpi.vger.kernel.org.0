Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9108234ECCE
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 17:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhC3Pmb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 11:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhC3Pm1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2021 11:42:27 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1646DC061574;
        Tue, 30 Mar 2021 08:42:26 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id w1-20020a4adec10000b02901bc77feac3eso3879913oou.3;
        Tue, 30 Mar 2021 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qM3iUxurXiKPxM9feL0QlUy8TVTGziOQBaYcEOYdGrQ=;
        b=NW9gs82KSLBYkZpRmjMEfRUgoWhanDJXPgjbtbgbYBgwrNMP/cMngf5KQKfNLKJg7/
         gmtTnCzB/SsPHfUC2kWKIY6mYuydMapEgDkcykJo5CwQ8LjQaOXQZ/7tqKcPQF0ZYfJO
         06c2r9ETkpoKp7lG0EM3b7L/f20EvLp/YaR6l/j5+lm5WP+7MI1LV/EG0qL8KhbW8DQj
         2qWedb4VlwBsQnlhu5egaDR23GUX6x2gam5wrtigllpqFxBBzNPQObfhX9u9QiRbXyBF
         VqT2uFcwey1uGh/xAkp1o5B1H9UmSH1MPf36QsR6oKPGlHdw9oRZ1m4I5LPh6PjkshQG
         tAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qM3iUxurXiKPxM9feL0QlUy8TVTGziOQBaYcEOYdGrQ=;
        b=B/GYHx28JCgVEF4gMq4mBPYgTjuvy/l5Z5vgezD+1EKl+CL7vzNqbpqoeEQMahEYxq
         CxgZfr+Ske1JxC7YGk+gjiGLVO1ENk6HeiXQYSYEvfh7JKzDwiWbatxFkvxEeZw2mopq
         sG28Ut8YjeeUqu2Kw/iSnkiEXIZkdSo2QnP8vnXyl6KGJ1V7+8b08smfuLclRFHv9UWQ
         NH3tNiHQzPly/lLfQ7GKKZe6Bg+sFCWkvsxjkI4Wia+aipLGI+xL64a3y519nEVYTcdO
         uh1PwtzW+I0mwE7iEzkFDoi4isjQsSPHeulPPUEiev9yLBrEMyvZig5VNRh8tnp1AC33
         35Bg==
X-Gm-Message-State: AOAM532e6hXFF4UDIYFFBgBkFvc0KdYJc7RxNB98/23bToBDO5f0VBDt
        04PPSCYtoTIQYVpcL4zxYXM=
X-Google-Smtp-Source: ABdhPJwOH4GrdevdYv/OWFyPub323EE7r+Zzeliv5G3Px1g+5k6tLU2N+2xq5pjEqbDvWPbMsS5z0Q==
X-Received: by 2002:a4a:e8d1:: with SMTP id h17mr26131056ooe.20.1617118945451;
        Tue, 30 Mar 2021 08:42:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c25sm5356763otk.35.2021.03.30.08.42.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Mar 2021 08:42:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 Mar 2021 08:42:23 -0700
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
Message-ID: <20210330154222.GA5411@roeck-us.net>
References: <20210205222644.2357303-9-saravanak@google.com>
 <20210210114435.122242-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210114435.122242-1-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 10, 2021 at 01:44:34PM +0200, Tudor Ambarus wrote:
> This is a follow-up for:
> commit 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/removed")
> 
> The above commit updated the deprecated of_clk_add_provider(),
> but missed to update the preferred of_clk_add_hw_provider().
> Update it now.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/clk/clk.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 27ff90eacb1f..9370e4dfecae 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4594,6 +4594,8 @@ int of_clk_add_hw_provider(struct device_node *np,
>  	if (ret < 0)
>  		of_clk_del_provider(np);
>  
> +	fwnode_dev_initialized(&np->fwnode, true);
> +

This causes a crash when booting raspi2 images in qemu.

[   22.123618] Unable to handle kernel NULL pointer dereference at virtual address 00000028
[   22.123830] pgd = (ptrval)
[   22.123992] [00000028] *pgd=00000000
[   22.124579] Internal error: Oops: 5 [#1] SMP ARM
...
[   22.141624] [<c0a2f4d8>] (of_clk_add_hw_provider) from [<c0a2f54c>] (devm_of_clk_add_hw_provider+0x48/0x80)
[   22.141819] [<c0a2f54c>] (devm_of_clk_add_hw_provider) from [<c0a43ad8>] (raspberrypi_clk_probe+0x25c/0x384)
[   22.141976] [<c0a43ad8>] (raspberrypi_clk_probe) from [<c0c18da0>] (platform_probe+0x5c/0xb8)
[   22.142114] [<c0c18da0>] (platform_probe) from [<c0c16654>] (really_probe+0xf0/0x39c)
[   22.142246] [<c0c16654>] (really_probe) from [<c0c16968>] (driver_probe_device+0x68/0xc0)
[   22.142377] [<c0c16968>] (driver_probe_device) from [<c0c14834>] (bus_for_each_drv+0x84/0xc8)...

np can (and will) be NULL here. See of_clk_set_defaults().

Guenter

---
Bisect log:

# bad: [9d49ed9ca93b8c564033c1d6808017bc9052b5db] Add linux-next specific files for 20210329
# good: [0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b] Linux 5.12-rc4
git bisect start 'HEAD' 'v5.12-rc4'
# good: [4b15c5b50e5ec7f2d80275d5a150807b7b9a0a0c] Merge remote-tracking branch 'crypto/master'
git bisect good 4b15c5b50e5ec7f2d80275d5a150807b7b9a0a0c
# good: [c92ad2dfc1a3bc31afc3d41af82c38accf2c3783] Merge remote-tracking branch 'ftrace/for-next'
git bisect good c92ad2dfc1a3bc31afc3d41af82c38accf2c3783
# bad: [103c8000962c33e274244a02a0383d20fab734c9] Merge remote-tracking branch 'staging/staging-next'
git bisect bad 103c8000962c33e274244a02a0383d20fab734c9
# bad: [05ee9b17ef7af7d47395caa48db55d0e2dae64a2] Merge remote-tracking branch 'tty/tty-next'
git bisect bad 05ee9b17ef7af7d47395caa48db55d0e2dae64a2
# good: [bd91c862df59c0290c8a2e2ee6467c0ed5fb6432] Merge remote-tracking branch 'workqueues/for-next'
git bisect good bd91c862df59c0290c8a2e2ee6467c0ed5fb6432
# good: [24327c478b2fc17a01b21a4721f35f22a51fe12b] usb: mtu3: drop CONFIG_OF
git bisect good 24327c478b2fc17a01b21a4721f35f22a51fe12b
# bad: [04c49226ac79b3e5bd0f89da69a64ba2e0cccb91] Merge remote-tracking branch 'usb-serial/usb-next'
git bisect bad 04c49226ac79b3e5bd0f89da69a64ba2e0cccb91
# good: [21a292d73a6e69f31c57d36288482c40b355daf0] Merge remote-tracking branch 'drivers-x86/for-next'
git bisect good 21a292d73a6e69f31c57d36288482c40b355daf0
# bad: [b6688015151857ed3f61fa2344c4b220bc9dc4d7] regulator: qcom_spmi-regulator: Clean-up by using managed work init
git bisect bad b6688015151857ed3f61fa2344c4b220bc9dc4d7
# good: [ea718c699055c8566eb64432388a04974c43b2ea] Revert "Revert "driver core: Set fw_devlink=on by default""
git bisect good ea718c699055c8566eb64432388a04974c43b2ea
# bad: [0341ce5443949588e93581b49b934cdde2befbf8] workqueue: Add resource managed version of delayed work init
git bisect bad 0341ce5443949588e93581b49b934cdde2befbf8
# bad: [0b8bf06f67191e6a3184802a690d3f521c6d7e78] device property: Sync descriptions of swnode array and group APIs
git bisect bad 0b8bf06f67191e6a3184802a690d3f521c6d7e78
# bad: [6579c8d97ad7fc5671ee60234f3b8388abee5f77] clk: Mark fwnodes when their clock provider is added
git bisect bad 6579c8d97ad7fc5671ee60234f3b8388abee5f77
# first bad commit: [6579c8d97ad7fc5671ee60234f3b8388abee5f77] clk: Mark fwnodes when their clock provider is added
