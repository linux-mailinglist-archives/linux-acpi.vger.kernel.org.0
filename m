Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E5D7978BD
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjIGQxp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244452AbjIGQxo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:53:44 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA891FE9
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 09:53:14 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34e25ad38cbso4925565ab.1
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 09:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105535; x=1694710335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QUcdjgXxrS+bTKkF3r2QRe+Cc9aRk/mkNDQCAPj22c=;
        b=Zen62yQn8omIlhIs2mjjJAIyicbLMQeEzyo7G/qI7/StumaEYenH9u9fvCck9CuWeH
         BdbYl1RwMEAx/Q81qlbGuOOSGQTDbJwc6HOvFwG8FynFducmHprCC09fo/IHNmqsGpP+
         VlZvu9bsWmjj8gAjgItxD+mp7KtQ6KwEG/CzGB8+RKu1++bYEQ/9qwvZY2v6NP2r9gjn
         mVnGcr7GGv1/SflS56LF/nC+j0kQpoJTa62TuVnUkslezJX1kdMjpTu9z8/lm7htRPgo
         c0uJP4/bcDk/7VweOcLSYAD9wdDlVXqsX9x2v5+5IFbBszoxWZka/tTkvFkuu4PQFxhP
         EB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105535; x=1694710335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QUcdjgXxrS+bTKkF3r2QRe+Cc9aRk/mkNDQCAPj22c=;
        b=a4PykTl0d0uf7TP4Zo8JvxdAtOx3MYcGWC9fmXTWANF3qf1MAXqFJg0WyX/iGEeH0p
         slL5jF0ngQAzM3saNLk8QAvocQ6TPuB6cH9LwX4hDbOD0UDCE31Fbw6g5r8AMO/GtI4E
         QNok/csXiQeyVh/L0LlY3QKHaQaQtqqNzcCs4T340D4+5LVUi2GlBYTNlIhiOWMOrhtg
         55+mynWXtz4lGsyK6U0TKg56ebnyIpxbsU8ab14O9bhQH2pg771yziIyYJyEeFwxxdPF
         L6DSUOkiIal9lE8GreCMyXB0ilehufuEAiSmVt68Zz4YMZAZdfUwkYDV4JGGDZbrqBLH
         /Dsw==
X-Gm-Message-State: AOJu0YzaFivlHepSF+7nyE608qUq8FKmPXockwvKYVesU75GlX+5fWAH
        oEzMO2Mw3XNoBlrNKTMuJHfAfvHzMCxkEaDi4cIBM2JZvUR0WijsKTY=
X-Google-Smtp-Source: AGHT+IG2TLQ2WqAfuGI+vTl02pQSFPJWDZVOY1MfvYV7hKobdzNo0vRGz8kywS9VyDIIMdmuzYR3qPmWC3h4lMZlj/s=
X-Received: by 2002:a25:dc81:0:b0:d7b:9a5d:37c with SMTP id
 y123-20020a25dc81000000b00d7b9a5d037cmr18599620ybe.49.1694071708542; Thu, 07
 Sep 2023 00:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-15-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-15-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:28:17 +0200
Message-ID: <CACRpkda9=VULj4Cy_sit-UpUQnVEbS-RJKAeULVCw8ZCRTq1sw@mail.gmail.com>
Subject: Re: [RFT PATCH 14/21] hte: tegra194: don't access struct gpio_chip
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
> Using struct gpio_chip is not safe as it will disappear if the
> underlying driver is unbound for any reason. Switch to using reference
> counted struct gpio_device and its dedicated accessors.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As Andy points out add <linux/cleanup.h>, with that fixed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I think this can be merged into the gpio tree after leaving some
slack for the HTE maintainer to look at it, things look so much
better after this.

Yours,
Linus Walleij
