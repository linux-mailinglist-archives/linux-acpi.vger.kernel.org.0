Return-Path: <linux-acpi+bounces-6458-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E668990B125
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 16:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DED8287693
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798A419D087;
	Mon, 17 Jun 2024 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCNu1Zi3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA819D06E;
	Mon, 17 Jun 2024 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630834; cv=none; b=jju/hP8t58jI8TGXVPJPD/yHpJeYE0IDZRnHidtAR6c8JIL8kpZ9Yq1Ki9WzJJG1BBwxVTlEGfAIVXhibfmytDTxv4Ac8jABwaYCP1IZtq/faOHs4y8c5xtZRYfPCS08UlkazOKLPHbx+dL3klErMFTTSVKacpxUZeIHduNiXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630834; c=relaxed/simple;
	bh=q6KG4SzbjjUNOFAPaFCztkOVr1JCI+IZQ7tSb7LBrNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBJLfynQpBqGkvD+UIBUKuNoR+nlZw+5mEXtcbZr7uMGuZcGonMZcIg90demUNbMNjZr25+PcW8TFtlhmfLvuwb1SkodXhCSzz5yFa8b1gXc6HrU9VsdMcKxdaOx+2nVpQBLYbZwvV22QwPK70aNBOjLCKMIn3gq0GfmrLLSqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCNu1Zi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0FCC4AF1D;
	Mon, 17 Jun 2024 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630834;
	bh=q6KG4SzbjjUNOFAPaFCztkOVr1JCI+IZQ7tSb7LBrNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCNu1Zi3D6rUF9QZgrThmoPk1XYo7dB+aOYOsijhGaai9hs7kH29jlB1ZKRJc/Jhg
	 4DOOxMOaCkEMEA5O8woK30F+dkvHBbEsXXu9XYK26+dqMYoj6Mq2ybWYNgrHXfaitT
	 btY3HTscw44hzZiEzpAN9xVTQaL1lNkas1G79AJi5rE/wBm+1uGPB2wNYzWiHOnmaL
	 dJAhMrCW8Dy48nmMbghnIIXckkKS+cpqYeRdSM98TFVK6cRQWDctSnvOT4B12+q8z1
	 YRG6M+GRwrvgouTqSdaBIqevzmcUQTkktKv1TYDsHjQjz0OdQUhEMg2IZf/krKsUra
	 tLYq8s4GDOHdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/13] ACPI: EC: Abort address space access upon error
Date: Mon, 17 Jun 2024 09:26:51 -0400
Message-ID: <20240617132710.2590101-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132710.2590101-1-sashal@kernel.org>
References: <20240617132710.2590101-1-sashal@kernel.org>
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


