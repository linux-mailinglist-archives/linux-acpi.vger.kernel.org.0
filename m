Return-Path: <linux-acpi+bounces-12810-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E492EA7EC2C
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 21:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED29C443EE2
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 19:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFB254B03;
	Mon,  7 Apr 2025 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elqB0Kyj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BAA21C177;
	Mon,  7 Apr 2025 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051033; cv=none; b=jE6H5hcqYafb3aJgWHi0qrlKHdYRuUhCJx+GTpr7sffqsQZy/FDBRQItEhavtf353Cy+bz1+9YRWdMuMBK2y5AgOZ9ac0hHg0wdEfpiJQQx+TbZboj8OvqdfUNdmHZw2fI/dyTOjf0g5zzMWvZuQM7siTOzjNAPINmts8Z8yJHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051033; c=relaxed/simple;
	bh=h+lvJnkRJtdQAFN1tfI2+LLaA9VaEBrHVfAYKEKH4Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3m+kRSuRiB92Mgm2ekjw6iDTxqXTbgn0no2g00O2ZQfckhRzGHFv07M/jNleoUXPQNrUdwPUKgJUWY5/GYwxIc8cWg1anv+xRtNY3dfAvI8AfccwpOWIyR3r2SJqyjYF6itkx1SUtDOP0gscNcmMJaDjLstd3OJDLsU6JBfIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elqB0Kyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D0DC4CEDD;
	Mon,  7 Apr 2025 18:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051033;
	bh=h+lvJnkRJtdQAFN1tfI2+LLaA9VaEBrHVfAYKEKH4Xo=;
	h=From:To:Cc:Subject:Date:From;
	b=elqB0KyjL4+5Fji6YneruOri6EgOkNsj5nviurtBuwwAMpGfcQ94w0N5epsYvKPGY
	 QK9Cmr56mMRZg2J5FAJ6bzmT5kr1Dz40fgGtb++snaIOabCPqQXcLk4W4e8JIJ/ofd
	 FMyOQ/pn46PLd6h0kcMk8CtZKdN+KWQJ69f8yBJ3K8OWvyF4SqFcpZcgLjiHlkgMtk
	 8UtNTdWCFP83L8tDOfHKIhhJHDC9dNbDKqS7W7P7zWiV3QFqqQfVeFVL9hQBYJgrK1
	 RtSRH5n7YSnlxzwzfQ46uXojocjCJWB+IvtAyAU5ko8udTZiEsghnQ/oTpMZZsSZO3
	 00b3ASZi146Jw==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	linux-acpi@vger.kernel.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v4 1/2] ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
Date: Mon,  7 Apr 2025 13:36:55 -0500
Message-ID: <20250407183656.1503446-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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
v3:
 * Add struct acpi_s2idle_dev_ops outside defines too
---
 include/linux/acpi.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3f2e93ed97301..fc372bbaa5476 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1125,13 +1125,13 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 
 acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
 					   u32 val_a, u32 val_b);
-#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
 struct acpi_s2idle_dev_ops {
 	struct list_head list_node;
 	void (*prepare)(void);
 	void (*check)(void);
 	void (*restore)(void);
 };
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 int acpi_get_lps0_constraint(struct acpi_device *adev);
@@ -1140,6 +1140,13 @@ static inline int acpi_get_lps0_constraint(struct device *dev)
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


