Return-Path: <linux-acpi+bounces-13861-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAF1AC2555
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 16:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FB41896D0F
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86635295DAE;
	Fri, 23 May 2025 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5+oYAi9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF112957B2;
	Fri, 23 May 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011630; cv=none; b=hVpbst6oJk/r8w3BszO9NIJBtbxEXdMRzu8WPU2aXQrqgMMP7+osALsKk1+raTYUB9BcUqqMSSyzsE5yIknRFiDVVqlsS7QUtS7rHqMixS2CcPBRmdyexxuTZdyzGoujumTX0vXNIcomQB+tE/XR8ds1BDYqut4Vjezuw4ZTJb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011630; c=relaxed/simple;
	bh=Ocz5J1wgv3YESCv8WYdkxEBqXdkzz0W+TH/W1ADUndA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7J3IxDSB6XByQyewsfVLbPSQRzRRlVxyaqYsBNAUmenaEz7VDA/30cbl31XnoJWqTXxvhU9HXJeU+A4aWkCdTB7JP/KkEGe7AiIKpjpEoliJET8VLoUqmg0ftQriEYyN25EXl+zNaey5WEveXTXrNcaiNvSWrYwxPeGi584We4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5+oYAi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE438C4CEED;
	Fri, 23 May 2025 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748011629;
	bh=Ocz5J1wgv3YESCv8WYdkxEBqXdkzz0W+TH/W1ADUndA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p5+oYAi9e/oWGhHk+fosP6dsXBN2Bqqz/RtfmYCGLGUyU6KkEte5RTr21U6RQmAAH
	 rGrA87GT9vlTZTPh+HPWUKWp0DCIFkf5yOVFRxc8YoQB3U1KGLLJC3vIhl9txl4pPU
	 q14+b9aNWIit7WlXdbXywjdEKGmdHLvbBcKiT1VpP8Irr5BoQluteaHzZD/8G4JWF3
	 E9cF6wXsWA8si/H2j2wYjn1noxpSN5m7VW9cVDrmtXTs6nmnghvFkdUjEClE1jFJyh
	 m1S9Vk72/mZ+8mGxJlkFpibWlfIdVMRZA7pKiFLqHUxeEldmLlQc7t4r1xxcZ/nTsl
	 9kWzNVH1CibJw==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3feaedb4085so35131b6e.0;
        Fri, 23 May 2025 07:47:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW99yl1tr2Qwsafj9mmZsiKNMGZ72dUXnv422nJidn7zTmo391JbNT7rjDxwvfeJaa3GqvC6BiiuASG2BKb@vger.kernel.org, AJvYcCXxOFjWPMZzZq+WE6h8Ydk2lnoVMurUJ7DR2WGTb2euZQArXbPlhADplSomC5izVvjJsjPEOg+Ibs/R@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2AuwJsO6jIihYcdx02hFTyCmAnIrQA/mq9mHO/N4xgdLNo9hp
	jJog59pBejgc6zVItYSaRERCpOYp96NDDA10Seh7mdPA1w7BMXrF6OfK1H1HIesSi+1ac5oal0e
	mZZD9YyX/0xOatQqEcbFms9yjbw6jbBc=
X-Google-Smtp-Source: AGHT+IGXxPZzBQ0rd2WqVkE2kMetZWcN0Srwq81135CC4scj5mkn+qPK+TyalxnWlDXRxW6GT+U59ljzQHKP8FVgAfY=
X-Received: by 2002:a05:6808:149:b0:401:e67c:b3be with SMTP id
 5614622812f47-404d865e18emr16061098b6e.4.1748011629042; Fri, 23 May 2025
 07:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522141410.31315-1-alexghiti@rivosinc.com>
 <91458376-dfc7-46fc-8523-aa176907d703@gmx.de> <83e02a52-86ad-45e5-ba87-6c17dc6f59b5@ghiti.fr>
 <CAJZ5v0iPVx0KXB5qQ46iQ7CKG6KJC1CnXogQ=e8or24vZuytrw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iPVx0KXB5qQ46iQ7CKG6KJC1CnXogQ=e8or24vZuytrw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 16:46:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iwH3p_A=f0g7+EsPbP7KBJS_LbT9+_gXNLBbXqW8vMFg@mail.gmail.com>
X-Gm-Features: AX0GCFu5YgI8J1uqi55rgc7H6g3G0QyH8pHo4Ylik2ehjhEW7e8_ODhJw6NXFgk
Message-ID: <CAJZ5v0iwH3p_A=f0g7+EsPbP7KBJS_LbT9+_gXNLBbXqW8vMFg@mail.gmail.com>
Subject: Re: [PATCH] drivers: acpi: Fix platform profile driver on !acpi platforms
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Armin Wolf <W_Armin@gmx.de>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 12:50=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Fri, May 23, 2025 at 12:11=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> =
wrote:
> >
> > On 5/22/25 22:04, Armin Wolf wrote:
> > > Am 22.05.25 um 16:13 schrieb Alexandre Ghiti:
> > >
> > >> The platform profile driver is loaded even on platforms that do not =
have
> > >> acpi enabled. The initialization of the sysfs entries was recently m=
oved
> > >> from platform_profile_register() to the module init call, and those
> > >> entries need acpi_kobj to be initialized which is not the case when =
acpi
> > >> is disabled.
> > >>
> > >> This results in the following warning:
> > >>
> > >>   WARNING: CPU: 5 PID: 1 at fs/sysfs/group.c:131
> > >> internal_create_group+0xa22/0xdd8
> > >>   Modules linked in:
> > >>   CPU: 5 UID: 0 PID: 1 Comm: swapper/0 Tainted: G W
> > >> 6.15.0-rc7-dirty #6 PREEMPT
> > >>   Tainted: [W]=3DWARN
> > >>   Hardware name: riscv-virtio,qemu (DT)
> > >>   epc : internal_create_group+0xa22/0xdd8
> > >>    ra : internal_create_group+0xa22/0xdd8
> > >>
> > >>   Call Trace:
> > >>
> > >>   internal_create_group+0xa22/0xdd8
> > >>   sysfs_create_group+0x22/0x2e
> > >>   platform_profile_init+0x74/0xb2
> > >>   do_one_initcall+0x198/0xa9e
> > >>   kernel_init_freeable+0x6d8/0x780
> > >>   kernel_init+0x28/0x24c
> > >>   ret_from_fork+0xe/0x18
> > >>
> > >> Fix this by checking if acpi is enabled before trying to create sysf=
s
> > >> entries.
> > >
> > > I already submitted a patch for this problem (see
> > > https://lore.kernel.org/linux-acpi/a6d92cdd-4dc3-4080-9ed9-5b1f02f247=
e0@gmx.de/T/)
> > > that only disables the legacy sysfs interface while keeping the
> > > class-based interface functional
> > > as it does not depend on ACPI at all.
> >
> >
> > Great, I understand if your patchset is not merged for rc1 but it would
> > be nice to have it merged in 6.16 though to fix riscv syzkaller
> > instance. Perhaps you could add the Fixes tag that Arnd mentioned too?
>
> I actually prefer your patch to the Armin's one because there are
> questions regarding the latter (see the most recent message from Arnd
> in this thread).

And so it has been applied as 6.16 material now, thanks!

> > >> Fixes: 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI
> > >> platform profile")
> > >> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > >> ---
> > >>   drivers/acpi/platform_profile.c | 3 +++
> > >>   1 file changed, 3 insertions(+)
> > >>
> > >> diff --git a/drivers/acpi/platform_profile.c
> > >> b/drivers/acpi/platform_profile.c
> > >> index ffbfd32f4cf1..b43f4459a4f6 100644
> > >> --- a/drivers/acpi/platform_profile.c
> > >> +++ b/drivers/acpi/platform_profile.c
> > >> @@ -688,6 +688,9 @@ static int __init platform_profile_init(void)
> > >>   {
> > >>       int err;
> > >>   +    if (acpi_disabled)
> > >> +        return -EOPNOTSUPP;
> > >> +
> > >>       err =3D class_register(&platform_profile_class);
> > >>       if (err)
> > >>           return err;
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv

