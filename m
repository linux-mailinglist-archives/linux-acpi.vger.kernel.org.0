Return-Path: <linux-acpi+bounces-6483-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC2490CD10
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 15:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87BFDB2B66F
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C76E1A00F7;
	Tue, 18 Jun 2024 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlszXGvS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EBC1A00EF;
	Tue, 18 Jun 2024 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714433; cv=none; b=qxoZqy4mZqPe40ym9CopumgYEzGTIp7RgwLbFlJHpZ3VNyBW3JLLv3eF29lMc7yaDp25T5TaPXMxMBVOrtHobUocEjAJkaDL+YVzJCZ/H8Xms8G8epgLd/qMAqiWeXzGtDv3d00XDiZwNDxAnpJrQZngW5wpH4rfRkituRhb9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714433; c=relaxed/simple;
	bh=nN21iP/qqfxyiAcks/jH3Q+FVdKoWkOs6ojS1nTvEeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT66U1P10f3ax0kLgkUjuCmsqX9LPEUlOPnLlMLcl9RdodFbLX73ZaBbObFTGErgROFkQHC4rJ5mMsIVb4BKjD0FFujghZIGtN1qu3QRGqNdHcREj6Q1vwp+TNEq/KtV7h2KVL+SrQYct1dye8ZszP+BY4R8hkDNOB65wOh8LKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlszXGvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C165C32786;
	Tue, 18 Jun 2024 12:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714433;
	bh=nN21iP/qqfxyiAcks/jH3Q+FVdKoWkOs6ojS1nTvEeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlszXGvS/54WNRrklS0yqNqo7ooOZWKNoQ+qRSyioH8nh1fwmaqWkRR2cgO5YUIQV
	 uXBYsS6YZlpCuQiR62s9TbxZ5cYdPzrOVk+VaDwCxvwxxZ17obrzNN5avdaCspNSSX
	 E3thLfKyyK03gkg/ihYenq3l+YXWvAy8bQyuTgAFDEllQ1Pb61UqE5L7LtxBNA6nw5
	 9HFQWWetjG5ZQwm6+jaYSR60fa5WJkYoSt6bm5akw439EGv/iIR959ZW8g5IfPCbZ7
	 44mzZrAzrpw+1A9hgsPFd3BAouxIIcruXFAWpvfxquCc40lljRL5hAxReRm0IzNBHY
	 2a+zXK9OtT8yA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/29] ACPI: EC: Abort address space access upon error
Date: Tue, 18 Jun 2024 08:39:34 -0400
Message-ID: <20240618124018.3303162-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124018.3303162-1-sashal@kernel.org>
References: <20240618124018.3303162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.94
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
index 77d1f2cb89ef3..fc3dc83bb8707 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1314,10 +1314,13 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
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


