Return-Path: <linux-acpi+bounces-13242-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74106A9B8BE
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Apr 2025 22:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB741B6865B
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Apr 2025 20:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376081F1927;
	Thu, 24 Apr 2025 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxmiO6ps"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122071891AA
	for <linux-acpi@vger.kernel.org>; Thu, 24 Apr 2025 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525050; cv=none; b=d0F7SgG4itRdC6vheJMPNEiUAwOZfrhgPgXG1hR2F1teYvpJBIwjmUNawhnM8o+FjqY4paKlXKMzBTlHxbu7/zwkeejMrqLz1C///+lqQ4Hb4AbeHdG36BmvRjKErPURplr6Rk6Ju23NpMe8EDmZVcvTQWO7OY45hXRwY/wkOuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525050; c=relaxed/simple;
	bh=KkxKNu+7sYjEvW2eUqgTl7hxYpjjmGiMFnVC7NvxbIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqaKUqAs0qWCRNeF7lto1B4Qaz1l3OUN/MGdap4TRIRzH1vokZjvjiSAjlGBAjVynT3WcGAtz/5PcH2aE1frSOO4KEhCJ8UoJzmdppb2oRIBxSwU9vs0qI4YsJ9HhkQEDVXyjthHMjTgrFNbLhx+oOzXyxSrj36kuSGRrN5oFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxmiO6ps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A274C4CEED
	for <linux-acpi@vger.kernel.org>; Thu, 24 Apr 2025 20:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745525049;
	bh=KkxKNu+7sYjEvW2eUqgTl7hxYpjjmGiMFnVC7NvxbIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YxmiO6psIt+uOX1V/ERh5+bjozKvEbTD/LDAmY5USFU1AJ/IsWw6qnmmfaC2vQ9hV
	 GVUDA9wpgc0zKVz9vNy1Mv1srEBq3iVT/+UDmsbsv33uLqchzFidrwsJ8BEkxhLnw1
	 qAYTF9/SYa01xEf1ZQEBS4EhH1kScjwfQR6XqNVM4J6xVGoLkiv1ONuFQ7noOwf0Ih
	 Rjt4yOWhr8elcFTzLD5q59i621nja/vmWsSoY9LX74rwLGBH4EVaPW+ctkPWdwWFJf
	 9YPyyY0ubihfmiUERVQdATAdFMUIFN3fP8/L+n8u1Vu9lJvQR5w7t72VtOTPpr5X/Q
	 iP2bgJdjdQMgg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2d0920ce388so727316fac.0
        for <linux-acpi@vger.kernel.org>; Thu, 24 Apr 2025 13:04:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxQfChbsQUGlLhe3+I9bcqfFGoVCHlhIU+7FYfvFZT7QRBKxviglauGZEjM97y/VtUXgvKifsO11mX@vger.kernel.org
X-Gm-Message-State: AOJu0YyS2pSx+GvKQEC5tnzL0Yz/zV7+9fBXKHFF7jOamDnmny6YUZRf
	fG4zhuVlVtL/3YRnMuViU/SOp/662xUP41THVAiJ0hS8G58f4t9ORNV6Ped6HY93lyLa96Roy0G
	SYA+8UL7nAaHEuvvzOmNi0ELsEcU=
X-Google-Smtp-Source: AGHT+IGA3cFIyxUaOUIh8097AbbxY4ZEq161C8YsJAHuQN2iFbHrk133ky3OUDGk7/YzotAcJDSuNHiqKO6HfRyDn0g=
X-Received: by 2002:a05:6870:9121:b0:2d4:d07c:7cc5 with SMTP id
 586e51a60fabf-2d96e29c4bemr2058793fac.12.1745525048837; Thu, 24 Apr 2025
 13:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417031040.514460-1-superm1@kernel.org> <CAJZ5v0iQMOY1NhpE9Hy0jD6iKQeFbdxB4ZWj5KZcsbApwZ_RhQ@mail.gmail.com>
 <90fcc29b-be8e-44b3-b6bb-a1ef06096520@kernel.org> <CAJZ5v0jRLRdcvTGELZswnNuQKQx_RuKvDAL776Qv49bP7vxKrQ@mail.gmail.com>
 <d00430dd-000f-4805-ab5d-d04affffa833@kernel.org> <CAJZ5v0iod_R7gSt8ppEtrkP59w6trRjpg=ZGc1hZr+sFuYELVg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iod_R7gSt8ppEtrkP59w6trRjpg=ZGc1hZr+sFuYELVg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Apr 2025 22:03:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gCVFNLOHSpiF_6SrNAdu-6S0HHnpp6+TeqW9qN70Afrw@mail.gmail.com>
X-Gm-Features: ATxdqUH_i0I8SJTmXO1agHsNuOXHT0dOVi9K9KQN6X0Es40QkVFwO7T6c5WimFQ
Message-ID: <CAJZ5v0gCVFNLOHSpiF_6SrNAdu-6S0HHnpp6+TeqW9qN70Afrw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPICA: Add support for printing AML arguments when
 trace point enabled
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, robert.moore@intel.com, 
	rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 3:51=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Apr 17, 2025 at 2:59=E2=80=AFPM Mario Limonciello <superm1@kernel=
.org> wrote:
> >
> > On 4/17/2025 7:46 AM, Rafael J. Wysocki wrote:
> > > On Thu, Apr 17, 2025 at 2:03=E2=80=AFPM Mario Limonciello <superm1@ke=
rnel.org> wrote:
> > >>
> > >>
> > >>
> > >> On 4/17/25 06:19, Rafael J. Wysocki wrote:
> > >>> On Thu, Apr 17, 2025 at 5:10=E2=80=AFAM Mario Limonciello <superm1@=
kernel.org> wrote:
> > >>>>
> > >>>> From: Mario Limonciello <mario.limonciello@amd.com>
> > >>>>
> > >>>> When debug level is set to `ACPI_LV_TRACE_POINT` method start and
> > >>>> exit are emitted into the debug logs. This can be useful to unders=
tand
> > >>>> call paths, however none of the arguments for the method calls are
> > >>>> populated even when turning up other debug levels.
> > >>>>
> > >>>> This can be useful for BIOSes that contain debug strings to see th=
ose
> > >>>> strings. When `ACPI_LV_TRACE_POINT` is set also output all of the =
arguments
> > >>>> for a given method call.
> > >>>>
> > >>>> This enables this type of debugging:
> > >>>>
> > >>>> ```
> > >>>> extrace-0138 ex_trace_point        : Method Begin [0x0000000096b24=
0c4:\M460] execution.
> > >>>> extrace-0173 ex_trace_args         :  "  POST CODE: %X  ACPI TIMER=
: %X  TIME: %d.%d ms\n", b0003f53, 1a26a8b2, 0, 15e, 0, 0
> > >>>> extrace-0138 ex_trace_point        : Method End [0x0000000096b240c=
4:\M460] execution.
> > >>>> ```
> > >>>>
> > >>>> Link: https://github.com/acpica/acpica/commit/08219d91b5678ae2fae6=
e4f208df790a4e108c1c
> > >>>
> > >>> The link doesn't work.
> > >>
> > >> Are you sure?
> > >>
> > >> I just tried again and it worked for me.
> > >
> > > Yeah, it works now, I had to sign in to github.
> > >
> > > But it is a link to a commit and I need a link to a PR.  I think it's=
 this one:
> > >
> > > https://github.com/acpica/acpica/pull/1012
> >
> > Yes that's the right PR that led to the commit.  Can you swap it out?
>
> Yes, I can.
>
> > Or would you like me to resubmit with it adjusted?
>
> No need.

Applied as 6.16 material, thanks!

