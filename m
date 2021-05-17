Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDB63831FC
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 16:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240649AbhEQOnq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 10:43:46 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:33670 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240240AbhEQOll (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 May 2021 10:41:41 -0400
Received: by mail-oi1-f176.google.com with SMTP id b25so6737797oic.0;
        Mon, 17 May 2021 07:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCTj6HgOq3kiS9EgLLQMGC5yw5m63tUFyLTYwxvC2gM=;
        b=tg/ev4ENmNbgBm7WLLIgJQAgYOEEE34Iq87uZnaHd5fTOKyuLCp9B66vK7EDa1NSWq
         lmKNHPMNinEzFgv5aRNLhcDylxPRaIBQR8lz03Nl91ca2XAwdNZCaF4gKvFp2b7SkuIp
         YyLMvIURBsmc1iSy02o3Qi4yjuYoGP8ObZ2B5idkRur3QcGboQTMUyp2/KodKkOCGA5M
         f7tRre17n2c4m1+ZuTENGJnoIRa7xL6ZJz1Vj1B4nLcXnlHy2dDLOs3OZ9XVwvKYj62y
         HTYYsfaDgIArSWj8rF4/TFQGow8AgXjIMrKUevLvhXxOjDcVqvvdgsw/aeSiWNzmm10g
         GH9w==
X-Gm-Message-State: AOAM530j/9xREABeNu2QAtTjiPB36w/hJI2KBlVMgTp7HP63+O2EpaaO
        dQQahwqFcuC9Uudw3PEFwJDsY8S826Hp2eMxIlc=
X-Google-Smtp-Source: ABdhPJwQ2qgBZtQf/GnZT0PoBoRySutc7ORD6yx1CUs52aGO/rZAy/KrZNJkaPf5W8Dy093AtfDOuOqLknHJKlQByhs=
X-Received: by 2002:aca:380a:: with SMTP id f10mr109907oia.157.1621262424289;
 Mon, 17 May 2021 07:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210511063835.7794-1-jhp@endlessos.org> <CAJZ5v0hsNSpL+1ero_+pzz97Xz4UCwjBv7swg+3CAne7_OUKkQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hsNSpL+1ero_+pzz97Xz4UCwjBv7swg+3CAne7_OUKkQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 May 2021 16:40:13 +0200
Message-ID: <CAJZ5v0iU15F42yGm5etxmMLsDwC=u7p1eT6EoVADnJnV8+S4VA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / EC: Fix media keys not working problem on more
 Asus laptops
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jian-Hong Pan <jhp@endlessos.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Chris Chiu <chris.chiu@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 17, 2021 at 4:32 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, May 11, 2021 at 8:40 AM Jian-Hong Pan <jhp@endlessos.org> wrote:
> >
> > From: Chris Chiu <chiu@endlessm.com>
> >
> > More ASUS laptops have the _GPE define in the DSDT table with a
> > different value than the _GPE number in the ECDT.
> >
> > This is causing media keys not working on ASUS X505BA/BP, X542BA/BP
> >
> > Add model info to the quirks list.
> >
> > Signed-off-by: Chris Chiu <chiu@endlessm.com>
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
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
>
> Applied as 5.14 material under a different subject ("ACPI: EC: Make
> more Asus laptops use ECDT _GPE"), thanks!

And dropped, because the chiu@endlessm.com email address is bouncing.

Please resend with a valid email address in the From: field, thanks!
