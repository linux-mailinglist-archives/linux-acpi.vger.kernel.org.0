Return-Path: <linux-acpi+bounces-9786-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF539DAD37
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Nov 2024 19:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26E816601D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Nov 2024 18:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235F42010ED;
	Wed, 27 Nov 2024 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glrBKOyd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A6D1FCD1B;
	Wed, 27 Nov 2024 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732732656; cv=none; b=PK6ryht0dq29FlIXd7X6q1zVrJiiCzjVOy6Rst31pmD52QP9yp+2y9diTiJvo79Ot+cqGDeEIUdqqLFOe3CFDXy8qxc690ymsq0B5Heq2x8t1I9nRzIXH3E2IvM6lncNBTk3gdgXZC+/wl4zW1SO0L/Qyi5tBDrE4ktLbvUu+x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732732656; c=relaxed/simple;
	bh=wvEICsJpjHmrh93qH8NdEZeaGqgdauRDbw+u+31oSEQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=On9RVt+TdMXjmBBBr0y7m6lREJqb8wYKAgiggX3OmIkkpN3N1T/AwLhWz6icV65hVsI+XpWlohEiGWqjtmkWtHqDrBBeTl7VoetEefKM+S1p77Dgj6SIWfj1KPgSJ5zRJBdAWC2w334RExcJ3vbTks7mWe2vBBRHvmCKyDcGdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glrBKOyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C788FC4CECC;
	Wed, 27 Nov 2024 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732732655;
	bh=wvEICsJpjHmrh93qH8NdEZeaGqgdauRDbw+u+31oSEQ=;
	h=From:Date:Subject:To:Cc:From;
	b=glrBKOydxpjHjsVioexITpL/I8dbqzGIJ3RWoIf8mYXh9dR6D13nzvHZ+S5SIjFoU
	 pT7gKy6Sv2cGLu3xOHFoP97bDesb6NSS2oKr70/thxcefQK5YQAECGnb9qnd8lksmJ
	 jK4vMgP4tO9NavbateQ5T67cq298qUzfj35HPiS6Z4flqJ2GPFY1dTmE84kskbJtjB
	 vf01XR4/2HPn8njYsn7bBcZMENyJ50r3p9eNCygESuq/Y/DLxKZp10DXHnu5u7dZS+
	 ro0je6pN85dPcJhlFNOhlrZUwzyi3zkDKr+4EqqcbhsL27OJTuAZ6y4LEjJLnfbspo
	 HyZQmLWOXuwhw==
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7251d20e7f2so113259b3a.0;
        Wed, 27 Nov 2024 10:37:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmC2J/j01+UCzWKCSQUdMtDZp/KIL2p/qLkStKToaGwxq90s+KQT9iMPPEtgJNKN4L8ggWHjiq/cDdHN8=@vger.kernel.org, AJvYcCW83HxKLW36wVE1y0UhIiXFLXSmgYcfePyXpDd77YVRhv5ohxuW/GRhlC+h3GvWiUT7+e+fHAt5MWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyekYVbPIOSMfLDvtSPb34AvRp0xfKMKO+EFkeE7xk2Kwhbxv/r
	AyZ2ddvqP834NNThgVn9NqUsgitlHHoX6eVNEHkyIhcNUWkGExBp6fOSsIGgkNxHcpyQMAHPzrm
	d/qfSFiRl6ivp9nY9ojSrSrXcGX0=
X-Google-Smtp-Source: AGHT+IGG413EY/PJaxpOvl+HvHWtH4fwsC4xurDql0GkMwR7Pn8MkX1ght6NayCxjnjBTr1VDRs36OlMzYuJkcWP0RE=
X-Received: by 2002:a05:6a00:4654:b0:724:e77f:ffa6 with SMTP id
 d2e1a72fcca58-7253012f899mr5152542b3a.16.1732732655408; Wed, 27 Nov 2024
 10:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Nov 2024 19:37:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jH9yWHEymTNjWTw2h5Vgh4yXjjcYFjpmeRi8kskOwxuA@mail.gmail.com>
Message-ID: <CAJZ5v0jH9yWHEymTNjWTw2h5Vgh4yXjjcYFjpmeRi8kskOwxuA@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v6.13-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.13-rc1-2

with top-most commit 6f683c7feea45cbcd8748aafe73b0c79a6909e26

 Merge branches 'acpi-misc' and 'acpi-x86'

on top of commit 4e9ad033b405336cea3c19b68e2acdf47d88c339

 Merge tag 'acpi-6.13-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 6.13-rc1.

These add a common init function for arch-specific ACPI initialization,
clean up idle states initialization in the ACPI processor_idle driver
and update quirks:

 - Introduce acpi_arch_init() for architecture-specific ACPI subsystem
   initialization (Miao Wang).

 - Clean up Asus quirks in acpi_quirk_skip_dmi_ids[] and add a quirk
   to skip I2C clients on Acer Iconia One 8 A1-840 (Hans de Goede).

 - Make the ACPI processor_idle driver use acpi_idle_play_dead() for
   all idle states regardless of their types (Rafael Wysocki).

Thanks!


---------------

Hans de Goede (2):
      ACPI: x86: Add skip i2c clients quirk for Acer Iconia One 8 A1-840
      ACPI: x86: Clean up Asus entries in acpi_quirk_skip_dmi_ids[]

Miao Wang (1):
      ACPI: introduce acpi_arch_init()

Rafael J. Wysocki (1):
      ACPI: processor_idle: Use acpi_idle_play_dead() for all C-states

---------------

 drivers/acpi/arm64/init.c     |  2 +-
 drivers/acpi/bus.c            |  5 +++--
 drivers/acpi/processor_idle.c | 12 ++++++------
 drivers/acpi/riscv/init.c     |  2 +-
 drivers/acpi/x86/utils.c      | 30 +++++++++++++++++++++++-------
 include/linux/acpi.h          | 12 +-----------
 6 files changed, 35 insertions(+), 28 deletions(-)

