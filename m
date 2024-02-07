Return-Path: <linux-acpi+bounces-3277-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F484C9DA
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Feb 2024 12:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BFDB22975
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Feb 2024 11:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C80208BC;
	Wed,  7 Feb 2024 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="Y3sikfb0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8662562D
	for <linux-acpi@vger.kernel.org>; Wed,  7 Feb 2024 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306211; cv=none; b=tNKiij40THzVvsgzwSnm5dqkvGMyZzB2LDgVEUjPBrSwbSwsSHE2eV635Csdwt5eypQe55yaLUuIS8z1gVvcrG51UIXbvoId1x+ESlVSHAn4mKl1t1VGuRDJqX1Wywfy+u6efhP+SxJ8cDZOYq78IltgzQrOWA4h9VF5S55ciSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306211; c=relaxed/simple;
	bh=nZWkH4rVzW8TgkmWTIqL4bL803zy1sSUN3lJAXo3+bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZPkUTISy638EJ5jAeGHTc8YfoM+YJ5/14ISdeGrVP6tqDgGHmODbW6KcpPbG/eDMkLC57G7vPPyCkXpOp03+5naaD2NPEYgq4mTHLeEy/nKSlE+urRiWvHNySJPZklf5Y7+9Zy7LdgnN1cDMtBfAJG7RUu3mdxVGfGdAxYfzi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=Y3sikfb0; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso469351276.2
        for <linux-acpi@vger.kernel.org>; Wed, 07 Feb 2024 03:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707306208; x=1707911008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSDT7dq2xZu7tLI0PgHHMilDKxVNEJS24TDaVUc7vdo=;
        b=Y3sikfb00amg3tcvTH2eZUzsg8oF9KEBB76lQv3o8+z78ZXGOnwmBCg8txKQYuJbF3
         G6sUwSKHVZrlheG8IdzxzAn2krymgmcaUlqSmRiGpV3roAdj0CMm6L+N5i2zKQHRhxtH
         5i2ozAV3nKgbMNN44QNxHmI8+yHFO2mndu4BzASoe+B1bQZPGU5d/gqWdk/6i/EhJd5A
         ROvC+8tJWMBE9bd5Kx5u0HgJt+NpTeetij+xeku+CrlPhpUZit2oNLuMEutrJWerQMB9
         Q7LKwKOcev4mWgTOmIV5fE/j9Ukd6hvxineXrNlFt6vr5k7EldfexZ1nhiTsKaO1BV49
         LgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707306208; x=1707911008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSDT7dq2xZu7tLI0PgHHMilDKxVNEJS24TDaVUc7vdo=;
        b=jj8419sSRFFhfXU8H7Nfz7xn+34MMise7WoVVJI/uIGMdT/A+8xso4p2wcc8MQMMda
         +oAE3fX3X0Rl2iFF6CpzXxh6lBc2IrH8m4WXcmP0I/SDrC3gYM655gwso89/LjJ5Y4jR
         vAZ3KTYHWt7WF0ekU0DF/2AsZRhE9QWC3Eh/XNxJHffvZFTehyGfm5EtPCx02oRIFrk4
         izUPqVs4S0Vv42W98k4LEs1j/maXByCIHoTU00X8Kiac3nJDAaNQjmwYqtqVWs+yzGto
         IQAjsns/Mo53vp1bwp8eOkoA8UAG62Qk2YxEkySuLHmXDO/3A331oBzBbidx0Gto4z5n
         /IVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWvmDfqQklQ9/qGxeyx+g+jYuf0MiVs2tzUQ6Mz8hb3A+rjohsWgrBfOBABBxOjCnnZSbhTobM8g3dXKQxU2SLbkY2Wh5uwX4hkQ==
X-Gm-Message-State: AOJu0YxNrmD2E1mEeaBcWhF1mAUSyTAXLIQpkXZA/OQnoOe9hCTuKKPs
	/N5BOjByspv+4lIrMB50TJPSExZdFbAj405rIVEnyQk6wW8auh22AmnQaGCjR6e+J9UrQkI7bf3
	UY6CtnMA5XohiHPHuEFdBZfjkOGZPRAgeB2vDLQ==
X-Google-Smtp-Source: AGHT+IFn+HVjlgt+YrKr/JzEvw+25I76EhKBvMZgbvcCxOvK5+eHr45jglTRp4lAQ22t4Oqg6fRzfzWknmLl9Th3uic=
X-Received: by 2002:a25:ad68:0:b0:dc2:25d4:11ae with SMTP id
 l40-20020a25ad68000000b00dc225d411aemr4253678ybe.2.1707306207713; Wed, 07 Feb
 2024 03:43:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207084452.9597-1-drake@endlessos.org> <20240207084452.9597-2-drake@endlessos.org>
 <CAPpJ_edoG0dD4aHZiZShcFMoD2JLQhbh7nuUPzgMT_ZMySJ=VQ@mail.gmail.com> <CAJZ5v0ikxjoJz7FDQ4dpCuY70w3LvAT5Tjitfzm9MDLdNyPF1g@mail.gmail.com>
In-Reply-To: <CAJZ5v0ikxjoJz7FDQ4dpCuY70w3LvAT5Tjitfzm9MDLdNyPF1g@mail.gmail.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 7 Feb 2024 19:42:51 +0800
Message-ID: <CAPpJ_eceu=ByLCJ=afhq_CV=UZorX2DqE6qiy0+xp0-RXHhtHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Revert "ACPI: PM: Block ASUS B1400CEAE from
 suspend to idle by default"
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Drake <drake@endlessos.org>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	david.e.box@linux.intel.com, mario.limonciello@amd.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rafael J. Wysocki <rafael@kernel.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:30=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Feb 7, 2024 at 10:09=E2=80=AFAM Jian-Hong Pan <jhp@endlessos.org>=
 wrote:
> >
> > Daniel Drake <drake@endlessos.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:45=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > This reverts commit d52848620de00cde4a3a5df908e231b8c8868250, which
> > > was originally put in place to work around a s2idle failure on this
> > > platform where the NVMe device was inaccessible upon resume.
> > >
> > > After extended testing, we found that the firmware's implementation o=
f
> > > S3 is buggy and intermittently fails to wake up the system. We need
> > > to revert to s2idle mode.
> > >
> > > The NVMe issue has now been solved more precisely in the commit title=
d
> > > "PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge"
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215742
> > > Signed-off-by: Daniel Drake <drake@endlessos.org>
> >
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
>
> What is this tag supposed to mean?
>
> In a reply to a patch, you can give Acked-by, Reviewed-by or
> Tested-by.  Which one do you mean?

Ok!  Then, Acked-by: Jian-Hong Pan <jhp@endlessos.org>

> > > ---
> > >  drivers/acpi/sleep.c | 12 ------------
> > >  1 file changed, 12 deletions(-)
> > >
> > > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > > index 808484d112097..728acfeb774d8 100644
> > > --- a/drivers/acpi/sleep.c
> > > +++ b/drivers/acpi/sleep.c
> > > @@ -385,18 +385,6 @@ static const struct dmi_system_id acpisleep_dmi_=
table[] __initconst =3D {
> > >                 DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
> > >                 },
> > >         },
> > > -       /*
> > > -        * ASUS B1400CEAE hangs on resume from suspend (see
> > > -        * https://bugzilla.kernel.org/show_bug.cgi?id=3D215742).
> > > -        */
> > > -       {
> > > -       .callback =3D init_default_s3,
> > > -       .ident =3D "ASUS B1400CEAE",
> > > -       .matches =3D {
> > > -               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> > > -               DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEA=
E"),
> > > -               },
> > > -       },
> > >         {},
> > >  };
> > >
> > > --

