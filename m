Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC31B79780D
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbjIGQlO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbjIGQkz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:40:55 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72FF35A0
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 09:39:59 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-44e8ddf1f1aso1360099137.1
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694104725; x=1694709525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f20OVJZsVkvgr12m2GLQpGE6nkKLjOApm9F1D76ZYu4=;
        b=v38Ubk/jBxbbGVepKIZX3l2elphP8qbDZara6KEc/SAm6CfPvYYQdo2tI7j9+yKUwW
         leOoHL7zgpUlBt9x5mxmNz/JcUVWyInTBufUbzfIPgjkRZGL3shXgFPhJEPRElfjrkTl
         /qMj+kyAKgwxl0KY/YIpJobn7gC0BwfyuhOnQhFB2XAZKvfSqRLe4Ve7jbdIPjzzktq3
         JDwuhp23C7r4eEgmXrlStJDTKyVi+5SrRfRSlf6nVbWUBpkL2EMMpiYkl0BZEPMBlD/2
         J4AkORsMBSFGg6QJ6P+1d5TVa8e+reJO9nqrbLT4uo2eipjHIT2S3A2uSBFwQn7uK3L7
         iNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104725; x=1694709525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f20OVJZsVkvgr12m2GLQpGE6nkKLjOApm9F1D76ZYu4=;
        b=kINhT73Lam2jJ3FohfxEGxxrQFQoXYkUXQCYP+J5feWBBO9fDONvxcKrD3nQN0u9Eb
         5cJZq2i1+Ndhv1ZffOAzsCOgJZTBcAsILWo+34Uv9zMuolPkFVuumPZjL0DGb6eogVG3
         Ofr28dpePgzSz7rjskWRCAbskMjcmyL4GqPYgcrBr9f/kjuU89eOs3gXFCMMDjCIQ2p6
         aFW2xE1OXecgEAVRRe9/Dy7UF3cQH6kUUfGIzlCssOWfcIoud+UsNZMWojZ6ww97NyRE
         WVdPmIY5vZMkCepwFCN2SHNw5dS8QUNZi94JqmjTVAyoCEnMBTtUsIHOC8VaXUB7R28I
         TZcg==
X-Gm-Message-State: AOJu0YzXbrD1dE/oJPFd3lZ9YzZs2bwm8F5KMwFnUWYnIPodM5eQPgL/
        2y6FJe/90ybx/pF9sxgd/CGvICYAfwpeiwYZsmXg8jrGuaoJh0WEBHs=
X-Google-Smtp-Source: AGHT+IHeVaENuEkywllarylsoaxFtkX8+wcxLmOt1RC5WvBdIS3BKktFFG9wSU0jnwmUX/wjU0B+ttekv3ZROcdPEGQ=
X-Received: by 2002:a25:f414:0:b0:d73:ed30:1162 with SMTP id
 q20-20020a25f414000000b00d73ed301162mr1939775ybd.28.1694072320536; Thu, 07
 Sep 2023 00:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-18-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-18-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:38:29 +0200
Message-ID: <CACRpkdZbCjFMytzsF6Sb-6V54J+owk+zJ3oB9ZGCzAdsGwcFOQ@mail.gmail.com>
Subject: Re: [PATCH 17/21] gpio: of: replace gpiochip_find_* with gpio_device_find_*
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

(Sorry for fatfinger reply)

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We're porting all users of gpiochip_find() to using gpio_device_find().
> Update the OF GPIO code.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Scoped guards, nice!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
