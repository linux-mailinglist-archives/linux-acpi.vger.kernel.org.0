Return-Path: <linux-acpi+bounces-20265-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 612EAD1B7EB
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 22:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61976302F2F4
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 21:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3176C34FF46;
	Tue, 13 Jan 2026 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjipl7iL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB2331B808
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341466; cv=none; b=Wb1hK3quOTCNHqZzgjwbSzHpuU0wtkk4eRWemOklG3KAs1ARoRaNDFVkGyb3OOMo/bkYIZ+T5oGEHOSw9vOKlLAmciJFfEJWkM7TQxk+xmtWSt9Mv4BlhhvU0Z+3kS3lvr2dtXXSkGjg+SrG9C1+PycoIajYw6SlDHMsJ41HXIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341466; c=relaxed/simple;
	bh=NlgZFPJHPp1obehSkBau+Ti6CjKCYkP0mAuZcu9Tr5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLI4j5QeWCgdAnP4EKfQvo2tQJplaOMriO4KIrHWwi/RXu46hbbi94oAHUhaFiYOVBDHO4cJnsFzyUMXkWb/9OvDMf3nWVM8Kz4BjAjyQArrBHn2N1XGmeEqoD0OVywOGJprj3AI6JUDQoe8vhzwJC0W8Sgy6Blet+jRFqIlns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjipl7iL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DF8C19423
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 21:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768341465;
	bh=NlgZFPJHPp1obehSkBau+Ti6CjKCYkP0mAuZcu9Tr5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bjipl7iLR07YnKMz7OOUwpwo9pqfVbC8BVaxEw+EDBD90psIFyTfcAxIcmT/Mn2Py
	 7ieRJCsQkUPkSyH+12p6f+SeXtVZMPJhAW0MfqfgfsQ7dzxn+wGWFaV/SsNsgCtENX
	 uX9ZGcz1QMxbcL0nld9zxnY7ud5thjFH2LnN05wz/Jvh161KUbFOEKhjV2mosMUC9G
	 QO12UEwV3T+onzwTX/1zz31CJlYIY8zoiRec/HBDkVRfexSoFEfO05Hip0RuFEWijb
	 R4/eMwlRssJfdwKV+h1bCWq1WrlLlMF9OSv1jcvAlc/FvCUa/YSIKkb9df5JWmEMc4
	 8nJ/cRzilJ2dA==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c6d1ebb0c4so6152277a34.1
        for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 13:57:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWn/Q+lm7MPcZAkYU/w44YBL963DxHjWSzRttGVjYY8RcK/9c21lJP2+Ss/nBBzhgr5RGocOPF9ZaiU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7cQSFQxT2ioMQi3PmCN46wkpGYVZL1oEzalJ/0HJCBd9Z7k4U
	i/mcY//o+Egue3ftAikFKbPlwX/0Zyfv/lGAvdIOA19HkGBYqXSEBVfQqC+39vATb0fEV2pdhg3
	nVlk+6YZbg2D7mSmjF7I2yqr6rYhfKQk=
X-Received: by 2002:a05:6808:238c:b0:459:993f:b841 with SMTP id
 5614622812f47-45c715f8678mr215813b6e.63.1768341465020; Tue, 13 Jan 2026
 13:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2827214.mvXUDI8C0e@rafael.j.wysocki> <757e7800-c45f-4d65-a7f5-9b158660277a@amd.com>
In-Reply-To: <757e7800-c45f-4d65-a7f5-9b158660277a@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Jan 2026 22:57:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gwAXU1MdiffgHz8bYJotrJEujwc14D9Dh1rAX0pE9Q_A@mail.gmail.com>
X-Gm-Features: AZwV_Qg3ryptHB7Oe65KTF16fcg7k6DDsRyTZ3pWp4golTBvKBKKk93NfNAyJbw
Message-ID: <CAJZ5v0gwAXU1MdiffgHz8bYJotrJEujwc14D9Dh1rAX0pE9Q_A@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: PM: s2idle: Add module parameter for LPS0
 constraints checking
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 10:48=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> On 1/13/2026 7:36 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints when
> > needed") attempted to avoid useless evaluation of LPS0 _DSM Function 1
> > in lps0_device_attach() because pm_debug_messages_on might never be set
> > (and that is the case on production systems most of the time), but it
> > turns out that LPS0 _DSM Function 1 is generally problematic on some
> > platforms and causes suspend issues to occur when pm_debug_messages_on
> > is set now.
>
> Any ideas why it's causing problems?  AML doing something it shouldn't?

It's not a clear AML bug AFAICS.  Rather, it seems to have
dependencies on something that is not ready when it is evaluated, so
an ordering issue or similar.

> >
> > In Linux, LPS0 _DSM Function 1 is only useful for diagnostics and only
> > in the cases when the system does not reach the deepest platform idle
> > state during suspend-to-idle for some reason.  If such diagnostics is
> > not necessary, evaluating it is a loss of time, so using it along with
> > the other pm_debug_messages_on diagnostics is questionable because the
> > latter is expected to be suitable for collecting debug information even
> > during production use of system suspend.
> >
> > For this reason, add a module parameter called check_lps0_constraints
> > to control whether or not the list of LPS0 constraints will be checked
> > in acpi_s2idle_prepare_late_lps0() and so whether or not to evaluate
> > LPS0 _DSM Function 1 (once) in acpi_s2idle_begin_lps0().
> >
> > Fixes: 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints when =
needed")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/acpi/x86/s2idle.c |    8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/acpi/x86/s2idle.c
> > +++ b/drivers/acpi/x86/s2idle.c
> > @@ -28,6 +28,10 @@ static bool sleep_no_lps0 __read_mostly;
> >   module_param(sleep_no_lps0, bool, 0644);
> >   MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device i=
nterface");
> >
> > +static bool check_lps0_constraints __read_mostly;
> > +module_param(check_lps0_constraints, bool, 0644);
> > +MODULE_PARM_DESC(check_lps0_constraints, "Check LPS0 device constraint=
s");
>
> I'm personally not really a fan of another module parameter for
> debugging.  I know some other subsystem maintainers are very anti-module
> parameters too.
>
> I did like having /sys/power/pm_debug_messages able to be a one stop
> shop for debugging messages at runtime.

Well, this is not just debug messages, rather a whole debug facility
enabled via pm_debug_messages, which is kind of confusing.

> So I had another idea I wanted to throw around.  What if instead we had
> a file /sys/kernel/debug/x86/lps0_constraints?

Then you cannot use this without debugfs.

> If the file is never accessed never evaluate constraints.  If you read
> it once then you can get a dump of all the current constraints and any
> future suspends during that boot will also include constraints in the
> logs (IE call lpi_check_constraints()).

So if it is not in debugfs, it would need to be in sysfs and then I
don't see much difference between it and a module param, honestly.

I actually prefer the latter because it uses an existing infra.

