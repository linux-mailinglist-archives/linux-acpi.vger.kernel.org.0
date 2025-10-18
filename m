Return-Path: <linux-acpi+bounces-17939-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E6BED14A
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 16:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 727564E375E
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8442E62D9;
	Sat, 18 Oct 2025 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ERKKpJZB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945D51C28E;
	Sat, 18 Oct 2025 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797329; cv=none; b=eMbwOk7GYbYVIhKt6WpG+D4uWa6ubt7X5mUaZxXHAyXW2YbNFa4zF6MRFLfGfFjYLaL2MinQxGCsL7tEoe2lfgaQZ/GAXEKwhu34y5OcKPU/249uYBw78sF70xCGAv/Ph+PCR4dCIkjBGiv15xTPzc82rVDC36wM9m5y5ozVK2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797329; c=relaxed/simple;
	bh=bNCDySUX0gZ9HE/gahHp0G1wmgAlm4IYidL20MOKk7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IK2po3//9jh0BppQ6dKpYaGEV20Ts7Oy8t6whKZQBDYpR7MlJnAFPQRPOBdTVIO/8+NwbfFW5k1ki/w4xmYTzMbzpFYapExUYitClQkPhXdtJns+Ww+pf4Wp/ChVSGe3IfA+g8d2OauZ7JZH7NIX7kEYPhbey4y0O6TMIsQeJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ERKKpJZB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760797318;
	bh=bNCDySUX0gZ9HE/gahHp0G1wmgAlm4IYidL20MOKk7I=;
	h=From:To:Cc:Subject:Date:From;
	b=ERKKpJZBAH3rK1Dd56cHB1lbuRiXRpNRdWseOd9tN156YhrfHe9TUSJ8iuA6SPeWO
	 u/3Zfj2a1f9FcrTZ82yiHGbIZqIWB4zdm180vhyCBCoo5iTj9u9CunGEI6Ib4bVsE2
	 rHt9GpudFaKLhGYg7RM/29qCjMV5SKCf+hQi+5LCJ6MlJGySwpl+XV8tkTLrGC/5mE
	 OT2s2buH1BKDOj43y02aE4U3MX1pmjKlX+LLKo6DW8tMVPxUvOdz6hQnhwCOogiUfK
	 aRleBSk+LZBP0tbBc4kMw57VQqZJNqCRSFC27JqjC7x4nG+4mF0aoRHnZGroAh80Ef
	 vFWEeXHm2Cqlw==
Received: from mt.tail9873f4.ts.net (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 03B5617E0CF8;
	Sat, 18 Oct 2025 16:21:55 +0200 (CEST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	superm1@kernel.org
Subject: [RFC 0/4] PM: Hibernate: Add hibernation cancellation support
Date: Sat, 18 Oct 2025 19:21:03 +0500
Message-ID: <20251018142114.897445-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a normal laptop/PC, the hibernation takes 15-20 seconds which is
considerable time. Once hibernation is triggered from command line or by
some GUI option, the hibernation cannot be cancelled until completed.
Its not a blocker, but poor user experience.

When power button is pressed during hibernation, it generates interrupt
and then the event is routed to userspace. If systemd is being used, the
logind handles these events and performs the specific action.

During hibernation, the first stage is to freeze the userspace. Hence
even if the power button is pressed, it doesn't aborts the hibernation
as user space daemon is frozen.

My device takes ~19 seconds to hibernate. When I was testing hibernation
using rtcwake with timeout of 10 seconds, I found out that hibernation
gets canceled around 10 seconds mark when the interrupt fires.

In this series, the idea is to find a way to cancel the hibernation.
With this series applied, the hibernation gets cancelled gracefully.

Muhammad Usama Anjum (4):
  PM: hibernate: export hibernation_in_progress()
  ACPI: button: Cancel hibernation if button is pressed during
    hibernation
  Input: Ignore the KEY_POWER events if hibernation is in progress
  PM: sleep: clear pm_abort_suspend at suspend

 drivers/acpi/button.c     | 12 +++++++++---
 drivers/base/power/main.c |  2 ++
 drivers/input/input.c     |  6 ++++++
 include/linux/suspend.h   |  2 ++
 kernel/cpu.c              |  1 +
 kernel/power/hibernate.c  |  6 +++++-
 kernel/power/process.c    |  1 +
 7 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.47.3


