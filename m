Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB40D2E91A8
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 09:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbhADITg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 03:19:36 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:38121 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbhADITf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 03:19:35 -0500
Received: by mail-oi1-f178.google.com with SMTP id x13so31352566oic.5;
        Mon, 04 Jan 2021 00:19:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMBiuedOOMmuXN5p23LzuCrx9oYV8zreF8EiRpvTu20=;
        b=CmPU8/tK9WaGzSp7WZfijGuD/L4y/b5JLjISEA2+j8S2w+TKc0lxYZOhMun4B+0kxL
         uwsyz4U4ku/ba889kW+eTXAlagFHA48Q7oxTgUtkbhtpivyAHKXyO2QjwRxWwqWMv0y0
         +JZrIPAlN1zVzNV9pjen/xNgj6Cesh4Ylr+5sI7np33oDsrpvdgjyUwQ88Wnn+Dq6G1c
         FRSCcVVTdpb9cMUDHOk4URAZxINpX4XCMl2bwUiTH6e3kYxE/ef2v/kp3p6FGZVjIAxd
         kmsBM+M+dn3383RTmPPuf/MOQS2rPMCeJDscCDXtogdCoqK83bhhwUP7n+EfgB7qvwP4
         PS8Q==
X-Gm-Message-State: AOAM532iMf1a44Cx/6VMsDcsS1CYDsFxZOBtphLWoFSCNgb1yrbAmzSh
        OTsHKSertPCPlGSrUSbkB7XNZdkI9zwU0kmIlaE=
X-Google-Smtp-Source: ABdhPJw1ZOaTYVHBloO8Pcssm2LM7Af99V6DZ54pWqVH/AwulrzQyS7V6fcrgUwHfui2oKcs/Xug060l9zJMQ/biQbw=
X-Received: by 2002:aca:4b16:: with SMTP id y22mr17093210oia.148.1609748334576;
 Mon, 04 Jan 2021 00:18:54 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gN3NfWyAHA7At=1ZG90vCJbDoUzF5ts2_t3GmunSbrMQ@mail.gmail.com>
 <20201230153744.15612-1-daniel.lezcano@linaro.org>
In-Reply-To: <20201230153744.15612-1-daniel.lezcano@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Jan 2021 09:18:43 +0100
Message-ID: <CAMuHMdXCn-tKcaeAHTgdJu0Lg=YrF7cFnW8-tD4ZBfVPUb53NA@mail.gmail.com>
Subject: Re: [PATCH] powercap/drivers/dtpm: Fix __udivdi3 and __aeabi_uldivmod
 unresolved symbols
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

On Wed, Dec 30, 2020 at 4:39 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> 32 bits architectures do not support u64 division, so the macro
> DIV_ROUND_CLOSEST is not adequate as the compiler will replace the
> call to an unexisting function for the platform, leading to an
> unresolved symbols.
>
> Fix this by using the compatible macros:
>
> DIV64_U64_ROUND_CLOSEST and DIV_ROUND_CLOSEST_ULL.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for your patch!

> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -99,8 +99,8 @@ static void __dtpm_rebalance_weight(struct dtpm *dtpm)
>                 pr_debug("Setting weight '%d' for '%s'\n",
>                          child->weight, child->zone.name);
>
> -               child->weight = DIV_ROUND_CLOSEST(child->power_max * 1024,
> -                                                 dtpm->power_max);
> +               child->weight = DIV64_U64_ROUND_CLOSEST(
> +                       child->power_max * 1024, dtpm->power_max);

Note that 64-by-64 divisions are expensive on 32-bit platforms.

Does dtpm.power_max need to be u64?
The (lack of) documentation for the dtpm structure does not say what is
being stored there.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
