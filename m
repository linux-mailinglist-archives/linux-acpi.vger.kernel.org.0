Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4E8677A3B
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 12:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjAWLie (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 06:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjAWLid (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 06:38:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A241352B
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 03:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674473877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WP+hFu+SpO+5okEXSIpWnGraJWr/6u3uMHmEGTvpxTI=;
        b=MUKJxCHzBqwbIvSX4AcQk4Ra3mC0tq+AKVral2UoOvIjsAOP3QOtIfc58hkXP52RSTrZT/
        8Qr+dnMUZyiwWBmBabHqOgY1MrUuSFrDJVn8DKXbuXmj+Cnar/IAQhDuyKkRQRyCqoHBdd
        vFYpTv6Hr5ltXisZbdLVuBj5hlvXeuI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-bn5EIZprPn-TbT2imMynQA-1; Mon, 23 Jan 2023 06:37:54 -0500
X-MC-Unique: bn5EIZprPn-TbT2imMynQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F7E829AB3E1;
        Mon, 23 Jan 2023 11:37:53 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A026A175A2;
        Mon, 23 Jan 2023 11:37:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/3] ACPI: video/apple-gmux: Improve apple-gmux backlight detection
Date:   Mon, 23 Jan 2023 12:37:47 +0100
Message-Id: <20230123113750.462144-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Some apple laptop models have an ACPI device with a HID of APP000B
and that device has an IO resource (so it does not describe the new
unsupported MMIO based gmux type), but there actually is no gmux
in the laptop at all.

This patch-series improves the drivers/acpi/video_detect.c so that
it no longer tries to use the non present gmux in this case.

Note I'm still waiting for testing feedback from the reporter of
this problem. But from the logs the problem is clear
(the logs show: "apple_gmux: gmux device not present") and
the detection code is not changed, just moved so these patches
should be fine, but they can definitely use a good review.

Aditya, can you perhaps test this on a model macbook which does
actually use the apple-gmux driver for backlight control
(assuming you have such a model) ?

Rafael, since this ultimately fixes a drivers/acpi/video_detect.c
bug I think it is best if you take this entire series including
the platform/x86 changes.

Regards,

Hans


Hans de Goede (3):
  platform/x86: apple-gmux: Move port defines to apple-gmux.h
  platform/x86: apple-gmux: Add apple_gmux_detect() helper
  ACPI: video: Fix apple gmux detection

 drivers/acpi/video_detect.c       |  24 +------
 drivers/platform/x86/apple-gmux.c |  93 +++++--------------------
 include/linux/apple-gmux.h        | 108 +++++++++++++++++++++++++++++-
 3 files changed, 127 insertions(+), 98 deletions(-)

-- 
2.39.0

