Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C7F481CEE
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Dec 2021 15:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbhL3ORj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Dec 2021 09:17:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57908 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232426AbhL3ORg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Dec 2021 09:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640873855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j/HT5vnocJ2pNpaJQm9Mn4RpRoem8sBDhOspC99X+oI=;
        b=bDw8myA0Fej/f2aZZCIkj2U381HT/AsqQ6ENYF3KuC0V1uRi6cOlKKB5CuGzro9bcPd+qI
        XTUE6zs8EW3/R/6dBWo343X42vZowoIPEto07QLjDtMM2KzSgmFod1wgAKgJfTcC0GgW8h
        MtWDJWxrfYi+POJTJYTi/d1sxkDRDts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-pRjPNKdMOjGFdvDhyNEvZg-1; Thu, 30 Dec 2021 09:17:31 -0500
X-MC-Unique: pRjPNKdMOjGFdvDhyNEvZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D185818460E5;
        Thu, 30 Dec 2021 14:17:28 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 837A97AB49;
        Thu, 30 Dec 2021 14:17:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-i2c@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 0/3] ACPI / pdx86: Add support for x86 Android tablets with broken DSDTs
Date:   Thu, 30 Dec 2021 15:17:19 +0100
Message-Id: <20211230141722.512395-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Here is v2 of my patch-series to deal with x86 Android tablets with broken
DSDTs. The only change in v2 is moving the i2c_acpi_known_good_ids[] list
and check to drivers/acpi/x86/utils.c.

Since the pdx86 patches are unchanged I'm only sending out the ACPI core
changes this time. Since the i2c and serdev ACPI enumeration changes are
very small and depend on patch 1, I believe it would be best for all 3
ACPI patches to be merged through Rafael's ACPI tree.
Rafael, acks have already been given for merging all patches through
the ACPI tree by Mika, Wolfram and Greg.

For some more background info here is the v1 cover-letter again:

As a small(ish) hoppy project over the holidays I've been looking into
getting some (somewhat older) x86 tablets which ship with Android as the
only OS on their factory image working with the mainline kernel.

These typically have pretty broken DSDTs since the Android image kernel
just has everything hardcoded.

This patch-series makes most things on 3 of these tablets work with the
mainline kernel and lays the groundwork for adding support for similar
tablets.

Since the ACPI tables on these devices clearly are buggy this series is
written so as to add minimal changes to the ACPI core code, leaving all
of the heavy lifting to the recently introduced (in linux-next)
drivers/platform/x86/x86-android-tablets.c module, which when built as
a module only autoloads on affected devices based on DMI matching.

And when this module is disabled the added acpi_quirk_skip_*_enumeration()
helpers are replaced by inline stubs and even the minimally added core
code will be optimized away.

Regards,

Hans


Hans de Goede (3):
  ACPI / x86: Add acpi_quirk_skip_[i2c_client|serdev]_enumeration()
    helpers
  i2c: acpi: Do not instantiate I2C-clients on boards with known bogus
    DSDT entries
  serdev: Do not instantiate serdevs on boards with known bogus DSDT
    entries

 drivers/acpi/x86/utils.c    | 111 ++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core-acpi.c |   7 +++
 drivers/tty/serdev/core.c   |  14 +++++
 include/acpi/acpi_bus.h     |  16 ++++++
 4 files changed, 148 insertions(+)

-- 
2.33.1

