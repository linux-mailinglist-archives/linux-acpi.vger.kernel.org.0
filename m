Return-Path: <linux-acpi+bounces-12417-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BDEA6DFAD
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Mar 2025 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07AD7A78EC
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Mar 2025 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5357F263F47;
	Mon, 24 Mar 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehoGlY5t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BF9263C8A;
	Mon, 24 Mar 2025 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833809; cv=none; b=gCCEhddh9l7CLrxf6DIY6P/q52mqSlOSE46kTnfqNtUKVyUR+dJKxd2wefORY14lxJkQQ9LTAR3i93CytlZ8nI93iPsHWxhROkdnXunR9cad+tHdcnB/jM+DHQL1GxFOMccXFQimpwMVkfcMgdsYytNtzIYU6I8hYP43xJnTcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833809; c=relaxed/simple;
	bh=oPUiieo2nIw9a52fhZehjoN/HpeYykF+bQ1aIY1TK/o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hPfM9362xj+2NUFy8TgcJeyFGd0m1HjSzz9bTHJsfnRMI33njJx8USa4TC74h3ByOTlMg3CllIvdD/rRnAcoUvtrG6U+Ul1isXIb7qZ4SgIkN5g24Zgn2ST/oh7ODfU5PZicBF0CU8V16XUz5jZFfb567zLr6t16eQqfeaKFFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehoGlY5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A272C4CEE9;
	Mon, 24 Mar 2025 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742833808;
	bh=oPUiieo2nIw9a52fhZehjoN/HpeYykF+bQ1aIY1TK/o=;
	h=From:Date:Subject:To:Cc:From;
	b=ehoGlY5tnTUEFFCaFeYb/3FM5lM90a1lf/LHGv02p2Vf7kXthc54XPrYi60Ln6G3Y
	 xmvt3BZkAYVNDKC7O14XSzGQu6WTNcylXhog5iSDWwbSpMSTXpqJ4jk8jBJ6wWSw3L
	 ITWfxfyAg4lVeU6t9CcTT4KkTifSGHEM0HeqytyBXRKdlcEjabf7mOQzSIJdUURCCM
	 7c74kAnuZ6vY0rP8vdedT3r3Ru2Saw1X0H1wU43pdtAzBnfCXJrcxbXUNF7ilW4xqs
	 QHzGtjNwHoVi1WpPwBW5d05wB7VQOCFzPSb4i5AOmMOpPyLsa7Oq7ZbYFuIus4aVDA
	 udWzvqT7oh4dQ==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7272f9b4132so3234902a34.0;
        Mon, 24 Mar 2025 09:30:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8YKQWGw2zVyXKuBYupISWu7HKhDFbofg1FZB4YltDikt+yJjV6VImhxSCDdSh+jc93XJEG3vJqBOBldA=@vger.kernel.org, AJvYcCVHGNxB66KjbJZGBA3BdiNwI9WsOukSsgJTnsLMcx68HsDEbl9ZrJtMew12DknLvvEaJhXqNeAxjj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn3ON9z6RIjcnGGLidLXolEsh8WMQdcLyfJAX5nVh1wOVzf7UX
	Sg3j7U7YKEZDT0CZDtw8BNj3pJdPvqYrwxsIsw1LGjcEJSBzaWbLC12ksTLyqLwI5xpQFDiBjSG
	6Y5Sx0yV2herA4yOVrQajNmcwwyE=
X-Google-Smtp-Source: AGHT+IHwK/5o9CFHgTZKff5prpDfXTmk+iSezr4xHi+4liiVMFB2kYvfW6BCI4zQSsECXlEl6EtCiXngvKS6msIfaJo=
X-Received: by 2002:a05:6830:7183:b0:72b:84ab:b1bc with SMTP id
 46e09a7af769-72c0ae4f90emr8773059a34.2.1742833807789; Mon, 24 Mar 2025
 09:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Mar 2025 17:29:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h2BgjPbZXe7yeXo-Y9MnvX+bXT5QLEq6KKLJc5N6QR2Q@mail.gmail.com>
X-Gm-Features: AQ5f1Jol_BYZXYkw-7voVIXhr0568LObMa_xUM9RgkcYPNx5sgQkajJxLViKI20
Message-ID: <CAJZ5v0h2BgjPbZXe7yeXo-Y9MnvX+bXT5QLEq6KKLJc5N6QR2Q@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.15-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.15-rc1

with top-most commit 8b30d2a3962ae07e67aee90d6698a6a68e771c6c

 Merge branches 'acpi-x86', 'acpi-platform-profile', 'acpi-apei' and 'acpi-misc'

on top of commit 80e54e84911a923c40d7bee33a34c1b4be148d7a

 Linux 6.14-rc6

to receive ACPI updates for 6.15-rc1.

From the functional perspective, the most significant changes here are
the ACPI fan driver update allowing it to handle fans with fine-grained
state checking supported, but without fine-grained control, and the
ACPI button driver update making it subscribe to system event
notifications (in addition to device notifications) which on some
systems is requisite for waking up the system from sleep.

The rest is fixes and cleanups including removal of some dead code.

Specifics:

 - Use the str_on_off() helper function instead of hard-coded strings in
   the ACPI power resources handling code (Thorsten Blum).

 - Add fan speed reporting for ACPI fans that have _FST, but otherwise
   do not support the entire ACPI 4 fan interface (Joshua Grisham).

 - Fix a stale comment regarding trip points in acpi_thermal_add() that
   diverged from the commented code after removing _CRT evaluation from
   acpi_thermal_get_trip_points() (xueqin Luo).

 - Make ACPI button driver also subscribe to system events (Mario
   Limonciello).

 - Use the str_yes_no() helper function instead of hard-coded strings in
   the ACPI backlight (video) driver (Thorsten Blum).

 - Add a missing header file include to the x86 arch CPPC code (Mario
   Limonciello).

 - Rework the sysfs attributes implementation in the ACPI platform-profile
   driver and improve the unregistration code in it (Nathan Chancellor,
   Kurt Borja).

 - Prevent the ACPI HED driver from being built as a module and change
   its initcall level to subsys_initcall to avoid initialization ordering
   issues related to it (Xiaofei Tan).

 - Update a maintainer email address in the ACPI PMIC entry in
   MAINTAINERS (Mika Westerberg).

 - Address a GCC 15's -Wunterminated-string-initialization warning in
   the core PNP subsystem code and remove some dead code from it (Kees
   Cook, David Alan Gilbert).

Thanks!


---------------

Dr. David Alan Gilbert (1):
      PNP: Remove prehistoric deadcode

Joshua Grisham (1):
      ACPI: fan: Add fan speed reporting for fans with only _FST

Kees Cook (1):
      PNP: Expand length of fixup id string

Kurt Borja (1):
      ACPI: platform_profile: Improve platform_profile_unregister()

Mario Limonciello (2):
      x86/ACPI: CPPC: Add missing include
      ACPI: button: Install notifier for system events as well

Mika Westerberg (1):
      MAINTAINERS: Use my kernel.org address for ACPI PMIC work

Nathan Chancellor (1):
      ACPI: platform-profile: Fix CFI violation when accessing sysfs files

Thorsten Blum (2):
      ACPI: power: Use str_on_off() helper function
      ACPI: video: Use str_yes_no() helper in acpi_video_bus_add()

Xiaofei Tan (1):
      ACPI: HED: Always initialize before evged

xueqin Luo (1):
      ACPI: thermal: Fix stale comment regarding trip points

---------------

 Documentation/admin-guide/pnp.rst |  3 ---
 MAINTAINERS                       |  2 +-
 arch/x86/kernel/acpi/cppc.c       |  2 ++
 drivers/acpi/Kconfig              |  2 +-
 drivers/acpi/acpi_video.c         |  7 +++---
 drivers/acpi/button.c             | 10 +++++++--
 drivers/acpi/fan.h                |  1 +
 drivers/acpi/fan_attr.c           | 37 +++++++++++++++++++-------------
 drivers/acpi/fan_core.c           | 25 ++++++++++++++++------
 drivers/acpi/fan_hwmon.c          |  8 +++++++
 drivers/acpi/hed.c                |  7 +++++-
 drivers/acpi/platform_profile.c   | 45 +++++++++++++++++++--------------------
 drivers/acpi/power.c              |  5 +++--
 drivers/acpi/thermal.c            |  2 +-
 drivers/pnp/base.h                |  4 ----
 drivers/pnp/card.c                | 32 ----------------------------
 drivers/pnp/core.c                | 16 --------------
 include/linux/platform_profile.h  |  2 +-
 include/linux/pnp.h               |  2 +-
 19 files changed, 99 insertions(+), 113 deletions(-)

