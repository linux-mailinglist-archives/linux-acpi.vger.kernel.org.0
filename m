Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683AF32B449
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 06:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353113AbhCCE5s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384606AbhCBPWn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2021 10:22:43 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7518C061224
        for <linux-acpi@vger.kernel.org>; Tue,  2 Mar 2021 06:48:55 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id q23so24254303lji.8
        for <linux-acpi@vger.kernel.org>; Tue, 02 Mar 2021 06:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFqgaXSqlQUQdPy3nY8PRtKYz9p0g0esCemDZNz6EmY=;
        b=fgwMUlhDupxFzSQVAdzZ2MamJBz7SFNsLGCfxSUbrDuDE8RnK9abPwY0MK5BYFz0cf
         C7wG0fAwq3JcAbCQE0w5Pw57fNibT4Q9i8Ebcl41yqoTSdbtsnveGZD7RWEwwlxGEPn4
         nikh/0chKEC3oA+CxAXJBOWRnHKRioT/wKveUVvyUCOpUBzgNlmhs/8LOG2jT78AwsWj
         1HW1RNZjr1FhXr9AQt9eoZJhQt/2/9QI43U23COktxAhYYt5A88aQuI9noST9sFM1PQG
         HxOHP56gjNA0pVDNl3t0l1NWFH77GvjWtXmy803148z99zvXMBIr0KwWgwniZBlHpdmg
         2mwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFqgaXSqlQUQdPy3nY8PRtKYz9p0g0esCemDZNz6EmY=;
        b=mK3bB8ueQylWnk97rEjJ0XglT+ubwaFcBSFClpaAV4mJUM/nWGVzZT9hZ+2mcLERIx
         AsnYm6dVwzMUokqCcL6sEkMCcj5fHNnbqiyvdaQwqpkzIc3MgesJTvonuwNukjPhjvrx
         F7wrZYhdQkqJdU1lNs0MNpwMs0fdmojqpN1KHiNIVLrYVXz+3zMeRjL1QCpMMfFR+3s5
         a8u41Wiu7HruUkY2CI6HW6FM2/PoHQjjdq9tZVM8qGYjU7Pcy8VqbyxsD9LxHoppxzm4
         bVR37oDTNLMqn7NimigsDhThsnWzD6OBal9TFTXCosMNbZsDQ6zsrN/GzP6ForUxOmCr
         +BsA==
X-Gm-Message-State: AOAM531+T65IkL1MODVYfNiYA/jBUF5Zu6+l3eHDAwOBTbfLTdKnWLqz
        AwCM3UcuSCLhVVWazekTNPUTKNkyUTgAAgf58GBGXA==
X-Google-Smtp-Source: ABdhPJxbxJWuTTRCgvRJT3XIAMjSeAKmqFJ3gfSSoP5sNHsmHmoMyaYsUaYNlfWERaagQf+eQpCP75td8ntOgunSOxk=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr12395110ljc.368.1614696534389;
 Tue, 02 Mar 2021 06:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20210225163320.71267-1-andriy.shevchenko@linux.intel.com> <20210225163320.71267-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210225163320.71267-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 15:48:43 +0100
Message-ID: <CACRpkdZj4TqOoJmfDhL1MuZCT9quz+5Gj8C6ckZ1i6cYCq9SOA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpiolib: acpi: Add ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk
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

> On some systems the ACPI tables has wrong pin number and instead of
> having a relative one it provides an absolute one in the global GPIO
> number space.
>
> Add ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk to cope with such cases.
>
> Fixes: ba8c90c61847 ("gpio: pca953x: Override IRQ for one of the expanders on Galileo Gen 2")
> Depends-on: 0ea683931adb ("gpio: dwapb: Convert driver to using the GPIO-lib-based IRQ-chip")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

OH THE HORROR!
However, we discussed it before. It is as it is.

It's the right place to fix the problem, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
