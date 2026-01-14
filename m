Return-Path: <linux-acpi+bounces-20287-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18778D1E7BC
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EA543173157
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C14396B81;
	Wed, 14 Jan 2026 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xuh50tdr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4A396B6F
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390630; cv=none; b=DOLfwIRweQWUYorVz8NfqOPszQB4ZuwAPrQAYAko5rTg6FsT4BBMJTF0plt41U2Y3n4G7gc4BvgkzgCvwcRTDQ8QIvK54TRViQfqTO8t9JPwd9XQZaQADusMA8YzHkpZPRNPpX8mRLiyWRKvoWAtLFbkkl7efMbzhD5+SH1P+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390630; c=relaxed/simple;
	bh=dVW6lo0EBZknOGNhVMV8h8yVyVoP7vOnHqJ4CeCBmfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IE5RrADJWJZzGY6iHi9NuCQr+40J+imH44usYAN6/BDubN8YMkZE/34mw4IQIaemEnXmhh1qEFJpeJs82lE3hxW1U2+pG1o/tvTcyO2+E8u0g8RQ4c/U/A30BaNpPQPbfZD04dIpwZ821G4UCTxGWzLyl/KKXL2KbO6XtoV0QC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xuh50tdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69871C4CEF7
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768390630;
	bh=dVW6lo0EBZknOGNhVMV8h8yVyVoP7vOnHqJ4CeCBmfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xuh50tdr+NxGclVFIVskaqw0DfIBqv56u9hnLu/SDJt75kkCqw5+uoSsC3RAFDtm1
	 6yYE7s+2mU0Z7PY1TYhlqgrw94UZZIrDYK3qxj80SXIkwB8W/tCDjkR54t39lVFD4+
	 95dIT/O5KDi5sQhkW1iOi+XYLhbMsBRAfq8gS5dNR8JqkX5u5NX93SBmSDDZsGhi8i
	 ZU1a7Jub6Uz4dE3ZCTqy3mrnQm2uGQUcvNcPm08QdAjyY8iVgkZlrdLeKY6BPCwndB
	 FPHUtIwbM8X9rn8bTOtpO4MFSzc7fm87UC8kfSsnx9ppnsj7mMe3PAXRDxFNzzr/h9
	 /S5aEOIncb5kA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-459a516592eso5645182b6e.1
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 03:37:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDEkEEvxgbOTkrLHUYzad6xgiOk23BlHniyPwhqsm5E7Xahbm/5kHpbqXPpudit3dHH6cnaJdg3mDW@vger.kernel.org
X-Gm-Message-State: AOJu0YxnseTW7O+dZoLnB7Rvp4jvHekiWndT+SX91MoHIhEwTRqwcyhZ
	hN+zG+f6GN8IYnvLg8D/+PbaP2PewTBI3QN6DogSOYDHCJctouUZBs1EdrG89oHTp1nMx9Mzwnu
	OeS55l2PTCcvJiCxN5HBF/V9iQzpYQPc=
X-Received: by 2002:a05:6808:14ce:b0:450:3c49:519 with SMTP id
 5614622812f47-45c71462c8fmr1776449b6e.7.1768390629508; Wed, 14 Jan 2026
 03:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <aWUpQ04uNcXtp0wR@bogus> <aWYBef5ZUNKVpg1W@U-2FWC9VHC-2323.local>
 <aWZZeD496CPi20Gc@bogus> <aWdAiaC10ear9ajR@U-2FWC9VHC-2323.local>
In-Reply-To: <aWdAiaC10ear9ajR@U-2FWC9VHC-2323.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jan 2026 12:36:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h-hjrE85_=6YOJ6oRRZ4=SmKWrs7hCKnrP6_KZTuDePw@mail.gmail.com>
X-Gm-Features: AZwV_Qhbt2BYUoHzGKxVpxeKEl_yH0iEt1PUqmHhZhgSxbVUdzThmowCiQDV8_o
Message-ID: <CAJZ5v0h-hjrE85_=6YOJ6oRRZ4=SmKWrs7hCKnrP6_KZTuDePw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Jeremy Linton <jeremy.linton@arm.com>, Hanjun Guo <guohanjun@huawei.com>, 
	James Morse <james.morse@arm.com>, Joanthan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 8:07=E2=80=AFAM Feng Tang <feng.tang@linux.alibaba.=
com> wrote:
>
> Hi Sudeep,
>
> On Tue, Jan 13, 2026 at 02:40:56PM +0000, Sudeep Holla wrote:
> [...]
> > > > >
> > > > > With this, the root cause of the original issue was pretty obviou=
s,
> > > > > that there were some caches items missing which caused the issue =
when
> > > > > building up scheduler domain.
> > > > >
> > > >
> > > > While this may sound like a good idea, it deviates from how errors =
in other
> > > > table-parsing code are handled. Instead of dumping the entire table=
, it would
> > > > be preferable to report the specific issue encountered during parsi=
ng.
> > > >
> > > > I do not have a strong objection if Rafael is comfortable with this=
 approach;
> > > > however, it does differ from the established pattern used by simila=
r code.
> > > > Dumping the entire table in a custom manner is not the standard way=
 of
> > > > handling parsing errors. Just my opinion.
> > >
> > > Yes, it's a fair point about the error handling. Actually for the iss=
ue
> > > we met, the PPTT table complies with ACPI spec and PPTT table spec ni=
cely,
> > > that it has no checksum or format issue, the only problem is some ite=
ms
> > > are missing.
> > >
> >
> > Agreed, but how is this any different from other tables that contain op=
tional
> > entries the ASL compiler cannot detect?
> >
> > > So I would say the dump itself doesn't break any existing ACPI table =
error
> > > handling, or change anything. As Hanjun suggested, it could be put un=
der a
> > > CONFIG_ACPI_PPTT_ERR_DUMP option as a PPTT specific debug method, and=
 not
> > > related to general ACPI table error handling.
> > >
> >
> > Sure, that could be an option as long as CONFIG_ACPI_PPTT_ERR_DUMP is d=
efault
> > off and are enabled only when debugging and not always like in distro i=
mages.
> > Does that work for you ?
>
> Yes. It sounds great to me.
>
> > > We have had this in our tree for a while, and the good part is it giv=
es a
> > > direct overview of all the processors and caches in system, you get t=
o
> > > know the rough number of them from the index, and items are listed si=
de
> > > by side so that some minor error could be very obvious in this compar=
ing
> > > mode.
> > >
> >
> > Agreed, but all this info are available to userspace in some form alrea=
dy.
> > What does this dump give other than debugging a broken PPTT ?
>
> It is mainly for debugging issues. Though we locally has option to dump i=
t
> on boot unconditionally to help kernel/BIOS devleoper to have a quick
> overview of the PPTT table, as the table gets updated from time to time,
> or sometime the kernel could fail before booting to user space.

The kernel message buffer is not a great place for dumping ACPI tables thou=
gh.

If an invalid PPTT prevents the system from booting, print out enough
information to identify the cause of the failure.

For everything else, use the tools in user space.

