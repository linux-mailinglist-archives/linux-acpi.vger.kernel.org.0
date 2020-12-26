Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33202E2E65
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Dec 2020 15:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgLZOaG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Dec 2020 09:30:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbgLZOaF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 26 Dec 2020 09:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608992919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdpo9QWGcl+My0/pe2MZRbnowZy5711k8yBKOLuHM5o=;
        b=HBLC9W2bCPu255UcURW258HyWDuaHKF9uvRIR6+Xst1xLulsKGwXet7fWV/X6Exa7dN9aq
        zte6z/GzaqP+FeaKU5qjaxrKiDoys/o8f2H1/pf4UREnjjGJ+Xu406YOPAdVk5jY/4EqLs
        68Yxx3VUnCzDDd9tEPLAJh1PKFAhYkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-2whNnwnKOkSX6tX6EmZU0A-1; Sat, 26 Dec 2020 09:28:37 -0500
X-MC-Unique: 2whNnwnKOkSX6tX6EmZU0A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48ABE800D53;
        Sat, 26 Dec 2020 14:28:36 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-35.ams2.redhat.com [10.36.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D634E1349A;
        Sat, 26 Dec 2020 14:28:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH 2/2] ACPICA: Remove some code duplication from acpi_ev_address_space_dispatch
Date:   Sat, 26 Dec 2020 15:28:30 +0100
Message-Id: <20201226142830.48818-3-hdegoede@redhat.com>
In-Reply-To: <20201226142830.48818-1-hdegoede@redhat.com>
References: <20201226142830.48818-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The handling of the space_id == ACPI_ADR_SPACE_GSBUS and
space_id == ACPI_ADR_SPACE_GPIO cases is almost identical,
fold the 2 cases into 1 to remove some code duplication.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/evregion.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 8e84eb0641e0..d1ca997c9c4c 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -244,7 +244,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	 *      the previous Connection)
 	 *   2) bit_width is the actual bit length of the field (number of pins)
 	 */
-	if ((region_obj->region.space_id == ACPI_ADR_SPACE_GSBUS) &&
+	if ((region_obj->region.space_id == ACPI_ADR_SPACE_GSBUS ||
+	     region_obj->region.space_id == ACPI_ADR_SPACE_GPIO) &&
 	    context && field_obj) {
 
 		status = acpi_os_acquire_mutex(context_mutex, ACPI_WAIT_FOREVER);
@@ -259,24 +260,11 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		context->connection = field_obj->field.resource_buffer;
 		context->length = field_obj->field.resource_length;
 		context->access_length = field_obj->field.access_length;
-	}
-	if ((region_obj->region.space_id == ACPI_ADR_SPACE_GPIO) &&
-	    context && field_obj) {
 
-		status = acpi_os_acquire_mutex(context_mutex, ACPI_WAIT_FOREVER);
-		if (ACPI_FAILURE(status)) {
-			goto re_enter_interpreter;
+		if (region_obj->region.space_id == ACPI_ADR_SPACE_GPIO) {
+			address = field_obj->field.pin_number_index;
+			bit_width = field_obj->field.bit_length;
 		}
-
-		context_locked = true;
-
-		/* Get the Connection (resource_template) buffer */
-
-		context->connection = field_obj->field.resource_buffer;
-		context->length = field_obj->field.resource_length;
-		context->access_length = field_obj->field.access_length;
-		address = field_obj->field.pin_number_index;
-		bit_width = field_obj->field.bit_length;
 	}
 
 	/* Call the handler */
-- 
2.28.0

