Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BED1ED70B
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jun 2020 21:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgFCTrH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jun 2020 15:47:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56535 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725821AbgFCTrH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jun 2020 15:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591213625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pUCFsh8kHhXLfpHddk4KhjpjgYqI8QDfRGVWgRvKZoo=;
        b=WVbUnYX5PSxGqH1v0UHbHCEk48bq4ocUOmh5g6Yrs98YGbZ0/d/oJ7AcIXbch3p2dXTbfV
        3T0zrXFGtAS0gOm0ahEx3Mhl1jnnLHmm3wN99DF2thAiTwQVPlnaK0IbQNrUorPb1wvHHP
        fv48clzsYFLtMTPLaY1S/EPIIFnlLSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-gBMP4d9QMZmGD5Gflmy0qg-1; Wed, 03 Jun 2020 15:47:04 -0400
X-MC-Unique: gBMP4d9QMZmGD5Gflmy0qg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89FEE80B73B;
        Wed,  3 Jun 2020 19:47:02 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-210.ams2.redhat.com [10.36.112.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 197BB2B4DF;
        Wed,  3 Jun 2020 19:47:00 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        youling257@gmail.com, linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI / PM: Do not infer power-state if there are no D0 power-resources
Date:   Wed,  3 Jun 2020 21:46:59 +0200
Message-Id: <20200603194659.185757-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some devices do not have a power-resource-list for D0, but do have a
power-resource-lists for e.g. D3 (_PR3).

On these devices the "if (device->power.flags.power_resources)" check
in acpi_device_get_power() succeeds because of the presence of the _PR3
resources, so the code used to try and infer the power-state.

In this case since there is no power-resource-list for D0, we can never
infer that the device is in D0 even though it very well might be in D0.
This results in the code inferring that the device is in D3HOT and on
the first suspend acpi_device_set_power() skips calling _PS3 for the
device because it thinks the device is already in D3.

An example of a family of devices which are affected by this are
Bay Trail based devices. The ACPI device for the XHCI controller on
these devices does not have a _PR0 method, but it does have a _PR3
method. The problem described above causes the XHCI controller's _PS3
method not getting called on the first suspend of the device, which
causes these devices to not reach the S0i3 power-state during suspend.

Since we cannot infer if the device is in D0 or not when there is no
power-resource-list for D0, the best thing to do is to change
acpi_power_get_inferred_state() to return ACPI_STATE_UNKNOWN in this
case.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205057
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/power.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index fe1e7bc91a5e..db54393a077b 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -807,6 +807,17 @@ int acpi_power_get_inferred_state(struct acpi_device *device, int *state)
 	if (!device || !state)
 		return -EINVAL;
 
+	/*
+	 * Some devices do not have a power-resource-list for D0, but do
+	 * have a power-resource-lists for e.g. D3 so we do end up here.
+	 * In this case we can never infer that the device is in D0 even
+	 * though it might very well be in D0, so return ACPI_STATE_UNKNOWN.
+	 */
+	if (list_empty(&device->power.states[ACPI_STATE_D0].resources)) {
+		*state = ACPI_STATE_UNKNOWN;
+		return 0;
+	}
+
 	/*
 	 * We know a device's inferred power state when all the resources
 	 * required for a given D-state are 'on'.
-- 
2.26.2

