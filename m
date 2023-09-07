Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C46A797952
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241542AbjIGRLN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 13:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241480AbjIGRLN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 13:11:13 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A57E7F
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 10:10:44 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a9b41ffe12so850213b6e.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694106586; x=1694711386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VX520/JAjo5YxFEs6vhZtWf0iQa736VrN0vgqzfoO4=;
        b=bIp1XI5WuK50n420V25onmC5yl6iasuOBMFz01qMq0J/HaMVu8Xi94N0y23H93dsIR
         pgPaUbnuMEliZsGkMH99ILVyb/8is40vXuVUZ3vpd+7MGTWMfn2O948/wryNxIrPWGOf
         q6tb4ye9nAvQZB3U9CINM9JB9bWqfPeRV3MgJYQ1tcIr03qFz78L/X8sP/gfOPlTMQ9U
         HiBeZW+UrveoAUbAAvFf6Kqo0F/yv2aJMYL+aTdt417dGcqUl9lwoEF1S/mG914OQ6j5
         0xIpUfmI7wjHc+EYbGS0d3Y8f+n8pWHP9N2xYMq/IJXxOxFHCENfkytI1y5Sd/h4zGCq
         yDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694106586; x=1694711386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VX520/JAjo5YxFEs6vhZtWf0iQa736VrN0vgqzfoO4=;
        b=B+XUkQz/T9kMslETLpg+SiY16OkuHj9mrQfltcghXuemJzbf3kQA/bUSnCYlX3ud8R
         SSBnU7obWr1zJsnDp7BvL2y+PkkureUeSK4I1ACbLIFi8LmQmcF8OfyOsnMxJwKPJ0Cf
         Kq/Ainj5xKhFDapJ0HV4pCETOgrVBPKnHISm0DjAzNLhqdCmyZ/gCq4FBZQaVOh8XVg6
         r2caYSx6J/OEgVoL8uoJ2pbdOEMIlBPZEW/9LZSum1cqRkvTwfoiv71ptvU0Wt5gPh80
         XQ7hXECnQfgKrFTVAQM+kqefctT2Z9t+g0dsXsN2wkToE03hDuLcZEW+16ATzMgys99Z
         tAmw==
X-Gm-Message-State: AOJu0YxDIfT053SLkplrebYAjOAFTapD4JHkHT5f9kJtCcCe0cg0qLZA
        VZmcjWPhJeqN1XtHEE3SIgDNY7HmnN+N9bpftyWk8M9SDOiMRdVF
X-Google-Smtp-Source: AGHT+IGsG5hJJbLxB8MJ18cSL64AbAsKmU8HUkb1gvXKq17Y/8ZLDXSkKoAPtcsGb/CfUJGklHIiazXnZYlmi1tiRYs=
X-Received: by 2002:a25:d78a:0:b0:d78:47a:d76e with SMTP id
 o132-20020a25d78a000000b00d78047ad76emr19559951ybg.49.1694072224500; Thu, 07
 Sep 2023 00:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-17-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-17-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:36:53 +0200
Message-ID: <CACRpkdap-AFmVFG_gtYeGuR5JFLgHQ6i7w6HRwKP4+pu=nd66A@mail.gmail.com>
Subject: Re: [PATCH 16/21] gpio: of: correct notifier return codes
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
> According to the comments in linux/notifier.h, the code to return when a
> notifications is "not for us" is NOTIFY_DONE, not NOTIFY_OK.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This should just be applied, right? If the notifiers already
went upstream (sorry for my ignorance) then it should be
a Fixes: even.

Yours,
Linus Walleij
