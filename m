Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18AD3BA36D
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jul 2021 18:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhGBRBq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jul 2021 13:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBRBq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jul 2021 13:01:46 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BADBC061762
        for <linux-acpi@vger.kernel.org>; Fri,  2 Jul 2021 09:59:13 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id w15so10063400pgk.13
        for <linux-acpi@vger.kernel.org>; Fri, 02 Jul 2021 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8c4+MrSASf5wQ7vgApK1RIekBS9pL2dL7ZdlhAHvO4=;
        b=Faqp07fQ1m6i4rEeah0mu33A0k4SLC2N/I03rhPuUiZLdyMr1XnJ8HUGmw8254tHHf
         Uz9IMiHY/lHr9/J2l/KHB6vsXeFozRcphJ9WtIDCJVrlBjxYej1F96rv1VAsN1gq1ljU
         xB7DY46eGl6QaNupnQnBPyQ6RYNGlpk0uXzDpFT4btGHO0/TIDSFeM7LVQqwU71we5uK
         JqwI8+zS1Jwqki0t3k2BHQuHj1kKoSr0T5CEIls4fLY/cLYCelVnGOBP0QEjqB1cBmL7
         3RS+ksJ4g68XgrwpHbSarbo219Rq/Xk9FX1Lo2V9C6UnC3708RV5W6+5r//kc7dFYiQp
         N+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8c4+MrSASf5wQ7vgApK1RIekBS9pL2dL7ZdlhAHvO4=;
        b=o+JPbpZAzAOqctfNdpo0hjN8TmTmH7Ctqm7ZUSq7ACgHzajEHUSjo0Vky7MJP6AFb1
         6pPM7XIv//JP7+kVfZILO4x27beEZJJvxFNg27D3rUwQqKY6g8wW3MEv3uHvMEuRh4tI
         cjpNjnxQQ8iKKqqjAAPCfSiFdHz/w0zOxIa/Vm0QmiY4xkq2LVym08zo0ekyw182Yaa5
         6YO7tLWgf3lHxZzg2hfWZROpNqm2Lugmiv0U1QJiSnyWFf93LT8JARS4sgbYp2b36Kor
         OpoMGyj5h0omsfcDYpLoU/EgtnOzGK1lx1w4YwHQuIXtfkqlrMwzkwnsAM7ksaU5+OaU
         mQTg==
X-Gm-Message-State: AOAM532uzkHOgWyH63OWlUaJA0pdUMs1E5U1y7aQHC8+APjQGBqMPZCT
        nyMY0wKK+AlV+Ne5BEq3VpJTM9tz5ZacBBzn+g4=
X-Google-Smtp-Source: ABdhPJxkviztnSMJW5ZdUHusGYzRxJqYb47G52jdr3k/vNrqkaTtZSMxHE0bmDok/xH9Zha7ix3iYIW1NkrXoGSRm3E=
X-Received: by 2002:a63:df10:: with SMTP id u16mr967724pgg.4.1625245152991;
 Fri, 02 Jul 2021 09:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210702165052.81750-1-hdegoede@redhat.com> <20210702165052.81750-2-hdegoede@redhat.com>
In-Reply-To: <20210702165052.81750-2-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Jul 2021 19:58:35 +0300
Message-ID: <CAHp75Vcwpy3boJexRi9h_H+QY0Lt0zbwXrwjFp75Q03F8UoHCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI / PMIC: XPower: optimize MIPI PMIQ sequence
 I2C-bus accesses
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 2, 2021 at 7:51 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The I2C-bus to the XPower AXP288 is shared between the Linux kernel and
> the SoCs PUNIT. The PUNIT has a semaphore which the kernel must "lock"
> before it may use the bus and while the kernel holds the semaphore the CPU
> and GPU power-states must not be changed otherwise the system will freeze.
>
> This is a complex process, which is quite expensive. This is all done by
> iosf_mbi_block_punit_i2c_access(). To ensure that no unguarded I2C-bus
> accesses happen, iosf_mbi_block_punit_i2c_access() gets called by the
> I2C-bus-driver for every I2C transfer. Because this is so expensive it
> is allowed to call iosf_mbi_block_punit_i2c_access() in a nested
> fashion, so that higher-level code which does multiple I2C-transfers can
> call it once for a group of transfers, turning the calls done by the
> I2C-bus-driver into no-ops.
>
> The default exec_mipi_pmic_seq_element implementation from
> drivers/acpi/pmic/intel_pmic.c does a regmap_update_bits() call and
> the involved registers are typically marked as volatile in the regmap,
> so this leads to 2 I2C-bus accesses.
>
> Add a XPower AXP288 specific implementation of exec_mipi_pmic_seq_element
> which calls iosf_mbi_block_punit_i2c_access() calls before the
> regmap_update_bits() call to avoid having to do the whole expensive
> acquire PUNIT semaphore dance twice.

Same as per patch 1.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/pmic/intel_pmic_xpower.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
> index 644a495a4f13..93c516ad361e 100644
> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
> @@ -266,10 +266,34 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>         return ret;
>  }
>
> +static int intel_xpower_exec_mipi_pmic_seq_element(struct regmap *regmap,
> +                                                  u16 i2c_address, u32 reg_address,
> +                                                  u32 value, u32 mask)
> +{
> +       int ret;
> +
> +       if (i2c_address != 0x34) {
> +               pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
> +                      __func__, i2c_address, reg_address, value, mask);
> +               return -ENXIO;
> +       }
> +
> +       ret = iosf_mbi_block_punit_i2c_access();
> +       if (ret)
> +               return ret;
> +
> +       ret = regmap_update_bits(regmap, reg_address, mask, value);
> +
> +       iosf_mbi_unblock_punit_i2c_access();
> +
> +       return ret;
> +}
> +
>  static struct intel_pmic_opregion_data intel_xpower_pmic_opregion_data = {
>         .get_power = intel_xpower_pmic_get_power,
>         .update_power = intel_xpower_pmic_update_power,
>         .get_raw_temp = intel_xpower_pmic_get_raw_temp,
> +       .exec_mipi_pmic_seq_element = intel_xpower_exec_mipi_pmic_seq_element,
>         .power_table = power_table,
>         .power_table_count = ARRAY_SIZE(power_table),
>         .thermal_table = thermal_table,
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
