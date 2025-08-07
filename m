Return-Path: <linux-acpi+bounces-15565-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B62FB1DB37
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 18:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD06622F89
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BAF26CE0C;
	Thu,  7 Aug 2025 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBU4NeT6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D226A1A3;
	Thu,  7 Aug 2025 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582569; cv=none; b=jqZJlrRvtT0co4cF4Wbzt7cxHPs8imayBU0erBiwsiG4sMxVOBqjObCyzNvaXbGt11dRQu+CiuW8QaR/7aG/PCcdGtZVAkpwVpMy9mHQBJL0FCtN9VmIDIG1nskgMXu9Lns6/Dpzj0+FPhN72z7mkiWkvG4HmtQfldFofdRi5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582569; c=relaxed/simple;
	bh=3JhWBhxd2u70kwy8Fen3Rx2vHh8BecM7RUudztSQYwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qhwGiY+0nNFRSLE0F5l1jn+MZ5XvODbpDcJRoiWUFGJK5cdgG4qOkQeR3ErXOhYIhkwpAsKPHgkEiozdu+l+o8ST96feTCaqiJb2Mcf6TcTV9MQs0bGVIVnsR1fyedxiV1jIAZ9l8zDEvj4zPXAxZDcoJe2qIJLrSQI4Am6zLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBU4NeT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28387C4CEEB;
	Thu,  7 Aug 2025 16:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754582569;
	bh=3JhWBhxd2u70kwy8Fen3Rx2vHh8BecM7RUudztSQYwM=;
	h=From:To:Cc:Subject:Date:From;
	b=UBU4NeT60VIIRgJIaHmZJrxCXiGEDs0rTAOjkkvGNBHiMCwfi5y+xN6dQ2WC+tN+z
	 uKQ18YQQLngICsSV2A764i+YeYeYewuyQLmSkikL8V66E4iyiGk2i3bvfnTQMgw96E
	 9uLSo1wUAUC+fC4a+Y9wNbcsKzili1JXadhgxtvbg7TyIBPlf9vTmGOa6SxckIQhPP
	 d+cE1c+BzvOfUqipMk2p3NQlTgE2o6xaSOQGPJv5vgnu4muUJb90H3//faatTTfzYQ
	 v1ps+0foHb2ZrlwSmYVgv50yKHGaHUOinEF/3/aowQVAdry3z6MxQLEAFnD2yLpEaq
	 tNeeFle/pynBA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uk34o-004zf7-JQ;
	Thu, 07 Aug 2025 17:02:46 +0100
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
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/4] clocksource: Add standalone MMIO ARM arch timer driver
Date: Thu,  7 Aug 2025 17:02:39 +0100
Message-Id: <20250807160243.1970533-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

For the past 10 years, both Mark and I have been lamenting about the
sorry state of the badly named "arch_timer" driver, and about the way
the MMIO part is intricately weaved into the system-register part.

The time has finally come to have a stab at it.

This small series simply creates a new timer driver for the MMIO arch
timer, and only that. It is an actual driver, and not some kludge that
has to run super early (that's what the per-CPU timers are for). This
allows, in turn, a pretty large cleanup of the per-CPU driver, though
there is more to come -- one thing at a time.

As an added bonus, we get a clocksource, which the original code
didn't provide. Just in case it might be useful. The end-result is far
more readable, and about 100 lines smaller.

Patches on top of 6.16.

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
 drivers/clocksource/arm_arch_timer_mmio.c | 439 ++++++++++++++
 include/clocksource/arm_arch_timer.h      |   5 -
 6 files changed, 531 insertions(+), 630 deletions(-)
 create mode 100644 drivers/clocksource/arm_arch_timer_mmio.c

-- 
2.39.2


