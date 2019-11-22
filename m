Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD751077F5
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 20:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKVTXp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 14:23:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49495 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbfKVTXp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Nov 2019 14:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574450624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=T6VTrt4cNuaAlYRzAubdGGLG93+Bx9+4a6na8TGc7+4=;
        b=BnsCLnnTdSwdo6jaIfLmQ+k1cOTDYXwFj6kVaim/XaLvQmtxFbvW25WfsvtTlmkU/cmnRk
        ZVHZNk2DtLruo4LTVJfPn+aaX6ZfjUgXGze9sR3chyH4PvKVY/ATQPuxRwHgZNXTM8cCiO
        KK2Nr47ggXZD5BRXo6umXj8tKDvEIUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-TOGQmyDvPam-3qrQqfJCIw-1; Fri, 22 Nov 2019 14:23:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C21F4801E76;
        Fri, 22 Nov 2019 19:23:41 +0000 (UTC)
Received: from dhcp-44-196.space.revspace.nl (unknown [10.36.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51A4E1037AB1;
        Fri, 22 Nov 2019 19:23:39 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 0/2] gpiolib: acpi: Add honor_wakeup module-option + quirk
Date:   Fri, 22 Nov 2019 20:23:32 +0100
Message-Id: <20191122192334.61490-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: TOGQmyDvPam-3qrQqfJCIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

On some HP devices _AEI handlers which are marked as WakeCapable are
causing spurious wake-ups.

We may be able to fix this better then in this series, but that
requires significant changes to how we handle s2idle, which I do not
see happening any time soon, as explained in more detail here:
https://lore.kernel.org/linux-acpi/61450f9b-cbc6-0c09-8b3a-aff6bf9a0b3c@red=
hat.c

This series adds a quirk mechanism which allows disabling wakeups
from _AEI handlers as a workaround for this.

Regards,

Hans

