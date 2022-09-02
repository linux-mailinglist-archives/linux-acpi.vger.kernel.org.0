Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5B5ABA63
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Sep 2022 23:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIBVze (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Sep 2022 17:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiIBVzd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Sep 2022 17:55:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B426D9F7
        for <linux-acpi@vger.kernel.org>; Fri,  2 Sep 2022 14:55:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u9so6364407ejy.5
        for <linux-acpi@vger.kernel.org>; Fri, 02 Sep 2022 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ecq3QiIvTsmZshGckaqCIPLzVvmOLA8FmTGWudNQTA0=;
        b=PedqGHFigr2YGOWASaF6IK1QRNXM7ZYMw1/SL2mOUzwsHaM9qTOtAkG489soN6gK6/
         Tf/Ic5ws5v2v6+gLHmHcgaQuY8Q9PDG/S4pPvo3SV/FbKtHQqEfwvgYGo61s/f3B38XN
         wXkXyjDFjYUwOKxAbkTmwn7yvIQPOBtWXP2YDocVnRzU+8GFEAgxiOUEz0ha+Lk9tPZo
         XDX8msVJH+kCxqH9XeiFVt8ub33KfaNL9zo3wOWq4lTe3dp78qBdfosHyXniIq889kie
         ZGPtD+lJEDDuhUcvcHu0C/47TiTTUTU7bCkDYTvwbKToTd64y0msrJmshFrTt1yWP6P1
         6/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ecq3QiIvTsmZshGckaqCIPLzVvmOLA8FmTGWudNQTA0=;
        b=0GjJ4ZM9f8vi5iZZuqQGAM8lvwbCdLjDM1KdpcB2C5yzZ8XReYpu/KvoIMMJYUDuj7
         AazWmqvXprO5az6MTISxjPS5uWBkHhVjo2Y45n0sINZ5qJ5lm+FlPeSBRMSjdhv18VWI
         eFlqUG9uDgEIrWxgQPiClG1evCU+H0Smp/86v6kYwolnUaZYTIzimrD6cLUmdcAC7Qlc
         AWHvu/CDnlj2wuRXaRvROxf+zQgQ03hBq1mL5pVQKW/J6CVt2hT0q/mnFwJXpk0pLGjA
         fVyRU4celhJVwA9cJ2UBa8N+ndgdxxHkjCcP5EvnDsODjl4FZdozBW7AoL5G2liZPt3k
         rEQg==
X-Gm-Message-State: ACgBeo3ht7Uzf8HEvf1EdIOTdJKdlgQFfAIMNHqEUqnubDb4gINQfVOa
        XlegR+fHxCAqfkWxe7JEW1BDV1AIyU1E53IP44t/1w==
X-Google-Smtp-Source: AA6agR45QkeSoBEZmUDyxCBa3vhjRQKSibpzgN/01XesHVGPtsB0vwRwtliEYYV0gW5NYkDniLcQKr/tSsNCysz1Dik=
X-Received: by 2002:a17:907:7242:b0:741:770b:dfc6 with SMTP id
 ds2-20020a170907724200b00741770bdfc6mr19731330ejc.203.1662155729809; Fri, 02
 Sep 2022 14:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220418141416.27529-1-asmaa@nvidia.com> <CH2PR12MB3895A1FB2977B725ED92AB57D7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdY1uK=73zpEM5zUyXacm5xaUUFYkuKMxi_q6vwmOPy6tw@mail.gmail.com>
 <CH2PR12MB389560A1873030472A7A371DD7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdZhW9XK3opXLLzdMiVLVkGQyJCf7RLZtRQLsmzv-aqwbA@mail.gmail.com>
 <CH2PR12MB38953FF57D91FA75AB9CB102D7CB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdbAhMa2CXvQra3E13n8WfiBxyHNqzEp4dW3qo5upr_=gw@mail.gmail.com>
 <CH2PR12MB38958CD365876A2106712C3CD7CF9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdZp9hx2SHxsmjBm2oj7m3UT-4S+MKw5qqNME0PLjPNV2A@mail.gmail.com> <CH2PR12MB3895B4E89237E6D6F635F252D77A9@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3895B4E89237E6D6F635F252D77A9@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 2 Sep 2022 23:55:17 +0200
Message-ID: <CACRpkdaHuQhzqqQbayGaRqYAcnyv2rmocX7YhcR_qj0HRVHkgQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Add driver for Mellanox BlueField-3 GPIO controller
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 2, 2022 at 5:55 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

> During testing, I use the sysfs to change the gpio value as follows:
> Cd /sys/class/gpio
> echo 480 > export
> When I do the export, I see that gpiochip_generic_request is being called which calls .gpio_request_enable = mlxbf_gpio_request_enable.

Yes but don't use the deprecated sysfs to test GPIO, use libgpiod
https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/

> Is this how it also works in other driver? Or am I missing something?

The gpio_chip usually works as a front end for pin control.

> I wanted to disallow muxing from user space.

If you ask for a GPIO then it will be muxed in if you implement
.gpio_request_enable().

If you want to make it impossible to use certain gpios alter
.valid_mask.

If you don't want people to use the sysfs ABI (which by the
way requires you to first select the "CONFIG_EXPERT"
option) then do not compile it into the kernel. It is a big
risk to use it in any case, so just don't.

If you use the character device (which is enabled by default),
you can set permissions on /dev/gpiochipN such that only
privileged users can access it, just like you protect any
other block/character device.

> I would like that to be controlled by the ACPI table only.

I don't know if it is possible to restrict GPIOs to just be
used from ACPI.

> For example, use devm_gpio_request from some other driver if needed.

If you only want other kernel consumers to use GPIOs,
the disable the sysfs ABI, and also disable the character
device, then only the kernel can use GPIOs.

Yours,
Linus Walleij
