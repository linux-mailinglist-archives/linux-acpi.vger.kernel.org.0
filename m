Return-Path: <linux-acpi+bounces-12349-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCACA68D2F
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Mar 2025 13:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCB51771FC
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Mar 2025 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C2D206F19;
	Wed, 19 Mar 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaUYXmIh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739542528F1;
	Wed, 19 Mar 2025 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742388652; cv=none; b=HF4+mlkXSc10lbep9/d1M1gmyNY4IJvPxS1Naz6igatxN7IuGes8eqK79M/ZkSQ5bu2WbwoqpI3JB2rjwUcxbgNgo2ees6Mc3/49Hv/Afn1ZGkZU0UdCj0DCVTw1WvRAi1eG/iwqUB45PDxgwOEdiJL659usAFJ/WMEg78PWOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742388652; c=relaxed/simple;
	bh=lTT6GrsfB43M99ZYz/tBaX8GosbcB7cxSqwTPc8WAHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlMyqiZIH1/yJDuGHFLz+JwJDXXwFKsOPnkcX6G8ZFOGbJoCRXdrnaNT75OKGLlyFKDtYudIpsuLLZjly3DXhzqLqA+kAdO5N6HFz7MyZn1UtYE+/0cQpCSr7ibXwenL5QKu0PCPDOuT8OFkJSf0ACGRHIA4j1feJCSIsFJ+KXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaUYXmIh; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-301c4850194so648363a91.2;
        Wed, 19 Mar 2025 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742388650; x=1742993450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoReY8zRe1ZMKnYZtwb0mLRHB4ICMrHMoJ+T2biCTOQ=;
        b=kaUYXmIhv8TWlRW95q2GktsIecoAwvJGfw4DX78cXyyyYi0askyWc93laOP1hYacYa
         3ZAzmBSE38OrNg4VMEyQ5+NBC/bphqle2bIh7UCnWPRksQ/U5ajNG1hJ3v+AzbDa1tsN
         gnA/Gzp6MR+3SJZkujhErASz2oBAgT/XqBdGC/F9n2ttYsRAZoP1HCFh+ypUeoCI2tnp
         2jHGVRdRH++SKWY3QyXwAsmEgb30KLKC9P5u/eP5Fj8Qd2j28l/zwFVeL79RZTrS/qY0
         aNWc6zwOrLmD95OW+Nh/kV+Wd/f2cFi1Nz7BORPcKFGHE0evogENz7VJNPu4t9PZN5HU
         LF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742388650; x=1742993450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoReY8zRe1ZMKnYZtwb0mLRHB4ICMrHMoJ+T2biCTOQ=;
        b=GD6oWOp+6UjhXmDf5VrEr/LTpXUJmCbbbebiMQRz+WKHskwLt0zwfQtvG4ZMP7bIc1
         xbhll4rGayi/xRulZ8c7DDLhvGbGTfAW1nsZMzV8g3VelL/jp5pZ8eW648AtqGdMRuGN
         dVMnY6gCqD8NbViHmM10T8rKfeia7R9X2TVjdN/PcIZQaiPlrwH1b05YOMooLzcqHUL1
         vz01E8C6KZA8ws5bWdilJ58IsygGL5RIpoGOk7Bl+rWGQSEdJkBFy3Usv2Ywe2vWI1fE
         clbTEvKDDcTfGL0OurNeEjdaULmkke+y+JCfxLzHujZnP9QK6Rpch2lCU6x2DwTcoJzm
         Cqyg==
X-Forwarded-Encrypted: i=1; AJvYcCVEbQ98bRu/WoL3zBWBpIDKHQBKBOLX5vZqZMr15dfsQv9A35P+JxjCfxNTEOXMoktQ4JtFmpO8@vger.kernel.org, AJvYcCVNUSEN9cR/rJVhSxQ3LlioDds6eAU4otChwd9TCkB0XfqjHgX/i5Ih2YGiX7//58WNgyABAY8a4rt6@vger.kernel.org, AJvYcCXubc867guLgtOqD3BfRyOLPfoDIdRTf+2rBx9sv+NhjcZcP7MWepfWEUgopAB+fRKFeEZF02iZKSlZZAZF@vger.kernel.org
X-Gm-Message-State: AOJu0YxKGoD5jH1WGUduiGF1rii2jKpdIGlSoBCWc4T0+ADX600qd2XA
	r/xOzeZot8C637QCN/lXZ0tMANi9JOdBWWN+4yM6CaXaS24KkFJErlaHOygJ4nwTsUZ6N3PT9kQ
	qXjKdGEko5pGC2HQlEt0rrzKbI78=
X-Gm-Gg: ASbGncv1Am6gZ07IzvoB/Lq12nETAFobt5gbnZEIYDyYX31NcqDOEwfpD/Sdm7/9kHG
	n8Rjww1ZR6BQAHYfO0JPHYQpU723ipPD9+8Cb/IzaLHkytAeZjA4YE8GMQbIi643Y/0bS4ydRlL
	P1iYUmbr4cpOczN0+YTIuOcArlSjU=
X-Google-Smtp-Source: AGHT+IFlBhqxbaeyaYnJ2KXZzzemvsVVjBjoBCcf37fdZGKb5QZ1+13/+IU9V72+aJ5q7s2cdg3vQzvvuFPN5O+ptQY=
X-Received: by 2002:a17:90a:e7ce:b0:2fe:ba7f:8032 with SMTP id
 98e67ed59e1d1-301bde6cfa0mr3853988a91.9.1742388650547; Wed, 19 Mar 2025
 05:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318160903.77107-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20250318160903.77107-1-pmenzel@molgen.mpg.de>
From: Anton Shyndin <mrcold.il@gmail.com>
Date: Wed, 19 Mar 2025 14:50:39 +0200
X-Gm-Features: AQ5f1JpJAuivja5bKbdIYCT80Pn308IVZtmA13wOu11CsVRkYn66mwoP4nH_XtU
Message-ID: <CABbizf-uBEiujmpUHHPdZT7JftyoM+qUKVRt4wuNxa6Actqo5Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on ASUS Vivobook 14 X1404VAP
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, All applicable <stable@vger.kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Anton Shyndin <mrcold.il@gmail.com>

On Tue, Mar 18, 2025 at 6:09=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Like the ASUS Vivobook X1504VAP and Vivobook X1704VAP, the ASUS Vivobook =
14
> X1404VAP has its keyboard IRQ (1) described as ActiveLow in the DSDT, whi=
ch
> the kernel overrides to EdgeHigh breaking the keyboard.
>
>     $ sudo dmidecode
>     [=E2=80=A6]
>     System Information
>             Manufacturer: ASUSTeK COMPUTER INC.
>             Product Name: ASUS Vivobook 14 X1404VAP_X1404VA
>     [=E2=80=A6]
>     $ grep -A 30 PS2K dsdt.dsl | grep IRQ -A 1
>                  IRQ (Level, ActiveLow, Exclusive, )
>                      {1}
>
> Add the X1404VAP to the irq1_level_low_skip_override[] quirk table to fix
> this.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219224
> Cc: Anton Shyndin <mrcold.il@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index b4cd14e7fa76..14c7bac4100b 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -440,6 +440,13 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
>                 },
>         },
> +       {
> +               /* Asus Vivobook X1404VAP */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> +                       DMI_MATCH(DMI_BOARD_NAME, "X1404VAP"),
> +               },
> +       },
>         {
>                 /* Asus Vivobook X1504VAP */
>                 .matches =3D {
> --
> 2.49.0
>

