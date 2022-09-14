Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318EF5B8EEA
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Sep 2022 20:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiINSdi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Sep 2022 14:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiINSdf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2022 14:33:35 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE3E77563
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2022 11:33:33 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id i7so4045682ioa.5
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2022 11:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vSj623uSHxO0oVI/Q9wO/OKZArt2x1BaVoPyjdenhVw=;
        b=be+8kTLNJULJ2PK8PDlYNxkvOH9mMmtB2rahv3H4TKnEDphAAkmXCOE/IJeod6Hn7s
         5bfrqzY55uo+WMDgfUuRTLnl3LQV0KqxaKo9Hoaec6URvxcr4+Uuej3n9eNHdHp4OrQy
         hhupSd3M3qkMCC7pUEhaLICCpyPOIsfS/nENA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vSj623uSHxO0oVI/Q9wO/OKZArt2x1BaVoPyjdenhVw=;
        b=ur3+nbGfpA4Ot9/qHhs8CDu3EWisIY7HO9a4Eycvq+aabRWCRFNc60dt/qj/GhowW3
         xpo3sdwI/hPFE0dMa3ECfFITUaCOxvot5csWAHycTwjGtGnv3zNkTBvFRP/KrmYFbzp2
         Fm2NFjVqonAgHKAE/s0lIBL/PNVtotBz+HQ3vDYOc9zXI76XsjMY7RH27nV7tnnkqRDK
         poeTOb/gmdRHRrentz9d9xnrQMQTnX/WCxBvZ7KodRPobqrVNTXJf3N4pdhpN1qL6OOG
         0zjMQotuKEGJ7ZoB+IZVFoKYKMvU2hIpeU9X9Ueb78Sp3SA3u6gPPn+675liUkjmDt5l
         /rHQ==
X-Gm-Message-State: ACgBeo3poCzHmdk+eCBcD9u+1Mnd3OE7emfwuHPthhRyzz5oqNe8hWiY
        TeG1QHJoLWXqY4HKqcYNNCDXEoPWu1yCnQ==
X-Google-Smtp-Source: AA6agR5+v33N+tELv06TBrYzbefRcUG1+QhD2qVDoMSDBA8E46XvlgRyxycDFRwB+fTe0lZQ89d9mA==
X-Received: by 2002:a05:6638:2496:b0:35a:36ca:b188 with SMTP id x22-20020a056638249600b0035a36cab188mr8165609jat.257.1663180412139;
        Wed, 14 Sep 2022 11:33:32 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id h10-20020a056602154a00b006a0d4a46588sm2064933iow.49.2022.09.14.11.33.29
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 11:33:30 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id l6so8431043ilk.13
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2022 11:33:29 -0700 (PDT)
X-Received: by 2002:a05:6e02:2189:b0:2f1:92d4:6b22 with SMTP id
 j9-20020a056e02218900b002f192d46b22mr14224475ila.210.1663180409089; Wed, 14
 Sep 2022 11:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220912221317.2775651-1-rrangel@chromium.org>
 <20220912160931.v2.7.I8af4282adc72eb9f247adcd03676a43893a020a6@changeid>
 <YyC9N62JaMGaeanf@smile.fi.intel.com> <CAHQZ30DAr_BwH03=bG9tfCSGW+-he-c-4PPeJMOqH28cVcKDoA@mail.gmail.com>
 <YyDNAw+ur177ayY0@smile.fi.intel.com> <CAHQZ30DP1asiMj7hoebQQvGqE36sBDjaFmp3ju3eUEF1PruFeg@mail.gmail.com>
 <YyGh6Yjbb/5rkh35@smile.fi.intel.com>
In-Reply-To: <YyGh6Yjbb/5rkh35@smile.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 14 Sep 2022 12:33:17 -0600
X-Gmail-Original-Message-ID: <CAHQZ30Dsk2ikhctYSk_eP=1qcOOn_tjgtCftPOqQFkHNfQwBsg@mail.gmail.com>
Message-ID: <CAHQZ30Dsk2ikhctYSk_eP=1qcOOn_tjgtCftPOqQFkHNfQwBsg@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] i2c: acpi: Use ACPI wake capability bit to set wake_irq
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>,
        "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> > > This is similar to what of_i2c_get_board_info() does, no?
> > > Note: _get_ there.
> >
> > `*info` is an out parameter in that case. Ideally I would have
> > `i2c_acpi_get_irq`, `acpi_dev_gpio_irq_get_wake`,
> > `platform_get_irq_optional`, and `i2c_dev_irq_from_resources` all
> > return a `struct irq_info {int irq; bool wake_capable;}`. This would
> > be a larger change though.
>
> Seems the ACPI analogue is i2c_acpi_fill_info(). Can we do it there?
>

So I originally had that thought, but decided against it to avoid
changing too many things,
but since you brought it up, I thought I would try it.

So I moved the GPIO lookup into `i2c_acpi_do_lookup`, but it failed
spectacularly.
I've linked some logs of both cases. grep for `RX:` to see my logging messages.

* https://0paste.com/393416 - Logs with IRQ lookup happening in
`i2c_acpi_do_lookup`
    * We can see that `i2c_acpi_do_lookup` gets called in three cases
         1) Early on from i2c_acpi_notify when the I2C ACPI nodes are
first created
         2) From `i2c_dw_adjust_bus_speed` as part of `dw_i2c_plat_probe`
         3) From `i2c_register_adapter` as part of `i2c_dw_probe_master`.
    * What happens is that all of these calls happen before the GPIO
chip has been registered.
      This means that `acpi_dev_gpio_irq_get` will return `-EPROBE_DEFER`. This
      messes something up in the i2c init sequence and the devices are never
      probed again.
    * You can see the `amd gpio driver loaded` message after all the
i2c probing.
* https://0paste.com/393420 - Logs of a normal boot
    * Here we can see the GPIO controller registers early
    * We can see the i2c devices being probed by `__driver_attach_async_helper`.
      I'm guessing the device was enqueued as part of `i2c_acpi_register_device`
      early on and it gets probed later.

I could try moving the gpio lookup into `i2c_acpi_get_info`, but I
think that suffers from the
same problem, the stack can't handle a PROBE_DEFER. So I think we need to keep
the lookup in `i2c_device_probe` for the PROBE_DEFER logic to work correctly.
