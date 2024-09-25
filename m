Return-Path: <linux-acpi+bounces-8395-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4679858CE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 13:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5088B1C209F3
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 11:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222B3183087;
	Wed, 25 Sep 2024 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GESBhKxt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B571922F9;
	Wed, 25 Sep 2024 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264287; cv=none; b=SLEkrIb2LSGV6/0c7jrtdLSZ5LBCOAKsc/fIdLwWShrDOFPMg5uiVFQfjQp97NOKOofDL0BM6P35crJCzy1Hwfl+zGzqFrOlmgXyd52emk8S7DMG2kod8LVtaoXKvP/a2hv49fwfo3MLtDwYfdQiSeOblISDVP13+aPh4GVZgUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264287; c=relaxed/simple;
	bh=7+qaFXH0HlkJAN23/jiRHB9vYRDP7nJCFkdPt8W6xZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8shtwH7JVkEB/fKTGrlnN+gHNqst03ENgf3V4JQ6XHwur/IzLnRq+R4DHpigEklWUl1JXxjbBPydOSBPY1FXsNvvrfS+wsl0zzGVy5gUlg6IzKK3ZCXRlEArNRqmvinBvVTieOJzu0Wg/Y2ETuxjl72x0yHcPpd+Sq7V/GVSrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GESBhKxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E064DC4CEC3;
	Wed, 25 Sep 2024 11:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264286;
	bh=7+qaFXH0HlkJAN23/jiRHB9vYRDP7nJCFkdPt8W6xZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GESBhKxtgxmTa2wactyJidZmgN+poyUXRSwlgBlOWZI5yOSQJe8Aw2YQizWe65tBZ
	 DabhD+k55TKA9eskTki3axWOorwxlMlU2kCA1moh1jrtqgPCKV5bqk3HXtD5oaWoor
	 +Ee41cxKya5IoV3kG53ywfiHJd9ISN+Bi4FLMHjypo3SkA6zPu7kyalIIuOaUNX/P6
	 Ek8aciHEvemTLpkJKBKwsyjh8/v2LSXR7NzzF6wT06vVBVa9yrikxOqHGt3WauzRvp
	 sqTWUApGKYnONO9OengyW8wlVuNf5wf9GFM/tH5C0zTTLFyFetX74pm+wHV0LOOSKj
	 ciWgPMVPtQ4pQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 040/244] ACPI: EC: Do not release locks during operation region accesses
Date: Wed, 25 Sep 2024 07:24:21 -0400
Message-ID: <20240925113641.1297102-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit dc171114926ec390ab90f46534545420ec03e458 ]

It is not particularly useful to release locks (the EC mutex and the
ACPI global lock, if present) and re-acquire them immediately thereafter
during EC address space accesses in acpi_ec_space_handler().

First, releasing them for a while before grabbing them again does not
really help anyone because there may not be enough time for another
thread to acquire them.

Second, if another thread successfully acquires them and carries out
a new EC write or read in the middle if an operation region access in
progress, it may confuse the EC firmware, especially after the burst
mode has been enabled.

Finally, manipulating the locks after writing or reading every single
byte of data is overhead that it is better to avoid.

Accordingly, modify the code to carry out EC address space accesses
entirely without releasing the locks.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/12473338.O9o76ZdvQC@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 55 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 38d2f6e6b12b4..25399f6dde7e2 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -783,6 +783,9 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	unsigned long tmp;
 	int ret = 0;
 
+	if (t->rdata)
+		memset(t->rdata, 0, t->rlen);
+
 	/* start transaction */
 	spin_lock_irqsave(&ec->lock, tmp);
 	/* Enable GPE for command processing (IBF=0/OBF=1) */
@@ -819,8 +822,6 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 
 	if (!ec || (!t) || (t->wlen && !t->wdata) || (t->rlen && !t->rdata))
 		return -EINVAL;
-	if (t->rdata)
-		memset(t->rdata, 0, t->rlen);
 
 	mutex_lock(&ec->mutex);
 	if (ec->global_lock) {
@@ -847,7 +848,7 @@ static int acpi_ec_burst_enable(struct acpi_ec *ec)
 				.wdata = NULL, .rdata = &d,
 				.wlen = 0, .rlen = 1};
 
-	return acpi_ec_transaction(ec, &t);
+	return acpi_ec_transaction_unlocked(ec, &t);
 }
 
 static int acpi_ec_burst_disable(struct acpi_ec *ec)
@@ -857,7 +858,7 @@ static int acpi_ec_burst_disable(struct acpi_ec *ec)
 				.wlen = 0, .rlen = 0};
 
 	return (acpi_ec_read_status(ec) & ACPI_EC_FLAG_BURST) ?
-				acpi_ec_transaction(ec, &t) : 0;
+				acpi_ec_transaction_unlocked(ec, &t) : 0;
 }
 
 static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 *data)
@@ -873,6 +874,19 @@ static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 *data)
 	return result;
 }
 
+static int acpi_ec_read_unlocked(struct acpi_ec *ec, u8 address, u8 *data)
+{
+	int result;
+	u8 d;
+	struct transaction t = {.command = ACPI_EC_COMMAND_READ,
+				.wdata = &address, .rdata = &d,
+				.wlen = 1, .rlen = 1};
+
+	result = acpi_ec_transaction_unlocked(ec, &t);
+	*data = d;
+	return result;
+}
+
 static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
 {
 	u8 wdata[2] = { address, data };
@@ -883,6 +897,16 @@ static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
 	return acpi_ec_transaction(ec, &t);
 }
 
+static int acpi_ec_write_unlocked(struct acpi_ec *ec, u8 address, u8 data)
+{
+	u8 wdata[2] = { address, data };
+	struct transaction t = {.command = ACPI_EC_COMMAND_WRITE,
+				.wdata = wdata, .rdata = NULL,
+				.wlen = 2, .rlen = 0};
+
+	return acpi_ec_transaction_unlocked(ec, &t);
+}
+
 int ec_read(u8 addr, u8 *val)
 {
 	int err;
@@ -1323,6 +1347,7 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	struct acpi_ec *ec = handler_context;
 	int result = 0, i, bytes = bits / 8;
 	u8 *value = (u8 *)value64;
+	u32 glk;
 
 	if ((address > 0xFF) || !value || !handler_context)
 		return AE_BAD_PARAMETER;
@@ -1330,13 +1355,25 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (function != ACPI_READ && function != ACPI_WRITE)
 		return AE_BAD_PARAMETER;
 
+	mutex_lock(&ec->mutex);
+
+	if (ec->global_lock) {
+		acpi_status status;
+
+		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
+		if (ACPI_FAILURE(status)) {
+			result = -ENODEV;
+			goto unlock;
+		}
+	}
+
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_enable(ec);
 
 	for (i = 0; i < bytes; ++i, ++address, ++value) {
 		result = (function == ACPI_READ) ?
-			acpi_ec_read(ec, address, value) :
-			acpi_ec_write(ec, address, *value);
+			acpi_ec_read_unlocked(ec, address, value) :
+			acpi_ec_write_unlocked(ec, address, *value);
 		if (result < 0)
 			break;
 	}
@@ -1344,6 +1381,12 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_disable(ec);
 
+	if (ec->global_lock)
+		acpi_release_global_lock(glk);
+
+unlock:
+	mutex_unlock(&ec->mutex);
+
 	switch (result) {
 	case -EINVAL:
 		return AE_BAD_PARAMETER;
-- 
2.43.0


