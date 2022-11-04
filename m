Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAEF619C16
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Nov 2022 16:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiKDPu0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Nov 2022 11:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKDPuY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Nov 2022 11:50:24 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D6D2D763
        for <linux-acpi@vger.kernel.org>; Fri,  4 Nov 2022 08:50:20 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id f68so2647723vkc.8
        for <linux-acpi@vger.kernel.org>; Fri, 04 Nov 2022 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=++mWirKgGkrCI+vm0xRouCpwLdjdutJmLOYC+ZHZYHc=;
        b=6qu4jPdvOOCYWJY2tYYGANBMsSd7/CxYS5H1o7QbPvAsTaD3mee0pz6cbfCWiGZ4Aq
         H9LlODO3kFJlFVAJT7CWMU+Yqj+4/FmxVqbGf9Bg7iS7e2P92JECKKHtE261i6ZEtTCz
         FIQOzDnp3SYTBW5oLsXtc6+zxZtUH7pborqIMlysstix1rAvqjU2uv6o+VflrvL4Rjj4
         8mAa0BWA2okqYafMVrqVg84kcgiwkwcXcFlRYAFhq9TL0un+hAvb/jL9UqK7ynx2ocpb
         TycWbahuCCIotdBs9kjuDTSC/+C7WLjP9lultacC5wEX+N88cMxMlPEGDydWN0KDNXJJ
         e+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++mWirKgGkrCI+vm0xRouCpwLdjdutJmLOYC+ZHZYHc=;
        b=xQyKnijaNgTMlmqKAPnN8OQ/k5ngHTpEdq+3Wp3MoLHyK8QL4LyYm38gpx3yTxISBX
         KNY4I02MEhQNtiC9iPratPsEhXHFOS6PY3zMM3uUF2fkWLNtngQZe5eHBAbaWb2usuFk
         qMzZpJfeFM7wyC+a7ovDHRYqv9XCLYkzB9hTcDHjH7L7xE8yAOZk/Zshr+oP4QFXo4M8
         QJDTv0FULpzykYSX9qMMCouBqiqZuD4aSFxuJwutrVwE/Pz7QzZ8apXDn/IJwu09+rPu
         7adEdgRFc6plySwl9bduLbqQJWJ94vmTXjVXrJ4pbqvJTd3Eo1VTNUF6dhMRU7FbSr3X
         Hi8Q==
X-Gm-Message-State: ACrzQf28mM5bo/6OHY7g/gw40B+LO/sJxcdQDptF53ZzHgkBLoPCNmB1
        F5iEuRG+gFcyqSpD+7EwYfEgGY7qnA5sfwWp8pmY9g==
X-Google-Smtp-Source: AMsMyM4h4K63MwrVrCDVB/AEOjRx4mKVdTi14OodmNPYWW8xwyK/6GeLFp4IWp8SkZBgNFadF7b0idAIkTNXuDaCmn8=
X-Received: by 2002:a05:6122:92a:b0:3b8:ae77:6927 with SMTP id
 j42-20020a056122092a00b003b8ae776927mr1331401vka.33.1667577019933; Fri, 04
 Nov 2022 08:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
In-Reply-To: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 4 Nov 2022 16:50:09 +0100
Message-ID: <CAMRc=McPxk_SPybakAsfJB0RRjSSByEbPY+rk=M63b+i3pBnuA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add support for software nodes to gpiolib
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 4, 2022 at 7:10 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> This series attempts to add support for software nodes to gpiolib, using
> software node references. This allows us to convert more drivers to the
> generic device properties and drop support for custom platform data.
>
> To describe a GPIO via software nodes we can create the following data
> items:
>
> /* Node representing the GPIO controller/GPIO bank */
> static const struct software_node gpio_bank_b_node = {
>         .name = "B",
> };
>
> /*
>  * Properties that will be assigned to a software node assigned to
>  * the devicei that used platform data.
>  */
> static const struct property_entry simone_key_enter_props[] = {
>         PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
>         PROPERTY_ENTRY_STRING("label", "enter"),
>         PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
>         { }
> };
>
> The code in gpiolib handling software nodes uses the name in the
> software node representing GPIO controller to locate the actual instance
> of GPIO controller.
>
> Note that kbuild robot is likely to complain about this patchset because
> it depends on patches removing [devm_]gpiod_get_from_of_node() and
> devm_fwnode_get_[index_]gpiod_from_child() APIs that are still pending.
> I pushed them to
>
> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tmp-gpiolib
>
> for your reference.
>
> To: Linus Walleij <linus.walleij@linaro.org>
> To: Bartosz Golaszewski <brgl@bgdev.pl>
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
>
> ---
> Dmitry Torokhov (6):
>       gpiolib: of: change of_find_gpio() to accept device node
>       gpiolib: acpi: change acpi_find_gpio() to accept firmware node
>       gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes
>       gpiolib: acpi: avoid leaking ACPI details into upper gpiolib layers
>       gpiolib: consolidate GPIO lookups
>       gpiolib: add support for software nodes
>
>  drivers/gpio/Makefile         |   1 +
>  drivers/gpio/gpiolib-acpi.c   | 132 +++++++++++++----------
>  drivers/gpio/gpiolib-acpi.h   |  54 +---------
>  drivers/gpio/gpiolib-of.c     |  52 +--------
>  drivers/gpio/gpiolib-of.h     |  16 +--
>  drivers/gpio/gpiolib-swnode.c | 106 +++++++++++++++++++
>  drivers/gpio/gpiolib-swnode.h |  13 +++
>  drivers/gpio/gpiolib.c        | 239 ++++++++++++++++++++----------------------
>  8 files changed, 316 insertions(+), 297 deletions(-)
> ---
> base-commit: dc04f5ab1b1114aa19b9026f816fc01ca9c9941d
> change-id: 20221031-gpiolib-swnode-948203f49b23
>
> --
> Dmitry
>

This is great work. I'll wait for Andy to Ack the ACPI patches and
let's get it in.

Bartosz
