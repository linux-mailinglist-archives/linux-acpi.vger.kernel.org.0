Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658F632C431
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382321AbhCDALl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843054AbhCCKY7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2021 05:24:59 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EBDC0698D5
        for <linux-acpi@vger.kernel.org>; Wed,  3 Mar 2021 01:16:39 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id z11so35904763lfb.9
        for <linux-acpi@vger.kernel.org>; Wed, 03 Mar 2021 01:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buRZjTCkPRscNUcgouTsLvhNWylzQC2Vu2Jj2dnDvlY=;
        b=JanEXoUqmSxDacqDR+nKEc/kxryraHtUeHFnwycu6BONzCTOiWRBjALBiBwlfx5e78
         ZM4cbGNZDa80DIBjWjbZ2BTmh/bTfU/pztwWhDbOXCyuO5Inl7kwcij9ZURFHJn6dGoD
         UD6u/e6GJGukxlR4C+JGktCNDZNFhYJdJo+HsUD9jewcpNbVAwYRmV9TXTLefeLCaANA
         FA5vJsiIvKMa/cADkYmxpsh4aeA4oA4nDt98zTYblsM9ibdNDEdD4FamSm1JsFm98Eha
         3iVWyXyVIs5Cf9aq0+KyuHzX3J8Zv+J7qB2v9YJn8rfo7WOSw4qYG64AzrHWwI0RI4LT
         PsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buRZjTCkPRscNUcgouTsLvhNWylzQC2Vu2Jj2dnDvlY=;
        b=L81pn7GOF7vsAb3BCPafFmMYzRtoTzxjHbDR8G3Jt6CP2LgTPSazmiHbiCVMMxVJUR
         Gj/algf6CAYSmBcAzQsU/lXsO6Zz24cJFm8w8WrHrNpqvWH3p+xrt9qGniVyaEUmmAJl
         6UG/+vvlz2K0T+dPUXKaN06TaDjk8RQ9kccisTMZc7bYfmO71XbM/kvXzRtse6lrvtLl
         rEB6ajzeZCTEh7PLSCEbMXK/PqnlF35Z+PdDtGCgJLnr6cD6Vm88Uzf4nWtrOQ1G+L8S
         nfV8wiJu4l4gVVWDnGcm6VBjSAVX5TrW+RlckFtsT4cDAppYeILZwHTPG3geQ3VJR078
         Iueg==
X-Gm-Message-State: AOAM532OgkRmd6rv1ovG4VwZsGIk4cV5DsoGKH4+PW+kQ0kYxg79AzD/
        Kchdxa/hAF/YYTM9NIWHLK7TgbjCXOwcscMjhLbUvA==
X-Google-Smtp-Source: ABdhPJy9aRQHMyc4qKY1gO36BOHVs6AyUE+pwQt9Kzv2pXSSRggMKgV9EEBjNSTc07PFy8N4HS0999U1MZ6NLJp5Nn0=
X-Received: by 2002:ac2:5d21:: with SMTP id i1mr14044766lfb.649.1614762997648;
 Wed, 03 Mar 2021 01:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com> <20210302153451.50593-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210302153451.50593-3-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Mar 2021 10:16:26 +0100
Message-ID: <CACRpkdYX-CuSmNk1Yx24y15+R7q=UbXqdhgKKdeWa+dzy3wKgQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] gpiolib: Introduce acpi_gpio_dev_init() and call
 it from core
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 2, 2021 at 4:36 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> In the ACPI case we may use the firmware node in the similar way
> as it's done for OF case. We may use that fwnode for other purposes
> in the future.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
