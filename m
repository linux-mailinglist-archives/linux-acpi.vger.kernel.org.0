Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7F93047A7
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 20:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbhAZF6O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 00:58:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731617AbhAYTKl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611601755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f1V+LPuoBvB9sYfJwGxS3yrxFQp3mMYgaVtf/y9Yvg4=;
        b=Fh2lyT1dRX4jw9QpfxpCHqo3m/U9G2nlODu4M9wDOnBoY0debhCEPV/5e45FdL+U4RuNnN
        hx+zOmrvr+TzzVdogrS9D5Li63yUAI4sBKqU/kVRrfQu0ue/d+++J+LuqxTvbcEPIW/lBt
        LyUUmf/zVOJw/HjeMNwjs4mu6UcgQOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-z02yBCcDP1m1LdWVwmQKoQ-1; Mon, 25 Jan 2021 14:09:13 -0500
X-MC-Unique: z02yBCcDP1m1LdWVwmQKoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3F9610054FF;
        Mon, 25 Jan 2021 19:09:11 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-56.ams2.redhat.com [10.36.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 878325E1A4;
        Mon, 25 Jan 2021 19:09:10 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/1] ACPI: platform-profile: Fix possible deadlock in platform_profile_remove()
Date:   Mon, 25 Jan 2021 20:09:08 +0100
Message-Id: <20210125190909.4384-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Sorry for throwing another patch into the mix for the acpi-platform
branch. I always build my local kernels with lockdep enabled and
while testing an unrelated acpi_thinkpad patch I did "rmmod acpi_thinkpad"
and lockdep pointed out this potential deadlock.

The fix is simple enough, although it does rely on the assumption
that drivers will only call platform_profile_remove() after they
have first successfully called platform_profile_register().

See the actual patch for more details.

Regards,

Hans


Hans de Goede (1):
  ACPI: platform-profile: Fix possible deadlock in platform_profile_remove()

 drivers/acpi/platform_profile.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

