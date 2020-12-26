Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AF72E2E64
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Dec 2020 15:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgLZOaD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Dec 2020 09:30:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgLZOaC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 26 Dec 2020 09:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608992916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+G0X1/vZfEvqUwLwFM/BFKyYSbOEkM30SCwGslu/tcM=;
        b=XjF1LPpEAL7mNOucBFJls6eVPF/daHWoSYPQWnKuiZ5AvFcRIK1VuiYHxXDQ937OPOM7ej
        6Ppl4DpNuPwEFC3kmZginG1xqI0ageCJEffxpQ7XuWQJxcN9tSiBnB2IdP4HiR53hiDCvD
        rgXquT3iJ6sMEXjh9vMnp9vPQ59nM2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-hNfixgmOMXC-XsXksypm2A-1; Sat, 26 Dec 2020 09:28:34 -0500
X-MC-Unique: hNfixgmOMXC-XsXksypm2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA734107ACE3;
        Sat, 26 Dec 2020 14:28:32 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-35.ams2.redhat.com [10.36.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25AC9189B8;
        Sat, 26 Dec 2020 14:28:30 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH 0/2] ACPICA: Fix a race in GenericSerialBus (I2C) and GPIO handling
Date:   Sat, 26 Dec 2020 15:28:28 +0100
Message-Id: <20201226142830.48818-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On one of my machines I noticed the following errors being logged:

[   52.892807] i2c i2c-0: adapter quirk: no zero length (addr 0x0078, size 0, read)
[   52.893037] i2c i2c-0: i2c read 0 bytes from client@0x78 starting at reg 0x0 failed, error: -95

The second line is coming from the Linux I2C ACPI OpRegion handling and
after a bunch of debugging I've found out that there is a rather obvious
(once you see it) and nasty race condition in the handling of I2C and GPIO
opregions in acpi_ev_address_space_dispatch(). See the first patch in this
series (the second patch is a follow-up cleanup patch removing some code
duplication).

TBH I'm surprised that this issue has gone unnoticed as long as it has,
but I guess that it mostly leads to unreproducable sporadic problems
making it hard to debug and I got lucky that I had a machine where the
race seems to trigger about once every 20 seconds.

I know that ACPICA patches are normally merged through the ACPICA upstream
but given that this is a serious bug, I believe that in this case it might
be best to add the fix directly to Linux and then port it to ACPICA from
there.

Regards,

Hans

