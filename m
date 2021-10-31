Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D07F441079
	for <lists+linux-acpi@lfdr.de>; Sun, 31 Oct 2021 20:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhJaTh5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 31 Oct 2021 15:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhJaTh4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 31 Oct 2021 15:37:56 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EA2C061570;
        Sun, 31 Oct 2021 12:35:24 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id k24so6639391ljg.3;
        Sun, 31 Oct 2021 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WuTpWz9YI/ddpcB1dJElXKYAQNO1y0xx5YwMMXQ8zB4=;
        b=Pu6LsxvwoeW4IWmkXZPI3htQ5RU307fzeXXBdkA/st4FtIFYUT322rSO6BIqPi2iSa
         ApGYvvS6vIZ1SdY8bwKll9+uLJsGZZ8QbvzErT0GN63Eosqt17iIPlawPqXDNpC9pmt0
         ASmNTaw2Cou50xti08CbbbRVgRpCSTap37FxMicOd4p7Rlo8AWAElg246Q8etF03YbhB
         0wTRsZIKQTy4BWr714hKowfEgJTvWMy7k5FrfoNuQxgr4Q2GErEALYIWaIdHFgydKe9X
         Gsg+bXXKUmerUOB+B3UTxEHkmUIHeGHDBIFdWN+NWS3148L80dZ2HDpz6+25b5vGY+Rl
         lxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WuTpWz9YI/ddpcB1dJElXKYAQNO1y0xx5YwMMXQ8zB4=;
        b=ML1ft2XcbI5Txl8Op0FGGKq3WqhCQNeZqyU6hAEj3/PAabG+mC0BlQmKGMZkCS+xq0
         D7zV9KelZgr3RybL0JC5BN2BRJ+WMDE8udvfNaZtZfbvgLt4dJBvq//kFksG7aNfoiSg
         L9p0e4iQ5ZpP/CDYm4FDOYKI9GaisE80zuwkt4qNMfbdSpfGV44DcRv1Qh4FtyDsNK9n
         nt1APKz7r7x4dUt1nWApeXxMhIXrBf9k4MkXz8R5nSgXA4WAUT+pRpStCv/zeJpTMaMA
         vF2UVLt/vxPxW5NbFEe8dJ1/zoCGS2m2v/9nzdl59TK/8o4RhW2LbTwTIZ510npIzQs7
         /ZqQ==
X-Gm-Message-State: AOAM531OT5kWFVRV2J1xZLJguLmV1Eq7X8swQjuCd9XU0JXb6yWpOYC1
        bj4jaN9UgHLWHPlULKR7MUohWo9weGWEyYRu7tw=
X-Google-Smtp-Source: ABdhPJyluf0XmpuQjyVpq9BPD0ZAx1H0Fr8Zn2ulDmXx2dA2cQ87nlK8Ig4JQ9NIu5hA4WMLNK/2exTHl25orvTBqL8=
X-Received: by 2002:a05:651c:b07:: with SMTP id b7mr26823391ljr.166.1635708922330;
 Sun, 31 Oct 2021 12:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211031152522.3911-1-hdegoede@redhat.com>
In-Reply-To: <20211031152522.3911-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 21:34:46 +0200
Message-ID: <CAHp75Vc6GO4e0_Qp6HfFtd_kbSakaMXsQN4oEPArdmMrxTFb7A@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply: bq27xxx: Fix kernel crash on IRQ
 handler register error
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Oct 31, 2021 at 5:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> When registering the IRQ handler fails, do not just return the error code,
> this will free the devm_kzalloc()-ed data struct while leaving the queued
> work queued and the registered power_supply registered with both of them
> now pointing to free-ed memory, resulting in various kernel crashes
> soon afterwards.
>
> Instead properly tear-down things on IRQ handler register errors.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 703df6c09795 ("power: bq27xxx_battery: Reorganize I2C into a module")
> Cc: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Fix devm_kzalloc()-ed type in the commit message
> ---
>  drivers/power/supply/bq27xxx_battery_i2c.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
> index 46f078350fd3..cf38cbfe13e9 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -187,7 +187,8 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>                         dev_err(&client->dev,
>                                 "Unable to register IRQ %d error %d\n",
>                                 client->irq, ret);
> -                       return ret;
> +                       bq27xxx_battery_teardown(di);
> +                       goto err_failed;
>                 }
>         }
>
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
