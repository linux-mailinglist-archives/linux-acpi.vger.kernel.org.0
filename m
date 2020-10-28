Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EFF29D2E9
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Oct 2020 22:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgJ1Vhu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 17:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgJ1Vhl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Oct 2020 17:37:41 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23490C0613D1
        for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2020 14:37:40 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c72so1088365oig.9
        for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2020 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khsXwY2FOIak2E0IL9IWqYVg7gg6o/TiC9wESQ4lpvE=;
        b=nvCl8sKwfy5MaflP71vCYy5uZwYIEw6hBOTPLMirYPIM9coKxLjYxUttQyjPrhGAW3
         wIYGldGZNGcC8gHmdV+ZWm/IqohhKrnRpZPcrTxQRcVfK0TKBfDHIMVWxU6FFW1n+y4V
         jYFhtScOr2Uz8IHzxFnLUdzAeKgHTM5DbPgfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khsXwY2FOIak2E0IL9IWqYVg7gg6o/TiC9wESQ4lpvE=;
        b=ISZCJezm78NHg2cFDjr/bEIJwts14PhWhRVk3GsRuTIuCrjmyIkXtqqbUzqG2/PfiU
         zLsAMp6bRBGDcadUMlzfvGLeLTh1u82ORaZWr8ac/Hy7cO/ZOc9d55BavAKxRtXWyKh0
         ycvLVQB2IBwTVd76Uqpy7wKV0piUFMzwlRzZulTWCqspQLcRvBx9Fe4K6ET+KAuL6wj0
         /TXfOIitWVcRhv7F11q00dh3za4TywKwJienfvxigQF15mNejnIW1nT7OGGGgAX+L9Lm
         QY03r4mvnHy6+vxiRpj8dQunVDBS0pWMLRimb/TqXkgD0pBKEOtf2kgP2b/+wUDsj7mA
         uRYw==
X-Gm-Message-State: AOAM5329WYizkChDq64PulPkyY5Uv/oiHAy2lvL9niPBAxevyr8sDwbL
        rAY3PR8ppcjRz20Vz9FBmgzumL89mMOehWlM5PI=
X-Google-Smtp-Source: ABdhPJz84vGRzdsJvW6wA4/9B5sIOjrlmy6UIlNR4rU/QNAuYRFqmd8eIpxB8hDU2JNLqHTWiC3HOA==
X-Received: by 2002:aca:d54c:: with SMTP id m73mr660598oig.94.1603919454988;
        Wed, 28 Oct 2020 14:10:54 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id h135sm178574oib.23.2020.10.28.14.10.54
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 14:10:54 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id y186so1051217oia.3
        for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2020 14:10:54 -0700 (PDT)
X-Received: by 2002:a05:6808:602:: with SMTP id y2mr686737oih.11.1603919453681;
 Wed, 28 Oct 2020 14:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com> <20201028205101.47583-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201028205101.47583-2-andriy.shevchenko@linux.intel.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 28 Oct 2020 22:10:42 +0100
X-Gmail-Original-Message-ID: <CANiDSCtRDwfFo9HE84iujjFe6h9aS6b3B8wkz5Rt0aO8=XMsNg@mail.gmail.com>
Message-ID: <CANiDSCtRDwfFo9HE84iujjFe6h9aS6b3B8wkz5Rt0aO8=XMsNg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] Documentation: firmware-guide: gpio-properties:
 active_low only for GpioIo()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy

Thanks for your patch and super fast response.

I think there are two different concepts here:

1) when the pin has a low value, it is  0 or a 1? =>active_low

2) when do I get an irq, low->high or high->low => irq polarity

When I read the acpi spec for GpioInt()
https://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf page
934, it has the same problem as for GpioIo(), it does not express the
active_low and this is where the _DSD field comes handy.

Without using the active_low, how can we describe  a pin that is
active low and has to trigger an irq on both edges?

Thanks again


On Wed, Oct 28, 2020 at 9:51 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It appears that people may misinterpret active_low field in _DSD
> for GpioInt() resource. Add a paragraph to clarify this.
>
> Reported-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/firmware-guide/acpi/gpio-properties.rst | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
> index e6e65ceb2ca1..370fe46c6af9 100644
> --- a/Documentation/firmware-guide/acpi/gpio-properties.rst
> +++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
> @@ -55,6 +55,9 @@ Since ACPI GpioIo() resource does not have a field saying whether it is
>  active low or high, the "active_low" argument can be used here.  Setting
>  it to 1 marks the GPIO as active low.
>
> +Note, active_low in _DSD does not make sense for GpioInt() resource and
> +must be 0. GpioInt() resource has its own means of defining it.
> +
>  In our Bluetooth example the "reset-gpios" refers to the second GpioIo()
>  resource, second pin in that resource with the GPIO number of 31.
>
> --
> 2.28.0
>


-- 
Ricardo Ribalda
