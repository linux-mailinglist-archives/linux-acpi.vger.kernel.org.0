Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE0C5F3214
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Oct 2022 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJCOm2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Oct 2022 10:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJCOm0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Oct 2022 10:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2D82B24E
        for <linux-acpi@vger.kernel.org>; Mon,  3 Oct 2022 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664808143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1h8g9qB3gz0zMn7qMffHdzJuHFBDrVjdCogLrPH8nr0=;
        b=cPVeW6D71247tTozRQ47gl0Bsw9tP0FSRg3MY2oTpvOo4mZPag0SqyjZuJPM1TK06SihP2
        WgGO3eJyZiTErNRmy9kLc7L8MwZ1fZnm5NDSiPkeAywBVy9F02lF2KxrUOGtFfVZubA21g
        GKTg+YO2pPyJCVqhB0JpMLqQC1/W62w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-NH9Pl9UBOk2MK_6STUq5hA-1; Mon, 03 Oct 2022 10:42:18 -0400
X-MC-Unique: NH9Pl9UBOk2MK_6STUq5hA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 296BA185A794;
        Mon,  3 Oct 2022 14:42:18 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D22840C206B;
        Mon,  3 Oct 2022 14:42:15 +0000 (UTC)
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
Subject: [RFC v3 0/4] ACPI[CA]: fix ECDT EC probe ordering issues
Date:   Mon,  3 Oct 2022 16:42:10 +0200
Message-Id: <20221003144214.345279-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Here is v3 of my series fixing some ECDT EC probe ordering issues which
are causing issues om some laptops:

https://bugzilla.kernel.org/show_bug.cgi?id=214899

This is a RFC because fixing this requires some ACPICA changes which
obviously need to go upstream through the ACPICA project:
https://github.com/acpica/acpica/pull/786

The problem this fixed is best described by the commit message of patch 4:

ACPI-2.0 says that the EC OpRegion handler must be available immediately
(like the standard default OpRegion handlers):

Quoting from the ACPI spec version 6.3: "6.5.4 _REG (Region) ...
2. OSPM must make Embedded Controller operation regions, accessed via
the Embedded Controllers described in ECDT, available before executing
any control method. These operation regions may become inaccessible
after OSPM runs _REG(EmbeddedControl, 0)."

So acpi_bus_init() calls acpi_ec_ecdt_probe(), which calls
acpi_install_address_space_handler() to install the EC's OpRegion
handler, early on.

This not only installs the OpRegion handler, but also calls the EC's
_REG method. The _REG method call is a problem because it may rely on
initialization done by the _INI methods of one of the PCI / _SB root devs,
see for example: https://bugzilla.kernel.org/show_bug.cgi?id=214899 .

Generally speaking _REG methods are executed when the ACPI-device they
are part of has a driver bound to it. Where as _INI methods must be
executed at table load time (according to the spec). The problem here
is that the early acpi_install_address_space_handler() call causes
the _REG handler to run too early.

To allow fixing this the ACPICA code now allows to split the OpRegion
handler installation and the executing of _REG into 2 separate steps.

This commit uses this ACPICA functionality to fix the EC probe ordering
by delaying the executing of _REG for ECDT described ECs till the matching
EC device in the DSDT gets parsed and acpi_ec_add() for it gets called.
This moves the calling of _REG for the EC on devices with an ECDT to
the same point in time where it is called on devices without an ECDT table.

Changes in v3:
- Add a prep patch to fix an indentation issue in Linux' acpixf.h to fix
  the patch from ACPICA's script not applying
- Add 2 new functions to ACPICA for this instead of a flags argument
  1. acpi_install_address_space_handler_no_reg()
  2. acpi_execute_reg_methods()
- Add a patch to fix EC handler removal in the ECDT case

From my pov this series is ready for merging once the ACPICA changes
are accepted.

Regards,

Hans


Hans de Goede (4):
  ACPICA: include/acpi/acpixf.h: Fix indentation
  ACPICA: Allow address_space_handler Install and _REG execution as 2
    separate steps
  ACPI: EC: Fix EC address space handler unregistration
  ACPI: EC: fix ECDT probe ordering issues

 drivers/acpi/acpica/evxfregn.c |  92 +++++++++++++++++++++--
 drivers/acpi/ec.c              |  32 +++++---
 drivers/acpi/internal.h        |   1 +
 include/acpi/acpixf.h          | 130 ++++++++++++++++++---------------
 4 files changed, 177 insertions(+), 78 deletions(-)

-- 
2.37.3

