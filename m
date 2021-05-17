Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D3938313B
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 16:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbhEQOgA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 10:36:00 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:34548 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240240AbhEQOdh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 May 2021 10:33:37 -0400
Received: by mail-oo1-f54.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so1511624ool.1;
        Mon, 17 May 2021 07:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHI3b3DrW2T0MjQQgWMyWbXQ9GdigCHzYjyvIDoNZoE=;
        b=glWsi7FJfzqrZvFPxQu14ljEsitaWe+jhb2bnf3Jai5F6unWF7tbr90jITGUBAsEq7
         YvZmmzObSHywR9rBBLKDiv0OGJ6sMtikrrbr7udTLQplSDex2UCfzBFOyB04O/C0KsSO
         OkgQniR97vL57wCiLdz3TsHfnu5CA3BgJXd2GgPfUomniDvAlSYl8bfrqToAEf1NBs1K
         g9UzsxtVHR0KAZHmM81YzaYf0+QSxr/3a/QOWsKPqpRS9ElY6YucJyd8lIllOUPNYeIR
         sAIYwgtJxA+nvtWOFgIErQn4xmKMEZXdWbYYHbaTgPP0dvEP9fZxx4gLN7gpkNT+ZNAV
         h7nQ==
X-Gm-Message-State: AOAM531/QfYdLIuiMzzHti6udCifI61+BtsmXjGaUVha6n9Chli2Y9vU
        CBJ8WQHD6XSCqO7n4m0CnL07S1NFOvNGwvH9Kq63aADDF7Y=
X-Google-Smtp-Source: ABdhPJzc2rxdxykvDgrq3LVlJMEuFAxBWrDmPrG65KUkzFceqYTVJUcH5pWimARkvOV2h+mTLPy6p+bZesk1kDkitDE=
X-Received: by 2002:a4a:ab83:: with SMTP id m3mr186799oon.2.1621261935224;
 Mon, 17 May 2021 07:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210511063835.7794-1-jhp@endlessos.org>
In-Reply-To: <20210511063835.7794-1-jhp@endlessos.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 May 2021 16:32:04 +0200
Message-ID: <CAJZ5v0hsNSpL+1ero_+pzz97Xz4UCwjBv7swg+3CAne7_OUKkQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / EC: Fix media keys not working problem on more
 Asus laptops
To:     Jian-Hong Pan <jhp@endlessos.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Chris Chiu <chris.chiu@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@endlessos.org, Chris Chiu <chiu@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 11, 2021 at 8:40 AM Jian-Hong Pan <jhp@endlessos.org> wrote:
>
> From: Chris Chiu <chiu@endlessm.com>
>
> More ASUS laptops have the _GPE define in the DSDT table with a
> different value than the _GPE number in the ECDT.
>
> This is causing media keys not working on ASUS X505BA/BP, X542BA/BP
>
> Add model info to the quirks list.
>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
>  drivers/acpi/ec.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 13565629ce0a..e8c5da2b964a 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1846,6 +1846,22 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
>         DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>         DMI_MATCH(DMI_PRODUCT_NAME, "GL702VMK"),}, NULL},
>         {
> +       ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X505BA", {
> +       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +       DMI_MATCH(DMI_PRODUCT_NAME, "X505BA"),}, NULL},
> +       {
> +       ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X505BP", {
> +       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +       DMI_MATCH(DMI_PRODUCT_NAME, "X505BP"),}, NULL},
> +       {
> +       ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X542BA", {
> +       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +       DMI_MATCH(DMI_PRODUCT_NAME, "X542BA"),}, NULL},
> +       {
> +       ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X542BP", {
> +       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +       DMI_MATCH(DMI_PRODUCT_NAME, "X542BP"),}, NULL},
> +       {
>         ec_honor_ecdt_gpe, "ASUS X550VXK", {
>         DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>         DMI_MATCH(DMI_PRODUCT_NAME, "X550VXK"),}, NULL},
> --

Applied as 5.14 material under a different subject ("ACPI: EC: Make
more Asus laptops use ECDT _GPE"), thanks!
