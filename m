Return-Path: <linux-acpi+bounces-20087-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2BFD0699F
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 01:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 038A1300983F
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 00:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A170157487;
	Fri,  9 Jan 2026 00:16:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BD22301;
	Fri,  9 Jan 2026 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767917813; cv=none; b=TiHorwv06oD7zDTKjiSJbv3dWmWwTSCVpDKbfFIx9gcYDITX7cW8hB8vKvZReBPlKzLpSeasu4UlxhSSOv8QF9aWyN+s05vNLXOXpNB5FYrsJua82/PUcfn9ZN8UfO6ZiQvpQP9sKmY/063d+P+ysD1ku7r/c6NcfuLWwiTdgVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767917813; c=relaxed/simple;
	bh=IH0q0n/GvKNVxnbDXyp6n3ltVCU4JHOotW9FtVPmzdY=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=jxuGbYAAb2wsIK0UWYDB3nZGK1dRY5s4fW8EHsRtwqEVhVXmn1rQxfPjTFCneTCF/p9/rIyxH+bbZXUOyqxEpNa17RxksUBgynq4ywV+dFbK6d1sijyGDt/gtQLrjWSk7UOw121trKK5CNMgFayKuExqY9IURGvsnwpESkNYG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68b20.dsl.pool.telekom.hu [::ffff:81.182.139.32])
  (AUTH: PLAIN soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000008031E.00000000696048F1.00398F03; Fri, 09 Jan 2026 01:16:49 +0100
From: Gergo Koteles <soyer@irl.hu>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
  Len Brown <lenb@kernel.org>,
  "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH] ACPI: x86: s2idle: Remove dead code in lps0_device_attach()
Date: Fri,  9 Jan 2026 01:16:19 +0100
Message-ID: <20260109001619.37532-1-soyer@irl.hu>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

The rev_id is always 0 for AMD since commit
e32d546483a2 ("ACPI: x86: Drop quirk for HP Elitebook"),
so this condition will never be true.

Remove the dead code.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/acpi/x86/s2idle.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 6d4d06236f61..a095b6f4401b 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -459,9 +459,6 @@ static int lps0_device_attach(struct acpi_device *adev,
 			lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
 			acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
 					  ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
-		} else if (lps0_dsm_func_mask_microsoft > 0 && rev_id) {
-			lps0_dsm_func_mask_microsoft = -EINVAL;
-			acpi_handle_debug(adev->handle, "_DSM Using AMD method\n");
 		}
 	} else {
 		rev_id = 1;
-- 
2.52.0


