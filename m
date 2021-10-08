Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BAC426EB8
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Oct 2021 18:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhJHQ0M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Oct 2021 12:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22890 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238121AbhJHQ0L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Oct 2021 12:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633710255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SBb0rlCeWZ1Ev5Z7FbYuF8IjjGkJR/n1Ws3JwD0IB0M=;
        b=dm5OTgtlvnPi/yA+R3vzZdGwap+hrHouQ0VMzJBFgqymKjLz2j9rKDIgYV8JgKgjHudUNf
        93sBkY2Aoa+NUVtNASrC5Qu7EpJTF3enZeSeS81a+nKE18KAfQuQjKN8AUeamoCz8ESQAs
        h6zzn2f7D3/WTlGvVxz9zjRbHSenrXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-2muWbBIWN6KdtXCk9s1c-g-1; Fri, 08 Oct 2021 12:24:05 -0400
X-MC-Unique: 2muWbBIWN6KdtXCk9s1c-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 858B9192E075;
        Fri,  8 Oct 2021 16:22:20 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 736EF61140;
        Fri,  8 Oct 2021 16:21:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 01/12] ACPI: Add has_unmet_acpi_deps() helper function
Date:   Fri,  8 Oct 2021 18:21:10 +0200
Message-Id: <20211008162121.6628-2-hdegoede@redhat.com>
In-Reply-To: <20211008162121.6628-1-hdegoede@redhat.com>
References: <20211008162121.6628-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The clk and regulator frameworks expect clk/regulator consumer-devices
to have info about the consumed clks/regulators described in the device's
fw_node.

To work around cases where this info is not present in the firmware tables,
which is often the case on x86/ACPI devices, both frameworks allow the
provider-driver to attach info about consumers to the clks/regulators
when registering these.

This causes problems with the probe ordering wrt drivers for consumers
of these clks/regulators. Since the lookups are only registered when the
provider-driver binds, trying to get these clks/regulators before then
results in a -ENOENT error for clks and a dummy regulator for regulators.

ACPI-devices may have dependencies at the ACPI level (_DEP method), these
are tracked by the ACPI core, but ACPI devices will be instantiated during
boot even if they have unmet ACPI-dependencies because the _DEPs may never
get fully resolved (under Linux).

These ACPI-dependencies may be useful to solve the probe ordeing, for
example on laptops which use MIPI camera sensors connected to an Intel IPU3
for there cameras, a TI TPS68470 PMIC may be used to provide a clk +
regulators for the sensors. This TPS68470 PMIC is described using an
ACPI-device with a HID of INT3472 and the sensors have a _DEP pointing to
the INT3472 device which describes their PMIC.

The sensor drivers can use the ACPI core dependency tracking to delay
binding (return -EPROBE_DEFER) until the Linux INT3472 driver has bound
and registered the clks + regulator including lookup info, thus solving
the probe ordering issue.

Add a has_unmet_acpi_deps() which drivers can use to check if all
dependencies requested enumerated by the _DEP method have been met.

Note this relies on all drivers for devices listed in _DEP (for a
device which driver uses has_unmet_acpi_deps()) to call
acpi_dev_clear_dependencies() at the end of their probe() function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/linux/acpi.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 974d497a897d..7ff35d483d04 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -86,6 +86,13 @@ static inline bool has_acpi_companion(struct device *dev)
 	return is_acpi_device_node(dev->fwnode);
 }
 
+static inline bool has_unmet_acpi_deps(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	return adev ? adev->dep_unmet : false;
+}
+
 static inline void acpi_preset_companion(struct device *dev,
 					 struct acpi_device *parent, u64 addr)
 {
@@ -802,6 +809,11 @@ static inline bool has_acpi_companion(struct device *dev)
 	return false;
 }
 
+static inline bool has_unmet_acpi_deps(struct device *dev)
+{
+	return false;
+}
+
 static inline void acpi_preset_companion(struct device *dev,
 					 struct acpi_device *parent, u64 addr)
 {
-- 
2.31.1

