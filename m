Return-Path: <linux-acpi+bounces-10567-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BF8A0C039
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 19:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9821887997
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 18:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132FA202C41;
	Mon, 13 Jan 2025 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmuWOmIi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2EC1FFC59;
	Mon, 13 Jan 2025 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793333; cv=none; b=qx3l8wR0Z9baIXuB44/sQVgJpKwMXGkpzoXun3NzeiK3eo7QAYsAvJUhsSpvyaXNs6LrMwguX8V4mHXHzB+5yKfn6YZ1d7e6eSQgyZMVZspQ8uDDYZ41Dsc1ZHvdSeVdAdk7+zYqPy0iZqUDIHHKEyjWGnH4NoXmnGotRUgRSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793333; c=relaxed/simple;
	bh=FhJQ8B2RND9ED4l7TJod052/Xv4xIBlkf++2T0FfpEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+Ar1c75FtxcUe7Od1alFw2XsdcS+CPzApsU9kV41INF8FyP6F9Ij7BFHXzWfomgVHxNqBkjqYOBo12ABLYQpvQ7JSda6nArRE/2Qt0MY0EOIo6dfe+It2aztJcg8qK6BOboc/0CH4tMzSNMBJXi4DKTlO0WWWBb43JMx8JkVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmuWOmIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BF3C4CEE5;
	Mon, 13 Jan 2025 18:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793332;
	bh=FhJQ8B2RND9ED4l7TJod052/Xv4xIBlkf++2T0FfpEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmuWOmIiWjbWb6m2MdZ7zntuxLudArZQ9Hi4R0T4Fp/+Va715iti5JKZ6BvWLEJKu
	 B0blAkYhhtu79a980PTroVjynH7kUl7NvEIcDLS5Jb+KuzlG7VcR91yyWQ7HKNi1FZ
	 2+ZgTX1T8L4O+U5HKYnOWKQJMFtFBAg2gKPu5JdhJedKjXmwoK1mWexOFi51sbD19w
	 vHkg4YaEq648Y5ZG1dimeuFEJe7SicF9+PKUuyTuTsoYPuMVL8WcaFv+xw9hJLKx7d
	 +JGNzDuMj0CMSSdXLgFNDhRVD9DMN5YYRdUunfCBOX1PjUAd7z2NYVVxO75IRts0+B
	 8q/PBqQdohbLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/10] ACPI: resource: acpi_dev_irq_override(): Check DMI match last
Date: Mon, 13 Jan 2025 13:35:09 -0500
Message-Id: <20250113183511.1783990-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183511.1783990-1-sashal@kernel.org>
References: <20250113183511.1783990-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.71
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
index df598de0cb18..f17dce80b7ba 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -662,11 +662,11 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
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


