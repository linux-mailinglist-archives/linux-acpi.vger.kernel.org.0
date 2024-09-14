Return-Path: <linux-acpi+bounces-8297-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA00397913F
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Sep 2024 16:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18CA51C21590
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Sep 2024 14:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462891D014B;
	Sat, 14 Sep 2024 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="mIdOF9cL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761051CEEBC;
	Sat, 14 Sep 2024 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726322442; cv=none; b=Z47idSqXqmMD8c5Rc/X6VmAZJ2Yndk7AIn1JDJ4HyJRffkjxX2jhn4BBF4fEJ1HGg7b9bqS6O+BUERwdLvOWxj1445tppH9o/h7iSkZ3lj62yJpvs0WlouPgg3PMW1AkB4o9cDmomMKNEPI0abCfSjXHk2Dg2R1eguO6g32LEqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726322442; c=relaxed/simple;
	bh=WjiCI3uPDALvFxpq797/LeRswOgYrgmUE/48wc8GCS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHUVzxcx+UNFwCDY+bIO8RAR0KUNJzSb8ksodl+EEfgzFB8vthhNCdob4CvWAXK6Hi85z5ZvjJkkhPxy/rY1Mlp+ww5quSmMuhNKGq1xUHWKNMaqOI0CCN4bIgj4q9iarbJDyPpn18EmXfuLd5Bw6TOBhj/l8P71JfVf7NiFZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=mIdOF9cL; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=IgiVZmpPaxA7yTrfKCOk/TPO7oQF+hBHzvGHp80KM8c=; b=mIdOF9cLZixsmdw3
	S9ElMbPLju11NwzAkISU9Mt2zDGZRnRw9xHwfvVv+E6/lOEKdfKtgXr3NVKBtk2C/jRu1Pz3Ctzcg
	gJTK4El9yI4AK1vZ2zmHH/GjhtANzPLL/5mLOATdembRGolzhjQChGEjFdUe+m+7a8nCg5oEbrMGn
	tdcRf1RdFrDQ5+YSvZaSwLaZzW7ZFgRs+vJTwqEbtnSZWY/ixRYrA+MN2/uDZfklvMu9bdFnOhcWH
	Tb2aVgfw6iOlc/G6fPJFcO88BeFoAvHhdl+U61I5nduDmjOA9KPEJrkC3MP0OIBhDkH6OGUbcypFB
	85GJ0CBwL4O5B54rtA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1spTKF-005kog-33;
	Sat, 14 Sep 2024 14:00:35 +0000
From: linux@treblig.org
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] ACPCIA: Remove unused acpi_ut_check_and_repair_ascii
Date: Sat, 14 Sep 2024 15:00:34 +0100
Message-ID: <20240914140034.29172-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'acpi_ut_check_and_repair_ascii' is unused, remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/acpi/acpica/acutils.h |  2 --
 drivers/acpi/acpica/utascii.c | 30 ------------------------------
 2 files changed, 32 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index edfdbbef81c1..9f0830a63c10 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -158,8 +158,6 @@ u8 acpi_ut_valid_nameseg(char *signature);
 
 u8 acpi_ut_valid_name_char(char character, u32 position);
 
-void acpi_ut_check_and_repair_ascii(u8 *name, char *repaired_name, u32 count);
-
 /*
  * utcksum - Checksum utilities
  */
diff --git a/drivers/acpi/acpica/utascii.c b/drivers/acpi/acpica/utascii.c
index 2be37676edd7..0f03745934d6 100644
--- a/drivers/acpi/acpica/utascii.c
+++ b/drivers/acpi/acpica/utascii.c
@@ -74,33 +74,3 @@ u8 acpi_ut_valid_name_char(char character, u32 position)
 
 	return (TRUE);
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_check_and_repair_ascii
- *
- * PARAMETERS:  name                - Ascii string
- *              count               - Number of characters to check
- *
- * RETURN:      None
- *
- * DESCRIPTION: Ensure that the requested number of characters are printable
- *              Ascii characters. Sets non-printable and null chars to <space>.
- *
- ******************************************************************************/
-
-void acpi_ut_check_and_repair_ascii(u8 *name, char *repaired_name, u32 count)
-{
-	u32 i;
-
-	for (i = 0; i < count; i++) {
-		repaired_name[i] = (char)name[i];
-
-		if (!name[i]) {
-			return;
-		}
-		if (!isprint(name[i])) {
-			repaired_name[i] = ' ';
-		}
-	}
-}
-- 
2.46.0


