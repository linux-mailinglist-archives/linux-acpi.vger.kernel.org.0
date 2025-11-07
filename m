Return-Path: <linux-acpi+bounces-18670-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212BAC41525
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 19:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC43A3A9050
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 18:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5638128A705;
	Fri,  7 Nov 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TiRtsq9p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254416F0FE;
	Fri,  7 Nov 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541122; cv=none; b=TFiZ7rueLfZN9/6l6+fW9dFInjIPbFrfivT+WfUjLCtjJuLY3ir4ZL0z7LcC+Bg82+EeSAE4h8Z6/8kboAieeyYrJkUQ+O23bKv8f9I1ZG9De0iaDigbJNyEXSdcB7Jy7zPmjIqEgllo9yPoqyBGtVrOcGeTKvoqJkf+jX9aLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541122; c=relaxed/simple;
	bh=Q8FxDt7eqtqgy06pFP3/HPIuhZ8Iv+3Mro4qoktzN3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9r1Db7IUjUTxooEo0rqj3+GL0QKOLMFzQ4IeNgE5ioBt5V0+9e/1EI9LxbLPB6g5IgtRP0KUYpHDG1MoXN7Le/Dh+eZbKtIfd6yHifwlyXvbWlN7CeJXf63rpFmsi+N1PaT6GoM5hlr2fqas+2Cuc06ecS0fnQEkLie2wtxAuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TiRtsq9p; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762541118;
	bh=Q8FxDt7eqtqgy06pFP3/HPIuhZ8Iv+3Mro4qoktzN3w=;
	h=From:To:Cc:Subject:Date:From;
	b=TiRtsq9pJ9kLRQvjImXlQJgHfqr764uE+hd5JomnbPu1ggma/VmwO/56Rjb9/ipxs
	 vm5dlLweg8uJi45h1sICfLYKKkB3win1IPPw+HcvcnKYMIi+CR1tQ+DUfZ7aVj7Rdr
	 UOpH1AgHw58QDgGpOFfYZfXLX3Ohk5J7/E7KKScLxSmcwo366tU2rgVwLdFHC4dSko
	 h/nFfrv8ZQTHK/L7RpdMD/ueJwNYW260Bb/uJWrThBkAkVu4tCKXysj5uqZssCgZgH
	 9ehJIYvEHv8hLOSvFNvXBdli0IlyknqpoJ6vZDHPdNm1nT3SpeimDNWSPBM61Y65r3
	 sEOgb1zHJGdLA==
Received: from mt.tail9873f4.ts.net (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3E54317E0927;
	Fri,  7 Nov 2025 19:45:14 +0100 (CET)
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
Subject: [PATCH 0/4] PM: Hibernate: Add hibernation cancellation support
Date: Fri,  7 Nov 2025 23:44:27 +0500
Message-ID: <20251107184438.1328717-1-usama.anjum@collabora.com>
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

The hibernation cancellation support isn't present in very last stage
just before power_down(). I've not been able to handle the error paths
correctly there yet as logs aren't available from that stage. I'll send
that patch separately when it works.

Cc: rafael@kernel.org
Cc: superm1@kernel.org
---
Changes since RFC:
- Update description of patches
- Use pm_sleep_transition_in_progress() instead of
  hibernation_in_progress()

Muhammad Usama Anjum (4):
  PM: hibernate: export pm_sleep_transition_in_progress()
  ACPI: button: Cancel hibernation if button is pressed during
    hibernation
  Input: Ignore the KEY_POWER events if hibernation is in progress
  PM: sleep: clear pm_abort_suspend at suspend

 drivers/acpi/button.c     | 12 +++++++++---
 drivers/base/power/main.c |  2 ++
 drivers/input/input.c     |  6 ++++++
 kernel/cpu.c              |  1 +
 kernel/power/hibernate.c  |  5 ++++-
 kernel/power/main.c       |  1 +
 kernel/power/process.c    |  1 +
 7 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.47.3


