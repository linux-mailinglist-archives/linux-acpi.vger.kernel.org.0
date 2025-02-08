Return-Path: <linux-acpi+bounces-10948-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CB9A2D73A
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 17:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C7E3A765B
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922101F1810;
	Sat,  8 Feb 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJqbzujg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917C1F180C;
	Sat,  8 Feb 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739031741; cv=none; b=KvRS6bF4j+M9TM2vA3ZHTvVz1fnfDp2VGieV6n6F9bMC2nNKqY+AIBqFotb/Yhb7AwW3IQXtoe/s1pTixsBLj5XPy9Swm7h02h2zV3/tvjS3r6uMP3XUptCFWyiJnX2RFbcF4S2G1UlshuHoATVxsT+a3Hj2gVAnt7SrSry7IAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739031741; c=relaxed/simple;
	bh=0Z/q4LhImUSjM76axedPc2BGhzDvkheqOdOCeml5VNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHaFsiJJ8EFvqihIpY6c9UTmj3ZRuUcEUU8X81A0fDwrtn/XovWz5tCbz+aAQf817mEjHHLNLhIwHyI/xjdTww3XlvTse/p1o5WNlT/E4LUC0S7OFH/OBCz7XoD5shin8gb87cGeYtBkuVMCD6t524GE3WjIbZvE0vp2Dq1fN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJqbzujg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A99C4CED6;
	Sat,  8 Feb 2025 16:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739031741;
	bh=0Z/q4LhImUSjM76axedPc2BGhzDvkheqOdOCeml5VNM=;
	h=From:To:Cc:Subject:Date:From;
	b=AJqbzujgtKcb2X23DRqZrRYW/oD5Hvv7xlUJmENZcpJf/hYAyMBGxmpbNo3uyiM/F
	 UdJFfaiQKpSnWI0xaTZZAg9J5wyxRnH5lF16v26i5mwUIUIbEhUNE/yBT2L/54YQ1A
	 84pyMDzrUOlbFoTdESeB1qKZwf3ctEOPiR6shtm/ZUBv/VlBfRWPT/DZVHoMLi4Ek1
	 Slwq9sH5A4X5a/wR9zxwWhzAZBNCOehMVgBNXVNT/ETgP5dfU4+haJcRbCGyzAK/Ib
	 9Ici+FUNp1e3shes/gztAJGeVKtkbTB8dmCD5FiYIvgzKLscPaTfBF0YfWMXf4pmX6
	 2XiqDmVMc7UPQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/4] Improvements to ACPI battery handling over s2idle
Date: Sat,  8 Feb 2025 10:22:06 -0600
Message-ID: <20250208162210.3929473-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

On Windows the system wakes up when connected or disconnected from an
AC adapter. On Linux the system will momentarily wake up but immediately
go back into suspend.

This difference in behavior can potentially expose lower level platform
firmware bugs. For example entering/exiting HW sleep rapidly might not
work properly [1]. It's also inconsistent in that plugging in a dock
might not wake up a system when it should.

This series most notably adjusts that behavior. It also adds a new sysfs
file to determine how much battery was lost over the last sleep cycle
which could aid in userspace statistics and in debugging high power
consumption over s2idle.

[1] https://gitlab.freedesktop.org/drm/amd/-/issues/3929

Mario Limonciello (4):
  PM: Add sysfs file for energy consumed over sleep cycle
  ACPI: battery: Save and report battery capacity over suspend
  ACPI: battery: Refactor wakeup reasons in acpi_battery_update()
  ACPI: battery: Wake system on AC plug or unplug in over s2idle

 Documentation/ABI/testing/sysfs-power |  8 ++++
 drivers/acpi/battery.c                | 62 ++++++++++++++++++++++-----
 include/linux/suspend.h               |  2 +
 kernel/power/main.c                   | 10 +++++
 4 files changed, 71 insertions(+), 11 deletions(-)

-- 
2.43.0


