Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72392569322
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jul 2022 22:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiGFUOW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jul 2022 16:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiGFUOV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jul 2022 16:14:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 456FF21B1
        for <linux-acpi@vger.kernel.org>; Wed,  6 Jul 2022 13:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657138459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xKByFhrdz0FMO64YyOLiea3OB/9UGtZHGsuegPeqVHY=;
        b=U4fUXKjH4/bYWqfYObZC31I/BCzMBuvYGvuyUmLDZ+uQtiQVlL6GxoFKgasnUbuKznYtrB
        78S0Z8pcElXQuGdHFpUvF6eB4X8mOdaqUiKJo0sBw7jJa725/ljUDhXibhMVB7ZyLL+you
        HsA3Ni/lr/9ncwfpwSiPEXzdOgZa+8s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-S_o2JskTNqOlo9N11vD17w-1; Wed, 06 Jul 2022 16:14:13 -0400
X-MC-Unique: S_o2JskTNqOlo9N11vD17w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A869C3801F69;
        Wed,  6 Jul 2022 20:14:12 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1545F1415121;
        Wed,  6 Jul 2022 20:14:10 +0000 (UTC)
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
Subject: [RFC v2 0/2] ACPI[CA]: fix ECDT EC probe ordering issues
Date:   Wed,  6 Jul 2022 22:14:08 +0200
Message-Id: <20220706201410.88244-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Here is v2 of my series fixing some ECDT EC probe ordering issues which
are causing issues om some laptops:

https://bugzilla.kernel.org/show_bug.cgi?id=214899

This is a RFC because fixing this requires some ACPICA changes which
obviously need to go upstream through the ACPICA project.

The problem this fixed is best described by the commit message of patch 2:

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

Regards,

Hans


Hans de Goede (2):
  ACPICA: Make address_space_handler Install and _REG execution 2
    separate steps
  ACPI: EC: fix ECDT probe ordering issues

 drivers/acpi/acpica/evxfregn.c | 32 +++++++++++++++++++------------
 drivers/acpi/ec.c              | 33 ++++++++++++++++++++++----------
 include/acpi/acpixf.h          | 35 +++++++++++++++++++++++++---------
 include/acpi/actypes.h         |  2 ++
 4 files changed, 71 insertions(+), 31 deletions(-)

-- 
2.36.0

