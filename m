Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E117978B2
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbjIGQwP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244267AbjIGQwO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:52:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317CF10FC
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 09:51:43 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-569deb93999so936170a12.2
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105446; x=1694710246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13mPF61qHFznELBakOuaBROvGPz0+u+UN1db/TtYWeY=;
        b=YCnbeQJ68h7p0kzVEgVeN/81Gjr5gavZBBmCd+7IwS8+oDpI2AJvUL87NEXWq3IplZ
         wyiWPs8eXD5+x8v0a4BC3lUtZOpIyx1ewb0jLeKFwsU83uptUdPGBWEI0H2+v0Gj8j8o
         IERdwC5zS+fJ5nke0XjJuIGKaXV+oaSurKoLTnZLUf0ItuzX/YedB2JH6BaKzFKs58mt
         houxP5v+81QaX0v0zAZ7yKj6YJxqupfdquF4iWW6e7GpDjgFfNyrZ3WXWGDDH5dxbu3v
         IdH84ebnGkD9qMsOt93xIb4ScRl+d6pnF9Lfwy9quUHSBys907rwslhikKUecSr+cKIn
         +h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694105446; x=1694710246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13mPF61qHFznELBakOuaBROvGPz0+u+UN1db/TtYWeY=;
        b=wISawa4WRJQFHhqhhty7+ggtV1hxP38usHLM/Mvd85qQKbhkJeblZ4Ud/cQnHhYZmH
         QlWmY1WRuLPwFh8Kqj/qVesqZ9h9rPO9IT8onwy/jwyxVk3TwaF2Pe17Nemwm9fyKQYN
         dYaFH8wN4jhC84d0y4dBjGt1Mr76zgZJN5vmg1PJX6uqmaCZy5ZbvQZtszzjcYABMYXP
         Fb6gBDgltZVg7OU74oJ/zzu0CyYoMt3H3gQ6ISDN5L2PTKgZocFjwCfDnBoG04ZdqjC+
         4z7Swp9pO3PjjDYjMLygVDts4RUp4agFDMGbKUjUELqYJDeH18TLB6sR40yLIBMS8ii3
         guMQ==
X-Gm-Message-State: AOJu0YyWyZhnEEzBuxItgXzVsnIIIkX4fGNdPQSzA7CyNWjr7OPFE7zM
        10IedPWCVv2cc7HS7Y3t9aTZcaCeC3hLSdeIY7gZqs83G6zTTZ9CTQg=
X-Google-Smtp-Source: AGHT+IEb93BSLJ6ys0EYsaB8W8EpvBdYT15JIdt6VJnTL5yTIvHPIi3k4AVOKcoqpkbYj81EENL5j+za7CaCpwJcXlw=
X-Received: by 2002:a25:d783:0:b0:d0e:b924:8e20 with SMTP id
 o125-20020a25d783000000b00d0eb9248e20mr19000067ybg.22.1694072539775; Thu, 07
 Sep 2023 00:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-22-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-22-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:42:08 +0200
Message-ID: <CACRpkdZBa7SY=3vykMSOxcQ=z8=igru5uFmyVw0zmTBvAWZTBQ@mail.gmail.com>
Subject: Re: [PATCH 21/21] gpiolib: remove gpiochip_find()
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
> With all users of gpiochip_find() converted to using gpio_device_find(),
> we can now remove this function from the kernel.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This is so much cleaner, and introducing some scoped guards
along the way it's a clear win.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
