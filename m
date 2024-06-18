Return-Path: <linux-acpi+bounces-6488-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA9690CD7B
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 15:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D941F20EE9
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30A71B1406;
	Tue, 18 Jun 2024 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw+w4942"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003D1B1401;
	Tue, 18 Jun 2024 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714556; cv=none; b=K59ErdRNt+FEktGF2mvE+3mhy5fAsZP9LhEkMCN+NMGDXCkYB3fY1gnDUwGlDsb8ulartb5eIdqEI9UMtWqVoemNt2b9Hxu0i5dA02xnb5V9S3LmTLH9tmqCLKdaftLhv9ZHo/K196+1XHXi44w8g4Ktr+HNmMoxfA0gMW73sVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714556; c=relaxed/simple;
	bh=r3DthCSQWYmsC0Ncq4NO+cfyYPpj5VwnQpOWO9uqglY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmYqk0XIsZcJJTtoN7+wEQWqO7PcmS1gSn4bQ4Fd0NACve4X101EoQynGcuFbtO91SkGXDTVgwRfgb2U9MUBPCbdBxurqFNahiIAYXpo7YRIu3tDV6sgPXCVSZq/gJbvzcjwfiQmW63JEG4Y5pBrmjMkpDUGmC+zDBXAQB6L5XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw+w4942; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85053C3277B;
	Tue, 18 Jun 2024 12:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714556;
	bh=r3DthCSQWYmsC0Ncq4NO+cfyYPpj5VwnQpOWO9uqglY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pw+w4942E8kUo/X7c2A4rqw03rRQA3oHZR1NSBGK5MO16CVkJTzR8re+gVMcSTJeu
	 PcyD0cDXKCHgV0i0g8KAQFAogGFefJessEsi3eRxSJCDE3diBeTdfYxLyhFD4/Wsbj
	 T6uJ31UZkSlym3sLXZQL1VH9GtQJrHYRFIyJMvm0i+WwvIjvD6bG9hIYMnWM1xzqhH
	 m5pxfw5um4NFriUOrHTqxR3o3fkr1XxM0DjPHRO90w9x8jvcpgo7a34JYmePMPHaCw
	 sN8Y92UgKZYdgURY0jusD7LqSK5H2MdTPcJBlkN11VaaIIRiRpPN5UCUaudGeoSahE
	 8OLOX/Q4hEV5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/13] ACPI: EC: Avoid returning AE_OK on errors in address space handler
Date: Tue, 18 Jun 2024 08:42:14 -0400
Message-ID: <20240618124231.3304308-3-sashal@kernel.org>
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
index 60f49ee161479..01a6400c32349 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1334,8 +1334,10 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
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


