Return-Path: <linux-acpi+bounces-20089-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F739D0702A
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 04:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C76C33019BA7
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 03:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FA324466C;
	Fri,  9 Jan 2026 03:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwtztGog"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEF723BF91
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767929960; cv=none; b=cybC21aSW90cV6pZTj+OKLPXG+f4qe3tX8WfDeg17Lfbj/N+VuvZ68UpNW2FAT0BA6+Cp1X6RamT/bie0U2kw5GOxIL1UuqFRDozEpYr8R+EfTRDjPxwSoOG+wbiax9IuGsgVZ9ACbS9FR1vKzrZzhZxLeUu5j3Nz+z1VWXNOPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767929960; c=relaxed/simple;
	bh=CCdgbi0B751s+BZocVj9tglVM2F5T5n8zZHUgyr2r+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IgYVr1Yao3bzLPSgaMCNXtlXarZbmgZ9MbnqI1cy9csp5xJBlTIzWWHx03qpdeYe4quZzew+t3XJjHmrwW4hZ5Zfw14RIGxsgi34gQ8OjGT+M+8lddjV+UdF+LTQQm0pinlY0iBH2+fDfwPA+1iXi+KGcLKseH05qGRCnpUhhRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwtztGog; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34b75fba315so2466322a91.3
        for <linux-acpi@vger.kernel.org>; Thu, 08 Jan 2026 19:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767929958; x=1768534758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XRo2wXN3bs+qG80QWKNHIcRdu6udViv66lv8WyS235g=;
        b=AwtztGogpRDrF0PRJxdkfz97wJ1L1OgwBDm8JwKf1sB8z4VT5k9lwl8yHqGw4YGGZl
         A/t+sYCNyVX+I/f++hHgEjBkcUZ6Z3fiEEgmQrkj7rFz0rjCP0ECrstiiVgxT2kSDgUT
         rXaDP2Gcw1pb0dvZeRADUIB4b+8Oh/GAJIU2zMb6wrA8sebDgTqRVNtXR7KsWAd0c+po
         ue4PrcHQ8I44AEKfnqss7YUFC6JK715zEeamE7CZFdQzM9KxJAVlqCSzs7VXvlg8pqpt
         N8VPBron8FK4z0vZsFM9FiBFddPlSOOfM8cUKXudWlxYIKLTzK+jKrsLdX9yE7TTfxVm
         N2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767929958; x=1768534758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRo2wXN3bs+qG80QWKNHIcRdu6udViv66lv8WyS235g=;
        b=M7i/vYTNu6DU+e05zXiKueMQvA63GuuWqqWLNJ3FSMcv3rmLsAVf1hpFg0ak3cgcuW
         RcEDLHweTrjh0XynrrCqDUrJb0sZEVUopMMQL6EPUkaOmYugRzH3BgBLiI74becECVoL
         IcgBrwWI/mccnQDvIIv2O43/tAVK7McvnYAK/SqDTF7LFOL8lp8lCSZ1/UQ1C2HKUctB
         zgaj+p1jPBOz1vLhqRxKGAaI/iilFd2DNcFNEVUFX3Ifi6srrB4MrfcrI48QIpkpaERZ
         EVoYBUi4m1vbIbkn3i4XpgDj0VW49k9wZISDjWCV5HPml+3CsICDpoh/KqjY9fvatWLA
         yi7g==
X-Gm-Message-State: AOJu0YyxLblD39mwp+Uj/LXXRB1oBvSCc1JVnyCXjbcmXJIRNj/WKy9i
	XyMjugwKHsx14Hi/Le6arEwP8r+DHAOsb9PDLHlloe4KWgeAex6tEife
X-Gm-Gg: AY/fxX4sR8EkllDfoG8M0ymAXDK/Nu1bAMzGIYB2ucF5SiPWsY1x8/XvmqOBjTlUsEw
	LPC9OTHjGVOGwAmWgXabw18cD69F7uRxobpbL1/AmkvCaWt9SwqCJhtaIzBZjhyQ4TmoeY/sflr
	nJdrFczKJhO1agoFXis6QIzufd+xbptMa7DRcus8pvJk/rHUI7Ik7fuAqRDNtRpE0yrZouZnIeh
	wY/qmw//zhhfBfcXoyzsOF7z/xupFoPY6D4AkbjSWElnugI4zbFdZycQfaH5Z88DVsLoM7kTiIn
	UA8D0qvHDoSGJjGTJrew1a/rOEoi9xCtjTvKfLhRZMa2Jrq+1g58aw1JWSkrn8wtuZukG2Eb7sQ
	N5vpSFRX2HVOlKlt9y0o+Z0OTLKDfmpZIwcLlpZ4PnTkgC3PXhDIh9wR9/iLuzA36ER+CWtFEg5
	PnmuS4AA==
X-Google-Smtp-Source: AGHT+IFaxUBwE7gm8CgewKAqLRbG01GKGqiM3iheSwyp6rUm5/0nBnWIBVPwUe+nSi8wkcpNYH9A5Q==
X-Received: by 2002:a17:90b:17c2:b0:341:194:5e7c with SMTP id 98e67ed59e1d1-34f68c9131fmr8393968a91.24.1767929958350;
        Thu, 08 Jan 2026 19:39:18 -0800 (PST)
Received: from oslab.. ([2402:f000:4:1006:809:0:a77:18ea])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fa93ee7sm9124515a91.7.2026.01.08.19.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 19:39:17 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH v2] ACPI: processor: Fix a possible null-pointer dereference in acpi_processor_errata_piix4() when debug messages are enabled
Date: Fri,  9 Jan 2026 11:38:59 +0800
Message-ID: <20260109033859.187086-1-islituo@gmail.com>
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
v2:
* Add checks for ide_dev and isa_dev before dev_dbg()
  Thanks Rafael J. Wysocki for helpful advice.
---
 drivers/acpi/acpi_processor.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7ec1dc04fd11..e43978b0d83c 100644
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
 
-	if (errata.piix4.bmisx)
-		dev_dbg(&dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
-	if (errata.piix4.fdma)
-		dev_dbg(&dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
+	if (errata.piix4.bmisx && ide_dev)
+		dev_dbg(&ide_dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
+	if (errata.piix4.fdma && isa_dev)
+		dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
 
 	return 0;
 }
-- 
2.43.0


