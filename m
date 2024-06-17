Return-Path: <linux-acpi+bounces-6456-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3E890B0D8
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 16:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B411C216AE
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2AF18E748;
	Mon, 17 Jun 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3h6orij"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52B018E740;
	Mon, 17 Jun 2024 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630786; cv=none; b=hUUiwRBwBNotmsX/fH1NTghhzM/FXZuOoFKqKq8BeU55WwHpvFMwexql1PsQ18jpjWKkCplsvC7qBkyaLOWrZzJ/LW2sCGnUqNY8Pn6RSTXamOHNmU/3kA0KthEDup2sBqXVNJ5EX8Oa5jY15JjnNcOr6Qr1LRN/HPnNifth32M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630786; c=relaxed/simple;
	bh=YIOi+92waFQ1ce33g6Wg62+s1ohyWKkoSuGKxK+hrF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHiv6XCoHHMM03BDeTsp/ly4+3uYxaJXmrZhX4VoS5IDgrh4z4NpyyRdYmRhWcAfHsPlKfKDrRZYzirWxF69Ft6nzBGb2oWCqkySZH+dG28MdCUykNdHy2NKhWr8pEgnzdcr4FrTQyh+BvXKxrwpX/lmkdVUvfKzVuuxzWEbpyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3h6orij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000EBC2BD10;
	Mon, 17 Jun 2024 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630785;
	bh=YIOi+92waFQ1ce33g6Wg62+s1ohyWKkoSuGKxK+hrF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3h6orij+vaHXqUMnZUkURV8w5SCUl6lGXjn+2V5YTDtDIL2TdY0dGk9Uf6sxNXUa
	 /Id3rYM/fGqK8SCUB3Q+Q4FZKvoIv8D8rNATFtnhgOm4JwsX7z6Ed7nbNaDM3yozW4
	 7bB9o97XritNds5ixyu+e9KlcVDKn7m2vu1aa4U+ZZeddwWTPIjhndsY6VjIoWlgmt
	 X/Gvc6Ct9NdUknwaZ7PRvNFDkw/J1JoJLETbaMKF1mssD06jlUf4eRfHAB7HU5WvCU
	 ehqmVKiez254RkVgNFqB30jInb9K8nYahYfBC+nzslNg01qFHp8ZbYtX6Cpa137cb2
	 NLC8L3aThgUAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/21] ACPI: EC: Abort address space access upon error
Date: Mon, 17 Jun 2024 09:25:42 -0400
Message-ID: <20240617132617.2589631-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132617.2589631-1-sashal@kernel.org>
References: <20240617132617.2589631-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
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
index 472418a0e0cab..1896ec78e88c7 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1303,10 +1303,13 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
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


