Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D53388B35
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 11:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346867AbhESJzO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 05:55:14 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:39693 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245745AbhESJzO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2021 05:55:14 -0400
Received: by mail-oi1-f170.google.com with SMTP id y76so3328460oia.6;
        Wed, 19 May 2021 02:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+DyMtUq0y9DzdbwtcafdWksxpvx1+4Y3Ho4YYiKmrQ=;
        b=BFLTb5J+ft6OfKaHc5Y8zfVplKKFKbuYGgnxcGR7AcinhrckJIqzKJ365PTbsOkMju
         3AEas2m1wlrTfmB6aJgWWx55WiKKDiWQAoryrdGWm5PlH2ocRoYnf5RJMZinvBEIldIx
         Ato1rWFKitvLQ2KzqOmLe5E78N30ibFJzgTvi33iD5SWUGZ9UpoCzcjbSjZ0E5S36g+W
         WC6ih7z1atnu63gdHfUO9o08eKEV5jiDUk30Sq3XGhzWjxlSSN0fowMqFYSl5SnZAgOp
         3Tvf3ZKMNxGMPWDfU2xP/0K8tDnyL7mjtJYU4orbkZom0qDHVc2JSHpNr+LI1wvOeYzb
         bQug==
X-Gm-Message-State: AOAM530bTn1DnI4Q4WIFeF5fUYLJn/QD3KrE6zP2fnpmObrvR2ntqfgK
        WPQuFeqdlEZJnaQ0LAJBw8leOu/T9WClgmL5edE=
X-Google-Smtp-Source: ABdhPJyj0miVGbThLEUKj90LyKoKmk/mAuEwP6b5nd7j5F0G58MJFxgt9P0Z7DGb0sEswTYPaGoAIOMvkMTH/hNPdxM=
X-Received: by 2002:aca:4ec5:: with SMTP id c188mr7216076oib.69.1621418034541;
 Wed, 19 May 2021 02:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0iU15F42yGm5etxmMLsDwC=u7p1eT6EoVADnJnV8+S4VA@mail.gmail.com>
 <20210519030655.2197-1-jhp@endlessos.org>
In-Reply-To: <20210519030655.2197-1-jhp@endlessos.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 May 2021 11:53:43 +0200
Message-ID: <CAJZ5v0hn6p6_vgb+F1WzLDTB1n-4BchGW4bbY7CS6pswTAc=nA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: EC: Make more Asus laptops use ECDT _GPE
To:     Jian-Hong Pan <jhp@endlessos.org>,
        Chris Chiu <chris.chiu@canonical.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@endlessos.org, Chris Chiu <chiu@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 19, 2021 at 5:11 AM Jian-Hong Pan <jhp@endlessos.org> wrote:
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
> Signed-off-by: Chris Chiu <chiu@endlessm.com>

This has to match the From address.

Chris, can the e-mail address in the S-o-b be changed?

> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v2: Edit the author information with valid email address
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
> 2.31.1
>
