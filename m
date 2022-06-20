Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06105551442
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jun 2022 11:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbiFTJ0F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jun 2022 05:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbiFTJ0E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jun 2022 05:26:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4D8311819
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 02:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655717162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lQzUyzmeAtsyaXW6UqSmoRFXfQPQ9mYKJjnP3hsZX5g=;
        b=OkUN/PdAohmDhzYe7ds3VFY6F8bmmtGhkLLjUO7srzQ1P/kMDl8kLX6XgAstsMyPLK2NGO
        FhoXg/RZwAjfuUcmbCwwo4a8Dnvle7ZWaBpbmwBWY+WoOg562vi2BwLOKXEMoq/tkyHNes
        Mx+CyT1XngSeDWNP2+9Ii1Oab34Navo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-nqlZTNHvP-e3tqIqgo05JQ-1; Mon, 20 Jun 2022 05:25:57 -0400
X-MC-Unique: nqlZTNHvP-e3tqIqgo05JQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0033880013E;
        Mon, 20 Jun 2022 09:25:57 +0000 (UTC)
Received: from x1.nl (unknown [10.39.195.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B7F91410F35;
        Mon, 20 Jun 2022 09:25:53 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>, kai.heng.feng@canonical.com,
        linux-acpi@vger.kernel.org, devel@acpica.org
Subject: [PATCH 0/4] ACPI: EC: Various cleanups
Date:   Mon, 20 Jun 2022 11:25:42 +0200
Message-Id: <20220620092546.8298-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Here is a set of cleanups / removal of no longer necessary
quirks (or so I believe please review carefully). These are all
things which I noticed while working on my:
"[RFC 0/4] ACPI[CA]: fix ECDT EC probe ordering issues" series.

Regards,

Hans

p.s.
Talking about my "[RFC 0/4] ACPI[CA]: fix ECDT EC probe ordering issues"
series, it would be great if someone can take a look at this and let me
know if that series seems sane. Then I can convert the ACPICA changes
from kernel patches to upstream github acpica patches and submit a
pull-req for those at github.


Hans de Goede (4):
  ACPI: EC: Remove duplicate ThinkPad X1 Carbon 6th entry from DMI
    quirks
  ACPI: EC: Drop the EC_FLAGS_IGNORE_DSDT_GPE quirk
  ACPI: EC: Re-use boot_ec when possible even when
    EC_FLAGS_TRUST_DSDT_GPE is set
  ACPI: EC: Drop unused ident initializers from dmi_system_id tables

 drivers/acpi/ec.c | 140 ++++++++++++++++------------------------------
 1 file changed, 48 insertions(+), 92 deletions(-)

-- 
2.36.0

