Return-Path: <linux-acpi+bounces-6459-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD5790B36F
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 17:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E76FDB3B4A7
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129DE19F474;
	Mon, 17 Jun 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJwfK3z+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD419F46C;
	Mon, 17 Jun 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630836; cv=none; b=H+J1yNkCHxyfmUfPVt06FYNhynZMkA03JwxL16mgJeCsNaIAgkgM1C3CQrD2wdg7z/2bmPOt8R5rkqW/hQ/vIw5rOmLdqSeFpE0PtmKuYK26koXttJVg6zQyIPHRLXE7P7ZB34F1njQ1Ja9aKvAPSQIiNiWiAE1Utw/VOYPodSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630836; c=relaxed/simple;
	bh=r3DthCSQWYmsC0Ncq4NO+cfyYPpj5VwnQpOWO9uqglY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evNe1jh0U0oVuMNVs45eA6Yxz2JebJLr3TC6Mr2Txm/xP9B209AqbIdD64vMz3JpNTwxdrVjq+/j0KY13R240Ffpi8judP3MrnAq/910orz9jMSdmQR/JvHOygLePYMySuuEQufwRi6XQ4kccC54ud6Dk0FBu29uNDjPwNl/VuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJwfK3z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DC7C4AF50;
	Mon, 17 Jun 2024 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630835;
	bh=r3DthCSQWYmsC0Ncq4NO+cfyYPpj5VwnQpOWO9uqglY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RJwfK3z+mKmSKYlFxGxIMQ0pYwWE1fVOMR4aS4AYQwO6fG0aga7EyYEmMXzWUg7rQ
	 ySL1pwgXEHSvu1OLTxGUgmZPv8GnB96l/8Hjj8Yu/VmjIjk8XF7WEMRmTM1WQZNvrZ
	 +/v7VyQt0a8DwFvSyKNzbAzC/fHA3R7YbEdQVdmOboR2tTV05D1Cg5hLyeN5M+szCf
	 e+0SdhWFeIWSBGqunV2UK6TiMrnjg/git41+DGKxJYSARfy3fXd4xEvigwyShyy3qM
	 7LKmrPe23n8+Z2umgarPGpLmEWpb/GvN9v73BB7lFW0/4kyVQsScdYFDAJQPJmEgUI
	 LRCnzFu01pUtg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/13] ACPI: EC: Avoid returning AE_OK on errors in address space handler
Date: Mon, 17 Jun 2024 09:26:52 -0400
Message-ID: <20240617132710.2590101-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132710.2590101-1-sashal@kernel.org>
References: <20240617132710.2590101-1-sashal@kernel.org>
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


