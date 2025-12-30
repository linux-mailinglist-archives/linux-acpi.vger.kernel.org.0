Return-Path: <linux-acpi+bounces-19911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E0ACEA21E
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 17:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EF8C3003B02
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 16:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D0E256C70;
	Tue, 30 Dec 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Pw5RNqgs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD93224891;
	Tue, 30 Dec 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110814; cv=none; b=fx2ZMYLA9AwKvnW6KKVCDdg79aJ+SJm1DQlilQu5JZR3gqFA7+d3bNZwP7a6YLOMamDFccuepexCad7EHVyylQDvbc8PIwM3fpJvYfQgzchVMT4vZEjT1werOnKfS2rjpy74H/lCuHnhlLptTO5GuJs0oCiNcnlR7wc0Pq/CqfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110814; c=relaxed/simple;
	bh=ta7J9pMCNOQH6SBNsaDltg+n9ViMmROGRYOw7qDx0fE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N2ftqpRCz72eO0bfPoIBtm8RqKvvPfh1+XjrU/0/EY89hE8b6uH4T5IJh5yer8SAZa+mqpwdlK7Z1lrPkZCibbow4p6yIxZuNOKiYl9msuvrn8ylJigrHCdxfjEEnOTmHPYcKi7S4r8tcpuWvfBY8JVi7W6sbsZAcFvchwNdhN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Pw5RNqgs; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ywIV/nsfnU5Yb4gQLa1tc7tVIOpnlOcOFH6qztARMdM=;
  b=Pw5RNqgsPSDnyKlTzd+27lNlWFgaQjdsSfpzPwl39VpZ8XQL0B4FPKLk
   V9DBEfjr4f3X9RPL8kwzMmIGdAGU35XG234EBcwJohkxmpCMrw2kbBvBf
   gz6KEVfdLnKpCuF4re+qmIA5dVTyFUzufoEEqv+E/5GKvgAjuhQvkq7T9
   w=;
X-CSE-ConnectionGUID: voLQ11MMSIqtRSSx+mNV4Q==
X-CSE-MsgGUID: /tJVTwibRHCuuK6qJOIQwA==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.21,189,1763420400"; 
   d="scan'208";a="134756530"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 17:06:50 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: yunbolyu@smu.edu.sg,
	kexinsun@smail.nju.edu.cn,
	ratnadiraw@smu.edu.sg,
	xutong.ma@inria.fr,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: scan: removed outdated comment
Date: Tue, 30 Dec 2025 17:06:44 +0100
Message-Id: <20251230160644.100439-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function acpi_video_get_capabilities() was removed from
drivers/acpi/video_detect.c by commit 87521e16a7ab
("acpi-video-detect: Rewrite backlight interface selection logic") in
2015.  At the time, comments about this function were just removed,
and no replacement seemed to be proposed.  So drop the reference to
acpi_video_get_capabilities() here as well.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/acpi/scan.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 416d87f9bd10..9297461045a2 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1294,8 +1294,6 @@ acpi_backlight_cap_match(acpi_handle handle, u32 level, void *context,
  * The device will get a Linux specific CID added in scan.c to
  * identify the device as an ACPI graphics device
  * Be aware that the graphics device may not be physically present
- * Use acpi_video_get_capabilities() to detect general ACPI video
- * capabilities of present cards
  */
 long acpi_is_video_device(acpi_handle handle)
 {


