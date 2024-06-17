Return-Path: <linux-acpi+bounces-6448-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A700690AF34
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 15:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0716F286EEE
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5196219D099;
	Mon, 17 Jun 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXh1X4BF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2702219D094;
	Mon, 17 Jun 2024 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630462; cv=none; b=O1D8fLMY+/nwUhlf6TNcUIFlAj6H1Jy3DCYHypOePNXoOfOCnvVfKFd1FOK2Qi7CtS4nrjb/6Yqv4rYbzCPwecEcYMFqS0wzrmLzNeodKHJQAqnAzBKYNZcKw8zB8AgsqpXjdsdrNl+F+8UYr5LR6c31EhP07/Eai1WsOOnFC0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630462; c=relaxed/simple;
	bh=3GxZABKnNxzCFT2y+l+8KtO4NBP4L+z+Tsc2aH64Q8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSyAm6zgVhH6soWgMWetWhfq2LTeJ55J4QWwqFXdwbXP+5rivY5sE6aaZvsG5t9wxyLja5NfL1S499SGu3ahoDLcIui+A64Ji/J7x0iAZoOQoV+ngbU6owYUfnADloC6046XUX50i+UBjg+SrhGyLnkIHNjJFHDr/h5qPuwc/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXh1X4BF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDED9C4AF50;
	Mon, 17 Jun 2024 13:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630461;
	bh=3GxZABKnNxzCFT2y+l+8KtO4NBP4L+z+Tsc2aH64Q8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXh1X4BFfABULtRBzHP0c2ci7rCI8/dLKogpSgVdx8KAfTmfAJ2JKs/pwU/vcUdBT
	 zo7vGPLaI2mSNFnLF4GdZmWoF3eVJFzq3bI7Q+5wdxwz+HS3ZYfWFCJn/BmGcQcxD4
	 zOMJ2DDOGd9b6I9hMx7Bsm0L1zlfkCt0rSdXGg8lrR1gM6LOE56nLvENoT0smiuyPH
	 5Fxe2cyqU2YTz46GsirL9MIbAbOEeQ/7PsBaEU7tYe4CtuOHtN8SI2v/vWO4Z5B23C
	 3HLrlrdTwTU27jxJak8oYenxmOrPPDOdM3QLhKJ14Hbn6qQoheo0VA3yHpFUpsDQq9
	 OBoNOPe4/KF8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 08/44] ACPI: EC: Abort address space access upon error
Date: Mon, 17 Jun 2024 09:19:21 -0400
Message-ID: <20240617132046.2587008-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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
index 02255795b800d..2896330146e29 100644
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


