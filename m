Return-Path: <linux-acpi+bounces-19335-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D62C9011B
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 20:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA6D04E46B1
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 19:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA703090E4;
	Thu, 27 Nov 2025 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQt8Yeim"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457A308F3E
	for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764273502; cv=none; b=T0AMfAWe2ykYY0Mb/nmVCoQgxYi8lml8jk5gsWc84jpMdHIIAcoh8V0ZQ7R/JHQ5VQITvf+6LfvhSXX9jneCYi/ZGz9PfzCKOvX6W20GcfukM1xOue9ccnYVc5OQkhj3/RaChuXn+TsOQqwdc5Ap5RPNUIme8sWF2Yic8Gf8zmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764273502; c=relaxed/simple;
	bh=NypzB4XpXsqYQ/TLS57pCGg8eK82SNtDGbjRfaKyuqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rltcqchzjRna4H62EwBoLT/ZK9jOSXlyhCgAEGoUuIXUkOpMNDLJywWkrKe7n9yUf2+M+uZwkQK+aIbVE1isauNh5YMruGkXXo5iclqMlvq521JoSzPdzZbwJolO1X5yLH5u1uom7HrvvYjHvrCY7311RyjF80xlepZWPumMDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQt8Yeim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E41EC19421
	for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 19:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764273502;
	bh=NypzB4XpXsqYQ/TLS57pCGg8eK82SNtDGbjRfaKyuqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oQt8YeimMGSR/QaJo5gl3qKMt1Z3nYXKj2pIGs1AX+jiJJ0JoFE6aEPigF/TWasG6
	 13hnhSBQqqa3d5kCditmANv7cf/uxzkSi9lTOKQlCeI56sXE7s9Z0EzDLhsvE3IO2S
	 rXE69tPbT4gkgeNUtt4pPuIhimUolzu8puQUPxWdDei8rdZYt9hvjhJvABd6+9m/Vv
	 OydXZDLLyQyleQZaHZJ82YMFhqCiFJrJlXNx3cC3ygjQBwhcZsD+uGdmJqde+uOd2r
	 YfyLUWnb74xOk/DJgxRiOZM2adqYHBPpWVBdskCxd5wTLJ32q+zMWhWgh1KW3TE8Gn
	 yBbs9GJfSzv8A==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6592f1f55a8so220994eaf.2
        for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 11:58:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvaxpk9B2jCUl95riNGWgSPDSve96hrHe+wA/UxcHofu8kYvVPS+XvoKmAK7C6Du9NoRVywqArRv3B@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHFExpNkwwLvHUoOSN2fFmAjjvjgbwY4rVUqbNoNgfbXVMQ5/
	KEjRaKiZ4bK1IUX/MC1h0Hbh2O+vWYwaY00mSNmMHuJrLLA4hNBFlacPXLUhJZMcHD163jWgiND
	LXHIXgwlT4EiDQEr5wk/Zm+2DpZcQXSo=
X-Google-Smtp-Source: AGHT+IG+0vD8fWiJ2QFk+LEX/izPtynlhYMKPpuSFTRn/J0jisth1WFTC17352PST/POWu7uRslhp+Jrz+uxZQybO08=
X-Received: by 2002:a05:6820:c94:b0:657:5da2:5f5d with SMTP id
 006d021491bc7-65792506028mr9257011eaf.3.1764273501562; Thu, 27 Nov 2025
 11:58:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0g6c1HNbxxh088xh_nTgD-SE6c2qtDr81AgD1+by-jnKA@mail.gmail.com>
 <1ea445d0-0949-4a28-9f76-325861a3c57f@huawei.com> <7487e99d-421b-4ac5-bb77-e61c3131bb13@amd.com>
In-Reply-To: <7487e99d-421b-4ac5-bb77-e61c3131bb13@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Nov 2025 20:58:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ij7XizsUkhGRMy_1pqjCAjsHfjsBCuvVarExGGMknPEA@mail.gmail.com>
X-Gm-Features: AWmQ_bleYk_cqqYErWzDjm5JFxLiI5H7dcyQTR2RGkLXX_o75f5vzC6KaIcdiwA
Message-ID: <CAJZ5v0ij7XizsUkhGRMy_1pqjCAjsHfjsBCuvVarExGGMknPEA@mail.gmail.com>
Subject: Re: [GIT PULL] Urgent ACPI support fix for v6.18
To: "Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: "lihuisong (C)" <lihuisong@huawei.com>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kprateek.nayak@amd.com, dhsrivas@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 27, 2025 at 8:03=E2=80=AFPM Longia, Amandeep Kaur
<AmandeepKaur.Longia@amd.com> wrote:
>
> Hi all,
>
> On 11/27/2025 7:39 AM, lihuisong (C) wrote:
> > Hello Rafael,
> >
> > =E5=9C=A8 2025/11/26 20:54, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >> Hi Linus,
> >>
> >> Please pull from the tag
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >>   acpi-6.18-rc8
> >>
> >> with top-most commit 43ff36c4a5a574ee83b4b0d3f3d74f09a3a8c2d3
> >>
> >>   Revert "ACPI: processor: idle: Optimize ACPI idle driver registratio=
n"
> >>
> >> on top of commit ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
> >>
> >>   Linux 6.18-rc7
> >>
> >> to receive an urgent ACPI support fix for 6.18.
> >>
> >> This reverts a commit that attempted to make the code in the ACPI
> >> processor driver more straightforward, but it turned out to cause
> >> the kernel to crash on at least one system, along with some further
> >> cleanups on top of it.
> > I just found that "ACPI: processor: idle: Optimize ACPI idle driver
> > registration" depends on the change
> > about cpuhp_setup_state in the commit [1]. Or many CPUs don't create
> > cpuidle directory.
> > What is the crash? Do you have releated trace?
> >
> > [1] https://lore.kernel.org/all/20240529133446.28446-2-
> > Jonathan.Cameron@huawei.com/
>
> We have observed the same issue. After booting the system with the
> latest kernel, the sysfs path /sys/devices/system/cpu/cpu*/cpuidle does
> not exist. Bisecting between v6.18-rc7 (good) and master (bad) led us to
> the following commit:
>
> 43ff36c4a5a574ee83b4b0d3f3d74f09a3a8c2d3 Revert "ACPI: processor: idle:
> Optimize ACPI idle driver registration"
>
> After debugging, we identified a code change that resolves the issue on
> our systems. Below is the code diff:
>
> diff --git a/drivers/acpi/processor_driver.c
> b/drivers/acpi/processor_driver.c
> index 7644de24d2fa..65e779be64ff 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -166,7 +166,7 @@ static int __acpi_processor_start(struct acpi_device
> *device)
>          if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
>                  dev_dbg(&device->dev, "CPPC data invalid or not
> present\n");
>
> -       if (cpuidle_get_driver() =3D=3D &acpi_idle_driver)
> +       if (!cpuidle_get_driver() || cpuidle_get_driver() =3D=3D
> &acpi_idle_driver)
>                  acpi_processor_power_init(pr);
>

Thanks for this information!

One more commit needs to be reverted which I have overlooked:

8a1b5d412cb4 ACPI: processor: Update cpuidle driver check in
__acpi_processor_start()

It was a fix on top of 43ff36c4a5a5.

My bad.

Linus, I'll send a pull request with this shortly, but you may as well
revert it yourself.

