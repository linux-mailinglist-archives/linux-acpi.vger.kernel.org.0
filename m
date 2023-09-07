Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A7797BE1
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 20:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241935AbjIGS36 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 14:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243685AbjIGS35 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 14:29:57 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285B22105
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 11:29:23 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-78caeb69125so503604241.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694111360; x=1694716160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBdELFiF0kNq2P4ovxPr1G/v1B3B5Z0Pa4x1EdUn7xY=;
        b=zos+i/jyZpvf6KBR/0JyavO24cDO2lEF1UM/dg47cJIHvvXlv/sqmoQME0wn0oTnDi
         l0Ui5yHSvUjwXRVnQfctW9X+VobDC8kXxjoUWws8hXBsoSgEg+zrCzLVYSeGF3dbNKqS
         ss1zXZuDoVrtfe2ZQvjZouVPCleUmyA9yoMEz6XjxfoJUJm7jas4euC4SmBtnX5Acte1
         dQBDqlqNhowEIB1slbuGF4XLqyjcMgcoW1ac4aXVcbksVy0w4/9wp7YrK5m2VR0yQHkT
         A02PImdnwZoGLBlKBYKChRwPMstyvvsUKHPk6A08bwFyXcM/w6i8oW7Hx+K1nDlmI13n
         92pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694111360; x=1694716160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBdELFiF0kNq2P4ovxPr1G/v1B3B5Z0Pa4x1EdUn7xY=;
        b=eLPwby3i2M39Nwkt012jsbda88HaBKS4oAPdzGm4zewNTFXp1/s5hIeufvVvlOf259
         OmaZ85l2qgKPe09h6SPMtwbArnsWkPQzIAPfIjLE+oyAq8CxJrxP11AYTI4CRk7w/a8m
         hQlpPBB7J8J1eKvQaXQc3kJ55t5n5MiyJLLat2Ur0rLL6BDmilx8DD2yElt/agyP4DU6
         +eWvujoD5BAsoeCsSYInMmdXGjR0CLLPHRuamDtNGsz/8OVwRSOcfeh98EpIGEIHTW0O
         fqFGeg6ISx5ijLd9Vc57qqBChnHJl2X+MIrtlPqPSpdn2LjXBoJuWPJYoUjdGZfXleA2
         +3rg==
X-Gm-Message-State: AOJu0YwzABYFJidapwu7JHX765vu0gzASx0+/E2bALFigyGQ8zve7ySK
        vAtyDXyF9Jz4lrtdCy3zB4NsLafIbKpdQE/lhwlTfZAwf1cqRfNAWEM=
X-Google-Smtp-Source: AGHT+IGquAMmj4BV1IgcH+0hlmwrCPO8RvK5dDPIHBFPHMvw3mBi9yKQYdiyjPsOt1CRLSecOSiNHyNGSnbycipPFpA=
X-Received: by 2002:a25:4057:0:b0:d7f:1ef3:66a9 with SMTP id
 n84-20020a254057000000b00d7f1ef366a9mr10826771yba.15.1694071032928; Thu, 07
 Sep 2023 00:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-8-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-8-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:17:01 +0200
Message-ID: <CACRpkdbdcPv1LHL2W-enKBJ2OARpduoOJkQ64oL6GSOfmmD3qQ@mail.gmail.com>
Subject: Re: [PATCH 07/21] gpiolib: provide gpio_device_get_base()
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
> Let's start adding getters for the opaque struct gpio_device. Start with
> a function allowing to retrieve the base GPIO number.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I guess you have a solid usecase for drivers needing to do this
crazy thing, because I suppose you feel as much as me that
this should rather be gpiolib-internal and confined to
drivers/gpio/gpiolib.h?

If you add a valid reason for making this globally visible outside
of drivers/[gpio|pinctrl] to the commit message I guess I can live
with it because we need to think of the bigger picture:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

It brings to mind the now confusing "base" inside of
struct gpio_chip. We all know it should go away, but since it
is never used during the lifetime of the gpio_chip - or SHOULD
never be used - it should rather be an argument to
[devm_]gpiochip_add_data( .... int base);...

Maybe something we should add to our TODO file.

Yours,
Linus Walleij
