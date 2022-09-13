Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D0A5B770F
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Sep 2022 19:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiIMRBY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Sep 2022 13:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiIMRBD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Sep 2022 13:01:03 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EC98C033
        for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2022 08:52:06 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id c4so9983636iof.3
        for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2022 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=CGLCtRbWwRCAf6WmqGJBYksHAfnT5oX5xIBwMzUyvqg=;
        b=Gjb/1drlC0T1KT6qKQp+EOjvuce3jT3ddBuZmCIhUCD1JjfynIXluqq+ydAE0YYAmG
         p+5JnSpv26BEqUDuJzeFgV+cDv+pcrHfjXDLRRItnLSsP1xlI5YcJEZJ7pEhDX8zjIh3
         cRbSM6dRKjNE1AtZwiNsW22tXNeNU6ZbagvXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CGLCtRbWwRCAf6WmqGJBYksHAfnT5oX5xIBwMzUyvqg=;
        b=pqCX4DUDW6EUjIhlvqRi8uUd0AmoTQIfQy4n/4Dl9QxiFG2A3X5rEiPG7NG2y3AKfZ
         CKRWF13Y2DMVHiK+kodBXUaRBfjzxE0nht2DFF5C+ruS9ldgseQV2RY//vfPOpnPt4bE
         qkSPmc9HuUmHvNPPKM46fHXLftONaoGluvHp3SA7Z9yBsg3lrL9t4RQqMoQYegMl3COn
         2hDeYn8yynasiYGmvQANwSZ+kiWEJRFhwCqvqmGFFgDpTMJv0AmM7hDpd5iwarhaUDfe
         LvCtkT7etbMczAqC2MZETOUQ6hYNvtUQRhSkHRYiWRYEh+3zbBcTtz/UwEuPbq7+HGRu
         S5dQ==
X-Gm-Message-State: ACgBeo2i7EIVj+6P6LAK4jq9TNhVBZjcesM4oLEjF+9vwNignn+JqUOc
        0lPePr0bUuA3Y1qzJ+9ZOy3kbwoDraQYEQ==
X-Google-Smtp-Source: AA6agR40/qfLd3DJjJGXA79tniZ/5Z/RXjBlDRXvLmXIAfG9lOjoavKhkUvj+TD5jhBDhd6h+drWtg==
X-Received: by 2002:a02:9f8f:0:b0:35a:153f:e085 with SMTP id a15-20020a029f8f000000b0035a153fe085mr8451820jam.287.1663084322691;
        Tue, 13 Sep 2022 08:52:02 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id v8-20020a056602058800b006a10d068d39sm4893360iox.41.2022.09.13.08.52.00
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 08:52:00 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id y15so6468498ilq.4
        for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2022 08:52:00 -0700 (PDT)
X-Received: by 2002:a05:6e02:12a8:b0:2ea:f53a:2d06 with SMTP id
 f8-20020a056e0212a800b002eaf53a2d06mr12701463ilr.223.1663084320106; Tue, 13
 Sep 2022 08:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220912221317.2775651-1-rrangel@chromium.org>
 <20220912160931.v2.7.I8af4282adc72eb9f247adcd03676a43893a020a6@changeid> <YyAxBtAD2wL91quT@shikoro>
In-Reply-To: <YyAxBtAD2wL91quT@shikoro>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 13 Sep 2022 09:51:48 -0600
X-Gmail-Original-Message-ID: <CAHQZ30Dw8XvNyok-BJ=oQEROC+Z6hfK8D93YHS4v-KGZymNXZw@mail.gmail.com>
Message-ID: <CAHQZ30Dw8XvNyok-BJ=oQEROC+Z6hfK8D93YHS4v-KGZymNXZw@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] i2c: acpi: Use ACPI wake capability bit to set wake_irq
To:     Wolfram Sang <wsa@kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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

On Tue, Sep 13, 2022 at 1:28 AM Wolfram Sang <wsa@kernel.org> wrote:
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
> I'll let the I2C ACPI maintainers deal with the technical details
> because they are the experts here, yet one minor thing hits my eye:
>

> > +             irq_ctx.irq = acpi_dev_gpio_irq_get_wake(
> > +                     adev, 0, &irq_ctx.wake_capable);
>
> That line split looks weird with the open parens at the end of line 1.
>
Ah, looks like I missed `clang-format` on that line. I can fix it in
the next revision.

Thanks
