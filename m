Return-Path: <linux-acpi+bounces-10568-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB70FA0C05C
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 19:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947B6164CF8
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F5B211489;
	Mon, 13 Jan 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw9FcEy5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05EB211460;
	Mon, 13 Jan 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793357; cv=none; b=jErvifTXvUsZans8fNirptdS3v0ZSKIygcNgBQuTgKTzjUI7dF0XlDed3Z/ZL7W5iX7Ee/W/nGzeAoH6SjXoj74hQzvxpJI4/RTdcXEH1WNLtQ8d9/7Wi/4UxP2PYJ5OslyUE4PE7MQTyKKE31b1AnhpzWtc/wq7Z7xUn/hBVMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793357; c=relaxed/simple;
	bh=wczmufoKcjIgTjG6Z3shPMl/d7xYT7WGizP5sWsZ/dQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qCEwyLDr2JlNeVcq80kbjnqir4RBmILJqd9QreFlBto6J/YhOkouGPwZTiWT0EGsK/1fJTtx2oOllU5oKzaYTxWd3u0+VoXLFDtiZLZabMN57BzF10aAD0ltR0i7MBFbtubpLP7+yiBD2LR9Elb8ynEUSHNfZu0iGLzaOqiNNYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw9FcEy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97718C4CEE5;
	Mon, 13 Jan 2025 18:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793356;
	bh=wczmufoKcjIgTjG6Z3shPMl/d7xYT7WGizP5sWsZ/dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dw9FcEy5N76Cx36Wy0drJlU/Q7A+YRuNbGzC6Y/1Qg9bEOekG+TemxplGt2xSCull
	 fkQkqUbC9wPYI386JbuvfsxGBZe+caffrMwekkNhk3XOEaEQz2QYlyzBodJ/r1yzBR
	 nRnGNHRdNWdGNK0K2zahi8jECPd3RPoH+oFWvLWvjX9pTQK19Nh6O8xvZmdLkBSW5n
	 xGKVNkuKRptW19fcZHzSJGNWApyoSBsxjBahDtNYP4CkDEYQ+isuYLA91S7UJbTrj2
	 RP4ZmpSY2l35+yHFniBvG1sOjuM7w4bpYwlzJa2a3Sootr2TMGbH7EYqqRo2vm71wW
	 k6EaYcH5F09cA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/10] ACPI: resource: acpi_dev_irq_override(): Check DMI match last
Date: Mon, 13 Jan 2025 13:35:34 -0500
Message-Id: <20250113183537.1784136-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183537.1784136-1-sashal@kernel.org>
References: <20250113183537.1784136-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.124
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
index b36b8592667d..f59a62396d65 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -645,11 +645,11 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
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


