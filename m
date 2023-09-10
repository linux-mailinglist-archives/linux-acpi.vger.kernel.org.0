Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C52799D02
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Sep 2023 09:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbjIJH6b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Sep 2023 03:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIJH6a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Sep 2023 03:58:30 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01412119;
        Sun, 10 Sep 2023 00:58:22 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5733789a44cso2107759eaf.2;
        Sun, 10 Sep 2023 00:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694332702; x=1694937502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6JkbpGm23VqArqnWbnu9q1q4gylGr4lX79IUeTB184=;
        b=fX4YWLKwwJRTrPGl2HUtVYlc4WOHvOV+hoFD6CViF8iRn6PDHaAO0Pi9NXEEVm3Y+T
         D2vpWEbIpyFA+0C9SEFNK3sr0Hcx/g6pL4CpYPCLdDC1Zidme9RmSKgbQ9H1p3CFVQzH
         Ac+QHA5w4bZ3ZpJ2IceyJzEUvLR0cd7ZgYjhxevETbIJVclL5zczgEoRGiJ7QLPIYK2+
         t7M8tuqv2IO6OSkuXAgfSYpehpP3h4P2kz07UiheSl9eNXbDQ2TC5lFk/ze4nNYvTcRA
         lv8s4dhILD6rQyZTdQF+/Pv1Xi7h559LblGYnEery6m+8ZJl43ZyjvtZdSjpjF2RZTJL
         XQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694332702; x=1694937502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6JkbpGm23VqArqnWbnu9q1q4gylGr4lX79IUeTB184=;
        b=NkkT8qNDvGc+IORpnb9SV4uVasZwBqgBTpILZ9HNTRefX2E6FBps0hbc/HQnaI4uWM
         7e4gqjr6yTut43UE0vOFu6hJ8z2toV3NLIVdDG/xzq1tQ/uts1cx6XSV5BX8JVtyOXRt
         WyAI034AO5HpP40cKzS5PCb3OwCHVkUFkgPNOcs5UP/xOfeLrZFNqHD6+3ubQzen7d9G
         vXiBo78rvsx/ZGlEc2b3T3RABOq1xg3NYmqOOp2McGPuLiN3ZjrpvKG5lCqYt/67DYwL
         JoWIBAyU/uCXS2zzGYjL2SQu405DOSXgsNuI3GrJ+j7vzPeyBIhTCSYJiknmP9+X+xyt
         lzzw==
X-Gm-Message-State: AOJu0YzTXyR5mjIJ6hwhCwYwlocx3w4CDd3QE/kzlpLchzUeWac5ycvo
        /kkBUucmuRKUUmTEU8ymvIonFkzbM+98OsJ+j2w=
X-Google-Smtp-Source: AGHT+IH4XFBoR8uKJossMcbs5BhtI49Pa+up0xxXjEY1AbN6EWvI8+I8twK84xgIF1QOVOlsxbvuexZ3M/HfqHKUsiY=
X-Received: by 2002:a4a:e742:0:b0:576:9392:f7d1 with SMTP id
 n2-20020a4ae742000000b005769392f7d1mr1798956oov.0.1694332702326; Sun, 10 Sep
 2023 00:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-5-hdegoede@redhat.com>
 <CAHp75Vd4WhMy8X_g76zGZCpD=vyHzM7=Ouq1mVBxq1i5ZCDY4g@mail.gmail.com>
In-Reply-To: <CAHp75Vd4WhMy8X_g76zGZCpD=vyHzM7=Ouq1mVBxq1i5ZCDY4g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Sep 2023 10:57:46 +0300
Message-ID: <CAHp75VcqeONkeX+F8hvV-gWOpeFjNHoeQGEQUr17+Hpbfu4HFA@mail.gmail.com>
Subject: Re: [PATCH 4/8] platform/x86: x86-android-tablets: Remove
 invalid_aei_gpiochip support
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Sep 10, 2023 at 10:56=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Sep 9, 2023 at 5:18=E2=80=AFPM Hans de Goede <hdegoede@redhat.com=
> wrote:
> >
> > x86_dev_info.invalid_aei_gpiochip is no longer used by any boards
> > and the x86-android-tablets code should not use the gpiolib private
> > acpi_gpiochip_free_interrupts() function.
>
> Shouldn't this patch remove the private header inclusion as well?

Ah, it seems it uses more than that...

--=20
With Best Regards,
Andy Shevchenko
