Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0501F2F880D
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 23:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbhAOV7Z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 16:59:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725918AbhAOV7Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 16:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610747879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FRdf+oO4QsAq/cq5laVstioBLXmBS1Z02chEz3YZ22U=;
        b=FHnUAAbitIYO7vnEz42Fgjxky1GRnae9xPY92PKf4scZmUMgt3rzrNdflyxbUV/gw33D1g
        pnEp6QB0/Bo3dvqWU0AQv5a/ME9U1KcojZG6plEmyTeP8PKET5X1ZtolKWdvT6Og6u8chZ
        GW/Syxz7B4XMEAKTt1IzaqsirlKUnhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-Y5TqMhwOPpWrhsbh9kyJ8A-1; Fri, 15 Jan 2021 16:57:55 -0500
X-MC-Unique: Y5TqMhwOPpWrhsbh9kyJ8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50CDF1015C80;
        Fri, 15 Jan 2021 21:57:54 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-172.ams2.redhat.com [10.36.112.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56B1563746;
        Fri, 15 Jan 2021 21:57:53 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ACPI: scan: Make acpi_bus_get_device() clear the adev ptr on error
Date:   Fri, 15 Jan 2021 22:57:52 +0100
Message-Id: <20210115215752.389656-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Set the acpi_device pointer which acpi_bus_get_device()
returns-by-reference to NULL on error.

We've recently had 2 cases where callers of acpi_bus_get_device()
did not properly error check the return value, using the
returned-by-reference acpi_device pointer blindly, set it to NULL
so that this will lead to an immediate oops, rather then following
a pointer to who knows what.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c575c9b67f76..c53e88deee1d 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -585,6 +585,8 @@ static int acpi_get_device_data(acpi_handle handle, struct acpi_device **device,
 	if (!device)
 		return -EINVAL;
 
+	*device = NULL;
+
 	status = acpi_get_data_full(handle, acpi_scan_drop_device,
 				    (void **)device, callback);
 	if (ACPI_FAILURE(status) || !*device) {
-- 
2.28.0

