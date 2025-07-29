Return-Path: <linux-acpi+bounces-15404-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 105B1B14BDC
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 12:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6FC1AA4612
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 10:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29DA28724F;
	Tue, 29 Jul 2025 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdD1cNLC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F76A1799F;
	Tue, 29 Jul 2025 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783424; cv=none; b=MAWFnJSilv2g2Q7DLWpkAaFflAgYzZ+kkwbTmUhYmSFbjAX6phSz2HxaI93XkD/qtpWS7pITCGnG5unEJTJV4nicUKeAJO0Nnt7PtgR3pL35fb4RC5NveBZ3NMd/XuubOsBZouo01mXhDmdFQ6qpHXCq4lZ1GHHFYsYv+ekBQZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783424; c=relaxed/simple;
	bh=D+MVLwJmF7zcQQs5GBiAvtVf89SV7MV1UDodoYOOKcM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eoB9jWxqJf9wTWDGJNkSDwnnhpNBcYxVO5kMw9pIgn027WhJQewetmXQG+jDEbY0wkSuVVdZh8B694ldpaHwhITOsSiUK2aulFZgu9sl7zl/hbM2cv7YyIbZgcdxGBq/OudmoysKXU73jsmktVJmGaqx7XyBNOWNGdjxkxYgsXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdD1cNLC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0e0271d82so1018227066b.3;
        Tue, 29 Jul 2025 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753783420; x=1754388220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D+MVLwJmF7zcQQs5GBiAvtVf89SV7MV1UDodoYOOKcM=;
        b=hdD1cNLCLOaUQOhH02Eo9SiEDi9PAfbacB8CTYOm6FgGea6Z1Ll0gHt6IktIKTS4ZO
         fM0zL6lOZ8dgD1PtClg2bbp09fW6Sn4mMwUCcgKBloyJvmGRxq0Hhw/GE6Uvkge4vvFQ
         rJ78iJsV7sqBeJYapjJnkzv5sAPG0nLNVLSovWDagp4WYqWekPyveVr5RVfvBjRTX56r
         vUiGgLDlQwyM48WcSuIVMkWwzMJNEX6kbQ91opJcXknfFiAJ/65qVYCED6ItHsHiMsQO
         mP4oPVE2RUu/VDzmVfY8I7Lg+zK7yW1UhahqiC9EGCZ6NFXVpfqkEoCwoDMbhrXqbyL0
         H5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753783420; x=1754388220;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+MVLwJmF7zcQQs5GBiAvtVf89SV7MV1UDodoYOOKcM=;
        b=IaOiw2tMM9gozbD4eSiAaHv8qluEp8s8rx6COQsvt0gsLOjaDtK3NkMcqhVml5H8Tl
         dtwADRd9IrsMYYBQwPudZFJCbI8XxVj0GH/ZicoS0UFiEz0uWAgcsmhKow16Hfdownuw
         +9mWOHlrp2Rp9QG6F7Obls2jzPMVabd90OiIREw43Uzvs8F6upEXyeHO7KLDbfhdyQGE
         3Fs6j8uoDLQ2yp17iZiC3/rylOebkQyCHzeH8KUCXIDcUkreg4830Nj1dTjef6xmYe2x
         EP4+ov5+XSl4kQQIDsf1sW9mdpLdiSO63rO2dULBDESkQdsTGqKgSWtuZNa7PEOTUu8b
         6uJw==
X-Forwarded-Encrypted: i=1; AJvYcCUB+h44IIGlBOr/b5d6kBI8dFNa0tLtc3T44F4Mw93SscXCIIMdVYZCuGh6Wxi86XEPqx3f5mxeR6RR@vger.kernel.org, AJvYcCWphGGtv210NoOtiwnMqTXROF3QN57Qy94MIL10tkV9LZtY5sXOYHK71T0+DoQmBPhL2hX5cOl/jRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTlwC6bpEG/9u8mUgGYhg1K9QdP3Sk1Y+YEfYXduuLP9gdgsQi
	MpTZ+81E7x1n1CvHHu9EuuaLQskHf7uCyaW0ESDFxldu4byMNTLHfZa2RenI6K7y0MClXR/ddK9
	x0jABPcAqUSUDQVqSg/BtJzaHpHn3iwe5FmcpkOA=
X-Gm-Gg: ASbGncv/qmmBJuvW0AaQm1x5uhlrT/GpkfrAkDhWpf/XJ+2+BYz/Wfqd0/dIOi3YZ+X
	TOLj2JTPAFbGrzC8166wZsXX1zCExS1VYgAw99851wvEwNMVQ3PoTCJ3hzRYdSg+FOpQ5JpJsxx
	XxzvOBTNIVEfNy8LRAGusy76XC4bHbTSXePCnmh2//CyJBj7UrBvasSFjwbjLc2Qoo5lSF7hEZa
	KEpE7zu
X-Google-Smtp-Source: AGHT+IFR5NqoKoHtBXiwuzultk2/wcc4NDM8ArexVgiStAANSbiLZ+rEDOZQAChRg5bGXQycZF4dSKht6k9SVrysExk=
X-Received: by 2002:a17:907:6d18:b0:add:f2c8:7d3f with SMTP id
 a640c23a62f3a-af618f02439mr1594000566b.33.1753783419635; Tue, 29 Jul 2025
 03:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andy Mindful <andy.mindful@gmail.com>
Date: Tue, 29 Jul 2025 13:03:27 +0300
X-Gm-Features: Ac12FXwT2AD8p3BCcLoITIH5kuPJ0_AKKpOAxOhi7hBOjcX8afUCURN2eTIOkdw
Message-ID: <CACTEcX6oXBot1VBApOyKVMVXsAN9BsvQMLa8J0iKpNeB-eLttQ@mail.gmail.com>
Subject: [REGRESSION] tty lockup and WWAN loss after hibernate/suspend in 6.8+
 on ThinkPad X1 Carbon Gen 10
To: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	linux-pm@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-acpi@vger.kernel.org, rafael@kernel.org, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Kernel-version: 6.8+ (confirmed in Fedora kernel 6.8.4-200.fc38.x86_64
and above)
Regression-from: 6.7.11 (working) to 6.8.4+ (regressed)
Affected-hardware: Lenovo ThinkPad X1 Carbon Gen 10 (Intel Alder Lake platform)
Affected-subsystems: TTY/Console, Power Management, WWAN Modem (Intel
XMM7560, iosm driver), Kernel DRM/i915 stack

Description:
We are reporting a significant regression introduced in Linux kernel
version 6.8 (specifically confirmed in Fedora kernel
6.8.4-200.fc38.x86_64 and subsequent versions), affecting Lenovo
ThinkPad X1 Carbon Gen 10 laptops. This regression manifests primarily
as tty lockups and complete loss of WWAN modem functionality after
hibernate cycle.

Problematic Behavior:
1. TTY/Console: After a hibernate cycle, the console input becomes
unresponsive. In some cases, after suspend, pressing `SysRq+R` (unraw)
can temporarily restore keyboard functionality, but this is not
consistent, especially after hibernation.
2. Power Management: While S3 suspend works correctly when "Linux
only" is set in BIOS, `suspend` causes the system to freeze upon
resume if "Windows + Linux" mode (which implies `s2idle`) is active in
BIOS settings.
3. WWAN Modem (Intel XMM7560, `iosm` driver): The modem fails to
reinitialize after hibernation, consistently showing "msg timeout"
errors in logs. The modem works correctly after a cold boot but
completely fails to recover after resuming from hibernate. Rescanning
PCI devices or reloading the `iosm` module does not resolve the issue.
Attempts to manually remove the device via
`/sys/bus/pci/devices/.../remove` result in a system hang.
4. Kernel DRM/i915 stack: Although GuC and HuC firmware (versions
70.44.1 / 7.9.3) are confirmed to load correctly, logs indicate
potential graphics driver reinitialization issues in affected kernel
versions. This might contribute to the TTY unresponsiveness.

System Specifications:
- Laptop: Lenovo ThinkPad X1 Carbon Gen 10
- CPU: Intel Core i7-1260P (Alder Lake)
- GPU: Intel iGPU (ADL GT2) - i915
- WWAN: Intel XMM7560 (iosm driver)
- Wi-Fi/Bluetooth: Intel AX201
- Operating Systems tested:
- Fedora 38 (most stable with 6.7.11)
- Fedora 39/40/42 (exhibit regression)
- Ubuntu 22.04, 24.10 (exhibit regression)
- EndeavourOS_Mercury-Neo-2025.03.19 (exhibits regression)
- Display manager: GDM/Wayland (also tested LightDM + Xfce and
runlevel 3, problem persists).
- Mesa Stack: Mesa 24.3.4 built with LLVM 16.0.6 (confirmed functional
with working kernels). Vulkan, GBM, EGL, GLX render correctly with
`iris` and `intel` drivers. Custom Mesa 24.3.4 build showed no impact
on the hibernate issue.

Behavior Matrix:
| Kernel Version | Hibernate Status | Resume Status | TTY
Functionality | WWAN Functionality | Notes |
|----------------|------------------|---------------|-------------------|--------------------|-------|
| 6.2.9 | OK | Not tested | OK | Not Tested | Working baseline |
| 6.3.12 | OK | Not tested | OK | Not Tested | Working baseline |
| 6.7.11 | OK | OK(S3)/Fail(S2idle) | OK | FAIL | WWAN regression
starts here, but hibernate/tty still OK |
| **6.8.4+** | FAIL | OK(S3)/Fail(S2idle) | FAIL | FAIL | Major
regression point, affects hibernate/tty/WWAN |
| 6.14+ | FAIL | OK(S3)/Fail(S2idle) | FAIL | FAIL | Problem persists
in newer kernels |

Additional Details:
- Hibernation issues:
- Initial `mem_sleep` was `[s2idle]` in BIOS "Windows + Linux" mode.
- Switching BIOS to "Linux only" enabled proper S3 suspend, changing
`/sys/power/mem_sleep` to `[s2idle] deep`. However, the hibernation
issue (TTY lockup, WWAN loss) persists even with S3 enabled for
suspend.
- `Alt + SysRq + R` sometimes revives console after suspend but
*never* after hibernate.
- TTY related errors observed in logs are, dmesg:
`tty_flip_buffer_push: called while buffer locked`, systemd-logind:
`New session created but VT is not initial VT, ignoring`, GDM:
`GdmLocalDisplayFactory: active VT is not initial VT` on kernels 6.8+.
- WWAN issues:
- The `iosm` driver appears loaded, and the device is visible via
`lspci`, but the modem is not visible to `mmcli` after resume from
hibernate.
- The WWAN modem (iosm) only works after a cold boot.
- Rescanning PCI or reloading `iosm` module (e.g., `modprobe -r iosm
&& modprobe iosm`) does not resolve the issue.
- Manual removal via `/sys/bus/pci/devices/.../remove` leads to a
system hang, indicating a deeper issue with device state or driver
interaction post-resume.

Tested Alternatives & Current Stability:
- Hibernate works reliably only up to kernel 6.7.11.
- Fedora 38 with kernel 6.7.11 + GNOME 44.10 is currently the most
stable configuration for this hardware, despite the WWAN issue already
present there (but not the tty lockup/hibernate issue).
- Kali Linux with 6.6.9 - hibernation works.
- Newer distributions (e.g., Fedora 42, Ubuntu 25.04, EndeavourOS)
inherit the same problems due to their newer kernel versions.

Expected Behavior:
The system should resume from hibernate and suspend without TTY
lockups, and the WWAN modem should reinitialize correctly and be fully
functional.

Steps to Reproduce:
1. Ensure system is running a kernel version 6.8.4 or newer (e.g.,
Fedora 38 with `6.8.4-200.fc38.x86_64`).
2. Perform a `systemctl hibernate` or `systemctl suspend`.
3. Resume the system.
4. Observe TTY console unresponsiveness(only in runlevel 3) and check
WWAN modem status using `mmcli -L`.

Please let me know if any further information or testing is required.

Thank you.

Best regards,
Andriy

