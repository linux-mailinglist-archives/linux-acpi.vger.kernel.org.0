Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A1E797522
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 17:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjIGPqp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 11:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245499AbjIGP3j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 11:29:39 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D1A1705
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 08:29:11 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58cd9d9dbf5so14732187b3.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100504; x=1694705304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY2mdAZRDyp8VLACjM3IsJrv/DB/YaVz8BTWDKGc7zo=;
        b=QYH/2RWdhkXU3aukIvHqmxGEsfopIZ1sDT0WYBEHHHQWaMGDLY++HZWbOc6fTXiufV
         pGPdpMppsFbFycKEVWCLJ6oXZSoeU1yBojvAfCy1TNNoxqWcV2wuSdTyyxVpc/WSHVzi
         cADb1tTEKpgEfkHMAJ3x17qJRA8LPmQIUJsHxduweQ94mbzvwixtQjWpWThi9UmyX+rV
         wIuuLQewV9M+YSKqX2OjLcHIDlpxJeu+eRPrxk3ZIRBo0Km5a/7SjGt7j7b7GEZbIErv
         UZHia52HxJiRifJNfLYc4wDgY3md4hVCK+DlxYat4PPaHzMEn5eHyt8C9qnvF/kQQ22c
         ktUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100504; x=1694705304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY2mdAZRDyp8VLACjM3IsJrv/DB/YaVz8BTWDKGc7zo=;
        b=JlTRlzoMwJjC/0TYE2KQ2X/amL3JAlBMKPXHxNtANZA4SNbc8jm6fNan0rIeLTfbJH
         tqMTq44xbHzFUmHeRKlXAtER0l80agirdZFlEyx7oeXO5sZtOYBmWtKYXYs/Bdxsnb1j
         05Hw3K5NUfGQoeL62JoNP6ggchQu5jzUQqFFwoEJGfHkBxF0YnjNN3CIdiQuIBWrj+Yn
         7BlFXAAx/NM6yoMJbcVRS7UNqabX7i7gQIXIoBCWtG8wp0EiJIdNa90NDEWqj5NimhaN
         1YesDAhW7n1xb9NpiJANtnz/Hg6wftFFqNM1DC+R+FHqlMzia01EnIU8f9Y1PV9moHwZ
         UKkQ==
X-Gm-Message-State: AOJu0YwCB72S4godWyvvxo7adwdxUrSDJTRtHz60Zl8Mct/YRRHC6jl1
        CJSuz1tH3LT7dXwXd0uFIXMYWjqsLJCqUx5CG38dx2CxXyHo1H+qfzw=
X-Google-Smtp-Source: AGHT+IG0DLNKfUPhB/XHRakKjzQvJdJ2oAW9KHDtArjRFCSpF0Q5z+EJuu/6b8snoqW3fkVGsSaqNy6kxIliPZAjMsU=
X-Received: by 2002:a25:dc04:0:b0:d4a:499d:a881 with SMTP id
 y4-20020a25dc04000000b00d4a499da881mr2163263ybe.9.1694072375343; Thu, 07 Sep
 2023 00:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-19-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-19-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:39:24 +0200
Message-ID: <CACRpkdYOp5162vhQXBp9FwLZzXnjByYHt8OurK4aUyQmJzgfoA@mail.gmail.com>
Subject: Re: [PATCH 18/21] gpio: acpi: replace gpiochip_find() with gpio_device_find()
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
> We're porting all users of gpiochip_find() to using gpio_device_find().
> Update the ACPI GPIO code.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With Andy's comment addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
