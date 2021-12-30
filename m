Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78236481FEE
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Dec 2021 20:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbhL3Tb1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Dec 2021 14:31:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240383AbhL3Tb1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Dec 2021 14:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640892685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=azdgNNWRbCPfvzexxCjoMpNgCR8RdxZY30tJBUl8k2Y=;
        b=OeKzlkIJLARGzGIOP8ZrRmR4djD0FtJKvTcO5dXZyZUd5KpxmNwb5UkTXe0MJXUk8q4BcC
        +H3tTY63timHJ3Z6RYd5pE+YTf34l/BgTye8D3H9kbWQj0qjHn9pmD6yIeo153Vy/oZQwQ
        /0PFGDbgmSBBnIGAa2xYO4i/tAbL6Wg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-9hU0shUhMGO_3-oaozthTg-1; Thu, 30 Dec 2021 14:31:24 -0500
X-MC-Unique: 9hU0shUhMGO_3-oaozthTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63D058042E0;
        Thu, 30 Dec 2021 19:31:23 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01D027DE2B;
        Thu, 30 Dec 2021 19:31:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/2] ACPI / x86: ac and battery device quirk work
Date:   Thu, 30 Dec 2021 20:31:18 +0100
Message-Id: <20211230193120.589337-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Here are 2 patches for ACPI ac and battery device quirk handling on x86,
the first one refactors the almost identical quirk handling in ac.c and
battery.c out into a shared helper.

And the 2nd patch then uses the now shared code to also skip / ignore
ac and battery devices on x86 Android tablets with known broken DSDTs.

Note this applies on top of my:
"[PATCH v2 0/3] ACPI / pdx86: Add support for x86 Android tablets with broken DSDTs"
series which you've just merged into your bleeding edge branch.

Regards,

Hans


Hans de Goede (2):
  ACPI / x86: Introduce an acpi_quirk_skip_acpi_ac_and_battery() helper
  ACPI / x86: Skip ac and battery devices on x86 Android tablets with
    broken DSDTs

 drivers/acpi/ac.c        | 43 ++------------------
 drivers/acpi/battery.c   | 42 ++------------------
 drivers/acpi/x86/utils.c | 86 ++++++++++++++++++++++++++++++++++++----
 include/acpi/acpi_bus.h  |  5 +++
 4 files changed, 90 insertions(+), 86 deletions(-)

-- 
2.33.1

