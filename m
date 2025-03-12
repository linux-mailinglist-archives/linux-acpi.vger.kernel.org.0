Return-Path: <linux-acpi+bounces-12123-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B78F2A5E0D6
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 16:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C462188A306
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541DF252907;
	Wed, 12 Mar 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="TmfXhxUl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2174200CB
	for <linux-acpi@vger.kernel.org>; Wed, 12 Mar 2025 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794371; cv=none; b=hXQlon1YwG2jakaUy6k999TmwoJsO5/a2obUYMk+tVSYR5zZtNAazyOosqxAKtGIjtCu+yIt6F8pKKrfTnlHJUiq56IFG/7FVVY7IwTzugkoxZggFS3WrnGq09a0vVLOhoZ4rr//8FZCwblp3gYjUYpqd/v7ufi+ZSVdQm9f9mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794371; c=relaxed/simple;
	bh=/tUeJxexUe7TBjTwiMUFAxVHNQcz9K5ss0oO62XNxrU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MN+aq3oeDTlaz2dSQ/jHG6SqhitARBZZC2AgKAMXmQHM9GRby51zJNQda7BOvYoM8f6HGhvVsw54FPn50zKTiMOKV331aP8L7OAagfwX+pwCgvplfOUkHxJzslLyr481BAkl8uMHujq4bWMVxAwJ3oGv+Gyk8p8j8plKjPu9ppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=TmfXhxUl; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250312154605faca1e93f4ba30d6b9
        for <linux-acpi@vger.kernel.org>;
        Wed, 12 Mar 2025 16:46:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=rFXi/EOvlI1q63UTtN3+2lWAAJojD4xng4L7RXQth+s=;
 b=TmfXhxUlb5zlX/dhogvn+w+uyGg11Igc3cdTjsIYm41TmFHuAVOsLPoYu2dzPWCQ1hnfs5
 +0L7QFOlT9aTIBIeI8UBliPigCpQxGPHDSOJOgSG5vElYzqj6IxucRvrITgi4KXe3ybvWh2/
 aOlTBD5hzWTvOAiTVIw3BrLz2R4xWLqVCDSYa6crwk6Y/CGk/4RzJQ7oJkU8EbOHveR6J1IZ
 +imxC/YnCqa1zQty4KBnOTXqZ1tfEOXtHCgtFCZUtU+a/tlFp4CEa4b1jYXpcJAsVsLtfDjR
 gpzQ8mORHQReFMmDjTd+M3Ny68OOH/4WUIYJNHiUj5T3iBqAB3zzHc4Q==;
From: Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH v2 0/2] Add driver for Intel Over-Clocking Watchdog
Date: Wed, 12 Mar 2025 15:46:00 +0000
Message-Id: <20250312-ivo-intel_oc_wdt-v2-0-52d09738cd0b@siemens.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADis0WcC/2WNwQ7CIBAFf6XZsxigtFVP/odpGgKL3cRCAw1qm
 v67WI8eZ5I3b4WEkTDBpVohYqZEwReQhwrMqP0dGdnCILlsuJQdoxwY+QUfQzDD0y6s0+pUa2V
 bzRWU2RzR0WtP3vrCI6UlxPf+kMXX/mK1EP+xLJhgzqqOq5bbs2uuiXBCn44mTNBv2/YB0wf+v
 rIAAAA=
X-Change-ID: 20250227-ivo-intel_oc_wdt-7a483a4d6a04
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com, 
 benedikt.niedermayr@siemens.com, Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741794365; l=1801;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=/tUeJxexUe7TBjTwiMUFAxVHNQcz9K5ss0oO62XNxrU=;
 b=jjgZeYqbuCnZ8jjOQM3TswX/VHg6IR2spnqrZYd/n1yvUzhlZYhQKegcofEklo5mqLrNlVZVd
 Fba/SDF0avkCz7sY9Ovixq9Y9TF/BpheaOButsaFuMsR7muPkVct59q
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
base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
change-id: 20250227-ivo-intel_oc_wdt-7a483a4d6a04

Best regards,
-- 
Diogo Ivo <diogo.ivo@siemens.com>


