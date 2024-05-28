Return-Path: <linux-acpi+bounces-6066-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197818D249D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 21:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C8C28B82D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 19:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3078174ED7;
	Tue, 28 May 2024 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVPXsDZo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271B5172767;
	Tue, 28 May 2024 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716924597; cv=none; b=bLEjgirGPd1oDMmIWEgCvU5UUTF2nsobvhmC3aalza9zVFnV3s5d9fLGgIgSdMmm/P9H1GYTCJq2QjFolfG5KEpa9CH6PyGHxcN5YIr0pD5+YTePLRclkoQNkwqrSvmbGw43MuvwmDKnxZEKKn2RTTa/x86S45WNpbESOTpjhBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716924597; c=relaxed/simple;
	bh=Z6OKxgSrUBb60RuBVWuMNXGMh/m2BPwjAQIW4pcCv0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/RGvj2nNPOnRuxb0CaNqw4E6mlRts9jq95C3kssyvxYNLBrdqDZ28tkk2PDfE20TEgqXs8mCchk/Bu+dmccEPiNk98xxZwNIxJDezEsv36MpkhfLBR0GKC0TpV7NM0b7moGFMC79wM5zZmlnECYEbkW4+vrIaCy5CEx+oxfm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVPXsDZo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716924595; x=1748460595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z6OKxgSrUBb60RuBVWuMNXGMh/m2BPwjAQIW4pcCv0w=;
  b=BVPXsDZoGeirShSYgTpSDMh1o5IGudXhOVdxh0ZBHLU6LylzSPbrsfqz
   toS4I0tqyyc9DpyOoWnbqi4nIwwJcF2vtg/WiEpWDEiOAuFTr/T8bC4Zc
   kvLBKmSZYX3Hlo3GvvjuYzwqXPyrNVhSpJT4nrNk1oKB3Gry+uRnEP8G4
   zkzmYdwXiAR4ckElL5PInKtko3Ecr2R5iSbu49rc/71Hvo3pl6yfYrqSd
   WBKTwQiKegOLdnzPhqJuVbOcHBmvEM0LgjyG0cecyxpxhcXvneYlQU5i4
   enrr+vHA9r+L2wO9ymDYUOJUKb78iMZsnnCQe79tDMJSVCA3muYHp1HoW
   A==;
X-CSE-ConnectionGUID: 0HI/iBMmQ42JNKMC20dPSQ==
X-CSE-MsgGUID: AB2c8faBSPaAfxYkOpdulg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24711838"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="24711838"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 12:29:53 -0700
X-CSE-ConnectionGUID: inouwosHR8CM4lIsH+BWwQ==
X-CSE-MsgGUID: oU18+uUSQoC3Kmgtkw20Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="35246717"
Received: from unknown (HELO pbossart-mobl6.lan) ([10.125.110.237])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 12:29:52 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	rafael@kernel.org,
	vkoul@kernel.org,
	andriy.shevchenko@linux.intel.com,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] ACPI: utils: introduce acpi_get_local_u64_address()
Date: Tue, 28 May 2024 14:29:33 -0500
Message-ID: <20240528192936.16180-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528192936.16180-1-pierre-louis.bossart@linux.intel.com>
References: <20240528192936.16180-1-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ACPI _ADR is a 64-bit value. We changed the definitions in commit
ca6f998cf9a2 ("ACPI: bus: change _ADR representation to 64 bits") but
some helpers still assume the value is a 32-bit value.

This patch adds a new helper to extract the full 64-bits. The existing
32-bit helper is kept for backwards-compatibility and cases where the
_ADR is known to fit in a 32-bit value.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/acpi/utils.c | 22 ++++++++++++++++------
 include/linux/acpi.h |  1 +
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 202234ba54bd..ae9384282273 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -277,15 +277,25 @@ acpi_evaluate_integer(acpi_handle handle,
 
 EXPORT_SYMBOL(acpi_evaluate_integer);
 
+int acpi_get_local_u64_address(acpi_handle handle, u64 *addr)
+{
+	acpi_status status;
+
+	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, addr);
+	if (ACPI_FAILURE(status))
+		return -ENODATA;
+	return 0;
+}
+EXPORT_SYMBOL(acpi_get_local_u64_address);
+
 int acpi_get_local_address(acpi_handle handle, u32 *addr)
 {
-	unsigned long long adr;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &adr);
-	if (ACPI_FAILURE(status))
-		return -ENODATA;
+	u64 adr;
+	int ret;
 
+	ret = acpi_get_local_u64_address(handle, &adr);
+	if (ret < 0)
+		return ret;
 	*addr = (u32)adr;
 	return 0;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 28c3fb2bef0d..65e7177bcb02 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -761,6 +761,7 @@ static inline u64 acpi_arch_get_root_pointer(void)
 }
 #endif
 
+int acpi_get_local_u64_address(acpi_handle handle, u64 *addr);
 int acpi_get_local_address(acpi_handle handle, u32 *addr);
 const char *acpi_get_subsystem_id(acpi_handle handle);
 
-- 
2.43.0


