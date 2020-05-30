Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1936A1E91F4
	for <lists+linux-acpi@lfdr.de>; Sat, 30 May 2020 16:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgE3ONK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 30 May 2020 10:13:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:34399 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgE3ONK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 30 May 2020 10:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590847967;
        bh=QrXSg+UsJWP9gK1C6YHtAzZxavSADYLznOMiGJYo0fM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=HoLdFZWVARYEkZXY0/me61dcAuoRwrKz1NSBFVE1YYveqh6oO0YVzWRzHnvdww8Yy
         htPuc0y2gICBAmFV2Sij79V7rsd/EgBdxnAEnO7n9gJ+paTa/ac0Y+r8DZLBMRLZSl
         pzyTN6iZb26Gtjh3gW/++oFKbQ8CYdaWy5AzyecA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MG9kM-1jmiGZ12Ts-00GZCW; Sat, 30 May 2020 16:12:47 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v4 0/3] drivers/acpi: Remove function callback casts
Date:   Sat, 30 May 2020 16:12:15 +0200
Message-Id: <20200530141218.4690-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MKwnw8vsgVAwEAVuWa65vsFSug6LsmUBtFRTQuX0nExrfiTk0dD
 LAgIwS6u5buJEAwX1/thqgEhZqMh78xDqhrn7TONBLWfbmdMLZCdnivpzlM5h72SeeT3ZKk
 ksOs8/ynSWaFPdFxi7RL3ZnHlYeb3fvQjXAu7FQIJ2T8wfgKE4mfcV/tLoz164Q2HKoyV+F
 asaKS/TLfp6CpenJkyAKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZnBXQf3zzPs=:WNc8x7+IPX6FKsLCUyusxA
 cNqjWhONlAifoVAqd1jPrY/KDI5fyLupqrtwEzj0/bcrii1jovxCvEzo0V0Wp5qIXQwJRe3wt
 cRKsgzdDyRtgWBSiLGlaZHPQPBvnlAHxJd+gqL6DtzhpeZciUnlc0mfKkqp6JORNoOhp7izVV
 TcEgKpBlqc/2/7XZEwdT+UwsnjOxl0eg/8EzatLlZxjyw7whwSZUZ6jWfo+COYRVWQ1wbhLNY
 75kn8sQZbpYjJhmiDmDYuUzf2UQF40H/ZFLnm7cnleayCFYQq4ZjrEZzMYHTwpLdGhTQ7apAS
 Yzk3VklRUuFsJ83kWpz7nwNQ9Wq0HyNdGAjrcZkVHWi44mi7w2oUgbGUJrSsEAr0I++nTxhSt
 SnNcMKHE/ULRIiuYjkhCl+3ihwcw/8VvKqr1urK0pYA6ecjRolVAs2GXXKpoCxuad3DD5Inv+
 dkcLVAio0DG6wq5bXloOfXxktmkflQdIVB4jHqKXF6p07Z9uMNDM5v1eguQYizzR3zlsAt/3A
 vlA8EPGSSwFlybFXLXHax5p/OrOyqLACBj+Pq1jhz9hsYNzKytN7FOXBDABetbG5lMLpNVCKa
 9mVuVhQdEgSkwBF+ATImYD8cU9t2NHgHXUBX6cOapY0DQYC2+6Nl6Q6lA4IEa2bvSPOT8CoY5
 9MV2s3T0inxT4ePLjcZkCWxgYuT6eseDlxKRx1znIz44Q2emBvmiZD25t1kRrzFujAMbAzkuo
 dtb5rsbeD05N4ZDdWgMDIAWTj4OEYEWIVOAMIiQfwFE2PtJ6vOSWkNTej32Ll7kni2Y/zm1Ft
 4n9e1Ye7JUbkJybKugn9QnKGcnF3a80TSDKIfqlxzZADvfnf7wibHtNX7etPIDz9wrGyFRFVk
 AVZABgLOzRuIK3XdaF4k8eC+3wc9x3T1akE6bcR82SIeVCNsfTi/2waIyvjLzL71U4ncnevf4
 2b63kOOb678erZz6GqVzqg9C2WqKFiRAv71cWWhUICew6VkqXBPiPXR/Vj37sBC0kIBqlyqVq
 1w7SB7xkLD0uVuceRl0hYV60275/UjfAYOpUH2Nj9/+TtOhTuEX16KRX888Ge27SX/bjB1PnH
 BW+Nis/I/ObxVhEaCG1na0Rglt478FyKbNl6aOf80O3PhpQNP9zAM5MvGN2qzzIJJJGZC3Ob4
 u7mByRBf8FOK4tipjmzlCdNr1gvlwlAozjbCVpuzBaGP4eRxbmpZOIHSQWt/6CupZy3MQmGXz
 Hx+OiafBo0ua2gIpd
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In an effort to enable -Wcast-function-type in the top-level Makefile to
support Control Flow Integrity builds, there are the need to remove all
the function callback casts in the acpi driver.

The first patch creates a macro called ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
to initialize the acpi_probe_entry struct using the probe_subtbl field
instead of the probe_table field to avoid function cast mismatches.

The second patch modifies the IRQCHIP_ACPI_DECLARE macro to use the new
defined macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY instead of the macro
ACPI_DECLARE_PROBE_ENTRY. Also, modifies the prototype of the functions
used by the invocation of the IRQCHIP_ACPI_DECLARE macro to match all the
parameters.

The third patch removes the function cast in the ACPI_DECLARE_PROBE_ENTRY
macro to ensure that the functions passed as a last parameter to this macr=
o
have the right prototype. This macro is used only in another macro
called "TIMER_ACPI_DECLARE". An this is used only in the file:

drivers/clocksource/arm_arch_timer.c

In this file, the function used in the last parameter of the
TIMER_ACPI_DECLARE macro already has the right prototype. So there is no
need to modify its prototype.

Changelog v1->v2
- Add more details in the commit changelog to clarify the changes (Marc
  Zyngier)
- Declare a new macro called ACPI_DECLARE_SUBTABLE_PROBE_ENTRY (Marc
  Zyngier)
- In the IRQCHIP_ACPI_DECLARE use the new defined macro (Marc Zyngier)

Changelog v2->v3
- Remove the cast of the macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY (Marc
  Zyngier)
- Change the prototype of the functions used by the invocation of the
  macro IRQCHIP_ACPI_DECLARE (Marc Zyngier)
- Split the changes in two patches.
- Add these two lines, to give credit to Marc Zyngier
  Signed-off-by: Marc Zyngier <maz@kernel.org>
  Signed-off-by: Oscar Carter <oscar.carter@gmx.com>

Changelog v3->v4
- Add a new patch to remove the cast of the macro
  ACPI_DECLARE_PROBE_ENTRY (Marc Zyngier)
- Change the subject of the first patch

Oscar Carter (3):
  drivers/acpi: Add new macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
  drivers/irqchip: Use new macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
  drivers/acpi: Remove function cast

 drivers/irqchip/irq-gic-v3.c |  2 +-
 drivers/irqchip/irq-gic.c    |  2 +-
 include/linux/acpi.h         | 23 +++++++++++++++++------
 include/linux/irqchip.h      |  5 +++--
 4 files changed, 22 insertions(+), 10 deletions(-)

=2D-
2.20.1

