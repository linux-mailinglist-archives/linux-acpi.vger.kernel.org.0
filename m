Return-Path: <linux-acpi+bounces-12515-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3043DA73EF7
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 20:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57C08808D8
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 19:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0992120F08F;
	Thu, 27 Mar 2025 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxsCj518"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F61C7019;
	Thu, 27 Mar 2025 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104377; cv=none; b=YVLYY7DgXQe8mKdiMB3CxYFyeHyT1Y+GI458Zu6IUGGcUCF0dvRUxaNnWwrhZ68/khCaiMZFB/x4eQ3E0ZPOBSVU3eb7jCzHd3BVkwFQyFb2/g2ieRPeOXlWjSSltonle66zAi43Oltv4lLuXhsF7QjI7wzC3A4ndiJojnBr+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104377; c=relaxed/simple;
	bh=qgcmWSQ73m/nlt+LAcujjvdRS2oaqefet/VvhLSsEG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLgybSzgmxNEllGwQ1aVCoJgPgOhHsp9WFFbWLwVfChB7ntpFEDLsv1Vp3zcU2gUWC4QjGI9uiF42ZJ9EXHpuVz+M7IsVfrWiRwgdr8QDVzmwZO3c4WiKOnhmYeIcChKCNtvole5xq2gIeEOnAuDnCWCwU7mKlmaodpkPmQC4AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxsCj518; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514EEC4CEE5;
	Thu, 27 Mar 2025 19:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743104377;
	bh=qgcmWSQ73m/nlt+LAcujjvdRS2oaqefet/VvhLSsEG8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nxsCj518N1E+FFnPXHACZvvt4LT+xHzXkh4tyqzuh+xKr6dTgkMqGJnhjNmiPD8YQ
	 R32cCzpcAwfi95dEV9mlVijk5gFZiuMsTzyu9FotswZew6+GNN5yOQx9Hor00zny2U
	 lwpDpC0wBuEWFf7yLxtO9XyMXjZunY5rlD0vWb194YIDiP8BRXwpAncVecFgxscq1z
	 AkscOD7hDTekILNi0Iq57H4L1yh1OxIG8UweFBGGk2W+VKSyJS0Wd7xCzCGZhW1d/b
	 vUhBD37y3+wswgn3lowQJUPJzHUFCEJLS7n53N5QN9ZkUUYUd4TCVXx7PAvlq/svR/
	 CTyb7QT2wwqTQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2bd2218ba4fso483445fac.1;
        Thu, 27 Mar 2025 12:39:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtRS0xPOqK9ZiL5BwIug7ArTzJURUltV6RAng2u2UafkAbrA1FPn3/TsfbkPcmeJOZcLFwXc9X@vger.kernel.org, AJvYcCWAAb/wqWffDZQ+jykn4+Bof8gh/h9wfBzgegZdiNsPW2fq3P2fmX9AIV1oNEO9IgxsjtybODPlEX6dMfKz@vger.kernel.org, AJvYcCXefyFvMqbP9GSVO3iIdKX1eVWqJBl78hw7oFw2s6gZRhywjxAuir54eJdNCeetwN5NbgBFshcDdCyQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyy4zRvIFdxnLtZ2uRPIlclhxuWzFQWFDdzMMvlPaqBAZ3/5i2
	0k1Re7G5Ks5BsAdCg+YrAOP/MnC2+vmJegp/5VbpTCGBFA1zPNpcMnfyEHgcCQhEII3ZMrBym44
	0mqZt09MQ7Y/MW7cpB3xH6XOFG6Q=
X-Google-Smtp-Source: AGHT+IFfbF859Ml6WjNSHLFR2N7RKpUdQUPsH2SfuPMF9ozrjRYIDTtA4i7eC25mpTuXuPzO1o8vur56NH168cSn1Ew=
X-Received: by 2002:a05:6870:e2cc:b0:2c2:3e54:553 with SMTP id
 586e51a60fabf-2c8481b51f1mr2832440fac.28.1743104376648; Thu, 27 Mar 2025
 12:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318160903.77107-1-pmenzel@molgen.mpg.de> <CABbizf-uBEiujmpUHHPdZT7JftyoM+qUKVRt4wuNxa6Actqo5Q@mail.gmail.com>
In-Reply-To: <CABbizf-uBEiujmpUHHPdZT7JftyoM+qUKVRt4wuNxa6Actqo5Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Mar 2025 20:39:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hP-tJ8YVmAiZF0ij2Z-Mjy4uEvuYoLWi9UC2XdGM6iug@mail.gmail.com>
X-Gm-Features: AQ5f1Joqpr26DlP06rBMLqLghnMo0aVY6tHjw0TNpkbtiN-JtcTcp-SVF_uttKQ
Message-ID: <CAJZ5v0hP-tJ8YVmAiZF0ij2Z-Mjy4uEvuYoLWi9UC2XdGM6iug@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on ASUS Vivobook 14 X1404VAP
To: Anton Shyndin <mrcold.il@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	All applicable <stable@vger.kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 1:50=E2=80=AFPM Anton Shyndin <mrcold.il@gmail.com>=
 wrote:
>
> Tested-by: Anton Shyndin <mrcold.il@gmail.com>
>
> On Tue, Mar 18, 2025 at 6:09=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.d=
e> wrote:
> >
> > Like the ASUS Vivobook X1504VAP and Vivobook X1704VAP, the ASUS Vivoboo=
k 14
> > X1404VAP has its keyboard IRQ (1) described as ActiveLow in the DSDT, w=
hich
> > the kernel overrides to EdgeHigh breaking the keyboard.
> >
> >     $ sudo dmidecode
> >     [=E2=80=A6]
> >     System Information
> >             Manufacturer: ASUSTeK COMPUTER INC.
> >             Product Name: ASUS Vivobook 14 X1404VAP_X1404VA
> >     [=E2=80=A6]
> >     $ grep -A 30 PS2K dsdt.dsl | grep IRQ -A 1
> >                  IRQ (Level, ActiveLow, Exclusive, )
> >                      {1}
> >
> > Add the X1404VAP to the irq1_level_low_skip_override[] quirk table to f=
ix
> > this.
> >
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219224
> > Cc: Anton Shyndin <mrcold.il@gmail.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > ---
> >  drivers/acpi/resource.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> > index b4cd14e7fa76..14c7bac4100b 100644
> > --- a/drivers/acpi/resource.c
> > +++ b/drivers/acpi/resource.c
> > @@ -440,6 +440,13 @@ static const struct dmi_system_id irq1_level_low_s=
kip_override[] =3D {
> >                         DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
> >                 },
> >         },
> > +       {
> > +               /* Asus Vivobook X1404VAP */
> > +               .matches =3D {
> > +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC=
."),
> > +                       DMI_MATCH(DMI_BOARD_NAME, "X1404VAP"),
> > +               },
> > +       },
> >         {
> >                 /* Asus Vivobook X1504VAP */
> >                 .matches =3D {
> > --

Applied as 6.15-rc material, thanks!

