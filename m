Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E6C79A5D9
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Sep 2023 10:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjIKISr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 04:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjIKISq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 04:18:46 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260E7CE7
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 01:18:30 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58e6c05f529so40983327b3.3
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694420309; x=1695025109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3FtP4eYfLciH8NMTppInh1yd0cZJOo0SC9UK5LWqOM=;
        b=n/Fs+Yw/XZiSsoksmVatDxI/qFr2a96lZEmYxEzOPGRxJQOUTzz8Hn6ajrEIcw4SSZ
         vKEgH1oeOcYsbAfA9mxrL1ZPxN6DF1Z2r1x/D8B8tH4wALHhPWgIaI6b7VoOjTJcRj/F
         P0Ns5F1HG8EW1Gf+t9f2z5E9s2AG4B05GcZH7VprhYGhG4LkUIcahPIGk56tx0T/xMi1
         gmV3/xszPZTU/WI3uQYJS0V9kEWueY94KIbiz2Bn7E0p5K78Wtzl3dibjsPV0L38bt9l
         nIxcwIcVj2inZ8B7LPuOSgWpgBlMPoKTNwUoYoG+L9E5tnOCmYRIX4r+BkdmDAcpWIDM
         Xr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420309; x=1695025109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3FtP4eYfLciH8NMTppInh1yd0cZJOo0SC9UK5LWqOM=;
        b=m0lpW8flc8ZBpMaWmVrSftnamkQAj/57YaASFNP3MH1X7VjIISZzl9DMvb02CizJqb
         tnOLX1j/7nwUd9AOXOigMpYdvk8VOfYSEl4DUScJJoSzz+SsIWXerZwKgqUihFxDH3KQ
         sa/HhCMcifMwVkHQS1jZOr+dOGVLiVKeW2u+1uSyEdJ6g/6xvPM2Eea2qgCHrhXYAobK
         d05eUUaLjMQ8//aH1NTXQDRx9nDB6gd/8GpILjFhoYO+G16pHHvxm4wqO2bW/M+M12Xp
         TH6f08RqcUImzMiJikP+PtGDG/nrwsLdOmjgLOSbeP40OwcEfxQmtkNC2y0nNNt6C5Ea
         A73g==
X-Gm-Message-State: AOJu0Yy/O35soAwq5ebaa6TmIS3ty1ACHDBbgWgv2L5AR5E0yfGyA/N9
        RnYl5t/SEZy2BnwJ6X5V8gTUj7oJSCS74FBeGeL1PQ==
X-Google-Smtp-Source: AGHT+IG6UBPsG3ER528i9u+4r8BVScL4ahYE/NA5v/zdBiZoZtNwPxGro0BQJVKq2AZUOGGOK7dxSEsNfSot8t1uxn8=
X-Received: by 2002:a81:490e:0:b0:583:9e6c:eb69 with SMTP id
 w14-20020a81490e000000b005839e6ceb69mr9522290ywa.42.1694420309307; Mon, 11
 Sep 2023 01:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com>
In-Reply-To: <20230909141816.58358-1-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 10:18:18 +0200
Message-ID: <CACRpkdYOan92797er6==bvTWVrNd5EepYVts5noZvEdwf5AJsg@mail.gmail.com>
Subject: Re: [PATCH 0/8] x86-android-tablets: Stop using gpiolib private APIs
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 9, 2023 at 4:18=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:

> As promised here is a patch-series to make the x86-android-tablets code
> stop using gpiolib private APIs.

This looks very helpful to me!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
