Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BA038CBEB
	for <lists+linux-acpi@lfdr.de>; Fri, 21 May 2021 19:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhEURUJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 May 2021 13:20:09 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35435 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhEURUI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 May 2021 13:20:08 -0400
Received: by mail-oi1-f178.google.com with SMTP id v22so20328429oic.2;
        Fri, 21 May 2021 10:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSelCdkeL6UMwaqXqXmyfBVh5HqO0dvhdB+UkPnarMA=;
        b=rp1uyl2iFgA0iDoK9er1EN3pKteHplZtkEvAvHDBq9cPiSXmNzm+LJJGlloXLd/AgT
         5oqYkLcCqgtx8YZ0QJqmMnynWdoEueXoaN8AK/sbAg9BBQRc+LyawUI+EGYpew98wBoa
         8jLc1/nNIwt9HQq5gWwc+zXWTt6miqSNRQ9WR/cbt9Z7ngCCV4vLGBvyBvsLPYZ5d7aS
         +fQU8hSgrRbb/qYL+47A/YK+LMUMOndVI3yRy5UIaxTfRdJ1gXAD8GPTcAk9tWfYb1F4
         hXMEObKwjZqKaQjzMvEeu0PyiFRso1bXYLFgOGVUfkzTnux02Z6tmR4Xa8+R55YPA5WH
         mebA==
X-Gm-Message-State: AOAM531JvI0UJq1uyqpxcTbK2fDXpV9i+o31OqYIvNxArWIqktT140qE
        Ti7GpE6qsTvxFJ/+3m7rzxc3ear030QO0YFWMms=
X-Google-Smtp-Source: ABdhPJzdRyjOsjiF7+aESA08qwmPjxDpeGYGENTw7cvWtCdyDUe8sbQBzqMx1Notao120+saRQEGH58JK0oxsBfE37k=
X-Received: by 2002:aca:1910:: with SMTP id l16mr2823747oii.69.1621617525180;
 Fri, 21 May 2021 10:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <CABTNMG12HADeXoWe+25kYKQPcY8KV0GCDx+75GVAVATQ1pZYTA@mail.gmail.com>
 <20210520030949.2471-1-jhp@endlessos.org>
In-Reply-To: <20210520030949.2471-1-jhp@endlessos.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 May 2021 19:18:34 +0200
Message-ID: <CAJZ5v0h3j+t3URKdM=WidytiAWx0N8jL6JnED11r4BCH5vDOHw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: EC: Make more Asus laptops use ECDT _GPE
To:     Jian-Hong Pan <jhp@endlessos.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@endlessos.org, Chris Chiu <chris.chiu@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 20, 2021 at 5:13 AM Jian-Hong Pan <jhp@endlessos.org> wrote:
>
> From: Chris Chiu <chris.chiu@canonical.com>
>
> More ASUS laptops have the _GPE define in the DSDT table with a
> different value than the _GPE number in the ECDT.
>
> This is causing media keys not working on ASUS X505BA/BP, X542BA/BP
>
> Add model info to the quirks list.
>
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v2: Edit the author information with valid email address
>
> v3: Edit Chris' S-o-b with current valid email address
>
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

Applied as 5.14 material, thanks!
