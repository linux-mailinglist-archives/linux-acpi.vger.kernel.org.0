Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADCD1E9213
	for <lists+linux-acpi@lfdr.de>; Sat, 30 May 2020 16:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgE3OfO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 30 May 2020 10:35:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:48211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbgE3OfN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 30 May 2020 10:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590849291;
        bh=siAvfo9HnN3isuQwfk3oJJG9pEuKrhYtdnBCMJBsSw8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=M1w7QJEMonxRcLWIRS5LPxtSjbKzGrj0kwEqw7ebgZ6TGEOQEwxX35owgO5DmjR0z
         iD3sk+Ju6q0YkNB94DBLRSQYevtRo56tA2ntq+hO746JsTXUGHbrWBd5gNiTgDQ/DQ
         IarT5bgGLpae4G+IV2CClgDSBaD36Gp7/zDMj5Qk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Mo6qv-1jCHCr3AuR-00pd1q; Sat, 30 May 2020 16:34:50 +0200
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
Subject: [PATCH v5 0/3] drivers/acpi: Remove function callback casts
Date:   Sat, 30 May 2020 16:34:27 +0200
Message-Id: <20200530143430.5203-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TLH3I1kZ/4RoCLR609cAd5CkkvREkPM2JAq81g5rMkxNaLQnDQ+
 En+YRkX25Sn2scR2EVv6z5wE/Wqon57mocitz3KWRvI61P0+897D+c487MqOudRehaHpO6w
 EL32gX+ACur+ObiMvftdM6jr0m9YEmwXeB6QQcOkuJ+kxHCHOVMeTLtR/yCqXK3g5qX43Eq
 gTzTOfhazuiUiisqJMQ9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:e+hkXNAahyQ=:X7kgqKeMlUO7T2y1y3UVSg
 HsQ4CiOn5htqFKTWGiWZHjajnGv2XzPqVhyj2J0ApZ/OIrwmJPmZXvYEWfSTEgdERdUTBS3Fo
 OmyzGSbvHtd6nuGLvrWrLkH8vnygJcxVp5lVtkiZIo10Qn/6pdQa9+fPcA5OJ+6HmdHCstAlB
 bn3b7J3uPn4hnmiJOYCP+R+tIf/l51cu7tqTFzJxetAVzeHWoFQsNSnUmSwLtm8Xy6YrRsCKs
 wlCjpAJls1/JP+m+t/PMdw6zfEh2DLxAgeGYhK3a1y+Y4vELOrAeFAnSOlVKjUC3XMZwfQLqJ
 lQHyQ1nAkmZcdJzj98oq+RVpxBSFGPCHzc8H7By+SguMbfycHLfKp1o73t/uKxcdbybl9U4DB
 izL8A9I7PNKtIFiGRWL75BLFONH2y/5CPjz6NB9Qv14OrQFFss9tvKk8a78puSyCWibthicxI
 uamTBTTk4x6p6ikqi1SSopgtAz0s8fSUViSwX0WQR189IOKp2StD8JLAAawAgSWzgYlznrbY6
 pOvBjys5Idl96AuUTNRpKzzu2l1zJQNld1Yevy+R6bejuku+HQRLeintgxePdF7Wb7XL6cyWF
 ec/kRzWhwNJGEf1zkDRIaQ1+LQpPCXUfeBIARQOIm3zV22Wv6jLeX4cua1vo30KXwakALrM38
 X3H0DtVFSIfUr8PiHmNFy4GHgN2aAG8mdOSxumDfMJPqG0sCuPQ+jTJsHD8ITmQrP+Xgvvyl/
 3BZRM7gP3H0N8uVfptJj1q2JcojXeTsLAzqwvsxccVhU5msxURrDWdXSgeI13wINiVuTB9KKB
 gW7V+9/NNUFx0DwpKHQQrFZZk2Cr+QxgJvpvArJRSZniyoww3Jutq/r4Ot4Lx2LSUomoAfPvM
 e2gy8/kITYWDPevJZDEtBh/fwT3RTfF7Owfb+qCodfo5yeQ9tDMUio6OtLDzWOqRTQEBtzqFC
 2m1iKvxUH2cForraIjk+g81gkrG4LJH7PPzWE0kVm3fhTxfZr3ixI+mmsj+XEXu+c8ta9FSSp
 WegeLWI5XGGBM2S84CRoztGmhwmx0hnpihw4Qwk/8AdyLeNlxvsBO+ZQ9BZHfR6pFkMb9Y4fG
 geSgfEOvmrKNvEeqTvlpUcsemzFdcbkcZzBTfBS+ZKUGyYDqfRDpMKVDhuu/6oUKgl5cihHb6
 ECSIErVUbGPZNsBJ+toGdqYR3kMFgz3rndXcRJFC3otpiqa0piUxPWaGsCcLgTxtqjCpj7cJN
 PKBNQp+AFYV7256XR
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
  Co-developed-by: Marc Zyngier <maz@kernel.org>
  Signed-off-by: Marc Zyngier <maz@kernel.org>

Changelog v3->v4
- Add a new patch to remove the cast of the macro
  ACPI_DECLARE_PROBE_ENTRY (Marc Zyngier)
- Change the subject of the first patch

Changelog v4->v5
- Add the following lines removed by error in the v4 version:
  Co-developed-by: Marc Zyngier <maz@kernel.org>
  Signed-off-by: Marc Zyngier <maz@kernel.org>

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

