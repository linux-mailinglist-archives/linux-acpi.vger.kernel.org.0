Return-Path: <linux-acpi+bounces-12556-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE15DA7655E
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 14:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6267E16A172
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 12:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2CE1E2613;
	Mon, 31 Mar 2025 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzHcLYEn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB01E2307;
	Mon, 31 Mar 2025 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743422845; cv=none; b=gegD/rWxBtZed8atekXrTl51uwGXq/FmaR8OnDZiZYQpu8HtGTOB5YscH5/JJx6IXQEFmXuez2tW+/rUnK7hvmjmcn0guscRBk5pvQnKQwv780v4On5AHuvUys+PBd4JmgOxCS47JubrGZK51qKn0Av+oVJe7Pc+wS2y93zqUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743422845; c=relaxed/simple;
	bh=1ThVDolRoOuV8VkIIp6hbxTzz5LvEBEw3AMGfClMmb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMrEa64/T2KIvE6viglKO9wZ3EGY6TeXW1G5MaGjx8U1JZuJNriJcd0xmAXnpuFCAc6SxnyClLWG4jXCutj+M7UdhxTJesZC+jgBS7hw8u3FmNaQhQF/L0QzQPh53LWazoHL9B+XPHk+LDOVBZpHfo2I2YDvrpe9G80QhdHcwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzHcLYEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDAFC4CEEB;
	Mon, 31 Mar 2025 12:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743422845;
	bh=1ThVDolRoOuV8VkIIp6hbxTzz5LvEBEw3AMGfClMmb4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GzHcLYEn3Ny6zHRzjloh5mtUFOKYJwuZHizKa5Mg78jwEdQpFgfNJTAjFSmXn9Jsy
	 h92D4RgEx5vgq3l81qJxTnoBaDduLOb+7O3mjc3e2t9/a/yNjHColRm5ECnR+P6HHN
	 ENIkJW+zYF2I92TTURsrwGkSEWBYCiL0vIoGMJ5AgYTykXrUnNtSiDRwvNRDAIXSqJ
	 /Ho9Zkr4wd2aantD8JN48Fgo8R2BJr7T5pu5GSZFBeKbfYPAw0+TILHNCrivpBVV53
	 8eNq2CcStBbZ2TzBQG047Qg/+/PflUOlti/yytEPkSohEeamGLL1FmuuSLNTXlKtom
	 h4ikez2nSxdaw==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72c13802133so1243257a34.3;
        Mon, 31 Mar 2025 05:07:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6KjZwEMjM4FI94cSfKHRhvbr5WdL1zbGqV7aOlMn6SaO2h+X0Mo48yyEG7brTTahrKTlnt6hKK2Y=@vger.kernel.org, AJvYcCWH7Lh0hQNu9K3gXUPOd1CB+WbwOF2BzIJuuVgArivEJ9kMoOObD0/yGL8ph0Cwa3zEoXsz0v1i/z2t@vger.kernel.org, AJvYcCXqSPj7EGD7aBnQChsnAKaraSlY6Yt8T3QpemKL1pdDUfc6S/gCQvJKIK5BFnD81ExKhOoPa785yQGPvSit@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/cE3MokdqaYVz09wdjxhrV+JnTGEiJlosut8Cq7mcko+44M47
	u2TGxV5XXgg93VNyM087IQ4I+LNeE08hjZwR9KL1L3kZRT+PVDarFkUi3AJxo0duNEZIsfii158
	tK7eUWJ1jNcbflGIaBcrx0szuYwU=
X-Google-Smtp-Source: AGHT+IFFOzs3GR6fst2FZdTPiHgytWi1lzYCXKoFaBP6man/WR8goAaw2WVdZEbCHSVPqeVXmCsizPE96fim93Xw59Y=
X-Received: by 2002:a05:6808:3c4a:b0:3f8:eee4:7140 with SMTP id
 5614622812f47-3ff0f53a861mr6838248b6e.22.1743422844145; Mon, 31 Mar 2025
 05:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328143040.9348-1-ggherdovich@suse.cz> <20250328143040.9348-2-ggherdovich@suse.cz>
 <SJ0PR11MB66228319834B1C7B48FCE52EF5AD2@SJ0PR11MB6622.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB66228319834B1C7B48FCE52EF5AD2@SJ0PR11MB6622.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 31 Mar 2025 14:07:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gC3DzanSdPqQiJ4JQppgNeRA7Z9Cge7NxmTO_shoUyOA@mail.gmail.com>
X-Gm-Features: AQ5f1Jpiz1ZW-0Bl1lF2W3TRNAnvi3ePtK28dr6XZHboJOgboExpJXJWuhWkTtE
Message-ID: <CAJZ5v0gC3DzanSdPqQiJ4JQppgNeRA7Z9Cge7NxmTO_shoUyOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 9:38=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> > -----Original Message-----
> > From: Giovanni Gherdovich <ggherdovich@suse.cz>
> > Sent: Friday, March 28, 2025 10:31 PM
> > To: Rafael J . Wysocki <rafael@kernel.org>; Zhang, Rui <rui.zhang@intel=
.com>
> > Cc: Len Brown <lenb@kernel.org>; Giovanni Gherdovich
> > <ggherdovich@suse.cz>; linux-acpi@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-pm@vger.kernel.org
> > Subject: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
> > Importance: High
> >
> > Since commit 496121c02127e9c460b436244c38260b044cc45a ("ACPI:
> > processor:
> > idle: Allow probing on platforms with one ACPI C-state"), the comment
> > doesn't reflect the code anymore; remove it.
> >
> > Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> > ---
> >  drivers/acpi/processor_idle.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idl=
e.c
> > index b181f7fc2090..2a076c7a825a 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -482,10 +482,6 @@ static int acpi_processor_get_cstate_info(struct
> > acpi_processor *pr)
> >
> >       pr->power.count =3D acpi_processor_power_verify(pr);
> >
> > -     /*
> > -      * if one state of type C2 or C3 is available, mark this
> > -      * CPU as being "idle manageable"
> > -      */
> >       for (i =3D 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
> >               if (pr->power.states[i].valid) {
> >                       pr->power.count =3D i;
> > --
> > 2.43.0
>
> I think we can clean up a bit more. How about the patch below?
>
> From 115d3a07febff32eed49f9343ef111e7e1452f9d Mon Sep 17 00:00:00 2001
> From: "Zhang, Rui" <rui.zhang@intel.com>
> Date: Mon, 31 Mar 2025 07:29:57 +0000
> Subject: [PATCH] ACPI: processor: idle: Simplify
>  acpi_processor_get_cstate_info() logic
>
> Since commit 496121c02127 ("ACPI: processor: idle: Allow probing on
> platforms with one ACPI C-state"), acpi_idle driver can be probed with
> C1 only.
>
> Optimize the logic for setting pr->power.count and pr->flags.power by
> 1. unconditionally set pr->flags.power leveraging the fact that C1 is
>    always valid after acpi_processor_get_power_info_default().
> 2. update acpi_processor_power_verify() to return the highest valid
>    C-state directly.
>
> No functional change intended.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/processor_idle.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 698897b29de2..7ce8c3802937 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -442,7 +442,7 @@ static int acpi_processor_power_verify(struct acpi_pr=
ocessor *pr)
>
>                 lapic_timer_check_state(i, pr, cx);
>                 tsc_check_state(cx->type);
> -               working++;
> +               working =3D i;

What if some states are skipped because they are invalid?  'working'
can be less than 'i' then AFAICS.

>         }
>
>         if (buggy_latency) {
> @@ -457,7 +457,6 @@ static int acpi_processor_power_verify(struct acpi_pr=
ocessor *pr)
>
>  static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
>  {
> -       unsigned int i;
>         int result;
>
>
> @@ -477,17 +476,7 @@ static int acpi_processor_get_cstate_info(struct acp=
i_processor *pr)
>         acpi_processor_get_power_info_default(pr);
>
>         pr->power.count =3D acpi_processor_power_verify(pr);
> -
> -       /*
> -        * if one state of type C2 or C3 is available, mark this
> -        * CPU as being "idle manageable"
> -        */
> -       for (i =3D 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
> -               if (pr->power.states[i].valid) {
> -                       pr->power.count =3D i;
> -                       pr->flags.power =3D 1;
> -               }
> -       }
> +       pr->flags.power =3D 1;
>
>         return 0;
>  }
> --

