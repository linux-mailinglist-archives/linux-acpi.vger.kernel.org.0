Return-Path: <linux-acpi+bounces-13066-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11955A8AA18
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 23:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A430E3AB684
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 21:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F0F23370C;
	Tue, 15 Apr 2025 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVO6TwBa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160DF221DA7
	for <linux-acpi@vger.kernel.org>; Tue, 15 Apr 2025 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752466; cv=none; b=WkQL64EaioSmZtCcuptIi3aBKLH2XIwttoUjXqvj/dD0P76GUV3rDd1+PZjH/wkFbILxZov0q0ePp1gdD/InIhuzsG6M7nkwQM88Ew2vpqFMkRkdb3AEnH98M4aK3UWhu7D5YhMOl8FiBERoCt19eecKHlkjp7VxWdECFUQgz+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752466; c=relaxed/simple;
	bh=Us6WNIKZAN3wfuINRj6+CyNGV+uYTLEH18wbtjV4FAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nf/2KffXIyClkXwd4B3i7tEaNgmIS6RAA11Pjkkcn6SRLOH/mZcpXw3PZ+D2LYrCLN+xmK0K/65lRYqBZDA8MuVlnpz4XOH+uAPPozNhveiKodxmlhBdqBOgXo2X86AfrEJiEtVsGWndFsO0v2Jrt4j8fFFlwbu/Z5WfBNv/SsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVO6TwBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA7EC4CEE7;
	Tue, 15 Apr 2025 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744752465;
	bh=Us6WNIKZAN3wfuINRj6+CyNGV+uYTLEH18wbtjV4FAE=;
	h=From:To:Cc:Subject:Date:From;
	b=rVO6TwBaurAuCpT2vkV9wwcgsdq2x20vEQR/UuZVnch0Rb2pk/xeKePRf+1rrHyg/
	 paTBZgnND1hVf1PJb1uFo/8AKXE2JN9id3K4NFKcRYTvyqVTNkxDKRtIXdKoLk+GOm
	 YUKhP6cEACmtPrB7eMly6UJzBh0VmP3CbI3mabsnPicPduvwtj3TDtiMwzC/5zDkYa
	 VsoKvOQe0ERY8c0lz4SwQWcji2BpPc7bNii7mRNjEwLFosfT2cgqFQMMU0qvgv8WpB
	 HaBwTC5Zetw/hOS9MGvtNJ5yMg6Yj9FYAPA/FtB3pNSrzyEIOat8Ia39BTagJSUgPT
	 dx568xRBZMilg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org
Cc: linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: Enable CONFIG_ACPI_DEBUG by default
Date: Tue, 15 Apr 2025 16:27:23 -0500
Message-ID: <20250415212740.2371758-1-superm1@kernel.org>
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
 drivers/acpi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7f10aa38269d2..cb190686499b9 100644
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


