Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC77F2CA648
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 15:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391646AbgLAOtr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 09:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389488AbgLAOtr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2020 09:49:47 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07697C0613D6
        for <linux-acpi@vger.kernel.org>; Tue,  1 Dec 2020 06:49:06 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id jx16so4602992ejb.10
        for <linux-acpi@vger.kernel.org>; Tue, 01 Dec 2020 06:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQmiVxJd+Kl2UDX74aE8ZcT26AtGS/wklDJV5DWlb3M=;
        b=jwAPYMuzH8oNFpb2B3klwVMdsmIjlpPrDfYD0OKHi+ansmJ1xkPwf6DfJacdvGbEhh
         6WnHZBSNLKx7hcEJ2IPsIojFee9my/FoLbJlkNlz/NbhTV9jhkQn8ME8J7cdaryRPbo8
         lVhF5Ij3hgCndTWby3BXtKNErZ9FUeF2dUMjr7NkjYJHyTGXtXou+nSO17xVSXHUawJz
         8/bOnngSJaErW3NxFTeBTklslB6aQJ0/vTHSJRfjmDuGPnLEFkSvpufW90liCaX/o4QK
         2nbG3vny/XyoEpAtuaTbCZeWeZwxVQS0F+fr8h56vGWhO1g473rDd0lc0sFTO3XPtqru
         sIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQmiVxJd+Kl2UDX74aE8ZcT26AtGS/wklDJV5DWlb3M=;
        b=FZ69qjIoj1TWd/QLBy71aa9XLLY6qWRscyzDEy/BjgoX7XH3gtejmr9+wyJtcvUOxo
         lHmjHJ+OQ22Db8EoikeJRJ3VH20CKmJCJ2i6k0NKHFkWldzDyI36/6sPPntxqgMzo6M6
         4BukbghwYAGBPNb81bozlWq/duQ2LkXF2Yi3atA2oceqyYasFUQTHkHTWZJBozTRyGjK
         ugHwpQi4tHBmkS/bsAkxEx8kyj28Nu25Np/4ekva0GPOuMhQ0OiwsGE7mZR4rUZH3dzB
         Y+0EY6SoGHZQu5aT5MYCxW2iXmOe8Si86eWFOlaouarV4OShdyyq9z/NqxF6gtGR5Xav
         /5xQ==
X-Gm-Message-State: AOAM531ShJfzPGBbC36uKhZTiCtq7OcL/W5BKVvs+c4UHXZT41hkTyAg
        l3pH5rgBTCnwMBnJFJzJsLW1B5Dt838zy1rcVqfPHA==
X-Google-Smtp-Source: ABdhPJx/znI8GH1T3tz02M68wDeFcvy3SeGIIJVLF7bwXNUsXDKYkXpr1p5++qs6ZnNs6bz2c6CH7QTdAPo10EfXcyM=
X-Received: by 2002:a17:906:d8dc:: with SMTP id re28mr3382153ejb.168.1606834145234;
 Tue, 01 Dec 2020 06:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20201119170739.GA22665@embeddedor>
In-Reply-To: <20201119170739.GA22665@embeddedor>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 1 Dec 2020 15:48:54 +0100
Message-ID: <CAMpxmJXhy4wRNZWz0iqfB5=g5-F2cdE_q9hRcPr-zRxg9O-jDw@mail.gmail.com>
Subject: Re: [PATCH][next] gpiolib: acpi: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 19, 2020 at 6:07 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpio/gpiolib-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 6cc5f91bfe2e..e37a57d0a2f0 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -233,6 +233,7 @@ acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio, int polarity)
>                 default:
>                         break;
>                 }
> +               break;
>         default:
>                 break;
>         }
> --
> 2.27.0
>

Applied, thanks!

Bartosz
