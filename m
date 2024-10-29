Return-Path: <linux-acpi+bounces-9087-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7D59B514A
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 18:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781231F2425C
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 17:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9924C199924;
	Tue, 29 Oct 2024 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wk5CMGaw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714192F56;
	Tue, 29 Oct 2024 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224156; cv=none; b=kscItqx1BN7g/Aatek3eVsLVz+AVFNIVuIaXmJOf8YTInjDdQCVD1HK92W36VKWt0tZBxR1MAnRB1zN+qzyxOmyAgF8hu58d/wF87rqHtM52JeKs63fS4h01fE51wg18N19HM9yYq60BlqZiP+i0q839OnbGz2OqrlND/xrw7IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224156; c=relaxed/simple;
	bh=oc8pgGQcFdQ8ybpsBOFVVrU/0ICTotD0WDj4WYDh3AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KK5jisJ8NK+c9icaQbAxrZ/jkHzycLxKiQqqB15F7XuzttgJvPsS+qh0MxxK63zS5f+BEgtLrtiWbcf5aueoHc/gn9PHcg5k4y/EAcpZpLYbUB80mJYAM0ig+Bnarr8ZUAuhKc8FzVr/FH9CgTG/lkKp1K4ZdF9haN5znyVC5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wk5CMGaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39229C4CEE5;
	Tue, 29 Oct 2024 17:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730224156;
	bh=oc8pgGQcFdQ8ybpsBOFVVrU/0ICTotD0WDj4WYDh3AE=;
	h=From:To:Cc:Subject:Date:From;
	b=Wk5CMGawl4iSjxgRYfbq4GTu+DBD8Jj0YQD73M5X460ajsO4bI1uBN+q8N+yoXi7+
	 sPKpvZpda+ObyawlFhnGEHk2aYIbf7LfjOuBqY8wlxBSwNWrJGry20f4SK1cdvIu4c
	 Ca83rGxF5bcDl7Hxu+D9K5qMfCBhtATBgHWsMTUmV7TBCZ1Cba7tHi4eWKWTVSXitC
	 tiieJui9rx1JdQzSZ9GV387egr+kumG8YKJ7g244C87tGyqqitY3vBiRgYX9Qfm1Ho
	 eT3vc6iKHLkjQhUaEJVHY/sK9OH+Nm1EPrWNeRGR/+nxcJlfkOUngn/KnmBioBiFCo
	 AzqS7Un1BNNZg==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ivan Shapovalov <intelfx@intelfx.name>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH] ACPI: processor: Move arch_init_invariance_cppc() call later
Date: Tue, 29 Oct 2024 12:49:10 -0500
Message-ID: <20241029174910.600482-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

arch_init_invariance_cppc() is called at the end of
acpi_cppc_processor_probe() in order to configure frequency invariance
based upon the values from _CPC.

This however doesn't work on AMD CPPC shared memory designs that have
AMD preferred cores enabled because _CPC needs to be analyzed from all
cores to judge if preferred cores are enabled.

This issue manifests to users as a warning since commit 21fb59ab4b97
("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn"):
```
Could not retrieve highest performance (-19)
```

However the warning isn't the cause of this, it was actually
commit 279f838a61f9 ("x86/amd: Detect preferred cores in
amd_get_boost_ratio_numerator()") which exposed the issue.

To fix this problem, push the call to the arch_init_invariance_cppc()
macro to the end of acpi_processor_driver_init().

Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()")
Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219431
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/cppc_acpi.c        | 2 --
 drivers/acpi/processor_driver.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index c3fc2c05d8687..f8614771bf32b 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -905,8 +905,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		goto out_free;
 	}
 
-	arch_init_invariance_cppc();
-
 	kfree(output.pointer);
 	return 0;
 
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index cb52dd000b958..59620e7bc6647 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -270,6 +270,7 @@ static int __init acpi_processor_driver_init(void)
 				  NULL, acpi_soft_cpu_dead);
 
 	acpi_processor_throttling_init();
+	arch_init_invariance_cppc();
 	return 0;
 err:
 	driver_unregister(&acpi_processor_driver);
-- 
2.43.0


