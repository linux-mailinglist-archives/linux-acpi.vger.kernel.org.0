Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E70482FC4
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jan 2022 11:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiACKHC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Jan 2022 05:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiACKHC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jan 2022 05:07:02 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4AC061761
        for <linux-acpi@vger.kernel.org>; Mon,  3 Jan 2022 02:07:01 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y22so134002062edq.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Jan 2022 02:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDDNrbo94yGf/mFPUSwm53ZPq2DtpQ/AKgaZuhvvG3E=;
        b=uDZejrRMI89xz8mKDplRD8+MVXUW3LjgL0hyxTBzUazxljJmOZBruVG81LZdhMVGWL
         bEJbh3791y8SEiOtnJd+rN5rtbJ5bR9huauO3s8vN5HoKNyAb5Ef2DCwCDFEmb0Kl40/
         Z5RwO0I5MV6Fa5I8rbm0VfogoOJWWy0sE4YBhl954dEhj6cQbGKA55tSV+ht3G8oSOpu
         8ZucOpJuro6X9/9zY8erAKIIYoBVT0agTTfCZLqWlLqFs8UPnf12iBQQJoQmU62vTwgH
         Q+XC6JthkDC4QEO7ZQUrUPZyM/WsNiQHmMS6j9a4Xtv8QxHJzDBMCaTGewIwrZnqQSh9
         gZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDDNrbo94yGf/mFPUSwm53ZPq2DtpQ/AKgaZuhvvG3E=;
        b=u1zHfGyJ9a4tJ8Q4q+mvkAiRygm3me+PPHg1jp7UWog+3S8JKqwLJdZrk7FdWdFdIQ
         /Th/kDs1J0ataujoYv29waOK2vtUahOhFuB8i/VTjJJwK1lZ8BnYtRgI1TCFOwyAjzpP
         IrrZ5t4ztkBI8kGQ2JmJ0umTS68hsMlNa4TJQbRYPFrVTxjeV5aGPVZp0KhhuUeKUKy3
         K/zSDe+06c8zzAWgdTOtizaPtyc1mf6MwJ7GmhhRElr+Z7AP3XYih7YfuNC/rVGVff6Y
         e6mGCPBz6ph3LZLYNdqynb6sLeKD+dIIoFsxPbsvcvrvIGmbndafGUW8JNRcIw91Z7i2
         0UnQ==
X-Gm-Message-State: AOAM531UQykNlft/Aop/W6taC4acRd3V685TCprPzzwLKH0pVeb4M+Ri
        yyZ9yFf0TD88TsyJmMx8DBFENi34qMtqXri+PHOLYg==
X-Google-Smtp-Source: ABdhPJxSo0bFqOkD1JphB5Ji1q1GKjtA/igTEwlGcc4AoWZL9cWg+AN1uhSA2irsbSx/M7ObRkZLjJZTp3a9i2hMJ/Q=
X-Received: by 2002:aa7:dd59:: with SMTP id o25mr43212393edw.288.1641204420348;
 Mon, 03 Jan 2022 02:07:00 -0800 (PST)
MIME-Version: 1.0
References: <20211223103809.12343-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211223103809.12343-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 3 Jan 2022 11:06:49 +0100
Message-ID: <CAMRc=McKS5CM-9ioQGVkEn4Oct6uxAiNKAm-y6S4FBOU3WDtVg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpiolib: acpi: make fwnode take precedence in
 struct gpio_chip
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 23, 2021 at 11:38 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> If the driver sets the fwnode in struct gpio_chip, let it take
> precedence over the parent's fwnode.
>
> This is a follow up to the commit 9126a738edc1 ("gpiolib: of: make
> fwnode take precedence in struct gpio_chip").
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied, thanks!

Bart
