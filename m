Return-Path: <linux-acpi+bounces-6454-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F69A90B11F
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 16:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579FEB366DB
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21BC1684BC;
	Mon, 17 Jun 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2oIaa7G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B6B1684B5;
	Mon, 17 Jun 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630711; cv=none; b=naQEkRlcgq50cKiqxVQFDZmHiwORsUnG9cxvoBcdxUS5Da5ldElBZHfC9KiJeZWt/+i5e5U1WbEq4ZBtWFj4k2nldGsFDaxy/TJv3q3AgEv5IcOTJn65sIHs6OA3aKfe4vwf00bgo75itIpkuMhe1nkgGk6F0eugS+bNXUL9smI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630711; c=relaxed/simple;
	bh=nN21iP/qqfxyiAcks/jH3Q+FVdKoWkOs6ojS1nTvEeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEVFMbwC/G5t5p851vZzKYDPlrdtDuyUkcYeLFGu5KDBpXw/VDyUh5AxneIHcmyzfBMZRy3OWWpOeYQ93zfdMD5YbIdTfhr3L3pYwbXJdL6COZWo/IwVJ+ZqAuCV3k4YmFRYKdNbA85Py8jgC/jeebJXUkebsog9CYlaBxOalT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2oIaa7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435E3C4AF50;
	Mon, 17 Jun 2024 13:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630711;
	bh=nN21iP/qqfxyiAcks/jH3Q+FVdKoWkOs6ojS1nTvEeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2oIaa7GvBPC7qJ4iCJ3TJgfHASYtNjPb0nxjkos97gs7CwiMHCRE2nY8HynBtSnW
	 zseS8FriVBFRUOHzreJo/LlQfAQyRWN3gMf+euAKcSW3SbA/L32w5/wIoQbY8aDVx/
	 h+Q3rcoGzr7U64UjV7u3/45cOn4sXNJaYB0G+sPz72T+pbn6MCOuy+raORTfu+ERip
	 DzI8Q37CSp6fjl2xV6XvzFFtHB3LF4dlSgJeM2F/GCNI+Klg4bOKn+vjtHRZS/D8lT
	 QA6ChiDMKb+ZrzHm1SN/8LEm18M6QnYzBs63HCnJWeM2KKj8/Z4TX1acY+rWIhDl++
	 L85aiQ8z+yvWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/29] ACPI: EC: Abort address space access upon error
Date: Mon, 17 Jun 2024 09:24:12 -0400
Message-ID: <20240617132456.2588952-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132456.2588952-1-sashal@kernel.org>
References: <20240617132456.2588952-1-sashal@kernel.org>
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


