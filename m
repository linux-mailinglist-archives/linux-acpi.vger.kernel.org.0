Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC947303603
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 06:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbhAZF5g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 00:57:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727853AbhAYMOJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 07:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611576721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qFYGXPSLNwIoMSm+97j34GHslVZxB/S/yGvgs080vfg=;
        b=SUONJrzFpCTedPd48O1wM1OTd0xw2dzAFcRwj6PH9qsF173jKSlPS48dbBfh7vcqmU0p5P
        dKmqe57J9XESngvxmV+8QrsOcFLQEX6UlNNgGpHrDzGT3uFhOtanNmxDr37HHWy+eX+CKj
        NduMDNgNRLQN2R4RwVRhVBn3ThbNtXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-3CETjn75OdGqFRqkPGCJGA-1; Mon, 25 Jan 2021 07:00:32 -0500
X-MC-Unique: 3CETjn75OdGqFRqkPGCJGA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C752192203E;
        Mon, 25 Jan 2021 12:00:26 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-170.ams2.redhat.com [10.36.112.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DA3960C90;
        Mon, 25 Jan 2021 12:00:02 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 2/2] ACPI: platform-profile: Introduce object pointers to callbacks
Date:   Mon, 25 Jan 2021 12:59:57 +0100
Message-Id: <20210125115957.3292-3-hdegoede@redhat.com>
In-Reply-To: <20210125115957.3292-1-hdegoede@redhat.com>
References: <20210125115957.3292-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Add an object pointer to handler callbacks to avoid the need for
drivers to have a global variable to get to their driver-data
struct.

Link: https://lore.kernel.org/linux-acpi/6a29f338-d9e4-150c-81dd-2ffb54f5bc35@redhat.com/
Link: https://lore.kernel.org/r/20210114073429.176462-3-jiaxun.yang@flygoat.com
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2 (Hans de Goede):
- Tweak the commit message wording a bit
---
 drivers/acpi/platform_profile.c  | 4 ++--
 include/linux/platform_profile.h | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index f65c61db7921..80e9df427eb8 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -64,7 +64,7 @@ static ssize_t platform_profile_show(struct device *dev,
 		return -ENODEV;
 	}
 
-	err = cur_profile->profile_get(&profile);
+	err = cur_profile->profile_get(cur_profile, &profile);
 	mutex_unlock(&profile_lock);
 	if (err)
 		return err;
@@ -104,7 +104,7 @@ static ssize_t platform_profile_store(struct device *dev,
 		return -EOPNOTSUPP;
 	}
 
-	err = cur_profile->profile_set(i);
+	err = cur_profile->profile_set(cur_profile, i);
 	mutex_unlock(&profile_lock);
 	if (err)
 		return err;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index c797fdb3d91a..a26542d53058 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -28,8 +28,10 @@ enum platform_profile_option {
 
 struct platform_profile_handler {
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
-	int (*profile_get)(enum platform_profile_option *profile);
-	int (*profile_set)(enum platform_profile_option profile);
+	int (*profile_get)(struct platform_profile_handler *pprof,
+				enum platform_profile_option *profile);
+	int (*profile_set)(struct platform_profile_handler *pprof,
+				enum platform_profile_option profile);
 };
 
 int platform_profile_register(struct platform_profile_handler *pprof);
-- 
2.29.2

