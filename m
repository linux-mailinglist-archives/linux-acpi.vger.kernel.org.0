Return-Path: <linux-acpi+bounces-11636-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E1FA49FB2
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 18:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F8E3A919B
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F54F27425F;
	Fri, 28 Feb 2025 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxVFx1/0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E41274253;
	Fri, 28 Feb 2025 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762125; cv=none; b=iLPVNQSbqRcL33AcIh3oK6LLXuLd+kjzj7FasvtIkiCbwZFZyPWqm55p+iDK9huZAhYPDWALWbB/Ywb2H99P6K3EstCvvUGa48pmLbxXljTLNzTSin6OIl/0K71Hik0FRHD7GeOCuZ+TCT5Mx4D/UNHUdzDBLUtLgjr+ARXt7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762125; c=relaxed/simple;
	bh=nVZjg2w4a12vSwQmLBWWeLjQQntQyeqv/AhDkQeSNUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWryQxtCg33gs6Q94CTLxK42AzHL3Q1NSB+JQYWqnBGujdyb9ozxnpP8Sme/IC8s031lz6TdWfICI8e8G8s2u8PZS2SFLAU1YFnxgctmEgDD2alk4OAtpKctJSiECJOETGitpVIvzyFZrMF4tV7GhwW+iYm4Soc8MxCJYlYaUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxVFx1/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB54C4CEE9;
	Fri, 28 Feb 2025 17:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740762125;
	bh=nVZjg2w4a12vSwQmLBWWeLjQQntQyeqv/AhDkQeSNUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxVFx1/04lnckrpkiQaU7GaeGv/n/7DCICWiTjTKnj/mYWaTdXjv5Ay6eeHtkwv/X
	 YPggBoQawV3e3l4ETnS6sGby+lkIoNMv2IRUxfcfbyptVOG0RZQo7unjK0if9p5rlb
	 hfkZA91QlnvksbBtKTwXHrmVS9syHK08Iip+KtfxYyzX5u4gyb4PlS4RsPNE+45mp0
	 NmhqsdbZ02mkF5CouuUyYO6SGDJJyRHgr1gcj6qFO5tPaRl/QP6jlAzZEZpraYV9tG
	 yfYtT6yhM6Gv63F7GQ5iKJyk9XhYZWo3AGwOCUYIHZhXYXSpPfoc7oGcAc9F1cw5Sv
	 MKD7WsHk6gE6w==
From: Mario Limonciello <superm1@kernel.org>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: platform-driver-x86@vger.kernel.org (open list:AMD PMF DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-acpi@vger.kernel.org (open list:ACPI),
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/3] platform/x86/amd: pmf: Add 'quiet' to hidden choices
Date: Fri, 28 Feb 2025 11:01:54 -0600
Message-ID: <20250228170155.2623386-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228170155.2623386-1-superm1@kernel.org>
References: <20250228170155.2623386-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When amd-pmf and asus-wmi are both bound no low power option shows
up in sysfs.  Add a hidden choice for amd-pmf to support 'quiet' mode
to let both bind.

Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
Suggested-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: "Luke D. Jones" <luke@ljones.dev>
 drivers/platform/x86/amd/pmf/sps.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index e6cf0b22dac33..3a0079c17cb17 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -303,6 +303,7 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
 		mode = POWER_MODE_BALANCED_POWER;
 		break;
 	case PLATFORM_PROFILE_LOW_POWER:
+	case PLATFORM_PROFILE_QUIET:
 		mode = POWER_MODE_POWER_SAVER;
 		break;
 	default:
@@ -387,6 +388,13 @@ static int amd_pmf_profile_set(struct device *dev,
 	return 0;
 }
 
+static int amd_pmf_hidden_choices(void *drvdata, unsigned long *choices)
+{
+	set_bit(PLATFORM_PROFILE_QUIET, choices);
+
+	return 0;
+}
+
 static int amd_pmf_profile_probe(void *drvdata, unsigned long *choices)
 {
 	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
@@ -398,6 +406,7 @@ static int amd_pmf_profile_probe(void *drvdata, unsigned long *choices)
 
 static const struct platform_profile_ops amd_pmf_profile_ops = {
 	.probe = amd_pmf_profile_probe,
+	.hidden_choices = amd_pmf_hidden_choices,
 	.profile_get = amd_pmf_profile_get,
 	.profile_set = amd_pmf_profile_set,
 };
-- 
2.43.0


