Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B6432C430
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382341AbhCDALl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843065AbhCCKZM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2021 05:25:12 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55FCC0698D2
        for <linux-acpi@vger.kernel.org>; Wed,  3 Mar 2021 01:15:49 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id n16so19024390lfb.4
        for <linux-acpi@vger.kernel.org>; Wed, 03 Mar 2021 01:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sp36NWnrhLjOQm0Stkd4LZHThWDt7bH0sFAyGvv2U8I=;
        b=vWE9DEmxJVpajt4N0OeAIG4Ywd6F9yjGpG/Usi4bJAfS82H2VuZuwrnkRZ6T0NDQfB
         pZl0oKm1D6Z2tM/z2yRbdqL7iCZFJVZlrgA4IalEQTULXAw9RNSgSwRLEeV5gyvwR3Ea
         uDGSawz54h09NUHEWROgApheu51J7YhOVRs8f9rRAGHvm5ANyh+jZa6cE4KMEhKy0nm/
         3a8iCPs8IcuwdiK7HC+CNwuzWeeoxEjj/Lx5nSJE0St9dqiwhU4vpzCVixIvl6V9Wltw
         otlve2l05JPsjGMmY5r3lgm2mN4XLAy4kC7IzPIlbMcrNqAJqIs0/hEzz2KUyTuUgONi
         WSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sp36NWnrhLjOQm0Stkd4LZHThWDt7bH0sFAyGvv2U8I=;
        b=HQ8YD+Mi4v9xHm6xYv+eytOHH24zE7sGPnMWvrt13hl6mREWAm/hAo3CcW37Up9Lci
         pDd0TEHWuw2S4gDm2il/4SHfFavVe2T30B18qjme749cjNrg8xjulyz0Ae8TwZ4r/6FW
         2N39RmJPh9rA+Lt04XthawY7grhJGwoUk6e9+PpusGgOu2Jv2jmaJuQum3vAmhc9cMlh
         VLop9WNqHEUrYK7wJ/DBxe8+8r0gQ6yxTop/5dyofzl3KRp1zDFE3T0SfQFf/8c0gGwm
         FeFPUgeysWWTLgyckKwNEdWrrAv7PWjIaQHO5qv/1QfM7GlD5O2ibc1FgHDZb6c4ES3q
         0hKQ==
X-Gm-Message-State: AOAM533ms/1w6dwo77KeNZfV+Ra8QjQGqMcq2Ca6pUtm3v+Jg175qmoQ
        EKS5bSI/CxVMEiNUPv2bMQ/25VzfsvxqNwj7Lyb2gg==
X-Google-Smtp-Source: ABdhPJyQEF3Dg3TGmwCnQX8IQTX6FuafUjYFGINhQ2GjRDyLMrkwj4Lim0GfOkHxDuTA0bc0wFX+DNzDrPi0C9v3McM=
X-Received: by 2002:a05:6512:74a:: with SMTP id c10mr14912207lfs.586.1614762948094;
 Wed, 03 Mar 2021 01:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com> <20210302153451.50593-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210302153451.50593-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Mar 2021 10:15:37 +0100
Message-ID: <CACRpkdZ5G=YX3NX-xhmj5t_w0mqtcnrnR_cYhv04d_9Rzg=FFw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] gpiolib: Move of_node operations to gpiolib-of and
 correct fwnode use
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

On Tue, Mar 2, 2021 at 4:35 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The initial value of the OF node based on presence of parent, but
> at the same time this operation somehow appeared separately from others
> that handle the OF case. On the other hand there is no need to assign
> dev->fwnode in the OF case if code properly retrieves fwnode, i.e.
> via dev_fwnode() helper.
>
> Amend gpiolib.c and gpiolib-of.c code in order to group OF operations.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I parsed it in my head a few times and it looks like it will
end up working the same, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
