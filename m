Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D058A694284
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 11:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjBMKRV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 05:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBMKRU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 05:17:20 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6305D1BCD
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 02:17:19 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-52ec329dc01so136932757b3.10
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 02:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B/9LKJBt/uFWrt2eaPCZXoPKu9jtJqzqiT0yu2iiXgA=;
        b=OM2Q7Dz3LTR45PgX0M0nt7MxrcR2SsThReuPjqCBzPxd5c4QunEGEjp/DRduZE3xIn
         XPbEDm5u9h1ISmC3kXacdxf48PBPMYor6N97cjwrle9+odF9Upg5zlGqwyUV9xGl8DFK
         GA2bKWRD3tAs1RscJKxKKAO6PkP5+MyxizdbL9PCPCiD0i94tLKhkM88lUi7qNXuQkg+
         8oDO4qdXBEl2mkBfPrnLjFaR1/GBvFw9F5ZbBD/l0TpN549fZH9XbzytNOFJd6XE8VuA
         Va6XjRrqIXwANHdCOdRNtMe0szAiHpQ6YEazgheQEgq2JMEkIFDR6zmnfInMNNqX/C2s
         ivEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/9LKJBt/uFWrt2eaPCZXoPKu9jtJqzqiT0yu2iiXgA=;
        b=ZicXaE4t06NdzsramG/zEKY+PgfID0VyM+k2HdVduhK4CDMGKZqGJf8V1Zkq1c22dS
         nb44zi83bIxl3DTjSUusSstL4Xsyr08gkHbWGSqsp7MnKN05YCZltcswBaqtlDYJy9te
         Y2Ol0mJzc/RbqTN3T/spFQhW3VwwkIVDagRg3RSlFuanR9nouZqEazlm4HCuPty8ZLMQ
         M4cy2G2h/P9vr5+/k0oVJfaIGyrbDSQclvSCCXxFe12ijbTQn6dXqhfOAdoGuZHaRGP7
         dCvgJuJe3eWTiWJb5QDeNRTAV+JfHU9uAK8ynf1hdIsgrrVM5owBLct4jJliW6tg7s/e
         wvAg==
X-Gm-Message-State: AO0yUKXMJQ0xBFc0xuHNh6UA4Rid8upR2EXhi5oHRx6frT9ynQ90c6ac
        HxG02ZXHZDT8ZiMKg2D2YlZwfMHCnrhNYux3AVhIJg==
X-Google-Smtp-Source: AK7set+LOXZf9z2fNtm1MlC7Tu7YYgsXp5XaxlLDCioWXk45a/E7fhy5d6++PstBOHEi2eCQ0PxXdO+s20DwzyhcA3o=
X-Received: by 2002:a0d:db96:0:b0:52e:c7a1:7439 with SMTP id
 d144-20020a0ddb96000000b0052ec7a17439mr1206379ywe.384.1676283438656; Mon, 13
 Feb 2023 02:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20230210150319.200799-1-asmaa@nvidia.com> <20230210150319.200799-2-asmaa@nvidia.com>
In-Reply-To: <20230210150319.200799-2-asmaa@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Feb 2023 11:17:07 +0100
Message-ID: <CACRpkdZB6nqsuMSH1Aq32kMcJuC29W987eUOdxNb37kx5KQ4tg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Support NVIDIA BlueField-3 GPIO controller
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, bgolaszewski@baylibre.com,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 10, 2023 at 4:03 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

> This patch adds support for the BlueField-3 SoC GPIO driver
> which allows:
> - setting certain GPIOs as interrupts from other dependent drivers
> - ability to manipulate certain GPIO pins via libgpiod tools
>
> BlueField-3 has 56 GPIOs but the user is only allowed to change some
> of them into GPIO mode. Use valid_mask to make it impossible to alter
> the rest of the GPIOs.
>
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>

Excellent work Asmaa,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
