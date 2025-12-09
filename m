Return-Path: <linux-acpi+bounces-19500-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9327CAFA43
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 11:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53CC33059AFE
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 10:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B0B26F462;
	Tue,  9 Dec 2025 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD8Ii3EU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3C18DB35
	for <linux-acpi@vger.kernel.org>; Tue,  9 Dec 2025 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765276289; cv=none; b=u8J8wAWgC+/+j3pcRL6UObrqOxHdbsJ7n0M/ziab6y06Gfl5p6pT/xxrfF3Yi8IwwgC5YhaH4QRoskX5bRFFeiafkyKMA/vIJE9305VTMAtGAmJ26tikhCeV/KcY7rPCX0jmTrveidjQnM6a0vjhUPuo3revyAiOhTdAWDj1igY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765276289; c=relaxed/simple;
	bh=/aEq0x6MLRV/L6sOD9HPYDQFVJxKO9BW6KJrWnDuYm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcmfDGvO/DDf7vqo8YYAelFY6pD5fON1nZYxZW2Z24wtUsFmozqpU3ClEvYByYJi9GBfpaeR8BEM0AUjBEY5FNx4ARXo54K1tslO+pPZqoU+pTWZ9FZe22iFlwCzIlBAKWK6d9sJKYQVyRDKEK8MfNaVRrXQwkYjZwuIrrcw59w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BD8Ii3EU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29d7b019e0eso60749515ad.2
        for <linux-acpi@vger.kernel.org>; Tue, 09 Dec 2025 02:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765276288; x=1765881088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/yj0w8fdlKkFDRy9220y5hCmadloVvp4/iXerUe4NDE=;
        b=BD8Ii3EUXU/i5X6wPGHDQEu3rezl/BSR/C3Wm6sB1kvRAkfJvfsf0SXwlS2/NZjl7a
         YIPwQX+qFuig/YfDI3C+NQzhjAVe4Uwj4u170nongvBScdDTMB+3M3q6/L3t0VmzwruT
         6TLGyopwkoMgsvr+m+5VYL8LnVM3xhGdd/lKTUyRn1DAAVBXmQIR0IpKoE+rMuQ3bZBV
         mzn3E3FHxQSaESmDQR4mZg6F5lG/NuSQ8p0NFNc0Bmjwrkd1OI4wXLA6Gvl/AeeubjEA
         1AUdv3qrXvIiwbeyj6Wg87FsXSRVThsiSC0hMrUtUKTnCf28NjTuTz5z7d7F9usCryLy
         SjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765276288; x=1765881088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yj0w8fdlKkFDRy9220y5hCmadloVvp4/iXerUe4NDE=;
        b=d2FvVrc31Cf5X1FAOQDC75qIMEkeNqNmSz0DbKO9ZRju5qX4FXBKkcOi2zGpPjXjxP
         3I1jdieeiVB6OF6Ry2IqpN1351MBmd6NXv0IrxtwK3+Bdzw6lWR9qfdNX5A/zqYzIMtp
         6H4kLRt86x3VntLMmaoNRRF1atk/0Lt9zEU0u88NBOUWom2kUttQFsLodTXJJeRa8Bxj
         VoEV1ditGtMc4SNYrfz0dEEEE0VSVqqhLRPZmoMZZPbX+NmG1GNFTByyI5aFylky/syL
         PRWw4Y7mt2iJc1X6NhadDLbY54s5/qEZmLjsA421PJG3vkFYiMMVk2Ir9qLMKDhXTmWJ
         WVUA==
X-Gm-Message-State: AOJu0YwtslSw4yOnA6LvNcIrAjLwmEwWyGm4FZ+m+iy+sd1vHDmuAS4k
	Re8BJUXA0uxIYJTKoOE8SVOwTrgSus0oPE3lfL8FsimnNxX6PTSm2428
X-Gm-Gg: AY/fxX4y4M/x1but2Eb6v5Jc1jPBrYGz6/LjDQ8wbjoboXqVk6bgm3nFpJe24vuJKNy
	HQvyhedzO/Zm+BjTN9OMREJVgdsTOQzumwIq1L2Vn18KME27JZ6hkcq8RXUpl4BLsfImwXAkoQw
	C5MYF8jkAjnSf8HPP+mwuwgVZ+YrZAjQU3UAH+9IJZ6CazuXqLpsTsfzz6pRfPdX60tS3LD/TU0
	LqXPVLefLrdQ5F+RzBgHf19c2MdOWcQ3UCthO6VT06+z+VSUp29ji+vhosR4LBVkgZJ8Fpn1qXB
	C5aVsa85ahUg7lHzAqxrt+9zXgM8NuWWo7e5MrZcdlse69U235sHa6LTDJlS/esBIzrQgx1LvmE
	yQk+DBCW9wHsKyPkfJSy1pBhacDEK7f4NPJNBFojewyGLYbY0wC3E9QSd7T7E2qarhWLqB3W4FP
	ibmx8gQmgKSZg=
X-Google-Smtp-Source: AGHT+IGT96A1erd61gvFmTe3P8AK62zWKkju7VS5bZ29xeGcMHMfsVoc7tZR2o3bVREg1cKHPPBc6Q==
X-Received: by 2002:a17:903:19e3:b0:29d:7b9b:515b with SMTP id d9443c01a7336-29df5791cb1mr77431165ad.20.1765276287542;
        Tue, 09 Dec 2025 02:31:27 -0800 (PST)
Received: from oslab.. ([2402:f000:4:1006:809:ffff:fffe:18ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f20bsm149111715ad.46.2025.12.09.02.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 02:31:27 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] ACPI: processor: Fix a possible null-pointer dereference in acpi_processor_errata_piix4() when debug messages are enabled
Date: Tue,  9 Dec 2025 18:31:13 +0800
Message-ID: <20251209103114.3964322-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In acpi_processor_errata_piix4(), the pointer dev is first assigned an IDE
device and then reassigned an ISA device:

  dev = pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB, ...);
  dev = pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB_0, ...);

If the first lookup succeeds but the second fails, dev becomes NULL. This
leads to a potential null-pointer dereference when dev_dbg() is called:

  if (errata.piix4.bmisx)
    dev_dbg(&dev->dev, ...);

To prevent this, use two temporary pointers and retrieve each device
independently, avoiding overwriting dev with a possible NULL value.

Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/acpi/acpi_processor.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7ec1dc04fd11..ddd7081430f7 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -50,6 +50,7 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
 {
 	u8 value1 = 0;
 	u8 value2 = 0;
+	struct pci_dev *ide_dev, *isa_dev;
 
 
 	if (!dev)
@@ -107,12 +108,12 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
 		 * each IDE controller's DMA status to make sure we catch all
 		 * DMA activity.
 		 */
-		dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
+		ide_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
 				     PCI_DEVICE_ID_INTEL_82371AB,
 				     PCI_ANY_ID, PCI_ANY_ID, NULL);
-		if (dev) {
-			errata.piix4.bmisx = pci_resource_start(dev, 4);
-			pci_dev_put(dev);
+		if (ide_dev) {
+			errata.piix4.bmisx = pci_resource_start(ide_dev, 4);
+			pci_dev_put(ide_dev);
 		}
 
 		/*
@@ -124,24 +125,24 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
 		 * disable C3 support if this is enabled, as some legacy
 		 * devices won't operate well if fast DMA is disabled.
 		 */
-		dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
+		isa_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
 				     PCI_DEVICE_ID_INTEL_82371AB_0,
 				     PCI_ANY_ID, PCI_ANY_ID, NULL);
-		if (dev) {
-			pci_read_config_byte(dev, 0x76, &value1);
-			pci_read_config_byte(dev, 0x77, &value2);
+		if (isa_dev) {
+			pci_read_config_byte(isa_dev, 0x76, &value1);
+			pci_read_config_byte(isa_dev, 0x77, &value2);
 			if ((value1 & 0x80) || (value2 & 0x80))
 				errata.piix4.fdma = 1;
-			pci_dev_put(dev);
+			pci_dev_put(isa_dev);
 		}
 
 		break;
 	}
 
 	if (errata.piix4.bmisx)
-		dev_dbg(&dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
+		dev_dbg(&ide_dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
 	if (errata.piix4.fdma)
-		dev_dbg(&dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
+		dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
 
 	return 0;
 }
-- 
2.43.0


