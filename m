Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC8E32B445
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 06:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353103AbhCCE5d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384494AbhCBPFT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2021 10:05:19 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0F5C0611BC
        for <linux-acpi@vger.kernel.org>; Tue,  2 Mar 2021 06:50:07 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id m11so23397947lji.10
        for <linux-acpi@vger.kernel.org>; Tue, 02 Mar 2021 06:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hMgVPyqEroq6mUvpTnCafuO0NxGOj5n7scddeeUGCM=;
        b=Z75INBuEVQQ30cCskP0pcL89OTBkPhRoBvdarUf6+vsKOwOBP9QlM/TQfG6Cc6alkE
         JpZoVrrxpBJNFoeiVdFCDnh4ZfdZxKIskCJp3P2vza+yybgZnd43iTBFK0LiUe3CAzhY
         M92Gx1JjF6SDlFCaBt/5o9Kjxba+gWXyHL5lIwenfTwQtkYQOV9Ah8w0+9zF1APOM4Aa
         qSp+Zmgdo1KaA85gSv4GJGs51mPC4PHlf2UStbyWhTBChAcPejClzvudWaFAa7KwCnC1
         sFK8OYgNFhiCD+F/lRV9Af78WHcGx5hXGq642FTBHiuZNc4K7pMm2VeRhPV/T4nz29kh
         MyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hMgVPyqEroq6mUvpTnCafuO0NxGOj5n7scddeeUGCM=;
        b=lYrooJIbU1oaRWPNHxOW9mzMgF011qpOjysjhY75xUpsps/An1+tXaOvnJSZC/GJa9
         zTVE8N4EBru4WH7GXF8VhhZWvXO3VYonIhvWaP9i8k0FrBUXNHbINHNnMPDu/2HufBgA
         n1uIxIGSGP5C91sSBy7KposiMZL4PlYvLub7b9sAQETrRglh3t1C9Kjh+uRtV4KkLrm2
         ycDn7JfkXyOmmQCumXNrv6jmuvhz1MuzwlnwNhQtoQZVQQc6KossScbMO1MXS/wyKh9s
         LgEWMqrSqdeer12XyWp3Rfehsw4ino/FT70MYTi2jv8yXXm1d1ZY/wpuJvAKLQEzHvdg
         RPUQ==
X-Gm-Message-State: AOAM530TlmYjl5v8eCH33goEwqA8eOOiCOpB6pMvjMoL7s9Anc0QlvHl
        ZLYkke5NCIxGoaYVfNkWL4aW92eBzvDIFBOsOhyvzg==
X-Google-Smtp-Source: ABdhPJyeSH+nLIU1qBeIvU6FymMympjF4AlZp3ZZ1BPO3/f368e5ngNK7Lpx21W/uNz7ZyxV2F6ctnxj2hHUXtaqRzY=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr12397816ljc.368.1614696604877;
 Tue, 02 Mar 2021 06:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20210225163320.71267-1-andriy.shevchenko@linux.intel.com> <20210225163320.71267-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210225163320.71267-3-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 15:49:53 +0100
Message-ID: <CACRpkdZugk02ia2iq4uy1n=jMb0VKQ4v5xd6z7M9RCtjoAmmgg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] gpiolib: acpi: Allow to find GpioInt() resource by
 name and index
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 25, 2021 at 5:33 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Currently only search by index is supported. However, in some cases
> we might need to pass the quirks to the acpi_dev_gpio_irq_get().
>
> For this, split out acpi_dev_gpio_irq_get_by() and replace
> acpi_dev_gpio_irq_get() by calling above with NULL for name parameter.
>
> Fixes: ba8c90c61847 ("gpio: pca953x: Override IRQ for one of the expanders on Galileo Gen 2")
> Depends-on: 0ea683931adb ("gpio: dwapb: Convert driver to using the GPIO-lib-based IRQ-chip")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
