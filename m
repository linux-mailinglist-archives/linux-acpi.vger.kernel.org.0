Return-Path: <linux-acpi+bounces-11428-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FE6A42D07
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 20:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDDE188E512
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 19:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DD82054E3;
	Mon, 24 Feb 2025 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="srfon7C2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0D1DB346;
	Mon, 24 Feb 2025 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426674; cv=none; b=MuJHPPpKlpAVWA1VggGaq2senSqcY+dGK8TaAZHqwmfSwrpeAbaQh6uRZjNsHz09eCLFOmJwgnKoZiXF2Fusn5tjIJ5m7TM53tWKjVoAVOZgiEix4dhRTA+0gwd+RwcETQkdLTA8ntt5sOHWvZM78n6yPlQlJklJKVymOCd3HEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426674; c=relaxed/simple;
	bh=2YTWcc0RCWcvCxkwLHCXfMZ1V9B6DXDFvKiWKCbalHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMBu42vntghoOjqSRMzvchJhcIKj0/fEgIk+PMQlambVbLujsTc08ct+o8DtTJnaFfjqa0Cn7DEz4XTRYGYsp1qb41Jx9gUvqspDAK1ev/ffF1mAfeCVor2GDH0vDZcCvN/d7EsIVfAeL6+geCRwwEWlIWYl2d072wOQHTV+gAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=srfon7C2; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 4A5E12E02886;
	Mon, 24 Feb 2025 21:51:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740426669;
	bh=E2QSzTezztxd6Ef0cZ8WmAoDrND7y6XUuooP7fVEXFI=; h=From:To:Subject;
	b=srfon7C2dPVlgEmPjo4bh/l1JXO2AJi38/c+s1goJbfqmTgXTX8GR0cNqfqIrbdyQ
	 pFV5VJ0K/TR+rlVZyxLJhSfKI2SkW11uicKryckICiSEgXIw1efzpddx3qiArOSh5e
	 vL+3UGJ8rJTWW0hGWQrYSZtYOuTrz81d9Qj6+Qic=
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
Subject: [PATCH 1/3] ACPI: platform_profile: Add support for secondary
 handlers
Date: Mon, 24 Feb 2025 20:50:57 +0100
Message-ID: <20250224195059.10185-2-lkml@antheas.dev>
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
X-PPP-Message-ID: <174042666945.466.7712161454235914871@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, only the subset of supported profiles are exposed when
using platform profile. This is a big problem when e.g., asus-wmi
and amd-pmf are loaded together, as they have conflicting low
power options. This causes ppd and tuned to miss the low power
option increasing power consumption.

Therefore, add the secondary variable. Profile handlers with it should
accept all profile options always. Only when they are the sole
handler, their probe function will be used to expose available profiles.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/amd/pmf/sps.c | 1 +
 include/linux/platform_profile.h   | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index e6cf0b22dac3..424b146d3574 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -397,6 +397,7 @@ static int amd_pmf_profile_probe(void *drvdata, unsigned long *choices)
 }
 
 static const struct platform_profile_ops amd_pmf_profile_ops = {
+	.secondary = true,
 	.probe = amd_pmf_profile_probe,
 	.profile_get = amd_pmf_profile_get,
 	.profile_set = amd_pmf_profile_set,
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 8ab5b0e8eb2c..fef5f2404e9f 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -30,6 +30,12 @@ enum platform_profile_option {
 
 /**
  * struct platform_profile_ops - platform profile operations
+ * @secondary: Set the platform handler as a secondary. Secondary handlers
+ *		 should be able to accept all profile options. This way, they do
+ *		 not obscure the primary handler's profile options (such as amdpmf
+ *		 having cool and asus-wmi having quiet). When a secondary handler
+ *		 is the only handler available, its probe function is still used
+ *		 to avoid showing all profiles.
  * @probe: Callback to setup choices available to the new class device. These
  *	   choices will only be enforced when setting a new profile, not when
  *	   getting the current one.
@@ -39,6 +45,7 @@ enum platform_profile_option {
  *		 profile in sysfs.
  */
 struct platform_profile_ops {
+	bool secondary;
 	int (*probe)(void *drvdata, unsigned long *choices);
 	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
 	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
-- 
2.48.1


