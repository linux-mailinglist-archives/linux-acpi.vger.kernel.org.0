Return-Path: <linux-acpi+bounces-14409-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB1BADCB12
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 14:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8366171A38
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 12:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DDA2D12F6;
	Tue, 17 Jun 2025 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhCaMlyj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF72DE1E7;
	Tue, 17 Jun 2025 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162960; cv=none; b=fsl1bCLOwnYbpc4HDGCiiuSLd20C+EWMZONzdhGkyGYOuvv2UXWF9dkG0gn0ladR7599Gd02DWUH5gXGVKnLNUhOzgqpvKfuhEmyeYjeN8QJJe5kyq0QFEH6dI2Yl/3kX4V6TPOnaMLSzxnGL9BfwfgcgY4zmwqrLUl6zBFpjWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162960; c=relaxed/simple;
	bh=9/iHQ3dYlLrbfQPOjcg+z2GVsbtgfzHHrq+JaTmPNUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jDgX7TBsymmoAx7TzWJlTNCgG3fduF1hkVRa8x+w+qnMLyexKVZZNDNLnZ9ffl9cNSOm3JdkreLLOCD/359c76pDTWfYtZRmPvFGAsm7msm9fJjU6y70oj+goNoTa+6rhrHekf/4txp9M0XjoXwI6IEbdGNJhopCwAosMiZ8p9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhCaMlyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88FEC4CEF0;
	Tue, 17 Jun 2025 12:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750162960;
	bh=9/iHQ3dYlLrbfQPOjcg+z2GVsbtgfzHHrq+JaTmPNUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhCaMlyj5wgG//+RnXhkxdxup8yqBBItPX+AponKeCfhE7/v+OGW5I148zJemlPbI
	 MR0DbR3xDnMkOCJBDvyKxQTza8DZLCjQf0PghiTHE65xXC4gRUYw67R+DW/TNPHDIx
	 flN1jxp4svjX4+hKfeq2VbnPa38HXUs7jh6BnqFB3pNlWoBVrUwX79CzJp8kBL10RI
	 7JOF0XHAxopwycS2f4iZzO1PBzPmu6WwUmaEDsXVvuqa3uWKyQDWnSLM1BzJoKZCuq
	 mp4QwLSsURjRdtzoOjZQvHdbm8zNKvNDNeJ/NdBRi6wFoer9yC3joZYR9qFGgASH97
	 M/Vc/EaMaHmWA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Wentao Guan <guanwentao@uniontech.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 09/12] ACPI: resource: Use IRQ override on MACHENIKE 16P
Date: Tue, 17 Jun 2025 08:22:18 -0400
Message-Id: <20250617122222.1968832-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617122222.1968832-1-sashal@kernel.org>
References: <20250617122222.1968832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.33
Content-Transfer-Encoding: 8bit

From: Wentao Guan <guanwentao@uniontech.com>

[ Upstream commit c99ad987d3e9b550e9839d5df22de97d90462e5f ]

Use ACPI IRQ override on MACHENIKE laptop to make the internal
keyboard work.

Add a new entry to the irq1_edge_low_force_override structure, similar
to the existing ones.

Link: https://bbs.deepin.org.cn/zh/post/287628
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Link: https://patch.msgid.link/20250603122059.1072790-1-guanwentao@uniontech.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Bug Fix for Non-Functional Hardware**: The commit fixes a broken
   keyboard on MACHENIKE 16P laptops. The internal keyboard does not
   work without this IRQ override, which is a significant hardware
   functionality issue that affects users.

2. **Small and Contained Change**: The change is minimal - it only adds
   7 lines to add a new DMI match entry to the existing
   `irq1_edge_low_force_override` array:
  ```c
  +       {
  +               /* MACHENIKE L16P/L16P */
  +               .matches = {
  +                       DMI_MATCH(DMI_SYS_VENDOR, "MACHENIKE"),
  +                       DMI_MATCH(DMI_BOARD_NAME, "L16P"),
  +               },
  +       },
  ```

3. **Well-Established Pattern**: This follows an established pattern in
   the kernel. The code shows this is part of a long-standing mechanism
   for handling keyboard IRQ issues on AMD Zen platforms where "the DSDT
   specifies the kbd IRQ as falling edge and this must be overridden to
   rising edge, to have a working keyboard."

4. **Similar Commits Were Backported**: Looking at the historical
   commits provided:
   - "ACPI: resource: Do IRQ override on TongFang GXxHRXx and GMxHGxx" -
     marked with "Cc: All applicable <stable@vger.kernel.org>"
   - "ACPI: resource: Do IRQ override on MECHREV GM7XG0M" - includes
     both "Fixes:" tag and "Cc: All applicable <stable@vger.kernel.org>"
   - "ACPI: resource: Do IRQ override on Lunnen Ground laptops" - marked
     as YES for backporting
   - "ACPI: resource: IRQ override for Eluktronics MECH-17" - marked as
     YES for backporting

5. **No Risk of Regression**: The change is isolated to MACHENIKE 16P
   laptops only (via DMI matching), so it cannot affect other systems.
   The DMI match ensures this override only applies to the specific
   hardware that needs it.

6. **Critical Functionality**: A non-functional keyboard is a critical
   issue that prevents normal system usage. This is not a minor
   inconvenience but a complete loss of primary input functionality.

The only reason this commit might not have been explicitly marked for
stable is an oversight, as virtually identical commits for other laptop
models fixing the same keyboard IRQ issue have been consistently
backported to stable trees.

 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 14c7bac4100b4..9d9921f70855c 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -666,6 +666,13 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
 		},
 	},
+	{
+		/* MACHENIKE L16P/L16P */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MACHENIKE"),
+			DMI_MATCH(DMI_BOARD_NAME, "L16P"),
+		},
+	},
 	{
 		/*
 		 * TongFang GM5HG0A in case of the SKIKK Vanaheim relabel the
-- 
2.39.5


