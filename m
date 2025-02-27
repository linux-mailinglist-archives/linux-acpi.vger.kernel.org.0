Return-Path: <linux-acpi+bounces-11581-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E65A48A20
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 21:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EC43A6A7A
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 20:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1922D4CD;
	Thu, 27 Feb 2025 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGz4im5T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88FA1AF0C9;
	Thu, 27 Feb 2025 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689459; cv=none; b=Lrgrd5mKn1QEW6Fo46vOjG+3hpKL4pQO17QQRtlP3CC2lQpJP34dWAAmHAEpjr/NJwQOpV3XX6LzWKNhd9VA6PDlP76huQkUCyGJzOXu1jhDe/VDcdvVs47/2reixW0FX9uiSreQgyX3cn+gryPrlNAw1hErakEdWxFVjcATQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689459; c=relaxed/simple;
	bh=yjqzPGCFCKvEVD4WADYW6Hpp8OL0ovQxg+j7io7UBgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQ64+wSTwXw6eOYSySTmXz06+jwAp17lOssJ4NWNmfcsEAPoD5/xaclBrIbNTvg5n2ElxXSmeJLNS6sq9NhI+gLilv85KadHKXob8IuUA5dJse00A68lrCGQmg7OEd/Pwmb9z0L5Wwr87y7ubZ7Vt+/Uo0/Mo1QaTlo3PEJPBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGz4im5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE91C4CEDD;
	Thu, 27 Feb 2025 20:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740689459;
	bh=yjqzPGCFCKvEVD4WADYW6Hpp8OL0ovQxg+j7io7UBgA=;
	h=From:To:Cc:Subject:Date:From;
	b=cGz4im5Tg05craYjuNucetPGiyg5QkJmrexWFwX6Edu9mglwV8UfM68L/WAkv+h/G
	 SyikFH+VcV/DNOHgTRSai9p38q3BjBiCHyVAwFCRaIi2JGlHvgsQHJT4I8KnKLEmvw
	 /huqaA9uaLgy0zF81w9JjHfkwEG9IseqZMYoqKF3Y5zahUoY01aHpFNcNZUob1hZra
	 X5sysAfWQVeKB0Ibf/rZnl42WcYRoxX7oYzb80dQEyyRpOzPMoUEMiBMDtN1k6dLpX
	 OeBh2yYTCakSlDwUpUb0It5YZqZpZAe5cxiGd9EOsK890PD7lOqCPzhdHzSF6GQdiT
	 R/qigpsUrMWHQ==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	Basavaraj.Natikar@amd.com,
	linus.walleij@linaro.org,
	rafael@kernel.org,
	Shyam-sundar.S-k@amd.com
Cc: linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 0/2] Add LPS0 check() for pinctrl-amd
Date: Thu, 27 Feb 2025 14:50:15 -0600
Message-ID: <20250227205049.765309-1-superm1@kernel.org>
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

Mario Limonciello (2):
  ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
  pinctrl: amd: Add an LPS0 check() callback

 drivers/pinctrl/pinctrl-amd.c | 28 ++++++++++++++++++++++++++++
 include/linux/acpi.h          |  9 ++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.43.0


