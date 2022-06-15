Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF2F54D22A
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jun 2022 21:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350416AbiFOT4z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jun 2022 15:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345218AbiFOT4z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2022 15:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AD733120C
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2022 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655323013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dqArTaCGaVZk6IGWHgnbE9TdxFOxfCQSKVeIV7IJhKo=;
        b=QkgZnA7IZ8FiUv4pu7h1kpeI8vPtnBxW/7M02UVOxoyFdjcPmRceqexJeY0tc9M2BRx8mF
        abyAI20tEs1b7/TWI0X0LGE4ujgu+l8wb0SNyt0AnFagNojMj5TyV2EZnFE+TEGdOsh8Af
        zfAXPdWQhZtU3FVkth2JiJTcVJNCEFI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-tUYurTs-MViGj1ap1fWo5g-1; Wed, 15 Jun 2022 15:56:52 -0400
X-MC-Unique: tUYurTs-MViGj1ap1fWo5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E5D11C14487;
        Wed, 15 Jun 2022 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF7652026D64;
        Wed, 15 Jun 2022 19:56:48 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>, kai.heng.feng@canonical.com,
        =?UTF-8?q?Johannes=20Pen=C3=9Fel?= <johannespenssel@posteo.net>,
        linux-acpi@vger.kernel.org, devel@acpica.org
Subject: [RFC 0/4] ACPI[CA]: fix ECDT EC probe ordering issues
Date:   Wed, 15 Jun 2022 21:56:39 +0200
Message-Id: <20220615195643.12608-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

This series fixes some ECDT EC probe ordering issues which are causing
issues om some laptops:

https://bugzilla.kernel.org/show_bug.cgi?id=214899
https://bugzilla.redhat.com/show_bug.cgi?id=1842039

This is a RFC because fixing this requires some ACPICA changes which
obviously need to go upstream through the ACPICA project. But first
I wanted to try and get some general feedback on the chosen approach.

The problem this fixed is best described by the commit message of patch 4:

ACPI-2.0 says that the EC OpRegion handler must be available immediately
(like the standard default OpRegion handlers). So acpi_bus_init() calls
acpi_ec_ecdt_probe(), which calls acpi_install_address_space_handler() to
install the EC's OpRegion handler, early on.

This not only installs the OpRegion handler, but also calls the EC's
_REG method. The _REG method call is a problem because it may rely on
initialization done by the _INI methods of one of the PCI / _SB root devs,
see for example: https://bugzilla.kernel.org/show_bug.cgi?id=214899 .

This _REG depends on _INI problem can be fixed by calling the new ACPICA
acpi_early_initialize_objects() function before acpi_ec_ecdt_probe().

But on some boards (e.g. Lenovo X1C8) the root devices _INI method
relies on the EC OpRegion so executing the _INI methods before
registering the EC OpRegion handler leads to errors there.

To allow fixing this the ACPICA code now allows to do the OpRegion handler
installation early on (without calling _REG) and to do the EC's _REG
execution later on as a separate step.

This commit uses this new ACPICA functions to fix the EC probe ordering
by changing the acpi_bus_init() initialization order to this:

1. acpi_load_tables()
2. acpi_ec_ecdt_probe()
   This now calls acpi_install_address_space_handler(ACPI_NO_EXEC__REG)
   which installs the OpRegion handler without executing _REG
3. acpi_enable_subsystem()
4. acpi_early_initialize_objects()
   This calls the _INI method of the PCI and _SB root devices
5. acpi_ec_ecdt_exec_reg();
   This executes the EC's _REG now that the root devices _INI has run
6. acpi_initialize_objects(ACPI_NO_EARLY_DEVICE_INIT)

This allows the EC's _REG method to depend on e.g. the \OSYS global/GVNS
variable often set by a root-device's _INI method, while at the same time
allowing these _INI methods to access EmbeddedController OpRegions.

Regards,

Hans


Hans de Goede (4):
  ACPICA: Add an acpi_early_initialize_objects() helper
  ACPICA: Add \_SB.PC00, \SB.PCI0 to acpi_ns_early_initialize_devices()
  ACPICA: Make address-space-handler install and _REG execution 2
    separate steps
  ACPI: fix ECDT EC probe ordering issues

 drivers/acpi/acpica/acnamesp.h |   2 +
 drivers/acpi/acpica/evxfregn.c |  32 ++++---
 drivers/acpi/acpica/nsinit.c   | 170 ++++++++++++++++++++-------------
 drivers/acpi/acpica/utxfinit.c |  21 ++++
 drivers/acpi/bus.c             |  19 +++-
 drivers/acpi/ec.c              |  38 ++++++--
 drivers/acpi/internal.h        |   1 +
 include/acpi/acpixf.h          |  35 +++++--
 include/acpi/actypes.h         |   5 +-
 9 files changed, 223 insertions(+), 100 deletions(-)

-- 
2.36.0

