Return-Path: <linux-acpi+bounces-12293-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB149A64BBB
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 12:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E7A18896A0
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9C721B18C;
	Mon, 17 Mar 2025 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="ZBunS47O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A2230BC7
	for <linux-acpi@vger.kernel.org>; Mon, 17 Mar 2025 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209530; cv=none; b=qo1eogyOrdMtCmlm7pS3p70i7ebogXiixGG4+HHEvhD8n7nFMPeybovU3QT/gVq7GLbtTPpV3wOTMqJ+yDagnIF8zMH95EPyjR0VmTqzz6jBh9siQTNp0qTYv2Cgav4RII/RrPDR5Prih2/XX53dQvPU/J8PvZpyHQPI9scb6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209530; c=relaxed/simple;
	bh=qzqq/7eO9HlSVpfTbFEf2KxsNWJh4uzOQ4PMMxfymlc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AY9FA8RZLrc6a0Q2JBsKONqzw09vwq4ZaJeqQD8uc1KEduKo5tHCQnwPTQl8XDhy7KFYfz2OSv1MZD5Zk/O4mefWvHXBQQhb9c1rc1+cED5gyDWaNjaodPXm8HLBXrZeb6sVGLaSomIq335J3rQSSpP9moh2GIe1jggb29IyHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=ZBunS47O; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250317105515ee02dbed682c0670f4
        for <linux-acpi@vger.kernel.org>;
        Mon, 17 Mar 2025 11:55:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=iCVYWatVYU36O55+g5B1I8cvGW344XdCB1TdauW5fac=;
 b=ZBunS47OaZEdtWvOtUCsWohrukHNHzF7VilT7f9MSB5H9zoi5YSt6FUSumoh88h0IkiQpX
 UFUw3MdKT2Jn0z90hbWpiDWQGyFBcxoyBiTZzc8HwLsvRhdP4MvNbSl3gbPmIkN0VswJSEM6
 H2eT0ntgg3Xewp5MHQgh5B+bthLpSi/2j4YK0X1usmNMBDp7QRuGQYNd7os9bfxw+p8UsqL8
 Gioo7edIgdgqD+yEx+PIXjrcd/7bS3thMnGLUCyxkfdfW9ujDxmSPaBvokbZ1i3rSXflFdow
 Db6zZGqa3n4FZfcmIyFPWKLELtnr4Pec9VF1m5jzo3gc32QASm1dElKg==;
From: Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH v3 0/2] Add driver for Intel Over-Clocking Watchdog
Date: Mon, 17 Mar 2025 10:55:05 +0000
Message-Id: <20250317-ivo-intel_oc_wdt-v3-0-32c396f4eefd@siemens.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIn/12cC/23NTQrCMBCG4atI1o7kr03rynuIlJqkdsAmkpSol
 N7dtG4UXb4fzDMTiTagjWS/mUiwCSN6l0NsN0T3rbtYQJObcMoLyrkCTB7QjfbaeN3czQiqlZV
 opSlbKkk+uwXb4WMlj6fcPcbRh+f6IbFlfWOCsV8sMWDQGamoLKmpu+IQ0Q7WxZ32A1m4xD8J/
 ofgQKHghtZKVNrQ8zcxz/MLgY3JA/UAAAA=
X-Change-ID: 20250227-ivo-intel_oc_wdt-7a483a4d6a04
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com, 
 benedikt.niedermayr@siemens.com, Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742208915; l=2033;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=qzqq/7eO9HlSVpfTbFEf2KxsNWJh4uzOQ4PMMxfymlc=;
 b=PnoDLgylyYGseCNwf2Am4PAbQPQHRpam/2bdmMQb1RZCNbD7LSvFTDICIQtMrHu/MMTwmTRU5
 3wUkFrx4DX7DFl+lnzoLy5BujClkQRIGGu+Qi+p5V1JEO920kTD+rIQ
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

This series adds a driver for the Intel Over-Clocking Watchdog found in
the Intel Platform Controller Hub (PCH).

This watchdog is controlled via a simple single-register interface and
would otherwise be standard except for the presence of a LOCK bit that
can only be set once per power cycle, needing extra handling around it.

Due to the way these devices are described in ACPI tables with both the
generic PNP0C02 CID and a more detailed ACPI HID we also need to add
their HIDs to the list of known non-PNP devices. As there are several HIDs
for what seems to be essentially the same hardware but I don't know all
the possible HIDs this series does not include an exhaustive list of all
such HIDs, only those that I could personally test.

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
Changes in v3:
 - PATCH 01:
  - Collect R-b from Guenter
 - PATCH 02:
  - Reword the commit message to clarify purpose of patch
- Link to v2: https://lore.kernel.org/r/20250312-ivo-intel_oc_wdt-v2-0-52d09738cd0b@siemens.com

Changes in v2:
- Split v1 into two patches, adding the ACPI IDs in a separate patch
- Initialize hearbeat module parameter to zero
- Clarify wording around lock handling
- Properly print resource with %pR when failing to obtain it
- Enable compile testing and add dependency on HAS_IOPORT
- Drop unneeded ACPI_PTR() and MODULE_ALIAS()
- Link to v1: https://lore.kernel.org/r/20250311-ivo-intel_oc_wdt-v1-1-fd470460d9f5@siemens.com

---
Diogo Ivo (2):
      watchdog: Add driver for Intel OC WDT
      ACPI: PNP: Add Intel OC Watchdog IDs to non-PNP device list

 drivers/acpi/acpi_pnp.c         |   2 +
 drivers/watchdog/Kconfig        |  11 ++
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/intel_oc_wdt.c | 233 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 247 insertions(+)
---
base-commit: b7f94fcf55469ad3ef8a74c35b488dbfa314d1bb
change-id: 20250227-ivo-intel_oc_wdt-7a483a4d6a04

Best regards,
-- 
Diogo Ivo <diogo.ivo@siemens.com>


