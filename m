Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48423F1A50
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 16:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfKFPrX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Nov 2019 10:47:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33667 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727192AbfKFPrX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Nov 2019 10:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573055243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NmN4OJBBm35WbMBR7Y/Z8itvsVjEWg72ApTODlVnx+A=;
        b=dX2LCnCGtk7dxf1Y/PCUBKKQPo/7VZuqHPorfY7Cc3XVf3ku0cy4BanwlyoCnYYgPodVyk
        T9W8r+qGmVkE1zXO8bpIR30yeirihoEJ4nMc6hZITluC+C3NV8Gfwm2RqqS2RNltvpgIZk
        lric5QpuepOPEnaLzxGMSEoE24ybD54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-3bAqftt6OiWXQB1TR-Z_Ug-1; Wed, 06 Nov 2019 10:47:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EA1C8017E0;
        Wed,  6 Nov 2019 15:47:18 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-167.ams2.redhat.com [10.36.116.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0125E5D70E;
        Wed,  6 Nov 2019 15:47:16 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/3] pinctrl: cherryview: Pass irqchip when adding gpiochip
Date:   Wed,  6 Nov 2019 16:47:12 +0100
Message-Id: <20191106154715.155596-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3bAqftt6OiWXQB1TR-Z_Ug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Here is v2 of my series for Cherry Trail devices to pass the irqchip when
adding the gpiochip instead of registering it separately. Similar to how
this is done for Bay Trail devices in Andy's recent series:
"[RESEND][PATCH v2 0/7] gpiolib: fix GPIO <-> pin mapping registration".

Note this series depends on that series as well as on the cherryview change=
s
currently queued in pinctrl/intel.git/for-next .

Changes in v2:
- Add kerndoc comments for new chv_pinctrl struct members

Regards,

Hans

