Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADF425F7B4
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 12:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgIGKTS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 06:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbgIGKTI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2020 06:19:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77400C061573;
        Mon,  7 Sep 2020 03:19:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 31so7809308pgy.13;
        Mon, 07 Sep 2020 03:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1O4Zn9P7hXV8yBwWw3nrL/yAlWgmCWvaLQgGvTWSTiU=;
        b=RYaB7CQHhLnCHtIJffl5L81Pte42BfwB7BEbyWq3Zxp50y0qtwg4iD+iFd708zJot+
         KbvxwnJJYgQWkw4kE+jQPlTUGoNkPq/tTc2ayTXC7ok4Es6v/kYXNRlK2islDzK+TnrR
         MeiU/4TJjGqeoY8pYLWMnqGemtQ9xOQB61GdgWRO+hucjohRzVTI41obIyg5vvD0011m
         hSFMWgCgqyacafyxsNcn2GwGSiZT4Y/yE69GTAsDhmVMiWYx8qYnVB53aVfXvJ/VAXSw
         dzHZJCbyBug2pJa0yQnpmBxztN2qscKjAqr7i9rZ6SAMRa0o9EbJn4iktsr3nDgJKIWt
         i95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1O4Zn9P7hXV8yBwWw3nrL/yAlWgmCWvaLQgGvTWSTiU=;
        b=WENYWQ+ewL3CsSDR5SpHF/czAkWKDLPzG9BmdT83gh1v7iG1rufC/EvJGOM6tcYvIz
         Pc9lS1BlImbB3eGEBtFiiMasp2HKsuJ7QxQoz0EtiAmdsBcMDbgOCPOkAQEfLqVDXpQ0
         +B7Mp3XucB1WXkSI2pmAqypYr0inKsajmLxPHW6eFEeAV01t3FoUHO2F6u0jxQxTCPRW
         hUMFPgK7TjtBWSfxVsvGvlR1yQ8XAr1PdVTlJQwN3uYYV5pLX+XLB7RcLIqjohso6faW
         XKBbiIUEfW++jcwuFmUn4Qy9Q0+kK6IlbGrbZmO49fygsoNwem22GLgH4ivFaeYuE9Kh
         uWSw==
X-Gm-Message-State: AOAM530Vb6nml23k73nzWX66xmcMpnOnE1VsXluRDoDkzNssO2dbsaf7
        36628BSta7OfRkCbBwkpnnaTXd+QTRMWZQRB/ImF85Xw+eUbpU3Q
X-Google-Smtp-Source: ABdhPJzAqpPT4aPR/aGiIlYWY2t/5OB6tUucV2i9E46bLc3PgE/QvkrTkvFrxNc99FCzS1QlriRnsR+hSVIQXLfM2t8=
X-Received: by 2002:a63:c543:: with SMTP id g3mr16545032pgd.203.1599473946680;
 Mon, 07 Sep 2020 03:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-4-brgl@bgdev.pl>
 <20200904163517.GW1891694@smile.fi.intel.com> <CAMpxmJWQsgV5WZrdPW3UUOVTEy1L6Y_rb7ThQK1QTRinmHSqWA@mail.gmail.com>
In-Reply-To: <CAMpxmJWQsgV5WZrdPW3UUOVTEy1L6Y_rb7ThQK1QTRinmHSqWA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Sep 2020 13:18:49 +0300
Message-ID: <CAHp75VdOWdwT-e5ufsZ8MEH=YtdBgm1=TDKn3f8fJxXY4YKh9A@mail.gmail.com>
Subject: Re: [PATCH 03/23] lib: uaccess: provide getline_from_user()
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 7, 2020 at 1:05 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> On Fri, Sep 4, 2020 at 6:35 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 04, 2020 at 05:45:27PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

> > Doesn't mm/util.c provides us something like this?
> > strndup_user()?
> >
>
> Yes, there's both strndup_user() as well as strncpy_from_user(). The
> problem is that they rely on the strings being NULL-terminated. This
> is not guaranteed for debugfs file_operations write callbacks. We need
> some helper that takes the minimum of bytes provided by userspace and
> the buffer size and figure out how many bytes to actually copy IMO.

Wouldn't this [1] approach work?

[1]: https://elixir.bootlin.com/linux/v5.9-rc3/source/arch/x86/kernel/cpu/mtrr/if.c#L93


-- 
With Best Regards,
Andy Shevchenko
