Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630886E6873
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Apr 2023 17:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjDRPnm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 18 Apr 2023 11:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDRPnl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2023 11:43:41 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DE4137
        for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2023 08:43:40 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-94f59fbe2cbso41123166b.1
        for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2023 08:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832619; x=1684424619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyVPleHZhfe8asU3jAmHkDVE7mfGIk+G9ELseouARXI=;
        b=j+tlY+rwduQS1YfcDX4MSi5+8gxXl9ixHsuFmeFsxCz4K+mbdriQ6OdoW0PgdPUNzL
         K/++DhldUIKbZpoKlfJYYbJUm1ih20R9udIH+wR/VoJJT7ZJv4aweBfs3OTvq7aAcHEl
         fjC88wBe6wuEBzV8UIzpsj0SlO+WJbapNWAgUDPXjkLEOeAhe/TfA/IHmiEuXDHuVTdF
         RONLBRvYpFZ3PA2jw9UkqHfWJFIMeKFHGbFpVt4Tn3/ar8/wGjhY3DbPnHjGpA1dGOnU
         CLGvgcm1dLo+NrLa1ez5uYL75Ac7bSltNz/d28SDNoIGmpdyutfwenzB9bZ3ovifD2xC
         dEDw==
X-Gm-Message-State: AAQBX9evjjL2+R6MQ5ZlC38QhyhmWu42DJdJkLxEgJR6GqaEvvR5hNw7
        vhR3JdF1LJABzI00pOwKYFwegRGZ1hhkSB3/xBxyR+Yf
X-Google-Smtp-Source: AKy350ZR9Dodrj7kS42sNW0cSj9vbi7Y7pftyJ1WXDu7z9B+IsPoQ56C+VcQpe2Dp7mWcHIuTPEYUnRl4D2q6iHReeo=
X-Received: by 2002:a17:906:72d9:b0:94f:4ec3:f0f5 with SMTP id
 m25-20020a17090672d900b0094f4ec3f0f5mr6865195ejl.4.1681832618654; Tue, 18 Apr
 2023 08:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230418085437.4579-1-hdegoede@redhat.com>
In-Reply-To: <20230418085437.4579-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Apr 2023 17:43:27 +0200
Message-ID: <CAJZ5v0hZK3JaC+qn8kargd0PP24VchVXpPKsCgQkio+sH4jwmg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: LPSS: Add 80862289 ACPI _HID for second PWM
 controller on Cherry Trail
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 18, 2023 at 10:54 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> On some Cherry Trail devices the second PWM controller uses
> 80862289 as ACPI _HID, rather then using 80862288 as is done
> for both controllers on most models.
>
> Add the missing 80862289 ACPI _HID, note this uses its own
> lpss_device_desc, without ".setup = bsw_pwm_setup" so that
> the pwm_lookup is not added for it.
> On devices where both controllers use the 80862288 _HID bsw_pwm_setup()
> does a UID check to avoid registering the lookup for the second
> controller but that will not work here.
>
> Adding the missing id fixes the second PWM controller no longer
> working after the entire LPSS1 island has been in D3 at least
> once, which causes the contents of the LPSS private registers
> to get lost. Adding the _HID makes acpi_lpss restore these
> when the controller moves from D3 to D0.
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - s/HID/_HID/
> - Add Mika's Reviewed-by
> ---
>  drivers/acpi/acpi_lpss.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index f08ffa75f4a7..77186f084d3a 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -271,6 +271,12 @@ static const struct lpss_device_desc bsw_pwm_dev_desc = {
>         .resume_from_noirq = true,
>  };
>
> +static const struct lpss_device_desc bsw_pwm2_dev_desc = {
> +       .flags = LPSS_SAVE_CTX_ONCE | LPSS_NO_D3_DELAY,
> +       .prv_offset = 0x800,
> +       .resume_from_noirq = true,
> +};
> +
>  static const struct lpss_device_desc byt_uart_dev_desc = {
>         .flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
>         .clk_con_id = "baudclk",
> @@ -368,6 +374,7 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
>         /* Braswell LPSS devices */
>         { "80862286", LPSS_ADDR(lpss_dma_desc) },
>         { "80862288", LPSS_ADDR(bsw_pwm_dev_desc) },
> +       { "80862289", LPSS_ADDR(bsw_pwm2_dev_desc) },
>         { "8086228A", LPSS_ADDR(bsw_uart_dev_desc) },
>         { "8086228E", LPSS_ADDR(bsw_spi_dev_desc) },
>         { "808622C0", LPSS_ADDR(lpss_dma_desc) },
> --

Applied as 6.4 material, thanks!
