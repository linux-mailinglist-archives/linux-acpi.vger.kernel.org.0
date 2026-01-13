Return-Path: <linux-acpi+bounces-20269-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C97D1B884
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 23:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1311C30057DD
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 22:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8D8324B0A;
	Tue, 13 Jan 2026 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRXcdI5h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF92222C4
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341946; cv=none; b=RoU2Y5BKxZbICVn0Zo7lMC+ssMVcUvLhLIDMJGMbJheCCgVN8eEjRiXshWHEGG6R6eKnM7ofI9WZr1pw2Kgt4y9fZuLnCkK4JdQbE+eIgyTBhmtB3RsU2k0z/hKjs5BErtKlpqxO7WFPypk+CXsk6irJvuL4Ejf+RTa19X7s5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341946; c=relaxed/simple;
	bh=zQdrq/FxmOJRbH6HsZdqBczaUQcz9JMCWPnERjZr10s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhpSmy3sFVTId6BJ6K0POuNqXSwf79rGH1kFw3FRAmGEb7EHzETnKAJlgtYxuAmLGr7EnA4t37co/gsSU4TY8nNyFI4ZSH6wNP2NknZJABDEIwuxU3TsqEXdlgfdo4dQDAgJM+P5fDKDsQA0a2DGRlIZUIsUmTCorPwxkgPxnKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRXcdI5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DACAC19424
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 22:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768341945;
	bh=zQdrq/FxmOJRbH6HsZdqBczaUQcz9JMCWPnERjZr10s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cRXcdI5h6fXWLZgwDRFJYUi9U/1UiRo5NB3OjGgpxRUbydgWfKDi42R6l1kbCTdro
	 lVwGOtATJlNGfB/6yVUDNmtV2HSbn3DvtCn8SXkyplfSVd3bc2Xb6Oexs215q3y0bx
	 tb8Yk8ftZDlvsl+FrRDrb2JtznffAJtss6Tqs2PSz6rHwfvq9JcvzqhdGeNs07LIBj
	 z8GASWgPfPqgcKB1zvYMwWH7V0a+TOHT9HmHrs/+xwVsBy3Q/myXL2xHblPItTJKFn
	 TQ9XbEQ0CF+RcxmI/IO9QAfFLByrEMe2YJPFQbwqbr/XwEgNkDuRy8Ptz+YDSG1w7F
	 oilOPPpAst/Ag==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-455a461ab6eso3250303b6e.2
        for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 14:05:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJrtEBptI51ifympObOvInffMrEwfyEMSZMmm6o41zJmQ50E2OC0P05sr2umU83dMzW6cyOr9qHHCe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5mVq+im28muNZyicSs0C/vjv7w97ckNaLTxg4rhw3C81Lhy5
	Cf7DBxZguQDaVkqcnGaUYiRaU77tL2ms+QkFEKlLvzkvPbc2BzuI/uMdLFoghjrWoB+q09Yc7JE
	qXVNKy5fjGSGxAt98rfHk1/p3B1V2Pf4=
X-Received: by 2002:a05:6808:221e:b0:453:30e5:5582 with SMTP id
 5614622812f47-45c71572540mr238514b6e.47.1768341944756; Tue, 13 Jan 2026
 14:05:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2827214.mvXUDI8C0e@rafael.j.wysocki> <757e7800-c45f-4d65-a7f5-9b158660277a@amd.com>
 <CAJZ5v0gwAXU1MdiffgHz8bYJotrJEujwc14D9Dh1rAX0pE9Q_A@mail.gmail.com> <bd1c4616-d8ad-4fbc-bd90-2e56996d0f5a@amd.com>
In-Reply-To: <bd1c4616-d8ad-4fbc-bd90-2e56996d0f5a@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Jan 2026 23:05:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gFmRVNEG_QL2+F7Dmvey4WrcHwt7Rhq2hizcxzGF2eWA@mail.gmail.com>
X-Gm-Features: AZwV_QioljCwxevXcwM-RvDFgkSilvDwQm0H82Jxaur-_YgnjuvJZ_xBUkGZHAE
Message-ID: <CAJZ5v0gFmRVNEG_QL2+F7Dmvey4WrcHwt7Rhq2hizcxzGF2eWA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: PM: s2idle: Add module parameter for LPS0
 constraints checking
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 11:00=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> On 1/13/2026 3:57 PM, Rafael J. Wysocki wrote:
> > On Tue, Jan 13, 2026 at 10:48=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >> On 1/13/2026 7:36 AM, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Commit 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints whe=
n
> >>> needed") attempted to avoid useless evaluation of LPS0 _DSM Function =
1
> >>> in lps0_device_attach() because pm_debug_messages_on might never be s=
et
> >>> (and that is the case on production systems most of the time), but it
> >>> turns out that LPS0 _DSM Function 1 is generally problematic on some
> >>> platforms and causes suspend issues to occur when pm_debug_messages_o=
n
> >>> is set now.
> >>
> >> Any ideas why it's causing problems?  AML doing something it shouldn't=
?
> >
> > It's not a clear AML bug AFAICS.  Rather, it seems to have
> > dependencies on something that is not ready when it is evaluated, so
> > an ordering issue or similar.
>
> Ah I see.
>
> >
> >>>
> >>> In Linux, LPS0 _DSM Function 1 is only useful for diagnostics and onl=
y
> >>> in the cases when the system does not reach the deepest platform idle
> >>> state during suspend-to-idle for some reason.  If such diagnostics is
> >>> not necessary, evaluating it is a loss of time, so using it along wit=
h
> >>> the other pm_debug_messages_on diagnostics is questionable because th=
e
> >>> latter is expected to be suitable for collecting debug information ev=
en
> >>> during production use of system suspend.
> >>>
> >>> For this reason, add a module parameter called check_lps0_constraints
> >>> to control whether or not the list of LPS0 constraints will be checke=
d
> >>> in acpi_s2idle_prepare_late_lps0() and so whether or not to evaluate
> >>> LPS0 _DSM Function 1 (once) in acpi_s2idle_begin_lps0().
> >>>
> >>> Fixes: 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints whe=
n needed")
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>    drivers/acpi/x86/s2idle.c |    8 ++++++--
> >>>    1 file changed, 6 insertions(+), 2 deletions(-)
> >>>
> >>> --- a/drivers/acpi/x86/s2idle.c
> >>> +++ b/drivers/acpi/x86/s2idle.c
> >>> @@ -28,6 +28,10 @@ static bool sleep_no_lps0 __read_mostly;
> >>>    module_param(sleep_no_lps0, bool, 0644);
> >>>    MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 devic=
e interface");
> >>>
> >>> +static bool check_lps0_constraints __read_mostly;
> >>> +module_param(check_lps0_constraints, bool, 0644);
> >>> +MODULE_PARM_DESC(check_lps0_constraints, "Check LPS0 device constrai=
nts");
> >>
> >> I'm personally not really a fan of another module parameter for
> >> debugging.  I know some other subsystem maintainers are very anti-modu=
le
> >> parameters too.
> >>
> >> I did like having /sys/power/pm_debug_messages able to be a one stop
> >> shop for debugging messages at runtime.
> >
> > Well, this is not just debug messages, rather a whole debug facility
> > enabled via pm_debug_messages, which is kind of confusing.
>
> Good point.
>
> >
> >> So I had another idea I wanted to throw around.  What if instead we ha=
d
> >> a file /sys/kernel/debug/x86/lps0_constraints?
> >
> > Then you cannot use this without debugfs.
>
> I mean; yeah.  But it really is debugging and most distros have debugfs
> enabled by default these days don't they?

Some of them don't.

That's one of the reasons why tracing has its own pseudo-filesystem
now, so it is a real obstacle.

> >
> >> If the file is never accessed never evaluate constraints.  If you read
> >> it once then you can get a dump of all the current constraints and any
> >> future suspends during that boot will also include constraints in the
> >> logs (IE call lpi_check_constraints()).
> >
> > So if it is not in debugfs, it would need to be in sysfs and then I
> > don't see much difference between it and a module param, honestly.
> >
> > I actually prefer the latter because it uses an existing infra.
>
> I agree if debugfs is decided to be out sysfs and module parameter are
> equal footing and then this patch makes sense.

I think that debugfs cannot be relied on to be always present.

