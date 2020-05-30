Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE41E9219
	for <lists+linux-acpi@lfdr.de>; Sat, 30 May 2020 16:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgE3Of0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 30 May 2020 10:35:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:60261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbgE3OfZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 30 May 2020 10:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590849303;
        bh=neh9UrSP9bO+wKS/cV7Mb81hOYu1y9//cRNSX6IME/o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Gage6s6P+ywkOKvWAUrO/6qoivELPDqxdLIDl7Gi2GWRuVJ8xx45oAKhuehIP5qlt
         O1YyDs/DsSke1xiq6Qsyri2WFKGoe0FSGISrgwU7wXhNKem/fX01m3Pj5ZKXVkR8Di
         vT36vpjo0yOEOqpPvDdPykXIgSVtfNWy3/MwgBgM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MaJ3n-1jT7pb42dR-00WBlg; Sat, 30 May 2020 16:35:03 +0200
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
Subject: [PATCH v5 2/3] drivers/irqchip: Use new macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
Date:   Sat, 30 May 2020 16:34:29 +0200
Message-Id: <20200530143430.5203-3-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200530143430.5203-1-oscar.carter@gmx.com>
References: <20200530143430.5203-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M4l/lu2Ot1isOnN2R13KTRlp5jrXN1XOyn2M/ueqxzZSv7vJOol
 B4I+tRfi763kyiRl8FHathgnioeLXcUFcfGiEqsF+IY2BEa5iknZGem9joaTY1fivqg8HDt
 yVEdPaSqyfcjtKy9Uz6pNZAeUP0DCieRiGUQKy/NSlHOW+iyhaD7J35JYOP6b/e3Twc43YV
 JVZT1u7JJVrDT7BDyk37w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:98X3ue3PCK8=:Ro2SzzpR4fxqY6xevdTRxj
 Si+zeF8Jx/Ck5U6jDOItwHAgZhc6KUD0YbQE6Zv7NF0wzF/S705KH7lx0cKPZlNKJk4HOZg9C
 0SfzWyaD1+JXzLy7ktjrWE8C8of2eCqyCwcY2CBjfJOzNAvwQczfS19boVeIz64aeYxDb8p/h
 6OG5Fyxwc43v4nKRnTJ3iowBt6Zy1L5pnRbJ4EiARp7iYju/A6dDxbxHvA3l1ePX17N+dPpr1
 tQ3JKS8OkH3Ni39gKvKa/Grx/3kK6XyW+W2GltM+Sr8vyQNcKcNz5XC94m+Qvge6hz/Y7z/MY
 TMYPyGY3zz8qBgfW+zhdc0S4PhKF/7KmmOMyfozQHra2O9aeckCxnDReycfTzR0LuUR9Vz5ll
 snrz6yO7yje/DBkipzPybXdB6aA3U8mWDd0dhUZNiUZuiZOebk9OrZiYJm2A9HdAeKr64lyHi
 CXKO2Aep8bHLR2DhDvJ3EXWb+ug7ZMwScVCBBJg6TL9tjT4cHMjk7lXnNz1p3JPvErN28ob6E
 JT3xN0EU0Ks9EF3jyau3WYQwKeY3s64eFEXK+Uett94fK1aTAV0Wye7pCOOeBb4U7J2vp+JwG
 ELe9bJfu8jhePNPHEBFJy5xW0JncfVANKrUuq1ixp2T5mUYysd/XKApmG6zL/DwNS1ziUjnBe
 ERcbYXxzOxk1oTyZidzGRT7+d+k5hK/qwJwYTHUnMGinaqPA5xXU2lMbpMmt5794E1ZmJzozS
 YvUQCkF9bgoIZZk4t3HieqqQA7Qx2X0inLQ2WWYogCfiwQ1/rAx4lwrhnrKVwIoU3MVcdX1zW
 Ol2+7isFcMaiHrRE1rjGtLFz+p/me80JHtwJECQ2BI7K+mpf6DHOHCklNZHvW9E2DRHOVGP4w
 lKiEtAmwptzHL553zERLTNKztFCgomtt7x5mhpjtYRt3Xz4PaBzEzHXnTOqAXubeV2xGqlP9r
 0i8a5p7VI61JByjOXDlQpuNVv6Bpq19u2/KIOFS1/pwfm7iZBgb+LrLLgAZmPSdYpDd+5Z9NB
 3ffH/lpB7yBuqres4SKTOvZl0k176MSMVFy2N7UBCaFAbqKBYUt4otf5HBAvPO+fJT4uyx3ci
 3B9R+ZUYf6/1A27MM1EFdaXRUbPKlz76tVQ747vlrI+uoeImupOseTAfzXCQJCtD0qmmz9gDq
 B73bJxilzmR7RVBVnzgTK1fNRD4HqLbVZ73lyumWQlKYX29KJhDuGYZEiGgKnQ131T/VbQjcJ
 NGGlGTrjbdItsZhPR
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In an effort to enable -Wcast-function-type in the top-level Makefile to
support Control Flow Integrity builds, there are the need to remove all
the function callback casts.

To do this, modify the IRQCHIP_ACPI_DECLARE macro to use the new defined
macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY instead of the macro
ACPI_DECLARE_PROBE_ENTRY. This is necessary to be able to initialize the
the acpi_probe_entry struct using the probe_subtbl field instead of the
probe_table field and avoid function cast mismatches.

Also, modify the prototype of the functions used by the invocation of the
IRQCHIP_ACPI_DECLARE macro to match all the parameters.

Co-developed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/irqchip/irq-gic-v3.c | 2 +-
 drivers/irqchip/irq-gic.c    | 2 +-
 include/linux/irqchip.h      | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d7006ef18a0d..3870e9d4d3a8 100644
=2D-- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2117,7 +2117,7 @@ static void __init gic_acpi_setup_kvm_info(void)
 }

 static int __init
-gic_acpi_init(struct acpi_subtable_header *header, const unsigned long en=
d)
+gic_acpi_init(union acpi_subtable_headers *header, const unsigned long en=
d)
 {
 	struct acpi_madt_generic_distributor *dist;
 	struct fwnode_handle *domain_handle;
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 30ab623343d3..fc431857ce90 100644
=2D-- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1593,7 +1593,7 @@ static void __init gic_acpi_setup_kvm_info(void)
 	gic_set_kvm_info(&gic_v2_kvm_info);
 }

-static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
+static int __init gic_v2_acpi_init(union acpi_subtable_headers *header,
 				   const unsigned long end)
 {
 	struct acpi_madt_generic_distributor *dist;
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 950e4b2458f0..447f22880a69 100644
=2D-- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -39,8 +39,9 @@
  * @fn: initialization function
  */
 #define IRQCHIP_ACPI_DECLARE(name, subtable, validate, data, fn)	\
-	ACPI_DECLARE_PROBE_ENTRY(irqchip, name, ACPI_SIG_MADT, 		\
-				 subtable, validate, data, fn)
+	ACPI_DECLARE_SUBTABLE_PROBE_ENTRY(irqchip, name,		\
+					  ACPI_SIG_MADT, subtable,	\
+					  validate, data, fn)

 #ifdef CONFIG_IRQCHIP
 void irqchip_init(void);
=2D-
2.20.1

