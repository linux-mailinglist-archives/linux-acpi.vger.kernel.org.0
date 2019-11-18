Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 217E810073A
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2019 15:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfKROUa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 09:20:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44875 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726704AbfKROUa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Nov 2019 09:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574086827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=i0ihOmqOTCiFt0SY55Ox7KeIwgDxHqpJgi7WW4P04QM=;
        b=gz4cst7GNqTbEl2lHcc3scYADep3oUEKhE10DTEhxpsa/ZSi2766jRyUn/XtPQHzkiSH+h
        BE4ZvzdidXD8hJpPHfjOdufc/vyXFalVIjFKMrH9PngH6W/bPWzJ1/u9c7EIoslBqFNOZV
        uGVgkhOIc5GVH8USs+AbGvCR5j0l9kE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-qft8cIMEMC-QvCkASYOpOw-1; Mon, 18 Nov 2019 09:20:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A6EF56C60;
        Mon, 18 Nov 2019 14:20:23 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A23B51D4;
        Mon, 18 Nov 2019 14:20:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/1] pinctrl: baytrail: Really serialize all register accesses
Date:   Mon, 18 Nov 2019 15:20:19 +0100
Message-Id: <20191118142020.22256-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: qft8cIMEMC-QvCkASYOpOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

First let me copy-paste a bit of the commit msg for background:

---begin commit msg---
Commit 39ce8150a079 ("pinctrl: baytrail: Serialize all register access")
added a spinlock around all register accesses because:

"There is a hardware issue in Intel Baytrail where concurrent GPIO register
 access might result reads of 0xffffffff and writes might get dropped
 completely."

Testing has shown that this does not catch all cases, there are still
2 problems remaining

1) The original fix uses a spinlock per byt_gpio device / struct,
additional testing has shown that this is not sufficient concurent
accesses to 2 different GPIO banks also suffer from the same problem.

This commit fixes this by moving to a single global lock.

2) The original fix did not add a lock around the register accesses in
the suspend/resume handling.

Since pinctrl-baytrail.c is using normal suspend/resume handlers,
interrupts are still enabled during suspend/resume handling. Nothing
should be using the GPIOs when they are being taken down, _but_ the
GPIOs themselves may still cause interrupts, which are likely to
use (read) the triggering GPIO. So we need to protect against
concurrent GPIO register accesses in the suspend/resume handlers too.

This commit fixes this by adding the missing spin_lock / unlock calls.
---end commit msg---

I was discussing the problem at my local hackerspace yesterday with
someone who knows quite a bit low-level details about Intel CPUs.
He said that on "big" core's all the GPIO islands sit behind the IOSF
and that there is a bridge which make their registers look like regular
mmio registers.

I wonder if the same is happening on BYT, that would point to an issue
with concurent accesses being done through the IOSF bridge, which would
explain why I've found that we need a single global lock for all GPIO
islands (*). But that in turn would mean that we really need global lock
for _all_ accesses done through the IOSF bridge, not just GPIO register
accesses...  Which would explain why on some machines BYT has never been
really stable with Linux.

Can someone at Intel with access to internal docs about BYT dig a bit into
the docs and see if 1. this theory makes sense, 2. if it does if there us
anything else behind the IOSF for which we also need to serialize accesses?

Regards,

Hans




*) It seems that the GPIO interrupt storm on the test device I hit
this is really good in triggering this

