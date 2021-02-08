Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1743E313841
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Feb 2021 16:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhBHPl0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 10:41:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233758AbhBHPjk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Feb 2021 10:39:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68DDF64E88;
        Mon,  8 Feb 2021 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612798739;
        bh=C034IrTVhQbEJ3ajlv6WrWRUJxx8ppxLnRBANxOdy/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r9jJGCr7R7RYEvSKD0hZSi3jCz2TF2ak9cxeLBc0NcajP5yDMbVVDR8Y3MJK0Ybt+
         XbG01QWnofikSLxL7rSQMT7PaVCM+D3xUxfkdk8EY+p5zmiI6NZclcNCOBFRHHwy7I
         d/zniqlCOOaqNAt/MxN7BlnotwcMKSrlquS7QHLuwo8zU0NmbWsLrX7fBkn64kXWa2
         pSq1q7cDjmcnXMOePwl/J8W4ebq1UyAa5y5+8+0Xvlll56Zv3Wd/alAGk5ydbSZfgi
         a41buJgmsI+2YFuVA3tWBcng7EbJaE3IuZ5OeudOU0MyHUeG7NjPh7Lu7hbU02yxfw
         CWn1NMAWRWtIA==
Received: by mail-qk1-f176.google.com with SMTP id l27so14725180qki.9;
        Mon, 08 Feb 2021 07:38:59 -0800 (PST)
X-Gm-Message-State: AOAM5320fQnblUl7oFMJebOepkd3sx5cqd0xxOYIMHfIfuRKWE6Cprrw
        I48edlOzrLmVtM9V5Fn/9EJXuH2f245G65LbGw==
X-Google-Smtp-Source: ABdhPJwUlbH9545MTd15G8WLEpDvOJelS15H4dOXXykl4felpUc4bGpib+NBOAQICuAM4jKRlXweB35IiC3gXZN0+r0=
X-Received: by 2002:a05:620a:22c5:: with SMTP id o5mr16753642qki.364.1612798738274;
 Mon, 08 Feb 2021 07:38:58 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com> <20210205222644.2357303-9-saravanak@google.com>
In-Reply-To: <20210205222644.2357303-9-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 8 Feb 2021 09:38:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJc8XRAL5Bj5LpH0M528K7ZL=wSqt8t=ibwjWutjCgB-Q@mail.gmail.com>
Message-ID: <CAL_JsqJc8XRAL5Bj5LpH0M528K7ZL=wSqt8t=ibwjWutjCgB-Q@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] clk: Mark fwnodes when their clock provider is added/removed
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 5, 2021 at 4:27 PM Saravana Kannan <saravanak@google.com> wrote:
>
> This allows fw_devlink to recognize clock provider drivers that don't
> use the device-driver model to initialize the device. fw_devlink will
> use this information to make sure consumers of such clock providers
> aren't indefinitely blocked from probing, waiting for the power domain
> device to appear and bind to a driver.

Don't we have cases that are a mixture? IOW, a subset of the clock
provider is initialized early, then the full driver takes over. You'd
want consumers that are not a driver to succeed, but drivers to defer
until the full driver is up.

>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/clk/clk.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 8c1d04db990d..27ff90eacb1f 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4555,6 +4555,8 @@ int of_clk_add_provider(struct device_node *np,
>         if (ret < 0)
>                 of_clk_del_provider(np);
>
> +       fwnode_dev_initialized(&np->fwnode, true);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_clk_add_provider);
> @@ -4672,6 +4674,7 @@ void of_clk_del_provider(struct device_node *np)
>         list_for_each_entry(cp, &of_clk_providers, link) {
>                 if (cp->node == np) {
>                         list_del(&cp->link);
> +                       fwnode_dev_initialized(&np->fwnode, false);
>                         of_node_put(cp->node);
>                         kfree(cp);
>                         break;
> --
> 2.30.0.478.g8a0d178c01-goog
>
