Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33642797C6D
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 20:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjIGSzh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 14:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbjIGSzg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 14:55:36 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10232A1
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 11:55:33 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6515d44b562so7938876d6.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694112932; x=1694717732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYoxChlU4Q9Xf4jiILAEb1/yHuX3jjQxtu/fJCh6QGo=;
        b=YZ1hTB8Rp5He32lWLNQx5ReJnykI2zmjw7I/3vAn+vj2Al/v9cjizg4fpj3sGQgSoW
         jDNJG9CI0wB6j0iqVfpDG9opnRUcHbIQg/A9ExXS4IE0RXqwTafIo//VM26ehG//EdL6
         tk/JOJq0Cfl9i1NLaIL7A9Zvi10/p6Rb2Cr4WVhz+HUxYeBhXG5Rn6Du0fbP4fOJfmsu
         oIbyEWoCURaIkF8P5mjJRH2I9m+k8x6p7+wulZmoTsxlR7pPkQud33Yk/VxCDm4tCJBG
         vNL6hxxVRLBazf9mYfjHoUtD1CUuLJYbYK/dO6qma80LlyXlRuDiAkx1x5lsdS8kVvP1
         EiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694112932; x=1694717732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYoxChlU4Q9Xf4jiILAEb1/yHuX3jjQxtu/fJCh6QGo=;
        b=XTYNOZVYeHvwH2Scq8yyOIQJiQDpjYWalcXIOMM484DaYv0d9QORvEzzKtEW2Df3/P
         R1E0nkGrX1/GdOzVCNCG5AaVvaK5wBjlcaAzlBjj+xWViy4IoGMjRRgN7CVuX/mW6B10
         CzIh5WPvz3sAmRnSZf98UdaxpWF1r3wFoN/GU9801ZpNc1S7bBkUbN2dU+NJCOPuestr
         xUvR7VBOZT0OQ/OF/RRgmaaQ85Ob2k9+ieNP6d+qNiyXrjmj3//I0bRJt9/woG+/m6qo
         5XisybQbR5vLdVhdNrph8egJH35fuyMydc6GTvQLsr2e/+IboBWApOSB1eFHKL0e+l1h
         Eq2w==
X-Gm-Message-State: AOJu0Yy+RCGCd7W+F7+Nzod4B6cL0+XCD4CE6n0jDh+GhWUoOyANbXpf
        1NZ/k0AG0s8i3GmXzjRWIvx23R3Hf5GwJAGQG3BzAb2pQCigGXEeIV0=
X-Google-Smtp-Source: AGHT+IHaxiCnBZm00LuWWUA+a8rnudg+hvum/6YQLw0kwU5o8WTcy0PQZuAfaxNBOQSTfwUYu0m1J/nwQGnmFDsy/5I=
X-Received: by 2002:a25:e6c9:0:b0:d05:fa02:5bf5 with SMTP id
 d192-20020a25e6c9000000b00d05fa025bf5mr19872193ybh.48.1694072468477; Thu, 07
 Sep 2023 00:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-21-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-21-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:40:57 +0200
Message-ID: <CACRpkdY-DMJAzkjVFx2Jyw6yG76u8cZ61YPUbcCsosN5kZ02Ww@mail.gmail.com>
Subject: Re: [PATCH 20/21] gpio: sysfs: drop the mention of gpiochip_find()
 from sysfs code
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
> We have removed all callers of gpiochip_find() so don't mention it in
> gpiolib-sysfs.c.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
