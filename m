Return-Path: <linux-acpi+bounces-8423-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE626986B23
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 05:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9CAB231DE
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 03:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E78517C23D;
	Thu, 26 Sep 2024 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzygvwhD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49D17B4F6;
	Thu, 26 Sep 2024 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727319608; cv=none; b=g0vmxyVTX8eh4TR24DyKhm1aMMtHr9bL06A0I9PgAorfYpnfe2nCWGEG8WjDhN91DRkxVr8kzfR6tMrhhS0qk1f+pI2SJNrYAyaQYNVGi8bxTFYkdWpG+wm4hX9oxwlX8gSFhEq+Ff1iExDyM9ZumiLaO8n+BZfwwo0ROFyHZUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727319608; c=relaxed/simple;
	bh=DQn0vH1OySQQskSdxWk+PEierBBh+i24Ih2z+s/Zr6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rN1koNTUH71RnxGOn/hOmVC7kpYIm/H4NCuvUhBwsI8kC6K3rfM+iE+p9uaJgKxJMjau9NyPwMByPXTVCvwAzLojdsxbZESYVCG6dfEamMJGPYwyvGBVvK82vz1XDKxzs6zror75ixj8iOEq/uKk4lNpQt/+uxbexyP9z9AC2kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzygvwhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE91C4CECE;
	Thu, 26 Sep 2024 03:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727319607;
	bh=DQn0vH1OySQQskSdxWk+PEierBBh+i24Ih2z+s/Zr6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzygvwhD+jk8H6oHSZsA8K6uguxfDYbyW2CPEziSd8933NLkE+bHxNb7moIB2uxun
	 6KSDW0RM9gWuuHONxateHdCWqjziCn0ZKc0ejbn5DTAj/JT1RMRMHWy6Axcyjft5RD
	 VMJ4qaVx0ZHBEtEvNRPakkAW/VcmpZGdFRRgPHZrLje/GrtDlOFq6sQbd1qhIKN8yI
	 KnLp6oIHD92aAfdJ0QNZRz8uZEjapxtpD0AMxHUwnfKstr0FWYbgTHaie1y3tsR1xZ
	 r0nS8dz5V/G4fsV+dqIdfOhOOc5UW36wgZxeLtGrINtvA8Zm2GGwPT+7dFRZhlphF0
	 W3rXDgQh6di4g==
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
Subject: [RFC 1/2] ACPI: Add support for a 'custom' profile
Date: Wed, 25 Sep 2024 21:59:54 -0500
Message-ID: <20240926025955.1728766-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926025955.1728766-1-superm1@kernel.org>
References: <20240926025955.1728766-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Introduce a new profile type called 'custom' that can be set to allow
changing settings outside of the standard profile settings.

The idea behind this is to enforce a state machine so that a user
can't set 'balanced' then manually change one APU setting and confuse
userspace because the system is no longer really behaving in balanced.

In practice the intention is that userspace would first set "custom"
followed by modifying any settings. If userspace wants to go back to
one of the predefined profiles then those profiles can be written to
/sys/firmware/acpi/platform_profile.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/ABI/testing/sysfs-platform_profile | 1 +
 drivers/acpi/platform_profile.c                  | 1 +
 include/linux/platform_profile.h                 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
index baf1d125f9f8..13dfe8aadbe2 100644
--- a/Documentation/ABI/testing/sysfs-platform_profile
+++ b/Documentation/ABI/testing/sysfs-platform_profile
@@ -15,6 +15,7 @@ Description:	This file contains a space-separated list of profiles supported for
 					power consumption with a slight bias
 					towards performance
 		performance		High performance operation
+		custom			Custom profile tuned by the user
 		====================	========================================
 
 		Userspace may expect drivers to offer more than one of these
diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d2f7fd7743a1..383f87c8c036 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -19,6 +19,7 @@ static const char * const profile_names[] = {
 	[PLATFORM_PROFILE_BALANCED] = "balanced",
 	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
 	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
+	[PLATFORM_PROFILE_CUSTOM] = "custom",
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index f5492ed413f3..61273b615419 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -23,6 +23,7 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_BALANCED,
 	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
 	PLATFORM_PROFILE_PERFORMANCE,
+	PLATFORM_PROFILE_CUSTOM,
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
 
-- 
2.43.0


