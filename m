Return-Path: <linux-acpi+bounces-1817-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFCC7F798F
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 17:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C026A1C20864
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 16:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F019364AC
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrFw/dw5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5B2FE25
	for <linux-acpi@vger.kernel.org>; Fri, 24 Nov 2023 15:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E57C433CA;
	Fri, 24 Nov 2023 15:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700841279;
	bh=HSUtuUG3dDjCbWMPNmFm21ZEHdtclUUifKkpgTT5yE8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rrFw/dw5ip/zqV5GjzcL/t5aMj+AndZ3mxtQzkqLdM3KbqPumL4xKLGkmU2lx99+g
	 q+sqA6/jZl8Tr+l8CbtlI4tAPRlGdBqQPqXAOOYXN3O5N4gbZWAKZK/rtuk9PBy2RY
	 6ZrCWyWAjzu/RrltCXdm8+6Bs2psimfBuicrmLltoGYJ2y8uXEeN0uwjj9z0kkI8Sv
	 RPtt9ycr+xDR7D1XNlw3ibPlK90lIBQMF4G8l+dxytINZRx8dXoVaWMCw69bWb6grW
	 61Pz37I7x5pqW98qMTstF4XMHx/fIW1AyWjNfD/MhTDWOP9x495BsAdOdV8QNKmN8x
	 3I2FvDFuB0cAQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c878e228b4so26153291fa.1;
        Fri, 24 Nov 2023 07:54:38 -0800 (PST)
X-Gm-Message-State: AOJu0YzOMb9S/jmedPNY5PzGR42ka7p4xgTOXjRuWj5vbZZdGa/qWwJ7
	6tRWL2Iv5jtnNChU6vORwB4OfBm6y+Rb4vAMXt4=
X-Google-Smtp-Source: AGHT+IEO6hzqnk+/EB0u2DykEu4CRlWVrIPl2vHrqt6bNxr5C0CBj4EcS7ice6ugF6Vx89pIH3u9pPzqBy+2EGPNIC4=
X-Received: by 2002:a2e:b523:0:b0:2c9:8f6b:3d9a with SMTP id
 z3-20020a2eb523000000b002c98f6b3d9amr1609781ljm.16.1700841277253; Fri, 24 Nov
 2023 07:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12299447.O9o76ZdvQC@kreacher> <CAMj1kXHpVroVqXxH72XNJP5=dYDcfBiZex2wE2jOsSFNEAYqxg@mail.gmail.com>
 <5724231.DvuYhMxLoT@kreacher> <CAJZ5v0gMw3xsKuvS0Q26D=DPdQFtDxAMfscufMZMPVFmYC2ZhA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gMw3xsKuvS0Q26D=DPdQFtDxAMfscufMZMPVFmYC2ZhA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 24 Nov 2023 16:54:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGT1c7aj4F7bnjkZG2aR+C6p1AYVbxLqNVg0DvXBLezjQ@mail.gmail.com>
Message-ID: <CAMj1kXGT1c7aj4F7bnjkZG2aR+C6p1AYVbxLqNVg0DvXBLezjQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: processor: Provide empty stub of acpi_proc_quirk_mwait_check()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Michal Wilczynski <michal.wilczynski@intel.com>, Guenter Roeck <linux@roeck-us.net>, 
	Frank Scheiner <frank.scheiner@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Nov 2023 at 20:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Sep 21, 2023 at 4:00=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.=
net> wrote:
> >
> > On Thursday, September 21, 2023 3:09:04 PM CEST Ard Biesheuvel wrote:
> > > On Thu, 21 Sept 2023 at 13:04, Rafael J. Wysocki <rjw@rjwysocki.net> =
wrote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Commit 0a0e2ea642f6 ("ACPI: processor: Move MWAIT quirk out of
> > > > acpi_processor.c") added acpi_proc_quirk_mwait_check() that is
> > > > only defined for x86 and is unlikely to be defined for any other
> > > > architectures, so put it under #ifdef CONFIG_X86 and provide
> > > > an empty stub implementation of it for the other cases.
> > > >
> > > > Link: https://lore.kernel.org/lkml/c7a05a44-c0be-46c2-a21d-b242524d=
482b@roeck-us.net
> > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.gi=
t/commit/?h=3Dremove-ia64&id=3Da0334bf78b95532cec54f56b53e8ae1bfe7e1ca1
> > > > Fixes: 0a0e2ea642f6 ("ACPI: processor: Move MWAIT quirk out of acpi=
_processor.c")
> > > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > > Reported-by: Frank Scheiner <frank.scheiner@web.de>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >
> > > > This is kind of orthogonal to
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/comm=
it/?h=3Dremove-ia64&id=3Da0334bf78b95532cec54f56b53e8ae1bfe7e1ca1
> > > >
> > > > because if any architectures other than x86 and ia64 decide to use =
the
> > > > processor _OSC, they will see the reported build error.
> > > >
> > >
> > > You mean when other arches #define CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC to=
o, right?
> > >
> > > In any case, this is going to conflict with my change, which is
> > > already in linux-next (you were cc'ed on the PR to asm-generic). What
> > > do you propose here?
> >
> > IIUC, the conflict is that the empty stub will be defined twice if this=
 is
> > applied before removing ia64.
> >
> > But if it is applied on top of the ia64 removal, all should be fine, so=
 that's
> > what I would do (and tell the -stable people to ignore it).
>
> And ia64 is gone now, so applied.

Excellent.

