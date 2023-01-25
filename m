Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564D267AFD5
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 11:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbjAYKkN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 05:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjAYKkI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 05:40:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09C79742
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jan 2023 02:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674643161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jNdHlwqa75bo03BzDGn3/1P66BHrvZnULx8SRTRIIXg=;
        b=Mg4vHgqhBlJi4udMvEYQcqDe/000OiWRC0GUW4Q5oj8G7vRxR8GWoicLnRCo0wrXxcpJA4
        uoIXNV4pshDkli4lFMYzRJzTGohgK438ngqR23L2PAbk0B4/8ZHCFMublf0dXSSSpk8Jsx
        6MmLTz02rS5HDGjXncA8K/WHlicYQN0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-bx4jaRnfONyWspXK2ImlHg-1; Wed, 25 Jan 2023 05:39:19 -0500
X-MC-Unique: bx4jaRnfONyWspXK2ImlHg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F36D1C00406;
        Wed, 25 Jan 2023 10:39:18 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F5DF492C14;
        Wed, 25 Jan 2023 10:39:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mario Limonciello <Mario.Limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [RFC 0/1] pinctrl: amd: Fix handling of PIN_CONFIG_BIAS_PULL_UP/_DOWN settings
Date:   Wed, 25 Jan 2023 11:39:15 +0100
Message-Id: <20230125103916.16772-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

I've been going over my local patch queue and found this. This is a fix
which I wrote quite a while ago trying to address:

https://bugzilla.kernel.org/show_bug.cgi?id=212379

Testing if this really helped that bug has been inconclusive, but
in itself the bugfixes from this patch still seem the right thing
to do.

Still I have marked this as a RFC for now, because it really could
use another pair of eyes + more testing before getting merged.

Regards,

Hans


Hans de Goede (1):
  pinctrl: amd: Fix handling of PIN_CONFIG_BIAS_PULL_UP/_DOWN settings

 drivers/pinctrl/pinctrl-amd.c | 37 +++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

-- 
2.39.0

