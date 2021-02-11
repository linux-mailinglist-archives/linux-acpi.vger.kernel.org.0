Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904FD318B9C
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Feb 2021 14:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhBKNJZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Feb 2021 08:09:25 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:40210 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhBKNGj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2021 08:06:39 -0500
Received: by mail-oi1-f182.google.com with SMTP id 18so5950414oiz.7;
        Thu, 11 Feb 2021 05:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xObaF1XR6HJKRkZuGgQPbLa0Xlc9E/4S3iOJ2jtrHq4=;
        b=gsyputBnbCOygMxEmMz4Vq2cKt/ZqBRtF4q+V0vWouxbYNSHuTa8mJn9Vt8l6XwNjc
         D2AP1S50QQQFkm2LCKGB+BU9IhklczhBGMI+dRoPmT+L7bDhlX6Pe/EOE0zR4hdUC0jj
         X0aS86sm1XXlkG3fqNwPJH8pHLaO8DuKfUzWOr3GtrNJ/RidR8FpnF6fn7BWNJUwlNQx
         gfxlJhPirM+afOHG0+EYcr+YdbANDNfGxhxE6TDMBHRAp4P6GJfMyMH4dIT8ySAmywAJ
         zXzbfj8JItbNGfeJxhyIjkUui+x41IQpm/ggmNd9xhk4joOi6fI6bGfbR+eeyllSxdk5
         hZjQ==
X-Gm-Message-State: AOAM53311PRJu4hTHpT9GlyIv+GNJFC/mGZpVTbGCZj2vQtTUTzEm/eM
        uxEgpVQT1Rm9U+wgKjzv3/Hjp7GiWb30LsuMsgfJc+qW
X-Google-Smtp-Source: ABdhPJzwYtQCs4VAB8ju7w94RZlUjgs0rmPh9eN3vSDuKS9kLskA4ogyi1srA8z4N9XHP/Hjkill3F4k3WedUrRufNU=
X-Received: by 2002:a54:4e88:: with SMTP id c8mr2600538oiy.148.1613048757267;
 Thu, 11 Feb 2021 05:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com> <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com>
In-Reply-To: <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Feb 2021 14:05:45 +0100
Message-ID: <CAMuHMdUZ1DsWycqreuvDN-bs+ZKJw9Dj6bsUfG0NzuM9LrBuig@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Make fw_devlink=on more forgiving
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
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Saravana,

On Thu, Feb 11, 2021 at 2:00 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>       - Disabling CONFIG_RCAR_DMAC works for most devices, except for
>         sound:

Please ignore.  DMA is mandatory for sound, and thus fails in the same
way on v5.11-rc5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
