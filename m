Return-Path: <linux-acpi+bounces-850-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA467D3F68
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787AE2813D8
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 18:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E119219E2
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="emNSBpG/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546B5219F1
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 18:33:08 +0000 (UTC)
Received: from out.smtpout.orange.fr (out-15.smtpout.orange.fr [193.252.22.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4DD9B
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 11:33:05 -0700 (PDT)
Received: from localhost.localdomain ([89.207.171.96])
	by smtp.orange.fr with ESMTPSA
	id uzjXqFyhBlciauzjaqWBr8; Mon, 23 Oct 2023 20:33:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698085983;
	bh=FMjgweLhTo5SkdcoVkpbQPkyPY7V0wNxVnhTVFmu8Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=emNSBpG/a9z3B1LDISJdjQaKSpJTUuKZpDTHiYtYZlavdx3+54rvcUgu0Cn2sHtnl
	 3FOcFQnp8G5lOpqX9RY0+ui+ci8ifYkIARA+gttPtI+ytelf1TlFTL80WgtS0+yRFe
	 BAmDhOQYLMaQgpbMSW30h0IIfvUfSwQl1o3aEz/t5HqWgKGFN0G1nj+F03Prik93zi
	 jXQ0MuoExuirfsSiR6of0Bk9z+685/GYw7SQfZM6cmnzFjt5VEKxkRk7kRUUHQRP6W
	 sAntpAAf820X/JJyE8N0YeshMzhBqn5vqASJOvWRj679qL5D4SzO6V1RH4QTgrN9cT
	 +VqLoqedq9CDw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Oct 2023 20:33:03 +0200
X-ME-IP: 89.207.171.96
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/4] ACPI: sysfs: Fix the check for a potential string truncation
Date: Mon, 23 Oct 2023 20:32:54 +0200
Message-Id: <20001867d5d19c3b3e677f6020750cc232b3325b.1698081019.git.christophe.jaillet@wanadoo.fr>
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

snprintf() does not return negative values on error.
To know if the buffer was too small, the returned value should be compared
with the length of the passed buffer. If it is bigger or equal, then the
output has been truncated.

Update the test for truncation accordingly.

Also return -ENOMEM in such a case, as already done below in the same
functions.

Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/acpi/device_sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 9d8e90744cb5..4deb36dccb73 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -158,8 +158,8 @@ static int create_pnp_modalias(const struct acpi_device *acpi_dev, char *modalia
 		return 0;
 
 	len = snprintf(modalias, size, "acpi:");
-	if (len <= 0)
-		return len;
+	if (len >= size)
+		return -ENOMEM;
 
 	size -= len;
 
@@ -212,8 +212,8 @@ static int create_of_modalias(const struct acpi_device *acpi_dev, char *modalias
 	len = snprintf(modalias, size, "of:N%sT", (char *)buf.pointer);
 	ACPI_FREE(buf.pointer);
 
-	if (len <= 0)
-		return len;
+	if (len >= size)
+		return -ENOMEM;
 
 	of_compatible = acpi_dev->data.of_compatible;
 	if (of_compatible->type == ACPI_TYPE_PACKAGE) {
-- 
2.32.0


