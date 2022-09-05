Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4627D5ACE61
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Sep 2022 11:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiIEJAO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Sep 2022 05:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiIEJAN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Sep 2022 05:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B812D1FCFE
        for <linux-acpi@vger.kernel.org>; Mon,  5 Sep 2022 02:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662368411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6UsCR6NCoIizPJgAvlKu3B3vbYgc63Gv2R8NjBiKhEw=;
        b=ah7MI+W0ffbeXVV7Jr5N/SvlLsLID2nnFxPA+pXtZ0ebVTW2sehTpoHg3qw+nJuIIG3BQ2
        mH44DZnKc5SsPuSMnFMcu7MnIp/v0uJ/IDz95C4TcOriQeR4X9k42VxFlxTYci604TVV++
        dq6eFuqaLjhlpPPD7uzmioJ679ZI3Ng=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-w9-OObrJNu6fCejJTcFccA-1; Mon, 05 Sep 2022 05:00:10 -0400
X-MC-Unique: w9-OObrJNu6fCejJTcFccA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16D51811E87;
        Mon,  5 Sep 2022 09:00:10 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.195.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3F6EC15BC3;
        Mon,  5 Sep 2022 09:00:07 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Arvid Norlander <lkml@vorpal.se>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/2] ACPI: video: Fix disable_backlight_sysfs_if regression
Date:   Mon,  5 Sep 2022 11:00:03 +0200
Message-Id: <20220905090005.333429-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Last week I realized that my backlight detect refactor series, which
makes sure we only ever register 1 backlight device, breaks the
video.disable_backlight_sysfs_if module-param / quirk which is necessary
to turn the backlight back on after a suspend / resume cycle on some
Toshiba models.

This workaround for some Toshiba models relied (in a way) on the old
behavior of registering both the acpi and intel backlight class devices
in case where acpi_video_get_backlight_type() returned "video".

Luckily recently Arvid has started contributing some toshiba_acpi driver
improvements and he has an affected Toshiba model. So with the help
of Arvid I have been able to come up with a fix for this by pushing
the magic firmware call these devices need on resume into toshiba_acpi.

After which the whole (no longer functional) disable_backlight_sysfs_if
module-parameter can simply be replaced by "standard" acpi_backlight=native
DMI quirks for the affected models.

I can take care of merging this on top of the backlight-detect-refactor-1
merge already done in the pdx86 tree.

Rafael, may I have your ack for merging patch 2/2 through the pdx86 tree?

Regards,

Hans


Hans de Goede (2):
  drivers/platform: toshiba_acpi: Call HCI_PANEL_POWER_ON on resume on
    some models
  ACPI: video: Change disable_backlight_sysfs_if quirks to
    acpi_backlight=native

 drivers/acpi/acpi_video.c           | 48 -----------------------------
 drivers/acpi/video_detect.c         | 35 +++++++++++++++++++++
 drivers/platform/x86/toshiba_acpi.c | 46 +++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 48 deletions(-)

-- 
2.36.1

