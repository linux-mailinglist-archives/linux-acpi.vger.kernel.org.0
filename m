Return-Path: <linux-acpi+bounces-14973-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798BDAF7361
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 14:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C2A3B74B4
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 12:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AE02E3AFD;
	Thu,  3 Jul 2025 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjPVz5eT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B142DE6E2;
	Thu,  3 Jul 2025 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544707; cv=none; b=PVYUY9iPLXKhNc4ysy0rC8YQWINxEs6SIkiVgCkcSD0c4pQpnsg3FSdxW7PtsYixh6tOZwT/mM6tzsiy3iv2zxPY20jF/cuswJL/7GVAtjp0oBFU4LdUm1j3h4eZMbI9dNJk6Isg/gL17sZXwd989+4W8SMkB5pjLAQyfyvTab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544707; c=relaxed/simple;
	bh=/u695DCkL8w+yoQZGNJnVtq6t82qtpyg/gJ1B9UDub0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8K7rb2SiynnxpUoZTioGeNW3K1T8AzvlMW7H7MgMRuUJFZ2X9WpOKrFMKwMgCZpCGOIFT6pSn20HU//H7EgkD/glcclkAYiAu/pHAuY6veyUXTcDsRCE9dPKcRF3NXC3ZJStWfT3ynmhJKbd8M9n5n+GypehDVRL0ewqHuCAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjPVz5eT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C03C4CEE3;
	Thu,  3 Jul 2025 12:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751544706;
	bh=/u695DCkL8w+yoQZGNJnVtq6t82qtpyg/gJ1B9UDub0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FjPVz5eTcZjLiKLc4yZNGS0tEKOsUK6irjZ9OpErjuLjVQ3MlgZqs2Mizo/tELfkC
	 wp7kmeqOWM7ZR3MJYNLTKRMYJDgpb3/z+U6cXgX1vuuiecmAgeQR7dWlDdQTNIlc4w
	 qrE2Z8QfHdOhueZCRzMv1gj96sqtR530RHuKv19GObiCzplnCqUI6i7qj5tq/t5fAD
	 8O6Fnf3KbLniVCrlyP6FhtIJ69r5o2jtPdpc7NKghF7GEPa/2Cgd+1nFehqd/gMCQz
	 xlYpglmpmDMwRBG2cyWP5jxcXUVQL7vVXya3CTBnspG9CX0hlvtHqrygjXV1SaIHyF
	 H5LOMcG2QEMVw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6113f0cafb2so2556478eaf.1;
        Thu, 03 Jul 2025 05:11:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFKLdsbRfccLYcWSgqMkUkFE3byc2I2WNqSiqch1eO8MpJDqN8S9gEiPu6empzmrlwVQCBZ2scwmA=@vger.kernel.org, AJvYcCXPO0jVbJMh3Djvd1N+4ZIfAKN++o1XyKpKYvgaEdtqRrif+Yu+4PxqPs0LS+8DU5coB7m6oby9kLKL3Ofv@vger.kernel.org, AJvYcCXzbVVJrv/D/WSvH6xAmTrHRSV/a3XLViMrD1h2t8JfnREVv9cAX/Mh+wTtVMcug6O1wEc4wTmd7pIT@vger.kernel.org
X-Gm-Message-State: AOJu0YynrG5NlE4LuXQ3taQvMQZGI95wwWlCoWq7+ERwy6+fu1LlSMJs
	4Po6Itb+J6824rJW825RxN4ApFL6n8lNkGVRbBZQ53pyci1TWfr0tuB3a/nI5NsjJrqDsgOCw6S
	STS0DtOnB+cH7GgIKHJzpPDhtSI597vY=
X-Google-Smtp-Source: AGHT+IE5Vw4m4mXPct9wVJmubJXbT4c5/+l/c/Mue+EJKIDprCrU46NbVGdZsrRTFJ0qceb/2zMPdR465PTwB9KXq7c=
X-Received: by 2002:a05:6820:c8f:b0:611:e00a:598d with SMTP id
 006d021491bc7-6120116d82fmr4804121eaf.8.1751544705742; Thu, 03 Jul 2025
 05:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621051704.12050-1-sumeet4linux@gmail.com>
 <CAJZ5v0hqAO32zdLcwZ9UtWEhf=OfCqUN0PkB83v6=suXMP14UQ@mail.gmail.com> <CAJ9orWQAPun6Oy3wMOBK+OYcvUTHDEZ7GUgsuxU2pctNY7O3Mw@mail.gmail.com>
In-Reply-To: <CAJ9orWQAPun6Oy3wMOBK+OYcvUTHDEZ7GUgsuxU2pctNY7O3Mw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 14:11:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g-bArTdntUCv=NiuBX7aDTGifYFF8Q8nhn6XmBgSKgCQ@mail.gmail.com>
X-Gm-Features: Ac12FXxyhSxv2LmBLQfy0x5Qbf55cDQu9Rq43uU9cCdIUQP2BDKCcltIagN9xd4
Message-ID: <CAJZ5v0g-bArTdntUCv=NiuBX7aDTGifYFF8Q8nhn6XmBgSKgCQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: FAN: Update fps count debug print
To: "Sumeet R.P." <sumeet4linux@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, lenb@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 1:37=E2=80=AFPM Sumeet R.P. <sumeet4linux@gmail.com>=
 wrote:
>
>
> On Wed, Jul 2, 2025 at 11:24=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
>>
>> On Sat, Jun 21, 2025 at 7:17=E2=80=AFAM Sumeet Pawnikar <sumeet4linux@gm=
ail.com> wrote:
>> >
>> > Update invalid value returned debug print with fps_count
>> > instead of control value for checking fan fps count condition.
>> >
>> > Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
>> > ---
>> >  drivers/acpi/fan_core.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
>> > index 8ad12ad3aaaf..9f2696a1928c 100644
>> > --- a/drivers/acpi/fan_core.c
>> > +++ b/drivers/acpi/fan_core.c
>> > @@ -102,7 +102,7 @@ static int fan_get_state_acpi4(struct acpi_device =
*device, unsigned long *state)
>> >                         break;
>> >         }
>> >         if (i =3D=3D fan->fps_count) {
>> > -               dev_dbg(&device->dev, "Invalid control value returned\=
n");
>> > +               dev_dbg(&device->dev, "Invalid fps_count value returne=
d\n");
>>
>> I guess this should be "fps" instead of "fps_count" because the latter
>> is just the array size, isn't it?
>>
>
> Yes, this can be fps.
>
>>
>> But I don't see why it should not be "control" either.
>>
> In this same function fan_get_state_acpi4(), the same debug print message
> is already present for invalid control value.
> So, it's confusing when we get the message and difficult to identify
> due to which condition the message is coming from.

Agreed, so maybe change the second message to something like "No
matching fps control value".

