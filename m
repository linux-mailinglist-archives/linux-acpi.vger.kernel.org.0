Return-Path: <linux-acpi+bounces-3983-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DBF869D2E
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 18:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6825F28EB09
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 17:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B020147A7D;
	Tue, 27 Feb 2024 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV2pyYPT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D82032D
	for <linux-acpi@vger.kernel.org>; Tue, 27 Feb 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053728; cv=none; b=Jhv7jincAVGBVd0ZDSqK4pUCNIywt7kDtOOeAu1Kd8EE5CFReJ1qJDWJOAHA8zsYad3RQRVhPBnclWM+e436ySSF1Viqp9MSr3BP3+VYOnUvUrx3pFrHmb7kZW9QJWPKfn+QL3Z20Q9hxvJmaNq9VPxD9CQ6tmU4UeXVM+nf3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053728; c=relaxed/simple;
	bh=e6OC0EIF2LxKtOIqckhwmsKoBmVzQpankJFNwGufQ5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnUol46fgtR3w3m6sPgqPfjhRUcG0XESdIiyHccSddekhD9ivOLOsAOH7zzwu4dnj+A+i1Efykn3rtF1sZMsMgd4qtXhT5laDi0lE0KlYMBA5jGCfRryYLnOtNc5oayO4cS59auKb+TKsE6GjGBiWESD5RnQDXZU9hACOTe5D+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MV2pyYPT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412acb93e2aso7236365e9.3
        for <linux-acpi@vger.kernel.org>; Tue, 27 Feb 2024 09:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709053725; x=1709658525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n6yshQ5kftOT4GsrqfYSSHdnqCbgVqbkBhqhnOUlik=;
        b=MV2pyYPTCbOMVfXS/UtNBaF80GGft1rd2PDS5q0TNqtH+q2DGyT/FCdcYABAHxf2MU
         c6OTVlMdA7R4VUderL7KScvKDYtUuYRRLikvg1cmajBSO1rFCrv+DnTePkxNyrqeQS/j
         r0DBxjj6tS2oypZ4bjfS6qfHESBnvg1AGpwcsjKhbRCutmXJmSyXVmXxpoChonQtfgYH
         Mb87nOQMiVbdhLv9lDh8xTd6T++sfA0GAU4hlXlyfTuNUDMADRHVSUBQk1cGXqRf7lhb
         HAiZY+JZNNNWST2klU+156sPoF2FgdNZjQyR3iPEPgA0MGmHbtn8UEDN04rqb02shRWF
         sBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709053725; x=1709658525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n6yshQ5kftOT4GsrqfYSSHdnqCbgVqbkBhqhnOUlik=;
        b=XP4IZU/6PAovX8dMWkviPwAEbWwQevFZwuUowwL0TASOjT7++EmO59iGwsuwmUAwrM
         7jrbt+A/tkpq47yh20JHVSvKBbfGZGR2T6pu745DZoX9SOG0t7FETK7cmmYldlZ+Bm/S
         WA9vU5Up5/MsUEdGw8sIvwCvooyUWgwD8gjzKpcEH9pd9e+y49oGaUKvE70BjYKEwJgT
         NANLVC4FPJH3ndslZx78XodwCVrnbSRWUJMGd+ZbYrIDUAtsObrKytAcwbboi2VTacir
         DiMs+5fXHDKJqq1bLFFII+u8BkUL8wwmxEoc56cqUvUy4TC6u6sYeM2yggkDsyUfAJlq
         HpWQ==
X-Gm-Message-State: AOJu0YyC35fR5Nu50koLglpnLK0lTuNrq+vCbsx+sWWdtp0n1UqDK7R3
	FtlAEhLH3Llhp6Uvey6N8/ajLCpvIVfaTgE441BWaAoZoMUuhi+u0AKb00cIBNVpynLxeEqnRMU
	jbNIi4RHsF6CjS9U8G6OntjeeDBPnuxG3RI8=
X-Google-Smtp-Source: AGHT+IFkl7r7AauueRF2fzdwlRUHtPap/vRkISDJNrIr7grBJkvjFkKljw1fNaHaitlIecOnOQLTFHCbJJxhV3pF6sE=
X-Received: by 2002:a05:600c:4f50:b0:412:abe9:af5c with SMTP id
 m16-20020a05600c4f5000b00412abe9af5cmr2068337wmq.7.1709053725089; Tue, 27 Feb
 2024 09:08:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAa5hjU-QV8LQtiNW5uuh_z1Gvge_q36LzmLqj7FiK7tT6JsOg@mail.gmail.com>
 <CAJZ5v0g4PtZCbNmyvn8OPy9K5tCGWqJkRkhbQUjzOz7puzaNwA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g4PtZCbNmyvn8OPy9K5tCGWqJkRkhbQUjzOz7puzaNwA@mail.gmail.com>
From: Maxim Kudinov <m.kudinovv@gmail.com>
Date: Tue, 27 Feb 2024 20:08:32 +0300
Message-ID: <CAAa5hjX-R7JOr7MM+6ayfmfFuHWBUzx2OuaD+kTMj-JTmw1KWA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

Yeah, sorry about the formatting, I didn't know that gmail breaks it,
so most people are using git-send-email. It was my first patch.

Maxim.

On Tue, Feb 27, 2024 at 7:53=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Feb 23, 2024 at 5:24=E2=80=AFPM Uldyk <m.kudinovv@gmail.com> wrot=
e:
> >
> > A known issue on some Zen laptops, keyboard stopped working due to comm=
it
> > 9946e39fe8d0 fael@kernel.org("ACPI: resource: skip IRQ override on AMD
> > Zen platforms")
> > on kernel 5.19.10.
> >
> > The ACPI IRQ override is required for this board due to buggy DSDT, thu=
s
> > adding the board vendor and name to irq1_edge_low_force_override fixes
> > the issue.
> >
> > Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen plat=
forms")
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217394
> > Link: https://lore.kernel.org/linux-acpi/20231006123304.32686-1-hdegoed=
e@redhat.com/
> > Tested-by: Maxim Trofimov <maxvereschagin@gmail.com>
> > Signed-off-by: Maxim Kudinov <m.kudinovv@gmail.com>
> > ---
> > If you need more info (dmesg, dmidecode), then please let me know.
> >
> > P.S. Sorry Rafael for sending it to you again, my email client was in
> > HTML mode, so
> > the email was rejected from the mailing list.
> > ---
> >  drivers/acpi/resource.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> > index dacad1d846c0..f681fd66d32b 100644
> > --- a/drivers/acpi/resource.c
> > +++ b/drivers/acpi/resource.c
> > @@ -588,6 +588,13 @@ static const struct dmi_system_id
> > irq1_edge_low_force_override[] =3D {
> >                         DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
> >                 },
> >         },
> > +       {
> > +               /* MAIBENBEN X577 */
> > +               .matches =3D {
> > +                       DMI_MATCH(DMI_SYS_VENDOR, "MAIBENBEN"),
> > +                       DMI_MATCH(DMI_BOARD_NAME, "X577"),
> > +               },
> > +       },
> >         { }
> >  };
> > --
>
> Applied as 6.9 material, but:
> (1) whitespace was all converted to spaces (please fix your email
> client or use a different one to send patches),
> (2) your S-o-b tag didn't match From:, so I used the name from the
> former  for the latter.
>
> Thanks!

