Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9ABE45F090
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Nov 2021 16:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378072AbhKZP0f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Nov 2021 10:26:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353915AbhKZPYb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Nov 2021 10:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637940078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z+hxKj1RhZxSD9K7CJZqF1FoH7TyNNXYZIrj9xYgerM=;
        b=VOVZib3LLRmQNHZ0QZyBg2JixcSo3tRN1z5yl1B+aq4nEXWO+Z4xp6vEv+2DBFNYaVJzD2
        3BZIVwtfrehmnCk4cMSF5/gx0iTP9MhUBaZHoTc5T1NU91sj/r4mg4bqEMPI7ld8Aq/PxC
        wXAxjfW2/tQXFfTppAGbSg4uEnQ6HPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-QhgFnXXtPZGDJIdxdmNiEw-1; Fri, 26 Nov 2021 10:21:17 -0500
X-MC-Unique: QhgFnXXtPZGDJIdxdmNiEw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 242E834833;
        Fri, 26 Nov 2021 15:21:16 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D451260854;
        Fri, 26 Nov 2021 15:21:14 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 3/3] ACPI: PMIC: xpower: Fix _TMP ACPI errors
Date:   Fri, 26 Nov 2021 16:21:09 +0100
Message-Id: <20211126152109.230986-3-hdegoede@redhat.com>
In-Reply-To: <20211126152109.230986-1-hdegoede@redhat.com>
References: <20211126152109.230986-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On some devices with a X-Powers AXP288 PMIC the LPAT tables in the ACPI
node for the AXP288 PMIC for some reason only describe a small temperature
range, e.g. 27° - 37° Celcius (assuming the entries are in millidegrees).

When the tablet is idle in a room at 21° degrees this is causing values
outside the LPAT table to be read, causing e.g. the following 2 errors
to get spammed to the logs every 4 seconds! :

[ 7512.791316] ACPI Error: AE_ERROR, Returned by Handler for [UserDefinedRegion] (20210930/evregion-281)
[ 7512.791611] ACPI Error: Aborting method \_SB.SXP1._TMP due to previous error (AE_ERROR) (20210930/psparse-529)

Fix this by clamping the raw value to the LPAT table range before
passing it to acpi_lpat_raw_to_temp().

Note clamping has been chosen rather then extrapolating because it is
unknown how other parts of the ACPI tables will respond to temperature
values outside of the LPAT range.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/pmic/intel_pmic_xpower.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index e844bc1f3df5..61bbe4c24d87 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -293,12 +293,33 @@ static int intel_xpower_exec_mipi_pmic_seq_element(struct regmap *regmap,
 	return ret;
 }
 
+static int intel_xpower_lpat_raw_to_temp(struct acpi_lpat_conversion_table *lpat_table,
+					 int raw)
+{
+	struct acpi_lpat first = lpat_table->lpat[0];
+	struct acpi_lpat last = lpat_table->lpat[lpat_table->lpat_count - 1];
+
+	/*
+	 * Some LPAT tables in the ACPI Device for the AXP288 PMIC for some
+	 * reason only describe a small temperature range, e.g. 27° - 37°
+	 * Celcius. Resulting in errors when the tablet is idle in a cool room.
+	 *
+	 * To avoid these errors clamp the raw value to be inside the LPAT.
+	 */
+	if (first.raw < last.raw)
+		raw = clamp(raw, first.raw, last.raw);
+	else
+		raw = clamp(raw, last.raw, first.raw);
+
+	return acpi_lpat_raw_to_temp(lpat_table, raw);
+}
+
 static const struct intel_pmic_opregion_data intel_xpower_pmic_opregion_data = {
 	.get_power = intel_xpower_pmic_get_power,
 	.update_power = intel_xpower_pmic_update_power,
 	.get_raw_temp = intel_xpower_pmic_get_raw_temp,
 	.exec_mipi_pmic_seq_element = intel_xpower_exec_mipi_pmic_seq_element,
-	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
+	.lpat_raw_to_temp = intel_xpower_lpat_raw_to_temp,
 	.power_table = power_table,
 	.power_table_count = ARRAY_SIZE(power_table),
 	.thermal_table = thermal_table,
-- 
2.33.1

