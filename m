Return-Path: <linux-acpi+bounces-7821-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAB795E7B3
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 06:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CEC2818D2
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 04:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120A555769;
	Mon, 26 Aug 2024 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iDPO314m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAEC10A0D;
	Mon, 26 Aug 2024 04:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724647204; cv=none; b=pxAJziuxEPvCA3UWtGLsxDN7zTJE0LAsffVIMLR5rA7bewynMS4L1ayQAveSW4kYRVnuVC03on+zZBt7LcmaxyHqmZQxBR7lrdWKqsRtbAVobP2fRpW9EaN4qlu4QDknhjYNElPG3KwOWW2PaNka43FYGXBp0JApIoUfyTO3LWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724647204; c=relaxed/simple;
	bh=HEGIzKWKJ7IG4OFpKSVNJ5CgBc9G23tKsyI1TMhlzN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iBIHfUjHGCzofU8JGGRciik0BG1FiMvBm+5jUmdsskVT2cgmtbJtORcuoZN4YIF8S+aNYe+bpMYRUaR+h4u3BphRJUNTZnmH1mnKF/L2JCdW0yCCtbf7HapdsRk9/v1r+iDTVr0ZZnrpSeTNmdKabe03f093HL5dEAIiWLYf0NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iDPO314m; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=skg/G
	bgcj2UpLV3GCSqZRKnfH2ijhdcsH4t+eKIUUEw=; b=iDPO314mdS+0G6T2e+ZeT
	0jo5eGF4RBfKTPszscR92RemqoLMLCqRv+YZwwbZwzJDN6vazAsjS36d75nxfKM9
	CddaJx5thb0CzHDzIToeSrUYCeN5LZv08TcVX93QYjSpJKVtM11nVWdB/pT8GliB
	dLEwyd0YXRIjh9Gl2pFwWc=
Received: from localhost.localdomain (unknown [111.35.190.113])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wCn_rD3BsxmIuujFg--.61239S4;
	Mon, 26 Aug 2024 12:39:34 +0800 (CST)
From: David Wang <00107082@163.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] Add rev and func to warning message when acpi_evaluate_dsm failed.
Date: Mon, 26 Aug 2024 12:38:58 +0800
Message-Id: <20240826043858.4292-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn_rD3BsxmIuujFg--.61239S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWxKry8ZryfAF4UurWkXrb_yoW8KFW3pF
	y7Zr4jkr9rZayUtwnrt3yIgw1S9a9xW39I9w4xGFyUX34DWr929rW5GrnFyayDAw17Xa45
	Z3W2qF1jgr4kZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE1vVZUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxFHqmXAnathGwABsn

When acpi_evaluate_dsm failed, the warning message lacks the rev
and func information which is available and helpful. For example,
iwlwifi would make DSM queries for lari config, and with some HW,
DSM error would return:
	ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
	ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
	ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
	ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
	ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
	ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
	ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
	ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
With this patch, the warning would be more informative:
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


