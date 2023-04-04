Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3AC6D5EB7
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Apr 2023 13:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjDDLKj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Apr 2023 07:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjDDLKf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Apr 2023 07:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C78535A6
        for <linux-acpi@vger.kernel.org>; Tue,  4 Apr 2023 04:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680606567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uTfE11g2MzTKcMBMgjUrc6VUhqvCe3CPW1442IG2tA8=;
        b=RE5fXn0AMr+6X1DIhcfWrlO3UulEAQfur+75F6oIV3jF4FRCTVQeT4xG+07F4cMjf1S/Ij
        LXkLg3D2bDSeRnGypobMy5qxkvE3XniQJ9aHP3Y+P0zH/SqOtONxLkUoCGFvUytUtJ+nN/
        Rt6gw602UTXkC4Y4xdpcPJ/UD12ExAc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-CPzIzPUjO4ujAdpUfk1y9Q-1; Tue, 04 Apr 2023 07:03:05 -0400
X-MC-Unique: CPzIzPUjO4ujAdpUfk1y9Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C6983C16E81;
        Tue,  4 Apr 2023 11:03:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C94B400F4F;
        Tue,  4 Apr 2023 11:02:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Dadap <ddadap@nvidia.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/6] ACPI: video: Fix missing acpi_video# devices on some systems
Date:   Tue,  4 Apr 2023 13:02:45 +0200
Message-Id: <20230404110251.42449-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

Here is my v2 of this series, changes in v2:

- Add Mario's Reviewed-by to the series
- Fix typo in commit-message for 5/6
- Drop no longer used video_detect_force_none() in 6/6

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
 drivers/acpi/video_detect.c                   | 93 +++++++++----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 -
 include/acpi/video.h                          | 17 +++-
 4 files changed, 71 insertions(+), 96 deletions(-)

-- 
2.39.1

