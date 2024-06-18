Return-Path: <linux-acpi+bounces-6484-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D336790CCEA
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 15:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FFB28122E
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEEC1A01D2;
	Tue, 18 Jun 2024 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRiYGcq/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D8D1A01BF;
	Tue, 18 Jun 2024 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714434; cv=none; b=TTmHAP0mSDlEYgB1xFJeBgLDQLoABx+4/gxD9yHBAqZ7OlZ5RoZDq3IBZPPoramoB3Wa3F05rwdHoL6TyHVPigIW2agX+JQZT/JXfmXfbEiDVtuaXwV3Ko9dBmPtl99TzfPjw0ic6PYbeT+Kl0ReZjauMt9fCAAoGgjmqz1x1Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714434; c=relaxed/simple;
	bh=IfoV7rkWQ5pHnsNC+WU1ryPWD5tQEUJ+bjVLweowzzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsNuKUhaAtOy5WVhctkqjq9nZ+zEHb0iaftMoeKnHpnLvrWaIpjmvI4M81YYLb4fKkf7FyH2HrgW0Vu0V0JQeMqsBpR8AoI3M+G9uzHqpTXKpgQzutzTlgJdvemS1coVkY7vchF8ZUwDLRtwMi9lR4BiYx+oTxGmPq8uTy865Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRiYGcq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C18CC4AF1D;
	Tue, 18 Jun 2024 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714434;
	bh=IfoV7rkWQ5pHnsNC+WU1ryPWD5tQEUJ+bjVLweowzzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRiYGcq/WLUXZToSwbVSE3eK0dvUliVk6TZvbUsZ/GxtKSCHxclcb3vzQQ64S1ok+
	 BATcNMEAt/ova27C3eJC/fhkbwGThtR4zy8dzHA+MRMeLqsNlSZbNeRdeL+97JCy1Z
	 HRisIAngkdYGMr814OGUrzsf6lTiUd41PnfR8E7Z5ESsuA/tTcnk3tvdYe6B2R8gE5
	 gTfZ7ChBAkzFo244cu/EJaiGENwnTS8Iuo2fGgC4GQdz7LmQo7Z0m52hHlkxNmHcbG
	 9YtuZoGoe3kf7ovF46V+l3GYChhMTcCcveW51xeLt20xTQCAanh9ZYcqsFktPJLNxC
	 AweuNtg1zj/nQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/29] ACPI: EC: Avoid returning AE_OK on errors in address space handler
Date: Tue, 18 Jun 2024 08:39:35 -0400
Message-ID: <20240618124018.3303162-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124018.3303162-1-sashal@kernel.org>
References: <20240618124018.3303162-1-sashal@kernel.org>
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


