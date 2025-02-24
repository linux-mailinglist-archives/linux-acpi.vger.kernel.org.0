Return-Path: <linux-acpi+bounces-11429-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97638A42D0B
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 20:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CC1178328
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 19:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F58821CC58;
	Mon, 24 Feb 2025 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Ya/WmKqu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AAC1C6FE4;
	Mon, 24 Feb 2025 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426676; cv=none; b=iaFNI11fBqxtKL1gmfKSDq1SQ2aBOd4ghwYBDhOUfhQ5Ymue7zRdwJcJyjFJDjQv3NapUIaMTdkIx8z6tbal6F4KHB4sXnF6vMvckwle1k/xykwekCUdCMTcekkYrtroVm/VI4iJsKmWWFKBETaIFd2JonZ5AN7ktGpXAOP+aME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426676; c=relaxed/simple;
	bh=pQIZI3RhskIemMuOi4mkO2phoUfcs3mClPk3IXZvoiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5n4+ItMZM/mGpDh1llrEr21d8zArqHnJaAdK7NClHP+wU+WsNcGqQJrinn0vQvPEFvCxwgjap3B75lcwzJfe9kKJOH1pOf0eKXR3anvIGRZeyUaehk+/5zwwyw8xSXKWD0/MAqtTFXu0eUtt2FqnpjGYOdTbbpwbUbgVFHjYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Ya/WmKqu; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 0BECC2E09300;
	Mon, 24 Feb 2025 21:51:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740426671;
	bh=+SO3o/KnLjaW2qevFdQUm8FDaUvLmpOi1YiDgAfUgBU=; h=From:To:Subject;
	b=Ya/WmKquGTu3gCnXsYLGsrr7JTqfN9U/WD+pgGQiVnsS3qu9ULoB48WGMic7xLN7P
	 R/pRIMg3iCNx5ioK1yj4SKbWbzEVeg5saaNVy2cGG1qs5HDQ+QuL3H+dPbDs8iKev/
	 +YmW5rjtLKAnyQmtvj5scXZZfMzAXwXVZSEXYPH4=
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
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH 2/3] ACPI: platform_profile: add all options to amd-pmf as a
 secondary handler
Date: Mon, 24 Feb 2025 20:50:58 +0100
Message-ID: <20250224195059.10185-3-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224195059.10185-1-lkml@antheas.dev>
References: <20250224195059.10185-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174042667123.532.11352273453287996101@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

As a secondary handler, the amd-pmf module should be able to accept
all platform profiles. In the case of a custom profile, it should NOOP
without an error to allow primary handlers to receive a custom profile.
The sysfs endpoint will still report custom, after all.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/amd/pmf/spc.c | 3 +++
 drivers/platform/x86/amd/pmf/sps.c | 7 +++++++
 2 files changed, 10 insertions(+)

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
index 424b146d3574..f284ebc495ee 100644
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
-- 
2.48.1


