Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BAA7755EC
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjHII4U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 04:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHII4T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 04:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C501BD9
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 01:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691571331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/2PjITaeSdxtRPrGdc+5P3Y3zD6poJp+/qiayk+doTM=;
        b=aj4fx6+bKEwoi5SXvpZgcigS0pGcK0y5r72Is+A04cQ8UM9UUvtWdjlywMJleLWtK9DjZY
        HIlP7WIlpMf6FfTNa+Rf7Z7hRnxk81umnywEQyN7mZx7rbSTWzF+rgeiKSSrlgG4+hKAoi
        7sXIjayphLgtORzq0sOkfZ5HmAE+QJY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-2KCwoi-cPtaxAdU1GZb2kw-1; Wed, 09 Aug 2023 04:55:28 -0400
X-MC-Unique: 2KCwoi-cPtaxAdU1GZb2kw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C936D1C05AEC;
        Wed,  9 Aug 2023 08:55:27 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE9241121314;
        Wed,  9 Aug 2023 08:55:26 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        August Wikerfors <git@augustwikerfors.se>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 0/3] ACPI: resource: Fix regressions from "Remove "Zen" specific match and quirks"
Date:   Wed,  9 Aug 2023 10:55:22 +0200
Message-ID: <20230809085526.84913-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Here is v3 of my series to address the regressions wrt PS/2 IRQs
not working on AMD zen models.

Changes in v3:
- Add links to more bug reports caused by a9c4a912b7dc to the commitmsg
- Also do the ZEN check for IRQ 12 (Reported-by August Wikerfors)
- Move the gsi != 1 && gsi != 12 check to inside the #ifdef CONFIG_X86,
  these being the i8042 IRQs is X86 specific and the "return true;" is
  always done for #ifndef CONFIG_X86 already
- Make acpi_int_src_ovr an array which keep track of the status
  of all legacy IRQs and not just IRQ 1

Changes in v2:
- Add 2 patches on top of the revert to avoid the revert causing
  other models which are known to need the override to regress.

As discussed in the v1 thread:
https://lore.kernel.org/linux-acpi/20230806151453.10690-1-hdegoede@redhat.com/

This series adds a few fixes on top of the revert to avoid the revert
causing regressions on other AMD Zen systems where dropping the special
Zen behavior was known to fix things.

As also mentioned in the thread this is intended as a short term fix
for 6.4.y >= 6.4.7 and 6.5 to get all the systems which were working
fine before commit a9c4a912b7dc ("ACPI: resource: Remove "Zen"
specific match and quirks") to work again.

The long term plan is to see if we can read back what the BIOS
has actually programmed as IRQ trigger-type / polarity into
the IOAPIC.

Regards,

Hans

Hans de Goede (3):
  ACPI: resource: revert "Remove "Zen" specific match and quirks"
  ACPI: resource: Always use MADT override IRQ settings for all legacy
    non i8042 IRQs
  ACPI: resource: Honor MADT INT_SRC_OVR settings for IRQ1 on AMD Zen

 arch/x86/include/asm/acpi.h |  2 ++
 arch/x86/kernel/acpi/boot.c |  4 +++
 drivers/acpi/resource.c     | 52 +++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

-- 
2.41.0

