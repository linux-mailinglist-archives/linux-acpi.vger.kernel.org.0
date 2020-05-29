Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCB51E84A4
	for <lists+linux-acpi@lfdr.de>; Fri, 29 May 2020 19:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgE2RTr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 May 2020 13:19:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:37435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbgE2RTr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 May 2020 13:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590772765;
        bh=neh9UrSP9bO+wKS/cV7Mb81hOYu1y9//cRNSX6IME/o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=T1T9LR/w3kBuqWO8Su09Op1EFM06tPZn4twLi9YwSV4LstFuZw8hrEoa5l5R8Ij+u
         ZhaED2tY7CVwC6hqKCXXxiMNO5bZyR/xtHF6Uuq1dsQs6PfCfmY/avjTdNxiXYzpcP
         EFtXIpEhp+7VbeTeVLwOTO8oifcEU8hmbUULqkx4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1Msq24-1iqCVY3XtA-00t8ge; Fri, 29 May 2020 19:19:25 +0200
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
Subject: [PATCH v3 2/2] drivers/irqchip: Use new macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
Date:   Fri, 29 May 2020 19:18:47 +0200
Message-Id: <20200529171847.10267-3-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200529171847.10267-1-oscar.carter@gmx.com>
References: <20200529171847.10267-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xbh6bc2AmKF5eUpe1JkLy04Gyi3Hb9L75YPMV4IOuT+BURFd86X
 QvCGG2899ZFmQmHxw4xv0sgrlbLGNr6vXbyyEUTV/j7WUl1KXnS/cSM5ZOFaWzMkqwMOUlh
 lAJfFVQQErGpc1+tiKPw+AKBMTpJ+duPgHDtZcDIR2dt98493If6An2WKlqLdDcZVvsdgWm
 i4pAUsQPQz8viQ6vtuxGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cK5pSdYPuYw=:cgBVRC43BeXuVFlw7NN1y5
 UBXR7VOvd0fbpnIL6EOPaqUSD23+KtXJCFi13A1RPvw8934ONa3QUNJ7HeK/a5bELNDW7b3YV
 KpTux8y6DvlapqfhfKnBO7UQdH1mCUag5uLd2i182hO7RMvZGeS3z2oacIuSL+RSGk9WNlv6z
 zO65gGkxuJ6zKQ40vXqeWeExhzToVnsnUvPQrWtay+tn2biPumJz7OW9gs+hg7UnsZC5UBNt4
 6sLnj3EAJ3+rCMalXr4hJZEqzF7QkGNjfZPQuhEQGvoNptSDGoNK/SVDnIlNONYolOex5b2xF
 l4OR1jWPkPgpgfCimojidEoKin2EOE4GIiWTIYemXBeDT5ge8tpjsgam6RyakcNL3vKFnimRp
 OEeEoFVAhbQx7ag34TEdyZNAIBIMA1UbLQqAYE7UkKe88alRgBcxkIUGwFrM4VrlFFKpnf0zq
 aMeMXpeLnwN/me1S6Ua/QQDh6a9GKaBI24WI5MBAV/NTT3Nb8A1uIEIXbhIK+6DI8Vjw7i8ZH
 FXPpQyQVgxAbv79UcORvXb3CIqQOendix1Wv+xVum9hlR8DnSa9SNwDBgcWkgNO66s4P/xOkR
 LHbYU5feM+QDugil6JBHIp4zng6vfNOivSdrlQYGqGBBXO0FH+6PulUw9HPSvYtbQALOjgUuj
 SzSkhRkjkJxNsKX5V69hnISQApJtYKEsS+hVrDq1aQUL2oT2xEeBtowactJKMHGJjJyzTJ74B
 CErkJPo9H2mmYdekKODtaN1f5AciV2dquEQ4TrZYhT6odGevQ8b+AFAYy7T9QffDiTmmxMD+7
 d++FsMUhOU14+kbGAMHvURc2e/4+sQdmHgD30AO3P+5TxeP+0wsXY1OpbkjU0uyMy+heXlkXt
 MQU0HWuo5plfNxf7lFqtCMHCtBr6EvywqKFZdock4Ux28MYfR3Tkmc30hxehESkh9eNpqkot+
 +9MQOnIjBslV8o/OIIKFBqwCEYQEJV0mnvxcfqJaPTWGLI6wLp6WDMiavYTxiQ1Wn5MI5cH+a
 zJEV44S/t+juj945Snbv+AyrmHKEqXYFjXN9vOjkVfdeT0MUYHUAXcn1WZqgDj+lETTD2cNAv
 87YicXY4DNA7+t58loMex8QgKKsG5fwW32QziQXxbLGxAsg5JSB9xgtQwlT5O57mZF8YIRkFM
 3hjnCIOTRWMXbjZvmAls+EGFwqVP0BBo3O6nDyTf1bbPduV0ReV+HL6X+e28Bxod0ZNLwFl13
 qMzqawkInlseylrYd
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

