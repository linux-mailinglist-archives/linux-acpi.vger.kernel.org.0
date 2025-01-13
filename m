Return-Path: <linux-acpi+bounces-10569-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD2AA0C073
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 19:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D840188572C
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 18:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D00121766F;
	Mon, 13 Jan 2025 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDkggtC6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2D2135D6;
	Mon, 13 Jan 2025 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793375; cv=none; b=RlcuLoxwop1RunsjhsNJKOv4uInbbDv0lPdhwdaXUqEl4WzbVjidrFSvuGLsCG6M/MXNMgfX9FI5Lu5V8tjupH0/OVpekgncDS+7GbuNQsQlelPT7L3HePLRXiB4dSk7H9iNkpDZt8m8ujvv3QxqOxT904/OkCrUDv4dBtXsu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793375; c=relaxed/simple;
	bh=iqF5Y0hzfDuFpyrJty+HD/GCtVD034ZcIEYI4gBz1Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dh8xeeW1UBRdv0MxjuE0EqxkFoeHgGFJ6BqzsvgTMJ+3Se2CEEljuJ5p8RDxGwZt4Z1LtyMv+RgY35N0g37iSUgP4KfiFrnddDiu/0WRp2n4nlw9X7Upkf6M+oa/UZY+UpAiOLHFpy6L7fg1LkSP6N+T5UYLwkN/sabMhHG/5+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDkggtC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DD8C4CED6;
	Mon, 13 Jan 2025 18:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793375;
	bh=iqF5Y0hzfDuFpyrJty+HD/GCtVD034ZcIEYI4gBz1Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDkggtC6Z9XqfLsStEPbVuldBvPquZ7jnCHoobxW/VgIBikY9V1XmXcP6ElgQovYg
	 7UNQS2Q3MxPqlIFiCiAWT+D3/TlxUljIWAdHcWYK/H0503josB2bGLllGO4hjP6DJE
	 zRuhBFr+u3qUgQ6Kuawwjg5RIYkpc77Vwj6pLrK0t3JDWQWGlcwVUF41tAv0V1T4tL
	 pqj/aDAIkcd/N0lyVvSIc8csPpMxn8nNWaefla2YCjvUiCZIZL+o0iMe021Ok10gzb
	 Smupq/8yTfWjCGXZ1O650piB3rYDObzl0DztsIFuU/qUj5Z1lC8khCcWuMS7fJkN0N
	 XZ3STFOJr5Baw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 5/6] ACPI: resource: acpi_dev_irq_override(): Check DMI match last
Date: Mon, 13 Jan 2025 13:35:59 -0500
Message-Id: <20250113183601.1784402-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183601.1784402-1-sashal@kernel.org>
References: <20250113183601.1784402-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.176
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
index 0433ab8ced0d..9bae5c473cf0 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -648,11 +648,11 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
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


