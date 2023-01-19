Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5AF673F06
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jan 2023 17:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjASQik (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 11:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjASQij (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 11:38:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFD14DE0D
        for <linux-acpi@vger.kernel.org>; Thu, 19 Jan 2023 08:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674146275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gtDRAlMxM3BpiZxjHXzl+V5fdT4iRLFW1Aqx9GmsqCU=;
        b=LqOvQICSXR+5jqFSqFMhVJyfWGT2Jc6mWwypQMIFOKqhePgqVFkzR1Gk4UhF1AuGco2uRd
        BePNjbJI5tsn0lMwSK7iv1LhAoJMqyFquwJMMoAjN2eoBGKBg6gSn83WW/BeCkrbzcmRax
        JINyJFS2UXzCtLZbUixHCxN7WaY7fa0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-eMGSeJgZN7CviRkg4WM27w-1; Thu, 19 Jan 2023 11:37:54 -0500
X-MC-Unique: eMGSeJgZN7CviRkg4WM27w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6D7C8A0100;
        Thu, 19 Jan 2023 16:37:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C33D32026D76;
        Thu, 19 Jan 2023 16:37:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] ACPI: video: More backlight quirks
Date:   Thu, 19 Jan 2023 17:37:42 +0100
Message-Id: <20230119163744.548749-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

With the backlight changes landing in 6.1.y now showing up in
distribution repositories I have been receiving a steady stream of
backlight bug reports by email.

These bug-reports fall into various categories and most of them are
already fixed with some recent fixes which are in 6.1.7 and later.

One category (unfortunately) requires adding DMI quirks.

I have been receiving reports from users with pre Windows 8 laptops,
who used to pass acpi_backlight=vendor on the kernel commandline to hide
a non functioning acpi_video# backlight device, so that userspace will
use the native (GPU driver) backlight device instead.

Starting with 6.1.y acpi_backlight=vendor is now also honored by
the native backlight drivers, hiding the native backlight device,
leaving these users with no backlight device at all.

This leads to them sending me a bug-report. Which in a way is a good
thing because these models really needed to have a DMI quirk added
all along, but this was never reported upstream.

The fix here is to use "acpi_backlight=native" and to set this through
a DMI quirk so that things will work out of the box.

The Acer Aspire 4810T quirk from a couple of days was like this and
the first quirk in this series is too.

I expect to receive more bug-reports like this, so you can expect
a steady trickle of backlight quirk patches from me the coming time.

Note the second quirk in this series is also a "acpi_backlight=native"
quirk, but the root cause is somewhat different, see the commit msg.

Regards,

Hans



Hans de Goede (2):
  ACPI: video: Add backlight=native DMI quirk for HP Pavilion g6-1d80nr
  ACPI: video: Add backlight=native DMI quirk for HP EliteBook 8460p

 drivers/acpi/video_detect.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.39.0

