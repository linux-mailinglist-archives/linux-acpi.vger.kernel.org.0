Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB78310D9CE
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2019 19:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfK2S6p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Nov 2019 13:58:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48201 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726970AbfK2S6o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Nov 2019 13:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575053924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ndgZl1BU7Nm/41TrwrerRMnL4cbZ50j76RV/soO6yek=;
        b=cOITZ4l6fabF+W/+UoxLuDCMH1N0ZVr2MXNViNRVQ73d03K7uH2OdmdTm7VeZksNLK88Fr
        uKF268xTgAA8Mklv31F8wYCzqSGSRnIfCye9xG3rP0cmTqFBYg6v7LIN1GGLA13wOrBiRJ
        Lhgk6ijtTux4mL1cc8drYiI8+7Tu6AY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-TNtv4G4MO_W624z8NTgYgg-1; Fri, 29 Nov 2019 13:58:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6B49800D53;
        Fri, 29 Nov 2019 18:58:40 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 520F410013D9;
        Fri, 29 Nov 2019 18:58:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/2] drm/i915/vlv_dsi: Control panel and backlight enable GPIOs on BYT
Date:   Fri, 29 Nov 2019 19:58:34 +0100
Message-Id: <20191129185836.2789-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: TNtv4G4MO_W624z8NTgYgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On Bay Trail devices the MIPI power on/off sequences for DSI LCD panels
do not control the LCD panel- and backlight-enable GPIOs. So far, when
the VBT indicates we should use the SoC for backlight control, we have
been relying on these GPIOs being configured as output and driven high by
the Video BIOS (GOP) when it initializes the panel.

This does not work when the device is booted with a HDMI monitor connected
as then the GOP will initialize the HDMI instead of the panel, leaving the
panel black, even though the i915 driver tries to output an image to it.

Likewise on some device-models when the GOP does not initialize the DSI
panel it also leaves the mux of the PWM0 pin in generic GPIO mode instead
of muxing it to the PWM controller.

This series contains 2 patches which together fix this.

To avoid new errors in the intel-gfx CI (assuming there is atleast 1
BYT device there with a DSI panel), we need both of these patches to
be merged through the drm-intel tree.

Unfortunately there is some churn currently going on in the
pinctrl-baytrail.c code, but not in the part of the file which this
touches, so merging the pinctrl-baytrail.c changes through the
drm-intel tree should not lead to conflicts later.

Andy, Mika, assuming you are happy with the changes, can I get your ack
for merging the pinctrl-baytrail patch throught the drm-inteol tree?

Regards,

Hans

