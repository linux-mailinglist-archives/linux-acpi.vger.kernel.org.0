Return-Path: <linux-acpi+bounces-14190-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAE1AD00CF
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 12:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1E818947B4
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 10:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA09F2874FB;
	Fri,  6 Jun 2025 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4h2MCx5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A222874F4;
	Fri,  6 Jun 2025 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749207233; cv=none; b=WpiogMgIno6foNvxU1qYJuWyjW8n93hrjO7xy1C5oeHR4ci0usTCI8+d+8gMeTdSMsiAumpGwybt16vr1JSVpThwD1Z2M516fp7tfuI+pjh2uZkfKtZmLLuWCkH9wOU7NrL40qk+YGzqIrL7S5TnFAMSiuqt7gPvmKs+s74cJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749207233; c=relaxed/simple;
	bh=738c3+vImT5W5NH3YikTKpwWO0oPCcaLLmdjIR93WMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8agGEnEjQf1zSIcDvKMkKenJpd5w1V9DrXgfAxZ1Od+OF1HAWvLhVJeOt6shea32LcHoQSaLxGH07x/SyK/dxw4YIpr47lK8lf4FIxbGpFRa6T1jTuXzWl3hOH4R4foy9jma3fUC1v/p/NM1kl/f6BXA3YMjkRa/nSUYL8rwlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4h2MCx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25459C4CEF3;
	Fri,  6 Jun 2025 10:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749207233;
	bh=738c3+vImT5W5NH3YikTKpwWO0oPCcaLLmdjIR93WMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i4h2MCx5NcLDNuVki3C8cfL8XtTye+jT/KKI6h/C+wfLkLbgvhXqmki1tw82IXgfQ
	 DptdH61mgBY5KH4ZtcOkHMKZqTrR6ByePYowFP6ErceG3oCwA/74eleY6vOiCHDBWV
	 xuSXNtnkptleo1lHFlhtdDXPkDXXCzLvhMwTKBQhYupdM5qqYtbWdCZzieE5MTIzhE
	 Vu5QgLVqcg6m5Y7PIpezhlyEQ4gcqCf9nmtm2OdO8i/c8jy91t3xUGIqKxFrGjnOws
	 JJRYwTxgf8PX9U7A1TClsuoPdolaGt8TWe6SBwb5d9pjmEAZ02KBmCMulDKEs6zQDz
	 8W7IuLLX/0gag==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2e95ab2704fso1277569fac.3;
        Fri, 06 Jun 2025 03:53:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtXzNG3r36eoTUs3eAn1zsmPGhaRYVbU0QF7yZR0dqBlKooGrxwAXU2f2B/Y/0quOfKb5LP/R2CMs=@vger.kernel.org, AJvYcCWR3BVUdQ7rJFnPvGL8rUU4mh18yhaVwR4ORcTcACnQxVdAC9AeaJ+vyeF+1mrMPqnu4+esAlWW5iD3q3I9@vger.kernel.org, AJvYcCXZxTzydbag9Gb75DTU/ftYza+vpOC6iSN8uxhFgPGC1e+0kckdqJB61QLIbRxwcueMNAfBAWo3E6OI@vger.kernel.org
X-Gm-Message-State: AOJu0YzEcXivXgtzJp/pE91h7J8wb7XKKgDnabGGhHPtj+gKlYweSdg8
	DHUG+7wn0CTTZCDdaEkatr5KNRH/y8Am3aX1RNFGB00LEs1HowvCsp/j/p1ZVPkE8f63NGFNUMi
	RpIdECDpVVtVgRlhWfve8uPO05rcQryI=
X-Google-Smtp-Source: AGHT+IGu2KnqIBuspqTcRC6/ewpwhRR9+2NqR71IcpBIzA+8G4EfS5Sv0RC7ugVJ5inNZjfMcaCUQP9Zhy4XnwAUdWs=
X-Received: by 2002:a05:6808:398c:b0:406:7af5:30f2 with SMTP id
 5614622812f47-409051434ffmr1923577b6e.34.1749207232407; Fri, 06 Jun 2025
 03:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2226957.irdbgypaU6@rjwysocki.net> <96158539a213de089c792ff8f88ed5abb71a60e0.camel@linux.intel.com>
In-Reply-To: <96158539a213de089c792ff8f88ed5abb71a60e0.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Jun 2025 12:53:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jxyBNnW+3yOSg4XU3eJs6Wtnn_OvQZG2S=vfoygftrug@mail.gmail.com>
X-Gm-Features: AX0GCFsxhm_gi3yDGG5Bsx_UpVGMtRT1JztjzICf6p0rLLjHW6sIxNr14Bl8AZc
Message-ID: <CAJZ5v0jxyBNnW+3yOSg4XU3eJs6Wtnn_OvQZG2S=vfoygftrug@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] x86/smp: Restore the elimination of mwait_play_dead_cpuid_hint()
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 12:51=E2=80=AFPM Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> On Thu, 2025-06-05 at 17:03 +0200, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > The purpose of this series is to reapply the code changes from commit
> > 96040f7273e2 ("x86/smp: Eliminate mwait_play_dead_cpuid_hint()") that
> > has been reverted because of an issue introduced by it.  This takes
> > place in the last patch ([5/5]) and the previous patches make
> > preparatory changes needed to avoid breaking systems in the field
> > once again.
>
> Hello,
>
> thanks Rafael for the patches, and Peter/Dave for helping handling the
> issue.
>
> Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> I measured a Granite Rapids Xeon with v6.15 vanilla [setup 1], then
> with v6.15 + revert of 96040f7273e2 + these 5 patches [setup 2].
>
> I can see that in setup 2 the average idle package power is 54% lower
> than in setup 1. This is simply because in setup 1 there is no CC6 /
> PC6. And this is because every core's sibling is in CC1, which blocks
> CC6 on every core.
>
> =3D=3D Reference =3D=3D
>
> 1. Small article explaining then naming I use (CC1, CC6, PC6):
> https://github.com/intel/pepc/blob/main/docs/misc-cstate-namespaces.md
>
> =3D=3D Non-essential details, just for reference =3D=3D
>
> The measurement could have been done in a simpler way, but since I have
> developed tools and have a good setup to measure workloads with my open
> source tools, I did the following.
>
> Used stats-collect: https://github.com/intel/stats-collect/
>
> # Boot the vanilla kernel on system under test (SUT) named 'gnr2' (this
> # is the host name). Then run the following command on my system, that
> # has root SSH access to 'gnr2' configured.
>
> stats-collect start --stats all -H gnr2 --reportid gnr2-idle-nosmt-
> v6.15-vanilla -o raw/gnr2-idle-nosmt-v6.15-vanilla -- sleep 600
>
> # The above SSHed to gnr2, ran workload "sleep 600", and collected a
> # bunch of statistics, which were saved to
> # raw/gnr2-idle-nosmt-v6.15-vanilla on my host.
>
> # Boot the "setup 2" kernel, which I referred to as "6.15-fixed". Run
> # the following command.
>
> stats-collect start --stats all -H gnr2 --reportid gnr2-idle-nosmt-
> v6.15-fixed -o raw/gnr2-idle-nosmt-v6.15-fixed -- sleep 600
>
> # Then generate an HTML diff between those.
> stats-collect report raw/gnr2-idle-nosmt-v6.15-vanilla/ raw/gnr2-idle-
> nosmt-v6.15-fixed/ -o diff
>
> # Open "diff" with a browser (I have my HTTP server, so just copied it
> # to ~/public_html). Find lots of stats, in my case
> # turbostat, interrupts, IPMI.
>
> In the diff, I checked turbostat's PkgPwr (CPU chip power in Watts) and
> turbostat's CPU%c6 (CC6 residency, %).
>
> HTH,

Yes, it does, thanks a lot!

