Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B162655987C
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jun 2022 13:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiFXLX6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jun 2022 07:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiFXLX4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2022 07:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13A8C7A6FB
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jun 2022 04:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656069834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LGApk+swnP1uEKw3iYyR1RdJ655GxP4fSVzWwny/eHI=;
        b=cNyuSDqWDxgzl0668X5zj6kh/2yHWaJJ9ICNRu9+CpbJCKCe9R3n+F8ATgK+cnN7AWzNEE
        5LhcjgqbMKezonfUnHfcrSCFvmoenYCdsF8Na/gms59GwVzR1dyNH4ln3PtD0mvsK9Q3sJ
        RYFPr1ylziOd4SGQiaA4oCyL2k/6kHI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-PESJFhd9NQ2Gip7ZT9i0-Q-1; Fri, 24 Jun 2022 07:23:50 -0400
X-MC-Unique: PESJFhd9NQ2Gip7ZT9i0-Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B1E81818CB8;
        Fri, 24 Jun 2022 11:23:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4988B492C3B;
        Fri, 24 Jun 2022 11:23:48 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/7] ACPI: video / platform/x86: Fix Panasonic laptop missing keypresses
Date:   Fri, 24 Jun 2022 13:23:33 +0200
Message-Id: <20220624112340.10130-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Here is a series fixing the missing keypresses on some Panasonic Toughbook
models. These missing keypresses are caused by
commit ed83c9171829 ("platform/x86: panasonic-laptop: Resolve hotkey double
trigger bug"), which made the panasonic-laptop driver unconditionally drop
most WMI reported hotkeys.

This series reverts that commit and then adds some more selective filtering
to still avoid the double key-presses on some models, while avoiding
completely missing keypresses on others.

Rafael, these fixes rely on patch 1/7, which is a tweak to
the acpi_video_handles_brightness_key_presses() helper. Without this
tweak this series will cause a regression, so I would like to merge
the entire series through the pdx86 tree, may I have your ack for this?

Regards,

Hans


Hans de Goede (6):
  ACPI: video: Change how we determine if brightness key-presses are
    handled
  platform/x86: panasonic-laptop: sort includes alphabetically
  platform/x86: panasonic-laptop: revert "Resolve hotkey double trigger
    bug"
  platform/x86: panasonic-laptop: don't report duplicate brightness
    key-presses
  platform/x86: panasonic-laptop: filter out duplicate volume
    up/down/mute keypresses
  platform/x86: panasonic-laptop: Use acpi_video_get_backlight_type()

Stefan Seyfried (1):
  platform/x86: panasonic-laptop: de-obfuscate button codes

 drivers/acpi/acpi_video.c               |  13 ++-
 drivers/platform/x86/Kconfig            |   2 +
 drivers/platform/x86/panasonic-laptop.c | 112 ++++++++++++++++++------
 3 files changed, 91 insertions(+), 36 deletions(-)

-- 
2.36.0

