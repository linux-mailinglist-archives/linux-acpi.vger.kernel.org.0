Return-Path: <linux-acpi+bounces-5632-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C658BCC93
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 13:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0755C1C21670
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 11:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEB6128372;
	Mon,  6 May 2024 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inYDud+5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C44436A
	for <linux-acpi@vger.kernel.org>; Mon,  6 May 2024 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714993463; cv=none; b=ihTDm8g3KjbkUZuIVIJKxZOHHks52feePyQvbrlX4QmbZTi7kituLPvNoeiSEhQwS3RsmVxow4PH6IvphMtPPq2xv9ao75JMGSxTIvKQrP1V4NFDVNHHUPnFWRBOjfrv5mk+u99XGBfojU8FO3WDUtHVCjW//QpP+Y3j3TnA+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714993463; c=relaxed/simple;
	bh=p/A5aIzSQzZcm6TqMdZtINKLJ3DvvyNU4aB2a57Agfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsrCQFUz394F+1ui2bN1hGh6Dr8ATXVyMO2uHjqop20Oy85S5f4RQmKyJ9/pyxu33EfMZgdUOQMSTG0rjC31i1CJraPM06YdyQFicHKU6NAI+I4pt3UP+RBudlvYTsbgMjWiRHbnhJu29w63lY/rEwSw8ZIvD71WUKkDzJlAgQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inYDud+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69E6C4AF18
	for <linux-acpi@vger.kernel.org>; Mon,  6 May 2024 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714993462;
	bh=p/A5aIzSQzZcm6TqMdZtINKLJ3DvvyNU4aB2a57Agfk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=inYDud+5Wdf0WAK2GAm7Kp6rKzTBcsSsi1NgTL3DBivs2X/0E3f6hIGF/hCyEF8RU
	 BWZLrTW5Eu8Bi44wGPqOnZtvAN6W/UEMHvWlZpGLlsaYDJl8fnKxHON+xWnD/tVNsb
	 XBpoVvW48bua3PesbemVuzBN387iGJTXvtG551pSwNglsG4tngwWn5jok05VV1k5ek
	 ZzF/uLtx/5fC5jmtAezuqPi61MdH6CAlvVtJBWEmNIAAn7GfYJn9vPg/kQ+JJaYrm+
	 rWGP+SouQClPzl/BoLp8q8VCMnmAS4oI1+sG9mUPfLR0s9v1lsU/ESlqURJgBV9VxI
	 suAOhQxbf2RDQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b2013d0090so462454eaf.2
        for <linux-acpi@vger.kernel.org>; Mon, 06 May 2024 04:04:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW16I0ojAtf+U+NiOP3Nbkjh7tNmqj6F87LUpUXti1gu97BAcP/U9twvtrp/BigZuUWGYTNc+8BtYgTv9qZphNSTF6grP3d25xPyA==
X-Gm-Message-State: AOJu0Yx03ttAz4I41Vbmvb3zsauC5EwV/QY1wGcBKa5HktEpGNNakkua
	lnm1aJ9zkjFdUlygDfxv7Kt1dZy/fHh+YuMalX0wVthukSiC2BhqCYf114tP/PssrJX1uDEeTDY
	dit4j4w/9FounVzbO7UcRbSkj7Js=
X-Google-Smtp-Source: AGHT+IEQqNeY9c13jd+uVvrRWpkYt+xvpbTmepqElmtJ/8ZvPh2rpNEkt4JVWUyAwViRkVWKrEwkoyl7nybD3sWqdF8=
X-Received: by 2002:a05:6820:3309:b0:5b1:ff38:5ee0 with SMTP id
 fd9-20020a056820330900b005b1ff385ee0mr5369117oob.1.1714993462132; Mon, 06 May
 2024 04:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SJ0PR11MB662464447DF707057BF43F97D9192@SJ0PR11MB6624.namprd11.prod.outlook.com>
 <2cd5a3d5-ed29-48c7-bb70-e660aff5c0d2@gmx.de>
In-Reply-To: <2cd5a3d5-ed29-48c7-bb70-e660aff5c0d2@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 May 2024 13:04:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iWtUs+JEjrwRme97CoK3W7P9odky3wdc5QkPecT8Ox_A@mail.gmail.com>
Message-ID: <CAJZ5v0iWtUs+JEjrwRme97CoK3W7P9odky3wdc5QkPecT8Ox_A@mail.gmail.com>
Subject: Re: 32-bit versus 64-bit ACPI tables
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Billie Alsup (balsup)" <balsup@cisco.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 6:25=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 01.01.70 um 01:00 schrieb :
>
> > My hardware comes with a DSDT with 32-bit tables, however I would like =
to add a
> > 64-bit table via SSDT.  Although, my SSDT compiles and loads successful=
ly, the
> > kernel truncates my 64-bit values because it apparently remembers that =
the DSDT
> > used 32-bit tables.  Is there a way to have a 64-bit SSDT, to augment a=
 32-bit DSDT?
> >
> > I don't quite understand the reason for truncating the SSDT values.  Th=
e original
> > code (from 2005!) warns that this is potentially a serious problem in t=
he ACPI
> > table(s) due to (possibly) buggy ASL compilers.  However, in my case, I=
 want
> > to explicitly have a 64-bit SSDT, and set the ComplianceRevision to 2 s=
pecifically
> > to support 64-bit integers.  But alas, they are still truncated due to =
a global
> > setting of
> >
> >                  acpi_gbl_integer_bit_width =3D 32;
> >                  acpi_gbl_integer_nybble_width =3D 8;
> >                  acpi_gbl_integer_byte_width =3D 4;
> >
> > versus having table specific settings.  Is there a workaround for this =
issue?
> >
> > It would be quite painful (both for me, and for customers) to get new f=
irmware
> > with a higher ComplianceRevision in the DSDT.  I wonder if there is an =
acceptable
> > alternative.  For example, is truncation really required still (are we =
still dealing with
> > buggy ASL compilers after 19 more years have elapsed?). Should there be=
 a
> > kernel command line parameter, or a kernel config option, to disable tr=
uncation?
> > Should these acpi_gbl_integer_* variables be table specific, rather tha=
n global?
> >
> > I would appreciate any insights or advice you can offer me. Thanks in a=
dvance!
> >
> > Some additional references:
> >
> > 1. truncation occurs in file drivers/acpi/acpica/exutils.c
> >      function acpi_ex_truncate_for32bit_table
> > 2. initial setting of the globals occurs in file drivers/acpi/utilities=
/utmisc.c
> >      function acpi_ut_set_integer_width
>
> Hi,
>
> the ACPI specification says that the integer length for _both_ DSDT and S=
SDT tables
> is controlled by the revision field of the DSDT, so your 32-bit DSDT prev=
ents your
> SSDT from using 64-bit integers.
>
> The only solution for this would be to not use 64-bit values inside your =
SSDT, is
> there a reason why you absolutely need 64-bit integers in your DSDT?

It's not just about the size of integers.

The size of integers was 4 bytes in ACPI 1.0 only, in ACPI 2.0 and
above integers are 64-bit.  If ACPI support in the platform is not
limited to ACPI 1.0, it must use 64-bit integers.

Thanks!

