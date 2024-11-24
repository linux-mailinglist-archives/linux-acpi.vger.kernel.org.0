Return-Path: <linux-acpi+bounces-9771-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BBC9D6EF2
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Nov 2024 13:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEBC2815B6
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Nov 2024 12:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAC21917CE;
	Sun, 24 Nov 2024 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGvS2c6m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E01BB6B8;
	Sun, 24 Nov 2024 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452344; cv=none; b=Huz9Ieni9YzzX2YWAe5V83ZUZCFqchapEGzMLJoVwGsAd7wQP7Fqs4DGsIaTNBIu+jCZvPAto2r72xgjd/cfCVr+kyzzlOhXDIDvarGTEMPm6hRlm0C6NlTIK/7g7jiPzodZ9bi/ohrl3cpVtY/qjSNZCw8uSpz68bVhttYEGZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452344; c=relaxed/simple;
	bh=eTgZQJpcD/PmjuNCIi0Xm4QqmNoFd66zhNMo0Cicm0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EELGCYOro0W6zRWrnxzWjvOTJ4EEbM604+Bv+7G91RyNsSrnayrSc5nDWqHdNVPiFwgTZThcw0sTeDWqb90EckkSH32w66LVCB9SZ2pM/P+ZkfLngic4BoqtH1vBwRxa0N43OkSh4ivYOwlwyKeSJBAjuQ28HZCw3jchZf5GlPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGvS2c6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5E2C4CED1;
	Sun, 24 Nov 2024 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452343;
	bh=eTgZQJpcD/PmjuNCIi0Xm4QqmNoFd66zhNMo0Cicm0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGvS2c6mZdGWu96MZjKHyrtBZzKWRES5MyQwUwHaiDIULh+/vS9eggnqiz01TQ5vP
	 qS8em1UHRgTIHUWf7u94UrCt9z8dkYjIfXefGxXxLUkcedwz3Zd9Xj8kj5KJmLkMNH
	 VEQ18VinCo7TlHVjGAKayEqpelVd0kzWzIzb40cfdpIbL7XlziKds14h1+IgCw5Yq1
	 M+0gGGH4cL7dYAch5bcKuRjRWBU3nGhcr2N9/0aWnUFfHo/N3Q9UhZmzRYrjXIvEPW
	 XzEw42ECvOzRrWVk07zAotKEzZATlya6O9yKQiWt8XiwxtgxL5dd/LzvSMvuY7Er4/
	 7KGk/AlyduNbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	mario.limonciello@amd.com,
	tony.luck@intel.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 5/6] ACPI: x86: Add adev NULL check to acpi_quirk_skip_serdev_enumeration()
Date: Sun, 24 Nov 2024 07:45:27 -0500
Message-ID: <20241124124532.3337626-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124532.3337626-1-sashal@kernel.org>
References: <20241124124532.3337626-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 4a49194f587a62d972b602e3e1a2c3cfe6567966 ]

acpi_dev_hid_match() does not check for adev == NULL, dereferencing
it unconditional.

Add a check for adev being NULL before calling acpi_dev_hid_match().

At the moment acpi_quirk_skip_serdev_enumeration() is never called with
a controller_parent without an ACPI companion, but better safe than sorry.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20241109220028.83047-1-hdegoede@redhat.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 5a3bf81746a55..ac6bc6482ce16 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -537,7 +537,7 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 	 * Set skip to true so that the tty core creates a serdev ctrl device.
 	 * The backlight driver will manually create the serdev client device.
 	 */
-	if (acpi_dev_hid_match(adev, "DELL0501")) {
+	if (adev && acpi_dev_hid_match(adev, "DELL0501")) {
 		*skip = true;
 		/*
 		 * Create a platform dev for dell-uart-backlight to bind to.
-- 
2.43.0


