Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ED261A33E
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Nov 2022 22:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKDVWR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Nov 2022 17:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiKDVWQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Nov 2022 17:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600E430F62
        for <linux-acpi@vger.kernel.org>; Fri,  4 Nov 2022 14:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667596873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pHt8weVKXTDRwYEHRsBpP4crU0LR1WYSvr/8+xQqqNI=;
        b=YvvyHq+awZU2CcOoAFzDJvw1gswLajqj8/LUMouP9CvL6Vi8aSo5eAUD+WsQLUnw7Xz/zf
        C9LiJf8T6c5RjB5bifmoqni1lPn/EtgX0VuCqC+jiZ04Wzuzznf8CQTolOeOeRiSZI6IL0
        lQR370CEBQcFwCTwJJJGOptC7rrz7Xs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74--KqdNOEQPI2Hz1ILPHYRog-1; Fri, 04 Nov 2022 17:21:12 -0400
X-MC-Unique: -KqdNOEQPI2Hz1ILPHYRog-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4343185A794;
        Fri,  4 Nov 2022 21:21:11 +0000 (UTC)
Received: from x1.nl (unknown [10.39.192.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 626232022EA2;
        Fri,  4 Nov 2022 21:21:10 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/3] ACPI: video: Fix backlight regressions in 6.1
Date:   Fri,  4 Nov 2022 22:21:05 +0100
Message-Id: <20221104212108.73537-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Here is a series of patches to fix known (and likely also unknown)
regressions caused by the backlight-detect refactor landing in 6.1.

This builds on top of the earlier Chromebook fix which went upstream
through platform-drivers-x86.git/fixes. as such I believe it would
be best for this series to go upstream through the pdx86 tree.

Can you please give your Ack for merging this through the pdx86
git tree?

Regards,

Hans


Hans de Goede (3):
  ACPI: video: Improve Chromebook checks
  ACPI: video: Make acpi_video_backlight_use_native() always return true
  ACPI: video: Add backlight=native DMI quirk for Dell G15 5515

 drivers/acpi/video_detect.c | 41 +++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 9 deletions(-)

-- 
2.37.3

