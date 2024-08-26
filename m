Return-Path: <linux-acpi+bounces-7828-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A2095F71E
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 18:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEB21C2184E
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 16:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E40196DB1;
	Mon, 26 Aug 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXe1oUta"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6411946BB;
	Mon, 26 Aug 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691011; cv=none; b=ZocSJITdWxSCKiNODw17sbilMIZc7Q1mHQJh2E7AOnnhofowEgez3TGRv7qTDhGAL3caut5zSB5G7dLY0TeJIRnm3/R6Do6rxH9+BV8M2DJZDMa28leipikDDo5tjI7hxJsxilDe/SRoAxrU3OkJHUJtnIR9U3Xfylc7tLUPOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691011; c=relaxed/simple;
	bh=+bSiQCgkSSf2Bt5tZ1n6E54Te1fmnG/10wPmdS+RUZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzhbJfCatNdD50oY2tBY9ctMZ52q8Coq8yN8YDasKQU6hI7rCVHzxevjRn0n15478BGztbObHScQE/v3O47v3qu17OFjhxz7irjSytuPKuesecOaYTjb6yzVfTbjhx3vC02MW8M642bNYS8JZskO3UO4BpyistXff1B96YOpH/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXe1oUta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6DDC52FCA;
	Mon, 26 Aug 2024 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724691010;
	bh=+bSiQCgkSSf2Bt5tZ1n6E54Te1fmnG/10wPmdS+RUZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eXe1oUtaQt3VO2Ldz6qdX+Mpmt0ynJavqWqvT7Y5u/tPO2OgvGkIw0qb1rN98JZmw
	 lsAWhJ6X7cVRp8cSFVpuCYPHab6KSy2RF0Wh9XCPeA5JnchaX0mE65bkcVYnq77okX
	 QZejc8XEp0VHzikBV3rU2bQxBKPbdXfgRU5q+h+MaWzDU2dFn8qB4FSIYBsVdKUHcu
	 dPO8y/VU8A/QYVm9XIJ820nuENZKVDKy+91Q83zYCIMH3qTDqyUxZ47ytKjuMm8a4K
	 LV79LEQsRk5b7g/Nd6OuNlc/j1J9iX8auzbDcJpToKtmoo3d4lInkpMFXATc14i4FI
	 u0YkmIzfoVSQw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-270263932d5so3296444fac.2;
        Mon, 26 Aug 2024 09:50:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfesuaOpUaL1+MZuzbC+xcBeaPyWrXwLOmmtU0wf0O+JwMdWxe22BBIMils7kcTM6ii9eGUNx1xRlZZpuH@vger.kernel.org, AJvYcCXFs7o1/+3YuRH4G8lCvSvRP4alAfAsMD0QlmThUV08xyRVWPRye11HiH3HFfim9Ku0pwcG05Vofffh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxsy6TaY2jOyRJrQvt0HworpUOuRobIIbSmPkfRaYmP5EqJXRN
	wqUd8BXWvP1E7VdVFcJraqEIHAWNJ8esJ2MQT3Llah2sXSRtR6sX/zjwGFJEDHontxqkuAQWMfb
	Xv2lU5lxyNBJ3ZV57eWraVPnIHX8=
X-Google-Smtp-Source: AGHT+IHbPIpEyvQGKVKc17VK9W7zgLw6+BUdZie7rM6oL1uiHZABkTRmUtL+J955p+cRpamAc21CRH0pJ76oV2wjrWw=
X-Received: by 2002:a05:6870:c698:b0:25d:8d4:68ab with SMTP id
 586e51a60fabf-273e6667a3bmr12197675fac.40.1724691009897; Mon, 26 Aug 2024
 09:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805103531.1230635-1-zhiquan1.li@intel.com>
In-Reply-To: <20240805103531.1230635-1-zhiquan1.li@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Aug 2024 18:49:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j-rEioP-BMYJwDYKeT_M_5FBP25UA6GHvRpzxd6oiqTg@mail.gmail.com>
Message-ID: <CAJZ5v0j-rEioP-BMYJwDYKeT_M_5FBP25UA6GHvRpzxd6oiqTg@mail.gmail.com>
Subject: Re: [PATCH RESEND v4] x86/acpi: fix panic while AP online later with
 kernel parameter maxcpus=1
To: Zhiquan Li <zhiquan1.li@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com, x86@kernel.org, 
	rafael@kernel.org, hpa@zytor.com, kai.huang@intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 12:03=E2=80=AFPM Zhiquan Li <zhiquan1.li@intel.com> =
wrote:
>
> The issue was found on the platform that using "Multiprocessor Wakeup
> Structure"[1] to startup secondary CPU, which is usually used by
> encrypted guest.  Before waking up the APs, BSP should memremap() the
> physical address of the MP Wakeup Structure mailbox to the variable
> acpi_mp_wake_mailbox, which holds the virtual address of mailbox.  When
> BSP needs to wake up the APs, it writes the APIC ID of APs, wakeup
> vector, and the ACPI_MP_WAKE_COMMAND_WAKEUP command into the mailbox.
>
> Current implementation doesn't consider the case that restricts boot
> time CPU to 1 with the kernel parameter "maxcpus=3D1" and brings other
> CPUs online later, the variable acpi_mp_wake_mailbox will be set as
> read-only after init.  So when the first AP gets online after init, the
> attempt to update the variable results in panic.
>
> The memremap() call that initializes the variable cannot be moved into
> acpi_parse_mp_wake() because memremap() is not functional at that point
> in the boot process.  Moreover, the APs might never be brought up, keep
> the memremap() call in acpi_wakeup_cpu() so that the operation only
> takes place on demand.
>
> [1] Details about the MP Wakeup structure can be found in ACPI v6.4, in
>     the "Multiprocessor Wakeup Structure" section.
>
> Fixes: 24dd05da8c79 ("x86/apic: Mark acpi_mp_wake_* variables as __ro_aft=
er_init")
> Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>
> V4 RESEND note:
> - No changes on this, just rebasing as v6.11-rc1 is out.
>
> V3: https://lore.kernel.org/all/20240702005800.622910-1-zhiquan1.li@intel=
.com/
>
> Changes since V3:
> - Add Fixes tag for the commit found by Kai.
> - Extend the commit message for the root cause and solution.
>
> V2: https://lore.kernel.org/all/20240628082119.357735-1-zhiquan1.li@intel=
.com/
>
> Changes since V2:
> - Modify the commit log as suggested by Kirill.
> - Add Kirill's Reviewed-by tag.
>
> V1: https://lore.kernel.org/all/20240626073920.176471-1-zhiquan1.li@intel=
.com/
>
> Changes since V1:
> - Amend the commit message as per Kirill's comments.
> - Remove the oops message.
> ---
>  arch/x86/kernel/acpi/madt_wakeup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/ma=
dt_wakeup.c
> index 6cfe762be28b..d5ef6215583b 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -19,7 +19,7 @@
>  static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
>
>  /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> -static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox _=
_ro_after_init;
> +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
>
>  static u64 acpi_mp_pgd __ro_after_init;
>  static u64 acpi_mp_reset_vector_paddr __ro_after_init;
>
> base-commit: 435dfff07e5b71ceecc35954645740ab91090fbb
> --
> 2.25.1
>

