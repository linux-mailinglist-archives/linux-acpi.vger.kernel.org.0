Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E211027DE
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 16:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfKSPS1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 10:18:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23618 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726637AbfKSPS0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Nov 2019 10:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574176705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=W44n0jnAWgfO1rcmYb1hXUHI1Cvs6LKx+Od1R8CiNaI=;
        b=WJhPoksoZr/4euaFUBfGc/1pQIxgjkeeEwiM2HBLdQmfVxVR4hMNPyKT/TlZPeMwJM7cT/
        wc0THZPqIKxX/u5sx8TpMbyZxvuIOk7viP2pY+SCBIMG9PrpsFr7ZAM86GdjWs18Q0eoQ3
        VGwD1ZkdlLcqtueUienq83kJnRFIp4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-gj-aswoLMX2E5TPcRjr9sg-1; Tue, 19 Nov 2019 10:18:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F51C802520;
        Tue, 19 Nov 2019 15:18:22 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-49.ams2.redhat.com [10.36.117.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9F201001925;
        Tue, 19 Nov 2019 15:18:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm/i915 / LPSS / mfd: Select correct PWM controller to use based on VBT
Date:   Tue, 19 Nov 2019 16:18:15 +0100
Message-Id: <20191119151818.67531-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: gj-aswoLMX2E5TPcRjr9sg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

This series needs to be merged through a single tree, to keep things
bisectable. I have even considered just squashing all 3 patches into 1,
but having separate commits seems better, but that does lead to an
intermediate state where the backlight sysfs interface will be broken
(and fixed 2 commits later). See below for some background info.

The changes to drivers/acpi/acpi_lpss.c and drivers/mfd/intel_soc_pmic_core=
.c
are quite small and should not lead to any conflicts, so I believe that
it would be best to merge this entire series through the drm-intel tree.

Lee, may I have your Acked-by for merging the mfd change through the
drm-intel tree?

Rafael, may I have your Acked-by for merging the acpi_lpss change through t=
he
drm-intel tree?

Regards,

Hans

p.s.

The promised background info:

We have this long standing issue where instead of looking in the i915
VBT (Video BIOS Table) to see if we should use the PWM block of the SoC
or of the PMIC to control the backlight of a DSI panel, we rely on
drivers/acpi/acpi_lpss.c and/or drivers/mfd/intel_soc_pmic_core.c
registering a pwm with the generic name of "pwm_backlight" and then the
i915 panel code does a pwm_get(dev, "pwm_backlight").

We have some heuristics in drivers/acpi/acpi_lpss.c to not register the
lookup if a Crystal Cove PMIC is presend and the mfd/intel_soc_pmic_core.c
code simply assumes that since there is a PMIC the PMIC PWM block will
be used. Basically we are winging it.

Recently I've learned about 2 different BYT devices:
Point of View MOBII TAB-P800W
Acer Switch 10 SW5-012

Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
PWM controller (and the VBT correctly indicates this), so here our old
heuristics fail.

This series renams the PWM lookups registered by the LPSS /
intel_soc_pmic_core.c code from "pwm_backlight" to "pwm_soc_backlight" resp=
.
"pwm_pmic_backlight" and in the LPSS case also dropping the heuristics when
to register the lookup. This combined with teaching the i915 panel to call
pwm_get for the right lookup-name depending on the VBT bits resolves this.

