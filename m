Return-Path: <linux-acpi+bounces-6824-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850C992BF6E
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 18:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6EB287D9B
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 16:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E007519EEB1;
	Tue,  9 Jul 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/OaSfPw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770C19E809;
	Tue,  9 Jul 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541298; cv=none; b=jxchVQNwSKVqDfJRb7I0fr3zKjULWHQZjezFhC+sXRuPm0IIkQ9Cmiiqvm74ag6U+oDZJT4E8wr24R3nVvZRc49yj1ub672ZOCPKlWIZTlE5IL4BJfI7haKtYR4wcAeotx87U0dheYVkLnkdBFRK9z2EelKzZkhtem/AuQYE1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541298; c=relaxed/simple;
	bh=ttnEqOC4kIPh4A+V9kLYrPRwCk06/JuvxNJo4wCJ644=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gA2qh+njaSiQNmf9X1HUlhChpDIBd/F0s+c7Z3Ei17XfmvsPYJEZffIgrWLwUwxsCXegxFLW/LPQc5nK9FfgUdduNfCnATTIIQSMpErmFebgNLUTqocfUUb19Ewc1WpfSPz0tpbFOxgW8gM2Vv6RKO1V45ap5JUznCwXf4Ze768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/OaSfPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CB3C32782;
	Tue,  9 Jul 2024 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541298;
	bh=ttnEqOC4kIPh4A+V9kLYrPRwCk06/JuvxNJo4wCJ644=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f/OaSfPwZNPbFg7LVAWYtxKr5Jf+MJgxBR8/ozKEkeAFbqApj2bxHY0pxGOvpfaCB
	 NUWWFDF9ZMb57LiwrGXnsTWBbKzAtukZGW5AYgipXN0oiJsLC5rr1cwuSlmoMZPUN2
	 zO1lCjAdwBpw8YoIm9vuuLwUM7T3qaXeBUpeWSa+zF6NG7wA+WqvR7gPVOQ2AQt0Oq
	 /nDqIyHm85QJQh1RFAPqwHbliV6/+948/Zgpg6Rn7UXEw0yLsQZ5mDu2SYE8Qlsgjp
	 rILfgmTBknUgr0RgaQx6oPbBqB8mJdvbiWuPK+FDvS8dwMzegJtStuZGUAevCYCq2H
	 brYUWNN0cBo9w==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d92531469fso140441b6e.3;
        Tue, 09 Jul 2024 09:08:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+xBV+iBoHamcYIY30W1UiGr0eoQOjNjTBFQO0tfAaQln4KuX/okeyYpmTR2fwNgnuzGQy83w/d4s/QumCnY+2LL0KkPkr4MUh6W/DQtwc+zP2LHH8iCq22WfuafP29HufIlh6CoivoQ==
X-Gm-Message-State: AOJu0YwRJfXPdxGXVC6M2TyLfz5ovUhoRx3kbX9kDqqXiK59bHfQ693p
	EkkF9y/FwEsbckIE+W1z5KP+ueoiz2uGLBXqvq+axQ20Plw3o+TeBT/ucm9T5mM5dEc0wSxIeJg
	Tt0L5sXjw+9bTCMbuzvK7E5hbWtI=
X-Google-Smtp-Source: AGHT+IGhosfelexhYexlV83ag1X5V315poRJX3kSksgClwNnQhmc60skdRAC+hnUw2BgrPedzGxbE28zV878LMpVP6U=
X-Received: by 2002:a05:6808:19a8:b0:3d9:30a2:f8e4 with SMTP id
 5614622812f47-3d93c099e30mr2974065b6e.4.1720541297654; Tue, 09 Jul 2024
 09:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3DA0EAE3-9EB7-492B-96FC-988503BBDCCC@live.com> <b2f69fb8-d87a-4cf4-8d45-11cf1a396e54@redhat.com>
In-Reply-To: <b2f69fb8-d87a-4cf4-8d45-11cf1a396e54@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jul 2024 18:08:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gg=Fj-RqY9zGPWLJ8E-CzWps=mMvrHdpDComndXGCOdw@mail.gmail.com>
Message-ID: <CAJZ5v0gg=Fj-RqY9zGPWLJ8E-CzWps=mMvrHdpDComndXGCOdw@mail.gmail.com>
Subject: Re: [PATCH] acpi video: force native for some T2 macbooks
To: Hans de Goede <hdegoede@redhat.com>, Aditya Garg <gargaditya08@live.com>
Cc: Lukas Wunner <lukas@wunner.de>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 12:13=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 7/5/24 3:56 PM, Aditya Garg wrote:
> > From: Orlando Chamberlain <orlandoch.dev@gmail.com>
> >
> > The intel backlight is needed for these, previously users had nothing i=
n
> > /sys/class/backlight.
> >
> > Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> > Signed-off-by: Aditya Garg <gargaditya08@live.com>
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied as 6.11 material, thanks!

> > ---
> >  drivers/acpi/video_detect.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> > index 442396f6ed1f..baf7264d7b94 100644
> > --- a/drivers/acpi/video_detect.c
> > +++ b/drivers/acpi/video_detect.c
> > @@ -513,6 +513,14 @@ static const struct dmi_system_id video_detect_dmi=
_table[] =3D {
> >               DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
> >               },
> >       },
> > +     {
> > +      .callback =3D video_detect_force_native,
> > +      /* Apple MacBook Air 9,1 */
> > +      .matches =3D {
> > +             DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> > +             DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir9,1"),
> > +             },
> > +     },
> >       {
> >        /* https://bugzilla.redhat.com/show_bug.cgi?id=3D1217249 */
> >        .callback =3D video_detect_force_native,
> > @@ -522,6 +530,14 @@ static const struct dmi_system_id video_detect_dmi=
_table[] =3D {
> >               DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro12,1"),
> >               },
> >       },
> > +     {
> > +      .callback =3D video_detect_force_native,
> > +      /* Apple MacBook Pro 16,2 */
> > +      .matches =3D {
> > +             DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> > +             DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,2"),
> > +             },
> > +     },
> >       {
> >        .callback =3D video_detect_force_native,
> >        /* Dell Inspiron N4010 */
>

