Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC6D169859
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Feb 2020 16:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgBWPSf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 23 Feb 2020 10:18:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21296 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726208AbgBWPSf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Feb 2020 10:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582471114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YXSldU4rp7h4W4vTeJugaLuXIu5wGOGxej7iJwzQz/Y=;
        b=Sqf8wAQQg39lS0W68LXTLdoqqQK/WmqywDJqkyIsr0AOtwiYmWJycQmOmaoP/+7vNGJJIB
        IC0ukOOzz12GH2r/dsvDS8Ci1VV9/pci7efTZTDpdH+P4tpenxI7xYDSzOuNCjibJOsMkg
        dUoc1nuYK0QIpAHLjX7VlNOpN+vxanU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-lKDw3IOOO9O-kUDf_BzGSQ-1; Sun, 23 Feb 2020 10:18:32 -0500
X-MC-Unique: lKDw3IOOO9O-kUDf_BzGSQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 489D2107ACC7;
        Sun, 23 Feb 2020 15:18:31 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-116-120.ams2.redhat.com [10.36.116.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A664D398;
        Sun, 23 Feb 2020 15:18:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/2] gpiolib: acpi: ignore-wakeup handling rework
Date:   Sun, 23 Feb 2020 16:18:26 +0100
Message-Id: <20200223151828.311682-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

The first patch just updates the comment describing why we are ignoring
GPIO ACPI event wakeups on HP x2 10 models.

The second patch is more interesting, in the mean time I've learned their
are actually at least 3 variants of the HP x2 10, and the original quirk
only applies to the Cherry Trail with TI PMIC variant (and the original
DMI match only matches that model). We need a similar quirk for the
Bay Trail with AXP288 model, but there we only want to ignore the wakeups
for the GPIO ACPI event which is (ab)used for embedded-controller events
on this model while still honoring the wakeup flags on other pins.

I'm not 100% happy with the solution I've come up with to allow ignoring
events on a single pin. But this was the best KISS thing I could come up
with. Alternatives would involve string parsing (*), which I would rather
avoid. I'm very much open to alternatives for the current approach in the
second patch.

Regards,

Hans


*) And more complex DMI quirk handling since now we would need to store
a string + some other flags in the DMI driver_data

