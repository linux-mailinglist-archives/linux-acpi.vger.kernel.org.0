Return-Path: <linux-acpi+bounces-14072-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADADDACB32B
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 16:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633DB4A0F8B
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAFA221FBB;
	Mon,  2 Jun 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKtXe9h1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B9421885A
	for <linux-acpi@vger.kernel.org>; Mon,  2 Jun 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874238; cv=none; b=TJGlcrS/LXTyZoKyY61PuOmvRv08x6kU1RIBILih5BOW4KfQBgbrxaMvKV9UWxAKDkQvvyGQpG4tLXTuyLXxTNnfCyGGHMI5h1Rf1I1yYl9cvvtUGk6aff8cyED3P6FY5t7RlWMOqzoQegqYm3rPWMVAnaE/5DDwu4oLfer7/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874238; c=relaxed/simple;
	bh=3g/I1bMDU17s2kE/FBY+ngUOOi1IOTbqjD3tyCKlzXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvmQ6p7EkCEyAKS8ZccSs2I9qahVQLvKXoiIk6bd9pXe8xephLBqNrXRG/tfNuv+WDzCrx4OzS5OF1n3ypL34R95i18Il1IttESitFfR9EJA8IxFyHuGuitscgTyKY+/Cr1zuBe7YQjO0HrmRH3SGH69TX8hjJRpNkkwsEZICy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKtXe9h1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D9EC4CEEB
	for <linux-acpi@vger.kernel.org>; Mon,  2 Jun 2025 14:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748874238;
	bh=3g/I1bMDU17s2kE/FBY+ngUOOi1IOTbqjD3tyCKlzXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tKtXe9h1As1jVKOhKB55WqtnegUw5FRdPdIK3VJE11fpFuAsQtUoBduEKARfKScGI
	 L855GrIQJItlS3dxWT4atqLREp97RSka9O+dp6a1ZigaQFQo272ZKvsYitdlSbFrEv
	 304JT8GW4c77ClnPKYGsTse8sgxivpYB5Lt+i4otYAppGvkU/ZmJInNr8YMsb1ndsa
	 RxvAQgqHbF4zIc2G8wL/bVhNvx0dYvDuwZUDH6D9K3S71SHS+P0WxB3wm4vEisaEot
	 w4G4u37r6+gXdTcOBQbho6TpFKzojDAZFuVNwd/1LecOtsshIdtEXoZ463zaYj7DDu
	 YTnuOTVs4x7fg==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-736f9e352cbso1085862a34.2
        for <linux-acpi@vger.kernel.org>; Mon, 02 Jun 2025 07:23:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YwJutjyiATpOyLAptY6zvD+zrdvQaTmZGxnk5CbSGcaoBBMwTs4
	0iq/ryAJvkTjd7+V9dwwHANPnMnvArUA8In2Qps0tj/3dTBKWm11SniGkPJfh71FsE9holml2XQ
	y56dCN7MkvFYVuzrOon+edv5TaKzweKo=
X-Google-Smtp-Source: AGHT+IGZ3nIDNi9g7H3//zwO1VO+Q7rAWOIgsZFtGi4JYfroHCVQh0VF7Ex/fZwhktwOk3gIhkfQ6X3/nn7Vvub8LUA=
X-Received: by 2002:a05:6808:7004:b0:401:e8b5:4e4a with SMTP id
 5614622812f47-4067e5418acmr6798346b6e.1.1748874237311; Mon, 02 Jun 2025
 07:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aCWbk4z50QYym9gV@merlins.org>
In-Reply-To: <aCWbk4z50QYym9gV@merlins.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 2 Jun 2025 16:23:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j0NK29+D=RjsLgmAmh7_bujA5xXoLpo--FC2Gd98RMig@mail.gmail.com>
X-Gm-Features: AX0GCFvZ9BzkvaUR2HI8y9iOAIzAv56Ga005bQ6hwuzzr4AKlIEfMiTYgVvczSk
Message-ID: <CAJZ5v0j0NK29+D=RjsLgmAmh7_bujA5xXoLpo--FC2Gd98RMig@mail.gmail.com>
Subject: Re: s2idle on kdell xps 9730 does go to sleep but laptop is warm
To: Marc MERLIN <marc@merlins.org>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 9:45=E2=80=AFAM Marc MERLIN <marc@merlins.org> wrot=
e:
>
> and burn a lot of battery during full kernel sleep
> Reply-To:
> X-Sysadmin: BOFH
> X-URL: http://marc.merlins.org/
>
>  With kernel 6.6.9 when I put the laptop to sleep, syslog shows that the
>  laptop was sleeping for 9h, fans were stopped, but when I gabbed my
>  laptop it was warm and burned 80% of the battery overnight.

First off, I'd try a newer kernel.  Say 6.15.0 (unless you boot with
"nosmt" in the kernel command line).

> And yet, linux was not running, my logs show the kernel went into ACPI
> sleep and back out

It wouldn't be "ACPI sleep" if it was suspend-to-idle.

> Logs show the system slept for 9h and went to sleep with s2idle.
>
> Is it the wrong sleep outside of suspend to disk and full shutdown?

No, it shouldn't be.

> Are there devices that should have been powered off but didn't
> (evidently yes since battery loss was 80% and laptop was warm)

There seems to be driver support missing for some devices.

> logs below
>
> 2025-05-14T00:01:20 merlin root: >>>>>>>>>> suspend  #1 1747206080
>
> 2025-05-14T00:01:21 merlin dbus-daemon[2846]: [system] Activating via sys=
temd: service name=3D'org.wicd.daemon' unit=3D'dbus-org.wicd.daemon.service=
' requested by ':1.1130' (uid=3D0 pid=3D3357435 comm=3D"/usr/bin/python3 /u=
sr/share/wicd/daemon/suspend.py")
> 2025-05-14T00:01:21 merlin dbus-daemon[2846]: [system] Activation via sys=
temd failed for unit 'dbus-org.wicd.daemon.service': Unit dbus-org.wicd.dae=
mon.service not found.
> 2025-05-14T00:01:21 merlin kernel: [1388664.621668] PM: suspend entry (s2=
idle)
> 2025-05-14T00:01:21 merlin kernel: [1388664.625122] Filesystems sync: 0.0=
03 seconds
> 2025-05-14T09:20:43 merlin kernel: [1388664.635518] Freezing user space p=
rocesses
> 2025-05-14T09:20:43 merlin kernel: [1388664.638313] Freezing user space p=
rocesses completed (elapsed 0.002 seconds)
> 2025-05-14T09:20:43 merlin kernel: [1388664.638320] OOM killer disabled.
> 2025-05-14T09:20:43 merlin kernel: [1388664.638322] Freezing remaining fr=
eezable tasks
> 2025-05-14T09:20:43 merlin kernel: [1388664.640285] Freezing remaining fr=
eezable tasks completed (elapsed 0.001 seconds)
> 2025-05-14T09:20:43 merlin kernel: [1388664.640290] printk: Suspending co=
nsole(s) (use no_console_suspend to debug)
> (...)
> 2025-05-14T09:20:43 merlin kernel: [1422225.195325] OOM killer enabled.
> 2025-05-14T09:20:43 merlin kernel: [1422225.195328] Restarting tasks ... =
done.
> 2025-05-14T09:20:43 merlin kernel: [1422225.204356] vgaarb: client 0x0000=
0000f7b9cd5c called 'target'
> 2025-05-14T09:20:43 merlin kernel: [1422225.204376] vgaarb: PCI:0000:00:0=
2.0 =3D=3D> 0000:00:02.0 pdev 00000000dec5b5e7
> 2025-05-14T09:20:43 merlin kernel: [1422225.204383] vgaarb: vgadev 000000=
00dca48b8a
> 2025-05-14T09:20:43 merlin kernel: [1422225.321870] PM: suspend exit

Well, it obviously is not a complete log.

What processor is there in your system?

