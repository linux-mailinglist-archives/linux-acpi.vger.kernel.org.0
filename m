Return-Path: <linux-acpi+bounces-11299-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3729DA3C2BC
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 15:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA59189278F
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA70D1F2B87;
	Wed, 19 Feb 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjG5u3iA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679E1EFFBF
	for <linux-acpi@vger.kernel.org>; Wed, 19 Feb 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976853; cv=none; b=FYxMzXjFqVxS1zki9HvGbhgfgmCEySql7bTak9kRmhMurFGnq5BJUCXyy05/KRvVF4p0qQaN+N2nYv9BdGAJ+dqpA1IqlA0xCS47gDbiOoe4ej374iv6O4RaHz7bxa5GJUd79/8GvAVRnWs/qYLeLMlqI7YymK3WaZyOjyTTclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976853; c=relaxed/simple;
	bh=OwPVvWypU9gkCuwGq3As34g8rm46gzAhcF0Uo5N2BnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7/EREdeMt29+D2uxcz10wSNcifolQX4O7cnvQ3ZBUs4kutNu7NzFjON582BGl54FH6b7bJpdM4dF/iTj7BWN0DQjjM7WcB0nirEjmGfLEAhTpD4WigER1AYbQTYRMoP/2+csCRvEU/Xr/WF1G6xlZ3lMAl8af84tbbXYWz2Ta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjG5u3iA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC251C4CEDD;
	Wed, 19 Feb 2025 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739976853;
	bh=OwPVvWypU9gkCuwGq3As34g8rm46gzAhcF0Uo5N2BnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjG5u3iABifPnL0odnrYeqnOUyPSuZ+wNdHmgW+OTd5qOC+dVD1hVfxumgb4CNJxV
	 FDbW4FHIsLB0j0YQQ2dQCZD1luo+S5T59cmgcjPgQ7kB2h94VW+X990PJsb5Tu+8Px
	 61NiDG2SLx7RPlFiJT2XNiY1CDJB52AEqxJRiSlPpMcDIs5JTDmiExpSshjohpRlTK
	 JIXd2VXjQWJj+7CmOaP9QjMN313VDSe6bD8LurQIaPqbsI9Pbo4j3q7rHcQd9xmV90
	 C4c3tejepfP8IDJByDziQfbi18B7+/er85s4026BOEKKB+yQpVfuCNPxoitdX+Ctnf
	 dHAMvVyImIPXg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org
Cc: kernel test robot <lkp@intel.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/2] ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
Date: Wed, 19 Feb 2025 08:53:12 -0600
Message-ID: <20250219145338.3306745-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219145338.3306745-1-superm1@kernel.org>
References: <20250219145338.3306745-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

acpi_register_lps0_dev() and acpi_unregister_lps0_dev() may be used
in drivers that don't require CONFIG_SUSPEND or compile on !X86.

Add prototypes for those cases.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502191627.fRgoBwcZ-lkp@intel.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 include/linux/acpi.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4e495b29c640f..8e16ca5046e45 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1130,6 +1130,13 @@ static inline int acpi_get_lps0_constraint(struct device *dev)
 {
 	return ACPI_STATE_UNKNOWN;
 }
+static inline int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
+{
+	return -ENODEV;
+}
+static inline void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
+{
+}
 #endif /* CONFIG_SUSPEND && CONFIG_X86 */
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
-- 
2.43.0


