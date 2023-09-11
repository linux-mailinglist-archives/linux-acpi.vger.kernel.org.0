Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3726579C012
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 02:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345353AbjIKVTn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbjIKJu7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 05:50:59 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C4FE44
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 02:50:55 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7a257fabae5so1679717241.2
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 02:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694425854; x=1695030654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5UYe75FP8toYURe1y5KQ1BGMkvcZaEW0CyeqMEnRyk=;
        b=IUSU0ImG9M85d23hYzB7bpDBI94yAXU7yb3KtFO22tR9KyhGzTYX8UrG7x/myd3q72
         uTFgJOAzv9jw3BpJKVTTDuP4YwYVAdX21idzyoCcMOdqISTqCFBylIocj4WU1o/GHxs6
         PV0qMe1e4vPgdHht2mLV2pqRbK1wE+BFhRJ3ka4+mACjKue9AWjL2ToE+nYZJlB2gRR+
         RPxqCBSrPbbkpxeXabtLTE43/NkkH/71EfGofjq8v1QTQcrtLiWtmKvw4AJp3cNP6sm0
         ajLskmIq/Ub165cTMCNLv8IoL7bViLPYWUVfJAD5pIeUv0MPsd44ConNMJJWdsVIbszi
         Jytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425854; x=1695030654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5UYe75FP8toYURe1y5KQ1BGMkvcZaEW0CyeqMEnRyk=;
        b=cv2MeZTZq0xA724zc1Hmqdm96AYt5GlpVhkEoDEFdEVmSHSMQDQB3SSYWfQFl2Ws+Y
         4TysMLTsLsBR8f5D807FLweZKMrfktWLOVy0PPZ3mjY1s2Vn6ETHOx74DcWlt46iXGjn
         7jSrTiiMis2Vs6m8oJgEa0ScQDELVTNufKK4NW3LLyk9o6lftb0bSS/UeV/HMaLp5wBC
         3/cNYNXjrmLO3nj+q943uGae6zpfZAgGJobo/cQk3G4ern9YBrhAQcVupP01ajhsehHa
         voHToB5bIYUbK14uDi4pPyg+aM9SC6ExjWJARSZlG+6P8R8SLeX8gYthnpQ6Xi9AYKws
         wHFA==
X-Gm-Message-State: AOJu0YxH4i6xGmxH8n9ctkKv9H9p9wD2NBZZLtW+qHrLWFjBune5ws5D
        dS2tF8mjAFDPpg7pxx/Oy1MVhlIqMm+0DO6JiloydQ==
X-Google-Smtp-Source: AGHT+IEggNm68Hr3RRD2F35KLRNwrrw6//YEgnoVHrVVzY9f74otc6OHWj8qqne2MLlaWMad6BNeDq9fIoKfbNoyalU=
X-Received: by 2002:a67:fd41:0:b0:44e:dece:6b38 with SMTP id
 g1-20020a67fd41000000b0044edece6b38mr8040621vsr.23.1694425853682; Mon, 11 Sep
 2023 02:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-2-hdegoede@redhat.com>
In-Reply-To: <20230909141816.58358-2-hdegoede@redhat.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Sep 2023 11:50:42 +0200
Message-ID: <CAMRc=Mdtbnc-uktsgG4rRMRpRfSO7a+6wCQZZgr3Q7uGKprbfg@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpiolib: acpi: Check if a GPIO is listed in
 ignore_interrupt earlier
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 9, 2023 at 4:18=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> In some cases where a broken AEI is present for a GPIO and the GPIO
> is listed in the ignore_interrupt list to avoid the broken event
> handler, the kernel may want to use the GPIO for another purpose.
>
> Before this change trying to use such a GPIO for another purpose would
> fail, because the ignore_interrupt list was only checked after
> the acpi_request_own_gpiod() call, causing the GPIO to already be
> claimed even though it is listed in the ignore_interrupt list.
>
> Fix this by moving the ignore_interrupt list to above
> the acpi_request_own_gpiod() call.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
