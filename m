Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF817744B7
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Aug 2023 20:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjHHS10 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 14:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbjHHS1H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 14:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C965022AC5
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691516412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=p2P7o3SWFMhac7R/CmLbPa6CJ+KlwYU2q6QemqG6buQ=;
        b=BVNsAoaQJyxWfdDfmAfGe4gB8QeGaZ42E+wiKYdyJqZclzTSuhq8D1OlJyILZMNvgTPqkY
        EuNwlVqVQeqBlv/vPsg4yggx7/uH91vfJoDUaoTnVwFdRF+Zy+cFmTS6y4p7BhCVkbxxjN
        c39UqJ1KccYZtMKNu2G8gWoqNmp8YLA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-ybtwm-viNvyK3DQ0cKNvFw-1; Tue, 08 Aug 2023 06:33:45 -0400
X-MC-Unique: ybtwm-viNvyK3DQ0cKNvFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 359288564F0;
        Tue,  8 Aug 2023 10:33:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CD9840C2076;
        Tue,  8 Aug 2023 10:33:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 0/3] ACPI: resource: Fix regressions from "Remove "Zen" specific match and quirks"
Date:   Tue,  8 Aug 2023 12:33:32 +0200
Message-ID: <20230808103335.95339-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

As discussed here in the v1 thread:
https://lore.kernel.org/linux-acpi/20230806151453.10690-1-hdegoede@redhat.com/

Here is a v2 which adds a few fixes on top of the revert
to avoid the revert causing regressions on AMD Zen systems
where dropping the special Zen behavior was known to fix
things.

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
  ACPI: resource: Always use MADT override IRQ settings for GSI != 1
  ACPI: resource: Honor MADT INT_SRC_OVR settings for IRQ1 on AMD Zen

 arch/x86/include/asm/acpi.h |  1 +
 arch/x86/kernel/acpi/boot.c |  4 +++
 drivers/acpi/resource.c     | 52 +++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

-- 
2.41.0

