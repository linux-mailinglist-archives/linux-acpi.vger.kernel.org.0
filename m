Return-Path: <linux-acpi+bounces-1762-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975827F51BD
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 21:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E94B20ABF
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9965319BDE
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8091A8;
	Wed, 22 Nov 2023 11:39:32 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5841a3ffd50so17382eaf.1;
        Wed, 22 Nov 2023 11:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700681971; x=1701286771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrGYRaQuwaRR+IXDug9hdvAmme5SWIRdj6QFrDzBe8c=;
        b=GXhRiJYmTV74Y0flUuOH89405jOaMEckYpmOKMaiH5HfqXoB+H0AKa/AqIMqIIAmpC
         ipKYMNmFF/7zzxPxpg6QVcVeoDJqYarmmQ+9aEWaGOyRgCns7TFnZIvhxFqyA9pnQPJb
         eKYCV0tPG4l61TuN9h+BGMS0WBuHDWuzsfKILMs5dAtnQEeGRaGgCrPrZWUoCoGUoO5p
         ftjlqPp3rGf7Hkx342Z/QLYHPoeZm8XjVtEEyzIxu2GZVN9jp2zdrD1w25iBq/t6tlkF
         81IrYkx+Oip5C5A46KWTK3JOkXvBJ3f9G1El/NIKqnIjsNOPIgKXVrB7wK0Y7AZxPjgt
         TcEg==
X-Gm-Message-State: AOJu0YyorhX57RoLsm+s/XfhL7/B0HghGpJt5D4xbw9NhPPBbBg5uZaM
	bhb972rxCQFMMIm5NZrAql/MlIKZdF+K59ga3RJmTHCn
X-Google-Smtp-Source: AGHT+IFjlxpZYJh/rg9Lttt/sOzsAjzIgeTKw0qmGeh2mnz//xW9WqG6Gik1J5Y7uJlf0nG5JhjkP0i4pFjZHckZ/K4=
X-Received: by 2002:a05:6820:706:b0:58c:ec4c:fcac with SMTP id
 q6-20020a056820070600b0058cec4cfcacmr3707814oow.0.1700681971570; Wed, 22 Nov
 2023 11:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12299447.O9o76ZdvQC@kreacher> <CAMj1kXHpVroVqXxH72XNJP5=dYDcfBiZex2wE2jOsSFNEAYqxg@mail.gmail.com>
 <5724231.DvuYhMxLoT@kreacher>
In-Reply-To: <5724231.DvuYhMxLoT@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Nov 2023 20:39:20 +0100
Message-ID: <CAJZ5v0gMw3xsKuvS0Q26D=DPdQFtDxAMfscufMZMPVFmYC2ZhA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: processor: Provide empty stub of acpi_proc_quirk_mwait_check()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ard Biesheuvel <ardb@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Michal Wilczynski <michal.wilczynski@intel.com>, Guenter Roeck <linux@roeck-us.net>, 
	Frank Scheiner <frank.scheiner@web.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 4:00=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> On Thursday, September 21, 2023 3:09:04 PM CEST Ard Biesheuvel wrote:
> > On Thu, 21 Sept 2023 at 13:04, Rafael J. Wysocki <rjw@rjwysocki.net> wr=
ote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Commit 0a0e2ea642f6 ("ACPI: processor: Move MWAIT quirk out of
> > > acpi_processor.c") added acpi_proc_quirk_mwait_check() that is
> > > only defined for x86 and is unlikely to be defined for any other
> > > architectures, so put it under #ifdef CONFIG_X86 and provide
> > > an empty stub implementation of it for the other cases.
> > >
> > > Link: https://lore.kernel.org/lkml/c7a05a44-c0be-46c2-a21d-b242524d48=
2b@roeck-us.net
> > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/=
commit/?h=3Dremove-ia64&id=3Da0334bf78b95532cec54f56b53e8ae1bfe7e1ca1
> > > Fixes: 0a0e2ea642f6 ("ACPI: processor: Move MWAIT quirk out of acpi_p=
rocessor.c")
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Reported-by: Frank Scheiner <frank.scheiner@web.de>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > This is kind of orthogonal to
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit=
/?h=3Dremove-ia64&id=3Da0334bf78b95532cec54f56b53e8ae1bfe7e1ca1
> > >
> > > because if any architectures other than x86 and ia64 decide to use th=
e
> > > processor _OSC, they will see the reported build error.
> > >
> >
> > You mean when other arches #define CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC too,=
 right?
> >
> > In any case, this is going to conflict with my change, which is
> > already in linux-next (you were cc'ed on the PR to asm-generic). What
> > do you propose here?
>
> IIUC, the conflict is that the empty stub will be defined twice if this i=
s
> applied before removing ia64.
>
> But if it is applied on top of the ia64 removal, all should be fine, so t=
hat's
> what I would do (and tell the -stable people to ignore it).

And ia64 is gone now, so applied.

