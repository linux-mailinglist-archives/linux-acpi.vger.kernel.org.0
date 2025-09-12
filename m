Return-Path: <linux-acpi+bounces-16773-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A4BB55765
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D057AA1459
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25342340DB8;
	Fri, 12 Sep 2025 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMb5K7WF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14F333A004;
	Fri, 12 Sep 2025 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707607; cv=none; b=ptOn0KUXktYMFdBHqWqkVNjHYKuIEGddYmjmBYddMlLal88d387yEqIhf1q2mgUJ19u60gB1PCdfXSTP/Iz7RpBqoWpuA6cYdstAvwzXMqlpLycm9gkHaDiOQ1H9fd5khgrSPmjzX6VNHmBix7yOLtTLW2ZTPkhXr7APWeMu8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707607; c=relaxed/simple;
	bh=AJICmF2BscnjE30r9RzzJZIM6ohQdQgFfSYSRpLPeDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTgj/fyZHLIrCBnp6F5A6SEQs6fc8ayw3NCUEx8BSYkelbpnR0jnvtsM1EUIIImXi/D99yhqovfrCy0GMHeuXRZiEVUG7jm3Es5LC1/cSZhMskc9TF00/DB8tPXtIhWMVkn2dzC3cdhHR9qrUNBhusny14C+AFSKABQMhMhZhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMb5K7WF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B785C4CEF4;
	Fri, 12 Sep 2025 20:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707606;
	bh=AJICmF2BscnjE30r9RzzJZIM6ohQdQgFfSYSRpLPeDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RMb5K7WFwi0latBXed3woOKztGA6Qd6Y/1qg9kNsoNqnETZoTZXiVVEvAds0h6kMm
	 4BnJeCqI4/Tny6dROC7NaiMUysdIRtVn45uDYPUbm3D7X4YIEd3gek/pGZeJ/NOW2S
	 chYu8NNiXajUI/G36qFHzG6V5kbIM6tXtbRetVwdsw0qht8rL5uSLmO+S7hcBEzxCd
	 Z97JmCFDgIHW1WidWxll2SvjuHUrpzsv+T3dc/lHS7sAzI/LgT21ectUGm57yHE/Cl
	 LmU/Gp1xq39Dko+7SsrBTGZx06k/gefynNbl4AUFbVbVwgpvEM05biRIJPnX539l7S
	 Gyn83yoOHa3UQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 07/16] ACPICA: acpidump: drop ACPI_NONSTRING attribute from
 file_name
Date: Fri, 12 Sep 2025 21:58:25 +0200
Message-ID: <2677488.Lt9SDvczpP@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2021361.PYKUYFuaPT@rafael.j.wysocki>
References: <2021361.PYKUYFuaPT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Ahmed Salem <x0rw3ll@gmail.com>

Partially revert commit 70662db73d54 ("ACPICA: Apply ACPI_NONSTRING in
more places") as I've yet again incorrectly applied the ACPI_NONSTRING
attribute where it is not needed.

A warning was initially reported by Collin Funk [1], and further review
by Jiri Slaby [2] highlighted another issue related to the same commit.

Drop the ACPI_NONSTRING attribute to fix the issue.

Fixes: 70662db73d54 ("ACPICA: Apply ACPI_NONSTRING in more places")
Link: https://lore.kernel.org/all/87ecvpcypw.fsf@gmail.com [1]
Link: https://lore.kernel.org/all/5c210121-c9b8-4458-b1ad-0da24732ac72@kernel.org [2]
Link: https://github.com/acpica/acpica/commit/a6ee09ca
Reported-by: Collin Funk <collin.funk1@gmail.com>
Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 tools/power/acpi/tools/acpidump/apfiles.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 75db0091e275..d6b8a201480b 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -103,7 +103,7 @@ int ap_open_output_file(char *pathname)
 
 int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 {
-	char filename[ACPI_NAMESEG_SIZE + 16] ACPI_NONSTRING;
+	char filename[ACPI_NAMESEG_SIZE + 16];
 	char instance_str[16];
 	ACPI_FILE file;
 	acpi_size actual;
-- 
2.51.0





