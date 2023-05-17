Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B8C70640E
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 11:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjEQJZB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 05:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjEQJYn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 05:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20182E67
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 02:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684315442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0WXrKVrpOueyuJ+KmObqF1EhWLzszGUe4iUnc0PDLAo=;
        b=N9Dlr2Uv07m8LNKdi8UHiSwMEFEI6KZGjCvsH+3YpXHiObuPtz3P4MZ1MyixQnx/SeryRY
        IUSxyV9YOcdZ8Sk7Xk2auE5gdLil6k12Czw/XiZNLF6tkCV7mtgbh7Z7Ezc4sC8FhMjjg0
        OimEzq4WmG4rxm1oqfnAQsPHjehXt08=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-CBbpmHEYOK6dFV62d14THA-1; Wed, 17 May 2023 05:24:00 -0400
X-MC-Unique: CBbpmHEYOK6dFV62d14THA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D44785A5B1;
        Wed, 17 May 2023 09:24:00 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C052F492B00;
        Wed, 17 May 2023 09:23:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 0/2] ACPI: video: Add 2 new backlight=native DMI quirks
Date:   Wed, 17 May 2023 11:23:57 +0200
Message-Id: <20230517092359.73840-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Here is a series adding 2 new backlight=native DMI quirks to video_detect.c
note the first patch is a resend for a patch which seems to have fallen
through the cracks. I've included that here again since patch 2/2 will
show a conflict if 1/2 is nor merged first.

Regards,

Hans

p.s.

Talking about unmerged patches, FYI I also have the following series +
2 separate patches still pending:

https://lore.kernel.org/linux-acpi/20230429103841.6988-1-hdegoede@redhat.com/
https://lore.kernel.org/linux-acpi/20230429163458.73479-1-hdegoede@redhat.com/
https://lore.kernel.org/linux-acpi/20230509124100.288814-1-hdegoede@redhat.com/


Hans de Goede (2):
  ACPI: video: Add backlight=native DMI quirk for Apple iMac11,3
  ACPI: video: Add backlight=native DMI quirk for Lenovo ThinkPad X131e
    (3371 AMD version)

 drivers/acpi/video_detect.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.40.1

