Return-Path: <linux-acpi+bounces-13052-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5EAA89F9E
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 15:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1FF4424E5
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3369D1509A0;
	Tue, 15 Apr 2025 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZ3MAWVy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051DB76025;
	Tue, 15 Apr 2025 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724251; cv=none; b=fj5RElY4jyypvOjOTzQBwRcod+6tGmPb7lHg6qO/MDjynhan+raSP+7XgMkq7TL/QbLvdeHckX+vKi71kkSPGsnWWVN8fG+gzaYkdAtlWOpJXEeGkO9ykPuKGgopxZRporoOMgm+eejvRgybxLTiodKsqUeT10p9Gug1YYUPhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724251; c=relaxed/simple;
	bh=d65VUzC+gp0Nh/nz0QJI3UYVT/j3ah8Q+Pab3E0+gx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvverYo9vAKlLZYHJ5b/F5vQJJDxtjDkg2x/dqNcS3rmaMvzM+Uh8NYyheymyOnQF8CQDTCpcbGHJyLUht79L0hXRPg9njy+EX+bmqLHfVSbvcL4HeA9WtXZM9Y9Vfa7UwU57+fK+3sQqXK41+8LqfQ/a3dIv1IRV6yMUof+PrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZ3MAWVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF72C4CEED;
	Tue, 15 Apr 2025 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744724250;
	bh=d65VUzC+gp0Nh/nz0QJI3UYVT/j3ah8Q+Pab3E0+gx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jZ3MAWVy4NxoEgJ5I6vU9WoYaGTrL+teTgbhpWy3uJjS+/dfLfHyq9DP1VML3KCjs
	 T0unwOlVE5P8fnTPiWxuDwHueSThfr8ZdgxSce6O42dlQBGyddQnbfdPAKpG/9YjOb
	 N9RlVZNSqCKMWbxAUd/xLBbVMR8dlBEWUv7vX0b7Kfb32znr8dl9H0wLYW4WKxtRDt
	 5jtcH+9le5Cib7lVZtFo932Im7uj3PIubvMIXrMnuviCMDr1/UwCW4CiZxbjNy+NOW
	 j2Y8L4iWEzwX5K/ijWf8K3KZZWnW9FA5N8pOxkbvirGJNSKL8lyL73rqXcrFubzPpN
	 t83W3B83lbQ7g==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72bbd3a3928so3126313a34.2;
        Tue, 15 Apr 2025 06:37:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMb8Bt8nEDAJ+CfD6PaivysoCm+zlc0480njCb0ZXP1vBEHmDnIAHDJkBSPEz6Gg/VD0iGWpK86M8jhTcz@vger.kernel.org, AJvYcCVV4d9TyEUQ4xqeMN5UNSLVf/zcQjMMuN/hpJ+ajYQlGwPJg96ACRxg1yTZ/w5wQ0yxBNg8muSfyiB7lQ==@vger.kernel.org, AJvYcCXvrvWWbX+DFCaem2TGycCQiSQiJjzPjuCp00nC+gQ9pfVhMASmlZQe5GOKsCp0agyHzl/vgqiwwfpP@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8INOw/QHEqft4soyKMVTOiLqJJl77oprZx4ciBvAV/PK2ugS
	BDnR4G7fz6V0NLMWNXaEEedeczt2hxssGFkJSZdzRn5mIjFNsDz3ceehvX0UNhupwsBAx8+vmxy
	j+F0JB1aJ+In5eHcyAbdiF+LKOqo=
X-Google-Smtp-Source: AGHT+IE11JHCuqB8/U/WeGs4WYMQP6FxuDrC1VzqUKMC/KmA1BTT2oGZxuLY2SD5Zv5UI0sP7/8+OclGGWeWdB/IuNU=
X-Received: by 2002:a05:6830:6408:b0:72a:f44b:13ed with SMTP id
 46e09a7af769-72e862dedd1mr10259803a34.2.1744724249784; Tue, 15 Apr 2025
 06:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414203551.779320-1-superm1@kernel.org> <CACRpkdaHru55wo5MdVsRKRbfPS9Hv3vGxgXNi8eXGvAOQzyDww@mail.gmail.com>
In-Reply-To: <CACRpkdaHru55wo5MdVsRKRbfPS9Hv3vGxgXNi8eXGvAOQzyDww@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Apr 2025 15:37:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h_Qc2xukPMmwHr-E1HvMwSoLT4TM96aV0e9QKfeRSGGQ@mail.gmail.com>
X-Gm-Features: ATxdqUFHl1qbyTf4tzc_yiGREMeHFSI_-MloFKLcN4qBhZNpu4QBPLLAtFtlKEw
Message-ID: <CAJZ5v0h_Qc2xukPMmwHr-E1HvMwSoLT4TM96aV0e9QKfeRSGGQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: amd: Fix use of undeclared identifier 'pinctrl_amd_s2idle_dev_ops'
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mario Limonciello <superm1@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-acpi@vger.kernel.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 3:34=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Mon, Apr 14, 2025 at 10:35=E2=80=AFPM Mario Limonciello <superm1@kerne=
l.org> wrote:
>
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > `pinctrl_amd_s2idle_dev_ops` is hidden under both `CONFIG_ACPI` and
> > `CONFIG_PM_SLEEP` so the functions that use it need the same scope.
> >
> > Adjust checks to look for both, and while updating make it CONFIG_SUSPE=
ND
> > instead as that's what the acpi header uses.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202504100420.88UPkUTU-lkp=
@intel.com/
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > v2:
> >  Use CONFIG_SUSPEND instead of CONFIG_PM_SLEEP
>
> This seems to be based on the previous fixes merged by Rafael?
>
> Do I need to rebase on -rc2 or something to merge this patch?
>
> Or can Rafael queue this too?

I can.

> In that case:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

