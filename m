Return-Path: <linux-acpi+bounces-6477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D2490CBFD
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 14:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8548BB2304F
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 12:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F41C148820;
	Tue, 18 Jun 2024 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7fmFGHO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7383813A877;
	Tue, 18 Jun 2024 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714187; cv=none; b=PFc7wKk3Gz6JOyu98B5TO6qJMBdj+jVVTrwUcHG0gugvVkq5WXxzgZkqahwsUswYfTq38vIemdtF4wyvUbL+IxP8jTBeMznF8hksh4zEr+1euDtOggxXA0s27840w/Agnly7Xqo+fP6VaRIptUB3eI3zkiw5t7WR1euniCOhKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714187; c=relaxed/simple;
	bh=3GxZABKnNxzCFT2y+l+8KtO4NBP4L+z+Tsc2aH64Q8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7RMG2rBENXlojvLY0R+gz2JM6UqFVsZgamdlWVcE6fcAbXJt8ItJLfmM5H1HIM/3uE0gOcbD4CNzJSaa9+CoMquRCQaLoAU3O61La4dE57WZmhAaERcXpP3XNUZ9VhsztxNK5SLBHexHhzR0ywB6AubpdqKYxC0E0dIzAon18A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7fmFGHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EE2C4AF1D;
	Tue, 18 Jun 2024 12:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714187;
	bh=3GxZABKnNxzCFT2y+l+8KtO4NBP4L+z+Tsc2aH64Q8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7fmFGHOVxRb75jO4nOQdgnM1B3cQzJd1rOs2DAskVn5KqCvwFUq9K0d3V06L/2M0
	 5NL7+CiMeW9Uze0fpqs5MpHZl4ZE7ZU/WXmjEDLRkJKjmDy6UrlLoT9jC67TVFGzOO
	 /nW8gU0WH7h/L9HMyjDy57a5EtzuE8wyzZVK5PWZmEaqfEJb6PmL/Mpxbyy3M4jCBL
	 WUsDoLxA4TWcGpKbfl94l6b3Gnl8+UvpDMAd40nbfXnLu6n/TGZB7wLhujFHlFZXhl
	 zLnzSa+UGgo1/hq6i87cenAiFYTg75T14C7sthBwKuqqT8an3pqOZANnKxXi4zXRK1
	 zazxc8ZwYuZmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 08/44] ACPI: EC: Abort address space access upon error
Date: Tue, 18 Jun 2024 08:34:49 -0400
Message-ID: <20240618123611.3301370-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
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


