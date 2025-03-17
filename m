Return-Path: <linux-acpi+bounces-12292-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7D8A64B20
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 11:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7914A188BB91
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265A0236A70;
	Mon, 17 Mar 2025 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="JI/6N8x4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870123496F
	for <linux-acpi@vger.kernel.org>; Mon, 17 Mar 2025 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208928; cv=none; b=Xk5hJ+FS7fNcWsMzYNWQNGtF9iIaNc5jPzXi/05UaueJjMJnwxUn3PBEp2ckozDe0kqU97oZK+eb+KwypYvsFohyqy7Iu5N6X6uYOVEZtInLvUl5I2qtgtf8YkYEHyMQ9u5bhoHEyfS5ZM3ulENIEgq3mc5w2r/8m+OXY8pqRh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208928; c=relaxed/simple;
	bh=GwZkwEPq4cFO76H7Y98P0dYu+xTlZLKLmJbqtXxtgoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=atH1GiJM67dBId7mZ0rOt2K3gAtnJr0EYYpSHfonsw0Lu3cgHLnXsACp/saOGVxrihYt1pqjQUjluiAqRJfbiTBWxJQI+x5aHAb5T4f4Z/64Aq8OhGzLezUXN/AlqxiEv3fmj0TsD6bs54h4lh1PTqb54quQUNY0EzmZEZm5kJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=JI/6N8x4; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202503171055163652efe79be5d12c76
        for <linux-acpi@vger.kernel.org>;
        Mon, 17 Mar 2025 11:55:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=y+mw3eTX34ZhavSHte3oJKReRA6UkQ9FchpympJdBDU=;
 b=JI/6N8x4mVjbr45hoavaLf/aGefRfdWxattg46X3Dgi2YoJwOiU7qtwyX+PDRFDJGSvmJS
 oNhMnWUbaAFifbwveZqS8Q58YJDx8eASUrPkzRf4NqC7B7GEH3Sk77XNkvLJ2091pK859sPJ
 SOBBYDlT+AHZjZEWpeM5+L01Q/eeRQ6CIif1OXBty95ZfIN7ZniIK4twi4R53VtuQsBXx0q8
 qPUpk81klcLeXON8sJ2oqrPgAoB48oxzC+5iABsjiGsqmc1wXOkVAj2LItFibFyLLi8Oa/4b
 VaPie81M8C5mlCk48z6s8MMI7LF9/bdQzEFXxW7QHSU3TKHL0eJNZ2DQ==;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Mon, 17 Mar 2025 10:55:07 +0000
Subject: [PATCH v3 2/2] ACPI: PNP: Add Intel OC Watchdog IDs to non-PNP
 device list
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-ivo-intel_oc_wdt-v3-2-32c396f4eefd@siemens.com>
References: <20250317-ivo-intel_oc_wdt-v3-0-32c396f4eefd@siemens.com>
In-Reply-To: <20250317-ivo-intel_oc_wdt-v3-0-32c396f4eefd@siemens.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com, 
 benedikt.niedermayr@siemens.com, Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742208915; l=1282;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=GwZkwEPq4cFO76H7Y98P0dYu+xTlZLKLmJbqtXxtgoY=;
 b=6W9q+5XD/i/wOmfmYYsERYU3EDKkvbACjgaHLOvYW415Tn+DZKc/jwF11nhb5qU641xyfV2NK
 DT/iPamQrcNBFjD2X1vM0AZpPQsQ569/PQ+TDiJXO8jY/GeJqhRlUT6
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

Intel Over-Clocking Watchdogs are described in ACPI tables by both the
generic PNP0C02 _CID and their ACPI _HID. The presence of the _CID then
causes the PNP scan handler to attach to the watchdog, preventing the
actual watchdog driver from binding. Address this by adding the ACPI
_HIDs to the list of non-PNP devices, so that the PNP scan handler is
bypassed.

Note that these watchdogs can be described by multiple _HIDs for what
seems to be identical hardware. This commit is not a complete list of
all the possible watchdog ACPI _HIDs.

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
v2->v3:
 - Reword the commit message to clarify purpose of patch
---
---
 drivers/acpi/acpi_pnp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 01abf26764b00c86f938dea2ed138424f041f880..3f5a1840f573303c71f5d579e32963a5b29d2587 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, const struct acpi_device_id **matc
  * device represented by it.
  */
 static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
+	{"INT3F0D"},
 	{"INTC1080"},
 	{"INTC1081"},
+	{"INTC1099"},
 	{""},
 };
 

-- 
2.48.1


