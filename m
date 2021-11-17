Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D21455011
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Nov 2021 23:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240876AbhKQWEh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 17:04:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240833AbhKQWEd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Nov 2021 17:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637186494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/7lUdT9Jc2F/pU7MWjZrV8GN5DxfN3+AZDDrymQB/Lg=;
        b=PmEQBFhFRSvuj/kSoYJbLHBpTkMdIw2Vk0Sg07odsiv1OMZka/fXwvrNTF2tJJJ1EIO9/h
        V1wy2zGr81aO7Ewfr55gQ8dSwuqkAXy0HfrnQu9vdmHnU3dMkXyEkj7v7cQE8rUgHzvVC3
        /sAIQzCTPs5BzykH999xfOc5FENBmzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-xf6mkB1XOg-xeA3QOcpHGA-1; Wed, 17 Nov 2021 17:01:28 -0500
X-MC-Unique: xf6mkB1XOg-xeA3QOcpHGA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10AB6100CCC3;
        Wed, 17 Nov 2021 22:01:27 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07F055D9DE;
        Wed, 17 Nov 2021 22:01:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 5.16 regression fix 0/5] ACPI: scan: Skip turning off some unused objects during scan
Date:   Wed, 17 Nov 2021 23:01:13 +0100
Message-Id: <20211117220118.408953-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Commit c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by
unused objects") adds a:

	bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);

call to acpi_scan_init(). On some devices with buggy DSDTs calling
_PS3 for one device may result in it turning off another device.

Specifically the DSDT of the GPD win and GPD pocket devices has a
"\\_SB_.PCI0.SDHB.BRC1" device for a non existing SDIO wifi module
which _PS3 method sets a GPIO causing the PCI wifi card to turn off.

I've an earlier, in some ways simpler, fix for this here:
https://fedorapeople.org/~jwrdegoede/0001-ACPI-scan-Skip-turning-off-some-unused-objects-durin.patch

But the sdhci-acpi.c MMC host code already has an older workaround
for it to not toggle power on this broken ACPI object; and this
simpler fix would require keeping that workaround. So then we would
have 2 workarounds for the same issue in the kernel.

Thus instead I've come up with a slightly different approach which
IMHO has ended up pretty well.

Patches 1-3 of this series are this different approach and assuming
they are considered ok must be merged into 5.16 to fix the regression
caused by commit c10383e8ddf4 on these devices.

Patch 4 removes the now no longer necessary workaround for the same
issue from the sdhci-acpi.c code. Once 1-3 are merged this could
also go to 5.16 but 5.17 is fine too.

Patch 5 is a small bonus cleanup to the sdhci-acpi.c code.

Regards,

Hans


Hans de Goede (5):
  ACPI: Change acpi_device_always_present() into
    acpi_device_override_status()
  ACPI: x86: Allow specifying acpi_device_override_status() quirks by
    path
  ACPI: x86: Add not-present quirk for the PCI0.SDHB.BRC1 device on the
    GPD win
  mmc: sdhci-acpi: Remove special handling for GPD win/pocket devices
  mmc: sdhci-acpi: Use the new soc_intel_is_byt() helper

 drivers/acpi/bus.c            |   4 +-
 drivers/acpi/x86/utils.c      | 114 ++++++++++++++++++++++++----------
 drivers/mmc/host/sdhci-acpi.c |  78 ++---------------------
 include/acpi/acpi_bus.h       |   5 +-
 4 files changed, 91 insertions(+), 110 deletions(-)

-- 
2.31.1

