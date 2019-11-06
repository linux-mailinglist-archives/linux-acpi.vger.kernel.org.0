Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1628F15D1
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 13:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfKFMKG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Nov 2019 07:10:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27692 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727652AbfKFMKG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Nov 2019 07:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573042205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A86SQgW7W5txuk5wt/duN6tyOQ8cF3AsK1eUFIsOK+E=;
        b=P9gTZKSoB7UvCs9nO7ozyLkPQhMY0tkmMZdWH0lYmBK32S8tlTCZZ/uyiwRlc/ikMTLNql
        A7TJPSwiHxYRZThCa8EPvplqS7fjORyLFS6oAB+EW71+63ufKPDms6xjMG3SDVX15fVNb9
        x6xHQscDv5doKjRJPyFwY3Kz7tlbR8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-L8P3TzfkMCiAxKT01H06Cw-1; Wed, 06 Nov 2019 07:10:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95A85107ACC3;
        Wed,  6 Nov 2019 12:10:00 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-167.ams2.redhat.com [10.36.116.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA95360852;
        Wed,  6 Nov 2019 12:09:57 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/3] pinctrl: cherryview: Pass irqchip when adding gpiochip
Date:   Wed,  6 Nov 2019 13:09:53 +0100
Message-Id: <20191106120956.119958-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: L8P3TzfkMCiAxKT01H06Cw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Here is a patch for Cherry Trail devices to pass the irqchip when adding
the gpiochip instead of registering it separately. Similar to how
this is done for Bay Trail devices in Andy's recent series:
"[RESEND][PATCH v2 0/7] gpiolib: fix GPIO <-> pin mapping registration".

Note this series depends on that series as well as on the cherryview change=
s
currently queued in pinctrl/intel.git/for-next .

Regards,

Hans

