Return-Path: <linux-acpi+bounces-6449-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD1090AF36
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 15:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43C51F21291
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC1719DF53;
	Mon, 17 Jun 2024 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQNCPnqq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365B19DF4C;
	Mon, 17 Jun 2024 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630463; cv=none; b=axYkYykuS5JsrZHTrwUMGilcy5LRjkGkxHqfT9vcXugz9RzHFLfRjIA7Vj0veB0YkGKECpMHF6a4zI1WZ2sHMarPMklcxWO6YdwAfyzsLEoxiJyxDXMdx9p954p2vA07wj0raVXXjbJozsdXbKlzeS2aLKg6SyJz1UFldv65h7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630463; c=relaxed/simple;
	bh=EJEDBFxskGGeWGDfpNpIzfroP1j6OK7f85F+xWHuWGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQXMw+IncHjtJYZIzAlVuPWQGT5jEF4wd98rzVtPe/BSJ8wc0nFrsDLslJ67nd+3AjTSYDO0/oOzmQqHEzW3SYs6KvFw6/eFytCd/KLC5/9akMpVaK3W7InCnYqkPp/alzUCUA89HMsvvkxmKnJT6fJDv0PTAo5Q9nki59zgtms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQNCPnqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F05C4AF1C;
	Mon, 17 Jun 2024 13:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630463;
	bh=EJEDBFxskGGeWGDfpNpIzfroP1j6OK7f85F+xWHuWGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQNCPnqqPWDyh7LmL99kKFEowRFn7fhWeMjiXfdZHmbJnO3Fua0dOzjXJciFULbNE
	 C8nWXTChljNaS+f+SDsHWXFLxhkwCtqVIZQdAK56OnprEbYokMV0sdbQ2ydvz8L8fX
	 IJv05lGSfgksypAGCCxKr68H63x0u9U77ZVNDm2pthFxg3zpV5TyAZQDYliJY5WbTT
	 4XNgHrhKXAIcfjq1uSWcOLS66TLihncXIMT+xPiBkCdpGL2a7Kigu6wOJbpellY0Wb
	 TlXEsbAP0HSrXWGOVZAOa17BdslDB6LgghpWfzDR1i7U1TeuZr82b5pjUDun6PcZzf
	 UyMjSO3gHzAsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 09/44] ACPI: EC: Avoid returning AE_OK on errors in address space handler
Date: Mon, 17 Jun 2024 09:19:22 -0400
Message-ID: <20240617132046.2587008-9-sashal@kernel.org>
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

[ Upstream commit c4bd7f1d78340e63de4d073fd3dbe5391e2996e5 ]

If an error code other than EINVAL, ENODEV or ETIME is returned
by acpi_ec_read() / acpi_ec_write(), then AE_OK is incorrectly
returned by acpi_ec_space_handler().

Fix this by only returning AE_OK on success, and return AE_ERROR
otherwise.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 2896330146e29..06efc15f934a6 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1351,8 +1351,10 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 		return AE_NOT_FOUND;
 	case -ETIME:
 		return AE_TIME;
-	default:
+	case 0:
 		return AE_OK;
+	default:
+		return AE_ERROR;
 	}
 }
 
-- 
2.43.0


