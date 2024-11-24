Return-Path: <linux-acpi+bounces-9768-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA3C9D6EDD
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Nov 2024 13:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409BA280C05
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Nov 2024 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920E61B0F11;
	Sun, 24 Nov 2024 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntYHN+CG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C11B0F15;
	Sun, 24 Nov 2024 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452327; cv=none; b=QwXr3x5wEzsOvTw8xgxbAL7ZbbmNtfhCLD/ko9nlcQCM8dyGC4KlNT8XOfm8MolJCDTBhA95pBPNbrF4MT1vh/kdvHYvISXxIS7bv8iokdet9Ks1UDahvIfRVVYuaHc1RT5YaB19nbwfqqtRZVMNaYQAE9QPrHA334DSqrsWo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452327; c=relaxed/simple;
	bh=LcZwJq3v2Ktit5H5ljQiBPyoVR6IvzaMMrJaaethwng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyCtx7gNp8O4UPEBlU0ZM0sraYIpfN5WqyAGp+IFml/b+caKJ7X5GCqiSOT7+VPSd3NVCUmbKnwugZ/zOGBH2CSOXEYJe3Gh7JFEyQAtgTT9+cVzHY3deioxNvJuHeaLcDjAjjorVpdEC2I/ZitxBLyYBys1Vww6vX3D4gdpL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntYHN+CG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011AFC4CED3;
	Sun, 24 Nov 2024 12:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452327;
	bh=LcZwJq3v2Ktit5H5ljQiBPyoVR6IvzaMMrJaaethwng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntYHN+CGcBzOFPTvJjbH6f9KJTL0B4qYA7JCY+enfhwilCfBbNrY5H4jcgb/yuyoQ
	 2Z/8Ykbr7Yh4Uhk8wccQmH+uMnxkmtVWfbXE8C86Yu9Dnl9L0/HMrreQQoxX1K6Jj8
	 uXPm8Os3Ibhz3vq5UaTU0RGQR4tP4/Vd3ouQ6iOmKRVZsl5TBYH3YldqHakZXa3Lpa
	 QjSY5b/mapxVPiQw4fj0p26V9OMpZYBzOO8mWavdPWy3cTue8qHpXH0CvQmDgWwDso
	 2Yg3KO7+ohnai9hNgT0mytCxsaPj8YlvKVgnvJoyfD9iF7Jk/pbHGUnUC4EnyEKrRt
	 vDkn0D/KAIUqw==
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
Subject: [PATCH AUTOSEL 6.12 5/6] ACPI: x86: Add adev NULL check to acpi_quirk_skip_serdev_enumeration()
Date: Sun, 24 Nov 2024 07:45:10 -0500
Message-ID: <20241124124516.3337485-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124516.3337485-1-sashal@kernel.org>
References: <20241124124516.3337485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 3eec889d4f5f8..423565c31d5ef 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -536,7 +536,7 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
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


