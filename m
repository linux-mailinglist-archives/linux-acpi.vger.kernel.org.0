Return-Path: <linux-acpi+bounces-14367-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F984AD9615
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 22:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64173A7C55
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 20:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6702475E8;
	Fri, 13 Jun 2025 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCKT19Gm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B24B1F3B83;
	Fri, 13 Jun 2025 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845793; cv=none; b=em44B9bHGFu5ip4YRv6bKV04Wsq90sVYDTvZ7AY8bhXxOVObeI74SJabupKIDs1QIoPFf58p0dRP0xQci2BR7x1GiWAhshpVO+mYSd0KpYut4OMAyl6UC+T83P+JTv1nf9IHER3u01K18pB2W7APYffpVdlXReY88HCOWpxth0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845793; c=relaxed/simple;
	bh=w4/ByWG7OueVLs+FxwLX/dyXL6d1GivBhZf1yaBEL8k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=B6pN+IVWfCiTSPZrXXgh3pjzHmuad09azIAzE8hDOYY27KI45oSkdrbZKp0kg//FRVwkfjVD81BcqZcYu70WSZYaL2yBHVy07H/GnClg7GGPoA2LAMND7qPEsDk0ZSjMBU1u9WUPpClr1auwf4J2IlsGEfPGYpzcTgLTQufZ0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCKT19Gm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF54C4CEF0;
	Fri, 13 Jun 2025 20:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749845792;
	bh=w4/ByWG7OueVLs+FxwLX/dyXL6d1GivBhZf1yaBEL8k=;
	h=From:Date:Subject:To:Cc:From;
	b=eCKT19GmIQ0VsG+MMhIqKt1wwXGhrS0eYrgcnPdfZJC1ZF0ClEtOb9EvnDz1h7345
	 AOPPmDXGOvM6oPuyHCoegzS7beAAKmyb4YUKL1bW48RG0wV6mi57gp+wh3bkC7Q1y1
	 GahKdD9q5i5/Gp4FEJGwLuDWA+qmFUWjP89ZMSRscOzfajb7AxoQq6Z7sLHyEZIHOz
	 40ZWKnOtvrH0sAfC6QIos7fH8i73qkfT4EkCH9QuWiX/Ux2ikJ1O8B49CJURASpRnu
	 WJkjXpX2dcnwkYULNIaOtafHnd2sOSHuLxG1BToDNyRBdSiBLPYzvZqGa6RuHMKSPC
	 t3w8HFCR7zRrg==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-60b8a9be972so722282eaf.1;
        Fri, 13 Jun 2025 13:16:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJBEqSD/nHFzv2fidGwLUm8EFHi+WbeArrnJVf7kQGMIIb9mLzJb/a51Uv1tRsRv6FmFxWaHF1rE28xvk=@vger.kernel.org, AJvYcCWi/aMJ0dAGZxJRr8wAUQEeR+oZYtnefV06shwpvOhStCHct5N7puVlJZxkqhckCOyPNAI9XDF2F28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTU5AohTHsaOt/MYQ0q5/y2ie5ATzyNu/yZl+qBjxZ00D6tKAI
	HoUYrUGl7EUlI/rQXzqNTjohYuYDeEbHypXI7SMybvv0Df35pSiE56Z9asThcHu18zQ9b4vJfjK
	jmwSetCESBsNPIgcystLsgnTa2MHIOWw=
X-Google-Smtp-Source: AGHT+IH8UYXZPGHXIMPkSSA3bfF2W7YegnQWJ1Mh7LS/3U1vKcDV+3JSdvddY+L6+6uGH7Hl0cgx6qpFYpjqgu08e0g=
X-Received: by 2002:a05:6820:16a2:b0:60f:446e:2ac3 with SMTP id
 006d021491bc7-61110d9c278mr552093eaf.0.1749845792084; Fri, 13 Jun 2025
 13:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Jun 2025 22:16:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i=QhToT6d7jKUUTfm8HbH2FyfEk8xDF5NRj4JFKqtBLA@mail.gmail.com>
X-Gm-Features: AX0GCFsP8SR_uP7YbV32DxY1vfq1UMgZBGo6YtG_AkJK3UlXxpKsf0-yEOvY2Jk
Message-ID: <CAJZ5v0i=QhToT6d7jKUUTfm8HbH2FyfEk8xDF5NRj4JFKqtBLA@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.16-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.16-rc2

with top-most commit 28b069933d39708af872d9739e78315317b93031

 Merge branches 'acpi-pad', 'acpi-cppc', 'acpi-ec' and 'acpi-resource'

on top of commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494

 Linux 6.16-rc1

to receive ACPI updates for 6.16-rc2.

These fix an ACPI APEI error injection driver failure that started to
occur after switching it over to using a faux device, address an EC
driver issue related to invalid ECDT tables, clean up the usage of
mwait_idle_with_hints() in the ACPI PAD driver, add a new IRQ override
quirk, and fix a NULL pointer dereference related to nosmp:

 - Update the faux device handling code in the driver core and address
   an ACPI APEI error injection driver failure that started to occur
   after switching it over to using a faux device on top of that (Dan
   Williams).

 - Update data types of variables passed as arguments to
   mwait_idle_with_hints() in the ACPI PAD (processor aggregator device)
   driver to match the function definition after recent changes (Uros
   Bizjak).

 - Fix a NULL pointer dereference in the ACPI CPPC library that occurs
   when nosmp is passed to the kernel in the command line (Yunhui Cui).

 - Ignore ECDT tables with an invalid ID string to prevent using an
   incorrect GPE for signaling events on some systems (Armin Wolf).

 - Add a new IRQ override quirk for MACHENIKE 16P (Wentao Guan).

Thanks!


---------------

Armin Wolf (1):
      ACPI: EC: Ignore ECDT tables with an invalid ID string

Dan Williams (3):
      driver core: faux: Suppress bind attributes
      driver core: faux: Quiet probe failures
      ACPI: APEI: EINJ: Do not fail einj_init() on faux_device_create() failure

Uros Bizjak (1):
      ACPI: PAD: Update arguments of mwait_idle_with_hints()

Wentao Guan (1):
      ACPI: resource: Use IRQ override on MACHENIKE 16P

Yunhui Cui (1):
      ACPI: CPPC: Fix NULL pointer dereference when nosmp is used

---------------

 drivers/acpi/acpi_pad.c       |  2 +-
 drivers/acpi/apei/einj-core.c |  9 +++------
 drivers/acpi/cppc_acpi.c      |  2 +-
 drivers/acpi/ec.c             | 17 +++++++++++++++++
 drivers/acpi/resource.c       |  7 +++++++
 drivers/base/faux.c           |  3 ++-
 6 files changed, 31 insertions(+), 9 deletions(-)

