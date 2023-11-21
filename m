Return-Path: <linux-acpi+bounces-1720-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A2A7F3796
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 21:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227471C202DC
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 20:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852375100B
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1C11A1;
	Tue, 21 Nov 2023 12:15:00 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58a106dd421so289493eaf.0;
        Tue, 21 Nov 2023 12:15:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700597699; x=1701202499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UP8hESYtpQcRpZlJ15KqFtLFayiF39ggrDfb/BLbyrA=;
        b=iMx9WpSq/ej2bmuLlFxH0mbn5K7UfYeheDIP7skrPvXQ1QPVksdQZDNGfMAfWkX8M2
         WRSwPSVPyaCihLop6w2GD4suAzLe5Z7xGz86URgKPuF/pQtNWv7qt21Xgvuz7Ej+HL5n
         k/R8vg6LoS9Zy5p7a9KG4xLpePEQ+WCCA15fHb9x1wrFnS/JVPK/cYQQhE0ONqM1dXB8
         v9cyEa0clvc73wWlAhvGsNUjV6EmPUuSKN50ivPWegUXpnkvep0bnp/xZE2x5AqhNAt2
         9RHZHhjCv6ucBE/hsbYv8Xzc6ZINHoqDkBQPqaZ0GK98SjJtkFiVW8boALzRr/YHKsRH
         FGOg==
X-Gm-Message-State: AOJu0Yw73U3mtGd8tidEe5boRGye8oNmHATw1HwuVExYQLSyqqD/n2CB
	RQF5nqXak6H8wrqo0cPiLUmM2cDQt6xKpOUH5Vc=
X-Google-Smtp-Source: AGHT+IHlw+nqBE34QxQ+n37MPYuwO+K3I9M7HUGacBube/dA9hEwVNSXcBdS7KPi+GIWd7FBAc9ZcmHLrbexD8KxeM8=
X-Received: by 2002:a4a:a604:0:b0:589:daaf:44a1 with SMTP id
 e4-20020a4aa604000000b00589daaf44a1mr574171oom.0.1700597699531; Tue, 21 Nov
 2023 12:14:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <430a1271-a45c-4f5a-90c7-a62703ac7cf4@ancud.ru> <CAJZ5v0gHgfscDCGo3P5JVn73uUTBkpfCqRJV3QcOnFt8FP7FhQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gHgfscDCGo3P5JVn73uUTBkpfCqRJV3QcOnFt8FP7FhQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Nov 2023 21:14:48 +0100
Message-ID: <CAJZ5v0jGSSevWuBKFK0z+bQ2QB9+GT=ofnY=MF=53N-r7QEhSw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: LPIT: fix u32 multiplication overflow
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Len Brown <lenb@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 8:56=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Nov 9, 2023 at 7:09=E2=80=AFPM Nikita Kiryushin <kiryushin@ancud.=
ru> wrote:
> >
> > In lpit_update_residency there is a possibility of overflow
> > in multiplication, if tsc_khz is large enough (> UINT_MAX/1000).
>
> That would be a TSC ticking at hundreds of millions of kHz if I'm not
> mistaken.

That should be "hundreds of thousands of kHz", so I was mistaken.

But anyway:

> Why is it really a concern?
>
> > Change multiplication to mul_u32_u32.
>
> So why is this better?
>
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Fixes: eeb2d80d502a ("ACPI / LPIT: Add Low Power Idle Table (LPIT) supp=
ort")
> > Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> > ---
> >   drivers/acpi/acpi_lpit.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
> > index c5598b6d5db8..794962c5c88e 100644
> > --- a/drivers/acpi/acpi_lpit.c
> > +++ b/drivers/acpi/acpi_lpit.c
> > @@ -105,7 +105,7 @@ static void lpit_update_residency(struct
> > lpit_residency_info *info,
> >                 return;
> >         info->frequency =3D lpit_native->counter_frequency ?
> > -                               lpit_native->counter_frequency : tsc_kh=
z * 1000;
> > +                               lpit_native->counter_frequency : mul_u3=
2_u32(tsc_khz, 1000U);
> >         if (!info->frequency)
> >                 info->frequency =3D 1;
> >   -- 2.34.1
> >

