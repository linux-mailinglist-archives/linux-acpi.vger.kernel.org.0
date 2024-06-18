Return-Path: <linux-acpi+bounces-6481-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A944C90CC7B
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 14:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B63EB29183
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 12:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ADC16CD01;
	Tue, 18 Jun 2024 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmqeELXm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE44916C852;
	Tue, 18 Jun 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714327; cv=none; b=Oks/iSM0USavokSSkyA+ktDeyWK5cqdj9HRLMEfy3u4ZzryMOvE5NA+ocya3WOMXtADu30buU9e2VYOJVl7McaV23BCiXHLQr84Vrp4NuifqomlM/Kph9gKHU/SAPf8I5mGwEMicWeMsdaMUoYxTF8zV3sukWQYF3IKaTZcrcN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714327; c=relaxed/simple;
	bh=jYzeQib9XVD+7muscBuexXT/ekwe1EQRbnwTYZ3UFF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWGHf9d7cW0v9lYY+zRp5nn3L9Vsyhxvq7C1eds6adI0mhdLof9vmGoI2kMR/ickZ8R7c7twLslbDDkryztIkg43knjFM/cJPrv3ld89VHXf7fV8qSC0DrzASzJEBvn5Hn6Pwj24iHNHBBNG6tcFMJ4loJc1Em5vPTTlALGN5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmqeELXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E444C4AF49;
	Tue, 18 Jun 2024 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714326;
	bh=jYzeQib9XVD+7muscBuexXT/ekwe1EQRbnwTYZ3UFF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmqeELXmkZjymRGI8e62uZX1Qb3sylqaTT21tuJebEYn3LCBu9rKXK/YK2ZkiCfEM
	 AUaGxmJ8yQ7j6aQWX9C3wBx6jD8LkExP/U5+DmLarDUTF0iOf8rHirgmlRW//3f8Ts
	 37KXvHObwi1bG4mqako0AQw3KiLMzIBJleTzdZqmGF1JBhu4R+1em4BJ/j9giVDwNQ
	 ST+FjcEjJkLlrdKxKLAIhDRvIEN/1uznjBNA3JKU8/YBFXhNp0sBiLo7NC5XPRGC5+
	 Yce/rfMz3ZmKwSQQBJwPnu2c3qufLRQEoqQUQ0pvy8pKAlA8dUtIgaYVd4miEVCmKr
	 EY5Sedsoeelyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/35] ACPI: EC: Abort address space access upon error
Date: Tue, 18 Jun 2024 08:37:28 -0400
Message-ID: <20240618123831.3302346-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit f6f172dc6a6d7775b2df6adfd1350700e9a847ec ]

When a multi-byte address space access is requested, acpi_ec_read()/
acpi_ec_write() is being called multiple times.

Abort such operations if a single call to acpi_ec_read() /
acpi_ec_write() fails, as the data read from / written to the EC
might be incomplete.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a59c11df73754..2e907800417db 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1333,10 +1333,13 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_enable(ec);
 
-	for (i = 0; i < bytes; ++i, ++address, ++value)
+	for (i = 0; i < bytes; ++i, ++address, ++value) {
 		result = (function == ACPI_READ) ?
 			acpi_ec_read(ec, address, value) :
 			acpi_ec_write(ec, address, *value);
+		if (result < 0)
+			break;
+	}
 
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_disable(ec);
-- 
2.43.0


