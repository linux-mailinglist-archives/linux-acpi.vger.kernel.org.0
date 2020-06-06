Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA031F0884
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jun 2020 22:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgFFU0L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 6 Jun 2020 16:26:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57684 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728350AbgFFU0K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Jun 2020 16:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591475169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xTqw3kVnB8v3sRhZ7VbObD+yMIguMk4i/LcXMpFqEhQ=;
        b=fYCEJ8TNEIRn6G4zjcU83mWLaAD9vhpb5OZJKeRlL7uRjp0sk1bPSD/P22OLe7crZ7vzV1
        TBZeWvOXenhjEanKPQGUGI9zzEpilQqoQMto4sNTGKTuIf4smj8tg1ZPQZGRpADtX2GPMu
        dHsID7iJOK9FwFneV3OG7SD1iuTfDGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-nzGiU4zhPGC6e83HQDwwyA-1; Sat, 06 Jun 2020 16:26:07 -0400
X-MC-Unique: nzGiU4zhPGC6e83HQDwwyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 900127BAC;
        Sat,  6 Jun 2020 20:26:05 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE3045C557;
        Sat,  6 Jun 2020 20:26:02 +0000 (UTC)
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
Subject: pwm/i915: Convert pwm-crc and i915 driver's PWM code to use the atomic PWM API
Date:   Sat,  6 Jun 2020 22:25:45 +0200
Message-Id: <20200606202601.48410-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

This patch series converts the i915 driver's cpde for controlling the
panel's backlight with an external PWM controller to use the atomic PWM API.

Initially the plan was for this series to consist of 2 parts:
1. convert the pwm-crc driver to support the atomic PWM API and
2. convert the i915 driver's PWM code to use the atomic PWM API.

But during testing I've found a number of bugs in the pwm-lpss and I
found that the acpi_lpss code needs some special handling because of
some ugliness found in most Cherry Trail DSDTs.

So now this series has grown somewhat large and consists of 4 parts:

1. acpi_lpss fixes workarounds for Cherry Trail DSTD nastiness
2. various fixes to the pwm-lpss driver
3. convert the pwm-crc driver to support the atomic PWM API and
4. convert the i915 driver's PWM code to use the atomic PWM API

So we need to discuss how to merge this (once it passes review).
Although the inter-dependencies are only runtime I still think we should
make sure that 1-3 are in the drm-intel-next-queued (dinq) tree before
merging the i915 changes. Both to make sure that the intel-gfx CI system
does not become unhappy and for bisecting reasons.

The involved acpi_lpss and pwm drivers do not see a whole lot of churn,
so we could just merge everything through dinq, or we could use immutable
branch and merge those into dinq.

So Rafael and Thierry, can I either get your Acked-by for directly merging
this into dinq, or can you provide an immutable branch with these patches?

This series has been tested (and re-tested after adding various bug-fixes)
extensively. It has been tested on the following devices:

-Asus T100TA		BYT + CRC-PMIC PWM
-Toshiba WT8-A		BYT + CRC-PMIC PWM
-Thundersoft TS178	BYT + CRC-PMIC PWM, inverse PWM
-Asus T100HA		CHT + CRC-PMIC PWM
-Terra Pad 1061		BYT + LPSS PWM
-Trekstor Twin 10.1	BYT + LPSS PWM
-Asus T101HA		CHT + CRC-PMIC PWM
-GPD Pocket		CHT + CRC-PMIC PWM

Regards,

Hans

