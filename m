Return-Path: <linux-acpi+bounces-394-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056857B7281
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 22:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AB0A128105E
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDB73D964
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB013B2B7
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 18:39:24 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC6890;
	Tue,  3 Oct 2023 11:39:23 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57b68555467so115922eaf.0;
        Tue, 03 Oct 2023 11:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696358363; x=1696963163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojh0GlprYqfF4cES3KrVg8rZgISvukWPZ0bGNIr9lsc=;
        b=en8U3/kHZ14ldFsqt6niKdDBC6pd+EZ8H0cN6Z1ZDTESRKSzWGd1B3WIDOvtOFCVAa
         ho2xti13uc2unMz3oEHaZiQ1gOG7rbqXUiJxjthDtMEjB9tyrYxnwJ8WTS0MuY6LVyty
         IzpZF8tQ/27az2Hw085nLJe8jx9wmkQ7f/19g0tp1PaNitBzQFZtT7T/ogiwEqD1LOYL
         p4XufJomWxDCL/x27xIMhKCdmwBGPFXMwCb9NZHpl31hauZv0nj31LUXpy3v7ERuq2/4
         wd4uuy7wxGTRMpSLoj14kKCcE7H0O9JktsXAuDkhL/sceHJ8rdR8x8llNDACpajdsZLy
         vvzw==
X-Gm-Message-State: AOJu0YzY3PaloRvS7fplaGA7bPZJYjXmzc/hGGMl/oQGJkcKLY/R9V7e
	FnafjaYiHZCswhsaI8+kFHsnDN9StwdM17M7IqDetZsO
X-Google-Smtp-Source: AGHT+IGIPULYGzQU1uU2lrfZfjw8XgoLLWATNuwr7it5GWVlqYL9FcAZaNIzPNZ2SUaDhSa0Ts+6j6eYn8cl97w/rPk=
X-Received: by 2002:a4a:df07:0:b0:57b:73f6:6f80 with SMTP id
 i7-20020a4adf07000000b0057b73f66f80mr245642oou.0.1696358363021; Tue, 03 Oct
 2023 11:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929134010.25644-1-wse@tuxedocomputers.com>
In-Reply-To: <20230929134010.25644-1-wse@tuxedocomputers.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 20:39:11 +0200
Message-ID: <CAJZ5v0iH4PGaCdSuQ-4Pu7oXbzrw+zLxpEqMjtMgcNFextgfqw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Do IRQ override on TongFang GMxXGxx
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 3:40=E2=80=AFPM Werner Sembach <wse@tuxedocomputers=
.com> wrote:
>
> The TongFang GMxXGxx/TUXEDO Stellaris/Pollaris Gen5 needs IRQ overriding
> for the keyboard to work. Adding an entry for this laptop to the
> override_table makes the internal keyboard functional again.

You said "again", so it used to work.  Do you know which commit broke it?

> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: <stable@vger.kernel.org>

What's the oldest kernel version you want this to be applied to?

> ---
>  drivers/acpi/resource.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 32cfa3f4efd3d..3aff81820e321 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -470,13 +470,25 @@ static const struct dmi_system_id asus_laptop[] =3D=
 {
>         { }
>  };
>
> -static const struct dmi_system_id tongfang_gm_rg[] =3D {
> +static const struct dmi_system_id tongfang_gm[] =3D {
>         {
>                 .ident =3D "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Ste=
llaris 15 Gen4 AMD",
>                 .matches =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
>                 },
>         },
> +       {
> +               .ident =3D "TongFang GMxXGxx/TUXEDO Polaris 15 Gen5 AMD",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
> +               },
> +       },
> +       {
> +               .ident =3D "TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD=
",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GM6XGxX"),
> +               },
> +       },
>         { }
>  };
>
> @@ -536,7 +548,7 @@ struct irq_override_cmp {
>  static const struct irq_override_cmp override_table[] =3D {
>         { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, fal=
se },
>         { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false=
 },
> -       { tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, tru=
e },
> +       { tongfang_gm, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true }=
,
>         { maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, tr=
ue },
>         { pcspecialist_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1=
, true },
>         { lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false }=
,
> --
> 2.34.1
>

