Return-Path: <linux-acpi+bounces-12519-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2995FA7429B
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 03:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6609F189BEAA
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 02:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B26A20DD64;
	Fri, 28 Mar 2025 02:51:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A720DD6B;
	Fri, 28 Mar 2025 02:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743130301; cv=none; b=WtzaXJnZC/h3NcsriYNsheXUm7jVq9FHa9wHn3dFCTZf7hmB+TWTKJqgDTAOlAHEeXk4BqfnsTSkaOhZZQzC/GWwPRyWo75GdGD0SG+Yoi5Q/87LWm/Kxo/uT1t+xnMEVUWKMQbE5J2yBM9s5YG2TvYNliGtFHEPxIP+6R7nDkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743130301; c=relaxed/simple;
	bh=OfSMEoXcKwYz9G/YAO5ukyb0YgaWhOSY50U/Dlz3TLA=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=CnQW2xU9mAqqc23XXHsuw9snVjnwEQ8hTtExACy5qPAqqoaA9eTkWGjiPQ0bE2fRUVeWX2hcemYVU+ZR44hwJDfB7D1avAQ+uSRrXoh1ktyzJyghHtkTdQfPUzlpcYhhrETzzybCnNkBI1wxBg/RQFtuhREDH2XafwsHDqVuhUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b692a2.dsl.pool.telekom.hu [::ffff:81.182.146.162])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000800FA.0000000067E60D82.0006A495; Fri, 28 Mar 2025 03:46:26 +0100
From: Gergo Koteles <soyer@irl.hu>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
  Len Brown <lenb@kernel.org>,
  Mario Limonciello <mario.limonciello@amd.com>,
  Rodrigo Siqueira <siqueira@igalia.com>,
  Alex Hung <alex.hung@amd.com>,
  Alex Deucher <alexander.deucher@amd.com>
Cc: linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>,
  stable@vger.kernel.org
Subject: [PATCH] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
Date: Fri, 28 Mar 2025 03:44:00 +0100
Message-ID: <4cef341fdf7a0e877c50b502fc95ee8be28aa811.1743129387.git.soyer@irl.hu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Some Lenovo laptops incorrectly return EDID as
buffer in ACPI package (instead of just a buffer)
when calling _DDC.

Calling _DDC generates this ACPI Warning:
ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - \
found Package, expected Integer/Buffer (20240827/nspredef-254)

Use the first element of the package to get the EDID buffer.

The DSDT:

Name (AUOP, Package (0x01)
{
	Buffer (0x80)
	{
	...
	}
})

...

Method (_DDC, 1, NotSerialized)  // _DDC: Display Data Current
{
	If ((PAID == AUID))
        {
		Return (AUOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.AUOP */
	}
	ElseIf ((PAID == IVID))
	{
		Return (IVOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.IVOP */
	}
	ElseIf ((PAID == BOID))
	{
		Return (BOEP) /* \_SB_.PCI0.GP17.VGA_.LCD_.BOEP */
	}
	ElseIf ((PAID == SAID))
	{
		Return (SUNG) /* \_SB_.PCI0.GP17.VGA_.LCD_.SUNG */
	}

	Return (Zero)
}

Cc: stable@vger.kernel.org
Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/acpi/acpi_video.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index efdadc74e3f4..65cf36796506 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -649,6 +649,9 @@ acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length
 
 	obj = buffer.pointer;
 
+	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 1)
+		obj = &obj->package.elements[0];
+
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
 		*edid = kmemdup(obj->buffer.pointer, obj->buffer.length, GFP_KERNEL);
 		ret = *edid ? obj->buffer.length : -ENOMEM;
@@ -658,7 +661,7 @@ acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length
 		ret = -EFAULT;
 	}
 
-	kfree(obj);
+	kfree(buffer.pointer);
 	return ret;
 }
 
-- 
2.49.0


