Return-Path: <linux-acpi+bounces-7849-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B44895FDCD
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 01:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7A61C213A3
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 23:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418241482E6;
	Mon, 26 Aug 2024 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FrTYElyo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1656A7DA92;
	Mon, 26 Aug 2024 23:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724715321; cv=none; b=L65BUHMPNAZStAbWrVvR0AIqkBZj7XIhE05btGVTPM4zjs1b3FtPk3UxxQgZG9BBEntc1ctES2BS7HQBQUi6iCI1n5eunJpLGBQTux/cKP7MRHqlEnjlcCkh0DZNaL1JaipFIutIewS2Su4Jjryg4rz9YkMmaA9OtEMlSPLPUUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724715321; c=relaxed/simple;
	bh=jvRskkPp2UNFxuSs1KmGXQf0+zNARsdAbtFaKe6i0GI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kX0nzwowcmJY2n7dXYT600SIY2yjcx/68hwbHH0SYJht+VifaeJ06DHzDxY8gZLebLbuLJqxaGb9Gna5lMM3NKWLoobkxrWNLN4z7+jp1ZGyk1cqw7UiR6Tm8Dx6mxPpaV7FEhW6/Ea9brCzVJdbwQ1N+Uftf+N06pj8xjxSx3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FrTYElyo; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zx3Z/
	skLD261Grlw5va5uoZD4LvrxeLByUbYg6lWgtU=; b=FrTYElyo2rpbMUQqRWiTB
	Z609ncu8uVzAsZrfFO8JidRvEvK6yRuS5UUZnuwLuVAV3ibun1z8e8bGo8ca0166
	7tQh6O0UI9T83gmE1as9a7ZjNGdc7HZ++mJJ4xyn2FKsge68h/eOgfn7y9fyI87Q
	P0/yAkN/b2oBhnc1OQHd7g=
Received: from localhost.localdomain (unknown [111.35.190.113])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wD3H6oQEc1mo37+Ag--.52917S4;
	Tue, 27 Aug 2024 07:34:57 +0800 (CST)
From: David Wang <00107082@163.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] acpi/_DSM: Add rev/func to warning message when acpi_evaluate_dsm failed.
Date: Tue, 27 Aug 2024 07:34:37 +0800
Message-Id: <20240826233437.19632-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H6oQEc1mo37+Ag--.52917S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWxCw45Zw4kAw45uF4rKrg_yoW8Kw45pF
	y7Zr4jkrZrAayUtwn7t3yxKw1S9a9xW39I9w4xGFyUX34DWrn29rW5GrnFyayDAw17Xa45
	Z3W2qF1jgr4kZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE1vVZUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxBHqmXAnb6sJQABsA

When acpi_evaluate_dsm failed, the warning message lacks the rev
and func information which is available and helpful.
For example, iwlwifi would make _DSM queries for lari config,
and when it failed, all warning messages are all the same:
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
With this patch, the warnings would be more informative:
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade rev:0 func:1 (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade rev:0 func:6 (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade rev:0 func:7 (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade rev:0 func:8 (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade rev:0 func:3 (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade rev:0 func:9 (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade rev:0 func:10 (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade rev:0 func:12 (0x1001)

Signed-off-by: David Wang <00107082@163.com>
---
 drivers/acpi/utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index ae9384282273..6de542d99518 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -801,7 +801,8 @@ acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 func,
 
 	if (ret != AE_NOT_FOUND)
 		acpi_handle_warn(handle,
-				 "failed to evaluate _DSM %pUb (0x%x)\n", guid, ret);
+				 "failed to evaluate _DSM %pUb rev:%lld func:%lld (0x%x)\n",
+				 guid, rev, func, ret);
 
 	return NULL;
 }
-- 
2.39.2


