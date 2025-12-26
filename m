Return-Path: <linux-acpi+bounces-19861-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABB0CDE97C
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 11:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5369A3009AA0
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 10:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64F8285C8D;
	Fri, 26 Dec 2025 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="X+ibKlEF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0F22097;
	Fri, 26 Dec 2025 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766745179; cv=none; b=jauzQHaCd7x+j94W60FybHMal4/1lM2bFaBXkvSnRZzUF2HzDO98oOdTONtlplgM33TTotRCpvxQjDxB0gdrHOoLkG2QkfAC8YoHewnHoM70uPM9/LEYy1TF9FixwU7A8XO1RK34CXB3C47ofBePMRKs8TZ9Rh+3kAg1wPN6HMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766745179; c=relaxed/simple;
	bh=2HKh3VVDcTLF6cYVYZwPDDOfOEz05QlmGVqz0NeNl9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoop/jHlpMZOiG4RI5AiePOJSc/T3xuexquKUEseWAgBjRIOU0gkHMeSDpfvVT/qWd3iZCi6shv0/eL5+Oxz6tHdM585wqaftPnCABii0tnibowUTi4zpalJ9pXKUjK8YQVPhyGpBf+hzglZwpGFFxCaFIBvmmhPJjDSS7yTIus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=X+ibKlEF; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 0AA94BD9F9;
	Fri, 26 Dec 2025 12:27:47 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 78D38BC770;
	Fri, 26 Dec 2025 12:27:46 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a02:2149:8a28:c200:ffd7:3bf6:9efd:b472])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 99FCF200D44;
	Fri, 26 Dec 2025 12:27:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1766744866;
	bh=ztcI+T5xyH1Iqv/Hfp0urWUwZszOLISihCn6mTknRkk=; h=From:To:Subject;
	b=X+ibKlEF1E/M7FqaRK0oV2ZMYfDEvmBph1XDmCc5FPgET/rbuLn378sYnOR5sdubD
	 kkDio8aWDenTDovx0ikSdDMrws/jjrsyR4o6GsncposQH27MfWzIRuN3F0jXt0eAAm
	 ylcxEi2igjlHL+q39PGlp/C0UqKFPvSq+2yUMr7A2i0lk6992cv5m+H2TmW4YVhPM0
	 2JbqdK0ef8qxpiVM7cOKyKTz7vkaH2gVIfrUYNoSDxt3GnE2N1/sCknx0y01VOmSsg
	 xd6pwqH2jsoaUqu92+vHOX/C7Pv+ov+H9sUGWNF2OTNS0MkCzVUf+L5bSke3ZhFqxD
	 wb1Zj+g73i8Pg==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8a28:c200:ffd7:3bf6:9efd:b472) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: dmitry.osipenko@collabora.com
Cc: bob.beckett@collabora.com,
	bookeldor@gmail.com,
	hadess@hadess.net,
	jaap@haitsma.org,
	kernel@collabora.com,
	lennart@poettering.net,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkml@antheas.dev,
	mccann@jhu.edu,
	rafael@kernel.org,
	richard@hughsie.com,
	sebastian.reichel@collabora.com,
	superm1@kernel.org,
	systemd-devel@lists.freedesktop.org,
	xaver.hugl@gmail.com
Subject: [RFC v1 4/8] acpi/x86: s2idle: add support for querying runtime
 standby state support
Date: Fri, 26 Dec 2025 12:26:42 +0200
Message-ID: <20251226102656.6296-5-lkml@antheas.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226102656.6296-1-lkml@antheas.dev>
References: <20251226102656.6296-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176674486607.2608443.11642982308655321183@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Implement the platform_s2idle_ops->get_standby_states() callback to
query which modern standby states are supported by the platform based
on the dsm func masks and expose those to the kernel as runtime standby
states. Union the vendor specific AMD/Intel masks with the ones from
Microsoft as some laptops implement both of them.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/x86/s2idle.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 1f13c8b0ef83..08fa7841a484 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -513,6 +513,40 @@ static struct acpi_scan_handler lps0_handler = {
 	.attach = lps0_device_attach,
 };
 
+static u8 acpi_s2idle_get_standby_states(void)
+{
+	u8 states = 0;
+
+	if (!lps0_device_handle || sleep_no_lps0)
+		return 0;
+
+	if (lps0_dsm_func_mask_microsoft > 0) {
+		states |= BIT(PM_STANDBY_ACTIVE);
+		if (lps0_dsm_func_mask_microsoft &
+		    (1 << ACPI_LPS0_DISPLAY_OFF | 1 << ACPI_LPS0_DISPLAY_ON))
+			states |= BIT(PM_STANDBY_INACTIVE);
+		if (lps0_dsm_func_mask_microsoft &
+		    (1 << ACPI_LPS0_SLEEP_ENTRY | 1 << ACPI_LPS0_SLEEP_EXIT))
+			states |= BIT(PM_STANDBY_SLEEP);
+	}
+
+	if (lps0_dsm_func_mask > 0) {
+		states |= BIT(PM_STANDBY_ACTIVE);
+		if (acpi_s2idle_vendor_amd()) {
+			if (lps0_dsm_func_mask &
+			    (1 << ACPI_LPS0_DISPLAY_OFF_AMD |
+			     1 << ACPI_LPS0_DISPLAY_ON_AMD))
+				states |= BIT(PM_STANDBY_INACTIVE);
+		} else {
+			if (lps0_dsm_func_mask & (1 << ACPI_LPS0_DISPLAY_OFF |
+						  1 << ACPI_LPS0_DISPLAY_ON))
+				states |= BIT(PM_STANDBY_INACTIVE);
+		}
+	}
+
+	return states;
+}
+
 static int acpi_s2idle_begin_lps0(void)
 {
 	if (pm_debug_messages_on && !lpi_constraints_table) {
@@ -629,6 +663,7 @@ static void acpi_s2idle_restore_early_lps0(void)
 }
 
 static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
+	.get_standby_states = acpi_s2idle_get_standby_states,
 	.begin = acpi_s2idle_begin_lps0,
 	.prepare = acpi_s2idle_prepare,
 	.prepare_late = acpi_s2idle_prepare_late_lps0,
-- 
2.52.0



