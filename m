Return-Path: <linux-acpi+bounces-6453-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23C490B075
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 15:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01AA2B358E2
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E1D1BD00E;
	Mon, 17 Jun 2024 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXUsGg/y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9351BD005;
	Mon, 17 Jun 2024 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630605; cv=none; b=D35wEAyKqwyuXy2MF/HxeEa7SIsATRSBF6C6nYrjDOo9pnrImuOap5BKJAW0W1sIyKARpzlZPAZgjuRgPf9ljg2nG7Rr72JOMrBpkRhv6OLluFaFLVaYq08qm96+EE4j6QTt31bTgPstBzkJmmXfnsvK4ZfqlRzclUIhXLZRUbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630605; c=relaxed/simple;
	bh=y+dPeb95Eq/YFHLynpEWrN856VxIZUimhAwPSc/Rdh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhG0Fy4BgtkkodZ4zPSZ+iaj4ixfrXYOpgewbZj7783pew9XO1c7xUflFccvhh4Ca+H/w6dCVkIk+YRZ/sv+d4ScgFIyPZtJPWclYlCmRiVbFGyv3Jfu/kpKbzj9TtC6AckPj4eHg2uwIm4eKkhtkaWZpSHcNqgVbAWvcB+kHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXUsGg/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DB9C4AF1D;
	Mon, 17 Jun 2024 13:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630605;
	bh=y+dPeb95Eq/YFHLynpEWrN856VxIZUimhAwPSc/Rdh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXUsGg/ynYCh4PFd4pjy5xMJ0HjlnQUUu1hS4NUqklpI+d/WawJwYtmEhbSHvh4sB
	 382tzdFNMyfHV0pJg4cjhNPysfTm4w+oOvDzLwUFya48BXa/bEZsEnWYr97zcx4BLU
	 gvA2u7tPrX/c3pDysujBAJ4rCCI+qRTbOXEI7iMFWuLYjZd8CD63MDkMctTBeRM2Ot
	 Z2x1u1ux/TIwPW5AySt/XoWtHZznuegnh6tgavUxuP0odgwF6N2HW6alIVJm2HpWvd
	 OWznMUw2gtUOM5TGfgKQHSfOawUmoMfcavDFTVNOGBTb+lxrxffPmKUcII3dA5UAXz
	 /oHbW5r4bVF7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/35] ACPI: EC: Avoid returning AE_OK on errors in address space handler
Date: Mon, 17 Jun 2024 09:22:07 -0400
Message-ID: <20240617132309.2588101-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132309.2588101-1-sashal@kernel.org>
References: <20240617132309.2588101-1-sashal@kernel.org>
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


