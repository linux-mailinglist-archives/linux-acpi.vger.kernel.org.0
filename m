Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FB05B79CC
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Sep 2022 20:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiIMSkB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Sep 2022 14:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiIMSj1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Sep 2022 14:39:27 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0A26E2E3
        for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2022 11:08:07 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1278624b7c4so34368646fac.5
        for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2022 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LjK0fulvlnuvLTjKk4E4pqpGI0zifUwgFi6JRD+xi1s=;
        b=ag1hME6oKmg5TCKzS6jNswj3qklmDcrZ04qFJO5dWFAsGn8l1Y3qTSwXq5Yx1fucPz
         nmcQ+3uJi9tLtO49mzhRIZAaW0+dYV7eqq1Oo5mErNTYHZaabH+fYqoR2Wl14BsDyCqC
         4u7U7rT4w5MarvgyEO9u6vhS7AeusigkSSNTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LjK0fulvlnuvLTjKk4E4pqpGI0zifUwgFi6JRD+xi1s=;
        b=wD5qGKM//QkCEzDtoz4sJ+jO9gMbW4CK76ciHvanX3gLa2NDaK1Zn864FBzPrBv5Br
         lhmuN5hAFl5XnccKX8vH88V9I+hpxte0fRfjbIrrageCW7v1ERMCV7bHMEmojLf3tbvh
         m2MLxB8mRz+JpgMeTsp0LoCkrp5y5yK+BgODqnStCiE4k5ApXQ1BWdAgMUKCpa/IDJ+Z
         3oRGZZezXEpGMYKp2fmB8k6jqXs3jZx3WTZjesE55EeQnZao08bo9L4iK8c3P4gmP6f6
         gnWCycHoo8cvMvL5Ug/CN9dMjxbl7bQq5YOfDaPzim/uHg9RFfgMVegs6Ww32VgMAcoS
         ZI5A==
X-Gm-Message-State: ACgBeo3kAjlK7vQiz4dfPDCkzfewqZKc5paeqx+tCrQDLqTN19wZHduc
        kHtTApbTfK2nhvVRGgPNHt5woJIwCjXmOQ==
X-Google-Smtp-Source: AA6agR4NpwmZb1G2x6XX6vwOGiNaOmM/OhLvtkdTPsq2Nn0Pw4b1HoU3CEc//+QbaWgmqsKx8ZMLSg==
X-Received: by 2002:a05:6870:ea84:b0:10d:fabe:9202 with SMTP id s4-20020a056870ea8400b0010dfabe9202mr299930oap.294.1663092486627;
        Tue, 13 Sep 2022 11:08:06 -0700 (PDT)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com. [209.85.160.46])
        by smtp.gmail.com with ESMTPSA id bd22-20020a056870d79600b0011f390fdb0asm7402453oab.12.2022.09.13.11.08.04
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 11:08:05 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-127ba06d03fso34378136fac.3
        for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2022 11:08:04 -0700 (PDT)
X-Received: by 2002:a05:6871:808:b0:127:69af:9adf with SMTP id
 q8-20020a056871080800b0012769af9adfmr322361oap.120.1663092484148; Tue, 13 Sep
 2022 11:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220912221317.2775651-1-rrangel@chromium.org>
 <20220912160931.v2.7.I8af4282adc72eb9f247adcd03676a43893a020a6@changeid> <YyC9N62JaMGaeanf@smile.fi.intel.com>
In-Reply-To: <YyC9N62JaMGaeanf@smile.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 13 Sep 2022 12:07:53 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DAr_BwH03=bG9tfCSGW+-he-c-4PPeJMOqH28cVcKDoA@mail.gmail.com>
Message-ID: <CAHQZ30DAr_BwH03=bG9tfCSGW+-he-c-4PPeJMOqH28cVcKDoA@mail.gmail.com>
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

On Tue, Sep 13, 2022 at 11:26 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 12, 2022 at 04:13:11PM -0600, Raul E Rangel wrote:
> > Device tree already has a mechanism to pass the wake_irq. It does this
> > by looking for the wakeup-source property and setting the
> > I2C_CLIENT_WAKE flag. This CL adds the ACPI equivalent. It uses the
> > ACPI interrupt wake flag to determine if the interrupt can be used to
> > wake the system. Previously the i2c drivers had to make assumptions and
> > blindly enable the wake IRQ. This can cause spurious wake events. e.g.,
> > If there is a device with an Active Low interrupt and the device gets
> > powered off while suspending, the interrupt line will go low since it's
> > no longer powered and wakes the system. For this reason we should
> > respect the board designers wishes and honor the wake bit defined on the
> > interrupt.

>
> > +                     if (irq > 0 && acpi_wake_capable)
> > +                             client->flags |= I2C_CLIENT_WAKE;
>
> Why do we need a parameter and can't simply set this flag inside the callee?

Are you suggesting `i2c_acpi_get_irq` modify the `client->flags`? IMO
that's a little surprising since the I wouldn't expect a `get`
function to modify it's parameters. I'm fine implementing it if others
agree though.
