Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55A33B6C6F
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 04:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhF2CWO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Jun 2021 22:22:14 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:40516 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhF2CWO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Jun 2021 22:22:14 -0400
Received: by mail-lj1-f178.google.com with SMTP id d25so28768555lji.7;
        Mon, 28 Jun 2021 19:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=FjE6J2J6ZECJGymv84c7w28BaRkO7xub+I+LeYwtvpk=;
        b=F4tYccvbHPdRWyGm7q4eFKr7DaUXM6ziBhOFYLucXm7Ci6k5p4BVTwsqqxEn2xod71
         8eY6ETMtKeSrQBkxtRHKtHMw6/LhaunePhEBpKqF1WBPuvkh2pQvAUXtQ/a8xEQyCtus
         6OKITvN1OvoDVADpUQG0EyxY/CJnSzeAJLS+/bUPsT8K9G19trg9cvryXVwOWH5eOtxa
         gCwjkZguGRFHOBmZ//PRVo1W230axT5uRUBU3IftACkkThuzliLrkRAz41pSiUW7COW0
         tk+v6DcVVAConTVJ6zXqGBDftLEpt7bSn1hgRpJggHvVkp1vjKyvJsjeghIpRn3lHRr2
         9TbQ==
X-Gm-Message-State: AOAM5330JS7rl2i+NxX3KAQ9migeoFxH5+JvuB37OD34QcM9dXRwweOo
        FcdSgVepa+Jic/SdHPBFoLMMKp7qJf02bw==
X-Google-Smtp-Source: ABdhPJw0K/xDspMwtYm+EUZgpoKmWk/wggb6xFJDKGfk5Y7Ffl+mwW43BC9/IGVxUWTPjicfJEOAIg==
X-Received: by 2002:a2e:5714:: with SMTP id l20mr1932609ljb.259.1624933185691;
        Mon, 28 Jun 2021 19:19:45 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id l21sm542954lji.64.2021.06.28.19.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 19:19:45 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id r16so28696715ljk.9;
        Mon, 28 Jun 2021 19:19:44 -0700 (PDT)
X-Received: by 2002:a2e:81d8:: with SMTP id s24mr1933289ljg.78.1624933184787;
 Mon, 28 Jun 2021 19:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210626132732.40063-1-hdegoede@redhat.com>
In-Reply-To: <20210626132732.40063-1-hdegoede@redhat.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 29 Jun 2021 10:19:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v64O3w6AGH4V-r6D_Zni-pCW2g7BTTceb4CoeAdowR2KNw@mail.gmail.com>
Message-ID: <CAGb2v64O3w6AGH4V-r6D_Zni-pCW2g7BTTceb4CoeAdowR2KNw@mail.gmail.com>
Subject: Re: [PATCH] mfd: axp20x: Update AXP288 volatile ranges
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-acpi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Clamshell <clamfly@163.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Sat, Jun 26, 2021 at 9:29 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> On Cherry Trail devices with an AXP288 PMIC the external SD-card slot
> used the AXP's DLDO2 as card-voltage and either DLDO3 or GPIO1LDO
> (GPIO1 pin in low noise LDO mode) as signal-voltage.
>
> These regulators are turned on/off and in case of the signal-voltage
> also have their output-voltage changed by the _PS0 and _PS3 power-
> management ACPI methods on the MMC-controllers ACPI fwnode as well as
> by the _DSM ACPI method for changing the signal voltage.
>
> The AML code implementing these methods is directly accessing the
> PMIC through ACPI I2C OpRegion accesses, instead of using the special
> PMIC OpRegion handled by drivers/acpi/pmic/intel_pmic_xpower.c .
>
> This means that the contents of the involved PMIC registers can change
> without the change being made through the regmap interface, so regmap
> should not cache the contents of these registers.
>
> Mark the LDO power on/off, the LDO voltage control and the GPIO1 control
> register as volatile, to avoid regmap caching their contents.
>
> Specifically this fixes an issue on some models where the i915 driver
> toggles another LDO using the same on/off register on/off through
> MIPI sequences (through intel_soc_pmic_exec_mipi_pmic_seq_element())
> which then writes back a cached on/off register-value where the
> card-voltage is off causing the external sdcard slot to stop working
> when the screen goes blank, or comes back on again.
>
> Note the AXP288 PMIC is only used on Bay- and Cherry-Trail platforms,
> so even though this is an ACPI specific problem there is no need to
> make the new volatile ranges conditional since these platforms always
> use ACPI.
>
> Fixes: dc91c3b6fe66 ("mfd: axp20x: Mark AXP20X_VBUS_IPSOUT_MGMT as volatile")

Maybe you want

Fixes: cd53216625a0 ("mfd: axp20x: Fix axp288 volatile ranges")

and then list the other one as a prerequisite? Or just list both tags.

Should we CC stable on this? I don't know the exact use case for these
devices. Are people running distro LTS kernels on them?

> Reported-and-tested-by: Clamshell <clamfly@163.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/axp20x.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 3eae04e24ac8..db6a21465594 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -125,12 +125,13 @@ static const struct regmap_range axp288_writeable_ranges[] = {
>
>  static const struct regmap_range axp288_volatile_ranges[] = {
>         regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP288_POWER_REASON),
> +       regmap_reg_range(AXP22X_PWR_OUT_CTRL1, AXP22X_ALDO3_V_OUT),

This region also covers the voltage and on/off controls for the buck
regulators. Maybe include that in your commit message if that was the
intent, or skip over them if not?


Thanks
ChenYu

>         regmap_reg_range(AXP288_BC_GLOBAL, AXP288_BC_GLOBAL),
>         regmap_reg_range(AXP288_BC_DET_STAT, AXP20X_VBUS_IPSOUT_MGMT),
>         regmap_reg_range(AXP20X_CHRG_BAK_CTRL, AXP20X_CHRG_BAK_CTRL),
>         regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IPSOUT_V_HIGH_L),
>         regmap_reg_range(AXP20X_TIMER_CTRL, AXP20X_TIMER_CTRL),
> -       regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
> +       regmap_reg_range(AXP20X_GPIO1_CTRL, AXP22X_GPIO_STATE),
>         regmap_reg_range(AXP288_RT_BATT_V_H, AXP288_RT_BATT_V_L),
>         regmap_reg_range(AXP20X_FG_RES, AXP288_FG_CC_CAP_REG),
>  };
> --
> 2.31.1
>
