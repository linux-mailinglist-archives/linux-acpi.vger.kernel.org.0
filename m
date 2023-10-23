Return-Path: <linux-acpi+bounces-854-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B697D4110
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 22:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDB21C20506
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B00323749
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iP/bKu14"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB721349
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 19:33:30 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615E1C5
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 12:33:29 -0700 (PDT)
Received: from localhost.localdomain ([141.170.221.62])
	by smtp.orange.fr with ESMTPSA
	id v0fzqGEQclciav0g4qWHEJ; Mon, 23 Oct 2023 21:33:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698089608;
	bh=/5Qo3nS8waaAiEey/mOoHQa+DwKTxtDvbnHYmE4+GsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iP/bKu14gUhGjswtz4l38t2ht/2Tcp77Pltkl5s8fh2CbTDC3k+5SxHNQw8oSj4Q0
	 ImbJS7ubWWo7ZyBd+EbHnjPYcHXocTMqD42S7miGBjMv85zuknLVGSZnuFs6t+H2G+
	 5aAp6lTX+7wPIfLmMt4BH3FtovjY8jktzW2yihDchkpC9t2APtudx3rPK6XLxjQ4dP
	 052FHs+M3uNsazOSc2hEUNk7eJ01TjzZzzwSOm9Smj/OiKPkfyTMaswnvIV+z9nHWM
	 k26E1DIo/DfM6JyJA9UtjIDmz+9HCOnKgUvpbTwiW56ITasuxPVxfBwREJmtOE7aNh
	 GyTo42AJXguFw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Oct 2023 21:33:28 +0200
X-ME-IP: 141.170.221.62
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/4] ACPI: sysfs: Remove some useless trailing NULL writes
Date: Mon, 23 Oct 2023 21:33:17 +0200
Message-Id: <d357fca843f8d3cc36a048732585de24d379a292.1698081019.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'modalias' is only written with snprintf(), so it is already guaranteed to
be NULL terminated.

Remove the unneeded (but harmless) writes of a trailing '\0'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/acpi/device_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 7ec3142f3eda..1cf6568a813f 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -177,7 +177,7 @@ static int create_pnp_modalias(const struct acpi_device *acpi_dev, char *modalia
 		len += count;
 		size -= count;
 	}
-	modalias[len] = '\0';
+
 	return len;
 }
 
@@ -237,7 +237,7 @@ static int create_of_modalias(const struct acpi_device *acpi_dev, char *modalias
 		len += count;
 		size -= count;
 	}
-	modalias[len] = '\0';
+
 	return len;
 }
 
-- 
2.32.0


