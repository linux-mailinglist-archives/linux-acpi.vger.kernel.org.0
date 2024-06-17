Return-Path: <linux-acpi+bounces-6462-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D2790B179
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 16:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8AC1F25E00
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993251BD900;
	Mon, 17 Jun 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEXWjhtW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7CC1BD8FB;
	Mon, 17 Jun 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630881; cv=none; b=udL5t5re8JE3/VQvPLZD8IInAxQAzvIzGm68dMMNe5AVZwZWPc2f6wmcgR2SY9kJ6Dh93kaxBc1W2BFc4YzekMPMB4uLSfeDKE7uqjEGf7sz5wGqZHKLb4SZOoU8KuoX2T5B8k1pi3vt/4E2QsvcF0WeIPSiaPTbnaINgyMDPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630881; c=relaxed/simple;
	bh=KZVRndqYkMzG6a/CM2CqN0VHNjdjWAWfe08qLKW8XvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQFjYaVyo7Je47b95oKXDGqvqB/Z22PagbCbCE30TSutOJVrD3g1O1nqiocj9Gonz3NhIZUbRnYkglN545kbPCbiOs0dxrgn3ayCOGTMUt8KkUDBVy6yBEscbZPxnAPSBeL0elSs6L7s+3aW72B91BEERKSPCnxz705cWhJ81mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEXWjhtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7E8C4AF48;
	Mon, 17 Jun 2024 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630881;
	bh=KZVRndqYkMzG6a/CM2CqN0VHNjdjWAWfe08qLKW8XvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eEXWjhtWj8NqvwBp/uA4/nZEvB0RqDlu6GnD1TUNmyYrS0ezQEZz4niiVY4cqlf4f
	 PHTDUuqjagTZEefDwqrDHCD+bgbWLg4YogOBf6hMX0Z9rpXeHqOSc1xXrYnzXOx8cL
	 ch11XJXCzaMydP6NA/F3igUjlQ2uz3rw5gA3gn4MhzjcdLnV+r4gCofojqjtdhHom8
	 kLeYi5hMldfMNk+q6wDls3krCPHGgtN0R6GxZu90ujdk/Dt0rttVoDI6/cLpcy2ubJ
	 AIK9tpKKtKqH5sQnWbAOoh97Ikh/N2QgqlW05LoShG66uy3knQbfz6u3fXPVO0sXpZ
	 UKeiFUu3Xj1hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/9] ACPI: EC: Abort address space access upon error
Date: Mon, 17 Jun 2024 09:27:47 -0400
Message-ID: <20240617132757.2590643-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132757.2590643-1-sashal@kernel.org>
References: <20240617132757.2590643-1-sashal@kernel.org>
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


