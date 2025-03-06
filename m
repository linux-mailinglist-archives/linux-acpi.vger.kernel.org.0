Return-Path: <linux-acpi+bounces-11878-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D74A54150
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 04:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0823AA01E
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 03:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C03D1991B6;
	Thu,  6 Mar 2025 03:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlxwznnS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEDA156225;
	Thu,  6 Mar 2025 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741232659; cv=none; b=rLxv6UCd3l4pKB7d1D4VWX2pV8g8/Qp3MNuZ+gJTX+fm9Kp7UveC/V9OT43hF9EE8NhBe2HeKC/i8DxbBKcp3moi+7DYfEFUTmsOMgKa1PlD2ozsm+bbv6YbNrrJeW1S0YaX56pYW6HSJOb2fJ5A73PBl607wlgsqcIwZN2WlLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741232659; c=relaxed/simple;
	bh=zbuxOIdgJUxZ4n8mVot+kiQOUkVyHXs87OyG172qmlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JKtyltKiHPm9Q3ruyOiOYPP+eQb1VSebTGqXqQNARkbsRFAoxGfdJYtyqCwOutGsOz6EFh+72AOxYabr5f1Rk8Mi14diQIkbmFFXaCV0awGAkICXaT7tY3Fv8hjEjxChhG8WQvhZZhMiIXzn6JlX5a2D7y6JYI8edmIkj2t/Hbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlxwznnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386D0C4CEE4;
	Thu,  6 Mar 2025 03:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741232654;
	bh=zbuxOIdgJUxZ4n8mVot+kiQOUkVyHXs87OyG172qmlk=;
	h=From:To:Cc:Subject:Date:From;
	b=RlxwznnSVd2HmpCdVhZNgE6a9GKYx0jLMHE0x0VqxVVV6QRAdvF8L6tbE9GL421nH
	 7cA64wpmnv4rwWrm0jEW7Jld4heyq9LB9c5SVcTxwQITg41JjSS0BrwGxrLmJd668p
	 yhcuTaiFWIRlqvKZygv6c1TRmgo0FKBfqLJMZGl0e0/xIrxFSZwBJQ8MRUdaaAMNIi
	 1TKJ1KU8Hf+f1GvllMW4KVxwObyTU+4rjzrQub2Bwd21+WT6gTSPMz5L27joxJzgtp
	 NAd9ptyWZ57454ja9cvV8HKWccbh2FI8cTXZu7RZEeseR6m1/Our8n+bwnG85eACcL
	 V8hUVUtl+tZZg==
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
	Mario Limonciello <mario.limonciello@amd.com>,
	Yijun Shen <Yijun.Shen@dell.com>
Subject: [PATCH] platform/x86/amd: pmf: Fix missing hidden options for Smart PC
Date: Wed,  5 Mar 2025 21:44:02 -0600
Message-ID: <20250306034402.50478-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

amd_pmf_get_slider_info() checks the current profile to report correct
value to the TA inputs.  If hidden options are in use then the wrong
values will be reported to TA.

Add the two compat options PLATFORM_PROFILE_BALANCED_PERFORMANCE and
PLATFORM_PROFILE_QUIET for this use.

Reported-by: Yijun Shen <Yijun.Shen@dell.com>
Fixes: 9a43102daf64d ("platform/x86/amd: pmf: Add balanced-performance to hidden choices")
Fixes: 44e94fece5170 ("platform/x86/amd: pmf: Add 'quiet' to hidden choices")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmf/spc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
index f34f3130c3307..1d90f9382024b 100644
--- a/drivers/platform/x86/amd/pmf/spc.c
+++ b/drivers/platform/x86/amd/pmf/spc.c
@@ -219,12 +219,14 @@ static int amd_pmf_get_slider_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_
 
 	switch (dev->current_profile) {
 	case PLATFORM_PROFILE_PERFORMANCE:
+	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
 		val = TA_BEST_PERFORMANCE;
 		break;
 	case PLATFORM_PROFILE_BALANCED:
 		val = TA_BETTER_PERFORMANCE;
 		break;
 	case PLATFORM_PROFILE_LOW_POWER:
+	case PLATFORM_PROFILE_QUIET:
 		val = TA_BEST_BATTERY;
 		break;
 	default:
-- 
2.43.0


