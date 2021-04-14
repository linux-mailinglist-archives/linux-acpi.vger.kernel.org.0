Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A1D35F3E1
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Apr 2021 14:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350929AbhDNMgN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Apr 2021 08:36:13 -0400
Received: from mail-02.mail-europe.com ([51.89.119.103]:50690 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhDNMgM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Apr 2021 08:36:12 -0400
Date:   Wed, 14 Apr 2021 12:35:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1618403747;
        bh=LBjI5Lfie9IfkopTYu8hIHm2MPYXBjYl387JLU+7p6o=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=ujQI1iniE56dRsjfjt1M+1ia3ALoGd6YuwOk955EO/YxeXWXJKF8qSFgSKRMQ5Qoa
         Y6Oi5q7yaV2N51xFABWBg11LdpvZmsQLes1NkB+dT5c3dSFlgUGvAUWqhLLsrwPzWg
         T3SpNc5RYdfc4qvO3AqHnrccTbwk1KVt++V7GQBQ=
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>
From:   w4v3 <vv4v3@protonmail.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Reply-To: w4v3 <vv4v3@protonmail.com>
Subject: Calling _WAK on boot
Message-ID: <JhJJOq9M37qi7rg1RcBQ-XBPrf3pvws9oaDxtseX1SnEStVYW5kT7krgx7YUITmovSL-tZTmfawGwoWTcXHEbDJd1tPDt7xleJhy6H8v49g=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi everyone,

As I understand ACPI spec =C2=A716.3.3, the _WAK method should also
be called when waking up from S5. Currently this doesn't
seem to be the case.

On my device (Lenovo Yoga 7i), the brightness hotkeys depend
on initialization carried out in _WAK, so they currently only
work after resuming from S3 or S4 sleep, but not after booting
normally.

I really don't know what would be the right way to do this,
but as an example, patching the acpi_init function as follows
seems to work fine.

--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -1094,6 +1094,7 @@
 =09acpi_debugfs_init();
 =09acpi_sleep_proc_init();
 =09acpi_wakeup_device_init();
+        acpi_leave_sleep_state(ACPI_STATE_S5);
 =09return 0;
 }
