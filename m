Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69662797808
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbjIGQkG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242234AbjIGQjp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:39:45 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5214C09
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 09:37:38 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58fae4a5285so11898247b3.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 09:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694104599; x=1694709399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZM5LCrIIZq6Cza2RJhNNmn9rDXfdqmiDRo4rHF5ssg=;
        b=McCz/eZdn9w/w8sy+blZGocajLKbF5PKSVhLXHU12yHRQSgobn1A6CMIKRVHNG2lhj
         9dnkDoGNkP7BdFKJyr95+g/0TI4alyeDjBstmtzpNmm7IvjyRpssBHEbHZlovHkDi3QP
         w9Q02sooYoMxinz/ISYhIz/jXHXX1nVf1+QT/XnhpnVU/WExycPZxniQ3OVl4DY95aki
         1U2iBiWg0aJf4t4j/ymfTbZoxr+UjyrkkNuvYuVRn616kcyYclv0jHhzuD/K8ov3Y/tC
         5nJhqmsXAdkdxfVrEkmuQ0TRk44geFjUzPpdyXxp4S5GOX3gLzawlAr65DuMvadzzJfT
         A1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694104599; x=1694709399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZM5LCrIIZq6Cza2RJhNNmn9rDXfdqmiDRo4rHF5ssg=;
        b=CtkCRPzGIkHq6OV33Lvc5/IzhCHpX13EL+8WnY283WkohexBJc6zXvHYhIfAsEKtFi
         k0i6voWcab8b2T2VT7ZFPP+KG2RyPiGfCUG8c3AluxlnfpBJoCdspQQfMyDoK8F7d0tL
         5fSHT69v/00t8LwyYo/a3pla484i4/PwCdf1R5aEs+a/G6KrI1yfEfRGi0e3yx8XjODW
         C7d1II3edz3R5sbXCSuMh9l8bkNj+MelGLGjawQyZjn59lyZXOtdsRAj2Af01qlSo6Wc
         l0bhyWeBTI8mKDCg11VtRcFttMDNvK5VLfRT7UKGXPat6mDV9CTchu6bI0Z0O83b9Ott
         awqA==
X-Gm-Message-State: AOJu0Yz8H3W35jvhes7mLXriwh9GUE/9krZhXgowbMV14/h5803UE5qm
        uopwDlaNHaMyMRXhFVE5aPWJY8E1q6KdqbvbZOTBAwNiaam7tAfb7OU=
X-Google-Smtp-Source: AGHT+IHhj18itEgT7Zkm6inaHN3nE+QPEGLPicrIzqqx/vXBzW0adJyqRztqORI4Xy/4ylPWC4tCJ9Ht9cCQq18uOlw=
X-Received: by 2002:a25:aae3:0:b0:d1a:955f:304d with SMTP id
 t90-20020a25aae3000000b00d1a955f304dmr18305004ybi.64.1694070633444; Thu, 07
 Sep 2023 00:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-7-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-7-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:10:22 +0200
Message-ID: <CACRpkdadcw=E38o=cNWT4fQ_PK0UPifJZdVjuXTw0cjxPAEaKw@mail.gmail.com>
Subject: Re: [PATCH 06/21] gpiolib: provide gpiod_to_device()
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
> struct gpio_desc is opaque so provide a way for users to retrieve the
> underlying GPIO device.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
