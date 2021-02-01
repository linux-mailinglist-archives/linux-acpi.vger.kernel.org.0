Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5013A30ACB8
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 17:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBAQfv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 11:35:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50519 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229892AbhBAQfv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 11:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612197263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K6d3hKuKWWffIk6Wi1MvL+qF9A0xt0rPQLlRoIbsI14=;
        b=L3kSjRm3im1DuiJbqJdwGE0JT2KSXR3S33l1lBo8Vi2NIH7/s5iU7x0a06iV8Xoi81P8Id
        rk6pG9YJMo+a7OAs7HMomio7nA278sWY3WwbIZ8G/soJeMWQ8DQ+m1eAX1Ro8Ds+TBJWMt
        FbwNKdpjI6z5/LffoWCqxoUNlkwnYBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-ElfX68h3MVmVYlb47fm_YA-1; Mon, 01 Feb 2021 11:34:22 -0500
X-MC-Unique: ElfX68h3MVmVYlb47fm_YA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20B1D81624;
        Mon,  1 Feb 2021 16:34:21 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-234.ams2.redhat.com [10.36.112.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51BDD10013C0;
        Mon,  1 Feb 2021 16:34:20 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 5.11 regression-fix 0/1] ACPI: scan: Fix Battery devices sometimes never binding
Date:   Mon,  1 Feb 2021 17:34:18 +0100
Message-Id: <20210201163419.396568-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Sorry for the last minute 5.11 fix, but I only noticed this yesterday
(and wrote the fix today). I believe that this was covered up by the
broken acpi_bus_get_device() error handling which we debugged earlier :|

For details see the actual patch.

It would be nice if you can get this to Linus for 5.11. But I understand
this is cutting it pretty close to the release, so if it misses 5.11 then
this can be picked up by the linux-stable releases.

Regards,

Hans


Hans de Goede (1):
  ACPI: scan: Fix Battery devices sometimes never binding

 drivers/acpi/scan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.29.2

