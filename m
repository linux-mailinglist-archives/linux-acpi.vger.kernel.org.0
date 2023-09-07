Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8167797540
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 17:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjIGPqk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344817AbjIGPdv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 11:33:51 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A931FC9
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 08:33:28 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-590685a3be5so10992717b3.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100783; x=1694705583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Rz9GiS8mTfnAVkN8QSO49dpqTEISv8k2Dk2MfoLtSg=;
        b=A3GHXhtZeE2rZOD37asQ+zH7LTglTM7FSAlKuo3pgKb0ws2DTYBpmIYJSyWLNVYxGn
         dUwrAdohHCAe0X7ZwLr7P4ml3W5dye3TA/Z7/CgucPlCsnJxlVwxpCR/iA6QnO/detBT
         KwXvRpxqwciDL578V8xeIB8jVebOx0gGi03LU0F6r7eYDzekGMO5mI4eWswTwdNf0fvS
         sYVyjw4jCSliDuSd+FPrZovkfbz42KyPfi/oIOejBwZvuQpG/UqYh1In18lQZQPAslF/
         8Si73cmnX32f6AgtT9ppxOMXG2OrDIE/GlFC0OtZPC7oH+MoeI1zswiJ5T5+ysrrkZ7N
         1JHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100783; x=1694705583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Rz9GiS8mTfnAVkN8QSO49dpqTEISv8k2Dk2MfoLtSg=;
        b=b+IzticFMCazbAC9o1BZcs6gelCuoTd+/KAJtF1zpDhB5sFjG4NCL1KZ58dEcVEj2k
         L2tAfjLg4aXIZ5eQhh0/Nf+EOdA9X3KsrvlmZH/3T8TmAxRlvCdWlbJt86aG5FZam0Wt
         Ao2LuwwpMQMMlQLb4wrBJmYH4CPz7iYubwYvmNZ0MpvfN/3wU8xeD0ILLT0bBATzepCD
         SZE4RVZtSJFrjXySwqBwsu9kLRYdEuqsM6D5j1/I15NxmXqVo6krde/hce8SepfNQOns
         oX9fvyeL3LfiBk0nzpjNjCPgIX+10Enn31cuw0DZCuSDaask4Hs12NdbRv5YO173tPwA
         y05g==
X-Gm-Message-State: AOJu0YyGxBv9I+fsmjzB6YpR2BU5i150+PF6Dxk+2XMJ5I8imX25T4fa
        yAEqhgcYW2vCMNRCvJf/rXkHOl0cjMLoTd37C5w75Mh7UGjCCCEOCAQ=
X-Google-Smtp-Source: AGHT+IFnux13voMEYKL2AvFFZ2IntVTZOtmPk8jRTbyWfstIdLEdj42EUj9cU8dCaEOekjzsm7vjd98pJPwVLSbOMrc=
X-Received: by 2002:a05:6902:120e:b0:d78:1b39:fd03 with SMTP id
 s14-20020a056902120e00b00d781b39fd03mr22126055ybu.64.1694072432520; Thu, 07
 Sep 2023 00:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-20-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-20-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:40:20 +0200
Message-ID: <CACRpkdZkPbvDTMo_ZOJ8rZ5+dUOqOi2_EfS+jzreWjMtpJrVYg@mail.gmail.com>
Subject: Re: [PATCH 19/21] gpio: swnode: replace gpiochip_find() with gpio_device_find_by_label()
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
> We're porting all users of gpiochip_find() to using gpio_device_find().
> Update the swnode GPIO code.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With Andy's comment addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
