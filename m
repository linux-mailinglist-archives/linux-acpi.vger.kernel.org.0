Return-Path: <linux-acpi+bounces-15691-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAE9B26B89
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 17:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81CF1CE2482
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 15:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27FF245020;
	Thu, 14 Aug 2025 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkxLPkez"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8835242D70;
	Thu, 14 Aug 2025 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186390; cv=none; b=qX/EFIigm5NtYXNS7+O7hFTJTVGZsoSzCwyRJ3H3qdoNH8JVG+CpnE1hWJpUTIEPUymOnXw3BAfYxaYWrD3CGkJ2umh7PYR7D67atlhWv9a+TQdXsufBnAZOype5rEbN0eASDmzAbv4PBelEws3N/yLz9wzhibDu6F04iPXeFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186390; c=relaxed/simple;
	bh=LU2AjF6g6ffItPa2bvywFmHrveZHplbThPGtNa1fwAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g/uHw036iYpY6CMOR5k+L2N5JVbXiEnN8zfzLXrV+dLfLzEHwPmqK8sXdNXZBUt6xiuhQ8D9FCX6c8g3dwLvEEDbaSni8N+7uW8lRJ91UxfUz/H9BcIBJrr2hQF7ffDBTAbT9iQDFw3DMvnmtj4hvWeLgOL+ERojbC4hceZEvQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkxLPkez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EE6C4CEEF;
	Thu, 14 Aug 2025 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755186390;
	bh=LU2AjF6g6ffItPa2bvywFmHrveZHplbThPGtNa1fwAo=;
	h=From:To:Cc:Subject:Date:From;
	b=fkxLPkezxMG4OBdKPxcNEBpXusbQ7qOGmM2EiRkXvhQR7LyxzwdZiL7HdnRWb6dWJ
	 +XHnm2qQgm6HhprZGb8trsrlEz+JQ1DQ7CewnIoq9lrldAP6WhjKycbCTI1ETtcGXl
	 BesJOehqWCxLeTTicF02poMMI+3Nm2C8u0BbyttBnrnGwQVv0q1YqZi9uxhtn2jae/
	 sPxJhjHM14ZaN7ojpydEK2AIX+ZfTBlDBB3i9NhXAmiqmXkG9c/eHJdGhy91AhRn7m
	 oKMzcbYCmYlu6mcmqEb1m9gpQ096oFhYxF7iU25Ratbpo7QE0rBkgX4UeUm97Q7XNL
	 f+R4r8DpQwbGQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uma9p-007VqB-Gu;
	Thu, 14 Aug 2025 16:46:25 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v2 0/4] clocksource: Add standalone MMIO ARM arch timer driver
Date: Thu, 14 Aug 2025 16:46:18 +0100
Message-Id: <20250814154622.10193-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, mark.rutland@arm.com, alexandru.elisei@arm.com, steven.price@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

For the past 10 years, both Mark and I have been lamenting about the
sorry state of the badly named "arch_timer" driver, and about the way
the MMIO part is intricately weaved into the system-register part.

The time has finally come to take a stab at it.

This small series simply creates a new timer driver for the MMIO arch
timer, and only that. It is an actual driver, and not some kludge that
has to run super early (that's what the per-CPU timers are for). This
allows, in turn, a pretty large cleanup of the per-CPU driver, though
there is more to come -- one thing at a time.

As an added bonus, we get a clocksource, which the original code
didn't provide. Just in case it might be useful. The end-result is far
more readable, and about 100 lines smaller.

Patches on top of 6.17-rc1.

* From v1 [1]:

  - Narrow the max delta to something that fits an unsigned long, as
    the core code doesn't deal with 64bit quantities on 32bit CPUs.

  - Collected RBs and TBs from Sudeep, with thanks.

Marc Zyngier (4):
  ACPI: GTDT: Generate platform devices for MMIO timers
  clocksource/drivers/arm_arch_timer: Add standalone MMIO driver
  clocksource/drivers/arm_arch_timer_mmio: Switch over to standalone
    driver
  clocksource/drivers/arm_arch_timer_mmio: Add MMIO clocksource

 MAINTAINERS                               |   1 +
 drivers/acpi/arm64/gtdt.c                 |  29 +-
 drivers/clocksource/Makefile              |   1 +
 drivers/clocksource/arm_arch_timer.c      | 686 ++--------------------
 drivers/clocksource/arm_arch_timer_mmio.c | 440 ++++++++++++++
 include/clocksource/arm_arch_timer.h      |   5 -
 6 files changed, 532 insertions(+), 630 deletions(-)
 create mode 100644 drivers/clocksource/arm_arch_timer_mmio.c

-- 
2.39.2


