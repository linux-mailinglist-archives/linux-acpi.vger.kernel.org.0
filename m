Return-Path: <linux-acpi+bounces-6486-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2646390CD3C
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 15:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5171C20A8F
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 13:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CFE1AC76D;
	Tue, 18 Jun 2024 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR08O4wz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575A1AC767;
	Tue, 18 Jun 2024 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714509; cv=none; b=e3rWhHaORDgIGFTfPXnrGCA89wEmNZ4rueDkkBxV1MfdsYclTcZg2unGDWVZYeBKfbhRJRHkIBLMt5yRWl4tsw5b+0KqDWn51EOUmSr/6774SXAR+fBwQQir0a+eUYBuztFw+Ekp9kC289q3ct+Sc2s5qY961pW6fcQK2xga4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714509; c=relaxed/simple;
	bh=SEXJjtvHeqIAj7o23X5mvtuW3OuzVM2avBfkkMf8IgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqXU+G5aAGIkE+2Fc8eThgoEz9iGfpmMOyA2RCY++tB4aqR4UR1MU6mXpoRfIc8Z1Jn7nkmhqNhjks5Oxch+Ll2I3eS+UzIWKN3dRUkFeAIdY9YZhzk9lzyx3yd1fOc7ZJG7WwLVzlBNRC3DBJpIV0hc4MIFqeAlFpxh4As6vYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR08O4wz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46189C32786;
	Tue, 18 Jun 2024 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714509;
	bh=SEXJjtvHeqIAj7o23X5mvtuW3OuzVM2avBfkkMf8IgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IR08O4wzeD3LLS/SaqRBho3u14GXUHRCUUwV+uZBF1E0efEXCQbloSBXlQwtdvMCF
	 Cvy09dUsjBc3+aYVeO7Q8e8COYWEXBsBAAQKXRAGxIO+KKxSb0urJrk+ZJSwgkWalm
	 w57aJ6Kq9hm1oPU8nA6WE47boI24q8g1nl+YUO3X8b3eNlHyqVP320lALnVxq8jo/P
	 ukhCeeaku4mg0UefKR7TfLa8rW9PNLQSBcMq3nz5Bi33sRKl9pj8jrKLGlVhAAKswc
	 fUTBZzucFFK7KGCCUgDhkXCiPZ7pMAD8Sl65KhBDjjKTMJiZ4JseNCkY5HJMIzpbjk
	 rhPG1ECTqFbhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/21] ACPI: EC: Avoid returning AE_OK on errors in address space handler
Date: Tue, 18 Jun 2024 08:41:05 -0400
Message-ID: <20240618124139.3303801-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124139.3303801-1-sashal@kernel.org>
References: <20240618124139.3303801-1-sashal@kernel.org>
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


