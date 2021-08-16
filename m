Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231A13ED314
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 13:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhHPLbL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 07:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235976AbhHPLbL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Aug 2021 07:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629113439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FI/eHQB74IQIC2qpQ/Xncvk17iFUa0PElL4kPSDcR0s=;
        b=jCA1jXo4vBhhdP6gXbSNvuVeTueQgzfFAeA5WxC8ekC7HYgOfPAl1AAd3ECbkjpZaZQL3J
        LaPdXTCSoREOhH9lGFd6LAZ86VQ73rPJpy3BXKC7lRJlgqqERWYachty7cBk5wfqgF6GkK
        y3Zg9ABSzNeLinR8lpQbthJQkkOJ5VU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-PGUG3SmDMPepkt_pKqkB6w-1; Mon, 16 Aug 2021 07:30:38 -0400
X-MC-Unique: PGUG3SmDMPepkt_pKqkB6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB5CD1853028;
        Mon, 16 Aug 2021 11:30:36 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.194.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9E7D6E0B7;
        Mon, 16 Aug 2021 11:30:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        "Luke D . Jones" <luke@ljones.dev>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] ACPI: platform-profile: call sysfs_notify() from platform_profile_store()
Date:   Mon, 16 Aug 2021 13:30:07 +0200
Message-Id: <20210816113007.88902-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Drivers like thinkpad_acpi and ideapad_laptop call the
platform_profile_notify() helper when the profile is changed by hardware
(the embedded-controller/EC) in response to an EC handled hotkey.

This allows userspace to monitor for such changes by polling for POLLPRI
on the platform_profile sysfs file. But the profile can also be changed
underneath a userspace program monitoring it by anonther userspace program
storing a new value.

Add a sysfs_notify() call to platform_profile_store(), so that userspace
programs monitoring for changes also get notified in this case.

Also update the documentation to document that POLLPRI polling can be
used to watch for changes.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/ABI/testing/sysfs-platform_profile | 7 +++++++
 drivers/acpi/platform_profile.c                  | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
index dae9c8941905..baf1d125f9f8 100644
--- a/Documentation/ABI/testing/sysfs-platform_profile
+++ b/Documentation/ABI/testing/sysfs-platform_profile
@@ -26,3 +26,10 @@ Contact:	Hans de Goede <hdegoede@redhat.com>
 Description:	Reading this file gives the current selected profile for this
 		device. Writing this file with one of the strings from
 		platform_profile_choices changes the profile to the new value.
+
+		This file can be monitored for changes by polling for POLLPRI,
+		POLLPRI will be signalled on any changes, independent of those
+		changes coming from a userspace write; or coming from another
+		source such as e.g. a hotkey triggered profile change handled
+		either directly by the embedded-controller or fully handled
+		inside the kernel.
diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index dd2fbf38e414..d418462ab791 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -106,6 +106,9 @@ static ssize_t platform_profile_store(struct device *dev,
 	}
 
 	err = cur_profile->profile_set(cur_profile, i);
+	if (!err)
+		sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	mutex_unlock(&profile_lock);
 	if (err)
 		return err;
-- 
2.31.1

