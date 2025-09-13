Return-Path: <linux-acpi+bounces-16837-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C0EB55DD7
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 04:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122FE5681CA
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 02:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F866158DAC;
	Sat, 13 Sep 2025 02:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VHS1IDsG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4208347DD;
	Sat, 13 Sep 2025 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757730759; cv=none; b=UViHlFerF2DTk1NOe+zmwIHDTvae+j/QndCtZph02J4MTagqdGPBhSQxZa1aBa5ayz2MWzR6D/BfRSXDqvPa+LMtgTdSSry8wAMwnx2huxK9vSPdyc4arJCNICq/nd9cZhcpYNbZ/SBZPzMEkfZbkItEPVBbI4Q9ubNiSraaViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757730759; c=relaxed/simple;
	bh=zm0VCcs9boavV2TCGL/wOXYwcxDhgoWmXtNFO35a+L0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qUKws9O9Ui6CaEkvSkUkOZ5JaWnyOrL/zNpFQOMwuTNaUHOw32zEKt1OG25JUnFo0RDATBkPsuazrdnnjrmc+KdFY3wHFdHe/nO/l8YyhQjXHxDNDh5JEqoFr8lrZ2Muxou05PpWOZR7jwBNIlCqRrLAPOnrIrKqc5YrrT5Lycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VHS1IDsG; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757730748; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=o3zfucXj3gdSgzCiY6p2mPd7NL3n/kEPQEJn/QTqr9Y=;
	b=VHS1IDsGOykPaNXBQzpINn+c+vekLpp4UczadhAe9gNUcuoM+wEO9jeBPXZZWlPdZAkoe/kuQNC0pCWcGa2jOuj1/sOhG40FRShlxtktlOSa9uDs4HNCrQOqRjNxowKyUIE/KaPZLTpBn4KCkk5RfWgR7wCjASddVKrbnwDC1/s=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WnsSKuO_1757730745 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 13 Sep 2025 10:32:26 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com
Cc: andrew@kernel.org,
	bfaccini@nvidia.com,
	eahariha@linux.microsoft.com,
	dan.j.williams@intel.com,
	thorsten.blum@linux.dev,
	gourry@gourry.net,
	xueshuai@linux.alibaba.com,
	nunodasneves@linux.microsoft.com,
	wangyuquan1236@phytium.com.cn,
	Jonathan.Cameron@huawei.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2] acpi,srat: Fix incorrect device handle check for Generic Initiator
Date: Sat, 13 Sep 2025 10:32:24 +0800
Message-Id: <20250913023224.39281-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Generic Initiator Affinity Structure in SRAT table uses device
handle type field to indicate the device type. According to ACPI
specification, the device handle type value of 1 represents PCI device,
not 0.

Fixes: 894c26a1c274 ("ACPI: Support Generic Initiator only domains")
Reported-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
changes since v1: drop changes in actbl3.h to make it easy to progress per Jonathan
---
 drivers/acpi/numa/srat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 53816dfab645..aa87ee1583a4 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -237,7 +237,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 		struct acpi_srat_generic_affinity *p =
 			(struct acpi_srat_generic_affinity *)header;
 
-		if (p->device_handle_type == 0) {
+		if (p->device_handle_type == 1) {
 			/*
 			 * For pci devices this may be the only place they
 			 * are assigned a proximity domain
-- 
2.39.3


