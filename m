Return-Path: <linux-acpi+bounces-6270-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9995D900C05
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 20:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA031F22D37
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 18:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACFD149007;
	Fri,  7 Jun 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gL3d+/bs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB31A270;
	Fri,  7 Jun 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786098; cv=none; b=ADcDX6v1mTXuumC4cqGAKkZyUuURI1nd6n3REnnKalfVK3TfIv+L58Qg+qiZCOWD19oXp+vsMiwZAJ1oMJ0ttz6kgxXiEZ1bSCLA3tO2HkOhYlWEcZcfoCYKLG9fLHxjCGUYID4VJasZl0OR//AYJPw81ZBaibi5glO3jEe91LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786098; c=relaxed/simple;
	bh=292CfxvmPGuyb+tMs5SvZaHZBZTxfqcwlEPRda2+kI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0z7OM4m8A6zWKVRz9l1T5gTM5frz9iLt01eiB9JIiK1SsTwwTG9Col2d+w0U4kqJ7dG+1JON0GouWwCkbHF4Z+dJk86dhuUPqbROfDEczrL2ZoF5z9Jkm4Ztz/8AYuDhFu3m6Iyyq8XOlJ+0Z6PYj5erIcnS8gG03sp+a35dCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gL3d+/bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5BBC4AF08;
	Fri,  7 Jun 2024 18:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717786098;
	bh=292CfxvmPGuyb+tMs5SvZaHZBZTxfqcwlEPRda2+kI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gL3d+/bssv5SVqtIe7zAY01xkeufkfsUsT7s+tyL4VySxqs3JDgtYadsa2q6vFM33
	 ydeheJ/+zAtkHRcD4f+xS829j0OkTY/t1cJO2OhZtB8cPNX9B7Dx8ENUDD48yPDwY9
	 7G9yQrko/ohpZBIuQ5/Xe0NAu9lwhyPwRpCSUZBU+GcFVWSrdnrjK6TnEDJNFNl467
	 z1KsWtCQe7XhOhtWbJzIfKiyvq7TcwTFCyOH7zY4LY5JtLFU+YJboTuYbhCH9kmCxx
	 VIy3Yt2um05QnvftF3Epkxu1EBjgG4m87ILlRKDrO0YznTghbwDpxDESvoEmQ65IM0
	 E2VeNnnhgMTkQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b335681e82so369339eaf.2;
        Fri, 07 Jun 2024 11:48:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1XjpZVfhcMxh6CqBr8P7TdLbbFfcdTwVazYy1VO9/dpkwZ6IP+b1MKJBHMuYPfmljtgnFLUD7WeTSFVyk0p+nMPwusJoBxhQQCuUVFgmcl5HYtBE4TbH77Kw3TTFu/wB8MHnZLbZ50UY+jVGUwkukCgCWP2SvdRXi9uS/bP+SMb6H
X-Gm-Message-State: AOJu0YwwW/LQ0SZ94dXTIqDpF2cOg05+9AmBpvUi8qNih3iLMlHw0Igz
	XZaLvAZPDaWl+YOFVudVmgbig5FvMbCbGJmMhi5KyCPmYTzGQvMxBqetgtxBE7DSd62jkL00YRO
	rH1SUul13GCidD7FjmKVkEMFyX0U=
X-Google-Smtp-Source: AGHT+IEL7OH/WeqRUrMAZsTNoGZw/iPaAVSU96WBVKUOiGZkyn9pov/OMQgKKn5VJw+LmjSdxULhpkvBM3GAi0dDhys=
X-Received: by 2002:a4a:a283:0:b0:5ba:c4ed:ee98 with SMTP id
 006d021491bc7-5bac4edef89mr1797321eaf.0.1717786097416; Fri, 07 Jun 2024
 11:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528184720.56259-1-tony.luck@intel.com>
In-Reply-To: <20240528184720.56259-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 20:48:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0joU5dzkdB6m_StXneVA9oNCpmBk8qrLvR2pGJYBBZqMw@mail.gmail.com>
Message-ID: <CAJZ5v0joU5dzkdB6m_StXneVA9oNCpmBk8qrLvR2pGJYBBZqMw@mail.gmail.com>
Subject: Re: [PATCH 0/8] PM/ACPI - New Intel CPU #defines
To: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 8:47=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
>
> These patches were previously posted in a patch bomb[1] across
> all subsystems. The core pieces of that patch bomb are now
> upstream, so here are just the PM/ACPI bits (previously
> Acked by Rafael).
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
>
> [1] https://lore.kernel.org/all/ZlYVqSlx8GLwTJEr@agluck-desk3.sc.intel.co=
m/
>
> Tony Luck (8):
>   cpufreq: Switch to new Intel CPU model defines
>   intel_idle: Switch to new Intel CPU model defines
>   powercap: intel_rapl: Switch to new Intel CPU model defines
>   ASoC: Intel: Switch to new Intel CPU model defines
>   thermal: intel: intel_tcc_cooling: Switch to new Intel CPU model
>     defines
>   ACPI: LPSS: Switch to new Intel CPU model defines
>   cpufreq: intel_pstate: Switch to new Intel CPU model defines
>   powercap: intel_rapl: Switch to new Intel CPU model defines
>
>  include/linux/platform_data/x86/soc.h         |  12 +-
>  drivers/acpi/x86/lpss.c                       |   4 +-
>  drivers/cpufreq/intel_pstate.c                |  90 +++++++------
>  drivers/cpufreq/speedstep-centrino.c          |   8 +-
>  drivers/idle/intel_idle.c                     | 116 ++++++++---------
>  drivers/powercap/intel_rapl_common.c          | 120 +++++++++---------
>  drivers/powercap/intel_rapl_msr.c             |  16 +--
>  drivers/thermal/intel/intel_soc_dts_thermal.c |   2 +-
>  drivers/thermal/intel/intel_tcc_cooling.c     |  30 ++---
>  9 files changed, 198 insertions(+), 200 deletions(-)

All patches in the series have been applied as 6.11 material, thank you!

