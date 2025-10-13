Return-Path: <linux-acpi+bounces-17735-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9631FBD21D7
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Oct 2025 10:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3723A528E
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Oct 2025 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89ED2EC0B7;
	Mon, 13 Oct 2025 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="XnFfSoYJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC92EAD10;
	Mon, 13 Oct 2025 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344685; cv=none; b=q4/rD1355ako+XZ/coBiHOK/O7/DIVBymuKRPJNn8sdopMNikCIelLzLSCw6+fM0z8wCJpURXYfnKSvrOZnY6o/2g0WgzqqT+5jbClbmuMXPbr4Cim8hSxktZg49vLcnB2AN3w+oogIBAAohx/sPqJ1Q3Nibulem4kqsXAilmOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344685; c=relaxed/simple;
	bh=6arSJg06MrMkixsEJHWkx329AWbue+1XZtRqQfyGgF8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ZfxD2U8qHMdPJB2v/D4UTNh9e8G8iEiUNEwAa0KzVIZcRTBYNq56bOEDTFKr+uBVj9JL7aMrQlte8xnSu0iYVB3uItHV2Ejay7MnSYJVtq2ItbVGGsFVJjwrnjpzjyUI93OglT/ZOu3jFSsEhRs70Bnk8GpM4pr0A332xnvND+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=XnFfSoYJ; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1760344679;
	bh=5fT7lo+YLGtKH01AJv/ZvxTs08zq3ei0Fpq75OwRn60=;
	h=From:To:Cc:Subject:Date;
	b=XnFfSoYJ5+9p+xoCq8nGHo+VhXQ+HgsdL1d7RiIBQ2BI9zdqcJenR5qUCJ7od/nf9
	 A0h8yJl7NEwFeBahc3L/JwYaJHvAvuE1xTay+LtzTzqYoEvTPvkySmwuPWec0+XyZJ
	 +TdTb3mnifr69puKaiSsh8Yf+Bk5updam34FRPDY=
Received: from dcitdc.dci.com ([61.220.30.51])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 7F3AECD0; Mon, 13 Oct 2025 16:31:51 +0800
X-QQ-mid: xmsmtpt1760344311t8ri0yeyl
Message-ID: <tencent_EAFBEC2D1967D73F4F76B8048D2F59BB1105@qq.com>
X-QQ-XMAILINFO: NwU6Bou9okj/GXiU9e1SiVUg8sRTWGVorLLNInsoMknKrt1oH8qSJtOqKjVH5P
	 jjdY6eAl+wU01bENhYgYuzwZR+TrI0BywOqcPLvvCVswk+tUpn2n3L4IxPALqZMpaUT0CzGF9XMK
	 iJbqo/EmoQOv6TTTjS0AY6H6cVVtGWArccm7PJD8QOLIT93h7Rc3NJAxfduKqS+S0iX7LwjaQZH9
	 gE6EmJ12qqi/Qfx2nP0IIc1EilbO8M4YaHuJENMHYh9bJ+IYOpuL3ke2w0DRcN1RtMrM8el8i53E
	 sl5yPwhTSaXLuV4UigCGAdnMrJA2C7q176hkNag24TKL2QOtKjyUDJ1wE1OL1hbU0uey1NVuE5Y8
	 d0CYCbW8MHVVbZXsfAMeSt7NscP97ZQH14dvQ0xIcsTPpoP+PROeTjBrGqxaYRTe64B6EA3fkV5G
	 aRPZqb7LhmdHNCpw94MEJdcGx3ijwx9qhA13WBtiVMcx6c+q5bZpFUESEuOlD+y44i+6bHH5vXgm
	 uGRRIzQ7p/FzIwBq0gvIuvtNgA2KXGaVgt1Uwpkl9RG8X7sEwIRVhjmVyP+hjgpSO6PUOsPHYaIR
	 lVRsJVXgUzF6BLkEGrcT1p3a/mdOtYR4k+2YW/7/sLnZqwxtG5QYKKVW1QUA50/bf5i7vnj0uYXE
	 apBJDWecD4yFbdYIWnbVBS46iMeeoL4f69IBWLphBRp09cUe8+7vrsnJd2rt5mzklSgHiOSolnXG
	 ZfS5PI7HwGryb4mCDVN/atgL2RdaQutGaZA6GMpK1Y615aJiYmzcdw2nZADvwmZZR1X+2jziQekz
	 fhKEpZmGLv35uNndYoAqRDt5SY1RgVEjK+Vze+EvdOvnpVj5QnqZHP4rqzXJrzxR0p+ZY8YhW1zI
	 jeAsXOwOvGa4zgPnSNVevRICWWM9E/L8IHP+80PhYHwivUxdSZooCZtN0TFRivi12LEspAYH2wpZ
	 vkMeJrtszu+GTwrLkvlWXVu1AV9333ImTo8GGcFI5ti2KfTtD9o4xyZ5j2x6os
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: "Shang song (Lenovo)" <shangsong2@foxmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shangsong2@lenovo.com,
	"Shang song (Lenovo)" <shangsong2@foxmail.com>
Subject: [PATCH 1/1] ACPI: PRM: Skip the initialization when boot from legacy BIOS
Date: Mon, 13 Oct 2025 04:31:40 -0400
X-OQ-MSGID: <20251013083140.2493313-1-shangsong2@foxmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To address the confusion caused by the misleading "Failed to find VA for GUID..."
message during legacy BIOS boot, making 'EFI_RUNTIME_SERVICES's earlier judgment
can prevent this false alert.

Signed-off-by: Shang song (Lenovo) <shangsong2@foxmail.com>
---
 drivers/acpi/prmt.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 6792d4385eee..ec367d322ab2 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -305,11 +305,6 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 	efi_status_t status;
 	struct prm_context_buffer context;
 
-	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
-		pr_err_ratelimited("PRM: EFI runtime services no longer available\n");
-		return AE_NO_HANDLER;
-	}
-
 	/*
 	 * The returned acpi_status will always be AE_OK. Error values will be
 	 * saved in the first byte of the PRM message buffer to be used by ASL.
@@ -388,6 +383,14 @@ void __init init_prmt(void)
 	acpi_status status;
 	int mc;
 
+	/*
+	 * Return immediately if EFI_RUNTIME_SERVICES is not enabled.
+	 */
+	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
+		pr_info("PRM: EFI runtime services unavailable, can not initialize.\n");
+		return;
+	}
+
 	status = acpi_get_table(ACPI_SIG_PRMT, 0, &tbl);
 	if (ACPI_FAILURE(status))
 		return;
@@ -404,11 +407,6 @@ void __init init_prmt(void)
 
 	pr_info("PRM: found %u modules\n", mc);
 
-	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
-		pr_err("PRM: EFI runtime services unavailable\n");
-		return;
-	}
-
 	status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
 						    ACPI_ADR_SPACE_PLATFORM_RT,
 						    &acpi_platformrt_space_handler,
-- 
2.43.7


