Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1139B7977EF
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbjIGQhR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241931AbjIGQgy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:36:54 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFB559EB
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 09:29:50 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-77acb04309dso47649839f.2
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 09:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694103815; x=1694708615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I18DoVxRqFJaTqip4HKub/TPXgj9WnWp7a45EaJWvuM=;
        b=YpT7AnnjkmZrqs7+QSUaY33FBaQaQsOEPn0quw6vofK72E1zBENMHE/uZsQYImMKX9
         54FdU+UgkRXIeNegboDQuh06c8y170+caTl/dTZWX4zUIT0PuDNJCqm20PfqvuCHs+Oz
         QMX8lUxG8/1IWjFyOcqGl8kH69lCsAqhCCHPGpSBhy2ofqxUkEJEh4q/0LwVjZR03AHv
         GweIxs9SiZ8+D2c82u7cjjr4Jkv4/LlnbINqxZxMqyPSrMVPBWLLf3u1JgQuLPP9g2cM
         mNTVHw9nGaFkI6pbyG5RPwAqTJstqcaKExWzX31hClb+IWM0S10YNVWOuHxGH4JVRjSR
         1EcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103815; x=1694708615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I18DoVxRqFJaTqip4HKub/TPXgj9WnWp7a45EaJWvuM=;
        b=PgRZRXOnGRr9mBqs2Q9ogBm47jMTvO+cpDRj6zyFh26eixvL3R+ly+x3qDFQ7YvKet
         5CdkZ517zq1Y4Z7oUZCEZ0IySwYMJ4PGF60wunOEbnSaoCAN2aNU+KVpcOwjucmqnBdG
         NEeM6MXkOX8v6I0YfNrSGqXOng2r+0mknw5ZTgw4GCISEViWB81coBQWm5VIWUky0Krj
         rNvQIHNyX+dbfnT4ztTUKr4O+NcuUkbYiuJn2J/TfZf5UKYKyCWqibhyEt9atthw7/M6
         /IEHFOGL+X6Io/t6OHP3156veQCwtDHRQu1nRJkC3TDUFFNmGlkLUdFK5c4QbINnL9A+
         J+sw==
X-Gm-Message-State: AOJu0YyoRL9eskZvx4EP40zcnNo4KsB1d2+K7QgQluLRrc9otPX7bLzX
        sUTWalhcuKYdFDWWcgONf46iy63H1xxS4rrVPCsb/hkGRp9ShAVCMYw=
X-Google-Smtp-Source: AGHT+IH52ZmMDQle74d5+xBv94alRH/CYtL/TIhLKM9b7HFrce/j3cJJJRCz5BcoTZ3hxH+Wxp8LvqydUyq2rr0UgjU=
X-Received: by 2002:a25:5f0d:0:b0:d7b:90c6:683c with SMTP id
 t13-20020a255f0d000000b00d7b90c6683cmr17866183ybb.26.1694070426178; Thu, 07
 Sep 2023 00:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-4-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-4-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:06:55 +0200
Message-ID: <CACRpkdbE5AJHiGan_oj4_kBSOh7okfwM0u9qDcEyTBr+NCO=wA@mail.gmail.com>
Subject: Re: [PATCH 03/21] gpiolib: provide gpio_device_find_by_label()
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> By far the most common way of looking up GPIO devices is using their
> label. Provide a helpers for that to avoid every user implementing their
> own matching function.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Yeah this is what everyone and their dog reimplements.
Good to centralize this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
