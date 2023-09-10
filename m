Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DC0799D00
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Sep 2023 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbjIJH46 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Sep 2023 03:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIJH46 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Sep 2023 03:56:58 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1A1119;
        Sun, 10 Sep 2023 00:56:53 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3ab29af398aso2551385b6e.1;
        Sun, 10 Sep 2023 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694332613; x=1694937413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfQwzmp/QfTlKmvI2XezXECvcbP5+n4cc8pReV4gkdM=;
        b=jlb62vKl7ScdswoAk81yE9Qa5hHqD0vwKH8Wi1GAWIqVWVmmZ7BvW7TLMuyLBoEMrj
         9zaroQ9d8r619hiaDPnSI/3/XikTsEtCxnqFGTVpdHPWtLX8nE5Wtknhz6FHpxcD0jzE
         ZolEigENlI5ij0bstY8k9K0cXBcJGmCc05r6Lsx2FOQSvK0tUN7yTAOAPD9AUpNyEJYh
         JR1JmiVPbda4S9037e1CZyG8vamKrJcho28uYKJ8iF8gs5t/8RvC96L8mLTwhrYh/KwO
         R11g2qhu9e6TvWx9h0RvsEr2hR0GztWBlyIUJ9Z4tV+6wXauZ2lRgh+lzQFIFT20Vm9+
         prUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694332613; x=1694937413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfQwzmp/QfTlKmvI2XezXECvcbP5+n4cc8pReV4gkdM=;
        b=ALQPc5F1QCQftSDybKDOVcjD0Bfxh59Bq+k2jAeos0a6WL+Y48IYb0J6gJJZKZYlKm
         nwzVFM3YIHk4kBgvU43Ys8APwNIQFGVqXreMlDz6nNwDChdol16ukvixS/rlKwWfR9XK
         beWcA1ztNB8JxELwqm9Rs0FMO7ZAz4JEolQyEEcsjpQQoH1tfAPjuInGr84WQcT8ooO+
         6qKgNuixz8wOIKl/j/ha34RkHDgB+YjZ1u8a4z4aWME33VoHDlanD3XVsy5+vZy71j0q
         CDVP/nouZFOVkzx7ewxutPQj+F7GEDUbky3x5e72RHl3m08LXaP9rKdduY75ADpVfQkm
         0mfw==
X-Gm-Message-State: AOJu0YxkrKGcpNSH73fbyteRTARXFljXAf5nksqjIXh1cjp2b7mf09lU
        2yRhfad3K0oTuC0UQBX3QARN22Fofkwf6ZZqDto=
X-Google-Smtp-Source: AGHT+IGQnEkhsftttSb9t1QhoMmAZod2MIn/IFjSX99d6mzYdmplvffEfCmKjV5hd6y2sDB8b8freg5RKft40tjamLQ=
X-Received: by 2002:a05:6808:8a:b0:3a7:9e5d:4c with SMTP id
 s10-20020a056808008a00b003a79e5d004cmr6697060oic.37.1694332612841; Sun, 10
 Sep 2023 00:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-5-hdegoede@redhat.com>
In-Reply-To: <20230909141816.58358-5-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Sep 2023 10:56:16 +0300
Message-ID: <CAHp75Vd4WhMy8X_g76zGZCpD=vyHzM7=Ouq1mVBxq1i5ZCDY4g@mail.gmail.com>
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
> x86_dev_info.invalid_aei_gpiochip is no longer used by any boards
> and the x86-android-tablets code should not use the gpiolib private
> acpi_gpiochip_free_interrupts() function.

Shouldn't this patch remove the private header inclusion as well?

--=20
With Best Regards,
Andy Shevchenko
