Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A35B681582
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 16:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbjA3Ptc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 10:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbjA3Ps6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 10:48:58 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001EE86B6
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 07:48:27 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id m2so32523430ejb.8
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 07:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46vggT4ysY52ow700PqHQbq3HZqyBdRX+kYILjdEfyo=;
        b=7YBzA+xje2Vg6nUkSLzT92y0k7pIi4sF+p5XDivVd9jZpQBnZUEidG8M08pLbCKFKR
         I4j9mZWgwJQuqBMzilMpDzKndojDsYWzFUWOaqRmA4+a1oreuHRSVL+ChRU1LOMV6gs2
         /IQqd7PPIvOtznHspS/P2Ahr9xZ3AnXF96toH4K1yJGJ2YEw2pqe2VKhq6JVT1j4ezGr
         2y8UzgtnUSFSxlpSwLQvr6adD1RREZo2GZyxltYIXviyi1KT88nVAVQMG+y5EFFBJKlt
         SzupuUF6X7ZLrOHtCcbsqdrnrmCtMmnFom5TUtZvcCvLd8KwqE6GZYpD7ZseEBBvbOKS
         Ro6g==
X-Gm-Message-State: AFqh2krSHsK/4u0XCwpQismyFQXU85wAhUKKHtRWOOuCSCDAyGk7PGyl
        eUSVBK8cgMW9bPhXUHXy3/LDb517CEtmTw452w4=
X-Google-Smtp-Source: AMrXdXvhlcVflWSBL4SMktVTQo7Jn2b4lBNaK08IlYJsoLAD6KVn3Nil11QfIVF1BX3jgCd74dElKma4b4eRlrdOttE=
X-Received: by 2002:a17:907:c928:b0:85e:4218:c011 with SMTP id
 ui40-20020a170907c92800b0085e4218c011mr7416739ejc.258.1675093706592; Mon, 30
 Jan 2023 07:48:26 -0800 (PST)
MIME-Version: 1.0
References: <20230125113811.53409-1-hdegoede@redhat.com>
In-Reply-To: <20230125113811.53409-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Jan 2023 16:48:15 +0100
Message-ID: <CAJZ5v0jYx4Niqyfgju=S2GAoS+FG7yLcxxoPFde+=w0F28OUdQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PMIC: Add comments with DSDT power opregion
 field names
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 25, 2023 at 12:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The DSDTs of CHT devices using the Dollar Cove TI PMIC, all use
> LDO1 - LDO14 names for the DSDT power opregion field names.
>
> Add comments with these fields to make it easier to see which PMIC
> registers are being set by ACPI code using these.
>
> Note that LDO4 is missing and the mapped registers jump from 0x43
> to 0x45 to match. This matches with how the fields are declared
> in the DSDT where LDO4 is skipped too. Note there is no hole in
> the field addresses, LDO4 is simply just not defined on either side.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - s/LDO3/LDO4/ in the commit message, because I somehow go this
>   wrong initially (thank you for catching this Andy)
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

Applied as 6.3 material, thanks!
