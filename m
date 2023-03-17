Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB0C6BF35C
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Mar 2023 22:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCQVAT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Mar 2023 17:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQVAS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Mar 2023 17:00:18 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60341EBCD
        for <linux-acpi@vger.kernel.org>; Fri, 17 Mar 2023 14:00:15 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-536af432ee5so116978157b3.0
        for <linux-acpi@vger.kernel.org>; Fri, 17 Mar 2023 14:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679086815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pSPDsSpYr0yzHIhE9QqHD/oXvXGj/zx+/wwbZGGiKE=;
        b=TLAPZObVbM6RimvFIq982tCnrphh2E8b4WnAsFslm59mu9C4n4OLg2kQev1+xjLbg+
         2mitKhD5cGv5G0XN85Rp4tPSNxVr85FQkGJGSwdK7KmCwJlM9e3kSu9hoM9x1IkIi/FA
         KEkxamYocSxlBIZKihAGoh5y8a68DWfU1du9MsCvsWkDvnf+uZZqM5N1n/Wp/CsSGO0p
         jSariuFyMrAx5ZnvxcUe71YEAwSQrFdGoEtyq2PudpolSPN3Yoe5lF3DAliDLyiT7h4w
         DeeKwiRKTDJO3zD/+N4mYgfokEIrqie0/2tPnMxROJ5K9GRx/jKrfJ/S+ws05JAf3CXr
         0lCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pSPDsSpYr0yzHIhE9QqHD/oXvXGj/zx+/wwbZGGiKE=;
        b=oDYFJk8QpLnBnewcpdHPbBIqkhG++s18LEZ1XOcYD3U6Ak1Q2xBPv0K3WfYzpL6XZD
         vt/3P9MgRe1OtIhHGvuOjDOVrteWk2LIU5jfYpDq0K4pu1Qhu/7PSTZ33VblGMJNUo3a
         dkwCZ/os0kHQLLAGvlTZFtK40FBo1dMvFuibMgB5SDRkoQXo8lP9lE50lORLxTrkTLyF
         vZ4QP6H2Qdv+sDXX2ZNm8n55aCL7SYx89m8iEgCCSkO59QOAyZz0jZS8Y5wJhLfonMu+
         Kikc8wq8w8f/qsOub1pI/nq6IuOPm4UU2XzLuktSC2Naz7mbdQzVX3RZto8pI14yjviu
         vtEg==
X-Gm-Message-State: AO0yUKV66pWHwZmbirMbv6dicWqE0LiiISZJI3/cvek/X79RBgwVVt4P
        tS+UTmUUPfQjcqj/5g1Iz95obVgmJVlxl3f/GbuypQ==
X-Google-Smtp-Source: AK7set/QsTUG3EEsvs9ExltdFx7/LqW6bRg6UIEkaEIPkBXihYNrXoghB4S0x7WKrIwB3mTvAVKhXTm20ajPQWcQ48Q=
X-Received: by 2002:a81:ac1f:0:b0:541:9895:4ce9 with SMTP id
 k31-20020a81ac1f000000b0054198954ce9mr5307886ywh.9.1679086815073; Fri, 17 Mar
 2023 14:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230315215027.30685-1-asmaa@nvidia.com> <20230315215027.30685-2-asmaa@nvidia.com>
In-Reply-To: <20230315215027.30685-2-asmaa@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Mar 2023 22:00:03 +0100
Message-ID: <CACRpkdZwpU_ZSC2KnTjgMCwKY8iDcBt7EyEUipSm0caMUG9BxQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] gpio: mlxbf3: Add gpio driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     andy.shevchenko@gmail.com, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 15, 2023 at 10:50=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wr=
ote:

> Add support for the BlueField-3 SoC GPIO driver.
> This driver configures and handles GPIO interrupts. It also enables a use=
r
> to manipulate certain GPIO pins via libgpiod tools or other kernel driver=
s.
> The usables pins are defined via the "gpio-reserved-ranges" property.
>
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
