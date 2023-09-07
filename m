Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCD779737B
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 17:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjIGPYc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 11:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjIGPVs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 11:21:48 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B6A10DF
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 08:21:22 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5922380064bso11401247b3.2
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100082; x=1694704882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoLVfI/Qa17hM0LLGxXlqleEL6Bcc6ph7u/GtpOctOM=;
        b=k75YBGrxve1OUKukHeNqufsKQcHuyhOkeuqAuIplbRrb1zqeFu3yuqiSK7eT6zMiRn
         RogVmrPwGTflfWsYRFjxC5u72CwIunuh9OLKO526A0HNXRX1u18g0WqB5uwHlwu4K244
         oW/AvVbs2M1yo2BaLahuUabj96zOTKz3khOlCptLSRPMx1S0JEwtzBdB7Y2LxoXd/6gg
         2DWH8YY/o5jr69FVicXnmU/nwZZNU0EUPT6vvf/ciNva79wbcjnpl/4/7DkoIiDtKaVE
         x1clNKdq8StXhcjldh23X86iQnJ8AiFRgEhYQbCFnFkUx6qwysfCf4muWfWOS3I7HPA5
         55jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100082; x=1694704882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoLVfI/Qa17hM0LLGxXlqleEL6Bcc6ph7u/GtpOctOM=;
        b=Q5Uv8PSG71Ifp5Pu99M2w+nBhTOeW1KrFIF2IWHqVkQ/ECLRsmkIVdI+rUVe9mUevd
         5HLH/NnHJc0ZTJyfLLdfZEqDICuVBYQcnOnbKEQVVtbHYgZkWi7iG2qBsKDtdoXu+3r/
         Ek1e0ncW++s2BEEeP0c/WQnyee5JCokMncSAm9VJNLVXC0LJiisJ2c7sItASK6WGVoG9
         1mqyqa1sD6m4utoqLSNU/ZRaDFIWpRUHOYVCczklrBY71nPougtLNqBU8ppTA2Znn69f
         5GRnKlsjuM4XtAtwzUpIbew+K2yVCPWiCfTDqi1Co5fSuCPMHotP2ZE+8yybONkUIQ3X
         WMTA==
X-Gm-Message-State: AOJu0YyOiuuU9u+xr6X0w5g/KP5JOpfRAEOucAsjUpvvARb4SU0qFSOa
        SHZiekcF+2xhhHL2Th8vvBvueqFFKCCLoRoA3vCtPSi5pGJkMiXq
X-Google-Smtp-Source: AGHT+IHG0TBlmxyoTQFIa7FFpqQqYMcVr4pyVQslrpSztqetV//HxeApegU4hZ/YXLQ350AtIlPtITxSVFId9gOqRWY=
X-Received: by 2002:a25:40a:0:b0:d7f:7690:d865 with SMTP id
 10-20020a25040a000000b00d7f7690d865mr6786114ybe.6.1694072130152; Thu, 07 Sep
 2023 00:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-16-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-16-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:35:18 +0200
Message-ID: <CACRpkdaLKqNM1xMCo9jz1Pe_18A=GJodbaTHL+VmoRZa5jJbjQ@mail.gmail.com>
Subject: Re: [RFT PATCH 15/21] arm: omap1: ams-delta: stop using gpiochip_find()
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
X-Spam-Status: No, score=0.9 required=5.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Oops one more note:

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> gpiochip_find() is going away as it's not hot-unplug safe. This platform
> is not affected by any of the related problems as this GPIO controller
> cannot really go away but in order to finally remove this function, we
> need to convert it to using gpio_device_find() as well.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
(...)
> +       struct gpio_device *gdev;
(...)
> +       gdev =3D gpio_device_find_by_label(OMAP_GPIO_LABEL);

This leaves a reference to the gdev right? No scoped guard?

If you leave a dangling reference intentionally I think it warrants
a comment ("leaving a ref here so the device will never be
free:ed").

Yours,
Linus Walleij
