Return-Path: <linux-acpi+bounces-11871-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951F9A50E46
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 23:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0303D7A40D5
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 22:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892622661A1;
	Wed,  5 Mar 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dewxnxxT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6C11FCD13;
	Wed,  5 Mar 2025 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741212116; cv=none; b=Sa6yywg8UHRU1cW8jikzFLtKzP6Sy5W/s7fDlDIk20y8Pt+cZT2utA2FpMCFEVWtMV0QTNaR8WvvgldOB2LAvYaisXxcrb6AKZm9J4Xtc8uzWabplC5KziVQzesWyUQdubA+H5i2BFTAULcgsloiZIcBU0j0ZtLuWfZknaPYxG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741212116; c=relaxed/simple;
	bh=ys+1CUcZMRjjGFgzzpjLEIwxQ5C9dqqIXsKsLEGeCHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JctGVkovwQr3TMt7zTDIpmC89mk/xMPVU9B+Skh9iN/yUAd/KZdRgqWexqv3lQXqu0xNsMQZgDXMN9y3UiSHCwJKwNP53y2LL9pyB4jW/OI1sFTLDxW/imgMCbIF+DB2TzKBtHpcppnwY0IcRk1jGk6Wwmbtk3hX2a3+Y9ERi+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dewxnxxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0654C4CED1;
	Wed,  5 Mar 2025 22:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741212115;
	bh=ys+1CUcZMRjjGFgzzpjLEIwxQ5C9dqqIXsKsLEGeCHo=;
	h=From:To:Cc:Subject:Date:From;
	b=dewxnxxTlMLvFhEWLQ6GqGHw5IyX07Q98BbOiRvInex75Ry59hKa+8eGTbzvqarnH
	 0RvlMu0dT489CzjqpWXLVizuH/pS20VyE+ElUVi1++HGJfjjdwj+0EmbbKp6/nNjLB
	 nH23rBil8JK4tXJP4cJ/g03dnDjJTsz8rlODnQ9lv4Xwf4GWPcAnT8vstK0kvKfpHl
	 yAve1ibUIrs4oHeItn8PR8xGT9uGWdmK2rgeLRgWwNqcgTanzIyASW08DMdEuKP148
	 Nw/7xlJOAF5B4VF9E1W9lMPi6BNVdjHG8P/+gpAe4cYMbAJfFyPPj79t23KrcrDj7+
	 11Bk85QGUlsVw==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	linux-acpi@vger.kernel.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 RESEND 0/2] Add LPS0 check() for pinctrl-amd
Date: Wed,  5 Mar 2025 16:01:44 -0600
Message-ID: <20250305220146.3932955-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

During suspend the pinctrl_amd driver disables the interrupts for
any GPIOs that are not marked as wake sources.

This however does not prevent them from changing the wake status
bit during suspend, it just stops the system from waking.

If the system wakes from hardware sleep for another reason (such
as plugging in the AC adapter) this wake bits might be active.

This could potentially cause problems with going back to hardware
sleep.  Add an extra debugging message when PM debugging is enabled
to help identify if this is happening.

---
I'm resending this because kw seemed to have split the patches on
separate mailing lists and the lkp robot didn't know and reported
failures.
No changes from v3 -> v3 RESEND

Mario Limonciello (2):
  ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
  pinctrl: amd: Add an LPS0 check() callback

 drivers/pinctrl/pinctrl-amd.c | 28 ++++++++++++++++++++++++++++
 include/linux/acpi.h          |  9 ++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.43.0


