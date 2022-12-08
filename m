Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346476471AC
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 15:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLHOZo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 09:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiLHOZX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 09:25:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7DA9E464
        for <linux-acpi@vger.kernel.org>; Thu,  8 Dec 2022 06:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670509424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oH/gedq6ig319Sz+Wxpq5wphHAjMRh/GHfbMJEprC9Q=;
        b=Ta3w31J58lvOsJfBVyUnEfhrXlS7ll+o/TlqTuO63MxEEzcB5FXC1ZbtR3ku8DAOYWnWb9
        u9OmKM9lFdEuI+ki4hWCtfEwVpYb8jAJuxtCE0NeUvsRLIoWvhnOK6MSplW/dBvMNvCNNs
        Mnpp6Nhotw+KyEf0qsRXeV3a/iETpM8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-pVtLDWsrPUyhxKYAFYW4Pw-1; Thu, 08 Dec 2022 09:23:40 -0500
X-MC-Unique: pVtLDWsrPUyhxKYAFYW4Pw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16990185A7A3;
        Thu,  8 Dec 2022 14:23:40 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F1D32024CC0;
        Thu,  8 Dec 2022 14:23:38 +0000 (UTC)
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
Subject: [PATCH 0/4] ACPI[CA]: fix ECDT EC probe ordering issues
Date:   Thu,  8 Dec 2022 15:23:31 +0100
Message-Id: <20221208142335.488382-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

As you requested in:
https://github.com/acpica/acpica/pull/786#issuecomment-1342632326

Here is a non RFC version of my series fixing some ECDT EC probe
ordering issues which are causing issues om some laptops:

https://bugzilla.kernel.org/show_bug.cgi?id=214899

including the ACPICA changes.

This series is rebased on top of linux-pm/bleeding-edge,
otherwise it is unchanged from the previous [RFC v3] version.

From the original cover-letter of the previous [RFC v3] version:

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
2.38.1

