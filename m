Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187EF7978F1
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjIGQ73 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbjIGQcV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:32:21 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13513C24
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 09:31:37 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41479b9b4f1so7994351cf.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694104241; x=1694709041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXtSDuwLHBAGfIvJXN98Bc/TjY2BpOjtqu3XNPdnEAg=;
        b=f0GaWCF6mcBtAT84RNi9d0TCHKAzyHKJBjeteruwA5vv+dh8eV+BMd3b+avPzY5Yz6
         23wn1ooPabd/G2JaaRsuikhdWR6MKmWEr3eQtXOCn+dWX/xLlwyH579pcip35ub4teri
         qgwpPttAsDq/7C4gJ/Yx6b66Q0j1t6zKWkox74FGHsFZei1qwUWOY6s8S6XCmKh1Vz1G
         MFuXXLeewFAxoxxTRGuHk8xeyCOfXSRK7RYZf9Y9eGXqn6e9UpvYMdnkF++Xw/LHBg/1
         ueM9yc/YekYe6kyopbYEKnpbxuL1hsYi/oEsJegYEkWE+5PqF1YWbE+KEdX+nGVirzbI
         8rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104241; x=1694709041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXtSDuwLHBAGfIvJXN98Bc/TjY2BpOjtqu3XNPdnEAg=;
        b=foemGxQ8tuqcnLlniS9aUCjNRDD1CMnGinCHbLa8uaRA880GxZoLERJzf3XlmLD6cr
         bGlCLvH1GRYNoNzLeCPYzH/fGkNdl/MTtO7ENzMsZWPywSx4g8+Q9B5tcUzCSlw/cIBq
         A8XnL8fEzf0qRZFyG1FaKEdb3PQuZyShCUmA5M+0lGsvEOUYj8bJ0KVed8xitlKFjzap
         61wtK5SBtp6UKhLSO6glO1MDNWNMVSlH/jS4e5KE78DEul95wZ3iF7O8Ha2Gj6Nkm0Q6
         7pctz2/RjLXKZ/3OPxFqfORvsj90Az99KDWIxgULd2Uho0kyYgaRbx0L/pCPIDQpgnzJ
         74hg==
X-Gm-Message-State: AOJu0Yy3RsB6kiwDnR6WVUaxNanCtgiuUlvorw+nKC3AWFtlLICQlDcP
        g/yy7uevHtfhFcwrrYBk17nJ/4e/JNekKtYRh8hhg6faUMZTjAsK6gQ=
X-Google-Smtp-Source: AGHT+IFBssMxe62b6gjC3N4aS6mxtu2dG9GSPKFawDHtfKqDxWyo3xiYEaVk7D6s0DhtiZ21qOVsU28YZ+Ws9GvtAJ0=
X-Received: by 2002:a5b:791:0:b0:d1f:6886:854a with SMTP id
 b17-20020a5b0791000000b00d1f6886854amr17648637ybq.9.1694071162023; Thu, 07
 Sep 2023 00:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-10-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-10-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:19:09 +0200
Message-ID: <CACRpkdazRyhqHhH+Ock3U0wFRkd_U5QUTZmOeTFoXx-Pe_jCRw@mail.gmail.com>
Subject: Re: [PATCH 09/21] gpiolib: reluctantly provide gpio_device_get_chip()
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
> The process of converting all unauthorized users of struct gpio_chip to
> using dedicated struct gpio_device function will be long so in the
> meantime we must provide a way of retrieving the pointer to struct
> gpio_chip from a GPIO device.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Yeah, sigh. Maybe add a notice to drivers/gpio/TODO that this needs
to happen long time.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
