Return-Path: <linux-acpi+bounces-15869-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C59EB2E302
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 19:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEBF5E07A9
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 17:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9275E327798;
	Wed, 20 Aug 2025 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J64JIAJf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF832512E6
	for <linux-acpi@vger.kernel.org>; Wed, 20 Aug 2025 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709778; cv=none; b=N9v6iiAezp1+iNo5tIp0OPbrmqyMFOCoug4oAWl+m7TzKVot82o8Cvrhm+GdQFQ/cN5gEr0HeOMnN7FWM6XHUU/jtGYm/q1PjH+2b5LK7KWJew+pjOA1F5amF3HHcGHqGcIxwRFbdvfc9LeMTmbKTIUv6nf9gzcC/TF8NxYR5qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709778; c=relaxed/simple;
	bh=oEB+J2o8NjqjCKmmtVWW4X5GZzlATjq0iFJDmU7mYdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0eJr6fctiRK9w4QNQWnBU2Ok3aiKYj8v6R7E8sbqBxGENkW37x+LOOFxiGtmQ7kpAnJ3C1JdeWmGytUvNbyWRCK0VxOLBo9RQPnVvSqyDDQVJByKdXpiyOFiAKBQcFNl6wCrUbunL1K9ynZU3+ayZChsREatLvhXOL1VgFSjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J64JIAJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0869AC4CEE7;
	Wed, 20 Aug 2025 17:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755709776;
	bh=oEB+J2o8NjqjCKmmtVWW4X5GZzlATjq0iFJDmU7mYdE=;
	h=From:To:Cc:Subject:Date:From;
	b=J64JIAJfmKV0CQEqXM5Vl65D7FPV+qU08gqdx+qOqyr/0bim8yV3RhuoLezzlYeEc
	 NePs6455UDuyY0FJTicltzLUS2wYraKhp1ZawQuxXrluhK2RK0r/oKqnNiDuZThh6S
	 n80aO+K2SoAFK4+kzntLdtcXp/b4wlJ5RVpApnzN7X/bK0Kvl7ZOkZlTaWY6V6qQgO
	 CVAZCcyLRlahe227AicTrN257cQP3r+WEtOnWZb2YGb+el8/zUpsWh1FHkZriQv1Wn
	 QbM0/B0KgivXA1CGg9WnHGdtu2MDO1KFGKN1ATd9h7+nzQQK+hANb72EBC6NGIKwZ3
	 mrnaQlu1CpLYg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org,
	lenb@kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Daniel Dadap <ddadap@nvidia.com>,
	Hans de Goede <hansg@kernel.org>,
	Wilson Alvarez <wilson.e.alvarez@rubonnek.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: video: force native for Lenovo 82K8
Date: Wed, 20 Aug 2025 12:09:26 -0500
Message-ID: <20250820170927.895573-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo 82K8 has a broken brightness control provided by nvidia_wmi_ec.
Add a quirk to prevent using it.

Cc: Daniel Dadap <ddadap@nvidia.com>
Cc: Hans de Goede <hansg@kernel.org>
Reported-by: Wilson Alvarez <wilson.e.alvarez@rubonnek.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4512
Tested-by: Wilson Alvarez <wilson.e.alvarez@rubonnek.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index d507d5e084354..4cf74f173c785 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -948,6 +948,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
 		},
 	},
+	/* https://gitlab.freedesktop.org/drm/amd/-/issues/4512 */
+	{
+	 .callback = video_detect_force_native,
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "82K8"),
+		},
+	},
 	{ },
 };
 
-- 
2.43.0


