Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAF1303197
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 03:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbhAYTK5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 14:10:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731618AbhAYTKq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611601757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+lWKLwxMgB8k9HPpVmv4K8bwd8xRT+dLD+7+TjXu/wY=;
        b=HqV/nEAUAQNkykF18T/fOCka++gU0sRc6sRYYhV2XmVjxNwyx/euJlu6rRehSanGFFwp53
        QQF873NS4JDwXEzC8v6ywcaPtUT0CUWjmUsWQEJb1O/ox7PXcf+i3h8muWFOB508ugY7gy
        SOzzeO138V+biSmDqX1Bj2nU5r/pHAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-Q4L7LbstMnitI2Si0bFjTQ-1; Mon, 25 Jan 2021 14:09:14 -0500
X-MC-Unique: Q4L7LbstMnitI2Si0bFjTQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8851F8066EA;
        Mon, 25 Jan 2021 19:09:13 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-56.ams2.redhat.com [10.36.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48D3E61D2E;
        Mon, 25 Jan 2021 19:09:12 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/1] ACPI: platform-profile: Fix possible deadlock in platform_profile_remove()
Date:   Mon, 25 Jan 2021 20:09:09 +0100
Message-Id: <20210125190909.4384-2-hdegoede@redhat.com>
In-Reply-To: <20210125190909.4384-1-hdegoede@redhat.com>
References: <20210125190909.4384-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After a rmmod thinkpad_acpi, lockdep pointed out this possible deadlock:

Our _show and _store sysfs attr functions get called with the kn->active
lock held for the sysfs attr and then take the profile_lock.
sysfs_remove_group() also takes the kn->active lock for the sysfs attr,
so if we call it with the profile_lock held, then we get an ABBA deadlock.

platform_profile_remove() must only be called by drivers which have
first *successfully* called platform_profile_register(). Anything else
is a driver bug. So the check for cur_profile being set before calling
sysfs_remove_group() is not necessary and it can be dropped.

It is safe to call sysfs_remove_group() without holding the profile_lock
since the attr-group group cannot be re-added until after we clear
cur_profile.

Change platform_profile_remove() to only hold the profile_lock while
clearing the cur_profile, fixing the deadlock.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/platform_profile.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 80e9df427eb8..4a59c5993bde 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -164,13 +164,9 @@ EXPORT_SYMBOL_GPL(platform_profile_register);
 
 int platform_profile_remove(void)
 {
-	mutex_lock(&profile_lock);
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
-	}
-
 	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+
+	mutex_lock(&profile_lock);
 	cur_profile = NULL;
 	mutex_unlock(&profile_lock);
 	return 0;
-- 
2.29.2

