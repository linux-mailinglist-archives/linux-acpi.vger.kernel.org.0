Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783A4262D49
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Sep 2020 12:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgIIKeR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Sep 2020 06:34:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45596 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729911AbgIIKcu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2020 06:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599647568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3NTL4uALNQDmLnKmP1H6DunP86pF+fpS5aGDoazOurI=;
        b=eo9OrW7T7VPg17oYDZu2vriTMFPXKp6NdPxiA26HyMXt4rBaRY3/6x4R3oVSQU8THjNQ43
        t2vE5nfL/cPsjJMBKfGR6klrElKfXq8rnys7hMYbgrv7+2nV+DRk6XHS6r7yujFuwHlk5/
        XEkv1LFg5sXr7cD0It5J5v2FeAvYK3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-xddZmv_JNFWmemk4a4u72Q-1; Wed, 09 Sep 2020 06:32:46 -0400
X-MC-Unique: xddZmv_JNFWmemk4a4u72Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84A9D8B95A4;
        Wed,  9 Sep 2020 10:32:36 +0000 (UTC)
Received: from x1.localdomain (ovpn-113-72.ams2.redhat.com [10.36.113.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7B231001901;
        Wed,  9 Sep 2020 10:32:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] i2c: core: Call i2c_acpi_install_space_handler() before i2c_acpi_register_devices()
Date:   Wed,  9 Sep 2020 12:32:33 +0200
Message-Id: <20200909103233.58287-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some ACPI i2c-devices _STA method (which is used to detect if the device
is present) use autodetection code which probes which device is present
over i2c. This requires the I2C ACPI OpRegion handler to be registered
before we enumerate i2c-clients under the i2c-adapter.

This fixes the i2c touchpad on the Lenovo ThinkBook 14-IIL and
ThinkBook 15 IIL not getting an i2c-client instantiated and thus not
working.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1842039
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 5ec082e2039d..573b5da145d1 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1464,8 +1464,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	/* create pre-declared device nodes */
 	of_i2c_register_devices(adap);
-	i2c_acpi_register_devices(adap);
 	i2c_acpi_install_space_handler(adap);
+	i2c_acpi_register_devices(adap);
 
 	if (adap->nr < __i2c_first_dynamic_bus_num)
 		i2c_scan_static_board_info(adap);
-- 
2.28.0

