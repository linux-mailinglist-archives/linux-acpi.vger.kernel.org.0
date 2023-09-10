Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749A1799CFE
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Sep 2023 09:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbjIJHyb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Sep 2023 03:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIJHyb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Sep 2023 03:54:31 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECCC184;
        Sun, 10 Sep 2023 00:54:25 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c0bbbbad81so2017446a34.3;
        Sun, 10 Sep 2023 00:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694332464; x=1694937264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX1Q2nwlhcYUquDHIXh6B6NEwXl59fh7IBcwLYScDxY=;
        b=cuk5NmcQxYHkNCTzhfbcNYKtj3NrwK7UrK7sy9tBRYW70vlNqb04sdgeeNTajRVlGs
         eb1V3zs+pq3AmDvK9QQ9Yg6Ejf/kWEw4mjpLHuaIppSVLaUXEeN3o1auyA51uSVr7kEH
         plE9Lw7oOJCUmnVrZ/mqvbeLW2nOIyRWlxIndZnv0PHbnoNh7VoJVIUB0EYC2/44rz93
         /fTDI7SImXKDSMg6IXPC+Ry86QjKdWUEW1CUp8b3EMfcxe7v3cF9vfuYkpY4Urzg1TD/
         qcR9IFfeDrJBtZrrAOWu18dFpiwaFu2AyVujCxCtG6Ogj0W8inD98FMGeZeauBnwh0IS
         DaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694332464; x=1694937264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX1Q2nwlhcYUquDHIXh6B6NEwXl59fh7IBcwLYScDxY=;
        b=GNzo1vN+YanKB2YFTyFPsfbf4H3lkRvQHjUMFed1z1C7kiTDS31JjzSDdzT0DmF2hP
         1U96vXRXJFjXX64jTBnHphDxkaYnmGVZ4KA8cNJGBYz9HZCwzhS4tgzkYGQg3UQGVvFn
         nQx6NruDGg1VLAWLTg3VbYmybgW/XGL+C6pqMkWBGKYbq+msFX57lNouwa5Uj9nkelyL
         7KfqWNsNY9yleyD8R7mOH58xgQ75H90gvNyWJtcele8OLOEUwK4sTDM5QTkMjl85Cvsc
         YrG/eib/TepHnkRTjjx4MwEW2Wad9E4n2cdn0djFFSWE3qDz4rbkh64NClAJ3XK3yfQm
         QafQ==
X-Gm-Message-State: AOJu0YxoV5Z7PhdHi7+fY+pGtEXbTrIsQzikDHzUUBdiwFrjArgUCVES
        ixF9ytv8McCs0bApxmrblMOAQlJcfvJ/Tf04LDQ=
X-Google-Smtp-Source: AGHT+IGB+FzL7gU4H3FecuelP1lJOcBVKE03ZP+bhexZXQ2vPNn9a6uLU/gXAxMcru4Hy3ehk7mzXP2lzjAjfHV21SQ=
X-Received: by 2002:a9d:6d02:0:b0:6bf:287e:1afe with SMTP id
 o2-20020a9d6d02000000b006bf287e1afemr7824709otp.30.1694332463917; Sun, 10 Sep
 2023 00:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-3-hdegoede@redhat.com>
In-Reply-To: <20230909141816.58358-3-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Sep 2023 10:53:47 +0300
Message-ID: <CAHp75VcqjoxbNUfVYfrmvttFgBHEQZ7zOmC6vJhE-G7p-joD3w@mail.gmail.com>
Subject: Re: [PATCH 2/8] gpiolib: acpi: Add a ignore interrupt quirk for Peaq C1010
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 9, 2023 at 5:18=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> On the Peaq C1010 2-in-1 INT33FC:00 pin 3 is connected to
> a "dolby" button. At the ACPI level an _AEI event-handler
> is connected which sets an ACPI variable to 1 on both
> edges. This variable can be polled + cleared to 0 using WMI.
>
> Since the variable is set on both edges the WMI interface is pretty
> useless even when polling. So instead of writing a custom WMI
> driver for this the x86-android-tablets code instantiates
> a gpio-keys platform device for the "dolby" button.
>
> Add an ignore_interrupt quirk for INT33FC:00 pin 3 on the Peaq C1010,
> so that it is not seen as busy when the gpio-keys driver requests it.
>
> Note this replaces a hack in x86-android-tablets where it would
> call acpi_gpiochip_free_interrupts() on the INT33FC:00 GPIO
> controller. acpi_gpiochip_free_interrupts() is considered private
> (internal) gpiolib API so x86-android-tablets should stop using it.

Yeah, OEMs often don't know what they are doing in firmwares...
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
