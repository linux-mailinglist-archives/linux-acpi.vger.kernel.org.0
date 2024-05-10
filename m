Return-Path: <linux-acpi+bounces-5743-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E768C28DD
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 18:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB11D1F26B15
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDC6168B1;
	Fri, 10 May 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz3BRG37"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85978134CC;
	Fri, 10 May 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359320; cv=none; b=Ozyv4vexuBctK0pORGErpYUoSg7Hom3nzgNkzfgpiR8YIBO3iZBhoUFD0nxF7a8Mv0oZdWp4ZEw7rDBI2hXcVH6DADebTQKLCrXg7H5ihgjW8XMZHdshD4UeUJ70grs8lj5SqeT3NpdUGTyZ9owxMnW5NMQaM+lTGZgQBYdTFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359320; c=relaxed/simple;
	bh=ygyighZLCuqVcaU8l/9kZcic3nWIHgkYfGhPv0f8hkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJHJ2SmUhy0CMFLOvY304lwC4wCHU7YQ4XTxr8IDq657IpjuaSIqiG0eRDZFcszvKsVrqXhh5WVR7UE/kh+1WFY3e0jbQFEpssFgU11+uMkUmzLthShQMU7sFXq9IOlbE8/5DzTM4bFDBRDKIXDD8xHWJayBM6P3OKEK+bNzv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sz3BRG37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E84AC2BD10;
	Fri, 10 May 2024 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715359320;
	bh=ygyighZLCuqVcaU8l/9kZcic3nWIHgkYfGhPv0f8hkA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sz3BRG37uQSQUrUbmiZDBnTugn48pGoTMogovsy6PlJ0Ay1R87wj6OKL2dOl6EzeK
	 9imWJw0SJriBsHda8wb8gjlk1oPlMQkkcZP/bSHFuTv7zwir0qIWiHiesMoy5rsnod
	 POMWy/NRt8nX2ouMYYosZljLE69JNM9Y7gAYYIMB89Kl4bQTeghOsunYmNUJD0XPA/
	 cqjMmKNWZ1uywV664fXLqJLsrbZtBsDDt8Zhub5Oi2Nk2i/IZV1QHPHMbOkAZasVSR
	 pjpmiIxlrvE8bBy883e10VQ0hGGGQpCGuxOdhpYZIRlro7FqQWQ3Bo4h3ISj2Habaf
	 paE/NPfT2R3hg==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f0e6015834so297780a34.1;
        Fri, 10 May 2024 09:42:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrCJwnpPYCiBsMoKzCZEhVklMIODVD4wkZOfsZG0upIpl7PBrE1ya+YrTyKcCiHn42HoW2SiIa5bXcnVJM6QZZTJkLTEY7fGjGC9/V40jtXLO7oqxfgFRalEp0g0Tyz/DkcrQN7n4tog==
X-Gm-Message-State: AOJu0YwEud5DPIC9/78LX7T4yMF8gg2MY+y7twIg1KAc8fBc44/eNpju
	oYOgNn4AkpSQyUSIJibrNTcb+L13ZN0dqJiYVTIPsL7xgecUZuvZ1m0YLl0m6EEYCd8rZMpZIOQ
	IUOQyRl7RLzk/xCtsiLHAXGhOLpU=
X-Google-Smtp-Source: AGHT+IFnZ9zTd+6jUzv/qLGuCCZRmMd5oksM3vdxHhHa5KbgqFaLRN2ld3dHJFCj+3f0QOABa2qovNrCsyPO/vHvX8k=
X-Received: by 2002:a05:6808:f03:b0:3c8:2af6:1125 with SMTP id
 5614622812f47-3c997036e42mr3561264b6e.1.1715359319438; Fri, 10 May 2024
 09:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5787281.DvuYhMxLoT@kreacher> <4926735.31r3eYUQgx@kreacher> <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de>
In-Reply-To: <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 May 2024 18:41:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
Message-ID: <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 6:10=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Lenovo
> > IdeaPad Pro 5 due to a missing address space handler for the EC address
> > space:
> >
> >   ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [Embedded=
Control] (20230628/evregion-130)
> >
> > This happens because the EC driver only registers the EC address space
> > handler for operation regions defined in the EC device scope of the
> > ACPI namespace while the operation region being accessed by the _DSM
> > in question is located beyond that scope.
> >
> > To address this, modify the ACPI EC driver to install the EC address
> > space handler at the root of the ACPI namespace.
> >
> > Note that this change is consistent with some examples in the ACPI
> > specification in which EC operation regions located outside the EC
> > device scope are used (for example, see Section 9.17.15 in ACPI 6.5),
> > so the current behavior of the EC driver is arguably questionable.
>
> Hi,
>
> the patch itself looks good to me, but i wonder what happens if multiple
> ACPI EC devices are present. How would we handle such a situation?

I'm wondering if this is a theoretical question or do you have any
existing or planned systems in mind?

ec_read(), ec_write() and ec_transaction() use only the first EC that
has been found anyway.

