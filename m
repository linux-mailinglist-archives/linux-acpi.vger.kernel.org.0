Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860F430ACB9
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 17:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhBAQfx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 11:35:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230055AbhBAQfw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 11:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612197265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wEqPXcgm5ocMR+3QesxkVD02pYDJl75FzS8y1W/fhns=;
        b=QszDMbKMpuTHdvIfhK5Uw4Dr3iKca8amxRyqmsBMf9bvpnKyT0m2BHhNohlcDitxxfDJro
        +BPpuzvQWIrYOIV/sd3Aj3u8DvGL+T43aL5gGbtD2rr8UORcYVGWPltNwfmnBdrXN7Exaa
        cndDIJjYtjSSts9AHqP/P6q4VZ14nng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-y-LxIJNAM3S61KvwD6wgiA-1; Mon, 01 Feb 2021 11:34:23 -0500
X-MC-Unique: y-LxIJNAM3S61KvwD6wgiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 375DC1927800;
        Mon,  1 Feb 2021 16:34:22 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-234.ams2.redhat.com [10.36.112.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6984E10013C0;
        Mon,  1 Feb 2021 16:34:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 1/1] ACPI: scan: Fix Battery devices sometimes never binding
Date:   Mon,  1 Feb 2021 17:34:19 +0100
Message-Id: <20210201163419.396568-2-hdegoede@redhat.com>
In-Reply-To: <20210201163419.396568-1-hdegoede@redhat.com>
References: <20210201163419.396568-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

With the new 2 step scanning process, which defers instantiating some
ACPI-devices based on their _DEP to the second step, the following may
happen:

1. During the first acpi_walk_namespace(acpi_bus_check_add) call
   acpi_scan_check_dep() gets called on the Battery ACPI dev handle and
   adds one or more deps for this handle to the acpi_dep_list

2. During the first acpi_bus_attach() call one or more of the suppliers of
   these deps get their driver attached and
   acpi_walk_dep_device_list(supplier_handle) gets called.

   At this point acpi_bus_get_device(dep->consumer) get called,
   but since the battery has DEPs it has not been instantiated during the
   first acpi_walk_namespace(acpi_bus_check_add), so the
   acpi_bus_get_device(dep->consumer) call fails.

   Before this commit, acpi_walk_dep_device_list() would now continue
   *without* removing the acpi_dep_data entry for this supplier,consumer
   pair from the acpi_dep_list.

3. During the second acpi_walk_namespace(acpi_bus_check_add) call
   an acpi_device gets instantiated for the battery and
   acpi_scan_dep_init() gets called to initialize its dep_unmet val.

   Before this commit, the dep_unmet count would include DEPs for
   suppliers for which acpi_walk_dep_device_list(supplier_handle)
   has already been called, so it will never become 0 and the
   ACPI battery driver will never get attached / bind.

Fix the ACPI battery driver never binding in this scenario by making
acpi_walk_dep_device_list() always remove matching acpi_dep_data
entries independent of the acpi_bus_get_device(dep->consumer) call
succeeding or not.

Fixes: 71da201f38df ("ACPI: scan: Defer enumeration of devices with _DEP lists")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5d7b2fcecf06..4ce54115e981 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2123,12 +2123,12 @@ void acpi_walk_dep_device_list(acpi_handle handle)
 	list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
 		if (dep->supplier == handle) {
 			acpi_bus_get_device(dep->consumer, &adev);
-			if (!adev)
-				continue;
 
-			adev->dep_unmet--;
-			if (!adev->dep_unmet)
-				acpi_bus_attach(adev, true);
+			if (adev) {
+				adev->dep_unmet--;
+				if (!adev->dep_unmet)
+					acpi_bus_attach(adev, true);
+			}
 
 			list_del(&dep->node);
 			kfree(dep);
-- 
2.29.2

