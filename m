Return-Path: <linux-acpi+bounces-11810-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A477A4EE3D
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 21:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FA2174D71
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 20:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4291F8BBF;
	Tue,  4 Mar 2025 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBq7QAEN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7508B2E3377
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119648; cv=none; b=M3bm7xWNWjHP5iHzZhDNCiMyK7/QQndY8FGdvW4eeZQ7af1OrV7sz2q1iOrSQGmkm76g7rkwEg2ldr+7aTEeah9i/VhReusBeDug6c+HMFjJdRtNDMY07tNwsG0T/6h35kAouLzt3Z8FvPeO5avrMrLHQTjabqhJNHgJT6VA0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119648; c=relaxed/simple;
	bh=7F6+kPqAM2RHixOz2p9ZDtoRhIYQG9CexTeaFAtDvbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mazUE8vTfD0e3ohn3g+XbF2cRMURNC6Nbl26X+LnjgBxnv1jv7FcTyGv+5HqgjIh+1IuMZ9/upSF39IcyWwED/ubZyR25pERKhZJDvil7sWjeGAOf1Sad8zD5Q7iI1t0jje5E25tZGxK/BleMs68PRtaG33IjQmYH6OfKOG2Z/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBq7QAEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BE0C4CEE5
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 20:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741119648;
	bh=7F6+kPqAM2RHixOz2p9ZDtoRhIYQG9CexTeaFAtDvbk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IBq7QAENYWLPoE7EmbwSPFhYPG48b0P5l+rO3mX3nEZY9hySMTHolMuq9O1RYkWHI
	 hVr8/h57TzIHuABWavJ5CouBDsPyFh5JOrB2LpvMxOmUJOmNq388NTJ/SPszfZuhSz
	 DslfT40IMNNuKFbb3YqSsUDvsJaiuYx/2PTqgh9ONLC/WDMeGgXfiyX4hZuYndig74
	 BAnYd8klJEa+9Gd3aql0qmdN/LjR9dsZGAXjFY94kiqsxV+qsa7oIF4A08aK8a8xC/
	 B2a7sih/nz586QbdN+pVsCoX8Ivag+egWsDX9mwD2YZ32a5TP181eNbbYgFP9keDYH
	 SAZEFnOlIzwGw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5fe9c1c14baso3609133eaf.0
        for <linux-acpi@vger.kernel.org>; Tue, 04 Mar 2025 12:20:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWENZlTnvCY24gHm3V9KehdpeJVoLh9XJGg0J32sNSldQ5yRR+aGm9QDVKhEe6ZF2p/jLNH8sFXGcBP@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/oWwhFYl0InFRnUY5RRkMs+r1d3mYXXFbAH3o/LbUmalGVaj
	3O2X2V3xm3O4NFDB9Znfoo7GRE+rotm5velF/NdFuD4cVjkY21iAKdZEn1kyMGluF7BaPv/+K3Q
	YOOJa7+0VFFbhA8XQQB8weOl9SZQ=
X-Google-Smtp-Source: AGHT+IFssR0tUEzh+6yY8aX0nP10xMknm+3iRA+aq53pCPuHQKlEBy0XR3x4bV+G32AbZkH8OZSoiQts/DF+xKjzucU=
X-Received: by 2002:a05:6820:1b1a:b0:5fc:b7f4:c013 with SMTP id
 006d021491bc7-6003358e57dmr231607eaf.5.1741119647577; Tue, 04 Mar 2025
 12:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303212719.4153485-1-superm1@kernel.org> <BY5PR19MB3922B4FC2D390A15CBE389C89AC82@BY5PR19MB3922.namprd19.prod.outlook.com>
In-Reply-To: <BY5PR19MB3922B4FC2D390A15CBE389C89AC82@BY5PR19MB3922.namprd19.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Mar 2025 21:20:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g16-kz1_PfPG+YC3DpUSuZVa4_cBZfCPy39PRR+31LEQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrJdhFjgC3aarzzZNidLg5uttozau2HKtPFLuQnnnzCyY5l20hxkggYcaQ
Message-ID: <CAJZ5v0g16-kz1_PfPG+YC3DpUSuZVa4_cBZfCPy39PRR+31LEQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: button: Install notifier for system events as well
To: "Shen, Yijun" <Yijun.Shen@dell.com>, Mario Limonciello <superm1@kernel.org>
Cc: "Limonciello, Mario" <mario.limonciello@amd.com>, "Richard.Gong" <Richard.Gong@amd.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 3:45=E2=80=AFPM Shen, Yijun <Yijun.Shen@dell.com> wr=
ote:
>
>
> Internal Use - Confidential
> > -----Original Message-----
> > From: Mario Limonciello <superm1@kernel.org>
> > Sent: Tuesday, March 4, 2025 5:27 AM
> > To: Limonciello, Mario <mario.limonciello@amd.com>; rafael@kernel.org
> > Cc: Shen, Yijun <Yijun_Shen@Dell.com>; Richard.Gong
> > <Richard.Gong@amd.com>; linux-acpi@vger.kernel.org
> > Subject: [PATCH] ACPI: button: Install notifier for system events as we=
ll
> >
> >
> > [EXTERNAL EMAIL]
> >
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > On some systems when the system is put to sleep pressing the ACPI power
> > button will cause the EC SCI to try to wake the system by a Notify(DEV,=
 0x2)
> > with an intention to wake the system up from suspend.
> >
> > This behavior matches the ACPI specification in ACPI 6.4 section
> > 4.8.3.1.1.2 which describes that the AML handler would generate a Notif=
y()
> > with a code of 0x2 to indicate it was responsible for waking the system=
.
> >
> > This currently doesn't work because acpi_button_add() only configured
> > `ACPI_DEVICE_NOTIFY` which means that device handler notifications
> > 0x80 through 0xFF are handled.
> >
> > To fix the wakeups on such systems, adjust the ACPI button handler to u=
se
> > `ACPI_ALL_NOTIFY` which will handle all events 0x00 through 0x7F.
> >
> > Reported-by: Yijun Shen <Yijun.Shen@dell.com>
> > Tested-by: Richard Gong <Richard.Gong@amd.com>
> > Link:
> > https://urldefense.com/v3/__https://uefi.org/htmlspecs/ACPI_Spec_6_4_ht=
ml
> > /04_ACPI_Hardware_Specification/ACPI_Hardware_Specification.html?highli=
g
> > ht=3D0x2*control-method-power-button__;Iw!!LpKI!m8bmT5JUyck9Q0BMUA-
> > LmC5MXTEXFeJ1nmcNGIhJ4AWCQ7XMUR_UqxaxBor674mhMk53MkwkXqT1a
> > cTF$ [uefi[.]org]
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Verified the patch on the issued system, the issue is gone.
>
> Tested-by: Yijun Shen <Yijun_Shen@Dell.com>

Applied as 6.15 material, thanks!

