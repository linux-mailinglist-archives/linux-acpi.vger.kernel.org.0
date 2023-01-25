Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4912B67B105
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 12:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbjAYLUO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 06:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbjAYLTh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 06:19:37 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8116C582A0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jan 2023 03:18:10 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id d13so9618765qkk.12
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jan 2023 03:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xndRFfvOQ48aiXQOB4DRbxIaOWkLd0zIEBIIhFu1e1Q=;
        b=NpcAqfypvVIdEcZwa21J5/ij8yH909pJzDTGNPl9whr+wMNzp7pj51rz2wOMnv+MAX
         GFceI8FHrw+kff8FtuUiVyeNEeWL/HGmQ/7+qU9cjW81bwa6Rfi2HRTk8u5f0m1890a9
         zv/okL/KW5yhd2/lb34CE7pTMK0pCNIDDPgj42nAupRWY3Y7IjvCoLkEoPMHlidYK4hw
         uv1hm4Xoi0X8TFMtT6nLEhAVnOCkkNgkM8YnFopMUWQpYlHn1VAhYrgnioWksd+8uJCp
         rcHQcyk3Hav+Tqrq4RPT1KycW/k4gz5YJPQbp5Po0TmkluzRQXpCLUCw43cczCWxXiMS
         tICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xndRFfvOQ48aiXQOB4DRbxIaOWkLd0zIEBIIhFu1e1Q=;
        b=oPWNR1Vg7rUceAuwcyaTSO3RXAVAghfiUUz5sqaxUgDL85orj0+jJtnm9DepnhfUui
         exwz0mQ7XD2qbTMk/Nf9cQtHRMwGFiIVdOpS2e0KGyYTRsrvuUk8JKtk5K4Wob6qDsdZ
         +4iveVRgGgJjPiEuoPME4Q+NmJbtKjvxsrVdt0CcYyh0uMdq6wJ7q2UQ7S/qeLPa8XRx
         EQFDTRMR0Z0FvFOgQzBwEomNHdADBpE08P5xvZE2s1SaOxmhM3fzFkoHUR6uMxGLUgd2
         9ef/sUJ28X7E0rl4hthIM6EO+zMFgZWx2pIvLflzSorAIqAuTLSqB0IRYhoDfXPA7rOA
         NODQ==
X-Gm-Message-State: AFqh2kogl15zgbKe3fbUR1HGS4fCZL23s1qom7zYIAQXjyKVuwUiBhOi
        5mfq79ScD7WwN3xxFWXtPDix+MerjlzrSSp0feyUXKn/p4Q=
X-Google-Smtp-Source: AMrXdXuRRtTvtxrBQkNpCMEhzD5E4Ugb1X/63TH8gF6DUTowfaTGTlrJazcF7zh5NGEl/6te6FhA3SuJnnBT+eeHY1s=
X-Received: by 2002:a05:620a:1139:b0:705:b8ad:5b36 with SMTP id
 p25-20020a05620a113900b00705b8ad5b36mr1724942qkk.734.1674645489146; Wed, 25
 Jan 2023 03:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20230125110718.18194-1-hdegoede@redhat.com>
In-Reply-To: <20230125110718.18194-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Jan 2023 13:17:33 +0200
Message-ID: <CAHp75VdBzHuo3Ft-f7wPcYF69yJC6_3vnAqxwgxCaKYn556_hQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PMIC: Add comments with DSDT power opregion field names
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
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

On Wed, Jan 25, 2023 at 1:07 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The DSDTs of CHT devices using the Dollar Cove TI PMIC, all use
> LDO1 - LDO14 names for the DSDT power opregion field names.
>
> Add comments with these fields to make it easier to see which PMIC
> registers are being set by ACPI code using these.
>
> Note that LDO4 is missing and the mapped registers jump from 0x43
> to 0x45 to match. This matches with how the fields are declared
> in the DSDT where LDO3 is skipped to. Note there is no hole in

LDO4?

too

> the field addresses, LDO3 is simply just not defined on either side.

LDO4?

With commit message clarification (whatever is considered correct)
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 26 ++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> index 418eec523025..c84ef3d15181 100644
> --- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> +++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> @@ -20,19 +20,19 @@
>  #define CHTDC_TI_GPADC         0x5a
>
>  static struct pmic_table chtdc_ti_power_table[] = {
> -       { .address = 0x00, .reg = 0x41 },
> -       { .address = 0x04, .reg = 0x42 },
> -       { .address = 0x08, .reg = 0x43 },
> -       { .address = 0x0c, .reg = 0x45 },
> -       { .address = 0x10, .reg = 0x46 },
> -       { .address = 0x14, .reg = 0x47 },
> -       { .address = 0x18, .reg = 0x48 },
> -       { .address = 0x1c, .reg = 0x49 },
> -       { .address = 0x20, .reg = 0x4a },
> -       { .address = 0x24, .reg = 0x4b },
> -       { .address = 0x28, .reg = 0x4c },
> -       { .address = 0x2c, .reg = 0x4d },
> -       { .address = 0x30, .reg = 0x4e },
> +       { .address = 0x00, .reg = 0x41 }, /* LDO1 */
> +       { .address = 0x04, .reg = 0x42 }, /* LDO2 */
> +       { .address = 0x08, .reg = 0x43 }, /* LDO3 */
> +       { .address = 0x0c, .reg = 0x45 }, /* LDO5 */
> +       { .address = 0x10, .reg = 0x46 }, /* LDO6 */
> +       { .address = 0x14, .reg = 0x47 }, /* LDO7 */
> +       { .address = 0x18, .reg = 0x48 }, /* LDO8 */
> +       { .address = 0x1c, .reg = 0x49 }, /* LDO9 */
> +       { .address = 0x20, .reg = 0x4a }, /* LD10 */
> +       { .address = 0x24, .reg = 0x4b }, /* LD11 */
> +       { .address = 0x28, .reg = 0x4c }, /* LD12 */
> +       { .address = 0x2c, .reg = 0x4d }, /* LD13 */
> +       { .address = 0x30, .reg = 0x4e }, /* LD14 */
>  };
>
>  static struct pmic_table chtdc_ti_thermal_table[] = {
> --
> 2.39.0
>


-- 
With Best Regards,
Andy Shevchenko
