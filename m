Return-Path: <linux-acpi+bounces-14229-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C82AD173A
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 05:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C121888AF6
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 03:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C073F9C5;
	Mon,  9 Jun 2025 03:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhVd3czR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D240828F3
	for <linux-acpi@vger.kernel.org>; Mon,  9 Jun 2025 03:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749438436; cv=none; b=THpqJcPSpiEDhztBNGKYxQFcWvGMKXeUVBHow+NMQ/Q682kbiATfGTH5yhLJ7If1KsApAFe0nlr4IjmVjI8ayLrST1OCiA/dLtcKmlHiybKBnb8Q/6cCq37EvaHtClli6Xtfn9hx+tc3zOvkbTKAJGAmS7sKILU8g+eUU/W1Q1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749438436; c=relaxed/simple;
	bh=/HhJIt6xw3RfK7RXWXK61/MtfAFnhoRAgEhkRcN8BgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NV1dWI8aisuy0qltYZWfnwJS/ZLTVPjZ9XC1sMEAhz6hORpc08Dlnr+sMHYD8IvULB4QZpWvGy2fbYskxZTrg8C6XsJe9Gt4JFMwYa3h0j/n3GM5aUr8vr7GbGS5/8sTrP9WJmsnfJFWo53kIi9IvGIqsicvzUhbqoQyQMHK9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhVd3czR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B59C4CEEE;
	Mon,  9 Jun 2025 03:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749438436;
	bh=/HhJIt6xw3RfK7RXWXK61/MtfAFnhoRAgEhkRcN8BgQ=;
	h=From:To:Cc:Subject:Date:From;
	b=fhVd3czRnyMf6IKAiRJsdsfLcT0zZfo8OCcvNAtXBSW8/W/LduYch0jOdosDMqJgx
	 R0Gd5QzvaAr8U0EH7E8JyMA2qiZqeqfpnFJQf1Y5WIJMqEI3lEc1eekWdKzxWHmmLK
	 BLSjg5wsC4dLX+gLqor4VkhGpt7JksBHo8hnNwxQ1wXuhPM/LKokj81mMcrHIBIlcK
	 QaXvL0bJTnYRnNBUJlqGweDh858cjERmJaCm/lF84HBPYTcJFjZJDR2BbWE9AwBRyz
	 f1SM3v3VQaUUVjLLpaYKD55HaMV0W915KP8sQPSGB+OuHnl8DBV2dyunA9DM/G/5GA
	 AqLwBBEsNukvA==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org
Cc: linux-acpi@vger.kernel.org
Subject: [PATCH v2] ACPI: Enable CONFIG_ACPI_DEBUG by default
Date: Sun,  8 Jun 2025 22:07:05 -0500
Message-ID: <20250609030706.465202-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

CONFIG_ACPI_DEBUG can be helpful for getting debug messages on OEM
systems to identify a BIOS bug.  It's a relatively small size increase
to turn it on by default (50kb) and that saves asking people to enable
it when an issue comes up because it wasn't in defconfig.

Enable it by default.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1: https://lore.kernel.org/linux-acpi/20250415212740.2371758-1-superm1@kernel.org/
v2:
  * rebase on 6.16-rc1
  * Fedora, Ubuntu, and CachyOS are all doing this in their distro kernels
    and haven't had any complaints about it.
---
 drivers/acpi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7bc40c2735ac0..b594780a57d71 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -394,6 +394,7 @@ config ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD
 
 config ACPI_DEBUG
 	bool "Debug Statements"
+	default y
 	help
 	  The ACPI subsystem can produce debug output.  Saying Y enables this
 	  output and increases the kernel size by around 50K.
-- 
2.43.0


