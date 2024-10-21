Return-Path: <linux-acpi+bounces-8876-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D860A9A6771
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 14:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E9A1C21542
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 12:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760B31E6DFC;
	Mon, 21 Oct 2024 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7qExNj5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCD1154BF0
	for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512154; cv=none; b=YjNhWX7skQCjHxjQDh1tIm/LB5HhM0JfLDEbII84/iXvrWmQo/AWXyd6TFWWEzSlrvuaB+ufkkn7KJ+HXNeDubWUnsjuQkMHp/d5D2OAtZjoxHzGlkLxgRmoPY0aFfHHliUaopBvgJa+jcBmtuCN/72uiTEYY5PWiwTqKDEHJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512154; c=relaxed/simple;
	bh=EiRjQ2RKhdvfx2Vxy5Gv5Y5UNymyxhkwtFbXgedgtms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibMLujhoM+QUIZ4R7/bD28s4295p8FsX2/pC07u2XZjAxFTV1T8FCrNQmTWCX0J2MouUXhSK804pij3Zg2HK/QW5MgH3Q9MX4reLilLdFlU6BIE2MjETqNJcJoIzWvd7xiF8A3zVgTLmzsCOL3KArFRINbQiiswPY3lNG+0zWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7qExNj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F048C4CEE6
	for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 12:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729512154;
	bh=EiRjQ2RKhdvfx2Vxy5Gv5Y5UNymyxhkwtFbXgedgtms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T7qExNj5+yvmZXNcFTkL/AnISIoGnmvrJVhIorQFSfaSLCv0mD3+TyUU2ouJOyWTv
	 2BOn/Vct/GI0WU8detzeKQinBuVrMX115BE3tAPqA7DAOeU+OLUKgGxLyZjsybwPY/
	 glKM6trA1qiqXEkRewSGd7rA9LsnbzQbqAps6dFjlYQyPcDg5yO+/fdy6kOGFk7pLn
	 gVjLu7AQVkD32nuuc1IBxz8dIFS5CPpdQA2bJAhxaQLQ/wkq9K4w3XcP76kIZore+o
	 +wFA/NumMCPnv3mVtgRR4UfKRxTrujxyIyJikOTNQBAZdtXDcYG+J2B1dRRh8eDhjy
	 XlSGDEaz/d/Kg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2884e7fad77so2199873fac.2
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 05:02:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YzLkPc7v030SAA+y08ytOWhbZUNY/kY7Y1msUB4CbBP4FKLkVDQ
	0jSOxR2ZjUvyi2q2GVnu+xk+ejhIOeXLE0pxRLgllOyENhPa3QlfneRrlrYD2u54OHj6/iQqnCN
	uCguQBxlive9fXKsw1gjl9F1t3Ug=
X-Google-Smtp-Source: AGHT+IG69Ep0gOzTv2dQeR08Avqqp3NOXUtNzNJJnlxoqxKdnBvLbMDxd8lV3ZgC9HaCCiTn75Bh+RJTPRDz31N1axI=
X-Received: by 2002:a05:6870:b28c:b0:27b:583b:bfa8 with SMTP id
 586e51a60fabf-2892c302f6bmr8036563fac.17.1729512153213; Mon, 21 Oct 2024
 05:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020095045.6036-2-shubiisp8@gmail.com>
In-Reply-To: <20241020095045.6036-2-shubiisp8@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 14:02:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gYsdgGyHybRRK4gqRwfk=cAA9sU8ZBdwwHunS1EXJ15A@mail.gmail.com>
Message-ID: <CAJZ5v0gYsdgGyHybRRK4gqRwfk=cAA9sU8ZBdwwHunS1EXJ15A@mail.gmail.com>
Subject: Re: [v2] ACPI: button: Add DMI quirk for Samsung Galaxy Book2 to fix
 initial lid detection issue
To: Shubham Panwar <shubiisp8@gmail.com>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 11:59=E2=80=AFAM Shubham Panwar <shubiisp8@gmail.co=
m> wrote:
>
> Changes in v2:
> - Removed extra blank lines
> - Fixed whitespace issues
> - Added appropriate commit description
>
> This patch adds a DMI quirk for the Samsung Galaxy Book2 to fix the initi=
al
> lid state detection issue. The _LID device incorrectly returns the lid
> status as "closed" during boot, causing the system to enter a suspend loo=
p
> right after booting. This quirk ensures that the correct lid state is
> reported initially, preventing the system from immediately suspending
> after startup.
>
> This fix only addresses the initial lid state detection and ensures prope=
r
> system behavior upon boot.
>
> Signed-off-by: Shubham Panwar <shubiisp8@gmail.com>

Applied as 6.12-rc material, thanks!

> ---
>  drivers/acpi/button.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 51470208e..7773e6b86 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -130,6 +130,17 @@ static const struct dmi_system_id dmi_lid_quirks[] =
=3D {
>                 },
>                 .driver_data =3D (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
>         },
> +       {
> +               /*
> +                * Samsung galaxybook2 ,initial _LID device notification =
returns
> +                * lid closed.
> +                */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO=
., LTD."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "750XED"),
> +               },
> +               .driver_data =3D (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
> +       },
>         {}
>  };
>
> --
> 2.47.0
>
>

