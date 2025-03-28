Return-Path: <linux-acpi+bounces-12534-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E0BA751DE
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 22:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E0E3B0558
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 21:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2831EB5D1;
	Fri, 28 Mar 2025 21:09:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C014D70E;
	Fri, 28 Mar 2025 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743196151; cv=none; b=XQFcfVOTHpJuvp3A9DWTu8BiKE15FFBgNTQZupUSmxsvbfFOEVnyUc2q/v1zd65Q8HhLSARQGyel4XdDU/iwbTjPuzYNej1PQEV0e0jy3IO6ph2nZtUZjn0BdwsCSY1EH4/qxiRlYIv44bQQN4BbvgXru4CFWhE+qlxtVq5OYbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743196151; c=relaxed/simple;
	bh=Hc3c/0+YJM29iLeoht3DsYlHu7lIMwN9kBvsmSdc5E0=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=MjDNnO+uiQuAF7X/fowH7SM2Gexrs4MkqYAtsGnxHFCgLf9VdLVg+DEQ+03L7DvTqICzd1t7hM/O1pyFjRmphqS8ZlXJlIF3t3wZ5b++lfYUVRAM6ZV/IEKk40QR43ZTcrrblvydHjIASC+XfjwQq4xx7oy/Z8Pe6hISdyYtda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b692a2.dsl.pool.telekom.hu [::ffff:81.182.146.162])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000080649.0000000067E70FF3.0006D659; Fri, 28 Mar 2025 22:09:07 +0100
From: Gergo Koteles <soyer@irl.hu>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
  Len Brown <lenb@kernel.org>, Alex Hung <alex.hung@amd.com>,
  Mario Limonciello <mario.limonciello@amd.com>,
  Rodrigo Siqueira <siqueira@igalia.com>,
  Alex Deucher <alexander.deucher@amd.com>,
  Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>,
  stable@vger.kernel.org
Subject: [PATCH v2] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
Date: Fri, 28 Mar 2025 22:08:56 +0100
Message-ID: <61c3df83ab73aba0bc7a941a443cd7faf4cf7fb0.1743195250.git.soyer@irl.hu>
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

The _DDC method should return a buffer, or an integer in case of an error.
But some Lenovo laptops incorrectly return EDID as buffer in ACPI package.

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

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extensions/output-device-specific-methods.html#ddc-return-the-edid-for-this-device
Cc: stable@vger.kernel.org
Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
Changes in v2:
 - Added comment
 - Improved commit message
 - Link to v1: https://lore.kernel.org/all/4cef341fdf7a0e877c50b502fc95ee8be28aa811.1743129387.git.soyer@irl.hu/

 drivers/acpi/acpi_video.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index efdadc74e3f4..103f29661576 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -649,6 +649,13 @@ acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length
 
 	obj = buffer.pointer;
 
+	/*
+	 * Some buggy implementations incorrectly return the EDID buffer in an ACPI package.
+	 * In this case, extract the buffer from the package.
+	 */
+	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 1)
+		obj = &obj->package.elements[0];
+
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
 		*edid = kmemdup(obj->buffer.pointer, obj->buffer.length, GFP_KERNEL);
 		ret = *edid ? obj->buffer.length : -ENOMEM;
@@ -658,7 +665,7 @@ acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length
 		ret = -EFAULT;
 	}
 
-	kfree(obj);
+	kfree(buffer.pointer);
 	return ret;
 }
 
-- 
2.49.0


