Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125B41FCD2D
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jun 2020 14:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgFQMUq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Jun 2020 08:20:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43415 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgFQMUq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jun 2020 08:20:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id j189so1554849oih.10;
        Wed, 17 Jun 2020 05:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0etkep4Rd918jvO2ZHID3EJxiQAW+0eFuu/af9OvSg=;
        b=du0mRv5SGDDkovbJS8x4ItuUVwqKS2iOaaLoxwfdXvbSXHc8Imhtsb9TUCaFeECA9X
         kdZAK4Cx5xbbhOAzSE8QFNAKG/zI6WwiqIZ+DJg3Zs5uLb/lrs2W8Okzd+Rdg5DwZ7QK
         U33EYzJ+h4z8pU/lAlCuj6POXI9gswukXG+bguwTIA2REpm2FQeLqljpT0Bddj3QgjsF
         4d5vKovT1ttAzFWWhO74j3FQaNi6p0gH9E0KpSxEa46eOH6MGV6wiLFbo0iecZMV1+xr
         e5tfW/4v2EZAYLvdCMiKll4/T/GInr76jUHh0RB+III0wdpjnwqNIaFZE6shce55E5nT
         pqnA==
X-Gm-Message-State: AOAM532K44vaw9Ii9OMks0WlGQeRuNL5OaGQa1mJIE+d7cHL6Nj7NHKt
        B0xqyZzgDytAf18JWl3xaNib+PQHey/UneIBMB4=
X-Google-Smtp-Source: ABdhPJx1wNFLvdG+kMPq1cVWjzPAn3tXuSHpnFN2crKJE10atFy356OIl7/gvqW9/EsYOSoXfgB9Wz20pr0EJ93Zz9w=
X-Received: by 2002:aca:1a19:: with SMTP id a25mr7137097oia.54.1592396444910;
 Wed, 17 Jun 2020 05:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com> <20200515053500.215929-5-saravanak@google.com>
In-Reply-To: <20200515053500.215929-5-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Jun 2020 14:20:33 +0200
Message-ID: <CAMuHMdUnbDvn6GdK51MN-+5iRp6zYRf-yzKY+OwcQOGrYqOZPA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding all
 top level devices
To:     Saravana Kannan <saravanak@google.com>
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

Hi Saravana,

On Fri, May 15, 2020 at 7:38 AM Saravana Kannan <saravanak@google.com> wrote:
> The fw_devlink_pause() and fw_devlink_resume() APIs allow batching the
> parsing of the device tree nodes when a lot of devices are added. This
> will significantly cut down parsing time (as much a 1 second on some
> systems). So, use them when adding devices for all the top level device
> tree nodes in a system.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

This is now commit 93d2e4322aa74c1a ("of: platform: Batch fwnode parsing
when adding all top level devices") in v5.8-rc1, and I have bisected a
regression to it: on r8a7740/armadillo and sh73a0/kzm9g, the system can
no longer be woken up from s2ram by a GPIO key. Reverting the commit
fixes the issue.

On these systems, the GPIO/PFC block has its interrupt lines connected
to intermediate interrupt controllers (Renesas INTC), which are in turn
connected to the main interrupt controller (ARM GIC).  The INTC block is
part of a power and clock domain.  Hence if a GPIO is enabled as a
wake-up source, the INTC is part of the wake-up path, and thus must be
kept enabled when entering s2ram.

While this commit has no impact on probe order for me (unlike in Marek's
case), it does have an impact on suspend order:
  - Before this commit:
      1. The keyboard (gpio-keys) is suspended, and calls
         enable_irq_wake() to inform the upstream interrupt controller
         (INTC) that it is part of the wake-up path,
      2. INTC is suspended, and calls device_set_wakeup_path() to inform
         the device core that it must be kept enabled,
      3. The system is woken by pressing a wake-up key.

  - After this commit:
      1. INTC is suspended, and is not aware it is part of the wake-up
         path, so it is disabled by the device core,
      2. gpio-keys is suspended, and calls enable_irq_wake() in vain,
      3. Pressing a wake-up key has no effect, as INTC is disabled, and
         the interrupt does not come through.

It looks like no device links are involved, as both gpio-keys and INTC have
no links.
Do you have a clue?

Thanks!

> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -538,7 +538,9 @@ static int __init of_platform_default_populate_init(void)
>         }
>
>         /* Populate everything else. */
> +       fw_devlink_pause();
>         of_platform_default_populate(NULL, NULL, NULL);
> +       fw_devlink_resume();
>
>         return 0;
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
