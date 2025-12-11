Return-Path: <linux-acpi+bounces-19548-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB47CB5E03
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 13:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A958300CCDA
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 12:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C42330C63A;
	Thu, 11 Dec 2025 12:34:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.ksb-soft.ru (mail.ksb-soft.ru [5.167.76.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031D1A9FB0;
	Thu, 11 Dec 2025 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.167.76.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456461; cv=none; b=AX34FtCsgR5iCnD9i0PonnsEATPm35lLaUUUBoDfLYiR2l5SSjKG37XkHt8DhqsrLySwP6DMo0pvm8KeTRTG3IYIaqS1P6Oo/+4rH1t1vfpj4R01PYGENy0Tgj9o4ImnKs4HS01xilwkVfViCWAbIusBTpj+cnCciSiif0JLLRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456461; c=relaxed/simple;
	bh=odDAQbgQA3c4km/LwyHrvw9SrvPSWXoSJuS72nK0Jiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EffLHs6WiUv/4tClqcefWZ8uJzALrwPhP+UJ0bgWAbyWwQYxfq5mYBiQvLctJnDUxrVXSaad6juJJ8DlzwB15yf1HKomuMNvbJuZk8NOJlIqdY0FIMVMGhbQ3WvlSu88nCdoIYXygzApFfiF8X7FxXQI3KtNwsJsyPTWYtQbOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=npc-ksb.ru; spf=pass smtp.mailfrom=npc-ksb.ru; arc=none smtp.client-ip=5.167.76.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=npc-ksb.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=npc-ksb.ru
Received: from ksb-289.ksb.ksb-soft.ru (ksb-289.ksb.ksb-soft.ru [10.38.30.64])
	by mail.ksb-soft.ru (Postfix) with ESMTPA id 4dRsKq40thz4LJR1;
	Thu, 11 Dec 2025 15:27:27 +0300 (MSK)
From: Markov Gleb <markov.gi@npc-ksb.ru>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Markov Gleb <markov.gi@npc-ksb.ru>,
	Robert Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ldv-project@linuxtesting.org
Subject: [PATCH] exstore.c/exoparg.c: Add null-check on return_desc->pointer use.
Date: Thu, 11 Dec 2025 15:27:24 +0300
Message-ID: <20251211122725.987-1-markov.gi@npc-ksb.ru>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 197590 [Oct 29 2025]
X-KLMS-AntiSpam-Version: 6.1.1.11
X-KLMS-AntiSpam-Envelope-From: markov.gi@npc-ksb.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 72 0.3.72 80ff96170b649fb7ebd1aa4cb544c36c109810bd, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean
X-KLMS-LinksScanning: Clean
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 10.0.0.7427, bases: 2025/10/29 20:57:00 #27800623
X-KLMS-AntiVirus-Status: Clean, skipped

If the requested length is == 0,
then the length variable will be set to == 0.

Call of acpi_ex_opcode_3A_1T_1R in exoparg3.c
with length == 0 may lead a skip of code block
with buffer initialization so usage of any
buffer fields will lead to dereference of null.

The problem occurs when calling acpi_ex_store
with return_desc as the first parameter.

Added null check to exstore.c to avoid
dereferencing.
Make status change on uninitialized buffer.
If the solution is trivial, this section can be omitted.
Not tried to initialize the buffer again.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Markov Gleb <markov.gi@npc-ksb.ru>
---
 drivers/acpi/acpica/exstore.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index cbc42207496d..791ecf89d71c 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -299,6 +299,12 @@ acpi_ex_store_object_to_index(union acpi_operand_object *source_desc,
 
 			/* Note: Takes advantage of common string/buffer fields */
 
+			if (source_desc->buffer.pointer == NULL ||
+			    source_desc->buffer.length == 0) {
+				status = AE_BAD_PARAMETER;
+				break;
+			}
+
 			value = source_desc->buffer.pointer[0];
 			break;
 
-- 
2.43.0


