Return-Path: <linux-acpi+bounces-16748-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F415BB5540B
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 17:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67DD5A1F33
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F2723AB8B;
	Fri, 12 Sep 2025 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Xo/rFNoS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3921D3F5;
	Fri, 12 Sep 2025 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692066; cv=none; b=TRPHUM+zTzYDKizoYxANr71etlRsO7xPHm+CFNFrheGRdRsck8DaV9jw15HnfKeSoKaCDvgnM1b0LryaeQQ311pkH2xFRO7z2tMqpPoQI8vHdNB2/jkuPxMQ6Lna0kUzuWI8sTkD+sUC4TXBCFiOKB6ILYdZ1QgrzIKPRReFVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692066; c=relaxed/simple;
	bh=jPe1pdv9rph8uVbl98SfuP23RiP7V6VDtBfkTK5lkSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dyzRiXmdLYElX605lsoHSHt7wT0Z2g8K1DZfQSd4HJqzx38dMyAeRFyYMFFVM1lRR0M1mAtVjb14pYmyyfcJUU0h902/yiKuG2FP0fRTbk7XprXGUA+RNK/M0HLmEd9cGgUpYfvOLOCruHv9DsYl+2WvMELn2L1FqcPKF53Rs6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Xo/rFNoS; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 22a15e980;
	Fri, 12 Sep 2025 23:47:39 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: rafael@kernel.org
Cc: robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] acpi: replace ACPI_FREE with acpi_ut_delete_object_desc
Date: Fri, 12 Sep 2025 15:47:35 +0000
Message-Id: <20250912154735.158537-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a993e9c5da603a1kunmf7421b2a2a66ff
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGU4fVklDT09KGk8YS0weHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=Xo/rFNoS1dz+c0yx+HedhqhhqKgS6VOs02EpGJlZ+ROoYv3jt7JF0MFeEBwRqFvpp11mzAIkZZLDxwUOpXYrhRiw50Jd+FuLdoEc2zPJPv6pXoBkOpLLkYcX8GLEagXU/Y8JaNKHoB/+jsESq0aDeDCcpuSree6Z4H178pAaWPo=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=b9yWIDSto645FMwYolwTKJoPgHsiJq2d08oXP46kQO4=;
	h=date:mime-version:subject:message-id:from;

acpi_ut_create_internal_object may allocate memory from a slab cache
via kmem_cache_zalloc, but the code currently frees it with ACPI_FREE,
which calls kfree. This mismatch prevents the object from being
released properly and may lead to memory leaks or other issues.

Fix this by replacing ACPI_FREE with acpi_ut_delete_object_desc, which
matches the allocation method used for internal objects.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/acpi/acpica/nsxfname.c | 2 +-
 drivers/acpi/acpica/utobject.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 1db831545ec8..b6895a48ae68 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -601,7 +601,7 @@ acpi_status acpi_install_method(u8 *buffer)
 error_exit:
 
 	ACPI_FREE(aml_buffer);
-	ACPI_FREE(method_obj);
+	acpi_ut_delete_object_desc(method_obj);
 	return (status);
 }
 ACPI_EXPORT_SYMBOL(acpi_install_method)
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 272e46208263..8362204b57b5 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -148,7 +148,7 @@ union acpi_operand_object *acpi_ut_create_package_object(u32 count)
 	package_elements = ACPI_ALLOCATE_ZEROED(((acpi_size)count +
 						 1) * sizeof(void *));
 	if (!package_elements) {
-		ACPI_FREE(package_desc);
+		acpi_ut_delete_object_desc(package_desc);
 		return_PTR(NULL);
 	}
 
-- 
2.34.1


