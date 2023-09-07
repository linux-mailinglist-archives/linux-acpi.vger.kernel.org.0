Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1CC79780F
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjIGQlS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjIGQky (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:40:54 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04631272A
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 09:39:57 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-412091b9035so8088921cf.1
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694104719; x=1694709519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9b7v8ynf43I8EPh86qv2+Qihb/MMTTB3QC+Af1PR4Qs=;
        b=erqBQUWpDikCbUB6+kAcfHaoee3hO8LFhYiLCxqnh5DBrzrwft+ayYNV0MVeuwzRuI
         dOXsZgFYlnLpxPleaVd5iwz44SDiTpTffuD8zCY7xRYuKpdWDcO04mp/lbkVbCvI1H5f
         RPAmbtewtU923/zIQbFPoCN2nRZhMPMFdWqXj1EgtSxkDp5+uMDoTs+ePgwz7JrLjxXt
         /Yh1cJU6tFO4AAPkVigNZXiZjePIcwDakkRijJk0otgGZ7zRwfOxpVntkeRUFZ2IB09N
         CcK9/n3WFr7G+SJnNPWfdPk2nICmh/2EC1os1++YjxoLXx4SdqxrpVDs8nsFV+Z+G9dy
         Vqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694104719; x=1694709519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9b7v8ynf43I8EPh86qv2+Qihb/MMTTB3QC+Af1PR4Qs=;
        b=gvDJBPlrjk7VE1RjC02xQ0m5j0SiyWxSlKm+E+xtJsLPf88/PGWSih5vt3Kc7jFuG0
         1Yedu/Brd5Gni6T0ta1F0LOE68Bw0kKry8+0lKJ3Uu+z33yk9sKy7pMAWdb1+BZ/IRMJ
         4DMM477fkPBmrs/flg7IaWTHsJuUDdkiPmfZ+SukYqsFvX0wqe4JJ6aydyPh5b8tiaCE
         3C56i4DmPd9/T8hueB6TMGRgf/4GxQlpnGkpI/ngrx4In7N3PB1qgeE4P5pWvnGkzU/y
         GYw0PjEGFXMMleGCKphNCH0riHGONfp/UnHX0v8AwtPeTWNa3u2ONigTVDFxDQaQjdI+
         6UZA==
X-Gm-Message-State: AOJu0YwYbh2OZoSvtSYZ5QdghMR8MobNdrnwLTt0+BAwrN4UQy55jePW
        cZO//OkalVmEh8tMFL1LVqLjsY1Uf4UUHJ0hjwx00ndxiE0LnxeoDCo=
X-Google-Smtp-Source: AGHT+IFBMY2aVjLfU4IGVauVzzx/POp8es0I/Cix3TKhZtX3AA6hztSUPcllgbHHruPMjhuUvCKYwAD/N3CsJPq8yKo=
X-Received: by 2002:a25:bc53:0:b0:d62:6514:45b7 with SMTP id
 d19-20020a25bc53000000b00d62651445b7mr18630990ybk.37.1694070562057; Thu, 07
 Sep 2023 00:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-6-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-6-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:09:10 +0200
Message-ID: <CACRpkdbAeBQj2RUjj9ybaAiytvtgpF4PXFvX+S4C0ZVP0bb8Rg@mail.gmail.com>
Subject: Re: [PATCH 05/21] gpiolib: add support for scope-based management to gpio_device
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
> As the few users that need to get the reference to the GPIO device often
> release it right after inspecting its properties, let's add support for
> the automatic reference release to struct gpio_device.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Needless to say, I'm a strong advocate for scoped resource management.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
