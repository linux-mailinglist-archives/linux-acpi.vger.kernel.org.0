Return-Path: <linux-acpi+bounces-6487-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27F190CD78
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 15:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D411C2198E
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 13:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623601B012A;
	Tue, 18 Jun 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcHeJ57f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EED1B0125;
	Tue, 18 Jun 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714555; cv=none; b=cfbAgpQ0b2Mck3zIQTz/qz+BuZkb3/bQ14fcGOVkN6t6Xolh/j6CZa8vejVwrDhEEO0hpc3wcUSpC9Ik3T45VJrwpsCXHK/RC56SfiSn6/7Z6c0KLx1ybPhDXovYneIWiGhML6PaaYM5tIkC7+hBB0xvy11tRAHVnlVjnfh132k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714555; c=relaxed/simple;
	bh=q6KG4SzbjjUNOFAPaFCztkOVr1JCI+IZQ7tSb7LBrNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEzelZ4IvvAI4WP5h7g8d4glftkVJBhHRQPenvO56U3GDDYox97EOZxKzjPGMvYl7MpflcaVlFQMhncLEA8YDwGZ8bQ5Ic7zZBSOYIiJRYshsditSsV2sRiOdh7ch0vNWX8ZCXSfTq4WZEtTGaGjueVJUN39PMmWXS92XLeTvgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcHeJ57f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4966CC3277B;
	Tue, 18 Jun 2024 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714555;
	bh=q6KG4SzbjjUNOFAPaFCztkOVr1JCI+IZQ7tSb7LBrNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JcHeJ57fRUpQN8nlKc/30QexrAy+B2Y31SFDLDwVddDz540Bcd8sHUlaluulvGJJC
	 7njN6axfJpg6X4BY4dKluS8sruYX43bgvrN9wmIQkl9A5yWw3ktwS232CIWAbiUhZx
	 XswhuXFqDMvXhY7xopN4RC6PFJ/M3T9wIu02SoMoBGMh+1QzKqKUI3bQ/8F9AjIYE3
	 ZDaaz4c7KYp9KUHCmnzTafHd869KziBs4n+aPCrfW+eT2s+8hlGxRazOEjZZsv3pQN
	 RjQu4fFh9juLS+oiAO1/76vVSKvcnPNIS5+aLi5k+iFJ1tZjI5x9YycufeywMxwSeh
	 h3BO6GCzX9YYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/13] ACPI: EC: Abort address space access upon error
Date: Tue, 18 Jun 2024 08:42:13 -0400
Message-ID: <20240618124231.3304308-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124231.3304308-1-sashal@kernel.org>
References: <20240618124231.3304308-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.219
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
index 487884420fb0d..60f49ee161479 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1316,10 +1316,13 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
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


