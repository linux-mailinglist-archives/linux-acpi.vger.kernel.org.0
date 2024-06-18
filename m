Return-Path: <linux-acpi+bounces-6478-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E953F90CBDF
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 14:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43731281E73
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8A514A08F;
	Tue, 18 Jun 2024 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1ANigGg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B8145A1F;
	Tue, 18 Jun 2024 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714188; cv=none; b=Q2XhbuvLYI1bvRxsQZFR1i0IatvXiS6c6QP5mhthRgXRIztJQH+tbNohObnQHWo6fK4/vJI+pGdkS8QXnoIPSv5mHClZF0Mgk4dENbSx5xcQf5/2qDkCmZMHXLX4BnBpJ2mosg6bM2eDddvGFcREpcY6rc4CBZlxVmBjz8+T3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714188; c=relaxed/simple;
	bh=EJEDBFxskGGeWGDfpNpIzfroP1j6OK7f85F+xWHuWGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uS2/o4mpi9hKz0L72goxbQ/7pgYWlq5neBHT5SZ0fW1pxsEss+iEGOsrShAcI7gFro8cBFmiEhqXdfO1Fmqs7hncBDd79BBHX6ibqqcGe0m7qlnrEH+NLjRZjf5pw4bTapeM/Vdw+ROY2hPPrgkZW9nzJevakg2XNHc15HNk1jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1ANigGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FD7C32786;
	Tue, 18 Jun 2024 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714188;
	bh=EJEDBFxskGGeWGDfpNpIzfroP1j6OK7f85F+xWHuWGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z1ANigGgO8JSs6KQqRr+nsnFWa3Gwn0EBiajpG/MK7gMctLkSzi+1lu6PXey0xjbw
	 +3d/uTb2CD3u47/ogouIioDpJocCuJ7Czfchtn6Ri4z3qGZzD532BDxRR6WEgWdOfC
	 8KHACZ9/+cABpxcMJkFlRFGqN+g1l7H0HuUVyBJbmTqtOwUziQokw3CKuOOKv2aCw4
	 UMqzdKtOikikCw5OIt2+9JJZ334c5w+zgQdur1tjoAqezwDRrE0onJPdL3zJ7nHcV8
	 sn5hEfokx7/1p1knhQGWp/1ISzZZDbLQgxXSdoZk5EkHKCq2Xse5bM4Ix6V9RcG104
	 EdRaFB2Qy520g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 09/44] ACPI: EC: Avoid returning AE_OK on errors in address space handler
Date: Tue, 18 Jun 2024 08:34:50 -0400
Message-ID: <20240618123611.3301370-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
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


