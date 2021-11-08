Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9915E449929
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 17:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhKHQOX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Nov 2021 11:14:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229568AbhKHQOX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Nov 2021 11:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636387898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KYUCHH61FI/LqvLo62UkT+RqsngJRkFoXPCNpaqTHP8=;
        b=AGv6vq5lCzXWCnNJDTnKdYaqqQ2QwvEyGdi3i4Lkezb0IFkwjDrbeWvGK41EO3SUaL/FpL
        sq9YgQ1rZLqaasUlj2HiKo8MzsrKX1COz7KmJzP3gXVTk2iyLKem7DlkjG8KO5f1RFKt0h
        zmmSjnl5dRW4zpxlRiLinJz8PkBfj1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-HGBqAbMbP6yJNlwEJYH3Qg-1; Mon, 08 Nov 2021 11:11:35 -0500
X-MC-Unique: HGBqAbMbP6yJNlwEJYH3Qg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E35CA40C0;
        Mon,  8 Nov 2021 16:11:34 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCB825C3E0;
        Mon,  8 Nov 2021 16:11:32 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/1] ACPI / x86: Add PWM2 on the Xiaomi Mi Pad 2 to the always_present list
Date:   Mon,  8 Nov 2021 17:11:30 +0100
Message-Id: <20211108161131.896783-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

This patch was previously send as part of a RFC series because
I was not sure if there may be needed to be more entries in
the always_present list for the Xiaomi Mi Pad 2.

I know have a clear plan forward and we will just need this one
entry, so this patch now is ready for merging (for 5.17, though
5.16 is fine too).

Regards,

Hans


Hans de Goede (1):
  ACPI / x86: Add PWM2 on the Xiaomi Mi Pad 2 to the always_present list

 drivers/acpi/x86/utils.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.31.1

