Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E326445939E
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Nov 2021 18:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhKVRIv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Nov 2021 12:08:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237306AbhKVRIu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Nov 2021 12:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637600743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cUC//gCwremMSm6kwFEU5MzAvtEDPiJEZuACeWICpUI=;
        b=B0nLya8zjIAW3WunmPq8MsCLi9lZI5fMOnKq8J9aZpBn2ZIbAM21OuTQxEKmqN4wuKdM8M
        Lq4goNIL0TB8AxZv7OngcRKPpcZbzXPAqffayxfDXfuV0lx8cyzCHZ5SEBW8/RrtevkvNz
        0h3PO57XSQ4/PQ3HL8bqgc7qS1hYPqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-11-I4iIRD-3NjC1Z953HOZd7Q-1; Mon, 22 Nov 2021 12:05:40 -0500
X-MC-Unique: I4iIRD-3NjC1Z953HOZd7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 910341B18BCE;
        Mon, 22 Nov 2021 17:05:38 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EB665D6D5;
        Mon, 22 Nov 2021 17:05:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v2 0/7] ACPI: acpi_device_override_status() changes
Date:   Mon, 22 Nov 2021 18:05:29 +0100
Message-Id: <20211122170536.7725-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

As requested here is a v2 of my series previously titled:
"ACPI: scan: Skip turning off some unused objects during scan"

Which was a regression fix series for the commit c10383e8ddf4
("ACPI: scan: Release PM resources blocked by unused objects")
change, but that has been reverted now. So as requested here is
a v2 changing the wording of various commit messages since these
changes are still useful to have regardless.

Patch 1/7 is a v2/resend of the "ACPI / x86: Drop PWM2 device on
Lenovo Yoga Book from always present table" patch. You requested
changing the commit message of this one a bit to make it sound
less like a regression fix (which it is not). But you already
have the previous version of this patch in your bleeding-edge
branch, with a "Cc: 5.1+ <stable@vger.kernel.org> # 5.1+"
added ?  So depending on which version you want you can either
skip this patch when applying this series, or replace it with
the version from this series.

Patches 2-4 are the main changes to make the always_present
quirk handling more flexible, changing it into a status_override
mechanism + adding a quirk for the GPD win and pocket to fix
an issue with those in a more elegant matter then the current
kludge in the sdhci-acpi code.

Patch 5 is an unrelated patch which touches the override-status
quirk table, so it needed to be rebased and I decided to add it
to this series to make it clear that its v2 needs to be applied
on top of the other ACPI changes from this series.

Patches 6+7 cleanup the sdhci-acpi code, removing the now no
longer needed ugly kludge for the GPD win/pocket. These can
be merged independently from patches 1-5, through the mmc
tree, as long as they get send to Linus during the same
kernel cycle as the ACPI bits.

Regards,

Hans


Hans de Goede (7):
  ACPI / x86: Drop PWM2 device on Lenovo Yoga Book from always present
    table
  ACPI: Change acpi_device_always_present() into
    acpi_device_override_status()
  ACPI / x86: Allow specifying acpi_device_override_status() quirks by
    path
  ACPI / x86: Add not-present quirk for the PCI0.SDHB.BRC1 device on the
    GPD win
  ACPI / x86: Add PWM2 on the Xiaomi Mi Pad 2 to the always_present list
  mmc: sdhci-acpi: Remove special handling for GPD win/pocket devices
  mmc: sdhci-acpi: Use the new soc_intel_is_byt() helper

 drivers/acpi/bus.c            |   4 +-
 drivers/acpi/x86/utils.c      | 122 +++++++++++++++++++++++-----------
 drivers/mmc/host/sdhci-acpi.c |  78 ++--------------------
 include/acpi/acpi_bus.h       |   5 +-
 4 files changed, 96 insertions(+), 113 deletions(-)

-- 
2.33.1

