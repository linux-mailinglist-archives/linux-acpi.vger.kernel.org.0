Return-Path: <linux-acpi+bounces-6457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3934E90B0DB
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 16:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ADFF1C2111B
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDDB18E76F;
	Mon, 17 Jun 2024 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mohA9UL9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406118E768;
	Mon, 17 Jun 2024 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630787; cv=none; b=sxNiWSCebFZcBZIjFN2lNrk3bmGrSRMn39AuSB5jqsBIZ6sydBCCRLcEyHswUp4sMNStC8LPdsaKx8WBOCJNbdSd5ZbherBB3M2J4G5/J2z8iy21ZMQR5vcRuuFi8KrtoJVEv8Wh1RhsuPiePBNx63JmMoLozmmODg5jz5STKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630787; c=relaxed/simple;
	bh=SEXJjtvHeqIAj7o23X5mvtuW3OuzVM2avBfkkMf8IgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlMM7U01qrGDSpx8LcSe6eT72aaY6euxWP973MXT3/jeSpr9q8MZ40hcUoZff/doofb3lir2eawl2J5fUoGyCgmh/rPaC7IzJJ1pXQPIWQRFNqQaSYCA5sVMTkoIVM7EHt6A/TDVzTnWvWhM6QJ/UCel92yi0kpbiyT6ZWDA9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mohA9UL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45ED4C2BD10;
	Mon, 17 Jun 2024 13:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630787;
	bh=SEXJjtvHeqIAj7o23X5mvtuW3OuzVM2avBfkkMf8IgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mohA9UL9BX7AQFYeFkqvrHrM/aKe3x50JY/USE7PPXgUJAQIR6Q/9t91B8m739dI1
	 qla9sZ+xY1Qhdi5vw8JQbhLDAu7mrXAJuR2b7hn5+ek1ufH/+joCoKJJv3t49rgKPl
	 riMbTumHK7PDXLD94Uy1erKANQ1pfJ8Abu5hW1uFQFQC3NAjbBNZ6s+Df3kTYmH5rD
	 yEpezrWuF4DsxCxn4RcV5h+3fltQRPrdh4oTMgqqpFHqj8XZeqR9+10noGA0DQjtRI
	 h5TqVFbl0faByw8yZmUFDaPBDrXu2WXAwEhbdTtebhO+5UuOeTZtcZrkNHNyJDW866
	 g28CWXgcl3xzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/21] ACPI: EC: Avoid returning AE_OK on errors in address space handler
Date: Mon, 17 Jun 2024 09:25:43 -0400
Message-ID: <20240617132617.2589631-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132617.2589631-1-sashal@kernel.org>
References: <20240617132617.2589631-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
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
index 1896ec78e88c7..59e617ab12a51 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1321,8 +1321,10 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
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


