Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1696216BEAE
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2020 11:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbgBYK2B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Feb 2020 05:28:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58968 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730126AbgBYK2B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Feb 2020 05:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582626480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ai+CrHnaWma5neew7/ejWRNh+dQMTJ1vxvQSu7J+LVU=;
        b=WB8MFswF3eOxvekRqsN5Z2CB+dcjlONz8c4KNu/T1vrvEezSwQlaeQp8i2ByGlGdiRMEcX
        KuJwaiwHJjAjAxKwbXuRR7TyIougIv7o1jhd0EfwHeWgUVkJ1LNztfbFaG/wAiNjfhtU5O
        jGFz7e8q8xJkvVo0SM8wgJ3427QqtGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-nn7-QsgAPPWuODtoZder3g-1; Tue, 25 Feb 2020 05:27:58 -0500
X-MC-Unique: nn7-QsgAPPWuODtoZder3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E93D9477;
        Tue, 25 Feb 2020 10:27:56 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.36.118.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BC8F1001902;
        Tue, 25 Feb 2020 10:27:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH resend 1/3] gpiolib: acpi: ignore-wakeup handling rework
Date:   Tue, 25 Feb 2020 11:27:50 +0100
Message-Id: <20200225102753.8351-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Since sending out the first 2 patches of this series I've received
positive testing feedback for the quirk for the HP X2 10 Cherry Trail +
AXP288 PMIC variant, so here is a resend of the first 2 patches with
a third patch adding a quirk for the third variant of HP X2 10 added.

Regards,

Hans


*) And more complex DMI quirk handling since now we would need to store
a string + some other flags in the DMI driver_data


