Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4062AB596
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 11:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgKIK5g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 05:57:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727774AbgKIK5g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 05:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604919456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yj0rLVKrwx2e/48rRjGHa5Mxo3H/jb+LBHg/BpAMTAM=;
        b=hdSASEl2OxRJ0MPR2pT+ErrNldks5tRQXRyBjBjxEK5cMitRQLPK4BVT6o7Yx9Evbhf+fs
        1H1v+/2VgvwXwGf3UXGkFtgHVNPIU+mSzXuKBWH4iaB/KFTSrlJtiDLFqe06A/HNEhrtQM
        pk1Q5wql9ihZ5B4fYx8LZRdNAyYXX3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-dn8KsXQyM7KXaidf_5ZBow-1; Mon, 09 Nov 2020 05:57:32 -0500
X-MC-Unique: dn8KsXQyM7KXaidf_5ZBow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D59F9107B471;
        Mon,  9 Nov 2020 10:57:30 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-3.ams2.redhat.com [10.36.114.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D03656EF4B;
        Mon,  9 Nov 2020 10:57:27 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/3] pwm: lpss: pwm: lpss: Misc. cleanups / improvements
Date:   Mon,  9 Nov 2020 11:57:23 +0100
Message-Id: <20201109105726.121512-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Now that the pwm-lpss / pwm-crc / i915 atomic PWM conversion has landed
in 5.10-rc1 here is a small follow up series with some misc. improvements.

Changes in v2:
- Extend comment to explain why the DPM_FLAG_SMART_SUSPEND is set
- Add Andy's Reviewed-by to all 3 patches

Regards,

Hans

