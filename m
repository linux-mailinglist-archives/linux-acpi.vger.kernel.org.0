Return-Path: <linux-acpi+bounces-13093-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83333A91EB1
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 15:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E549F8A10F9
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E824EA91;
	Thu, 17 Apr 2025 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s52LAt+U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE5024E4B1
	for <linux-acpi@vger.kernel.org>; Thu, 17 Apr 2025 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897894; cv=none; b=fgU3K2GR4Istwm/ASetD+nLHBQOtx9isGqaPIjluzFC0DirhX2n81u5baO6RGH2GiYfU8AhcSjcE6zWCTh5qyKD7engmLx/1mSQi/4kPhF/YxH/88Oj9UB9CpfaHlA+yvZnqkRN5OaRl8aWQp5Iih5/iquShNFDbCKJhWXVtcRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897894; c=relaxed/simple;
	bh=dBELqwP/B84rSdr4uZ1+xXM/R+yGPB+mJ4sEF/BlDd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xrs+D4B1P/H1k2XZikRSY5EAkBWGF+PjcNBoK44tgZGGiLZpolc160VFn6zVS/BRZ04bT94/45Wd/EEdHsLKitIb0OGJiy4u1oN5tYvZiUbunXyBz/en0wX7KamILiVuRZJpFSOHgn5vvW6TbOJlb8jUjPKNJgxf4Ji4uFZH7kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s52LAt+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10693C4CEED
	for <linux-acpi@vger.kernel.org>; Thu, 17 Apr 2025 13:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744897894;
	bh=dBELqwP/B84rSdr4uZ1+xXM/R+yGPB+mJ4sEF/BlDd0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s52LAt+UnuREjaMo4Vh+9LiEuzTmyD+kzdWW2iqkKmKdepTkAa2p4P6IkcvrzH7Md
	 JttEkHyFCUXDdpimSj+oJpAGgmvsensdV/MJZFWOunvaH5B7dBNZh99OSmE6zJ3Xj9
	 r1r8E8t35QQkbc6o0ayVRbAAi4uvz17luEcH20Ki2B2nXmvSIQVHLoDs9Rmqc9OPsK
	 su4axMckkbT409IMXKc+U4EuikK9BUpAtFlBE6Urpacn11kQGCr3vokAla9aSH0nHF
	 rUcv3yQDexq7PafqOTlrJXq0/q6emA/t6fweAOR+KqdCUJfjqq9UoW46js+cRYwESo
	 dm0/hLHM//ttQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-601ad30bc0cso1131605eaf.0
        for <linux-acpi@vger.kernel.org>; Thu, 17 Apr 2025 06:51:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGQzW7QnufY5M+HTkeNy0gxtX4omcn7ndf8TAoLceOQOVQOh17Uxe8YHJGX4pNrqIwzjW6XUqKcqmE@vger.kernel.org
X-Gm-Message-State: AOJu0YydUh0JR6ipgM5RVGS+f5uSGirrdV7MCxB+L4NVIRtdrWb/7vpY
	cdYJObV7ELCOQ6KKFxprkjvxQjmkrPNjK7iihx8KCxO+NcVd0IFja1cAZqzM6uvNrqngDfa2aix
	OhcvDwrtpg70Od6BCI2yz+l7Y3tE=
X-Google-Smtp-Source: AGHT+IH9YbcGc9ZabzYy6wcIGvg2AfWrm5Cjtyr6+kdeisZm1DHv+HX5WAQ7Cc92jibO5QqXw9xvhotc/ggiJmXcv8o=
X-Received: by 2002:a05:6870:af97:b0:2b8:8d81:4658 with SMTP id
 586e51a60fabf-2d4f1f6d3e3mr1415728fac.2.1744897893419; Thu, 17 Apr 2025
 06:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417031040.514460-1-superm1@kernel.org> <CAJZ5v0iQMOY1NhpE9Hy0jD6iKQeFbdxB4ZWj5KZcsbApwZ_RhQ@mail.gmail.com>
 <90fcc29b-be8e-44b3-b6bb-a1ef06096520@kernel.org> <CAJZ5v0jRLRdcvTGELZswnNuQKQx_RuKvDAL776Qv49bP7vxKrQ@mail.gmail.com>
 <d00430dd-000f-4805-ab5d-d04affffa833@kernel.org>
In-Reply-To: <d00430dd-000f-4805-ab5d-d04affffa833@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Apr 2025 15:51:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iod_R7gSt8ppEtrkP59w6trRjpg=ZGc1hZr+sFuYELVg@mail.gmail.com>
X-Gm-Features: ATxdqUFsjesdlILm_Ap77EcHpQIljfCBFv093xmLypS-cPkWv_Bs0DUDp2SsUBM
Message-ID: <CAJZ5v0iod_R7gSt8ppEtrkP59w6trRjpg=ZGc1hZr+sFuYELVg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPICA: Add support for printing AML arguments when
 trace point enabled
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mario.limonciello@amd.com, robert.moore@intel.com, 
	rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 2:59=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 4/17/2025 7:46 AM, Rafael J. Wysocki wrote:
> > On Thu, Apr 17, 2025 at 2:03=E2=80=AFPM Mario Limonciello <superm1@kern=
el.org> wrote:
> >>
> >>
> >>
> >> On 4/17/25 06:19, Rafael J. Wysocki wrote:
> >>> On Thu, Apr 17, 2025 at 5:10=E2=80=AFAM Mario Limonciello <superm1@ke=
rnel.org> wrote:
> >>>>
> >>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>
> >>>> When debug level is set to `ACPI_LV_TRACE_POINT` method start and
> >>>> exit are emitted into the debug logs. This can be useful to understa=
nd
> >>>> call paths, however none of the arguments for the method calls are
> >>>> populated even when turning up other debug levels.
> >>>>
> >>>> This can be useful for BIOSes that contain debug strings to see thos=
e
> >>>> strings. When `ACPI_LV_TRACE_POINT` is set also output all of the ar=
guments
> >>>> for a given method call.
> >>>>
> >>>> This enables this type of debugging:
> >>>>
> >>>> ```
> >>>> extrace-0138 ex_trace_point        : Method Begin [0x0000000096b240c=
4:\M460] execution.
> >>>> extrace-0173 ex_trace_args         :  "  POST CODE: %X  ACPI TIMER: =
%X  TIME: %d.%d ms\n", b0003f53, 1a26a8b2, 0, 15e, 0, 0
> >>>> extrace-0138 ex_trace_point        : Method End [0x0000000096b240c4:=
\M460] execution.
> >>>> ```
> >>>>
> >>>> Link: https://github.com/acpica/acpica/commit/08219d91b5678ae2fae6e4=
f208df790a4e108c1c
> >>>
> >>> The link doesn't work.
> >>
> >> Are you sure?
> >>
> >> I just tried again and it worked for me.
> >
> > Yeah, it works now, I had to sign in to github.
> >
> > But it is a link to a commit and I need a link to a PR.  I think it's t=
his one:
> >
> > https://github.com/acpica/acpica/pull/1012
>
> Yes that's the right PR that led to the commit.  Can you swap it out?

Yes, I can.

> Or would you like me to resubmit with it adjusted?

No need.

Thanks!

