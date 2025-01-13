Return-Path: <linux-acpi+bounces-10566-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2090FA0C013
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 19:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4017116A429
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 18:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6C11F9ED2;
	Mon, 13 Jan 2025 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8fM5wyO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BD21F9EBB;
	Mon, 13 Jan 2025 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793304; cv=none; b=uYl7KusvvgLRY2JX0o4OphbNhT7E2Bs0IKaBQEWJb40pCp1rTeYN8wXcMNK1sacpK/TNIi5cgwA2PilpaEus+GkrJLF8S0cUzfIXj+ib8d4DExzVE7hcADGCTpvFrZkdGFFGzyREL2W8b89gaZjWm/RiL6f8I9LWKk3JTKUIPa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793304; c=relaxed/simple;
	bh=Zj2gZNvL7MpN+xivJ7ur61/XqBLQqjM5r5bid6Vo0CQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tNcbcOmCL847n+lcGp1S3Jiwoa/gPF9W9LrPHIYMJtGRuzk5Sab62b7nquGhVrzkOOlTgQ4KANuKfUg4BBZc5DdgdOHuzIO4DRFXf9l8HOK0bUaPQVlE7FZsBgIi/5GJ03ijrpUlsGUbk4Ml57gkPyVZ2Xm6SwB47fhhZwVbGpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8fM5wyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA1BC4CEE1;
	Mon, 13 Jan 2025 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793304;
	bh=Zj2gZNvL7MpN+xivJ7ur61/XqBLQqjM5r5bid6Vo0CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8fM5wyOQaNDpjW3KWALz1fxB2Ny51Uxtom71qkxtuYZ5ICPdxq01TF7+aGRXoTGj
	 +HsI/UIn8dAARFa/TQrM8y8Y0AHJAXVVftXrUf7jTknOOQcT45Eg6N8zD8d+ZiI5Gk
	 khCj4l+cTr9JpcAmedSjbuwIhm3SLTTJLDJ+RHCz0lpMhY5IhHcXyELwJXniZFZXNN
	 /tNQwxg65PlQe4mg3cy9moyHXa6/LFigi2dfOyjwg8MIvbaQ19fq0qxEJ0MgER2hnu
	 0IJJscP81upQPSs7fViwfOoIWl0r4pIy6QwQgnZPg/ox3caXE2hv2Hpfx0Qn4RHcDt
	 z0X7GGOazRwqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 16/20] ACPI: resource: acpi_dev_irq_override(): Check DMI match last
Date: Mon, 13 Jan 2025 13:34:21 -0500
Message-Id: <20250113183425.1783715-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183425.1783715-1-sashal@kernel.org>
References: <20250113183425.1783715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.9
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit cd4a7b2e6a2437a5502910c08128ea3bad55a80b ]

acpi_dev_irq_override() gets called approx. 30 times during boot (15 legacy
IRQs * 2 override_table entries). Of these 30 calls at max 1 will match
the non DMI checks done by acpi_dev_irq_override(). The dmi_check_system()
check is by far the most expensive check done by acpi_dev_irq_override(),
make this call the last check done by acpi_dev_irq_override() so that it
will be called at max 1 time instead of 30 times.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20241228165253.42584-1-hdegoede@redhat.com
[ rjw: Subject edit ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 821867de43be..f0ae46e7be36 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -671,11 +671,11 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 	for (i = 0; i < ARRAY_SIZE(override_table); i++) {
 		const struct irq_override_cmp *entry = &override_table[i];
 
-		if (dmi_check_system(entry->system) &&
-		    entry->irq == gsi &&
+		if (entry->irq == gsi &&
 		    entry->triggering == triggering &&
 		    entry->polarity == polarity &&
-		    entry->shareable == shareable)
+		    entry->shareable == shareable &&
+		    dmi_check_system(entry->system))
 			return entry->override;
 	}
 
-- 
2.39.5


