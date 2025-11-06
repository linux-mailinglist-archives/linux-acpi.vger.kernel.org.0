Return-Path: <linux-acpi+bounces-18609-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F45C3D7F6
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 22:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE663AB12D
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 21:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD95306B21;
	Thu,  6 Nov 2025 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbUOsWsl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD92FD689
	for <linux-acpi@vger.kernel.org>; Thu,  6 Nov 2025 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464486; cv=none; b=F2SpRrfV0d+usHkpG0TczqvFSFEsRxXPDMrrkyC09oFcCFxdNunP1QDQnpjfTNt/KBltepdZJskAmCJwybJUzBW4tIyHuZFPWMysKJ6Dgv326Dor4ouVlti3b9rbB5z6ffi3D6WjQ3heeEkzYp9AvY71wJQH8rZZcVN+JQTUZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464486; c=relaxed/simple;
	bh=K0MBA/NDjuYhSJlc9XQF6LJrAQaSHSLl0UPjoCj5H8A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MpoMQttl6/vRN7UJ/MdmLHrZAO/3J+irL2o1gDWo8d1xK4ElpeHU4/FKF6pN1gXz15/xopz1DH3O/gAGBEdF+xJ3Jrprj7F4KLhCDuHHn7nOOdXZ72EDUnkRRT3p8n5B+94HboopcE8oRmcNJPWL1RMnX0N+eJ0SytQek7i1y9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbUOsWsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9391C16AAE
	for <linux-acpi@vger.kernel.org>; Thu,  6 Nov 2025 21:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762464485;
	bh=K0MBA/NDjuYhSJlc9XQF6LJrAQaSHSLl0UPjoCj5H8A=;
	h=From:Date:Subject:To:Cc:From;
	b=ZbUOsWslDgugyGr+2L60nMe2KRy1Y6Vv5n5qT9wHgQkTqi6gED/OFMrwyZi2+6XvG
	 JPIYi134LUawbNLQipF4AeBO+v9g8CVRjBmzBZWr9Yc6ZWoCdozq7xq7gsupu9Ikro
	 b26SFwdsgjoZMgGppxdATsfC+1aH5a2pUvW6N2SNakluoAHs4TN/fglSfn10xpYWY2
	 Gq5BrzoNPdvnYKzuhGff8l8Mc72SXqBVjdiWu3i3dhfo+4YZ4T1JMBSBOhjJG6BUgo
	 lHj9wZo8HVACOQ4OC8HlctLxTRY3QlAwnCaUSw0jMY+8Mt5kiSfHjxGFn8+6UA1JBk
	 xGLedD/LbIDNA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45015646170so54960b6e.0
        for <linux-acpi@vger.kernel.org>; Thu, 06 Nov 2025 13:28:05 -0800 (PST)
X-Gm-Message-State: AOJu0YyOwUkaTkNi+2ZFEtk8kqT3l0x8TsfaaL2vuKuxjiT1Ie2o/1rH
	3Cpx1JLoyrhq8QXI7Yk4e5Nl+rLEJ4mpMzkDldTbQs3Jen5cXPf0ZHpbn+IzbThG7M/uTEjfxxO
	xGaNNJd4w/UptHKQ74KrVoGifhTQL2MY=
X-Google-Smtp-Source: AGHT+IF7dXr2RjLUY6C1fn8TVkoQlFIs4Kvq8HgR0agdfLt+A1tmPiUwMKNIMRKDuTeki2c06C7v7pnTpBbzrMNIFWE=
X-Received: by 2002:a05:6808:4f2a:b0:44d:c03e:657a with SMTP id
 5614622812f47-45015cf2fc2mr529707b6e.7.1762464485311; Thu, 06 Nov 2025
 13:28:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Nov 2025 22:27:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0heXyzAAP5mH-kP9iS9yGJ-ceGFUJG5m-FL-rMMWx4eJg@mail.gmail.com>
X-Gm-Features: AWmQ_bmo8bBBfH4_s2z-itlUMPz6AjaSxaBC6mGyOgstB6XZR-N0AaE5S4zWuOw
Message-ID: <CAJZ5v0heXyzAAP5mH-kP9iS9yGJ-ceGFUJG5m-FL-rMMWx4eJg@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.18-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.18-rc5

with top-most commit 771e8f483583728cd2ef164f7c2256c4bf2adf4c

 Merge branches 'acpi-cppc' and 'acpi-docs'

on top of commit 6146a0f1dfae5d37442a9ddcba012add260bceb0

 Linux 6.18-rc4

to receive ACPI support fixes for 6.18-rc5.

These fix a coding mistake in the ACPI Smart Battery Subsystem (SBS)
driver and two documentation issues:

 - Fix computation of the battery->present value in acpi_battery_read()
   to work when battery->id is not zero (Dan Carpenter)

 - Fix comment typo in the ACPI CPPC library (Chu Guangqing)

 - Fix I2C device references in two ASL examples in the firmware guide
   that were broken by a previous update (Jonas Gorski)

Thanks!


---------------

Chu Guangqing (1):
      ACPI: CPPC: Fix typo in a comment

Dan Carpenter (1):
      ACPI: SBS: Fix present test in acpi_battery_read()

Jonas Gorski (1):
      Documentation: ACPI: i2c-muxes: fix I2C device references

---------------

 Documentation/firmware-guide/acpi/i2c-muxes.rst | 8 ++++----
 drivers/acpi/cppc_acpi.c                        | 2 +-
 drivers/acpi/sbs.c                              | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

