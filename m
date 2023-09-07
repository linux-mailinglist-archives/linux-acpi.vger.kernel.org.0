Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FEC7977F6
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbjIGQiw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243031AbjIGQhz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:37:55 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37187D81
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 09:23:19 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34ca1aadcccso4799165ab.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694103733; x=1694708533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvLrxMQ1IidFWYQv1qbOrK7Zz+kctFqLG1SqA3KCV8I=;
        b=jMfym1kpLA5Gj3RhxLsXqyjrTWgrAsm6m0Y20PEWaFr9XfXcvwv1h6b4J+fd0y/gej
         3gVld+czv18ztFPAPf1eGJDW5mZz837VLkyzSioDI4cnL4YI7gY0rBfjlFW8IsQW/AbF
         4ZIXHAKpo56ejsz96OF13KsjiMb3awf1hEGVshFFNZWzeeYCc1JDaTZaXpMHy+X3YreO
         +K+Coh8oYO71CbuVFDIvSmaEy9yWK3/W6FUr8B/RLfnjJ10RFR6FdktTbBWQC9V3qxE1
         Mh1hl7uiIcNxdRBBdoauYAVEXFpoz6gKmMJAzWOS4dZnrAJ6Bgbd7y8JWs/KvkNVmRp5
         jKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103733; x=1694708533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvLrxMQ1IidFWYQv1qbOrK7Zz+kctFqLG1SqA3KCV8I=;
        b=Q6u5VN9xaYycaFrf195tUGCEywrkiukBkV+pYU9UaTDc/agATCAWTI5vvaWcMcHCBc
         nNlp5Aw+riKWuhK0lyWveqmBwEAHf+1qjInWzGFTV5WQJwYOaq+ZsQiKEX4PXmNo4MXL
         NEX/4+aDMgTY3acLwh1fO94P158yLV65awGuaa9of9+cd0qYwTgvc9UmV3QnfzU7OpHU
         6Qim43imJWMQWBMmbMzFxbX8hePVR4zR0xXfzsrJ+/Ywye7nOSR9bxoBtmoMuauFKHta
         zv7/590srM2m8JsII2foeS1DW5jEcP8QECqyYvsd+fX+GaRscz+D05nwMsmuEB9HSv8f
         zjrQ==
X-Gm-Message-State: AOJu0Yx1DuxDjtCNeg2i6S1lw/j31oLDVrEHOtgQaxhFFaxYfR3nJJw6
        MA2fKyU0MeNaPI5RrGB/zwZSsBP32SlQaO3eaaF2Gc8AlRbno/pu
X-Google-Smtp-Source: AGHT+IF33BsQs6PXZBD6Yyx6MLxtC5D3dCLaevE9AUQBN2cYvO/VBix1ip+znuJz46jocHvadEET9qd1DQq8TKxIbhc=
X-Received: by 2002:a25:fc16:0:b0:d78:be:6f02 with SMTP id v22-20020a25fc16000000b00d7800be6f02mr17528083ybd.11.1694071503985;
 Thu, 07 Sep 2023 00:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-14-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-14-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:24:52 +0200
Message-ID: <CACRpkdZE9hMWNeY=J0LrGTO1=83L46z69V6b7BX=Q-vaM3kBAA@mail.gmail.com>
Subject: Re: [PATCH 13/21] hte: tegra194: improve the GPIO-related comment
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
> Using any of the GPIO interfaces using the global numberspace is
> deprecated. Make it clear in the comment.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Split this off and send separately to Dipen.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
