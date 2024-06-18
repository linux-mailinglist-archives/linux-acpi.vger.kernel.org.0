Return-Path: <linux-acpi+bounces-6482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAB690CCAC
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 14:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29096B295C2
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6408816CD2C;
	Tue, 18 Jun 2024 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0i5WjGX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C22216CD27;
	Tue, 18 Jun 2024 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714328; cv=none; b=b8k9wsVTagXJMziEdKthatkHodDm1q7fa+exMOVvq6KTJ+B9hJY/ACnNxuQx4FD5Cz8hz4LMcKsoXkRdnhHcBdfcONnkAL4EHEi7VJr+da5V+VwmRrnGDABNPYgr5ANiTXtJcTLkelEX/gDPPu4RkfOo9FUqqK9+Mr/GZf/mO3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714328; c=relaxed/simple;
	bh=y+dPeb95Eq/YFHLynpEWrN856VxIZUimhAwPSc/Rdh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N41JcjVc3qy6SHkqRRRv2819S0InNHqiYLCNrCLbsYtRiQGhpzmCyJz5uuIKLze06+tl+EzKstt6k6lRof0di+BebEzssVkJpqZ/khmeV0L5xYXmV5Z6tNDAcRZTfw3KaAsT7G8qtpVbskpLrA815jXOP+L1QpfnxVpW1oriZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0i5WjGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48591C4AF1D;
	Tue, 18 Jun 2024 12:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714328;
	bh=y+dPeb95Eq/YFHLynpEWrN856VxIZUimhAwPSc/Rdh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0i5WjGXYTPmn9TdVnf715G9hbdUFvfe03pZTUd0f7fFxsSuOpjw+UZ1rPqNwnwPY
	 JHXqc1wI36bkZawHr0znZAWUThyyMqamdbuC9h1Lur0Y3kHTe5sDwCLAYv6H7MgmKU
	 b/uQJoIqGo/Vtb8ZyZtt/iGM8ULVMfe4WIHVIAaDg44JDDpO9Qjx7HIA2luuDsXFgk
	 4RlReyN78ksBxSxKglMAmSoU8pW8a0lEF6VD0JZ4wcpe0660NQvaJ7d2hc+CZBX7NX
	 c7Q2y7otaCCYbIfPB0qS39KhEc75P8ahDw+BXmN82yT5VkF/dT+ZvGS6xaUpN97yqd
	 HwZkFnJPHPPcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/35] ACPI: EC: Avoid returning AE_OK on errors in address space handler
Date: Tue, 18 Jun 2024 08:37:29 -0400
Message-ID: <20240618123831.3302346-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
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
index 2e907800417db..75fa23962d1d3 100644
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


