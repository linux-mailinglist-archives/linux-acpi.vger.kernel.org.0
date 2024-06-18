Return-Path: <linux-acpi+bounces-6491-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E6090D151
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 15:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F0FB247F6
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AE81BD006;
	Tue, 18 Jun 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cey6OfGT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D5B1BD001;
	Tue, 18 Jun 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714602; cv=none; b=QkSYLzOBizmIiJcJZQki5swPT5nY6W4CFUmHaMpZWGOtbDbRzZgDBZj8CHAF1sc8YKgfswVbpymeZZ7uu0c3ti3H1iaU4rall3lYxa/kSFm2ewzKRs5cliF6YeYMAhM2isVLNrNPCKfdvB73/Ii6OmzcXvVtKMukWDskYb58C/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714602; c=relaxed/simple;
	bh=KZVRndqYkMzG6a/CM2CqN0VHNjdjWAWfe08qLKW8XvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWtzWfokAQLZ2KdjHzdN66uKJSvnzqDGQY/DkGNXa7tEzLuvHAu4catKn9b6fOTJQtbLzAbHTaP7mpMADncf4mNts3p2C33UuY50ia798Fgl6q202n0duQ2zLq53k/y4ukkmbNXfHuwlbPGIWDJzNZRhEKCjvdZhLoC1Bg5KlvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cey6OfGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3C3C4AF49;
	Tue, 18 Jun 2024 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714602;
	bh=KZVRndqYkMzG6a/CM2CqN0VHNjdjWAWfe08qLKW8XvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cey6OfGTzNahryXX/TL0GJIS0b2FM5j7y2qb2tAEIgodBPnEKqR3fSpEL8x752Ghu
	 KAOJ3Lkb6MwEE4JBK/RPazYI7pWK0QfUGvtZUC2xjLG3ueoUzUC0GHTuAP96M5agbP
	 g1uNPtGeimZAPLIasRIz0CzcQvFKxr/GOB33/Yj8Ss2kCX8LeNuLyWqA1eWFHLkgfS
	 21ChvaCkkH4dNYWroiy4x6jrIwVlzij4FFZNdkbmOnWEwyWerzmkNUBsFu3Q7RDLE2
	 uw5oF978y0bqtHCeaf1zrS7gOH4mlgzpf6AvMFBadwKBoTrRF8CgcLaRq8xJaxrf/j
	 d1Y9Myj+TILww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/9] ACPI: EC: Abort address space access upon error
Date: Tue, 18 Jun 2024 08:43:08 -0400
Message-ID: <20240618124318.3304798-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124318.3304798-1-sashal@kernel.org>
References: <20240618124318.3304798-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.316
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
index d2fde87e4d0d4..78f8b8b5a8099 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1330,10 +1330,13 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
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


