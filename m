Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3098936B8C8
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Apr 2021 20:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhDZSTG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Apr 2021 14:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbhDZSTF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Apr 2021 14:19:05 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061B2C061763
        for <linux-acpi@vger.kernel.org>; Mon, 26 Apr 2021 11:18:21 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e8so6143199ybq.11
        for <linux-acpi@vger.kernel.org>; Mon, 26 Apr 2021 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxk441iU0wp7QI5uSmMi84qyuJ4uphlRd2RFq20rb5g=;
        b=fCCr/nw130U0++Z0Ivdh5cPqDkXHWeQsmeWFwQD9nz4NkxrycmLKiQUAFXKoMFlqZx
         qDEMWDw0v/cbIc0a8goTHlmnrZB6Cn9RHhHgvTC4tYhqM+ZCvQ4MJFU+WNJCkJQnBEW9
         bsWQ+775cYJ0vHY8ed/UTIu5IqAqc4WiYqbvI+KLqgY/FdIGxj1oiJVUGM10BKBchfnI
         kyjf9HUzrbLvG6aI2ZJaPstOkNLsVtLlH7F5hzlfXPUJW3W0YFd8UpigyoHMjBIyaTqK
         F6s2oJeL1xEhoTLvtbYuIMWxtd/vCEbmbEv7s8sR3KPU8q9xHajibhc49Ror8dMvpOl9
         eRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxk441iU0wp7QI5uSmMi84qyuJ4uphlRd2RFq20rb5g=;
        b=TDAT0gQq3GI6rsv1EcY62nw1Zd6jwxtotu0bdBDz+Ye33O6VEWNW2QARxoBqiycLmU
         +MSbk5Yrpx6tJ3aiao/dVUJod9YZ2vcMNa5QDe7ZwdxB71uAaOmcwweOKitOpVBjwVkW
         g1OTfaHrShQt+0pA37jyWs9y/Ix1AQGxxOEKVm1zkasAY7eQKJr1CDn2y2TI8JhFy5aK
         +4VoDvZU0ybYPEwzCS5ZNDMwbmkfjU03SNZK9Yy0RqH/jybpJetkL7fHwUCHdqS04w7W
         DXC42l9UWn/XvYMWIwCm2vkuOrXl/g+iSdnUlK4kbxiKTqRs4Juyrj/HBa18y0nQMyGc
         ilNg==
X-Gm-Message-State: AOAM5327/5gnFmhMZGsK5pq4TMZYrGEWUa4pmY5FDsV03fTHvaZ//GmF
        /E2rPqe18+CRZIgf93dHIHMraf5jt+7K++9dNjuOMQ==
X-Google-Smtp-Source: ABdhPJxpKkzlxeFeOtzkL9KcfVeos0Z41kgtlmgxKrzK9GddPMejgPaMIQWIl+pLW3jEJCvWSVSH9ek3FFeVdL0Q7Q0=
X-Received: by 2002:a25:e7c8:: with SMTP id e191mr24243893ybh.153.1619461100801;
 Mon, 26 Apr 2021 11:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210426065618.588144-1-tudor.ambarus@microchip.com>
In-Reply-To: <20210426065618.588144-1-tudor.ambarus@microchip.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 26 Apr 2021 11:17:44 -0700
Message-ID: <CAGETcx9LgyX-D1E0bb-JW=G6TTvr-KC+1-733uWppzGZnYaoxg@mail.gmail.com>
Subject: Re: [PATCH v2] clk: Skip clk provider registration when np is NULL
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, nsaenz@kernel.org,
        maxime@cerno.tech, Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Guenter Roeck <linux@roeck-us.net>,
        guillaume.tucker@collabora.com,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetre
        e@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>, linux-rpi-kernel" 
        <linux-rpi-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Apr 25, 2021 at 11:56 PM Tudor Ambarus
<tudor.ambarus@microchip.com> wrote:
>
> commit 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
> revealed that clk/bcm/clk-raspberrypi.c driver calls
> devm_of_clk_add_hw_provider(), with a NULL dev->of_node, which resulted in a
> NULL pointer dereference in of_clk_add_hw_provider() when calling
> fwnode_dev_initialized().
>
> Returning 0 is reducing the if conditions in driver code and is being
> consistent with the CONFIG_OF=n inline stub that returns 0 when CONFIG_OF
> is disabled. The downside is that drivers will maybe register clkdev lookups
> when they don't need to and waste some memory.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
> Fixes: 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/removed")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

> v2:
> - s/return 0;/return; in void of_clk_del_provider()
> - add second fixes tag and Stephen's R-b tag
> The opinions on whether to return an error or zero were split. Returning 0
> and skipping the logic was considered safer as we don't know for sure if
> other drivers are affected. See:
> https://lore.kernel.org/lkml/d24bebc5-0f78-021f-293f-e58defa32531@samsung.com/
> https://lore.kernel.org/lkml/20210423171335.262316-1-tudor.ambarus@microchip.com/
>
>  drivers/clk/clk.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index a3b30f7de2ef..b47460b40d14 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4552,6 +4552,9 @@ int of_clk_add_provider(struct device_node *np,
>         struct of_clk_provider *cp;
>         int ret;
>
> +       if (!np)
> +               return 0;
> +
>         cp = kzalloc(sizeof(*cp), GFP_KERNEL);
>         if (!cp)
>                 return -ENOMEM;
> @@ -4591,6 +4594,9 @@ int of_clk_add_hw_provider(struct device_node *np,
>         struct of_clk_provider *cp;
>         int ret;
>
> +       if (!np)
> +               return 0;
> +
>         cp = kzalloc(sizeof(*cp), GFP_KERNEL);
>         if (!cp)
>                 return -ENOMEM;
> @@ -4688,6 +4694,9 @@ void of_clk_del_provider(struct device_node *np)
>  {
>         struct of_clk_provider *cp;
>
> +       if (!np)
> +               return;
> +
>         mutex_lock(&of_clk_mutex);
>         list_for_each_entry(cp, &of_clk_providers, link) {
>                 if (cp->node == np) {
> --
> 2.25.1
>
