Return-Path: <linux-acpi+bounces-10953-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 587D5A2D7EB
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 18:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867521887219
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D4D194C6A;
	Sat,  8 Feb 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2UdqEj5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B644A241103;
	Sat,  8 Feb 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739037594; cv=none; b=XnsVgIIUr+2xP1R3IRc736kDN5qLdgPZesugf8/FNE9udFZQlBQfXI3V9XH6XLxI39MLDPKztS6gnIJI/9hoLJoiIcwWJTtlNpKTacugPjCweoWmLGrWpx91JRXK+ZDj9X1wBCNyhTc32e9pIXjhSiQX9SlaD3F8bXz+qA771jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739037594; c=relaxed/simple;
	bh=KzldU6J3Gf92ol1FiAe0esXgaxmHztRlUH2ond0TeGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eb2Wiej3ezpzcOGoFT1OA2AcaAzIW2ge3NxtLkToWJihI2AELOtc2sDKaSVazo1019Dj6VosWNhrbZgHLboRyMuMiHDo1+MYcWNaUYi0XCUyp0TsRafcchowhZjLhn7E1gaHrrbqqTLK69A4NFvNJF7g5jcY5SIT7duR/8H0SM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2UdqEj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9454BC4CEE5;
	Sat,  8 Feb 2025 17:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739037594;
	bh=KzldU6J3Gf92ol1FiAe0esXgaxmHztRlUH2ond0TeGU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H2UdqEj56IGWeuD2b03UdqtVadyL71uLR21cIJ4INfcc0hIgVPJEaI9AXmQ+LTnLu
	 7v76Zy6MnBHpPQTI4aT2UTmoMy3Z7DnB2WgF/H31Y8LUu6Og4/jXqrw6sgQgOydtT+
	 AvP093TNQ8djdWsS3R+D9wBGm4ClLqfyMICg2gY6dP6SJ18IpyF+fMIam8Su5plt+Q
	 7M0GBQCE9WrBZDbSuDxgzlc3/FNvFSYK6B0JWCxg0IoNy7SSP+zSdt6UAQnPlo4Gju
	 25E4rYE3r3pSUx6n5YtRNEkU/KGTbBn8AxAgact8zfNB9fSkFr3x9+PtNWHu6PWWQG
	 xmkgGBvpBch4Q==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eb6b16f1a0so872069b6e.3;
        Sat, 08 Feb 2025 09:59:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeYzsrWmCJH/KqHqkDUBdGT8mdX9Nu7CXHx+BKDRWeZhZSFAkU73/PVd3hkTAHZizGszYAO3rV+q8=@vger.kernel.org, AJvYcCXjkMTcldBkFt1zpFAHiBu3JArVQrE9cemPFWLyvuBpSt03ZJ+ZttGALzfkOMuWkn1zGNySpIUzZ1O0@vger.kernel.org
X-Gm-Message-State: AOJu0YxKbYiB8qt+lFCZrcQGpP6ybMeE02mVMzgGOHYzJwe3FyTX/mE7
	HmXJ8t8vTB7F7E1j1UrogQcZ/PpMgXVoCUF9qZ6LRePuomVYOb7SBYAFdleD3Gg+P6il09SQTVQ
	v8t0TVpyUMHgOG9PSJOJAnNyAWhk=
X-Google-Smtp-Source: AGHT+IFPssbwoiV4Dp4g+8lPMXJlr6LWvEGUm0t2cz6ZLx7bISc7fzClJHiUVDDA2YY7IssmH7MbqWKE3d0J1ZIaejg=
X-Received: by 2002:a05:6808:80c4:b0:3eb:4a36:8744 with SMTP id
 5614622812f47-3f39230d6acmr5473984b6e.17.1739037593891; Sat, 08 Feb 2025
 09:59:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208162210.3929473-1-superm1@kernel.org> <20250208162210.3929473-5-superm1@kernel.org>
In-Reply-To: <20250208162210.3929473-5-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 8 Feb 2025 18:59:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j4+8nqQRtcAihpVgOHWUPE54nTWienCpFk1U7easVPnA@mail.gmail.com>
X-Gm-Features: AWEUYZkaLUPUFCPmsO46FDgRZ-V6E8IG6u6q_QSweKo5UGiMK6sG_h_aCT0apN4
Message-ID: <CAJZ5v0j4+8nqQRtcAihpVgOHWUPE54nTWienCpFk1U7easVPnA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ACPI: battery: Wake system on AC plug or unplug in
 over s2idle
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 5:22=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> On Windows the OS will wake up when plugged or unplugged from AC adapter.
> Depending upon whether the system was plugged in or unplugged will
> determine whether the "display turns on".  If there is no user activity
> for some time then it goes back to sleep.
>
> In Linux plugging or unplugging an adapter will wake the SoC from HW
> sleep but then the Linux kernel puts it right back into HW sleep
> immediately unless there is another interrupt active (such as a PME or
> GPIO).
>
> To get closer to the Windows behavior, record the state of the battery
> when going into suspend and compare it when updating battery status
> during the s2idle loop. If it's changed, wake the system.
>
> This can be restored to previous behavior by disabling the ACPI battery
> device `power/wakeup` sysfs file.

Why is this desirable?

What if the AC is connected to a suspended laptop when the lid is
still closed?  Is it really a good idea to resume it then?

Frankly, I'd prefer the existing behavior to be still the default.

> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-ex=
periences/modern-standby-wake-sources#environmental-context-changes-1
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/battery.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 72c8a509695e6..91f79927cc720 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -125,6 +125,7 @@ struct acpi_battery {
>         int state;
>         int power_unit;
>         int capacity_suspend;
> +       int suspend_state;
>         unsigned long flags;
>  };
>
> @@ -1012,6 +1013,12 @@ static inline bool acpi_battery_should_wake(struct=
 acpi_battery *battery)
>                 return true;
>         }
>
> +       if (battery->state !=3D battery->suspend_state) {
> +               pm_pr_dbg("Waking due to battery state changed from 0x%x =
to 0x%x",
> +                         battery->suspend_state, battery->state);
> +               return true;
> +       }
> +
>         return false;
>  }
>
> @@ -1313,6 +1320,7 @@ static int acpi_battery_suspend(struct device *dev)
>                 return -EINVAL;
>
>         battery->capacity_suspend =3D battery->capacity_now;
> +       battery->suspend_state =3D battery->state;
>
>         return 0;
>  }
> --
> 2.43.0
>
>

