Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1EE797BFB
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 20:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242986AbjIGSfQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 14:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244298AbjIGSfP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 14:35:15 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45E91700
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 11:35:06 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5925e580f12so12858617b3.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 11:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694111706; x=1694716506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwy6uKOVyjPH/vJMAsaPCoM0fNwaGdU7NPhSy+lwVBs=;
        b=cXPh7NzRlkcKh5H5iI5+/JmduCcRI8GtO51Ss/x49nUweyTpOeab3HWdJuU29e/JJY
         O/FfsBZGMocxp1yBBBzysEcAoAwThstXbJVaR0h/0pVHjmWEE0mPqaV+crJx8XQaRIJE
         HR2yQ+YGRbbN7gJunLX4Iz3K10s0CO85Rp+u/PonaXB0P+ildjzV9YSYsvXuLKANMTQI
         zqEk4DQBQnGoWHOedO7sy4morctMGjIveYlETVx9jLwvwXmeOnYGKtU2FCXq0KjtnzVY
         5V/NoX9X1Z5Nuz+420xr7+hkyeFVKQFSAXftSkCHbp3mYbZJE98kdZsG8Iq7o8v3tDbP
         8obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694111706; x=1694716506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwy6uKOVyjPH/vJMAsaPCoM0fNwaGdU7NPhSy+lwVBs=;
        b=W9uPTW3gNmYGC1sTaAX0PFWN9uH9Qd/a5U0e07BcHKefBQSQyPFkme9y4OGeKBDPKc
         BAPnS7MdidXDVM1HkzH/U5qKY9ywYjy6G3snLv/+z58+7JgTbrLV2iLghYqH9lrdTb9U
         cKrT5wEugi8IARyR361d80yAxdtMYyoo+jt7P3HTzMlFfwfZZJlhSKP31WuUqn/KSsHp
         ckASBobBC8HzXg7uVr4L3OvVoUB0hVmaqmdM2vogMx551XjDTUY2E4pGdP2FWUO0U9mC
         3kJvJXTx8JZ6rDS9ItiMPXHpxuP2z0VCA48wtcTjw3v3TOD/5Nb8w/fmF+EAE6xllDi/
         T5Rw==
X-Gm-Message-State: AOJu0YyHSA8pxw1rD2Xsqdj4ygj4EXC8F8VxSxFDPNSAq9z/3nkITdaW
        4G+y169SHKhFSii5uvgvH3iT0VJyQvEtr629Bqjhc+S2NuC4GDbkO10=
X-Google-Smtp-Source: AGHT+IFDrgWVURx3JNju7kZZF1wu9Y/TadMJ5yuRpzoXN8X2bh2xdWz8hzInBvmi+tzixNC0aGXs9GN4uotRGCxcdwY=
X-Received: by 2002:a25:dc54:0:b0:d44:a90b:ba50 with SMTP id
 y81-20020a25dc54000000b00d44a90bba50mr19457872ybe.5.1694071251891; Thu, 07
 Sep 2023 00:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-11-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-11-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:20:40 +0200
Message-ID: <CACRpkdZdaBELiyR8da2GHxj+=FFzsvL+5POX5139+OTA8rKUeg@mail.gmail.com>
Subject: Re: [PATCH 10/21] gpiolib: replace find_chip_by_name() with gpio_device_find_by_label()
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
> Remove all remaining uses of find_chip_by_name() (and subsequently:
> gpiochip_find()) from gpiolib.c and use the new
> gpio_device_find_by_label() instead.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With Andy's comment addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
