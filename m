Return-Path: <linux-acpi+bounces-6455-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A134E90B079
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 15:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10C528C391
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37D416B390;
	Mon, 17 Jun 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBgc2Ozx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8770916B38A;
	Mon, 17 Jun 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630712; cv=none; b=rM2452/ol58r7tNBKWDDM9H9UpR2zr1+6ztz+Cog2TkvgWnfx8wI4geBAW/YSKTvU0Fq1tNl86USZYATs1A6LqhPzW/B6qS1nrFPdBQ7qSWp6UaAUr6JtD+EkwjHy9f9AHX4e/n0NMhEXJGgb4Lmoakxu8ca56/Mk2K5Ml69akM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630712; c=relaxed/simple;
	bh=IfoV7rkWQ5pHnsNC+WU1ryPWD5tQEUJ+bjVLweowzzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0zTMwOLB8EQF9j3+kgOnYSfmM7c9HdcfsLmVcVnPj2NwqUDF86fVps/agfv5VB7KJ9k11k9/+uTvnTQM9CKFBJFzYMLWgEIECywFQmeXiSwl56QarbwBxJ6OAbr0Exgyq4i605WflGTfBDkDvVwoyqQjwZD2GNF/cIfbi3G46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBgc2Ozx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907CAC2BD10;
	Mon, 17 Jun 2024 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630712;
	bh=IfoV7rkWQ5pHnsNC+WU1ryPWD5tQEUJ+bjVLweowzzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EBgc2Ozx0pQsLtLYqS8Z9xDTE5OL5Ktv6kVBWvdyLovM9ATsbtMG5u14kg6AKZnL/
	 +raajY18rTsgx5QrHtTz3gUDUbCaVbFX6stVhr9neYmH5b2lPHTPu+pKmOmXihB7dm
	 4azwwZfzzFGR27B3XYdtm4Jy4WQ0WIUeqjwXnpWKx9rAhBUhsqpzvnd0ylKvCQIdu1
	 2rE9GjLrQiVdJ+3Rm2obNh61VOH3JVDDHyyAKayNxjKVeRJziGv/xt90uWKOgnTJ32
	 Tc7BgYweu1QRYzT10hV90cwdPHVAZH58dplqa2pWxPugVLRnfntrzXemW4zcMfxyzx
	 YPcnOOZXZK+nA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/29] ACPI: EC: Avoid returning AE_OK on errors in address space handler
Date: Mon, 17 Jun 2024 09:24:13 -0400
Message-ID: <20240617132456.2588952-9-sashal@kernel.org>
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
index fc3dc83bb8707..7589908b358e3 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1332,8 +1332,10 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
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


