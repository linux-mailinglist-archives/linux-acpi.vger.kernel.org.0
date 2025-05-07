Return-Path: <linux-acpi+bounces-13595-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B37BAAE51F
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 17:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26564A8653
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7FE28B4E9;
	Wed,  7 May 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbYyiEs7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3728B4E2;
	Wed,  7 May 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632544; cv=none; b=bYDGwhLkl/LPJ42edBT4lpb4RrrlxLzf0/IwmZ+HJ/aJo9VEXdArSkTcvzDVGpRVrQGtITjlEoynVJSfENVuTdOm/G+09bEc46owEsRbXj0L/lKNuuKfT7bv0VlhbqhZzVEFfkG6sXO+Sm0EOLfRIZfp7jQub3r0ZbJyyfy8hgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632544; c=relaxed/simple;
	bh=X6a4mVmc9Gg+626jkP+iQ/neOLmh8i1nYRqm1zgMs0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZF5Gn7qHDBK7brLV+FGM/iUxDIuS2ivd8pC/1MYeAI8TEdpQL67rcOjQ6JpkGsYfBUXjyRus8tx0MrJulC5SzsLdOwmEHWIAo8AJd4aNM+o3mfCAshmj1I3jKbZJXlZ93p30JIjbJz6lgXu/iDXHybARrbCwLtb0GYLG6kRkJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbYyiEs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C510C4CEE9;
	Wed,  7 May 2025 15:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746632544;
	bh=X6a4mVmc9Gg+626jkP+iQ/neOLmh8i1nYRqm1zgMs0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RbYyiEs7wpnnw8imM6jb3u7SFlt3Hqn5B0wGfNcOEWLQnobDGeH8bQBUkTqXHu93l
	 AObLrQsBXwxcdg5/QsC8PWLbYslJENDskuMWVnZQAGaSNJpJBp7iSUACe70E08JCiC
	 kRSUmMhHeLS91T7IPrFEjbnChP+hNcblovKjh06VwoizzOxDCJzj0iqhxqovg5aRe+
	 ipT51pZVW9zcC3KReij0nOPiUd4JJYuQu3tj+lNxeZpjZvDd5KlaQs4D8W/q/e0LhD
	 KFt33SqPxIQ9Dx9+Na0rOPfv3nk7NS10V1kVfpMnvu5kbwrq7gdcFHImvOAzn3ha14
	 RW89QAqBGgOGw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2da3b3bb560so32216fac.3;
        Wed, 07 May 2025 08:42:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQg/JpnEJPymoV0DDbcrFTdF0hT7OnYILpNMDt0rAZzgSzwnawev/Cp8/7EzcCHH7q53oon5b5jlx2@vger.kernel.org, AJvYcCVfB2Q5KoBVo/C68O4nNRkc1jFGo6iSY8SKo+LH0YHbD4ohWIW5ZDyAhKTl84qCUeGTo7CkH/E4@vger.kernel.org, AJvYcCVyg+QR2VFNDgAcm5nsxRZKXlGWcX3D9kI387YjenUGdJfzyqEDhLY6Z3YoHe657bsLfBWYcVIosx04Hsvc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+0jYsv46X6J5ViQQ9M+zFSB9Obb20DFbmsor4PnLHMsiq1Lp
	Sv2qHZQwUmZstoiYmhH97ncq8fs4NsXg2W0jly9KOGFGUXgYCohMzSr6xMSA2Zcu/O6LN0GRNYo
	50Q5wXBhP4ZwV1ZaA7KlIdmmbrLk=
X-Google-Smtp-Source: AGHT+IF9g0bYO+YbMTdPoNSKVhb7oxdZ2SOFycPAHV8kmay8GgVyfTxxkuMDCK4QI6tlWeIbB4BlcK0/VaSa95NIsNo=
X-Received: by 2002:a05:6870:6109:b0:2c1:461f:309a with SMTP id
 586e51a60fabf-2db5bda3d4amr2310275fac.8.1746632543645; Wed, 07 May 2025
 08:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-draco-taped-15f475cd@mheyne-amazon> <214c2a2d-e0ea-4ec6-9925-05e39319e813@arm.com>
In-Reply-To: <214c2a2d-e0ea-4ec6-9925-05e39319e813@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 17:42:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jvWXDQQ++4wmWJ+i=jds+MZ68bRB9+26WM4tAPHFxALw@mail.gmail.com>
X-Gm-Features: ATxdqUFhaifr6kFHTAZ2IQkc_RdcvjRSQqknxvPrr1gBeUalvCjgLodiDGXZ-24
Message-ID: <CAJZ5v0jvWXDQQ++4wmWJ+i=jds+MZ68bRB9+26WM4tAPHFxALw@mail.gmail.com>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Heyne, Maximilian" <mheyne@amazon.de>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 5:25=E2=80=AFPM Jeremy Linton <jeremy.linton@arm.com=
> wrote:
>
> Hi,
>
> On 5/6/25 8:13 AM, Heyne, Maximilian wrote:
> > Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple of
> > sizeof() calls") corrects the processer entry size but unmasked a longe=
r
> > standing bug where the last entry in the structure can get skipped due
> > to an off-by-one mistake if the last entry ends exactly at the end of
> > the ACPI subtable.
> >
> > The error manifests for instance on EC2 Graviton Metal instances with
> >
> >    ACPI PPTT: PPTT table found, but unable to locate core 63 (63)
> >    [...]
> >    ACPI: SPE must be homogeneous
> >
> > Fixes: 2bd00bcd73e5 ("ACPI/PPTT: Add Processor Properties Topology Tabl=
e parsing")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> > ---
> >   drivers/acpi/pptt.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> > index f73ce6e13065d..4364da90902e5 100644
> > --- a/drivers/acpi/pptt.c
> > +++ b/drivers/acpi/pptt.c
> > @@ -231,7 +231,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_he=
ader *table_hdr,
> >                            sizeof(struct acpi_table_pptt));
> >       proc_sz =3D sizeof(struct acpi_pptt_processor);
>
> This isn't really right, it should be struct acpi_subtable_header, then
> once the header is safe, pull the length from it.
>
> But then, really if we are trying to fix the original bug that the table
> could be shorter than the data in it suggests, the struct
> acpi_pptt_processor length plus its resources needs to be checked once
> the subtype is known to be a processor node.
>
> Otherwise the original sizeof * change isn't really fixing anything.

Sorry, what sense did it make to do

proc_sz =3D sizeof(struct acpi_pptt_processor *);

here?  As much as proc_sz =3D 0 I suppose?

> >
> > -     while ((unsigned long)entry + proc_sz < table_end) {
> > +     while ((unsigned long)entry + proc_sz <=3D table_end) {
> >               cpu_node =3D (struct acpi_pptt_processor *)entry;
> >               if (entry->type =3D=3D ACPI_PPTT_TYPE_PROCESSOR &&

And this checks if the current entry is a CPU one and goes to the next
one otherwise, so it clearly looks for a CPU entry.

So the size check is logically correct now: It checks if there's
enough space in the table to hold a CPU entry that's being looked for.
The only problem with it is the assumption that the size of a CPU
entry must be greater than sizeof(struct acpi_pptt_processor).

Previously, it didn't make sense at all.

> >                   cpu_node->parent =3D=3D node_entry)
> > @@ -273,7 +273,7 @@ static struct acpi_pptt_processor *acpi_find_proces=
sor_node(struct acpi_table_he
> >       proc_sz =3D sizeof(struct acpi_pptt_processor);
> >
> >       /* find the processor structure associated with this cpuid */
> > -     while ((unsigned long)entry + proc_sz < table_end) {
> > +     while ((unsigned long)entry + proc_sz <=3D table_end) {
> >               cpu_node =3D (struct acpi_pptt_processor *)entry;
> >
> >               if (entry->length =3D=3D 0) {

