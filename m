Return-Path: <linux-acpi+bounces-20288-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 865E3D1E84C
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DC293061B39
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 11:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBB338A28A;
	Wed, 14 Jan 2026 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iixokxzT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CECA34A797
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390911; cv=none; b=i5v8h0PzUx2CDt3gPotHVi9c7oLfEFh78A4KrZAuKnTVm5K9gEzQyyTmYG1SDCQBX5A47TaHTSb2uQYeekH1SvKH1iVzCOCgc1ACiV4rZ5GGCWuarh6Gq7GgeCje3xCPHBncSRLpT8+jZhZA/fm6ZAr65LysCxa6KkClwhQxdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390911; c=relaxed/simple;
	bh=l5fX4CzKcwUwX0lvaTazUBtf0q/WLCN36Zvbsd6bXLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSL1KHjG0zHpfk3JBF6rQcaVJ34Np/FRdUs6E190GkgaFUqBqmakNbeZJhEp1L3Y87sRAGZ3yMiOHtT5Ha5Q6RDeFBiz9s5G1w+u51AEDoynouvdvSzcSfJFAkv0YnncJpnExsGxVwTuDXrXkPBAcw4Xy233ZwGsAriLJ5RBaGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iixokxzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6D5C16AAE
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 11:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768390911;
	bh=l5fX4CzKcwUwX0lvaTazUBtf0q/WLCN36Zvbsd6bXLI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iixokxzT9C5kw53DYkAQ2w84PR355khVsGAUfJZyACdpwGNnvxcW3jB2zpsPBufZ6
	 1oAwShTRvZ8rhspV4zo6PpjExqRjEAuEHYDzxZX7V1PJPUKTMuwwSfaq6JNosE1gO2
	 EEXmrMxdMUMi2YTuIGfWzfKrj3OJdtI3pMw4ZtJbX5aag98Z1Fx11tGW4VBWvYR5D3
	 ws3BZ8EIzvYTo+f37Ko16RdGQ6r6oNQR0QlR/hl/s3UtL2190P1oLTteJldsfB/yLU
	 MFKtinVslJOQcLdM4NfG5tzpfY/M9h7eC2d3ExjeqGH5NtJWp9Gyz1oYCKG2nRnury
	 wNWYdx0qjShRA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45c7f550f46so51527b6e.3
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 03:41:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXgV1sXlKjlBUPCrQFM8mA8cBqHgUgSRgkAJUCe2MTyeCp6yjhHFh8fqaCUxTfoo8zgFSRwKB9jXKo@vger.kernel.org
X-Gm-Message-State: AOJu0YzK3G3SuGrepZq/r6arLhM/8fOenVxJi+ObFJ+IQWxoW9BHCEGs
	O49d4M2/yhjCQm4O4IP3LwoHHT6PyAY9862x2I6fc91DJilifGFvuVwVIgYGopFVNGGEn51P5Oq
	ZuK3j7Ebx7Yif2rjvpByE2ZsHJRmhAWE=
X-Received: by 2002:a05:6808:4f4b:b0:44d:ba5b:ad34 with SMTP id
 5614622812f47-45c715efae2mr1363379b6e.65.1768390910531; Wed, 14 Jan 2026
 03:41:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <aWUpQ04uNcXtp0wR@bogus> <CAJZ5v0gXMAFRCH8sn7OSb8Dc8XCf0wgi-CGre8i76KXAZ8tc-Q@mail.gmail.com>
 <aWdKLClEHQ1cg34-@U-2FWC9VHC-2323.local>
In-Reply-To: <aWdKLClEHQ1cg34-@U-2FWC9VHC-2323.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jan 2026 12:41:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ggYTPnYVMGy1uWGCPQNOu=xGFDxm=qf2G05hvZ999s_g@mail.gmail.com>
X-Gm-Features: AZwV_QhRwMI6r0phU--mMTYLr_Qu9emoB8cqSSkCwkLyBRW98SKVicmunxEYg9M
Message-ID: <CAJZ5v0ggYTPnYVMGy1uWGCPQNOu=xGFDxm=qf2G05hvZ999s_g@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>, 
	Jeremy Linton <jeremy.linton@arm.com>, Hanjun Guo <guohanjun@huawei.com>, 
	James Morse <james.morse@arm.com>, Joanthan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 8:48=E2=80=AFAM Feng Tang <feng.tang@linux.alibaba.=
com> wrote:
>
> Hi Rafael,
>
> Thanks for the review!
>
> On Tue, Jan 13, 2026 at 05:21:07PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Jan 12, 2026 at 6:03=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.=
com> wrote:
> > >
> > > On Wed, Dec 31, 2025 at 06:49:09PM +0800, Feng Tang wrote:
> > > > There was warning message about PPTT table:
> > > >
> > > >       "ACPI PPTT: PPTT table found, but unable to locate core 1 (1)=
",
> > > >
> > > > and it in turn caused scheduler warnings when building up the syste=
m.
> > > > It took a while to root cause the problem be related a broken PPTT
> > > > table which has wrong cache information.
> > > >
> > > > To speedup debugging similar issues, dump the PPTT table, which mak=
es
> > > > the warning more noticeable and helps bug hunting.
> > > >
> > > > The dumped info format on a ARM server is like:
> > > >
> > > >     ACPI PPTT: Processors:
> > > >     P[  0][0x0024]: parent=3D0x0000 acpi_proc_id=3D  0 num_res=3D1 =
flags=3D0x11(package)
> > > >     P[  1][0x005a]: parent=3D0x0024 acpi_proc_id=3D  0 num_res=3D1 =
flags=3D0x12()
> > > >     P[  2][0x008a]: parent=3D0x005a acpi_proc_id=3D  0 num_res=3D3 =
flags=3D0x1a(leaf)
> > > >     P[  3][0x00f2]: parent=3D0x005a acpi_proc_id=3D  1 num_res=3D3 =
flags=3D0x1a(leaf)
> > > >     P[  4][0x015a]: parent=3D0x005a acpi_proc_id=3D  2 num_res=3D3 =
flags=3D0x1a(leaf)
> > > >     ...
> > > >     ACPI PPTT: Caches:
> > > >     C[   0][0x0072]: flags=3D0x7f next_level=3D0x0000 size=3D0x4000=
000  sets=3D65536  way=3D16 attribute=3D0xa  line_size=3D64
> > > >     C[   1][0x00aa]: flags=3D0x7f next_level=3D0x00da size=3D0x1000=
0    sets=3D256    way=3D4  attribute=3D0x4  line_size=3D64
> > > >     C[   2][0x00c2]: flags=3D0x7f next_level=3D0x00da size=3D0x1000=
0    sets=3D256    way=3D4  attribute=3D0x2  line_size=3D64
> > > >     C[   3][0x00da]: flags=3D0x7f next_level=3D0x0000 size=3D0x1000=
00   sets=3D2048   way=3D8  attribute=3D0xa  line_size=3D64
> > > >     ...
> > > >
> > > > It provides a global and straightforward view of the hierarchy of t=
he
> > > > processor and caches info of the platform, and from the offset info
> > > > (the 3rd column), the child-parent relation could be checked.
> > > >
> > > > With this, the root cause of the original issue was pretty obvious,
> > > > that there were some caches items missing which caused the issue wh=
en
> > > > building up scheduler domain.
> > > >
> > >
> > > While this may sound like a good idea, it deviates from how errors in=
 other
> > > table-parsing code are handled. Instead of dumping the entire table, =
it would
> > > be preferable to report the specific issue encountered during parsing=
.
> > >
> > > I do not have a strong objection if Rafael is comfortable with this a=
pproach;
> >
> > I'm not a big fan of it TBH.
> >
> > > however, it does differ from the established pattern used by similar =
code.
> > > Dumping the entire table in a custom manner is not the standard way o=
f
> > > handling parsing errors. Just my opinion.
> >
> > I agree.
>
> I understand the concern of this could be kind of special, Hanjun and Sud=
eep
> have the same feeling.
>
> The reason for the patch is:
> * The apcidump tool follow the standard general format to dump each item,
>   without grouping them according to type, the number of lines of acpidum=
p
>   is about 20X more than this, making it harder to parse

But you can develop a PPTT parser.

All ACPI tables are exposed verbatim via /sys/firmware/acpi/tables/.

> * In rare cases like for silicon enabling, sometimes the kernel can fail
>   early where the user space checking is not available. If HW debugger is
>   not available either, the kernel dumping is the only way to debug.

But I don't think you need to dump the entire table in those cases.

> Does the proposal of putting it under a kernel config look doable to you?

That would mean extra code that's almost never used and needs to be
taken into account when making changes that may affect it.  Thanks,
but no thanks.

