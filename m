Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D72CD1308ED
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Jan 2020 17:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgAEQEE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Jan 2020 11:04:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25365 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726351AbgAEQED (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Jan 2020 11:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578240243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EZCMLeEnDp7SGoOxxQSF2uRhff4VPWzcJo9YvOtRxu8=;
        b=P5IG+VhF7XGRXUc/vCvWDJjH+UQTEAkINbNj258+xRj4GGME6qGMtjWUL4OomfL/0P7/d1
        NtkrlvAbN+nk0QTOv7SFGkckwnGu5yO55zwKkHOx3pI8I8PnTqu7IUhKmjck9cMfKp1ddR
        +o5ao3LBHoLq0+NDeOSfxjRN8YP3STI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-n5aG5_0LMKShhset5gwNuQ-1; Sun, 05 Jan 2020 11:04:01 -0500
X-MC-Unique: n5aG5_0LMKShhset5gwNuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B8B3107ACC9;
        Sun,  5 Jan 2020 16:04:00 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-82.ams2.redhat.com [10.36.116.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E93460C63;
        Sun,  5 Jan 2020 16:03:58 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH resend v2 0/2] gpiolib: acpi: Add honor_wakeup module-option + DMI quirk
Date:   Sun,  5 Jan 2020 17:03:55 +0100
Message-Id: <20200105160357.97154-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

As discussed here is a rebased resend of the 2 patches to fix suspend/res=
ume
on some HP X2 models.

Regards,

Hans

