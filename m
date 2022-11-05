Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA061DB3C
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Nov 2022 15:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKEOyB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Nov 2022 10:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEOyA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Nov 2022 10:54:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E48FAF8
        for <linux-acpi@vger.kernel.org>; Sat,  5 Nov 2022 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667659985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MuetAjcYBCwxOMxF5/nZHZwcGC9dQS5cWO/4myHLFRI=;
        b=iAgEbmi5yZffg2ifSuYEChoN9LIm1CQxteqhqYtCSYFBCvqztpcuhYluVDVgIk4ZeBzwLf
        5WbzVYywpN9LayDpkh06KwsZoWVvJLzsBLWOQ8SSLLamPjJNB9jHK/0T7V6q84NmM8D/cs
        3vHcKzbAZodrRgSCwben7m62Wx4ayTs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-LQnK9f95M5-zKI6MZexSvw-1; Sat, 05 Nov 2022 10:53:02 -0400
X-MC-Unique: LQnK9f95M5-zKI6MZexSvw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D8E58339C5;
        Sat,  5 Nov 2022 14:53:02 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C9A84A927F;
        Sat,  5 Nov 2022 14:52:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [RFC 0/2] ACPI: video: prefer native over vendor
Date:   Sat,  5 Nov 2022 15:52:56 +0100
Message-Id: <20221105145258.12700-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael, Matthew,

Here is a second attempt at always registering only a single
/sys/class/backlight device per panel.

This first round of testing has shown that native works well even on
systems so old that the don't have acpi_video backlight control support.

This patch series makes native be preferred over vendor, which should
avoid the problems seen with the 6.1 changes before the fixes.

ATM there is one known model where this will cause a regression,
the Sony Vaio PCG-FRV3 from 2003. I plan to add a DMI quirk for that
in the next version of this series, but I'm waiting for some more
testing (to check that the vendor interface does actually work) first.

I will also do another blogpost, focussing on asking users to see
if they have a laptop which provides a combination of vendor + native
backlight interfaces, which may be impacted by this series. This is
the main reason why this is a RFC for now.

Note this applies on top of my series with fixes for 6.1:
https://lore.kernel.org/linux-acpi/20221104212108.73537-1-hdegoede@redhat.com/

So we need to be a bit careful with merging this to avoid
non trivial conflicts. Assuming that series gets send to Linus
for 6.1 through the pdx86 tree, it might be best for me to
rebase pdx86/for-next on top of the fixes and then this can
(also) be merged through pdx86/for-next without conflicts.

Regards,

Hans

p.s.

Matthew, this should keep your custom coreboot laptop working since
acpi_video_backlight_use_native() will return true there now.


Hans de Goede (2):
  ACPI: video: Simplify __acpi_video_get_backlight_type()
  ACPI: video: prefer native over vendor

 drivers/acpi/video_detect.c | 52 ++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

-- 
2.37.3

