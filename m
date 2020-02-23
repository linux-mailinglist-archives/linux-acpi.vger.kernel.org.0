Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 310F5169810
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Feb 2020 15:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgBWO3r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 23 Feb 2020 09:29:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39006 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbgBWO3r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Feb 2020 09:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582468186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WSz2SL2nQKU3y5K6kw6Zwdg0kQYk9JDuryzGvJWmvjk=;
        b=FfJI8VLiG/BDHBYAvuVyu/C95kndWueoVZ02pNr3EljtKRMu4lI1USJmCOOSz4k/mQE/ZS
        v7nFGZziB1VoiaBOWUoLb7bS+Pe89vh3ijDcSv+ay3fW5zJJafAstfH8d/mo5IrN+VKabD
        N0u+JCVtL2a31inDNT1a2XxEzyx8d9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-sxwF7hnqNmSYmE8SBboftQ-1; Sun, 23 Feb 2020 09:29:44 -0500
X-MC-Unique: sxwF7hnqNmSYmE8SBboftQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88A29107ACC5;
        Sun, 23 Feb 2020 14:29:43 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-116-120.ams2.redhat.com [10.36.116.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C4641001902;
        Sun, 23 Feb 2020 14:29:42 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 0/2] ACPI / AC / battery: DMI quirk cleanups
Date:   Sun, 23 Feb 2020 15:29:39 +0100
Message-Id: <20200223142941.60705-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

These 2 cleanup patches were preparation patches for adding a quirk
to both drivers for one more model. But in the end I ended up solving
the problem on that model in a different way.

I still think the cleanups are good to have, so I'm submitting them
without any further changes on top.

Regards,

Hans

