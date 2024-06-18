Return-Path: <linux-acpi+bounces-6489-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBAC90CE9A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 15:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F62528193D
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C971B9AA2;
	Tue, 18 Jun 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C04ZsDS7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D091B583B;
	Tue, 18 Jun 2024 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714584; cv=none; b=ezEn88xbtMJnjZr6L131ZtbxioFrx7W73ZRuQ76yOF9V/qWGcZGQZ8hmbqIroutlcYLQz+HNeuaT2OIL8kalokiLwfpDoUM3EDmG8NV7gJCkt70O+pHaFgWROn1iNG7cD8mxH7w1LwiJgcDjD98VQfelgtmhlfsHAgg3JQevOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714584; c=relaxed/simple;
	bh=AH6BarYo+R0ZVI8y1E1ZnzrrDCD/Azq/NaY4lEndFgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUCSZshxvgyPKmqGABtbv6B0oGAiDjvZDz2MJ0AYrvvAv7SCWAo61aQJBhtDOtnxopDOEL2FiOVy0QlDnUhj01FaUgLOGcqebhZQ8QKVEoNywtOUovvJgc7uYE/TgUto1eI+GrU/cVQwwBfgTvGS+5Q7JL2YsD/Ziv+uukLjjto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C04ZsDS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD24C32786;
	Tue, 18 Jun 2024 12:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714583;
	bh=AH6BarYo+R0ZVI8y1E1ZnzrrDCD/Azq/NaY4lEndFgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C04ZsDS7EfCaFyTQGQehOQJWNu6gbTLwsoSRequ8oixRI0ZxZDwTkjHs0zOCKkKtG
	 UWs5LzgYuVmRjSJA5xU07B0WozhFB3I1LGtPyEhhwBLUbLedUfgh2HynEGLZmPpvJr
	 MaRpiu8Ud45d+uPeZH6P9qhRdMLonD5ZFfDmfDGMadQo+7Xthp/lTUzh/CDPjIDphg
	 GHI5guo9/ZJp+msXVI+Ek9wnGlCzskvnHqv9RvPCWaZ8joDdwYfeectF8TDCZRhw+k
	 BvGwUK8aOidkMlYGmQxhj8WNohQSLyVR28OAlLIosPTbTNWNvLWuzHboHFdftSWqRr
	 L762sZun7R0ww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/9] ACPI: EC: Abort address space access upon error
Date: Tue, 18 Jun 2024 08:42:50 -0400
Message-ID: <20240618124300.3304600-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124300.3304600-1-sashal@kernel.org>
References: <20240618124300.3304600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.278
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
index c7baccd47b89f..43a8941b6743d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1310,10 +1310,13 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
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


