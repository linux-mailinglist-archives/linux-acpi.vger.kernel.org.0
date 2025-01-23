Return-Path: <linux-acpi+bounces-10800-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79BAA1A824
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 17:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA0D167B6F
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 16:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B21145B00;
	Thu, 23 Jan 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="ZbOn/ynG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D56613EFF3;
	Thu, 23 Jan 2025 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651086; cv=none; b=URINYtObSYc82w9ctN8DKxLMkKSvRmzSOcBd/RBivEJm1f9xuRhXeKLpI1TiJpnIKAeJZJM6bA5q9y9fRS0Yb40JNQzyg8UuwrVoROxK6Jit4Z/NapQKvj7WBHRO2OZqpZr7M+6rWCBzTGCbFQe6M2Gmsxk30JGyj7b4qbiM84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651086; c=relaxed/simple;
	bh=Z7ty9WVbB0M4TxOo48ZyHFsHyJ48xfUCwM0/dhzUu0Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r9OQJG0KprJG1OjAO2g1hXLJKUvVjDlJaPjoZkvYG13MTUqOqUn3bvYdGoN1HSR88AI9Am4Vbr8gCCsG85H2YP57guFt1xEya/HITsDPOMoCDTW6jXtl4iu63dVcQb9/6Qya733nZM7XMsKUGMfXz3qsM5B6PAcOR1jR+OliUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=ZbOn/ynG; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id A65341E0003;
	Thu, 23 Jan 2025 19:42:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru A65341E0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1737650536; bh=YuwjCf1HyLvGPjp3W8Ochs01wpAdi5nVwsFvz0dXPUU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ZbOn/ynGiW3Sl3IeYlDSaUSDbUGhwQR67umH5VqTktwh0zHbw67eAPtJgGjBnyp82
	 rXSuB2Bd6h7rxYGOghtHfFodPhicirO+Rd65jY729GR7bF9w4D5pjbqiaYXvXFMplq
	 8iQZ8U7FbSuM4VcwHbYRSqBNzz9E2vJrUzTZ24k8Nw7ttlaRYnj0kGPHv+QqMOVAQ4
	 hEsrxaKJf0/KqX9WLCKDpiw9pYvlw7Gr/TAo+He3Z70mo/LAL8oCRdY0hr5LuMUby9
	 TIACU8D9MGenae/F2K9Diw9GTPLWjsYRttNDtaWD81t8q8Qlc/sIL2nRrE/cOt64mC
	 7smuFj8aVPRkA==
Received: from ksmg02.maxima.ru (autodiscover.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Thu, 23 Jan 2025 19:42:09 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.247.8) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Thu, 23 Jan
 2025 19:42:08 +0300
From: Murad Masimov <m.masimov@mt-integration.ru>
To: Dan Williams <dan.j.williams@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Murad Masimov <m.masimov@mt-integration.ru>,
	<stable@vger.kernel.org>,
	<syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com>
Subject: [PATCH] acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
Date: Thu, 23 Jan 2025 19:39:45 +0300
Message-ID: <20250123163945.251-1-m.masimov@mt-integration.ru>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-AntiPhishing: NotDetected, bases: 2025/01/23 15:43:00
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: m.masimov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 50 0.3.50 df4aeb250ed63fd3baa80a493fa6caee5dd9e10f, {rep_avail}, {Tracking_one_url, url3}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg02.maxima.ru:7.1.1;mt-integration.ru:7.1.1;127.0.0.199:7.1.2;81.200.124.62:7.1.2;syzkaller.appspot.com:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 190535 [Jan 23 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/01/23 13:11:00 #27106774
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/01/23 15:43:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

Syzkaller has reported a warning in to_nfit_bus_uuid(): "only secondary
bus families can be translated". This warning is emited if the argument
is equal to NVDIMM_BUS_FAMILY_NFIT == 0. Function acpi_nfit_ctl() first
verifies that a user-provided value call_pkg->nd_family of type u64 is
not equal to 0. Then the value is converted to int, and only after that
is compared to NVDIMM_BUS_FAMILY_MAX. This can lead to passing an invalid
argument to acpi_nfit_ctl(), if call_pkg->nd_family is non-zero, while
the lower 32 bits are zero.

All checks of the input value should be applied to the original variable
call_pkg->nd_family.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 6450ddbd5d8e ("ACPI: NFIT: Define runtime firmware activation commands")
Cc: stable@vger.kernel.org
Reported-by: syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c80d8dc0d9fa81a3cd8c
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index a5d47819b3a4..ae035b93da08 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -485,7 +485,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		cmd_mask = nd_desc->cmd_mask;
 		if (cmd == ND_CMD_CALL && call_pkg->nd_family) {
 			family = call_pkg->nd_family;
-			if (family > NVDIMM_BUS_FAMILY_MAX ||
+			if (call_pkg->nd_family > NVDIMM_BUS_FAMILY_MAX ||
 			    !test_bit(family, &nd_desc->bus_family_mask))
 				return -EINVAL;
 			family = array_index_nospec(family,
--
2.39.2


