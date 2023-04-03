Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887876D4D17
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Apr 2023 18:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjDCQEx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Apr 2023 12:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjDCQEk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2023 12:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DFA2733
        for <linux-acpi@vger.kernel.org>; Mon,  3 Apr 2023 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680537825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Atv3FFKb34RmCZVgW82YChnrjyU6mprkqO4LnTKBjKU=;
        b=djPJEkwV3vBkpcH2TLFshaaoHqH2Ua+NFawuslzZsdSmU7+pqquiCYwxsXxTymunTrFzp2
        qdzjeqnyhzUlaqa7r2V2UvnOTJj7WRcpcjgnq1caXBbn203densjUacyZsW293iU8Pi5aN
        boty+lRAqtUgBmf7u0fw/3qfiBCrA8k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-UvvBpVz2MZyhqtQurvcRdA-1; Mon, 03 Apr 2023 12:03:42 -0400
X-MC-Unique: UvvBpVz2MZyhqtQurvcRdA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6B3D857F81;
        Mon,  3 Apr 2023 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCFDC2166B26;
        Mon,  3 Apr 2023 16:03:37 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Dadap <ddadap@nvidia.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/6] ACPI: video: Fix missing acpi_video# devices on some systems
Date:   Mon,  3 Apr 2023 18:03:23 +0200
Message-Id: <20230403160329.707176-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

This patch series consists of 2 parts:

1. Fix missing acpi_video# devices on some systems, currently in kernels
   >= 6.1.5 and >= 6.2.0 acpi_video# backlight class devices will only
   get registered (by default) when a GPU driver asks for this by calling
   acpi_video_register_backlight(). This is causing backlight control to
   be missing on some systems.

   Patches 1-4 fix this and ideally these should be send to Linus for
   an upcoming 6.3-rc# release.

2. Now that the dust has settled a bit on the backlight refactor we can
   do some further cleanups. This is done in patches 5 + 6. Note that
   patch 5 depends on patch 2.

Regards,

Hans


Hans de Goede (6):
  ACPI: video: Add auto_detect arg to __acpi_video_get_backlight_type()
  ACPI: video: Make acpi_backlight=video work independent from GPU
    driver
  ACPI: video: Add acpi_backlight=video quirk for Apple iMac14,1 and
    iMac14,2
  ACPI: video: Add acpi_backlight=video quirk for Lenovo ThinkPad W530
  ACPI: video: Remove register_backlight_delay module option and code
  ACPI: video: Remove desktops without backlight DMI quirks

 drivers/acpi/acpi_video.c                     | 53 +++--------
 drivers/acpi/video_detect.c                   | 87 ++++++++++---------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 -
 include/acpi/video.h                          | 17 +++-
 4 files changed, 71 insertions(+), 90 deletions(-)

-- 
2.39.1

