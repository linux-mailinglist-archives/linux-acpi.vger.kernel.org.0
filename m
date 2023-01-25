Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7667C67B0E5
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 12:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjAYLPr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 06:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbjAYLPQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 06:15:16 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DA758649;
        Wed, 25 Jan 2023 03:15:04 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id pj1so9635122qkn.3;
        Wed, 25 Jan 2023 03:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XFW/ufQ2ODZuW6qlKrzpcFO4Ac9BwXlqUp4Wb7d1CZg=;
        b=PnuLkYOa2xJK+gR/xZexrUKa+4nuhSJ4NBXJ71w1bJpYMFylmtJu6irCEGCyVKHVwm
         urAfBcNwWoBJfTe3aJrLFHNvh3YRPjpINZgDiqoEIMFlVqTxJmKrGeGov+me7wcR96sg
         KQYRvbTqWhSjH95Bn1eIikUuJz7YbN7aFDM/cJCYdxLDW9OzhNwc/lkcCDb5QewxWDu6
         VkW1up9CRONpTK0KAl9dS6+/M2ndjer59TyGYpaxgj7E69J2U1qs4rE8HlctsIDGHxlk
         jqqAJ34huXGpdsz+7q/z0ndGF4NG3YM0PPAQaVViHBOFi6M2svG1p6pM676qmTd0fJS0
         6zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFW/ufQ2ODZuW6qlKrzpcFO4Ac9BwXlqUp4Wb7d1CZg=;
        b=u6t/Ej3Kn9zQOi3oy4+tboKATBjlGetuy9sPoZgBFTQcDs/k4I+SLphsFoojtRFJ9S
         UjnvXXdlufCbB1XivtwZgKx1jPALYhm/J7qogSw9lrqaaheLvuun98KjaqgyhsnVzWMf
         o/pcOoBSboPDcHZ6D3GQ/0/5FNgEpNa2Wfmdf3YfxCiXcZ5etcesQHXfBN2AQXcNnmw3
         YHh9y3rFk6o/lF1gMabsGfQbIs+GJOMgiP8ObpvGyGEdyrJuKFQt+LN3yZLkMsWaYJsE
         QRB2BRZrYWDeE9FiqxA4oyPkI2wq+1iYZQL65/Vp4A5cT4q5GJNPINit9jpYD85Ok56D
         T1fA==
X-Gm-Message-State: AFqh2koCFRGEVQ3Rnms1wNd1Wx3AcghrXbTjDhYBbraBTsDE0O1yUDPd
        MPYy3Ei5cmsL17ftL4O6b7Piw6HLn9KLTKKmqfQ=
X-Google-Smtp-Source: AMrXdXs8RzIHqR7y24zBioo70o0Ov0wcXcHH/LLv2kzdP9PfZORjhTcJiL0X+jM3Y1pTD02KBRTBDSMClsIlVxIPXRY=
X-Received: by 2002:a05:620a:56d:b0:706:5fba:6192 with SMTP id
 p13-20020a05620a056d00b007065fba6192mr1771887qkp.383.1674645303020; Wed, 25
 Jan 2023 03:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20230125103916.16772-1-hdegoede@redhat.com> <20230125103916.16772-2-hdegoede@redhat.com>
In-Reply-To: <20230125103916.16772-2-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Jan 2023 13:14:26 +0200
Message-ID: <CAHp75VdKei2GtGuLZ4R=WxzciPFjVhDji+wO3xWU4Z893z0J8A@mail.gmail.com>
Subject: Re: [RFC 1/1] pinctrl: amd: Fix handling of PIN_CONFIG_BIAS_PULL_UP/_DOWN
 settings
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 25, 2023 at 12:39 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> PIN_CONFIG_BIAS_PULL_UP is documented as follows:
>
> @PIN_CONFIG_BIAS_PULL_UP: the pin will be pulled up (usually with high
> impedance to VDD). If the argument is != 0 pull-up is enabled,
> if it is 0, pull-up is total, i.e. the pin is connected to VDD.
>
> This patch fixes 2 issues with how the AMD pinctrl code was handling this:
>
> 1. amd_pinconf_set() was setting the PULL_UP_ENABLE bit as follows:
>     pin_reg &= ~BIT(PULL_UP_ENABLE_OFF);
>     pin_reg |= ((arg>>1) & BIT(0)) << PULL_UP_ENABLE_OFF;
>    When called from gpio_set_bias() for ACPI enumerated GPIOs arg == 1,
>    so the pull-up enable bit would be cleared instead of being set.
>    It seems unnecessary to say that this is BAD.
>
>    There is no real convention for the meaning of arg other then that

than

>    a value != 0 means the pull-up should be enabled (which was being
>    violated here). Looking at other drivers the Intel pinctrl drivers
>    all treat 1 (as used by gpio_set_bias()) as indictating that the

indicating

>    driver should pick the pull-up strength; and all other values are
>    interpreted as the amount of ohm with which to pull-up, with non
>    supported values being rejected with -EINVAL.
>
>    This patch changes the AMD pinctrl code to match this behavior so
>    that the behavior of all x86 pinctrl drivers is consistent.
>
> 2. arg == 0 does not mean that the pull-up/-down is disabled as the
>    old code was assuming. Rather it means that the "pull-up is total,
>    i.e. the pin is connected to VDD". The correct way for
>    amd_pinconf_get() to indicate that the pull-up/-down is not enabled
>    is to return -EINVAL. I've checked a whole bunch of pinctrl drivers
>    and they all behave this way. This patch brings the AMD pinctrl driver
>    in line with this.
>
> Fixes: dbad75dd1f25 ("pinctrl: add AMD GPIO driver support.")
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=212379
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pinctrl/pinctrl-amd.c | 37 +++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
> index 9bc6e3922e78..88174195b5c8 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -744,11 +744,19 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
>                 break;
>
>         case PIN_CONFIG_BIAS_PULL_DOWN:
> -               arg = (pin_reg >> PULL_DOWN_ENABLE_OFF) & BIT(0);
> +               if (!(pin_reg & BIT(PULL_DOWN_ENABLE_OFF)))
> +                       return -EINVAL;
> +               arg = 1;
>                 break;
>
>         case PIN_CONFIG_BIAS_PULL_UP:
> -               arg = (pin_reg >> PULL_UP_SEL_OFF) & (BIT(0) | BIT(1));
> +               if (!(pin_reg & BIT(PULL_UP_ENABLE_OFF)))
> +                       return -EINVAL;
> +
> +               if (pin_reg & BIT(PULL_UP_SEL_OFF))
> +                       arg = 8000;
> +               else
> +                       arg = 4000;
>                 break;

Do I understand correctly that there is only one bias value possible
for Pdown (4k?) and two for Pup (4k & 8k)?
(of course excluding cases when either is disabled).

Also I have stumbled over _OFF. Does it actually mean "offset"? Can we
rename to avoid (my) confusion with OFF as something being "off"?
(Maybe a separate patch?)

>         case PIN_CONFIG_DRIVE_STRENGTH:
> @@ -790,15 +798,28 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>                         break;
>
>                 case PIN_CONFIG_BIAS_PULL_DOWN:
> -                       pin_reg &= ~BIT(PULL_DOWN_ENABLE_OFF);
> -                       pin_reg |= (arg & BIT(0)) << PULL_DOWN_ENABLE_OFF;
> +                       pin_reg |= BIT(PULL_DOWN_ENABLE_OFF);
>                         break;
>
>                 case PIN_CONFIG_BIAS_PULL_UP:
> -                       pin_reg &= ~BIT(PULL_UP_SEL_OFF);
> -                       pin_reg |= (arg & BIT(0)) << PULL_UP_SEL_OFF;
> -                       pin_reg &= ~BIT(PULL_UP_ENABLE_OFF);
> -                       pin_reg |= ((arg>>1) & BIT(0)) << PULL_UP_ENABLE_OFF;
> +                       /* Set default ohm value in case none is given */
> +                       if (arg == 1)
> +                               arg = 4000;
> +
> +                       switch (arg) {
> +                       case 4000:
> +                               pin_reg &= ~BIT(PULL_UP_SEL_OFF);
> +                               pin_reg |= BIT(PULL_UP_ENABLE_OFF);
> +                               break;
> +                       case 8000:
> +                               pin_reg |= BIT(PULL_UP_SEL_OFF);
> +                               pin_reg |= BIT(PULL_UP_ENABLE_OFF);
> +                               break;
> +                       default:
> +                               dev_err(&gpio_dev->pdev->dev,
> +                                       "Invalid pull-up arg %u\n", arg);
> +                               ret = -EINVAL;
> +                       }

Can Pup and Pdown be enabled simultaneously?

>                         break;
>
>                 case PIN_CONFIG_DRIVE_STRENGTH:

After your answers I might come with some comments, but FWIW the
code-wise this seems correct approach.

-- 
With Best Regards,
Andy Shevchenko
