Return-Path: <linux-acpi+bounces-270-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA2E7B269C
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 22:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E5C47280E99
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 20:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9B014F98
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 20:30:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A26763CA
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 18:40:16 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E26180
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 11:40:13 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a229ac185aso10411687b3.1
        for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695926412; x=1696531212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y95bvgZdeDdsBCYjefAKBMoB3y5noRiDCdm/BR1RHRI=;
        b=YiNrvilf3OjZrgklSJXf16yJ+b+yHoByVR5EyE7zT6qfm9MYUUnn2Kt64rGzyK7Q/X
         UqNoSqAiaoqRUt7ju4alkfR44Z77BELWSQ2DUE7+ZgVDl7dlBicJpp+vDc1QMaqNTcVw
         DU/zyL58ZPoY3KE/Vjs3nFcO/GL75heiZZAA8fLOKMSmMrKesjq+Qsi5c6pk+i9GWKB3
         Qc1UEkbHum5PBhbuGVUzHhYLudnBEmdOe9bsUQkJfWvRNPiZjYo5EjlKKyAeQTC5FrAz
         vJT0d9btmkIQ1qGyJ62y39/GQS4N+QnoySQ3PX+9KNX2n95AvFrKmULToW0rLWETVtYr
         niuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695926412; x=1696531212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y95bvgZdeDdsBCYjefAKBMoB3y5noRiDCdm/BR1RHRI=;
        b=pjydCe1eXz5q7/dDhTLsVyK1rx04Hvpbi4jgr5SbVbWWcm+WdDH0/2NQzd7MGAy+9v
         F44TATkPI0+/IEvN+PqOY+DE2vhIMzYSUjugGXGN6iqDnOABRbWmy8bdssCsN/f4sbm+
         7K+2cxXXSs4kxEJWOD+DAiCecA1JACtnM1QnQLA8YUJ8S7kJBjZLOqrJogUIwiz67cPf
         89l57nhbO3ykB9YFkCpt1EDjIxE6KOGNJpDg4a3tBRn3adPT5g+8AQumdObiDa5DyHS4
         H+kxMtlz0Zk7oqK2wVUEB61oITkj4Hq1ys+IdiGbafQs9t5y/vN1BFGqb97iz12Uqlk4
         0KBg==
X-Gm-Message-State: AOJu0YyZw7oeY8qV73RoMYOmF/bGMd3jsneknj/GRpb/G6Vrn0NfmTBX
	wcxI2YJT4aveWJqT9cI22BeaaIMJHp6XV3pgJ0EV9u2NHzpgx8yu
X-Google-Smtp-Source: AGHT+IEStuY1jaSYpbOeINbGsBAxa0XDn+/8B2qloC+Mkxuq1vgTpNjjiaenDAt/S2ypr6HWq4hm9r+CIRrUYbmmqkI=
X-Received: by 2002:a0d:d410:0:b0:59b:c847:bce0 with SMTP id
 w16-20020a0dd410000000b0059bc847bce0mr2110790ywd.42.1695926412719; Thu, 28
 Sep 2023 11:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926145943.42814-1-brgl@bgdev.pl> <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
In-Reply-To: <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 28 Sep 2023 20:40:01 +0200
Message-ID: <CACMJSetWH=Z5ubHb33W0mYvpqkU7vv=nKNBSa9eLmAi94NyrgA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] platform/x86: int3472: don't use gpiod_toggle_active_low()
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 28 Sept 2023 at 14:40, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> Here is a v2 of Bartosz' "don't use gpiod_toggle_active_low()" series.
>
> New in v2:
> - Rework to deal with ACPI path vs gpiod_lookup.key differences:
>   acpi_get_handle(path) -> acpi_fetch_acpi_dev(handle) -> acpi_dev_name(adev)
>
> Regards,
>
> Hans
>
>
> Bartosz Golaszewski (2):
>   platform/x86: int3472: Add new
>     skl_int3472_gpiod_get_from_temp_lookup() helper
>   gpio: acpi: remove acpi_get_and_request_gpiod()
>
> Hans de Goede (3):
>   platform/x86: int3472: Add new skl_int3472_fill_gpiod_lookup() helper
>   platform/x86: int3472: Stop using gpiod_toggle_active_low()
>   platform/x86: int3472: Switch to devm_get_gpiod()
>
>  drivers/gpio/gpiolib-acpi.c                   |  28 -----
>  .../x86/intel/int3472/clk_and_regulator.c     |  54 ++--------
>  drivers/platform/x86/intel/int3472/common.h   |   7 +-
>  drivers/platform/x86/intel/int3472/discrete.c | 101 ++++++++++++++----
>  drivers/platform/x86/intel/int3472/led.c      |  24 +----
>  include/linux/gpio/consumer.h                 |   8 --
>  6 files changed, 93 insertions(+), 129 deletions(-)
>
> --
> 2.41.0
>

Thanks Hans, this looks good to me. I'd let it sit on the list for a
week. After that, do you want to take patches 1-4 and provide me with
another tag?

Bart

