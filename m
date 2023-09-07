Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6696779789C
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243589AbjIGQuA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbjIGQt7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:49:59 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73DA1FE8
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 09:49:33 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1d0d3d40124so864201fac.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 09:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105312; x=1694710112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhjMO+NmlnkrwuQTWTc/YRBA9QtXdjC/hl8DIJEpExk=;
        b=R4LpTmS2tMUml/BusT5TWrK/qCAkWuKi04PZAHhi+oTnNCo7OG/p9NsvGbm5F5ux2B
         q4jA4AGhfhj3a8wFpAkP05sam5K1QkipTpG0m3i1DbrrfsnKsEmo6GQLoYCRqI5fQ4Ma
         Hmzc7KybmL5KPzNe+i6hP4bmWu8riEM2qWQsE6Cu9KN2Wo7ZRzfZ8YnvDlYqN9HY4TNl
         AhytBVdVtUdHogCkmLTq6WQ/ZvONbszha4bB1T0g34429dFDGUfhGycseFA4nL72FDwi
         Vc2l7Zo/3GlATsvafkLi65MH6eRZqx4wxfAHlk/RZ8Czp8LSFaXb9ieawf8D5OOhCWGQ
         yFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105312; x=1694710112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhjMO+NmlnkrwuQTWTc/YRBA9QtXdjC/hl8DIJEpExk=;
        b=Ppk3qiDbqIKTx1gMz2rbEjNkX8pFnb4roOV9Cb9eNcZyrxgQXKxXPqUuMBtnjWsAy5
         Z2FLydYx+RttEjTt+IchWl2Ih56L0mMcmO+CS0w0fhoyf6rjo3pM2Lp3FOLEO8V8TKNn
         30jZxbiXAyBk0DkqQHp2gIgCrbHCHx2S55IR9751WWxbehgFOVw42sdu3bce4BlzZk+i
         CWWIaHkpTwQHwhP74Z5FtuW0cg2dHi3LmeQamltrNyKKGqmcSiUpBoUr6EbOFSpOOK1H
         HBx9oHwTXgBO2VCPivmRpTM/b5YrFup9Tqxspi36k/lNNFV/cfNnYvBN/KaflDYLo11f
         4NjA==
X-Gm-Message-State: AOJu0YzFs4SM3UBR79ZzwIvMDd0i+YxWiAVwEfBtg1K2lVxGNvwIBQz4
        6bnTZeiVo5JYmeYE2hy3thuVfEtytCPSUIYcVaqIM9rI1Tzre9WYibg=
X-Google-Smtp-Source: AGHT+IEos+IWcRlRURBpWq2f/yqX4JwD1uUNGc4FMcBDjtB4EYVZgMX+6wsZb6/oamwVKLnZoLMvxAzj5BAJ8/qIfJs=
X-Received: by 2002:a25:aad4:0:b0:d7b:9ac8:f439 with SMTP id
 t78-20020a25aad4000000b00d7b9ac8f439mr18109140ybi.40.1694071872125; Thu, 07
 Sep 2023 00:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-16-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-16-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:31:01 +0200
Message-ID: <CACRpkdaVUPNYVjAi2XsNKVhwmtk2qpVp62Lke4xeDOwhhBXLtg@mail.gmail.com>
Subject: Re: [RFT PATCH 15/21] arm: omap1: ams-delta: stop using gpiochip_find()
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
> gpiochip_find() is going away as it's not hot-unplug safe. This platform
> is not affected by any of the related problems as this GPIO controller
> cannot really go away but in order to finally remove this function, we
> need to convert it to using gpio_device_find() as well.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I was cleaning this one just some merge cycle ago, now it
looks even better!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
