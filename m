Return-Path: <linux-acpi+bounces-9373-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 058949BF80A
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 21:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5B51F23B7A
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5387A20C464;
	Wed,  6 Nov 2024 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp+2tJDN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74220C325;
	Wed,  6 Nov 2024 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925243; cv=none; b=pvRk1f1XSAs4YFgQy3ORviaiS5aVwa4SsHU+UftiT48TiwliBgjX2+JK5/944ByWBtWOujgI7tssP5k2eHO7kkfVJhP20ylP8FTLpP39sU6a3O7VA45TjSsqk1RBu7arwauLNFiWj1KADydB275JkgeGl6eb7fWhrbyeczQrG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925243; c=relaxed/simple;
	bh=FohDGAir3tCHy+2gHu5Qo5hFIGFB4ybypUNSHv+E94o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPSbijU+kdlNVzZi8zgH6KTCgcL9fH4BCa0qSlc5O5t+lpIXTDPldDujR2BtShzzskCTsdagYwNqKQVV4QMIMHP4UNp+z9QUbB5a8tspQy2QYxMFYIpF6Y7Z/KjjPSEKO0+Lkg1ALzOlsStHXGRFZz6w5OIx9yTg+l2sonsVsvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qp+2tJDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF003C4CED8;
	Wed,  6 Nov 2024 20:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730925242;
	bh=FohDGAir3tCHy+2gHu5Qo5hFIGFB4ybypUNSHv+E94o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qp+2tJDNDDNnEvEXorSf6ztPAGCji2NP6uIsi65W1B3595+5ZnS+eeLFX3Q2a08SZ
	 EE9BA3NaCPk4/R3f0UeNOFLuGm0rk4+VAAIp5rZcOaam709/CqWrZeXu4E7aupXL1i
	 C7M/ZuUVBfhAmE2CMjesaNWImc3jT3ZyGs8/G6b/Z0U9G4j2b9IG26kTYK2Pxlt+g9
	 xqvznGT5qbX+PgTlESQMRGWPTyT/VSjZsYqMZHQk0RkfM19HfSTkXGWdnyO8pOLCSq
	 3Q/XO5IbodtyIQfecDpum97swDAi+c9TGgH7qQ7/lcqThCjZT+iBIfxolpw/pey+ul
	 ih6nxBzrCInFQ==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e6104701ffso195198b6e.0;
        Wed, 06 Nov 2024 12:34:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtj2mMeu0Li2folVfNuMuf+7yfx4hqr47KCOCkkJtAq8cLChFFTbli3ryBBZQAjcXdEGwKp3BQAvUi/Cp0@vger.kernel.org, AJvYcCWWf930AOjbqqzla1Pwsn+0P/MxqOxMJM/AXVEBnyhQFJ05XMX8HbDOCvof2m4Hlzujy+C2xKazBDOA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzax6lEtkbbwwNEPjxxkl25Bn+mSe415w/sz0CV0f4dzClVfg7Z
	QbjlzLrHoBTL8bIBHW0LTMLdSEfbYsG3vSWHZrnoxmKae7s+cIXz6yQiz2iHgzCFteg2aG/Ymi7
	22tlH/xa1bFT52pXCIQUy/4lzcFU=
X-Google-Smtp-Source: AGHT+IGecqvZYz6VJ6nPpjW5PfwtCsmdNJCPFVN4oXkxrvO72g6VDvW7tykCxY6jViLJuWqan+LokpLOrJ2cns7t//M=
X-Received: by 2002:a05:6870:418d:b0:270:50f7:50c1 with SMTP id
 586e51a60fabf-29051af0f4amr37508782fac.1.1730925241795; Wed, 06 Nov 2024
 12:34:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104222855.3959267-1-superm1@kernel.org> <CAJZ5v0iVfdfetFBrq93hcaTgVTN-=WoWYnK5G65q+kRA-qNtwQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iVfdfetFBrq93hcaTgVTN-=WoWYnK5G65q+kRA-qNtwQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Nov 2024 21:33:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jLez+WcqMs4hWeTKdeSbBbAShWvbvGHVj--foZLQ_u6w@mail.gmail.com>
Message-ID: <CAJZ5v0jLez+WcqMs4hWeTKdeSbBbAShWvbvGHVj--foZLQ_u6w@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: processor: Move arch_init_invariance_cppc() call later
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, Ivan Shapovalov <intelfx@intelfx.name>, 
	Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 9:17=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Mon, Nov 4, 2024 at 11:29=E2=80=AFPM Mario Limonciello <superm1@kernel=
.org> wrote:
> >
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > arch_init_invariance_cppc() is called at the end of
> > acpi_cppc_processor_probe() in order to configure frequency invariance
> > based upon the values from _CPC.
> >
> > This however doesn't work on AMD CPPC shared memory designs that have
> > AMD preferred cores enabled because _CPC needs to be analyzed from all
> > cores to judge if preferred cores are enabled.
> >
> > This issue manifests to users as a warning since commit 21fb59ab4b97
> > ("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn=
"):
> > ```
> > Could not retrieve highest performance (-19)
> > ```
> >
> > However the warning isn't the cause of this, it was actually
> > commit 279f838a61f9 ("x86/amd: Detect preferred cores in
> > amd_get_boost_ratio_numerator()") which exposed the issue.
> >
> > To fix this problem, change arch_init_invariance_cppc() into a new weak
> > symbol that is called at the end of acpi_processor_driver_init().
> > Each architecture that supports it can declare the symbol to override
> > the weak one.
>
> "Define it for x86, in arch/x86/kernel/acpi/cppc.c, and for all of the
> architectures using the generic arch_topology.c code."

I've added this to the patch changelog and queued it up as a 6.12 fix.

Thanks!

