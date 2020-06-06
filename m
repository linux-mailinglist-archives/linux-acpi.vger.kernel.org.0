Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A8B1F08BF
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jun 2020 22:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgFFU0x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 6 Jun 2020 16:26:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23367 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728902AbgFFU0x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Jun 2020 16:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591475212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aD0U0nj+eoOBxkRm+vQR3prqd59NNlNzFOHiBlv90gk=;
        b=fgo6WcW5dom83lEdkH9xeWhNJe3bxctAXrLr93psmUd/cDgQzEFhxKT97i6OOxk8Oh2w3M
        o9bnQGVo05GjQLQjBstjRvBT9fdjkwdN0f3SKVAC960uBO2ioVQO9bpGHv5nTu7ixaWXcf
        cA2laD6h/8zE93qb6HwjnQBWF3sVbOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-fpOpA4wpOf-_5mPxHzuyXg-1; Sat, 06 Jun 2020 16:26:48 -0400
X-MC-Unique: fpOpA4wpOf-_5mPxHzuyXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06F70835B40;
        Sat,  6 Jun 2020 20:26:47 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8ED5A5C557;
        Sat,  6 Jun 2020 20:26:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 15/16] drm/i915: panel: Honor the VBT PWM min setting for devs with an external PWM controller
Date:   Sat,  6 Jun 2020 22:26:00 +0200
Message-Id: <20200606202601.48410-16-hdegoede@redhat.com>
In-Reply-To: <20200606202601.48410-1-hdegoede@redhat.com>
References: <20200606202601.48410-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

So far for devices using an external PWM controller (devices using
pwm_setup_backlight()), we have been hardcoding the minimum allowed
PWM level to 0. But several of these devices specify a non 0 minimum
setting in their VBT.

Change pwm_setup_backlight() to use get_backlight_min_vbt() to get
the minimum level.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_panel.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 14e611c92194..cb28b9908ca4 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -1925,8 +1925,8 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 	 */
 	pwm_apply_args(panel->backlight.pwm);
 
-	panel->backlight.min = 0; /* 0% */
 	panel->backlight.max = 100; /* 100% */
+	panel->backlight.min = get_backlight_min_vbt(connector);
 	level = intel_panel_compute_brightness(connector, 100);
 	ns = DIV_ROUND_UP(level * panel->backlight.pwm_period_ns, 100);
 
@@ -1941,8 +1941,9 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 
 	level = DIV_ROUND_UP(pwm_get_duty_cycle(panel->backlight.pwm) * 100,
 			     panel->backlight.pwm_period_ns);
-	panel->backlight.level =
-		intel_panel_compute_brightness(connector, level);
+	level = intel_panel_compute_brightness(connector, level);
+	panel->backlight.level = clamp(level, panel->backlight.min,
+				       panel->backlight.max);
 	panel->backlight.enabled = panel->backlight.level != 0;
 
 	drm_info(&dev_priv->drm, "Using %s PWM for LCD backlight control\n",
-- 
2.26.2

