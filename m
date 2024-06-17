Return-Path: <linux-acpi+bounces-6463-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52090B180
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 16:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BFD1C218A2
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 14:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21951BD91F;
	Mon, 17 Jun 2024 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckHG7j9a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A691BD919;
	Mon, 17 Jun 2024 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630882; cv=none; b=dWTy2tBCujn39gUnWyHxYJc3LhOqwUgK9Oi+oB6nc5IXxHdn2BbVoRtgZnO6cZ4NKxn04C0MYmQrGfJBheXAwnkPk8AFoyplanjFsW97H9GijgHBfDq0nILjxtA2YpCUPRPHG3emAFQSFrNpBqsi/Hf9Z9qbbuBjLC+BSnT41g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630882; c=relaxed/simple;
	bh=aZuB6AepPPnXSjNK8WfaWoiTw7MpOVW2gI63k/mnaew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhUUwP+wyu+w9M6o0DkeO5gOsyGWuN6/+6DUZ7di5+G5Dt5jcEAIpxH2UfyQBfx7bZlWsAE246zVPxmEHhAA1dKoy3O+OpxNTSg2XmcXg6GOSn7Sy8R740oFxwTPsXzxgqIbh2jT7zKYv1psV8zXh5sL6q5tdHxZZfxWp4A07P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckHG7j9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1A5C2BD10;
	Mon, 17 Jun 2024 13:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630882;
	bh=aZuB6AepPPnXSjNK8WfaWoiTw7MpOVW2gI63k/mnaew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckHG7j9aXWCKO6CjSFG5K5s2O0hRjwINmcJAvpp3HFGfHVoZVhbiLMDw+2Hh1Ddf3
	 PVkapAZO88YyvK29Sr71Iy/ciFbbrUeFpoymlWWBX2+tfllxp/Q+4CYVjD3zlX3j+G
	 3XH1PYUm3f8iL8qv9wHOVz1CM1En2tu6cSGrIptDa+EzAnPj85RabNBLO1zjdf+eD3
	 g+MYEJOpadwN+R2GWcPqE0GR7Wt+sMvp4NvTkMkCuux6OUUnrwiMD/DcQVZLADtInc
	 a4Y3iBpE55i5rxXX4FX1wFB1tYZA72kq6ZbnzbE4PnXEoZIuGIz3iPFfZEJcQylQef
	 qnC7OVrqPTZtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/9] ACPI: EC: Avoid returning AE_OK on errors in address space handler
Date: Mon, 17 Jun 2024 09:27:48 -0400
Message-ID: <20240617132757.2590643-3-sashal@kernel.org>
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


