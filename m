Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587D511FD82
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 05:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLPES1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 15 Dec 2019 23:18:27 -0500
Received: from mo-csw-fb1115.securemx.jp ([210.130.202.174]:48052 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfLPES1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Dec 2019 23:18:27 -0500
X-Greylist: delayed 620 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Dec 2019 23:18:25 EST
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id xBG484bA028120; Mon, 16 Dec 2019 13:08:05 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id xBG47nQ3008763; Mon, 16 Dec 2019 13:07:49 +0900
X-Iguazu-Qid: 2wGqjDiQpC9B15ge9O
X-Iguazu-QSIG: v=2; s=0; t=1576469269; q=2wGqjDiQpC9B15ge9O; m=s5a6vg9zpyrVRrEsYdwnILKPvfFX08BE9xRq9WG+OXI=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1111) id xBG47ltE020225;
        Mon, 16 Dec 2019 13:07:48 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id xBG47lqx028241;
        Mon, 16 Dec 2019 13:07:47 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id xBG47l4L000309;
        Mon, 16 Dec 2019 13:07:47 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     linux-serial@vger.kernel.org
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, shrirang.bagul@canonical.com,
        robh@kernel.org, gregkh@linuxfoundation.org, johan@kernel.org,
        hdegoede@redhat.com
Subject: [RFC  0/1] serdes: Add whitelist to bring back missing serial port
Date:   Mon, 16 Dec 2019 13:08:24 +0900
X-TSB-HOP: ON
Message-Id: <20191216040825.523720-1-punit1.agrawal@toshiba.co.jp>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Hi,

While booting v5.5-rc1 on Apollo Lake based UP2[0], I ran into an
issue with the primary serial port. The kernel is able to output to
ttyS0 but systemd isn't able to raise a login prompt. On further
investigation, it turns out that no serial device (/dev/ttyS0) is
being created as the device is claimed by serdev sub-system.

The issue has been reported in a few different places[0][1]. A patch
was proposed to solve the issue but there doesn't seem to be any
further progress[2]. Feedback on the thread suggested implementing a
whitelist based approach - which is what this RFC does.

With this patch, systemd is able to create a login prompt. The
whitelist has intentionally been left blank as it's not clear which
devices go in there.

Feedback welcome.

Thanks,
Punit

[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911831
[1] https://bugs.launchpad.net/ubuntu/+source/linux-oem/+bug/1769610
[2] https://marc.info/?l=linux-serial&m=152455861101408&w=2

Punit Agrawal (1):
  serdev: Only claim supported devices

 drivers/tty/serdev/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.24.0

