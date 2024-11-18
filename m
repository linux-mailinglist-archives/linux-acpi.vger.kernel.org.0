Return-Path: <linux-acpi+bounces-9630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9A69D0E74
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 11:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEBE1F21F43
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 10:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD8A1974FE;
	Mon, 18 Nov 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPBtFW6R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31936192D97;
	Mon, 18 Nov 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925543; cv=none; b=l4Oa5iRzkRzQjhQyEBbAUaZFJ1vGLjaVB04pz3xzQVER3QFGJn47EboB91pxVF3lvkFx9WejdL20vYNAVqamvBUFrgtwDUygx3K+9hRBKP3KgrWhk27MpPJfaPjVSZ2YldMB7IHBIXJFKHeL3plNqfCRWcjs9aN22TYigkVsGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925543; c=relaxed/simple;
	bh=QDfRNQIvlwjaYeOF45h2WoWUC3qqv0lyACNzU1NOqV0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Top0ZN4fBg90oWpCnOoF8Xk3RticGou6EoTBj2o/gtPKuneGmul6YbkF+6ED07QPYN/8qGF9aRTZjyvG86N1vyC+WlcsqwdIYcpiEBm1XQovOCuaCeXWJvmLAkCHU6p/iTvezqRngxaAqnw++C2XKG0bURLNvdaRBAyyien4P8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPBtFW6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A69C4CECC;
	Mon, 18 Nov 2024 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731925542;
	bh=QDfRNQIvlwjaYeOF45h2WoWUC3qqv0lyACNzU1NOqV0=;
	h=From:Date:Subject:To:Cc:From;
	b=tPBtFW6RMCDlkA2XB4wsLOKFhltfSM3YW2okBzn8/th6iPKO7Lt9Tw5IcGJ1eRL8P
	 doBQBHyIQ6X2VSqojTmu7eOlv6r3B0hceEUZmcuSlC3WNDrLG3lL9gwcqIVJW3a2mg
	 BgM9NubA5/UXRe+7MK6Ob/y6/3fBcnmgfJuON8893wqP8uIx1fY8E4S0a1YfC/qjMw
	 sUI5vqymkSJJ/OM/EGlE8HYgooyjQnf2yxWYRS04oPnjltFc2gOy/C695q8PkkGgzd
	 8I8ufSPtWcXZvzkdxhYTNuNaZ1s2FpPbKyu68gpmS3WKog9UiPCTM2zIE3bZIWgaOL
	 783GYx6DLKoqg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-296252514c2so2487451fac.3;
        Mon, 18 Nov 2024 02:25:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU27llnrhDpr2/UUWZ6KP62H5iBp08jq5JWOOSawpeP3MqLbZotdfG5/M75559EhUSiDBdSvsIy62Y=@vger.kernel.org, AJvYcCXSWrRrjCrbx3VCoVvTUbFXcc853djOf++rEzUbxKCDUiCzFzy1qLKMTLYD7sNeKn5vuYkQjFKUOy54MsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqq+pA5siQLikgqukp1RsWA0CPImrGVVJf/UcOhzLoYKdD8Fr3
	AVlwQ6rpOWnHMtxFiG7Qi9EJtDwPWLnuX6jJoWqamPcKd+atZAnTQhOJ73oYuV8t3w9SYOlivvg
	xXm9KuHv1TOwd7H7uxwebRtLY87s=
X-Google-Smtp-Source: AGHT+IEgLgtg76At0fKYYK+vm+PcqDQMbKbm/vKpGXtbtfAiFEb4iBbnJlK+TR0rslax9lHvmUe+g71XIrpsHR0VagA=
X-Received: by 2002:a05:6870:7904:b0:294:8f41:88c8 with SMTP id
 586e51a60fabf-2962dde4e56mr9865603fac.21.1731925542028; Mon, 18 Nov 2024
 02:25:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Nov 2024 11:25:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hey+FYr5KAbs=Eg_6u9Hp=gqH99G8nCwfr_ibRgkkiQw@mail.gmail.com>
Message-ID: <CAJZ5v0hey+FYr5KAbs=Eg_6u9Hp=gqH99G8nCwfr_ibRgkkiQw@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.13-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.13-rc1

with top-most commit d47a60e487fbb65bbbca3d99e59009f0a4acf34d

 Merge branch 'acpi-misc'

on top of commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623

 Linux 6.12-rc7

to receive ACPI updates for 6.13-rc1.

These include a couple of fixes, a new ACPI backlight quirk for Apple
MacbookPro11,2 and Air7,2 and a bunch of cleanups:

 - Fix _CPC register setting issue for registers located in memory in
   the ACPI CPPC library code (Lifeng Zheng).

 - Use DEFINE_SIMPLE_DEV_PM_OPS in the ACPI battery driver, make it use
   devm_ for initializing mutexes and allocating driver data, and make
   it check the register_pm_notifier() return value (Thomas Wei=C3=9Fschuh,
   Andy Shevchenko).

 - Make the ACPI EC driver support compile-time conditional and allow
   ACPI to be built without CONFIG_HAS_IOPORT (Arnd Bergmann).

 - Remove a redundant error check from the pfr_telemetry driver (Colin
   Ian King).

 - Rearrange the processor_perflib code in the ACPI processor driver
   to avoid compiling x86-specific code on other architectures (Arnd
   Bergmann).

 - Add adev NULL check to acpi_quirk_skip_serdev_enumeration() and
   make UART skip quirks work on PCI UARTs without an UID (Hans de
   Goede).

 - Force native backlight handling Apple MacbookPro11,2 and Air7,2 in
   the ACPI video driver (Jonathan Denose).

 - Switch several ACPI platform drivers back to using struct
   platform_driver::remove() (Uwe Kleine-K=C3=B6nig).

 - Replace strcpy() with strscpy() in multiple places in the ACPI
   subsystem (Muhammad Qasim Abdul Majeed, Abdul Rahim).

Thanks!


---------------

Abdul Rahim (1):
      ACPI: thermal: Use strscpy() instead of strcpy()

Andy Shevchenko (1):
      ACPI: battery: Check for error code from devm_mutex_init() call

Arnd Bergmann (3):
      ACPI: EC: make EC support compile-time conditional
      ACPI: processor_perflib: extend X86 dependency
      ACPI: allow building without CONFIG_HAS_IOPORT

Colin Ian King (1):
      ACPI: pfr_telemetry: remove redundant error check on ret

Hans de Goede (2):
      ACPI: x86: Make UART skip quirks work on PCI UARTs without an UID
      ACPI: x86: Add adev NULL check to acpi_quirk_skip_serdev_enumeration(=
)

Jonathan Denose (1):
      ACPI: video: force native for Apple MacbookPro11,2 and Air7,2

Lifeng Zheng (1):
      ACPI: CPPC: Fix _CPC register setting issue

Muhammad Qasim Abdul Majeed (9):
      ACPI: APD: Use strscpy() instead of strcpy()
      ACPI: EC: Use strscpy() instead of strcpy()
      ACPI: event: Use strscpy() instead of strcpy()
      ACPI: pci_link: Use strscpy() instead of strcpy()
      ACPI: pci_root: Use strscpy() instead of strcpy()
      ACPI: power: Use strscpy() instead of strcpy()
      ACPI: SBS: Use strscpy() instead of strcpy()
      ACPI: SBSHC: Use strscpy() instead of strcpy()
      ACPI: scan: Use strscpy() instead of strcpy()

Thomas Wei=C3=9Fschuh (4):
      ACPI: battery: check result of register_pm_notifier()
      ACPI: battery: allocate driver data through devm_ APIs
      ACPI: battery: initialize mutexes through devm_ APIs
      ACPI: battery: use DEFINE_SIMPLE_DEV_PM_OPS

Uwe Kleine-K=C3=B6nig (1):
      ACPI: Switch back to struct platform_driver::remove()

---------------

 drivers/acpi/Kconfig               | 11 ++++++++-
 drivers/acpi/Makefile              |  2 +-
 drivers/acpi/ac.c                  |  2 +-
 drivers/acpi/acpi_apd.c            |  2 +-
 drivers/acpi/acpi_pad.c            |  2 +-
 drivers/acpi/acpi_tad.c            |  2 +-
 drivers/acpi/apei/einj-core.c      |  2 +-
 drivers/acpi/apei/ghes.c           |  2 +-
 drivers/acpi/arm64/agdi.c          |  2 +-
 drivers/acpi/battery.c             | 31 +++++++++++-------------
 drivers/acpi/cppc_acpi.c           |  7 +++---
 drivers/acpi/dptf/dptf_pch_fivr.c  |  2 +-
 drivers/acpi/dptf/dptf_power.c     |  2 +-
 drivers/acpi/ec.c                  |  4 ++--
 drivers/acpi/event.c               |  4 ++--
 drivers/acpi/evged.c               |  2 +-
 drivers/acpi/fan_core.c            |  2 +-
 drivers/acpi/internal.h            | 25 +++++++++++++++++++
 drivers/acpi/osl.c                 | 12 ++++++++++
 drivers/acpi/pci_link.c            |  4 ++--
 drivers/acpi/pci_root.c            |  4 ++--
 drivers/acpi/pfr_telemetry.c       |  5 +---
 drivers/acpi/pfr_update.c          |  2 +-
 drivers/acpi/power.c               |  4 ++--
 drivers/acpi/processor_perflib.c   | 13 ++++------
 drivers/acpi/sbs.c                 |  4 ++--
 drivers/acpi/sbshc.c               | 13 +++-------
 drivers/acpi/scan.c                | 14 +++++------
 drivers/acpi/thermal.c             |  6 ++---
 drivers/acpi/video_detect.c        | 16 +++++++++++++
 drivers/acpi/x86/utils.c           | 49 +++++++++++++++++++++++++++++++---=
----
 drivers/char/Kconfig               |  1 +
 drivers/hwmon/Kconfig              |  3 ++-
 drivers/platform/x86/Kconfig       | 22 +++++++++--------
 drivers/platform/x86/dell/Kconfig  |  1 +
 drivers/platform/x86/hp/Kconfig    |  1 +
 drivers/platform/x86/intel/Kconfig |  2 +-
 include/linux/acpi.h               |  8 +++++--
 38 files changed, 189 insertions(+), 101 deletions(-)

