Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8FC606184
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Oct 2022 15:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiJTNYT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Oct 2022 09:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiJTNX5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Oct 2022 09:23:57 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A49F1DED57
        for <linux-acpi@vger.kernel.org>; Thu, 20 Oct 2022 06:23:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b1so33527230lfs.7
        for <linux-acpi@vger.kernel.org>; Thu, 20 Oct 2022 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1/rQTj+F6iMjBXDfbMgUbbilI53wQ3z95Itk6dlN+G0=;
        b=TmkYGlOf4GCNJ81/OoLjk86+MxSeybTFWnt9z8rU+UDTpDh5LChJVRsmtJdRnC6MTr
         Bz56C3f0b8GV4FX3GH7R7BNUJ+9zrfCnmn1nUfM3LuNK/g3blm7yKkf8SMsBCwOUX4oG
         uHeO2dygaxJCKW38lYlf5S5tfkjXK064qBAZpNs9lj3mj8nGIDvwRgA+chFO55BmA7Qr
         VNfQj7ZzSeTfoDePm/yuLl+xgw197ugjKP2ByTunLcCgMrH2/08/J6m2Y6ENYnAJD92W
         +cj6GJqAJ9OEszgYa6EJd1WsQxaLoyUIfrK4g2/wPHXLppvWAhRJ/NoPCUcToqIp1uyh
         njoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/rQTj+F6iMjBXDfbMgUbbilI53wQ3z95Itk6dlN+G0=;
        b=BLdyZSapWOE1gLCjzsgIYEDD4hq1P5vOlhMj02IAp1/f38wVGvK1BIg7zJQFbXSCko
         NytdM4cdMR2NNNn6KWwQ5wV+kPEIy4LPC/ERl3XiOOC8aaUr4e2/paEnYY7r43PlELbz
         zm0xEaKllOqdCMrodJ4AjVUx3czNWch2ivbshZ44a0MyECQh0krxnJG38Wo72ypdXmHn
         /6bgXi7MLJqXPAM/fGcE5IXIIpR2yfnWM1XiYnwS0QgNA8UKQjQfhLQYObJsOf2BH9yo
         fVwuTk9DT8+g2WbVySxuZmbk5iPTK7/qOKskKncu1TAACWLiMvaX40gebr+gLJ5Q0kS5
         tK8w==
X-Gm-Message-State: ACrzQf3sxAxB00MZhvYr/GztR4SZasipv30LTo+caMh9/Zi9MT+9wpCz
        GZ0ELF5mA9cWoHXGMkWuGwzzps5imhj34PA2L7mtyQ==
X-Google-Smtp-Source: AMsMyM6Ejr3vZHIikug5ZYbRCT3sFKMcVE3OlPZrnfovttCzSJGQ5qM2X/aC+GBdbK1zeBROTMwZLG4mWMU1iq598kQ=
X-Received: by 2002:a05:6512:1188:b0:4a2:4d8f:74ce with SMTP id
 g8-20020a056512118800b004a24d8f74cemr4918670lfr.112.1666272219775; Thu, 20
 Oct 2022 06:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221020014426.188667-1-xiangyang3@huawei.com>
In-Reply-To: <20221020014426.188667-1-xiangyang3@huawei.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Oct 2022 15:23:27 +0200
Message-ID: <CAMRc=Md6nseghBwfiRCL0KQ1BJ0WE7MH9QENf=HdJdnC1Xz1Fg@mail.gmail.com>
Subject: Re: [PATCH -next] gpiolib: acpi: Use METHOD_NAME__AEI macro for acpi_walk_resources
To:     Xiang Yang <xiangyang3@huawei.com>
Cc:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 20, 2022 at 3:48 AM Xiang Yang <xiangyang3@huawei.com> wrote:
>
> Using the METHOD_NAME__AEI macro instead of using "_AEI" directly.
>
> Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index a7d2358736fe..064ba5150fd4 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -512,7 +512,7 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip *chip)
>         if (ACPI_FAILURE(status))
>                 return;
>
> -       acpi_walk_resources(handle, "_AEI",
> +       acpi_walk_resources(handle, METHOD_NAME__AEI,
>                             acpi_gpiochip_alloc_event, acpi_gpio);

This line dates back to 2018 so why -next in your PATCH tag?

That being said - patch applied (unless Andy wants to take it directly).

Bart

>
>         mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
> --
> 2.22.0
>
