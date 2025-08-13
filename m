Return-Path: <linux-acpi+bounces-15630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D893EB24779
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 12:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CA116276D
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 10:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3F92F49FD;
	Wed, 13 Aug 2025 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct6/nd9K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9532F49F1;
	Wed, 13 Aug 2025 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081371; cv=none; b=dt5IrEH0VZGXOyE1wwOlZ4kVnc/6/P/7Dp2q2PyRGAL32vo4UAfuVnlGzuEzKxqDoAvg1rWsOlObhtSovQDGcB7QyuCLe7hWBZDYcYtbrqEaWDMKZXyF5oPVZa59vBr46liuK4PKvNR7ADleG9lAdoeN7kMipWuw7kjgxHrNZto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081371; c=relaxed/simple;
	bh=WnZLoFzTL8UjoJY0cIQ1vOyAt6jb0dOEkPmZF3J4xJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gq6SJANjHX19czjQfIihD9Ds7WuJI+fFHVMhLo179bCnnSl2l3ladsovP6jpcK4DK3sGT/lec77COdM47p7GQFgQqMnoCNhLk7/CjWlScfu84BpzhX4Nx2Yr1ySH2AgwpvpH11SBx0vF5m6pEEIjTq6QpeTNMpUwpenAs75lH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct6/nd9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF12AC4CEEB;
	Wed, 13 Aug 2025 10:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755081370;
	bh=WnZLoFzTL8UjoJY0cIQ1vOyAt6jb0dOEkPmZF3J4xJE=;
	h=From:To:Cc:Subject:Date:From;
	b=ct6/nd9Kb/oBJxNSWGqDGkBaFRaryzuuVT7fTHJK7aM9VKB42+996yYySg/LS+KQm
	 KF3Xj0UIVxs1sZe2Y2E62TCOSjWsCG3q+go3CkJ17rNZUWggL07RJ37sjJissWBgDK
	 h+ercD8nFwNZFGRp+O+X2auTTzSj75pVHFxcyHb8kmAALuy/k2SHgClCaZVOp5rGQH
	 /0L32gfrvBkyUUmy1x8xKkKk/IHlnMc40zJj0Xibj+ZOv1ihce9CKNaXP2j1U4Ampb
	 8QvvJfHIPlYTJLuJRuRa1JCFVs/6Wikt8lg4R6MM3IZCMRLACwwADitSw0dVWS/T8W
	 15Vu/tCSEAe5A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v1] ACPI: processor: idle: Add module import namespace
Date: Wed, 13 Aug 2025 12:36:04 +0200
Message-ID: <3376499.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new module import namespace called ACPI_PROCESSOR_IDLE for
functions exported from the non-modular part of the ACPI processor
driver to the modular part of it.

Export acpi_processor_claim_cst_control() and acpi_processor_evaluate_cst()
in that namespace to hide them from unrelated modules.

They are also used by the intel_idle driver, but it is non-modular,
so it can call them regardless of the way the symbols are exported.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_processor.c |    4 ++--
 drivers/acpi/processor_idle.c |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -815,7 +815,7 @@
 	cst_control_claimed = true;
 	return true;
 }
-EXPORT_SYMBOL_GPL(acpi_processor_claim_cst_control);
+EXPORT_SYMBOL_NS_GPL(acpi_processor_claim_cst_control, "ACPI_PROCESSOR_IDLE");
 
 /**
  * acpi_processor_evaluate_cst - Evaluate the processor _CST control method.
@@ -994,5 +994,5 @@
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(acpi_processor_evaluate_cst);
+EXPORT_SYMBOL_NS_GPL(acpi_processor_evaluate_cst, "ACPI_PROCESSOR_IDLE");
 #endif /* CONFIG_ACPI_PROCESSOR_CSTATE */
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1431,3 +1431,5 @@
 	pr->flags.power_setup_done = 0;
 	return 0;
 }
+
+MODULE_IMPORT_NS("ACPI_PROCESSOR_IDLE");




