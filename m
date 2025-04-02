Return-Path: <linux-acpi+bounces-12652-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5083A7919A
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 17:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0C216F48B
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 15:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14348635A;
	Wed,  2 Apr 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv20uYzl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979E123AE7C;
	Wed,  2 Apr 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606006; cv=none; b=VBqzHDtM77OT1iAg2Kfo8r//C6VwgNJ8ope0nrl++weB3B+EWFF6DEDJg1/zIKcsoXAokMEahd1+CYzyAhoDHiRqR02+MXvVvxlOpWSgbSCqY61NGIUTYwLYrruDJvyXVLDtYA6VtFpYvBsKoLC8sWpJFiEMHAvQ6wa26uCZl3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606006; c=relaxed/simple;
	bh=gkTDlBLspVsDUeTz3Xteu6bE9B4OIpL6/8gC3s6pajo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eMZgqLqhpQ8aUZhVbxYHOoXJ3476J4gROh87uCo6RGMQUowVIQtCcMFxR2+xmzIMlkdAu5PcEZhz72VtM2DhVT4Y8HnTWHJ9vz4EtZduZxACzICaouJdftz4pUZ4+FkCmVNDd/aC6/tRVI9ydtUUVswOmUYK3K+srfFoLqxovKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv20uYzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F0BC4CEDD;
	Wed,  2 Apr 2025 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743606006;
	bh=gkTDlBLspVsDUeTz3Xteu6bE9B4OIpL6/8gC3s6pajo=;
	h=From:Date:Subject:To:Cc:From;
	b=jv20uYzl2hoDJG0WGnpQd0St6H3Z19cQwZoGZFRMV+cAWQ7qNV4kFy2iz7RoqGYUy
	 CFNub+wuodsMfYahnE4BPzgSpUkpXql94e9NBxrk8BnNPCyvgCIdTwV/tyv+vh0LUP
	 fzD8l1PcmEoVdZt/uSZbzCaqb0NMF3Sdfx8r270w4NBj+R50HqjToEZLrTKM+IK97Q
	 jqr4pKwlPwnFVTPOspOAZIh1T3EVoalR0MaYeacpCjHzvw0GzvqZjTYJAapkZ7JQgy
	 ln+L7wUr9X4IBI/vyMvhrDzuFCF3Rlqnp9J9NWqMo+myaP9mgt3QIfiXV7uTqvsPAE
	 P80z3+u3bHLMQ==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c14138668so1637624a34.2;
        Wed, 02 Apr 2025 08:00:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVuaS66E/7uo3JyDtMo/VCSyHLLcFo7EaNpjFxHd7Cg2MOu2xmtZeJy/s4sfTdUF4uP5dXODJlXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwsU8O1Yd84BjcykT4/9jkmNucTQI0qXVnjBv/KS2P6PrmOPR2
	jolCWYK9PygsWo/5Q9ZARDuqFDKEmOAEndq80WtNoR8lLGqsOukGaWoEPtkGma1ZTIPIq8Nv8Li
	cg+lpnZ5y6GOqM/uhjStVPsujZ6E=
X-Google-Smtp-Source: AGHT+IE5oqwISwQehu9eNdF5AQbKiisSs0JngsBv/p6GfDXWgEdO8QaFWKWkkdBaXlSbn+xOdgrKkwqIkcYT6J8tKuE=
X-Received: by 2002:a05:6830:4129:b0:72b:9196:c15c with SMTP id
 46e09a7af769-72c6376d558mr8869774a34.6.1743606005216; Wed, 02 Apr 2025
 08:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Apr 2025 16:59:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gtr2acS0ZNux5TzHrawoxC6jD474H1s-_MHBQPAe3fkA@mail.gmail.com>
X-Gm-Features: AQ5f1JpH3iy5XIProJMzMZmb6DlVsrpsMkn9qtpwW6zLuKbMA1JwtDfUPBV2pg0
Message-ID: <CAJZ5v0gtr2acS0ZNux5TzHrawoxC6jD474H1s-_MHBQPAe3fkA@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v6.15-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.15-rc1-2

with top-most commit 5bf46fe2b84cda662062f7aca73e15602c76a844

 Merge branches 'acpi-video', 'acpi-platform-profile' and 'acpi-misc'

on top of commit 21e0ff5b10ec1b61fda435d42db4ba80d0cdfded

 Merge tag 'acpi-6.15-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI/PNP updates for 6.15-rc1.

These are fixes and cleanups on top of the previous ACPI material for
6.15-rc1 merged recently:

 - Extend the Lenovo Yoga Tab 3 ACPI quirk to skip GPIO event-handlers
   along with ACPI AC and battery which makes it work with Linux when
   started in the Windows mode (Hans de Goede).

 - Prevent the ACPI processor idle driver from being used on systems
   without _CST and with invalid C2/C3 in FADT in order to restore its
   previous (and expected) behavior that has been altered inadvertently
   by a recent code change (Giovanni Gherdovich).

 - Skip ACPI IRQ override on ASUS Vivobook 14 X1404VAP to make the
   internal keyboard work on it (Paul Menzel).

 - Make the ACPI backlight driver handle fetching EDID passed as
   ACPI_TYPE_PACKAGE which is not specification-compliant, but
   has been encountered in the field (Gergo Koteles).

 - Simplify the aggregation of choices in the ACPI platform-profile
   driver which has been unlocked by recent modifications of that
   driver (Kurt Borja).

 - Use str_enabled_disabled() instead of hardcoded strings in the ACPI
   code related to NUMA (Thorsten Blum).

 - Add Intel OC Watchdog device IDs to non-PNP device list to prevent
   PNP from claiming the devices that carry these IDs in which case
   non-PNP drivers cannot bind to them (Diogo Ivo).

Thanks!


---------------

Diogo Ivo (1):
      ACPI: PNP: Add Intel OC Watchdog IDs to non-PNP device list

Gergo Koteles (1):
      ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE

Giovanni Gherdovich (1):
      ACPI: processor: idle: Return an error if both P_LVL{2,3} idle
states are invalid

Hans de Goede (1):
      ACPI: x86: Extend Lenovo Yoga Tab 3 quirk with skip GPIO event-handlers

Kurt Borja (1):
      ACPI: platform_profile: Optimize _aggregate_choices()

Paul Menzel (1):
      ACPI: resource: Skip IRQ override on ASUS Vivobook 14 X1404VAP

Thorsten Blum (1):
      ACPI: NUMA: Use str_enabled_disabled() helper function

---------------

 drivers/acpi/acpi_pnp.c         |  2 ++
 drivers/acpi/acpi_video.c       |  9 ++++++++-
 drivers/acpi/numa/srat.c        | 22 ++++++++--------------
 drivers/acpi/platform_profile.c | 13 +++++--------
 drivers/acpi/processor_idle.c   |  4 ++++
 drivers/acpi/resource.c         |  7 +++++++
 drivers/acpi/x86/utils.c        |  3 ++-
 7 files changed, 36 insertions(+), 24 deletions(-)

