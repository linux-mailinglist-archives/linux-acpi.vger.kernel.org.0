Return-Path: <linux-acpi+bounces-19611-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6260CC6F88
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 11:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FA9930281B3
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B979A3451BB;
	Wed, 17 Dec 2025 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="P/shgKP1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384E347BA7
	for <linux-acpi@vger.kernel.org>; Wed, 17 Dec 2025 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965999; cv=none; b=ObJw5rth0tn/cUZBc1Naq7GP1364cWAtjvZBlTC8NLRJuRCeHHeMgYV9/AGaynYjiNsy2eAjuFN25Zum0ip+O7AwDwWHWVBVFF453XT1YfDZhUVXTW2QhnOsqiML65ZNC8AmB4igUEvBksKvInij8ZbtR0/H0ABCuoiDZKiFOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965999; c=relaxed/simple;
	bh=3Xb05DB3Q6WIcLEHMe2seSQ1dmwYv75KsTNmo5UtLtE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dr7KXKrrb/ZmjRCbwRL1ANNC5LfPmzq2CSSNVSxSPBX5KuGc5bWDHMDodY8F63Jy4pCZvAaxgyu1phOotAoa2XlKnGKFHuDP1088L654K18eHhHmZW+Tbax6GglzxLG9qc3+bBKLSwR885fNaK7wLlxnYomaqB/k/eYgAg9bjC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=P/shgKP1; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1765965990; x=1766225190;
	bh=2RnnQuGifjV/kTBTetVRhHsLJSG1bJ9UnM5JJ2WVBrA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=P/shgKP1kIMs1lYT7l9kDcVEv9dsrIjAeH+G1tAZq/7uZ3/7YXOR510z/lwKG5pk7
	 jwfcxDUMgVh/x87VGvdJJcYzOpMrb+Gjk9cllPTPVHahdC87Pvd4CYWK2/0s9OGDVd
	 3utEZtEj7TYqyFdpGJmcsEnTZyLcWXTItzRPwG26grA946VOZf/4oo3HX2b4MGdOKN
	 H9oW6C2AZ8eMDNd7D8+vO6Da8QGqamRvC/B1Wk+A9QKJ2aabnZ5WLOtJjoMB42yUlW
	 K3K4XZATjMnw1u3xvy6MPzrfJMjUokYu4/NkEJbYGnV6FzQZkeYHmj9j10tpNDIcW9
	 p693ClKzxreMg==
Date: Wed, 17 Dec 2025 10:06:24 +0000
To: "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
From: Francesco Lauritano <francesco.lauritano1@protonmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: [BUG] 36-second boot delay due to by acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
Message-ID: <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com>
In-Reply-To: <2kSCn4XaoXsXJ3EUR0syTdmip8Z1cBuUr0Br4sFVnwnsA8q4GlhiHOmsJkeBxvxYoLnetp4r44wIPXw42yTAFl-BtMROnIwR-NkckKgA5EY=@protonmail.com>
References: <2kSCn4XaoXsXJ3EUR0syTdmip8Z1cBuUr0Br4sFVnwnsA8q4GlhiHOmsJkeBxvxYoLnetp4r44wIPXw42yTAFl-BtMROnIwR-NkckKgA5EY=@protonmail.com>
Feedback-ID: 66654272:user:proton
X-Pm-Message-ID: f4e4ecbc07449d31ab46ad4031982754970d5bba
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ASUS ROG Strix G16 G614PP (2025) experiences a 36-second kernel boot delay =
caused by `acpi_gpio_handle_deferred_request_irqs()` hanging during late_in=
itcall_sync. The workaround is `gpiolib_acpi.run_edge_events_on_boot=3D0`.

System Information
------------------

-   Hardware: ASUS ROG Strix G16 G614PP_G614PP
-   DMI Product: ROG Strix G16 G614PP_G614PP
-   DMI Vendor: ASUSTeK COMPUTER INC.
-   BIOS Version: G614PP.307 (08/14/2025)
-   CPU: AMD Ryzen (Strix Point)
-   GPU: NVIDIA (with nvidia-open 580.105.08)
-   Distribution: EndeavourOS
-   Kernel: 6.17.9 (also reproduced on zem)
-   Bootloader: systemd-boot with dracut

Problem Description
-------------------

The system takes approximately 56 seconds to boot, with 37.8 seconds spent =
in the kernel phase. Using `initcall_debug`, the culprit was identified as:

    [ =C2=A0 =C2=A01.739645] calling =C2=A0acpi_gpio_handle_deferred_reques=
t_irqs+0x0/0x40 @ 1
    [ =C2=A0 38.077788] initcall acpi_gpio_handle_deferred_request_irqs+0x0=
/0x40 returned 0 after 36338138 usecs

The kernel goes completely silent between ~2 seconds and ~38 seconds (no dm=
esg output during this period):

    [ =C2=A0 =C2=A02.607764] clocksource: Switched to clocksource tsc
    [ =C2=A0 37.828217] clk: Disabling unused clocks

Windows boots normally on the same hardware, indicating this is a Linux-spe=
cific ACPI handling issue.

systemd-analyze output
----------------------

    Startup finished in 8.593s (firmware) + 1.273s (loader) + 37.877s (kern=
el) + 4.645s (initrd) + 3.831s (userspace) =3D 56.221s

ACPI Errors During Boot
-----------------------

The following ACPI errors appear in dmesg (though these complete quickly an=
d are not the direct cause of the delay):

    ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.GPP2], AE_NO=
T_FOUND (20250404/dswload2-162)
    ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20250404/psobject=
-220)
    ACPI: Skipping parse of AML opcode: Scope (0x0010)
    ACPI Error: AE_NOT_FOUND, While resolving a named reference package ele=
ment - \_SB_.PCI0.GPP7.UP00.DP00.U4UP.U4P3.UHI0 (20250404/dspkginit-438)
    ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored

GPIO-related dmesg output
-------------------------

    [ =C2=A0 =C2=A00.257981] calling =C2=A0pinctrl_init+0x0/0xc0 @ 1
    [ =C2=A0 =C2=A00.257982] pinctrl core: initialized pinctrl subsystem
    [ =C2=A0 =C2=A00.257994] initcall pinctrl_init+0x0/0xc0 returned 0 afte=
r 0 usecs
    [ =C2=A0 =C2=A01.612848] calling =C2=A0amd_gpio_driver_init+0x0/0x20 @ =
1
    [ =C2=A0 =C2=A01.613779] initcall amd_gpio_driver_init+0x0/0x20 returne=
d 0 after 930 usecs
    [ =C2=A0 =C2=A01.739645] calling =C2=A0acpi_gpio_handle_deferred_reques=
t_irqs+0x0/0x40 @ 1
    [ =C2=A0 38.077788] initcall acpi_gpio_handle_deferred_request_irqs+0x0=
/0x40 returned 0 after 36338138 usecs

Workaround
----------

Adding the following kernel parameter resolves the issue and reduces boot t=
ime to ~10 seconds:

    gpiolib_acpi.run_edge_events_on_boot=3D0

Impact of Workaround
--------------------

Testing with the workaround applied, no obvious regressions have been obser=
ved:

-   Lid switch works
-   Power button works
-   Keyboard function keys work
-   Sleep/wake works

Long-term, a DMI quirk entry for this device would be preferable.

Suggested Fix
-------------

Add a DMI quirk entry to `drivers/gpio/gpiolib-acpi.c` for the ASUS ROG Str=
ix G16 G614PP, though it may be needed on other=C2=A0ROG/Strix/Zephyrus mod=
els from 2021-2025.

Steps to Reproduce
------------------

1.  Install Linux on ASUS ROG Strix G16 G614PP (2025)
2.  Boot without `gpiolib_acpi.run_edge_events_on_boot=3D0`
3.  Observe ~40 second boot time with `systemd-analyze time`
4.  Add `initcall_debug` to kernel parameters and observe the 36-second han=
g in `acpi_gpio_handle_deferred_request_ir`



