Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C69D7976BD
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbjIGQPi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbjIGQPW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:15:22 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512CE51B7
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 09:12:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c0d0bf18d7so9216265ad.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694103076; x=1694707876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Cz/9gzupE5TkNJMwQALq93+f7LW0hvWUSZEk1aMybo=;
        b=exbbb7Mit3PTnu+Rxs7lfLUs3adyO4aybE3+ReDyMb6U4rsAydUm906767Zn0hLloi
         CB8KQGw6zolHqQrNa3ghueyK8dtbkex0VlAbbU6S19547VEDEJ+U9ojgZJSb3xWjIhcC
         hoIrZ3ZHIlAxRSXTHoCkiEiK5txAl/khSBrFvNwDaeBXY087Ca4ZEfmzeofFSOOd7fo9
         3xklo4mydu9i8dXUZ8RenIndMUjji6SlyIf3lqF7AMc0u1uY1+W90wBFyfPh8+PmH7vT
         LOCDMZ3FB2zHjpd8sELis6UWmRiDsXRveUSR6gZ032cCiE+rmTu6G5O1P0l/ioyAYidu
         3HmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103076; x=1694707876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Cz/9gzupE5TkNJMwQALq93+f7LW0hvWUSZEk1aMybo=;
        b=KIB9wfK6lLIRgliuwxifChK2fNub+Yo2pOhG1hptB33AR2i+Q9rcUuU2mkUZPMmVj0
         v5uZyXlHBsi1XvilCtCD7PYGuKPyDup/p1ytQR00yakhVNgbgMe4T7t3vQJF6uZEYIrP
         138Ymc5IsC52LxhxMu+n2W8JJJr7ZyVDdELOa1CqHmKv2Kqyfs2caxdHyTLQjVJYYTIS
         mh9lV2eGK1j0i4AfA0zVHS8C29/e4Yp/XCm1UbhwFSjWMsWSofEAsl3aBVUsjmqLuf/p
         SWzSfhpq9oxV758pLy1SH93k4tSYIQaNplShNL+3qYGNqMYC8RU0g1aLFjoiEQfOzStc
         YU+g==
X-Gm-Message-State: AOJu0Yz1aRE8lq8B6hPEwFrg6ML9GFLr1h40xY87RlI7tbedyEUmYXw9
        6yx4PY4dznZqm50v9wrajve05FAHMA+QmG3xMu0A/aJz2iIXWIlS
X-Google-Smtp-Source: AGHT+IHhmgzWKTsylHHZ2qSwdCSe8fG9sB+HCDYVng7dujabCyOchOSgbCuVeCZbRiidwPEiAF4MbYeMV3WMB/wKWxY=
X-Received: by 2002:a25:40ce:0:b0:d7a:d628:f69d with SMTP id
 n197-20020a2540ce000000b00d7ad628f69dmr19332220yba.32.1694070175534; Thu, 07
 Sep 2023 00:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-2-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:02:44 +0200
Message-ID: <CACRpkdbT25G+KSUOPjgo9BQmPy2_rgXULVM1fpZQDqE+Xcj80g@mail.gmail.com>
Subject: Re: [PATCH 01/21] gpiolib: make gpio_device_get() and
 gpio_device_put() public
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> In order to start migrating away from accessing struct gpio_chip by
> users other than their owners, let's first make the reference management
> functions for the opaque struct gpio_device public in the driver.h
> header.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
