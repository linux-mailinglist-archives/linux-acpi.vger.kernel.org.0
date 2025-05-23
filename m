Return-Path: <linux-acpi+bounces-13869-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A6BAC2941
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 20:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048304A46AA
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 18:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18287296D37;
	Fri, 23 May 2025 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJyv9dAo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045A293B5C;
	Fri, 23 May 2025 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748023381; cv=none; b=s1FGQNK/X7mcqAsTtBkIqhMpgj/Pv3B099wgs3hqgvoo13x0qjUOLb6Dyn1sBd6MKsY2RwB1VBAaGHJWs2DHWPc47iAvvAO4nb8fSYVJxD4MNilH4IXijf4Iu/apS3CgRSrokej1U4b+yMaLDNg91sIzjHILFsG/BenK0+RVdSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748023381; c=relaxed/simple;
	bh=d/CZd0yu4Tfmli9qaZ+EAbiupvzbLXWHymbt3P4VdII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RANoZHGQlvvZ4vfEeqE2NVr9778O/Jcy4UD5OzuPpDfyIsfCV5awoZPeqmvpfQaWWzlqVfFOSiugqnh+pVV/sIznuqW+fWphJxyFwzBStmXeORoYXWrL5DDDCOZiFKkIIrk91W1rb8q75eUnH4WpIG4y8yFA5/HbRiNFCIoa+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJyv9dAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614F1C4CEF0;
	Fri, 23 May 2025 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748023380;
	bh=d/CZd0yu4Tfmli9qaZ+EAbiupvzbLXWHymbt3P4VdII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dJyv9dAontErDkYUzz7YcVksv/4K1fjKNKEqmNTEdsrXrhx6GZBefVWBR/ONj4G9L
	 7mnYYWQD4GbLvfyCQPytweMVlA2R6gmLu8xJxZBM8TKyEk3CZAEvMwze8e+6tiWI0u
	 a9s5h+vJsdXGWr5IvEYwbXmNjrbInxoFKO5TJ5Qm+4ZsrfaQx9Yr6uPTVN0YhFJ1qe
	 7incrf3DrcL3uG+KssHmfmXYhhUby8qzSu7bJiH8QKtQbXwvi/s5u2Ek3IvIK8tagV
	 3ZBrGwaKzgHw+dRPbUImbo3NrkevH0uJWgPm56683xWWKW/wWMHfXvuqzgOyIxpO6X
	 3mFyiAWdKgKPA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6021e3daeabso86546eaf.3;
        Fri, 23 May 2025 11:03:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWc8bKQ9jTZorhpZnWjoLsDw2y4Nw37D4NEndufUOkquEvMtGdSUwCvHJ8FTjjsxBOZbMIbunsc5Av3TQ1m@vger.kernel.org, AJvYcCXWuvSxtAGv2EUNimr/y9Bo3Z2+Hzqq+e6i55ibQ5VSkTRPjVBu58qEYkiTxhe8RWSTjPIz8CUEwSfg@vger.kernel.org
X-Gm-Message-State: AOJu0YyiTY+u6WFzpB1D2pgcda6kl9IaMW70HGRojgrdrFGozOquQ8I8
	QmTxuH5dMZIjaow8o/HMUMMJAL6KP9ZLa/hLUz6Kjnn2896o4ArcvaZAzJILsz9f7mp5yGjWUeo
	LYTj5+IHH+U19emYJLlMuD0mGibDDzOk=
X-Google-Smtp-Source: AGHT+IHO+WmOp6+ClNzeFqNALypAVMWRWVOjEcyjqnL7SpjjuFzAlk0SEmsYCUGJyAKxsqTmackVJW+bb/DihV1b1hk=
X-Received: by 2002:a4a:ee83:0:b0:60a:383:dbce with SMTP id
 006d021491bc7-60b9fba5da2mr184657eaf.8.1748023379682; Fri, 23 May 2025
 11:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518185111.3560-1-W_Armin@gmx.de> <CAJZ5v0hNmMtR4V0tYqD1dV2BqAKJ2sCOyBadkVtG3sS3V90uvw@mail.gmail.com>
 <a6d92cdd-4dc3-4080-9ed9-5b1f02f247e0@gmx.de> <CAJZ5v0icRdTSToaKbdf=MdRin4NyB2MstUVaQo8VR6-n7DkVMQ@mail.gmail.com>
 <20250523162917.GC2575813@robin.jannau.net>
In-Reply-To: <20250523162917.GC2575813@robin.jannau.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 20:02:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0haWTB92-r2UHmpc8JXh69uOHaS4qZUG3MyhqFLw1kOTw@mail.gmail.com>
X-Gm-Features: AX0GCFsZOxg8jr12u1v3p7beV2tEpMQJn0GmiDUBSpRPv_VoOG5AEbtWuQ_8NuA
Message-ID: <CAJZ5v0haWTB92-r2UHmpc8JXh69uOHaS4qZUG3MyhqFLw1kOTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: platform_profile: Add support for non-ACPI platforms
To: Janne Grunau <j@jannau.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <W_Armin@gmx.de>, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 6:29=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:
>
> On Fri, May 23, 2025 at 04:39:59PM +0200, Rafael J. Wysocki wrote:
> > On Thu, May 22, 2025 at 6:34=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wro=
te:
> > >
> > > Am 21.05.25 um 22:17 schrieb Rafael J. Wysocki:
> > >
> > > > On Sun, May 18, 2025 at 8:51=E2=80=AFPM Armin Wolf <W_Armin@gmx.de>=
 wrote:
> > > >> Currently the platform profile subsystem assumes that all supporte=
d
> > > >> (i.e. ACPI-capable) platforms always run with ACPI being enabled.
> > > >> However some ARM64 notebooks do not support ACPI and are instead
> > > >> using devicetree for booting.
> > > >>
> > > >> Do not register the legacy sysfs interface on such devices as it
> > > >> depends on the acpi_kobj (/sys/firmware/acpi/) being present. User=
s
> > > >> are encouraged to use the new platform-profile class interface
> > > >> instead.
> > > > So how does it work in this case?
> > > >
> > > The platform profile subsystem also exposes a more modern class-based=
 sysfs interface,
> > > see Documentation/ABI/testing/sysfs-class-platform-profile for detail=
s.
> > >
> > > This interface does not depend on /sys/firmware/acpi being present, s=
o userspace
> > > programs can still control the platform profiles using the class-base=
d interface.
> > >
> > > This will become very important once we have platform profile drivers=
 not depending on
> > > some sort of ACPI interface. I suspect that sooner or later some driv=
ers for the embedded
> > > controllers on ARM64 notebooks (devicetree!) will register with the p=
latform profile subsystem.
> > >
> > > Apart from that this allows input drivers using platform_profile_cycl=
e() to work on non-ACPI
> > > platforms (like ARm64 devices using devicetree).
> >
> > This driver though is located in drivers/acpi/ and depends on
> > CONFIG_ACPI.  Moreover, the platform profile provider drivers need to
> > select ACPI_PLATFORM_PROFILE so it gets built.  This means that there
> > are no non-ACPI platform profile providers currently in the tree.
> >
> > While the observation that the code in the driver, other than the
> > legacy sysfs interface, doesn't really depend on ACPI is valid, if you
> > want it to be used on systems without ACPI, it needs to be properly
> > converted to a generic driver.
> >
> > For now, it is better to simply make it fail to initialize without
> > ACPI, so I'm going to apply this patch:
> >
> > https://patchwork.kernel.org/project/linux-acpi/patch/20250522141410.31=
315-1-alexghiti@rivosinc.com/
>
> That unfortunately does not help with the hid-lenovo regression. Commit
> 84c9d2a968c8 ("HID: lenovo: Support for ThinkPad-X12-TAB-1/2 Kbd Fn
> keys") added a platform_profile_cycle() call and thus a dependency on
> platform_profile.

And so on ACPI because platform_profile depends on it.

> hid-lenovo is used for USB and Bluetooth devices and
> not just for Lenovo laptop/tablet specific devices.
> Above patch just avoids the warning splat but still prevents loading
> hid-lenovo when ACPI is enabled in the kernel (like Distro kernels) on
> a non-ACPI system. This breaks devices like "Lenovo ThinkPad Compact
> Keyboard with TrackPoint" on such systems.
>
> I will send a patch to remove platform_profile_cycle() call as short
> term regression fix and tell the original author to to resubmit once the
> platform_profile dependency on non-ACPI systems is worked out.

Sure, thanks!

