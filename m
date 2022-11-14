Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A01628317
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Nov 2022 15:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiKNOqc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Nov 2022 09:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKNOqb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2022 09:46:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9331E13
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2022 06:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668437107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vic4AEsqkKUSbUZgxs3KmSszKDMGFHmuqwykg+7qm3g=;
        b=MUkyccGC699Ry7dVlKm2TqWsVrSFPBSvO6xtdgkJcm6kSUpG+aw7PObeq5pB/txriQEhL3
        urGLnOTknhL1odS1wfv6SUc8HdRBYRvSwIYCZJAomFQrD2ZV16GMcgBhjS96Qmx0fesY/C
        gfAV/7ajst+k78snWJCB/blpFgcFlJg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-tHznKo5sNDS2Mo_HiRmFMw-1; Mon, 14 Nov 2022 09:45:05 -0500
X-MC-Unique: tHznKo5sNDS2Mo_HiRmFMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A8C387B2A2;
        Mon, 14 Nov 2022 14:45:05 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E39B51415134;
        Mon, 14 Nov 2022 14:45:02 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/7] ACPI: video: Prefer native over vendor + quirk updates
Date:   Mon, 14 Nov 2022 15:44:52 +0100
Message-Id: <20221114144459.455519-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael, et. al.,

As mentioned already in the RFC:

"""
Here is a second attempt at always registering only a single
/sys/class/backlight device per panel.

This first round of testing has shown that native works well even on
systems so old that the don't have acpi_video backlight control support.

This patch series makes native be preferred over vendor, which should
avoid the problems seen with the 6.1 changes before the fixes.
"""

The 2 base patches (last 2 patches of the series now) are unchanged from
the RFC. New is a bunch of video_detect DMI quirk updates, 3 small fixes to
existing quirks + 2 new quirks. 1 of the new quirks is necessary to avoid
a known regression with preferring native over vendor on 1 model,
the other DMI quirk is unrelated to the other changes.

This series applies on top of the platform-drivers-x86-v6.1-3 tag from:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/

So either you will need to merge that tag (or merge v6.1-rc5 from Linus)
before applying these patches, or I can merge this through my for-next
branch which already has these changes. Either way works for me.

Regards,

Hans


Hans de Goede (7):
  ACPI: video: Add a few bugtracker links to DMI quirks
  ACPI: video: Change GIGABYTE GB-BXBT-2807 quirk to force_none
  ACPI: video: Change Sony Vaio VPCEH3U1E quirk to force_native
  ACPI: video: Add force_vendor quirk for Sony Vaio PCG-FRV35
  ACPI: video: Add force_native quirk for Sony Vaio VPCY11S1E
  ACPI: video: Simplify __acpi_video_get_backlight_type()
  ACPI: video: Prefer native over vendor

 drivers/acpi/video_detect.c | 110 ++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 48 deletions(-)

-- 
2.37.3

