Return-Path: <linux-acpi+bounces-11560-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12569A4831B
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 16:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF2A7A594C
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E0826BD8F;
	Thu, 27 Feb 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="1pZtdF94"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E62260C;
	Thu, 27 Feb 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670573; cv=none; b=FjWpm+L0mn/RHbQTLXC6OAFwhiWw9HGvH2ZbfOZDN8pOxURTDR+/B/dsErvw00w5DiXVNHg5H016HcZWIXwsHWbThiCTlAt7D2hAj01z0T41gkb6TiBN/7/UJXHOAABCkwad+XXOz/OVM+biOQF8LPEPFBViX46GZc3Ay8+IhMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670573; c=relaxed/simple;
	bh=LXfWGMImBVNNBL2/aFJcmVKGpxXpL5lEwqNmPymHTdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W51KK0XlmgiGMFLd0F7XXTWclA057POZ8GuySc9YIsm+h3yVhN//MbjEptQtf9eXwkFghGjP17sSXCBGanRnlw/KfSVKwmD9erB3bUNSW5g0OH9ytNyzT2SRUTQk46cq7P1T7AVflHCEH9kLi3LBaHy9aXHFts2k0bR+S1Cq7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=1pZtdF94; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 309772E08EB6;
	Thu, 27 Feb 2025 17:36:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740670569;
	bh=3atOOL6HRdSCGQf8dbOyq0sehckQcDD/Uoq82e0iXWo=; h=From:To:Subject;
	b=1pZtdF94V7v97BouunzcjbSEwR4RSC6BjH1lfElJLdtzK+bvP2/vyQVt2AJMcGUyZ
	 a3iY2MEctQ/2yyjJWEgrafVcSjiAg8xz1BFsYGXmMuxyHQmkCnVBaLqkw7wYVRq1NZ
	 XQVyVuF/Zwi06b/QMgn8T0uZMo/lDpcnwQdY1I04=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: mario.limonciello@amd.com,
	mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	hdegoede@redhat.com,
	me@kylegospodneti.ch,
	luke@ljones.dev,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v2 2/2] ACPI: platform_profile: make amd-pmf a secondary
 handler
Date: Thu, 27 Feb 2025 16:36:03 +0100
Message-ID: <20250227153603.131046-3-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227153603.131046-1-lkml@antheas.dev>
References: <20250227153603.131046-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174067056939.31705.3234110058223723097@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Since amd-pmf is expected to run alongside other platform handlers, it
should be able to accept all platform profiles. Therefore, mark it as
secondary and in the case of a custom profile, make it NOOP without an
error to allow primary handlers to receive a custom profile.
The sysfs endpoint will still report custom, after all.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/amd/pmf/spc.c | 3 +++
 drivers/platform/x86/amd/pmf/sps.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
index f34f3130c330..99c48378f943 100644
--- a/drivers/platform/x86/amd/pmf/spc.c
+++ b/drivers/platform/x86/amd/pmf/spc.c
@@ -219,12 +219,15 @@ static int amd_pmf_get_slider_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_
 
 	switch (dev->current_profile) {
 	case PLATFORM_PROFILE_PERFORMANCE:
+	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
 		val = TA_BEST_PERFORMANCE;
 		break;
 	case PLATFORM_PROFILE_BALANCED:
 		val = TA_BETTER_PERFORMANCE;
 		break;
 	case PLATFORM_PROFILE_LOW_POWER:
+	case PLATFORM_PROFILE_COOL:
+	case PLATFORM_PROFILE_QUIET:
 		val = TA_BEST_BATTERY;
 		break;
 	default:
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index e6cf0b22dac3..a2a8511768ce 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -297,12 +297,15 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
 
 	switch (pmf->current_profile) {
 	case PLATFORM_PROFILE_PERFORMANCE:
+	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
 		mode = POWER_MODE_PERFORMANCE;
 		break;
 	case PLATFORM_PROFILE_BALANCED:
 		mode = POWER_MODE_BALANCED_POWER;
 		break;
 	case PLATFORM_PROFILE_LOW_POWER:
+	case PLATFORM_PROFILE_COOL:
+	case PLATFORM_PROFILE_QUIET:
 		mode = POWER_MODE_POWER_SAVER;
 		break;
 	default:
@@ -369,6 +372,10 @@ static int amd_pmf_profile_set(struct device *dev,
 	struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
 	int ret = 0;
 
+	/* If the profile is custom, bail without an error. */
+	if (profile == PLATFORM_PROFILE_CUSTOM)
+		return 0;
+
 	pmf->current_profile = profile;
 
 	/* Notify EC about the slider position change */
@@ -400,6 +407,7 @@ static const struct platform_profile_ops amd_pmf_profile_ops = {
 	.probe = amd_pmf_profile_probe,
 	.profile_get = amd_pmf_profile_get,
 	.profile_set = amd_pmf_profile_set,
+	.secondary = true,
 };
 
 int amd_pmf_init_sps(struct amd_pmf_dev *dev)
-- 
2.48.1


