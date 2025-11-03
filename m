Return-Path: <linux-acpi+bounces-18466-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD19BC2D223
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 17:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EB404E2DD0
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EC2316908;
	Mon,  3 Nov 2025 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofmBnPmX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47D318139
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187438; cv=none; b=jhnKqdXWw4BcBeQvy3NE7GHSmpzn2sTOEUXGRvCAOC6yZg9w2ylWiepEb064Xa+WaNACBq7i2vTdUB84fYhOU9pu6Tvy05wzZAP3ec+ynH0Pbamw4Lten+c0bt5yfwj1FLK32DUNLcXYfAgSv5Eiube8TNY/pmuh87Pv39mNh9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187438; c=relaxed/simple;
	bh=3jHO59Spn4QAaN4bMhxNmHfKwqFWC6l3wa2Li9DQ1oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gi9i/75wbeGYJkQuzCY8zyby6hZ43wupYw5NZwdcfyhM7xxElip2FDoEhHFQtvj49pZIZ3lfUvsg24r8JeDfJHjXLAIsBBKD1Vf0xr//l0SrhtWaatUfzrLQtqbszslpZl1o38nUDGkUCzcLmcKtxIFlBb51htpUtXSWnILjVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofmBnPmX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d345d7ff7so1044833266b.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 08:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762187435; x=1762792235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jHO59Spn4QAaN4bMhxNmHfKwqFWC6l3wa2Li9DQ1oo=;
        b=ofmBnPmXOeDvNaVosLFTlkpXACP+535o18d9ZkWZ140rFLY0AJ6j43ttXDkdb0T+HT
         jR/Vndkku8XfOu0lxklkLs9c/IQkt0o5HwEXqZZRPLqykPRpifpEpTSYjI5//srbEgWF
         jq6KBcBKFfTL7ba6OECRhCEcsIui6vahFEnpIqZp1ENJ5fpDiHzy/q9TSZ7ojsgcfkzC
         QeHKaIEWqbN2i3vtqVrv7tpUGHEHIKjwTRkZYBDYh+klcbad/NJg+XOHvAntdcYe8zNR
         v0TfrreHQwx/dAPPMKI+GIts+cHBL2mLZ1tfcs3N0/JqMtAngcAxy29KmDzPsHy1ZVCz
         B3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187435; x=1762792235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jHO59Spn4QAaN4bMhxNmHfKwqFWC6l3wa2Li9DQ1oo=;
        b=exxfWvlxCBPYLmCqHKSe05q/m/lp7IgcAnn/3N2RYKeDghm3fiNpOIEEJV6jUs5AoM
         aJSpDlyz+Be12r1sjPDM1IM2sGerl2xepNLCtcmzBrJsx6WtddA4LTsoDhF0kkv26ayn
         dwsoaC8PryY8+Mfo5MEnEB0PWNfZSmM202NYVRqyOJB+qxwVIxvQUVAWxBITRbaq2Hvn
         92TWMp222OLbS8F6mMDskIhTcuQzE0fq/hNRHD4iXoWYypkqmMCk3WG+7TR4vSHyvPdK
         /fIoQ8aEpyTJQ9jWoHXKg/Zh9XuviSGNZn00SOLG8z5lh05ztKGdmDplu8kNTqQqZ+L7
         yS9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXi4hvSznWMbK8m3/BrLQVgrGPsyx04YdGMHQyjOJcpnyp9y9cu04RZu19oSu96p0iuN0UD8UOiS2Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+CZhJEn05ZbpgTIg75fsAz82ALfl/3Cou9aCq4NowhZIT7zjY
	x6lRVeyVJ/qh+MvEg2G7e2SUnoBE+lfUEFwaMKiKwTmVm6BJrbxBB8kPXWDPDifiM7ceK3qi56X
	BotlffMuw/1lMAIEF3KrmjkZ/RqB1wM9ME2gPUDx1
X-Gm-Gg: ASbGncshOzsk6wgY/D84YiL1MASIA8Pnuzr1C/Wr5uh+kCPafl1NrzibXUhok95BUzM
	VbnAe5cxQJ7e/guJNFKoT2y8gQawrxzLt5UhuQrPOXrOeLNJDJCb1v/ItiidvGHq1DHg/49vabN
	DsnrCQYOift4HMnJ4IcE6ypMm0eR9cIrVxjQDSK7yRodiWGpepRn8qNIexs7FQr3iMi4CCSq3Z9
	oIsJCJR2Ert5YAOMQMLreOslySAvyHtSIvrB5mfS9oPEhSivewtDqvB7G3rfg==
X-Google-Smtp-Source: AGHT+IEazeo19yYwXbrlW+SfBjEyqX4LiokguCi4PzahYxjLvk/Xq8fmQ/+sYzRyHdMWvx9uISoizNeAkPmwtH/q/P8=
X-Received: by 2002:a17:907:7209:b0:b6d:ba71:a17f with SMTP id
 a640c23a62f3a-b705212b184mr2030477366b.18.1762187434663; Mon, 03 Nov 2025
 08:30:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com> <20251002113404.3117429-3-srosek@google.com>
 <CAJZ5v0iQToOkedruYqsowSm8=fxpnyJf86JJHB36E8+aCSZ5Hw@mail.gmail.com>
 <CAF3aWvFSomq+cm2sj+KjkYw=WODsrwH-VLDL=yOc6o9dqc5hWA@mail.gmail.com>
 <CAJZ5v0g72U3+u_KedKpZh2TuN-iYbXPcnZhN16oDvi4UqUTr7Q@mail.gmail.com>
 <CAF3aWvFc5ZZo3VaJSr68FwGuCFYJU=tXsJ6Fm1vmNLs4B=+8dg@mail.gmail.com> <CAJZ5v0gJYOcTCACj6jKYL6juAYpUvJUf89kZ6ZxU3fMOpBjFzQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gJYOcTCACj6jKYL6juAYpUvJUf89kZ6ZxU3fMOpBjFzQ@mail.gmail.com>
From: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Date: Mon, 3 Nov 2025 17:30:22 +0100
X-Gm-Features: AWmQ_bkxaBBdR7r8KnybjDiudQOBfZf1J4aHlS3iONHtKxrvEfx-n7LoFV4QQ9k
Message-ID: <CAF3aWvGN2ipXNPs_3UNppJppwo+2J1uvjVTD2tyXoQ6ATdkuPQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] ACPI: DPTF: Move INT340X device IDs to header
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, AceLan Kao <acelan.kao@canonical.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:30=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Oct 23, 2025 at 6:27=E2=80=AFPM S=C5=82awomir Rosek <srosek@googl=
e.com> wrote:
> >
> > On Thu, Oct 23, 2025 at 5:11=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Thu, Oct 23, 2025 at 4:41=E2=80=AFPM S=C5=82awomir Rosek <srosek@g=
oogle.com> wrote:
> > > >
> > > > On Wed, Oct 22, 2025 at 8:46=E2=80=AFPM Rafael J. Wysocki <rafael@k=
ernel.org> wrote:
> > > > >
> > > > > On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@goo=
gle.com> wrote:
> > > > > >
> > > > > > The ACPI INT340X device IDs are shared between the DPTF core
> > > > > > and thermal drivers, thus they are moved to the common header.
> > > > > >
> > > > > > Signed-off-by: Slawomir Rosek <srosek@google.com>
> > > > >
> > > > > I've actually started to wonder if int340x_thermal_handler is nee=
ded at all.
> > > > >
> > > > > It just creates a platform device if the given ACPI device ID is =
in
> > > > > its list,
> > > >
> > > > That's true. It creates platform device for the given ACPI device I=
D,
> > > > but only if CONFIG_INT340X_THERMAL is enabled.
> > > >
> > > > > but acpi_default_enumeration() would do that too with the
> > > > > caveat that it would also be done for CONFIG_INT340X_THERMAL unse=
t.
> > > >
> > > > Not exactly. scan handler returns ret=3D1, so device is marked as e=
numerated
> > > > https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/acpi/scan=
.c#L2314
> > > >
> > > > > That should not be a problem though because if CONFIG_INT340X_THE=
RMAL,
> > > > > there are no drivers that will bind to those platform devices, so=
 the
> > > > > net outcome should be the same.
> > > >
> > > > If CONFIG_INT340X_THERMAL is not set and there are no drivers to at=
tach
> > > > to platform devices and int340x_thermal_handler is removed then you=
 are
> > > > right, acpi_default_enumeration() will enumerate ACPI bus anyway an=
d
> > > > create platform devices for all ACPI device IDs. However, for me it=
 looks
> > > > like it was intentional to prevent this behaviour unless INT340X dr=
ivers
> > > > are "present" in the system (were enabled for build so should be).
> > > > I am not sure how DPTF works and what may happen if platform device=
s are
> > > > visible in sysfs while drivers are not loaded.
> > >
> > > Such a dependency would be unexpected and confusing.
> > >
> > > Also, I'm not sure why it would be useful because the lack of drivers
> > > means that the devices in question are not handled, so no
> > > functionality related to them is provided by the kernel.
> > >
> > > > >
> > > > > Thus I'm wondering if the way to go might be to drop
> > > > > int340x_thermal_handler and simply keep the device IDs in the dri=
vers
> > > > > that use them for device binding.
> > > >
> > > > Even better. If it's not required for DPTF to prevent enumeration
> > > > on the platform bus I can simply remove the scan handler.
> > >
> > > I would at least try to do that.
> >
> > Makes sense, so I'll give it a try. Removing handler will result with
> > only two patches, one to update dts_doc_thermal kconfig and second
> > to remove the dptf scan handler, the rest won't be needed for a new
> > patchset. Should I send it as v4?
>
> Yes, please!

I removed the scan handler and tested it on i7-9750H using Ubuntu
24.04, Linux 6.12.56
and DPTF 9.0.11402. With CONFIG_INT340X_THERMAL enabled DPTF daemon
starts without
errors, with CONFIG_INT340X_THERMAL disabled the int340x devices are enumer=
ated
on the platform bus and DPTF fails to retrieve TCC Offset on initialization=
:

2025-11-03T09:03:07.108038+01:00 localhost kernel: Consider using
thermal netlink events interface
2025-11-03T09:03:07.109139+01:00 localhost DPTF[4098]:
ERROR:[<ACTION>ActionSysfsGet@esif_uf_action_sysfs_os_lin.c#1205]<176215698=
7108
ms>: Error retrieving TCC Offset value from sysfs.

For comparison, with CONFIG_INT340X_THERMAL disabled on the pure Linux 6.12=
.56
the int340x are not enumerated on the platform bus and DPTF initialization =
fails
as follow:

2025-11-03T08:43:31.725514+01:00 localhost kernel: Consider using
thermal netlink events interface
2025-11-03T08:43:31.727119+01:00 localhost DPTF[4046]:
ERROR:[<LINUX>GetManagerSysfsPath@esif_uf_sysfs_enumerate_os_lin.c#1004]<17=
62155811726
ms>: GetManagerSysfsPathFromAcpiId failed
2025-11-03T08:43:31.727934+01:00 localhost DPTF[4046]:
ERROR:[<ACTION>ActionSysfsGet@esif_uf_action_sysfs_os_lin.c#1205]<176215581=
1727
ms>: Error retrieving TCC Offset value from sysfs.
2025-11-03T08:43:31.729027+01:00 localhost DPTF[4046]:
ERROR:[<ACTION>GetGddvData@esif_uf_action_sysfs_os_lin.c#2818]<176215581172=
8
ms>: g_ManagerSysfsPath Invalid

Link to v4: https://lore.kernel.org/all/20251103162516.2606158-1-srosek@goo=
gle.com/

Thanks!

