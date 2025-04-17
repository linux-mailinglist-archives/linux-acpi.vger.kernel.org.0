Return-Path: <linux-acpi+bounces-13088-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1765FA91572
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 09:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3402B16DCC5
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 07:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64EF21ABDB;
	Thu, 17 Apr 2025 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="vrIIPKLj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C78218821;
	Thu, 17 Apr 2025 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875617; cv=none; b=seGlB/1dLpNgrFvlGU1f8ZqaRYoI9unLuMsnJhbzBt10VGEi1BXTwozfV2gWfvtOw2rkYgnjAwNUN/RHMGVV1EyrSnAOEgQu+wxwOtDlec50WMhVpavuGrNchDL7uontexnFG403XcWZhGf7tgDLO6bGaWWpAR3UpxYyXklNMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875617; c=relaxed/simple;
	bh=TimnS22xJLJdJcglTRD/eXrTiFGGEKRUHgCJ2bG/N+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Egj7R4jJYYJBt+SOe+qQbhVBwOXDE5QhUIAroMC1Y9xxnS4azDdeZwr3dt3rosFATbCyjSkgMgbqt55pjrV9qf8LIVz8UxyLNAZhy9rX3DdnvqY3cXrnBvLt6g1n8bGfCS2OuMviuSDGHttsbT9PsChMYQR07YrSRlTVWnOOpVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=vrIIPKLj; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.155])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id E9B1C2005F;
	Thu, 17 Apr 2025 07:40:07 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 2DB5C3E8FC;
	Thu, 17 Apr 2025 07:40:00 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id C84C240049;
	Thu, 17 Apr 2025 07:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1744875599; bh=TimnS22xJLJdJcglTRD/eXrTiFGGEKRUHgCJ2bG/N+M=;
	h=From:To:Cc:Subject:Date:From;
	b=vrIIPKLjQwUTp5FjNtjshS/dxm0P3QeklwByfcIzL3+4efoydX3ttVrGCmSgtc9jZ
	 Hecn/kwMb3+yq1NzVj53m1Q1siQ+ARPxj/nthSCIIx9q929SRW6vq+2ql7OlxQaosB
	 J4E1yENfYWW4e3rh25UF5zoQC17zWzTNNkSktyz0=
Received: from JellyZhongke.localdomain (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 133564260D;
	Thu, 17 Apr 2025 07:39:55 +0000 (UTC)
From: Mingcong Bai <jeffbai@aosc.io>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>,
	Runhua He <hua@aosc.io>,
	Mingcong Bai <jeffbai@aosc.io>,
	stable@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Li Chen <me@linux.beauty>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ACPI: resource: fix a typo for MECHREVO in irq1_edge_low_force_override
Date: Thu, 17 Apr 2025 15:39:46 +0800
Message-ID: <20250417073947.47419-1-jeffbai@aosc.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C84C240049
X-Rspamd-Server: nf1.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[jeffbai.aosc.io:server fail,stable.vger.kernel.org:server fail];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action

The vendor name for MECHREVO was incorrectly spelled in commit
b53f09ecd602 ("ACPI: resource: Do IRQ override on MECHREV GM7XG0M").

Correct this typo in this trivial patch.

Cc: stable@vger.kernel.org
Fixes: b53f09ecd602 ("ACPI: resource: Do IRQ override on MECHREV GM7XG0M")
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
 drivers/acpi/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 14c7bac4100b..7d59c6c9185f 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -534,7 +534,7 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
  */
 static const struct dmi_system_id irq1_edge_low_force_override[] = {
 	{
-		/* MECHREV Jiaolong17KS Series GM7XG0M */
+		/* MECHREVO Jiaolong17KS Series GM7XG0M */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM7XG0M"),
 		},
-- 
2.49.0


