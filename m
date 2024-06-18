Return-Path: <linux-acpi+bounces-6492-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4A590CEDC
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 15:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3BB280169
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1367D1BD023;
	Tue, 18 Jun 2024 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANzG1Kup"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09641BD018;
	Tue, 18 Jun 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714604; cv=none; b=cRsB1Jxv6KdWN+sOEjxSy1SL6tyxZO+28Xh9F85pWNrgtcqMz2zetdApsCzaiceoHPKqID3yHjrbsrvaFUFd+yRW56VvI81v7evivKM0VN+HMkudnIHtAsZqXn3GyvrCemGAaNYcerxLITs6SVYLGp2k3oHKPZcTbdCjKy+CI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714604; c=relaxed/simple;
	bh=aZuB6AepPPnXSjNK8WfaWoiTw7MpOVW2gI63k/mnaew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7UOM8odTLfyfuvrhn5LnaY7kf33GXDWulGxBDCbnsIsG68EVdwoAwWxQCOHy1tr/LaRigortfMAZznEgOhkH6QnkbWuVEgzd59vHaZgaJ26aTrBMDV7gbt2ee+ZfqohSG0MFU4eilSzGgpZ0mQg6MVnZj2Nl1Nr+ToBHvzozgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANzG1Kup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D10C32786;
	Tue, 18 Jun 2024 12:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714603;
	bh=aZuB6AepPPnXSjNK8WfaWoiTw7MpOVW2gI63k/mnaew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ANzG1Kup6N0IDl11j278g3kZdDUJp/Z1zUIAkqOOFrk1aUUo7HHlsSENrMZRozokB
	 rr35g6vhjtZVubhphidISPnM9sKsVGcZwBqAYU1LTQV5eZBkE10Mt93aZVO3e+TPA7
	 skZnDK16Q9Pt36XwW6jWqpxLAURAfavgKPuS7OqlHyBZaTgAjw2o+fH2zTd1nmREtf
	 h4mZentgPRBaieQY1YjPYLqH+FnDO2aA1hy1BUzI5r73llmeNUAeLP54j1apy9V3mk
	 79ckBNdhGDp+QbJcvMABNnEOSpyc12ZiPFvKYuPunjmju6SXjqWt7gKiGbLjCiA/Fp
	 J4+jxZZ7YT/qQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/9] ACPI: EC: Avoid returning AE_OK on errors in address space handler
Date: Tue, 18 Jun 2024 08:43:09 -0400
Message-ID: <20240618124318.3304798-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124318.3304798-1-sashal@kernel.org>
References: <20240618124318.3304798-1-sashal@kernel.org>
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
index 78f8b8b5a8099..7db62dec2ee53 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1348,8 +1348,10 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
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


