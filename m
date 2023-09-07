Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441107977A2
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbjIGQaK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240597AbjIGQ3y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:29:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB71E46
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 09:27:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68becf931d0so1012532b3a.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694103996; x=1694708796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2UPY8Ad0JyZ552HHQpe1k1G4pRk3wLhmWob6nvmGZM=;
        b=OV2GxbhoZTDLNa5+14Let7kGD3/ozOJZVFANKyanJyyjPtF8LexIsMFbLyjn5PUYZg
         SPOOB8skB4OjqF4R+Uf7osnCifTAfQ7K/4W59Hovu3KPbbf1ou76AjvGCcAhT51amcCg
         DwHuZyoD0dnQYDqbP6Vb2/tT8MJmJ7iaZRXVOiNAcES0vMK6rmgo0XvRbpVhkXAWGJja
         kwYloD+XHZWyG6ALgnlt7/27rL7MeWVIPemMqlv19Kw6fwAp5GHuskeJ0DycxEZUPg8F
         JN9jk/30a/WJSEQtgh1vRxLpGYswRtN1Z2HOSLxGDNEOa6eHGMxGUB8A83RazmU02p4N
         m+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103996; x=1694708796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2UPY8Ad0JyZ552HHQpe1k1G4pRk3wLhmWob6nvmGZM=;
        b=hKCBnzCSVoeP2UVUdqCBrbDGI7dJGU/iXnsl1V89sStkdUm41Ddo854tLLpFeV7G1b
         ELyxSxQafNALUb9c5MCukj/oDRFmJ/fijrBppd1YlrQGSEJZeI24zy+MEZNhttd3V5FO
         6fWYW5cm1LnTvGtuTxhVarnpz+MIz2HTmuqcHgJSk0cS+0Pmww+cZJYla0joJBDj2a1+
         0qJ6WT4hN5a6V959UfG7sKSh+ScVXUyhPWmQ221akis9XYFadXRoYY2kVW+N3n0NfolI
         ZaODMnLkhXjokGcHz/pQXAl20xvcwUjBoVGPWhjMv0O7HxWX5cOyCeQLuyudhP/iO2DR
         LVqQ==
X-Gm-Message-State: AOJu0YyF4eTMcDValzAQeI0oX9aOQa3sY8jQq+r4HMWnzsu/9kO8dDvx
        KtjUQLT28XMYKYG7758JRGIjwFXg0jFkl3Oa/3MS0PvvX2jtGY+zaCY=
X-Google-Smtp-Source: AGHT+IFxuGmnz6UhP+iDHBaAUw7EFN+gVZSw6nwdZwmmFMJ3XnkMU5k7fxCuPngY53Trr0s6Te5MkJ1CXk5K8y+Rwo4=
X-Received: by 2002:a25:ce47:0:b0:d1d:514e:27c6 with SMTP id
 x68-20020a25ce47000000b00d1d514e27c6mr18577035ybe.6.1694070485563; Thu, 07
 Sep 2023 00:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-5-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-5-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:07:53 +0200
Message-ID: <CACRpkdYCOVJZ6TUMQQHSaKZHMCx8tE8=3z=1BogYTkr52mFr8Q@mail.gmail.com>
Subject: Re: [PATCH 04/21] gpiolib: provide gpio_device_get_desc()
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
> Getting the GPIO descriptor directly from the gpio_chip struct is
> dangerous as we don't take the reference to the underlying GPIO device.
> In order to start working towards removing gpiochip_get_desc(), let's
> provide a safer variant that works with an existing reference to struct
> gpio_device.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Andy had some good doc comments, with these addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
