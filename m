Return-Path: <linux-acpi+bounces-6887-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFED931B32
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2024 21:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E1E283750
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2024 19:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29FE139D00;
	Mon, 15 Jul 2024 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djAFJ9xZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62BF137930;
	Mon, 15 Jul 2024 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072685; cv=none; b=tgxbSLcEfKKbSY01AvU1/YJqEYsqi7IbZS6po7k3QvjX6XeVWNZ191wvqxREpT9WbsrJJxzQdGGCXx4kQgYYbusRRRY2B2emOb1MfcKE8VGR7Y2I8DeQxXsRQDwSFdPD23RlNaKHZ2fAT2q5YVZnXsK7GldESS1stqjkNAH0QpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072685; c=relaxed/simple;
	bh=09tIpSCUoyvI4+y9Yb5wCfNrTwUwNt31dEg9O12cLao=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tsKtzuhfl9T/B/Fu0T92pKXysEcfCjvcIgu5FVctXEukWZUL0pJWyqLb6GUm6qiysRGwlidWokq/zP5ml0Tc6DZkEB+ADtNWD63HGo7OrVzcbXvlj8xnANS7YAwjCm0lFDeG2XQYbEqvi14E6fmuwM44ro+WoK6yqciRU8xKlj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djAFJ9xZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F90C32782;
	Mon, 15 Jul 2024 19:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721072685;
	bh=09tIpSCUoyvI4+y9Yb5wCfNrTwUwNt31dEg9O12cLao=;
	h=From:Date:Subject:To:Cc:From;
	b=djAFJ9xZevJrWgFAyPK2lktJZKoqSxCYdiZPf34kah2vaDWF1PSxURlAG7cS0UABB
	 Vsc00wHgJG56PZrJDPNAVY+4y4/9VB03Mitbu2Ikv9VxkFOl2A9KNdydfUlRVo54C+
	 t0SLilwt+qtaP96DrMz3rblDbfKfWtq1BrPzGloFnkQSBFu2f88p99Scx5rzLmcjYR
	 /faK+9G/axGfoDKs+wZBwBzGD9yWbzIJwM2PYFDb0ULDbrzUmL6Rso+d3KXCEj4nCo
	 B95eHb0EgaCUs71fFDwlW2Wv7+0EabuOfCpJNNMuLMwbGxkDpenN55I/CNh+0c41e/
	 3wqJeInfLJGfA==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25e55d0f551so512181fac.0;
        Mon, 15 Jul 2024 12:44:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVh8OjRGfXePOAo4xCw7JTa2SZVkR/ilegJi97NIWSzFQNzmt4z2/tVovOqPGw6fceAXa8QDsL45Nif33EXVhcdPrAWOfDbId4GfFhpLxG7OQIA1AOXiBGWFHgw6oOCiLN9caWSa40=
X-Gm-Message-State: AOJu0YwYRKqkLZwNMmkVgBj0XHvfiGgNm6WlZyVDZHQl2MR3GGwFdS2a
	l3YmIlhEq1FaGGvzYEU/p2wGv/N5VkcQ7DvoU68+QtprIcm/HaT6kFNlKAnZzQf9uMi4jqfYz5G
	rGJqpaLBGxDTWov8ySHuOCUY4xm0=
X-Google-Smtp-Source: AGHT+IFdIhzpgKkUMCjoh8gI5MBHJP2G7iuYSazD2Fp6Iml/DUP8CiBuNRK0lKCnTGMMg6TYcUY+d+sfQbSH0SlI8/Y=
X-Received: by 2002:a05:6871:e2d1:b0:254:a7df:721b with SMTP id
 586e51a60fabf-260b8d512cdmr365105fac.5.1721072684522; Mon, 15 Jul 2024
 12:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Jul 2024 21:44:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jtWq5kTmM_DRPwFZZCziqY11TMP8rYtj8UQHHfRKX6tg@mail.gmail.com>
Message-ID: <CAJZ5v0jtWq5kTmM_DRPwFZZCziqY11TMP8rYtj8UQHHfRKX6tg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.11-rc1

with top-most commit b77b0bc85b117119764107f3ee76e8877bf826ab

 Merge branch 'acpi-misc'

on top of commit 233323f9b9f828cd7cd5145ad811c1990b692542

 ACPI: processor_idle: Fix invalid comparison with insertion sort for laten=
cy

to receive ACPI updates for 6.11-rc1.

The only kind of new feature added by these is the hwmon interface
support in the ACPI fan driver.  Apart from that, they mostly address
issues and clean up code.

Specifics:

 - Switch the ACPI x86 utility code and the ACPI LPSS driver to new
   Intel CPU model defines (Tony Luck).

 - Add hwmon interface support to the ACPI fan driver (Armin Wolf).

 - Add sysfs entry for guaranteed performance to the ACPI CPPC library
   and replace a ternary operator with umax() in it (Petr Tesa=C5=99=C3=ADk=
,
   Prabhakar Pujeri).

 - Clean up the ACPI PMIC driver in multiple ways (Andy Shevchenko,
   Christophe JAILLET).

 - Add support for charge limiting state to the ACPI battery driver
   and update _OSC to indicate support for it (Armin Wolf).

 - Clean up the sysfs interface in the ACPI battery, SBS (smart battery
   subsystem) and AC drivers (Thomas Wei=C3=9Fschuh).

 - Coordinate header includes in the ACPI NUMA code and make it use
   ACCESS_COORDINATE_CPU when appropriate (Huang Ying, Thorsten Blum).

 - Downgrade Intel _OSC and _PDC messages in the ACPI processor driver
   to debug to reduce log noise (Mario Limonciello).

 - Still evaluate _OST when _PUR evaluation fails in the ACPI PAD
   (processor aggregator) driver as per the spec (Armin Wolf).

 - Skip ACPI IRQ override on Asus Vivobook Pro N6506MJ and N6506MU
   platforms (Tamim Khan).

 - Force native mode on some T2 macbooks in the ACPI backlight driver
   and replace strcpy() with strscpy() in it (Orlando Chamberlain,
   Muhammad Qasim Abdul Majeed).

 - Add missing MODULE_DESCRIPTION() macros in two places (Jeff Johnson).

Thanks!


---------------

Andy Shevchenko (3):
      ACPI: PMIC: Use sizeof() instead of hard coded value
      ACPI: PMIC: Convert pr_*() to dev_*() printing macros
      ACPI: PMIC: Replace open coded be16_to_cpu()

Armin Wolf (4):
      ACPI: fan: Add hwmon support
      ACPI: acpi_pad: Still evaluate _OST when _PUR evaluation fails
      ACPI: battery: Add support for charge limiting state
      ACPI: bus: Indicate support for battery charge limiting thru _OSC

Christophe JAILLET (1):
      ACPI: PMIC: Constify struct pmic_table

Huang Ying (1):
      ACPI: HMAT: Use ACCESS_COORDINATE_CPU when appropriate

Jeff Johnson (1):
      ACPI: add missing MODULE_DESCRIPTION() macros

Mario Limonciello (1):
      ACPI: processor: Downgrade Intel _OSC and _PDC messages to debug

Muhammad Qasim Abdul Majeed (1):
      ACPI: video: Use strscpy() instead of strcpy()

Orlando Chamberlain (1):
      ACPI: video: force native for some T2 macbooks

Petr Tesa=C5=99=C3=ADk (1):
      ACPI: CPPC: add sysfs entry for guaranteed performance

Prabhakar Pujeri (1):
      ACPI: CPPC: Replace ternary operator with umax()

Tamim Khan (2):
      ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MU
      ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MJ

Thomas Wei=C3=9Fschuh (6):
      ACPI: AC: constify powersupply properties
      ACPI: SBS: constify powersupply properties
      ACPI: battery: constify powersupply properties
      ACPI: battery: use sysfs_emit over sprintf
      ACPI: battery: create alarm sysfs attribute atomically
      ACPI: SBS: manage alarm sysfs attribute through psy core

Thorsten Blum (1):
      ACPI: NUMA: Consolidate header includes

Tony Luck (2):
      ACPI: LPSS: Switch to new Intel CPU model defines
      ACPI: x86: Switch to new Intel CPU model defines

---------------

 drivers/acpi/Makefile                   |   1 +
 drivers/acpi/ac.c                       |   2 +-
 drivers/acpi/acpi_pad.c                 |  19 +++-
 drivers/acpi/acpi_processor.c           |   4 +-
 drivers/acpi/acpi_tad.c                 |   1 +
 drivers/acpi/acpi_video.c               |   8 +-
 drivers/acpi/battery.c                  |  37 ++++---
 drivers/acpi/bus.c                      |   2 +
 drivers/acpi/cppc_acpi.c                |   4 +-
 drivers/acpi/fan.h                      |   9 ++
 drivers/acpi/fan_core.c                 |   4 +
 drivers/acpi/fan_hwmon.c                | 170 ++++++++++++++++++++++++++++=
++++
 drivers/acpi/numa/hmat.c                |   6 +-
 drivers/acpi/platform_profile.c         |   1 +
 drivers/acpi/pmic/intel_pmic.c          |   2 +-
 drivers/acpi/pmic/intel_pmic.h          |   4 +-
 drivers/acpi/pmic/intel_pmic_bxtwc.c    |   4 +-
 drivers/acpi/pmic/intel_pmic_bytcrc.c   |   4 +-
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c |  17 ++--
 drivers/acpi/pmic/intel_pmic_chtwc.c    |   7 +-
 drivers/acpi/pmic/intel_pmic_xpower.c   |  11 ++-
 drivers/acpi/resource.c                 |  14 +++
 drivers/acpi/sbs.c                      |  29 +++---
 drivers/acpi/video_detect.c             |  16 +++
 drivers/acpi/x86/lpss.c                 |   4 +-
 drivers/acpi/x86/utils.c                |  44 ++++-----
 include/linux/acpi.h                    |   5 +-
 27 files changed, 338 insertions(+), 91 deletions(-)

