Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491D1797752
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbjIGQYP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243915AbjIGQXS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:23:18 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7176CAD31
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 09:09:38 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bca3311b4fso853659a34.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694102912; x=1694707712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdWsNUufxYU54d2v+3Wxi5MrfQGJIJLOBq5vhtohyVg=;
        b=A0FXsS5tc9ujhlyqLEtxTl9HZi06rI7A3vlo/M6gN9dEofwcGYt9MVE3OJvHkBoatC
         0EDqcvgZv4jwlzBm5L6UjcWvZvcl+r/TADq93uhqeX/ZbLwdgcAQA/1JMNlpvF1XU7w8
         TqIvT1wIza9u75dwah/GgLpmdVULPdzPsYeMmF7T+kjpflc0QDN3M8Y26V2xy0HzBsIe
         2aO6Gyzjb7CxrgpMdGrbIYNhT+M0wmtSiqAH/UTnHae5pcugO9DNRZA/a0qRAPvE22xw
         ZEUspl5tUYVGnYgfcA+OMUxfxy/2QRwl0hfzvtm4Lm1NG87cW8rHYdbvtO6aJSUGEr9Z
         k5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102912; x=1694707712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdWsNUufxYU54d2v+3Wxi5MrfQGJIJLOBq5vhtohyVg=;
        b=HGaWApkGQ2bF45j5yHKT6iqBuvb7m1I2mRZYL6wGS5eziHPlsrg+kC0K/Wp8XjxxCA
         /bq9jHMkqsQCGjWfksay91q3eBB4CTYJIbuRU+kmseZsJlkWiRFahX4QYIccp6kw93Ao
         bwU5HPzk4UCfvCLcBaYIlvj1GaTol+W/geQTlUbIIXu2OWMbqnoR21E32i2NKDkO2f3w
         IhHDqETCnlg6Opi3HQ7Reo1sdAy1ogJmaJWsWSH0dGQkI2A0N7bh2iIp45kQMkClKtSr
         kAx/M4KWhFTu7iG3w+J/FvBuke8XX7/fLqGK/JFpF0JKAkF25d90fo1Hflkhitk99ucC
         pG6Q==
X-Gm-Message-State: AOJu0YzIwkb1tr4XQdj7Kx6wgLDkd/1FnhbtfxFKbmggAcOTmEZZ2R7T
        MavYsw8/bB0CUFUnnl4bhkqNJqDrthEXlMKXQn31MXMQmAbrqlzJGk4=
X-Google-Smtp-Source: AGHT+IGMY/aPJYeBu1Pp0IzmGxqtgA0g7tRf3VGot5Pdq6hh1Y77T4EpHI+nXikBBcDxY/Os4mlIAHH2bnKyBxN7wMo=
X-Received: by 2002:a25:258f:0:b0:d7a:edf3:f0a9 with SMTP id
 l137-20020a25258f000000b00d7aedf3f0a9mr17868648ybl.50.1694070333187; Thu, 07
 Sep 2023 00:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-3-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-3-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:05:22 +0200
Message-ID: <CACRpkdZEphqvwpid7QzXuYX79q2==58eKT7wg9Cmr8m1FLOuRA@mail.gmail.com>
Subject: Re: [PATCH 02/21] gpiolib: provide gpio_device_find()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> gpiochip_find() is wrong and its kernel doc is misleading as the
> function doesn't return a reference to the gpio_chip but just a raw
> pointer. The chip itself is not guaranteed to stay alive, in fact it can
> be deleted at any point. Also: other than GPIO drivers themselves,
> nobody else has any business accessing gpio_chip structs.
>
> Provide a new gpio_device_find() function that returns a real reference
> to the opaque gpio_device structure that is guaranteed to stay alive for
> as long as there are active users of it.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
