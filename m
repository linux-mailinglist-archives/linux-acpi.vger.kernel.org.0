Return-Path: <linux-acpi+bounces-6665-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1915C91B9AD
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2024 10:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2F71C22CFF
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2024 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8656145354;
	Fri, 28 Jun 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7XQ5ge1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A2E14262C;
	Fri, 28 Jun 2024 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562906; cv=none; b=jvKbkwaguMagjIS5SPULwTfpckXFbPzodnDaQt/ZxwA5UCbzkF7UwqW1tP8t4qtuXb+VhC4fs7jTJ+983BnjyszeOSSwGQT/c5VbU/+XxsUEmyuMAVoI8rWXPa2PePHj1mGj24GamWv6PLZ474KX3rsppNwsSeiDKko8jfIGu+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562906; c=relaxed/simple;
	bh=TqNqAzLtzotdvNX29kX+BIiR68e5CuyVDrsotPClK3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sfP7kQWiXpGQYp0a70KtoFYVq23aEpX9jkJvmCnea/Z68aSEtksenD6aHIQK453WJVScGUKnAl6Un83l4oUsleVL1Zpw781nhELPIlzctr8Kz9uw5ZV3ypgkDbMc+Cu3dQiOpcNiEEfoKvx+sBVpQoyRtBJHXzJV6aqTnkRGlaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7XQ5ge1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719562904; x=1751098904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TqNqAzLtzotdvNX29kX+BIiR68e5CuyVDrsotPClK3k=;
  b=T7XQ5ge1E7hHMoKMVIK1BjuSsdTSd/o0qnAeyMCQhN1JeY+qcg8Xigna
   k023kKyoNU/ObJ4iW/c/RhddEsUzFz7PaQaCZnj66On7qXh7we5V6+7Zn
   hucKSU34vxQxisvW1GmGfU/b35fM/i+EYIzal+IICbqsq3lC/5b9JDBnb
   nD0gQ9tpvSagciD5gvzNJpJ3XfQ6Li9e/mTHwhSepPXJF3QnbuO8RAlgM
   j96Mnm//MAuKaHJ3wLsuA0wan1iCtXodLJTruJysX/fKC0OFSrvNKDyNc
   ZxKdonO8R4DKi7vbyARrxyNdDYDNUzt62Dpo3CQ4WajZuA4yNINjskjha
   w==;
X-CSE-ConnectionGUID: hw7FoA7fQz+L18viOajY5w==
X-CSE-MsgGUID: B6dloLQgRUStTUS5UjdOjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16866536"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16866536"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 01:21:44 -0700
X-CSE-ConnectionGUID: 0+zLxO8aTdSI3CjImTLAMA==
X-CSE-MsgGUID: tYYMPhRyQKCyfl3p5xhurw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="75401515"
Received: from unknown (HELO zhiquan-linux-dev.bj.intel.com) ([10.238.156.102])
  by orviesa002.jf.intel.com with ESMTP; 28 Jun 2024 01:21:41 -0700
From: Zhiquan Li <zhiquan1.li@intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	kirill.shutemov@linux.intel.com,
	x86@kernel.org
Cc: rafael@kernel.org,
	hpa@zytor.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhiquan1.li@intel.com
Subject: [PATCH v2] x86/acpi: fix panic while AP online later with kernel parameter maxcpus=1
Date: Fri, 28 Jun 2024 16:21:19 +0800
Message-Id: <20240628082119.357735-1-zhiquan1.li@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue was found on the platform that using "Multiprocessor Wakeup
Structure"[1] to startup secondary CPU, which is usually used by
encrypted guest.  When restrict boot time CPU to 1 with the kernel
parameter "maxcpus=1" and bring other CPUs online later, there will be
a kernel panic.

The variable acpi_mp_wake_mailbox, which holds the virtual address of
the MP Wakeup Structure mailbox, will be set as read-only after init.
If the first AP gets online later, after init, the attempt to update
the variable results in panic.

But it is worth noting that the memremap() function that initializes the
variable cannot be moved into acpi_parse_mp_wake() because memremap() is
not yet functional at this point in the boot process.

[1] Details about the MP Wakeup structure can be found in ACPI v6.4, in
    the "Multiprocessor Wakeup Structure" section.

Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>

---

V1: https://lore.kernel.org/all/20240626073920.176471-1-zhiquan1.li@intel.com/

Changes since V1:
- Amend the commit message as per Kirill's comments.
---
 arch/x86/kernel/acpi/madt_wakeup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 6cfe762be28b..d5ef6215583b 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -19,7 +19,7 @@
 static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
 
 /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
-static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_after_init;
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
 
 static u64 acpi_mp_pgd __ro_after_init;
 static u64 acpi_mp_reset_vector_paddr __ro_after_init;

base-commit: e2009f68e1a9d07467dc833fc2b0c3a7e9c19f37
-- 
2.25.1


