Return-Path: <linux-acpi+bounces-11749-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51144A4D410
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 07:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C0E1627FC
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 06:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9781F5617;
	Tue,  4 Mar 2025 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLVoTRfX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC91F5608;
	Tue,  4 Mar 2025 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070884; cv=none; b=F9l40kwj80RNWBZsvjf1LXWYPdQAuKGpVTVkcL6+03WBUkz/YKKDydeKY2JE6+7RIhrwNOmtX63w85J4zSh+EkmfQNFjP4Wpm1DyvAqPtspSHhe5TBPGb+V+dcfAwGff3WG7uq1DxovOPQH86GRscQLGOoo8QDeo7sq2aL4bEaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070884; c=relaxed/simple;
	bh=FFsgRhnvi+o6UYvVxaej1RWPU5KX/3pcA/SeTUYAZX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuGzDyd9nnCkSPFY8/8s3bTLBcNr4aq4gfnL3V7xohMe4N68BjdmXxCBGKjYa7RSMJoGfZF1ptaDBE5WQtTVPWdlmfsjWOJBGn92AiCnYLr8UjD6EYGLQUACAPumCg5Bi9FG7fZJm2W3WrPyUPMJLhK/Q/qmE1aQeFs7AoTR+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLVoTRfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57294C4CEE8;
	Tue,  4 Mar 2025 06:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741070883;
	bh=FFsgRhnvi+o6UYvVxaej1RWPU5KX/3pcA/SeTUYAZX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLVoTRfXEX9nbqrhPCV2RC5thZzne7rSOjreff/mIjCHdG3ScZJKDQJhbSIh8YvrH
	 +/79HI0RT77WtxBvwaIOKESk1Xb0FTeRDBOflOEsNaOPelBmNjCRWWPn0cXMcRCXWN
	 AiQURDuz4dUFv+Zo4phjpLKtn4JlacIN2W+TKa/EBGj5otuqjVMmprsHBuHtUfQaNa
	 tHpaQ9grvRUHy/8RB1s5etIapisMWyF6gYj/bNuY7gwJ8vzN+JGNAafwqEcKTSJd28
	 POAWP1Qp+B7pifTzYcYu/2diCk73huSOVhXUsz7IMi6t5lltg9huVS3/Crp1uPcgTU
	 0n4XE2dU2jUMg==
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
Subject: [PATCH v2 1/1] ACPI: platform_profile: Treat quiet and low power the same
Date: Tue,  4 Mar 2025 00:47:45 -0600
Message-ID: <20250304064745.1073770-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304064745.1073770-1-superm1@kernel.org>
References: <20250304064745.1073770-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When two drivers don't support all the same profiles the legacy interface
only exports the common profiles.

This causes problems for cases where one driver uses low-power but another
uses quiet because the result is that neither is exported to sysfs.

If one platform profile handler supports quiet and the other
supports low power treat them as the same for the purpose of
the sysfs interface.

Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 38 ++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 2ad53cc6aae53..d9a7cc5891734 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -73,8 +73,20 @@ static int _store_class_profile(struct device *dev, void *data)
 
 	lockdep_assert_held(&profile_lock);
 	handler = to_pprof_handler(dev);
-	if (!test_bit(*bit, handler->choices))
-		return -EOPNOTSUPP;
+	if (!test_bit(*bit, handler->choices)) {
+		switch (*bit) {
+		case PLATFORM_PROFILE_QUIET:
+			*bit = PLATFORM_PROFILE_LOW_POWER;
+			break;
+		case PLATFORM_PROFILE_LOW_POWER:
+			*bit = PLATFORM_PROFILE_QUIET;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		if (!test_bit(*bit, handler->choices))
+			return -EOPNOTSUPP;
+	}
 
 	return handler->ops->profile_set(dev, *bit);
 }
@@ -252,8 +264,16 @@ static int _aggregate_choices(struct device *dev, void *data)
 	handler = to_pprof_handler(dev);
 	if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
 		bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
-	else
+	else {
+		/* treat quiet and low power the same for aggregation purposes */
+		if (test_bit(PLATFORM_PROFILE_QUIET, handler->choices) &&
+		    test_bit(PLATFORM_PROFILE_LOW_POWER, aggregate))
+			set_bit(PLATFORM_PROFILE_QUIET, aggregate);
+		else if (test_bit(PLATFORM_PROFILE_LOW_POWER, handler->choices) &&
+			 test_bit(PLATFORM_PROFILE_QUIET, aggregate))
+			set_bit(PLATFORM_PROFILE_LOW_POWER, aggregate);
 		bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
+	}
 
 	return 0;
 }
@@ -305,6 +325,13 @@ static int _aggregate_profiles(struct device *dev, void *data)
 	if (err)
 		return err;
 
+	/* treat low-power and quiet as the same */
+	if ((*profile == PLATFORM_PROFILE_LOW_POWER &&
+	     val == PLATFORM_PROFILE_QUIET) ||
+	    (*profile == PLATFORM_PROFILE_QUIET &&
+	     val == PLATFORM_PROFILE_LOW_POWER))
+		*profile = val;
+
 	if (*profile != PLATFORM_PROFILE_LAST && *profile != val)
 		*profile = PLATFORM_PROFILE_CUSTOM;
 	else
@@ -531,6 +558,11 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 		dev_err(dev, "Failed to register platform_profile class device with empty choices\n");
 		return ERR_PTR(-EINVAL);
 	}
+	if (test_bit(PLATFORM_PROFILE_QUIET, pprof->choices) &&
+	    test_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices)) {
+		dev_err(dev, "Failed to register platform_profile class device with both quiet and low-power\n");
+		return ERR_PTR(-EINVAL);
+	}
 
 	guard(mutex)(&profile_lock);
 
-- 
2.43.0


