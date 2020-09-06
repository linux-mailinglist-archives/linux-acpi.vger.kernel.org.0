Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C991B25EDC4
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Sep 2020 14:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgIFMVU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Sep 2020 08:21:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40317 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728832AbgIFMUo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Sep 2020 08:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599394824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CxJ/LRM65OR3AnlvatdcLfZCthNJRAPFXPEjZKd0JvU=;
        b=hJJ7fGo/wnRicoii3bR16q429FKQnQY1H5juYYqOlyvTlnXQQIw5/u2Ff/3nR1+nQMgcSo
        GAkdRF0ygFg1OtfbkEuLhOMU0bo2nyOKETDnkmyG5Ycux5EwPO/fJctyyjuyF+SkqVXC7p
        H/4YoI5Og5YpezpFR8ffTIvIJCjIDpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-qk1YH0sbOSuRfbWY_oxCYg-1; Sun, 06 Sep 2020 08:20:20 -0400
X-MC-Unique: qk1YH0sbOSuRfbWY_oxCYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CA481005E67;
        Sun,  6 Sep 2020 12:20:19 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-17.ams2.redhat.com [10.36.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DA945D9CC;
        Sun,  6 Sep 2020 12:20:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/1] Input: soc_button_array - Work around DSDTs which modify the irqflags
Date:   Sun,  6 Sep 2020 14:20:15 +0200
Message-Id: <20200906122016.4628-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Dmitry,

This patch is a bit of a kludge, but the problem it fixes has been
encountered on 2 different models now, so it seems that we really
need a workaround for this.

This patch applies on top of these 2 patches:

"Input: soc_button_array - Add active_low setting to soc_button_info"
"Input: soc_button_array - Add support for INT33D3 tablet-mode switch devices"

Which I have posted multiple times upstream already (they are from May!),
but these have not been getting any attention.

The soc_button_array code really is x86 specific glue code to translate
various incarnations of gpio-keys in ACPI tables to gpio_keys_platform_data.
As such I wonder if it would not be better to move this driver to
drivers/platform/x86?

I seem to be doing most if not all of the recent work on soc_button_array,
and soon I will be a co-maintainer of drivers/platform/x86. So having it
there and adding me in MAINTAINERS as maintaining it seems to be best?

If you want I can do a patch moving soc_button_array to drivers/platform/x86
and then add the other 3 patches on top and then we can merge all of this
through drivers/platform/x86?

Regards,

Hans

