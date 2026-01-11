Return-Path: <linux-acpi+bounces-20153-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AF4D0F716
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 17:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 972B73043D55
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F10333E364;
	Sun, 11 Jan 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLVvp0oq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086B0337B8E
	for <linux-acpi@vger.kernel.org>; Sun, 11 Jan 2026 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768149160; cv=none; b=dsy2U7TJ3fd4FmUZQYK25OOBuDKgR5o1sabfPemeSsI+uza2Gb1qKW2XsTz0E5tSlcB8xFa5GT4CRDw5HVwUi4CDHF6TJOaNj/40hYyY7i1Gijj6qZ4wwLP6HgvlEQ2xmLCDtIt+2E11qtz3R/qa8ZgTC2UAa2TGhVwKC0vnuRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768149160; c=relaxed/simple;
	bh=bCuarnFNRCnr39J2usARL/W3Wz8m2zhoLrFZ1H028Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CejOLYqZd3ZEpdT/YIQhXFLf7v31S8acjPn89Lgm0vuLGhIhwh/ACab6lpEYw3gWQuFYoYM0A02W5ClHYiSkK+WSrRmp2aMlJ+BU3velL6UVYNEdgnDGon3ko7y8IKoYMR1qA4bh4CGgH11gIS+/y8MJ/9/waVPynw9xYEHP/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLVvp0oq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81ef4b87291so654978b3a.0
        for <linux-acpi@vger.kernel.org>; Sun, 11 Jan 2026 08:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768149158; x=1768753958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s4TpFVNLEQuYiPG1Qe8WVzTpZhAqoRthypQE7fqDUSY=;
        b=NLVvp0oqZK7GAWM8WRC22EAw0EVoHK+I0R3+O0drYKagTDg3BMq8tLz2O0Wa8PN7Xu
         Nj2bSW4rj6w2GgsV9ef524+5DqqnTjb34KbuSeDTyyoKKBlXjhsuGTmP5LJjfgzTFSTl
         hnEXQRbZEa2fI0YvGD8zBrSIe+NxP5qsRhVPOuldI1GuOAhs0nxqJUQzFFXn49Kn/RqV
         PTiJE3vc8ibETXulKDZSSL1jl7gnZ/fVB/zikJtH499VthrhdtDjUAxxXssQV+mn+v3h
         SeEP9bm51VO1BmxFZXWoGHliOsIxKj7jI/6e8rYAGhw/ZyQKvsELddPo9RSi0vBiVLmt
         tACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768149158; x=1768753958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4TpFVNLEQuYiPG1Qe8WVzTpZhAqoRthypQE7fqDUSY=;
        b=ikv7inEYbDmH8PYO8PLzyMOqGXGJPSPH0MSo0qa0uNpaKuumjw2BXkilOGTcHhI/B0
         eeN+Btypuy/g16d0RPsacU0b5WKxEMqSM//bJN1r6enjgKVjB9xPyw+Ci5DU14VE87eU
         79o/LLMnbYZBaCIXd0BagrsyKucMhGbAjlMkNRXWWQBK5Gva1C1J2bfdiVOBBFuCECz8
         Ra95ISPAJPqvViJmlQy0B7uhirw9PwFvWc8eZ+2IVlKo114OkkPANwe5coiV+UTLrDtw
         +6I10zj7itaYZb+sH83sAsQ3aE98A6B/MoayLxV0F5H3rbjQsuwPnxk8gqvKKidjxCcc
         hp/Q==
X-Gm-Message-State: AOJu0YzJ94EEGwdbUXKWl6/Dx/tzSZ0wsPOZkoYLoiT5xPHZ0JbPsEb+
	Zi6c72IUHWpcuICQBoj+xcIzEGD/8O5TaxSY4xwKTHLIwv5tVenREALQxoX5G8Xk
X-Gm-Gg: AY/fxX7bKGW25H21EDnlfgIPWt21wHNwyYQGgsLD7Un70Pl3bPYJcuJv03B6z4KI5hb
	ADs0ERlAlmlLXsc9YG7FCYgEbzZjHPzUFpRn7z36Cl3qGZ90yRO2jS6TNmrtJB6+o8c3rtNC4p7
	i0mgfx/HjP6iZlI87aml+qNBOdXG1FStGyqZyXeEJ+UduVFsttJ/HPJ0k/PltRmmdRtU+44OtX5
	VskCwWH/jbhsw0rU/EMNZINuZrlkhJdMw9AkxMV3DEhtM5bZv0/r/Wfa+01/WU1HzXF/Gjws/Ea
	A1mHCcFgF2O0P9s1o7creTc9cb4rRiwiBdEUGyVXKBA2NKe5CJLfleeUXqhfzPRlaNWdi5fcXg0
	4G6n9pxLFpkL0xKEP9yQQBgMZWMXG/V9Sd60BytyGmt4V9Zm9GeS0AcLcAEE7ecK1aygypT0=
X-Google-Smtp-Source: AGHT+IFhjfp8iUng3rZnb8udZDChBCD1uV+dGKPvnYGBapEk1VRy0GFtinohxmXmzl6POzntYUhTjA==
X-Received: by 2002:a05:6a00:428e:b0:7a2:7458:7fc8 with SMTP id d2e1a72fcca58-81b7d862d52mr12814023b3a.13.1768149158173;
        Sun, 11 Jan 2026 08:32:38 -0800 (PST)
Received: from oslab.. ([2402:f000:4:1006:809:0:a77:18ea])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b6d9sm15456865a12.34.2026.01.11.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 08:32:37 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH v3] ACPI: processor: Fix a possible null-pointer dereference in acpi_processor_errata_piix4() when debug messages are enabled
Date: Mon, 12 Jan 2026 00:32:14 +0800
Message-ID: <20260111163214.202262-1-islituo@gmail.com>
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
v3:
* Initialize the new variables to NULL and drop redundant checks.
  Thanks Rafael J. Wysocki for helpful advice.
v2:
* Add checks for ide_dev and isa_dev before dev_dbg()
  Thanks Rafael J. Wysocki for helpful advice.
---
 drivers/acpi/acpi_processor.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7ec1dc04fd11..de256e3adeed 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -50,6 +50,7 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
 {
 	u8 value1 = 0;
 	u8 value2 = 0;
+	struct pci_dev *ide_dev = NULL, *isa_dev = NULL;
 
 
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
+	if (ide_dev)
+		dev_dbg(&ide_dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
+	if (isa_dev)
+		dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
 
 	return 0;
 }
-- 
2.43.0


