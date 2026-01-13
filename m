Return-Path: <linux-acpi+bounces-20239-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D06D1A305
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 17:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49312300287A
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2322ECD1D;
	Tue, 13 Jan 2026 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD/GBQRa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE72EA147
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321279; cv=none; b=qipow8bE4nd+hnghUQraQUwer4zCwTaSCdp4rNdaxNjkRbosPZyr3KuRGRqtM8sP8V/agL8/FEsWqnuvx9t+gfI4xIkih4poZQwQH0qtn+1/Dh7U64zMBjsXJ3XTTMeeS9gyN36BJieaJ71JNSExpg6m6oJK5ZWzOGiDZBnOwvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321279; c=relaxed/simple;
	bh=D8Og+TnqxWTARrxXIhMaCnl8G/jCeh7dT5FUokkKgKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f21HUo8lLLdGxVfODtG3mwF6acMG08ac22QzZ8sQmx1g1Y7+SMMTO9knPx19cXkhUzbOnK1aS1Ia5BWRonmFzMmmjnxMRcQcSx3T9tjfB9JoFVpA64d5cJgXSW7MU0GczuuA9ILkNG9+ObrIlnrcLXJt0WtItWnrvdgiG9Epwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KD/GBQRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C78AC2BC86
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 16:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768321279;
	bh=D8Og+TnqxWTARrxXIhMaCnl8G/jCeh7dT5FUokkKgKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KD/GBQRafnqR67qiez37Yk2q4I8b9ruD6D8bhkGgjNB9oKEiqskh6v5fMDtlS5SIZ
	 +lYGhZ+CpYfq/JviG/IcT2nkKv3R+1TDtRMrDqyOZfeonrRPAtNEbQrb5yj96R1ooQ
	 ty52s2CmTiHBRFI6QGSZSWGXIjAsA71QEuBYvGsDOcMN5swxmh8NPInxSgpI+N9JWn
	 rWEBlN2eJZxblg+4nqceW6MechuIvd/86ApODS5pY0rpjayPhgkfP0eF+Ipx0Yb51y
	 +lvY6NAvmdKb6ol4AK10OSkgugc6yVbmQ2IYqZK7F/8fRqbEoxcYEAHmIybvK/DDUr
	 zASBP2b2SNnig==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c76d855ddbso2537880a34.3
        for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 08:21:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjSYrq9fGOAcMQxCiDruZlbIw94bdZqpRCpH4e4Bbrg12VMXCaEgdxRTZsHMt8ULO7nD4kVp7/Wg52@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvyICkh0PwhPODfy58EnhncgmOEK87wb0zTTZDJaJ8PQfc4Gd
	BafhEpiPYBNG0Mlua7AE4LgsVV32Ud0ccIMXWI247xIZFb6ypKppzLUoesmFn0KPWPk2fyV4V6M
	39GBCKDIEcbO9PzqJIQFMvaQ1vOv7Fsw=
X-Google-Smtp-Source: AGHT+IFRWKJGnCA715gcajWCIlYonkszNpc3ayEtzV2C4Lt3AILnB1bTvuzzQK82HN6KvKBOt9hXOx1Z3mj9VkHRE7g=
X-Received: by 2002:a4a:dc47:0:b0:65f:2baf:4ad with SMTP id
 006d021491bc7-65f54ef5eebmr7236592eaf.30.1768321278346; Tue, 13 Jan 2026
 08:21:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com> <aWUpQ04uNcXtp0wR@bogus>
In-Reply-To: <aWUpQ04uNcXtp0wR@bogus>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Jan 2026 17:21:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gXMAFRCH8sn7OSb8Dc8XCf0wgi-CGre8i76KXAZ8tc-Q@mail.gmail.com>
X-Gm-Features: AZwV_Qj3DG4eR3nH1g7Lggz9AsecgA1MyKWTqyQIRjdIUzS2Ijreo5GhIKB2-PI
Message-ID: <CAJZ5v0gXMAFRCH8sn7OSb8Dc8XCf0wgi-CGre8i76KXAZ8tc-Q@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, 
	Hanjun Guo <guohanjun@huawei.com>, James Morse <james.morse@arm.com>, 
	Joanthan Cameron <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 6:03=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Wed, Dec 31, 2025 at 06:49:09PM +0800, Feng Tang wrote:
> > There was warning message about PPTT table:
> >
> >       "ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> >
> > and it in turn caused scheduler warnings when building up the system.
> > It took a while to root cause the problem be related a broken PPTT
> > table which has wrong cache information.
> >
> > To speedup debugging similar issues, dump the PPTT table, which makes
> > the warning more noticeable and helps bug hunting.
> >
> > The dumped info format on a ARM server is like:
> >
> >     ACPI PPTT: Processors:
> >     P[  0][0x0024]: parent=3D0x0000 acpi_proc_id=3D  0 num_res=3D1 flag=
s=3D0x11(package)
> >     P[  1][0x005a]: parent=3D0x0024 acpi_proc_id=3D  0 num_res=3D1 flag=
s=3D0x12()
> >     P[  2][0x008a]: parent=3D0x005a acpi_proc_id=3D  0 num_res=3D3 flag=
s=3D0x1a(leaf)
> >     P[  3][0x00f2]: parent=3D0x005a acpi_proc_id=3D  1 num_res=3D3 flag=
s=3D0x1a(leaf)
> >     P[  4][0x015a]: parent=3D0x005a acpi_proc_id=3D  2 num_res=3D3 flag=
s=3D0x1a(leaf)
> >     ...
> >     ACPI PPTT: Caches:
> >     C[   0][0x0072]: flags=3D0x7f next_level=3D0x0000 size=3D0x4000000 =
 sets=3D65536  way=3D16 attribute=3D0xa  line_size=3D64
> >     C[   1][0x00aa]: flags=3D0x7f next_level=3D0x00da size=3D0x10000   =
 sets=3D256    way=3D4  attribute=3D0x4  line_size=3D64
> >     C[   2][0x00c2]: flags=3D0x7f next_level=3D0x00da size=3D0x10000   =
 sets=3D256    way=3D4  attribute=3D0x2  line_size=3D64
> >     C[   3][0x00da]: flags=3D0x7f next_level=3D0x0000 size=3D0x100000  =
 sets=3D2048   way=3D8  attribute=3D0xa  line_size=3D64
> >     ...
> >
> > It provides a global and straightforward view of the hierarchy of the
> > processor and caches info of the platform, and from the offset info
> > (the 3rd column), the child-parent relation could be checked.
> >
> > With this, the root cause of the original issue was pretty obvious,
> > that there were some caches items missing which caused the issue when
> > building up scheduler domain.
> >
>
> While this may sound like a good idea, it deviates from how errors in oth=
er
> table-parsing code are handled. Instead of dumping the entire table, it w=
ould
> be preferable to report the specific issue encountered during parsing.
>
> I do not have a strong objection if Rafael is comfortable with this appro=
ach;

I'm not a big fan of it TBH.

> however, it does differ from the established pattern used by similar code=
.
> Dumping the entire table in a custom manner is not the standard way of
> handling parsing errors. Just my opinion.

I agree.

