Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FF53024B4
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 13:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbhAYMM6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 07:12:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727847AbhAYMMh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 07:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611576666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yx6+lqiN2xkCZw3IcAtJgEckwR55n0HSKE2EyvgHAjY=;
        b=Gv6hLj72XyD/iLQDZg32aoqVHIO+3AeKweTP1judoUF1u/liBiZ5T3BmTdYNdpUm1cqmFL
        Vci/MBd6zZMF1TkgcN1Sogm/uET/bOfqecsf9WkJosC/yfizT3j0c1NO86lHun9szXN6hM
        rxs9w9PL0yEx/8zxa3k3rq+ka4KRvts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-9iurb-apNpSBn2he3Jf9-A-1; Mon, 25 Jan 2021 07:00:03 -0500
X-MC-Unique: 9iurb-apNpSBn2he3Jf9-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26D28CE642;
        Mon, 25 Jan 2021 12:00:02 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-170.ams2.redhat.com [10.36.112.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 943AC60C64;
        Mon, 25 Jan 2021 12:00:00 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 1/2] ACPI: platform-profile: Drop const qualifier for cur_profile
Date:   Mon, 25 Jan 2021 12:59:56 +0100
Message-Id: <20210125115957.3292-2-hdegoede@redhat.com>
In-Reply-To: <20210125115957.3292-1-hdegoede@redhat.com>
References: <20210125115957.3292-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Drop the const qualifier from the static global cur_profile
pointer declaration.

This is a preparation patch for passing the cur_profile pointer as
parameter to the profile_get() and profile_set() callbacks so that
drivers dynamically allocating their driver-data struct, with their
platform_profile_handler struct embedded, can use this pointer to
get to their driver-data.

Note this also requires dropping the const from the pprof
platform_profile_register() function argument. Dropping this
const is not a problem, non of the queued up consumers of
platform_profile_register() actually pass in a const pointer.

Link: https://lore.kernel.org/linux-acpi/5e7a4d87-52ef-e487-9cc2-8e7094beaa08@redhat.com/
Link: https://lore.kernel.org/r/20210114073429.176462-2-jiaxun.yang@flygoat.com
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
[hdegoede@redhat.com: Also remove const from platform_profile_register()]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2 (Hans de Goede):
- Not only remove the const from the global cur_profile variable declaration,
  but also from the platform_profile_register() argument
- Reword commit message to match
---
 drivers/acpi/platform_profile.c  | 4 ++--
 include/linux/platform_profile.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 91be50a32cc8..f65c61db7921 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -9,7 +9,7 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-static const struct platform_profile_handler *cur_profile;
+static struct platform_profile_handler *cur_profile;
 static DEFINE_MUTEX(profile_lock);
 
 static const char * const profile_names[] = {
@@ -132,7 +132,7 @@ void platform_profile_notify(void)
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
 
-int platform_profile_register(const struct platform_profile_handler *pprof)
+int platform_profile_register(struct platform_profile_handler *pprof)
 {
 	int err;
 
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 3623d7108421..c797fdb3d91a 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -32,7 +32,7 @@ struct platform_profile_handler {
 	int (*profile_set)(enum platform_profile_option profile);
 };
 
-int platform_profile_register(const struct platform_profile_handler *pprof);
+int platform_profile_register(struct platform_profile_handler *pprof);
 int platform_profile_remove(void);
 void platform_profile_notify(void);
 
-- 
2.29.2

