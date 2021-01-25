Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DA43024B9
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 13:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbhAYMNL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 07:13:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727844AbhAYMMd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 07:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611576667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9YNvMknkwracq1I1R/AwjyKQhZIGz8Y5nGhBoNSyFyw=;
        b=XEtD+f724OFIym/8IUEsc3fWCRtgMWchAwlxmn3wHp1j8AqAaP7ljvGTmgUzh11/fnNvYu
        e2Jhjxvj8gzMLaG0l3NgTTfcilxd+b6WE3wjblyayJhbB/cekNDF6ub4+KynNiZ3edGaTM
        0Nm2w3yDKX5NmMbq8Mznag3hXXkSdoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-TJRATGi7OkqO7SZkmQMxPg-1; Mon, 25 Jan 2021 07:00:01 -0500
X-MC-Unique: TJRATGi7OkqO7SZkmQMxPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D8ED8030A1;
        Mon, 25 Jan 2021 12:00:00 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-170.ams2.redhat.com [10.36.112.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F2B3672C0;
        Mon, 25 Jan 2021 11:59:58 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 0/2] ACPI: platform-profile: Introduce object pointers to callbacks
Date:   Mon, 25 Jan 2021 12:59:55 +0100
Message-Id: <20210125115957.3292-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael, Jiaxun,

Here is a v2 of Jiaxun's series to introduce object pointers to the
profile_get() and profile_set() callbacks.

I've taken the liberty to fix the issue of the platform_profile_register()
function argument still having a const and post this v2, as I would like
to at least merge the thinkpad_acpi platform_profile support for 5.12 and
we are slowly running out of time.

Rafael, you please add these 2 to your acpi-platform branch and then once
you are happy with these (once the bots have tested them) send me a PR
for an immutable branch with all 4 patches from acpi-platform ?

Regards,

Hans


Jiaxun Yang (2):
  ACPI: platform-profile: Drop const qualifier for cur_profile
  ACPI: platform-profile: Introduce object pointers to callbacks

 drivers/acpi/platform_profile.c  | 8 ++++----
 include/linux/platform_profile.h | 8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.29.2

