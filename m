Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F6D6A6A66
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Mar 2023 11:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCAKFi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Mar 2023 05:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCAKFh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2023 05:05:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA025E2A
        for <linux-acpi@vger.kernel.org>; Wed,  1 Mar 2023 02:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677665089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=k78l10kp8fbLF65yBqsAzl70szi7/95GURZ+eIxxm5s=;
        b=YgKoRAX+3onIy7OCg6uviR+8ck9I3PAAq7Tq0PFjMkPocqNndzO1Um9m5W0m/GDNo3KMiu
        SFW0qVdjaHlnWwKZ+CuAhWUrvGZtvNtcvwidkwcX3j6CnP/BpmwjQ7MGooTzeimkHIBCoR
        AVJ1mCd0uUNNHCiGQTfgIb8sDhCLw2w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-1jVtTWTENcmRxwF5_n_ugA-1; Wed, 01 Mar 2023 05:04:46 -0500
X-MC-Unique: 1jVtTWTENcmRxwF5_n_ugA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA8D8811E6E;
        Wed,  1 Mar 2023 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E01A9C15BAD;
        Wed,  1 Mar 2023 10:04:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/3] ACPI: x86: Introduce an acpi_quirk_skip_gpio_event_handlers() + 2 quirks
Date:   Wed,  1 Mar 2023 11:04:33 +0100
Message-Id: <20230301100436.132521-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Here is v2 (more of a resend really) of my patch series to allow
the existing quirk mechanism in drivers/acpi/x86/utils.c to
disable ACPI GPIO event handlers on systems where these are totally
broken (typically systems which use Android as factory OS with a
heavily patched linux kernel).

New in this version of the series is the addition of a second new quirk
using this.

Regards,

Hans


Hans de Goede (3):
  ACPI: x86: Introduce an acpi_quirk_skip_gpio_event_handlers() helper
  ACPI: x86: Add skip i2c clients quirk for Acer Iconia One 7 B1-750
  ACPI: x86: Add skip i2c clients quirk for Lenovo Yoga Book X90

 drivers/acpi/x86/utils.c    | 45 ++++++++++++++++++++++++++++++++++---
 drivers/gpio/gpiolib-acpi.c |  3 +++
 include/acpi/acpi_bus.h     |  5 +++++
 3 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.39.1

