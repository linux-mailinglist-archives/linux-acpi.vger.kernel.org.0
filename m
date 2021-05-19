Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED67388B5D
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 12:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhESKMN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 06:12:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53684 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347159AbhESKMM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2021 06:12:12 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1ljJAC-0000Ul-Dr
        for linux-acpi@vger.kernel.org; Wed, 19 May 2021 10:10:52 +0000
Received: by mail-ot1-f70.google.com with SMTP id x2-20020a9d62820000b02902e4ff743c4cso8569301otk.8
        for <linux-acpi@vger.kernel.org>; Wed, 19 May 2021 03:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bh7oN3YWxMGW4HDhFAH8x43fpamYV6QbQivhB+lZzsI=;
        b=boIarynAkkgV2ArNPz9n0nyRqoUzFuodcoYJ7ivSl22742muSbzFg3WJqk62w7gffo
         oEf53/KwuEqYk/3hKz8drzqWewrorDXDNfbI3NbuCtLNeN5DMUoFnpDGRaF3rynpjl/s
         sBOM5qrXDOSEbz4gFej3Q1xfth2IKkH9V7FQ8gARpgdXBbGsVEbZJPeFoezICYA/eYRa
         gHF9GGanIrrfpl/vwx9Zmg+YXrXu5mcKpGMrbrNoDQHEMMFt7W7uvW223lS9qSOxLL9f
         rAeleHNwBchwS6xmx8eSSI6EBsatTICF5esPJDXtx11QbkGUkb3+IYVS3u+6TTst+oxH
         FgZA==
X-Gm-Message-State: AOAM5318LjzDAyQ2PpxGhSbs1vA1tKWCZE9mLkM4E1m341xeO82JQcZD
        keL6qzFkyZk4fnlP7NBrmbJV+lVmXmI/U8KjaSnv8rMph5aKVgc4D/G52lPmOWjo9pFrVSdtdO/
        icHUI9b/0D+mLr04C2l2kLukLs4bTlOae4+IZYjdsQNeAv1B1lRGLVjg=
X-Received: by 2002:aca:4e8c:: with SMTP id c134mr5247742oib.169.1621419051467;
        Wed, 19 May 2021 03:10:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAsQQxJ/sqF/yN04GIbPc/pOhiPLIyAg+/QOWHOWonVtIfu5NSnQDd3L2BH3zVgTYCV2HwGrfT8xOpWgfMLXE=
X-Received: by 2002:aca:4e8c:: with SMTP id c134mr5247731oib.169.1621419051315;
 Wed, 19 May 2021 03:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0iU15F42yGm5etxmMLsDwC=u7p1eT6EoVADnJnV8+S4VA@mail.gmail.com>
 <20210519030655.2197-1-jhp@endlessos.org> <CAJZ5v0hn6p6_vgb+F1WzLDTB1n-4BchGW4bbY7CS6pswTAc=nA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hn6p6_vgb+F1WzLDTB1n-4BchGW4bbY7CS6pswTAc=nA@mail.gmail.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Wed, 19 May 2021 18:10:40 +0800
Message-ID: <CABTNMG12HADeXoWe+25kYKQPcY8KV0GCDx+75GVAVATQ1pZYTA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: EC: Make more Asus laptops use ECDT _GPE
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jian-Hong Pan <jhp@endlessos.org>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@endlessos.org, Chris Chiu <chiu@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 19, 2021 at 5:53 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, May 19, 2021 at 5:11 AM Jian-Hong Pan <jhp@endlessos.org> wrote:
> >
> > From: Chris Chiu <chris.chiu@canonical.com>
> >
> > More ASUS laptops have the _GPE define in the DSDT table with a
> > different value than the _GPE number in the ECDT.
> >
> > This is causing media keys not working on ASUS X505BA/BP, X542BA/BP
> >
> > Add model info to the quirks list.
> >
> > Signed-off-by: Chris Chiu <chiu@endlessm.com>
>
> This has to match the From address.
>
> Chris, can the e-mail address in the S-o-b be changed?
>

Sure. I've updated the .mailmap. Jian-Hong, could you help fix the
S-o-b? Thanks.

Chris

> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> > v2: Edit the author information with valid email address
> >
> >  drivers/acpi/ec.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> > index 13565629ce0a..e8c5da2b964a 100644
> > --- a/drivers/acpi/ec.c
> > +++ b/drivers/acpi/ec.c
> > @@ -1846,6 +1846,22 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
> >         DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> >         DMI_MATCH(DMI_PRODUCT_NAME, "GL702VMK"),}, NULL},
> >         {
> > +       ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X505BA", {
> > +       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> > +       DMI_MATCH(DMI_PRODUCT_NAME, "X505BA"),}, NULL},
> > +       {
> > +       ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X505BP", {
> > +       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> > +       DMI_MATCH(DMI_PRODUCT_NAME, "X505BP"),}, NULL},
> > +       {
> > +       ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X542BA", {
> > +       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> > +       DMI_MATCH(DMI_PRODUCT_NAME, "X542BA"),}, NULL},
> > +       {
> > +       ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X542BP", {
> > +       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> > +       DMI_MATCH(DMI_PRODUCT_NAME, "X542BP"),}, NULL},
> > +       {
> >         ec_honor_ecdt_gpe, "ASUS X550VXK", {
> >         DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> >         DMI_MATCH(DMI_PRODUCT_NAME, "X550VXK"),}, NULL},
> > --
> > 2.31.1
> >
