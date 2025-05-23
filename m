Return-Path: <linux-acpi+bounces-13857-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB9AC2180
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF52B1B64D83
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE802229B1C;
	Fri, 23 May 2025 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLHW9TqF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B3F14A627;
	Fri, 23 May 2025 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747997426; cv=none; b=bhfLKrOzclQIlO7VCmDEnTKXqsFJhnpZghNbHcE0HByE8KtLpEMktG1y7XgrH+iVTwfVbsKyZ0GRcfD2k/2MnK+B1Zi+rhNCSeWOaOF85QdazoKYj1HG7UOQBy9e9fZP20EjXzlnFJXgfqFRkJ2O23BYpQRhhg4VqojddSsW3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747997426; c=relaxed/simple;
	bh=ItwvRkhTT2c2vOcsnAS+TQJbapv+gHHQ9cnv1sPZbsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFn5hbgr9bvxbH5NZReJ/yQS4DcW+9V5htSYGv+xS4qB3BBZXs0xU37S53hA+Ld2ueWbOuZqXWuSvrdfchERjC/zlhp0UqwYk4Bi99QqSemjSQEH9U4BOsDatyjmTnpSgNXfKUUp9zlO5LT71tMTSfH/AZkbvJudSJ+yr62NA9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLHW9TqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF6FC4CEEA;
	Fri, 23 May 2025 10:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747997426;
	bh=ItwvRkhTT2c2vOcsnAS+TQJbapv+gHHQ9cnv1sPZbsQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FLHW9TqFjJVITGyGJaV2Fl04y5ckg+KCuKKkQpFLZSZT4FVBOP4Y0b6EPZSB1105M
	 9BRZ8fXqdHFxBsDn6eAaoF/vAGyUMosQjffWqmRp+qOoZjpgw/Wzb9clskNU7fF35q
	 6C590MkglnURG+bgUtx/9pmPR7iRtqVbZ05em/xtVlqOglkhLARsz3eUEF0bCtbOi2
	 1HNl+D5u1h8atcgyO7gXOVlShHIZI/Ix0dARFKP7eQfnZPQN2W+kn5luW2sZ7uJwAj
	 R0nztJU1Ax0j1drIQPWKPcYQlQXPJ5hdZ3zN4De7rsCFG6ZrtpRjkUddI28qgFNov6
	 xeXoWV7OrDUmw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-604ad6c4d3dso3183654eaf.0;
        Fri, 23 May 2025 03:50:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeJ9ZH37m+A+sD4C70C5YUzDZzyckhQ3SnmFPW0/kENn9nU5ugXBF/Xh2AbU71SVIsYgze5TXoCL+lBEXA@vger.kernel.org, AJvYcCXTHkTGoe8VbK/QXjoxNKxrX7kpcK7asUMHcyBrmEIu6HVNazI3DUcpw7wsJGr0tEBDYNSjUXF+91Jy@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGVYbgCE6I//3+DmI2Zp7XuOUNMSik8zLWrIhyFRVxO7F7nrG
	5bjbfTShR2l/MtRVYiQ4GUAlxvCG7rBPJLSBB7GnHtGvNp6NUYzM0Eg8OqaWqqh/VLi25PojSnb
	YoaHYlLVjvmVXl9ZcNL5cx2F9P3Ivt8s=
X-Google-Smtp-Source: AGHT+IGRYoi8FvCDeVJW5bpz6ccEXrPNWeRojPzXCCPt1ZQOkm62FHpUPClgAcFymrz8Ta6H/88yteDUITwuy21OwY8=
X-Received: by 2002:a4a:ec44:0:b0:608:3f1d:bbdb with SMTP id
 006d021491bc7-60b95417fafmr1181273eaf.8.1747997425506; Fri, 23 May 2025
 03:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522141410.31315-1-alexghiti@rivosinc.com>
 <91458376-dfc7-46fc-8523-aa176907d703@gmx.de> <83e02a52-86ad-45e5-ba87-6c17dc6f59b5@ghiti.fr>
In-Reply-To: <83e02a52-86ad-45e5-ba87-6c17dc6f59b5@ghiti.fr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 12:50:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iPVx0KXB5qQ46iQ7CKG6KJC1CnXogQ=e8or24vZuytrw@mail.gmail.com>
X-Gm-Features: AX0GCFs9rXtmQ9GPe95j5ovoZSpmZkfTNbNUc6PIZtkLQ9LMDWe_nnToU3ojthc
Message-ID: <CAJZ5v0iPVx0KXB5qQ46iQ7CKG6KJC1CnXogQ=e8or24vZuytrw@mail.gmail.com>
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

On Fri, May 23, 2025 at 12:11=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wr=
ote:
>
> On 5/22/25 22:04, Armin Wolf wrote:
> > Am 22.05.25 um 16:13 schrieb Alexandre Ghiti:
> >
> >> The platform profile driver is loaded even on platforms that do not ha=
ve
> >> acpi enabled. The initialization of the sysfs entries was recently mov=
ed
> >> from platform_profile_register() to the module init call, and those
> >> entries need acpi_kobj to be initialized which is not the case when ac=
pi
> >> is disabled.
> >>
> >> This results in the following warning:
> >>
> >>   WARNING: CPU: 5 PID: 1 at fs/sysfs/group.c:131
> >> internal_create_group+0xa22/0xdd8
> >>   Modules linked in:
> >>   CPU: 5 UID: 0 PID: 1 Comm: swapper/0 Tainted: G W
> >> 6.15.0-rc7-dirty #6 PREEMPT
> >>   Tainted: [W]=3DWARN
> >>   Hardware name: riscv-virtio,qemu (DT)
> >>   epc : internal_create_group+0xa22/0xdd8
> >>    ra : internal_create_group+0xa22/0xdd8
> >>
> >>   Call Trace:
> >>
> >>   internal_create_group+0xa22/0xdd8
> >>   sysfs_create_group+0x22/0x2e
> >>   platform_profile_init+0x74/0xb2
> >>   do_one_initcall+0x198/0xa9e
> >>   kernel_init_freeable+0x6d8/0x780
> >>   kernel_init+0x28/0x24c
> >>   ret_from_fork+0xe/0x18
> >>
> >> Fix this by checking if acpi is enabled before trying to create sysfs
> >> entries.
> >
> > I already submitted a patch for this problem (see
> > https://lore.kernel.org/linux-acpi/a6d92cdd-4dc3-4080-9ed9-5b1f02f247e0=
@gmx.de/T/)
> > that only disables the legacy sysfs interface while keeping the
> > class-based interface functional
> > as it does not depend on ACPI at all.
>
>
> Great, I understand if your patchset is not merged for rc1 but it would
> be nice to have it merged in 6.16 though to fix riscv syzkaller
> instance. Perhaps you could add the Fixes tag that Arnd mentioned too?

I actually prefer your patch to the Armin's one because there are
questions regarding the latter (see the most recent message from Arnd
in this thread).

Thanks!


> >> Fixes: 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI
> >> platform profile")
> >> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >> ---
> >>   drivers/acpi/platform_profile.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/acpi/platform_profile.c
> >> b/drivers/acpi/platform_profile.c
> >> index ffbfd32f4cf1..b43f4459a4f6 100644
> >> --- a/drivers/acpi/platform_profile.c
> >> +++ b/drivers/acpi/platform_profile.c
> >> @@ -688,6 +688,9 @@ static int __init platform_profile_init(void)
> >>   {
> >>       int err;
> >>   +    if (acpi_disabled)
> >> +        return -EOPNOTSUPP;
> >> +
> >>       err =3D class_register(&platform_profile_class);
> >>       if (err)
> >>           return err;
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

