Return-Path: <linux-acpi+bounces-6461-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4432D90B155
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 16:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3B81F25AFF
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A2B19DF7B;
	Mon, 17 Jun 2024 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ5mIork"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03319DF72;
	Mon, 17 Jun 2024 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630864; cv=none; b=KL4JEGUZeDeWRLybwsRsIG2nHB8/SJLD0Nk/4Gvuiy9p81PMUxNxu9vZ9DNc6lx1I3F7l+5mmhfEhVpbS2YOFRYeLsQbK+olQ/BRDaHxKCNLFa+VKmEp5JcO9aj105UJcDeZpto1Wfckb3pwgSZd0l1BsDaeRrBVOW6248lcmdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630864; c=relaxed/simple;
	bh=W3cbnYQ/eEHVdfJULh66GP6lhxsfzrBzxB40bktSZbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doPOHCkkC9MJH5IA7cVa4aQSu/0c6Y+uZv2BEhegbR+WyaXUW1HL+8DCr48CiR4zhRjvWO7Td9MmbaSJFkNHea/lX1p8/SPmA+p1C6mp6hnpEHxJJD0AOA+BIO3EPbeLSbU0FlxgzQ2VOQz8wFPZkfO6ElOcvTxgL/T6s+42CiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ5mIork; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C2FC2BD10;
	Mon, 17 Jun 2024 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630864;
	bh=W3cbnYQ/eEHVdfJULh66GP6lhxsfzrBzxB40bktSZbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJ5mIorkR7G7T3rjUIid0dQL1Cx4mIXXwgopYNwt/YzgKQwbeltLQUuWw9W4m2UZ5
	 hB1Lkl+jMMzZZ4ZNF3ntugeKR6YhZrW/p6X0Rn0LvwSHDcRwInliI4YqswMeSGhnYc
	 rjn6zeBusT2kQlzXT+SugHcU1Q7vSp5HOsxCa6gqMWZmJR4VeVKlj9CHnZ0iGdKw2W
	 eBqFkKuICOarGRJMiZqmSilLMApToopV4LB+Z+rSO9BKvSVvjuSH3NdRMN9tj0HgaN
	 1rT/ZZfsE0ERfXrQ+FVOM/yK0SKNVMGG6FYaT54Fy8gIUUHh4qXUuMiRddheOguoBW
	 E6gAigIe3D4hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/9] ACPI: EC: Avoid returning AE_OK on errors in address space handler
Date: Mon, 17 Jun 2024 09:27:30 -0400
Message-ID: <20240617132739.2590390-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132739.2590390-1-sashal@kernel.org>
References: <20240617132739.2590390-1-sashal@kernel.org>
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
index 43a8941b6743d..142578451e381 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1328,8 +1328,10 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
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


