Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B4F2BC212
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 21:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgKUUa6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 Nov 2020 15:30:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20214 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728511AbgKUUa5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 21 Nov 2020 15:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605990656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fep8DCqOArUWxlXgL6bYOBw/BAGxDrrFI4it7tfDd1Y=;
        b=ge+90bAEOTKkCL1djAkAoJN2jn0yKqeGjC44v2tFwXZiDqhsF7szB/VxuFCIOQt2Wr2N7P
        A2anuuw5RmD/uQ1ac0MvCpOiRGzCnXAov3wXmqRSdfz9CL6BDzrDatm6L7G1Ig2wv9soaQ
        UutLQxFmNL+EtJgykMMJKBLRvIyjGMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-4MKHtsUOPU60XzWs0JKAyA-1; Sat, 21 Nov 2020 15:30:54 -0500
X-MC-Unique: 4MKHtsUOPU60XzWs0JKAyA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40B6B1005D65;
        Sat, 21 Nov 2020 20:30:53 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EFC01C959;
        Sat, 21 Nov 2020 20:30:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 7/7] ACPI: scan: Add some HIDs which are never bound on Cherry Trail devices to acpi_ignore_dep_hids
Date:   Sat, 21 Nov 2020 21:30:40 +0100
Message-Id: <20201121203040.146252-8-hdegoede@redhat.com>
In-Reply-To: <20201121203040.146252-1-hdegoede@redhat.com>
References: <20201121203040.146252-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add some HIDs which are found on Cherry Trail devices and which
Linux never bounds to acpi_ignore_dep_hids. This allows all root
level ACPI devices to be instantiated during step one of scanning
the ACPI root.

Note this is not strictly necessary, at least not on the one
Cherry Trail device this has been tested on so far.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 44001610f6a4..218a6e9e560e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -759,6 +759,8 @@ static bool acpi_info_matches_hids(struct acpi_device_info *info,
 /* List of HIDs for which we ignore matching ACPI devices, when checking _DEP lists. */
 static const char * const acpi_ignore_dep_hids[] = {
 	"INT3396", /* Windows System Power Management Controller */
+	"INT33A4", /* Windows System Power Management Controller */
+	"INT33BD", /* Intel Baytrail Mailbox Device */
 	NULL
 };
 
-- 
2.28.0

