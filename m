Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408BF4CFF19
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Mar 2022 13:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbiCGMtS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Mar 2022 07:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbiCGMtS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Mar 2022 07:49:18 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021BE3DA73
        for <linux-acpi@vger.kernel.org>; Mon,  7 Mar 2022 04:48:23 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id gb39so31638545ejc.1
        for <linux-acpi@vger.kernel.org>; Mon, 07 Mar 2022 04:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Dqjx6E61lpXMk4u4/xIAa8wjn4AVIxdHXjiXwxqPnE=;
        b=SdVPlGT53aJQdIYTgsflP5IBJI2j/2pfOWDjUv+0cy7ZahiqUXpLr8OGAc7yUnnnnL
         r+aeiHCwBGRUnkFpwmeRCASJE1W4/FcJc1WT0tX+7Lj1zcEVIvimgERYUdJ2S8xGFMSj
         ADC0RzaNafdx+okSCla1a38AIqootHTq0qD0YNktSs2b6h0jEFTPCSug5H6XMv/bYZGF
         IQ+6MtD8z27DEsu1KIYNmD7E6fuE2azlqG0dQRgT3LE95VSi6uLhL8bOrk3HGHTaR76/
         DKkMhOwXnhOHJcsNG5te57SIjYxGBcHk9o2rFNrWOXl/ZbjkecSoLBgRC1wpAzhzdPk/
         godQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Dqjx6E61lpXMk4u4/xIAa8wjn4AVIxdHXjiXwxqPnE=;
        b=08WaEnySQyEVHI8K8vjQt+2xbUJYZOOfw+gxPXQUCY/prPp4myHdSgrtNSOWf0w3tn
         ux72EqIY7+16zqSHENooB9iYc7PcR2195rbSvu63vMqtyPIYddsB/bqHcmk5yiZHjqM9
         Jl2FApykKtGcye8g0z6jMBghjybChb7t6nnAJsvcVppLSF+59Pt0lOKCV3GEBflluA/l
         grh7UotD54OXK1250kLxZwG26lZC+4KFmBLFkw+QXvWte4GwwUB5SSFmIjgN9ekzMYUz
         agcHZRj8tMN+Kk8rnJGLIX0HUNq2noBvpKmogzaQxUPHRH0ae30BgiWqQno49oQp1sxE
         ehPA==
X-Gm-Message-State: AOAM533qO/kGm0OnJQNFNzp3N3C4PEpuhM1i5xrj5L7KECkerRTkO9wa
        Bj57Gu1jLI8hRCbhp5RZrR96UnKcq272VoLoKwx/WhqCYMg=
X-Google-Smtp-Source: ABdhPJxLwvDZ+ME60I2VzVPFk32bFDOeNbdGBUEmCmgh7TYDxQWH6OvPtYIQOR2tTVQyWwrvKL8kBusBWs7QEN4npQg=
X-Received: by 2002:a17:907:728b:b0:6da:97db:b66d with SMTP id
 dt11-20020a170907728b00b006da97dbb66dmr8844403ejc.636.1646657301501; Mon, 07
 Mar 2022 04:48:21 -0800 (PST)
MIME-Version: 1.0
References: <20220307115623.37492-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220307115623.37492-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Mar 2022 13:48:10 +0100
Message-ID: <CAMRc=Md3_W49Wq5-zaxdNzELW87OogEN5wW6XQnF9aMpZrRvBA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: acpi: Convert ACPI value of debounce to microseconds
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 7, 2022 at 12:56 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It appears that GPIO ACPI library uses ACPI debounce values directly.
> However, the GPIO library APIs expect the debounce timeout to be in
> microseconds.
>
> Convert ACPI value of debounce to microseconds.
>
> While at it, document this detail where it is appropriate.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215664
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Fixes: 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-acpi.c |  6 ++++--
>  drivers/gpio/gpiolib.c      | 10 ++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index c0f6a25c3279..a5495ad31c9c 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -307,7 +307,8 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
>         if (IS_ERR(desc))
>                 return desc;
>
> -       ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout);
> +       /* ACPI uses hundredths of milliseconds units */
> +       ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout * 10);
>         if (ret)
>                 dev_warn(chip->parent,
>                          "Failed to set debounce-timeout for pin 0x%04X, err %d\n",
> @@ -1035,7 +1036,8 @@ int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int ind
>                         if (ret < 0)
>                                 return ret;
>
> -                       ret = gpio_set_debounce_timeout(desc, info.debounce);
> +                       /* ACPI uses hundredths of milliseconds units */
> +                       ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
>                         if (ret)
>                                 return ret;
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index f5e7443208d4..f956c533f218 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2223,6 +2223,16 @@ static int gpio_set_bias(struct gpio_desc *desc)
>         return gpio_set_config_with_argument_optional(desc, bias, arg);
>  }
>
> +/**
> + * gpio_set_debounce_timeout() - Set debounce timeout
> + * @desc:      GPIO descriptor to set the debounce timeout
> + * @debounce:  Debounce timeout in microseconds
> + *
> + * The function calls the certain GPIO driver to set debounce timeout
> + * in the hardware.
> + *
> + * Returns 0 on success, or negative error code otherwise.
> + */
>  int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
>  {
>         return gpio_set_config_with_argument_optional(desc,
> --
> 2.34.1
>

Do you have some more stuff coming up for fixes or do you want me to
queue it directly?

Bart
