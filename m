Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8151A1E84A1
	for <lists+linux-acpi@lfdr.de>; Fri, 29 May 2020 19:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgE2RTl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 May 2020 13:19:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:48865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgE2RTl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 May 2020 13:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590772760;
        bh=SSghX4fQBGTxIf7PjXQdIdo641GED8Z6u8uODLHkLDM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cTh6g67vPidzhusXMiiOXzRh2/xcUyHgOUse9mkFeBTjoojXuy0bAQWGX9TJkBj+I
         OL8omeQ8PHgv6K5/DngMw/EZtj9VhfxUKaXWsLneGXqbsLRlfC1mD+DNbYFiDrT2aZ
         f3QKgRcHxlKKe/qc5mINlUCrIHnY4rUceTSevThM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MqaxU-1jA6wZ3U5Q-00mfVU; Fri, 29 May 2020 19:19:20 +0200
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
Subject: [PATCH v3 1/2] drivers/irqchip: Add new macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
Date:   Fri, 29 May 2020 19:18:46 +0200
Message-Id: <20200529171847.10267-2-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200529171847.10267-1-oscar.carter@gmx.com>
References: <20200529171847.10267-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rdaSFSQvyzluIQEylm4cUlsIYa3IM62+UJqstrmCUjnSAfZ7Go+
 mLXSMyT5rc6iZdKd8YcgHLT1bROWSa7tzBdY+DgUjeO0rTWcRNkGTYBCI6wIzhJa9kzm92l
 B9ISgIG0Atx+KEWvnKYfS9EoqJZovI8UkostenIRlfTK2sutw9evu6jBiXptbifD56dwmpV
 Ic6fXNOgJYcHF3o0ZjLtw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B8FFhg+6+eE=:yTZz1wtcsksQD5aBjUyp1u
 gdWRPiklZ9r9msMJHM0+V6l5WCfq6EwZr7hhcW6tDl1DgkmG9Dfgkn3I+oEiarScWMJJVXBfr
 6XpV8K00igtTs0JY8wBREVWl0KTCRgV8HQnsJMvz1SeekaQAvZP/GB1H6EoMYccS9lHFfHzo1
 quUs3FFVOsWggtOYshYWD5etQVNlDjK2VBK5eNt1oGPYAFdgSOx+gBQpH6s44qVzn9ue73qUm
 VydN3ZyR9YVMNV8X1Z74izVkk8d4W3oZBzbOHmRAsrOCH8ILghkebyx1EmEA7RlIUHhpXlu/c
 W9q9aDgkYS/aNTnRKEKaKtzE/oyIIXPXrHA0k214bSelW7/kHu4guMgWhd+3S+a2fCPtop4MS
 OOm3zkOhPb5QGgZcYATp12BK7uvX6E5WOZno40XsBQDAfoY2oY628piG20/qalJAHI337CgT8
 gAyStAbBzmT6lJ0dGXIdfNClzxlbuo+71nOKcK6urBNuGfvFngN6A0+sMHZ6q5eTo32TjEHbQ
 S5pH32CjbtPzFn6j6PKCsGw9FoI+5GzJ++4MmYbYIpMIPdXJ1KT2Jz8pp/qGuAvm75dZV4KdE
 QDoojVvSYuA/18bVOcMt2LglIb94Mc2sKtKnGKjLO61INCvQaNq5/1czi06r4E7f6CejtdvJM
 Cv9/wSqIZTishRyXJSSjOP6mO4bkciHGmhcjOstTlJltTOlhzqRaN4qVFitHSfLzhG0HlcqB4
 jSOgNbx12FkiNR4g6yPS8vkCi1nfT5JusGEnlIxSMJOE3cjFWubnCbFTBOT6/NmXFnHVfzl26
 RW3l3a821UFXImKIYaru69xYAjGAO5+9/z+EFCeR4fms4iQc9QAjRMaBtECICNxKMeIhdRU7K
 ZcdAnHIDW8mmfozW6HttAeP3D7UPusneDiD1+iicWPmb+YRdpbXcxE8obhUmP5fpZMkKS1KhA
 egyumwHaimpPQAn7L9PH8n9typUFZASXoFNeUaLkJ88t32xviuV0mJsFgEgYJzNAw7wFx9yzE
 Fb8jDob464yQlYRJtGODGC1CujCIWnkGVhKYUtsd4Q8a/hS27s9ohQHM/o6q2fcH8czEBoARp
 847P860ThMHEXE55M+m/HTByaEtDWvMhLqCJqNSTBSTM+zZKXPp7P2m0i+qvUQ2VqFzWzMaaa
 AKxc9ICQ3G3caJhjtioUC2v94TApojbPuv5SVSdeyq+23bmLjNwLTovIhS8v7dsjCqMNx+8YA
 vB8zqDKJ7bttSdsmf
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In an effort to enable -Wcast-function-type in the top-level Makefile to
support Control Flow Integrity builds, there are the need to remove all
the function callback casts.

To do this, create a new macro called ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
to initialize the acpi_probe_entry struct using the probe_subtbl field
instead of the probe_table field. This is a previous work to be able to
modify the IRQCHIP_ACPI_DECLARE macro to use this new defined macro.

Even though these two commented fields are part of a union, this is
necessary to avoid function cast mismatches. That is, due to the
IRQCHIP_ACPI_DECLARE invocations use as last parameter a function with
the protoype "int (*func)(struct acpi_subtable_header *, const unsigned
long)" it's necessary that this macro initialize the probe_subtbl field
of the acpi_probe_entry struct and not the probe_table field.

Co-developed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 include/linux/acpi.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d661cd0ee64d..cf74e044a570 100644
=2D-- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1154,6 +1154,17 @@ struct acpi_probe_entry {
 			.driver_data =3D data, 				\
 		   }

+#define ACPI_DECLARE_SUBTABLE_PROBE_ENTRY(table, name, table_id,	\
+					  subtable, valid, data, fn)	\
+	static const struct acpi_probe_entry __acpi_probe_##name	\
+		__used __section(__##table##_acpi_probe_table) =3D {	\
+			.id =3D table_id,					\
+			.type =3D subtable,				\
+			.subtable_valid =3D valid,			\
+			.probe_subtbl =3D fn,				\
+			.driver_data =3D data,				\
+		}
+
 #define ACPI_PROBE_TABLE(name)		__##name##_acpi_probe_table
 #define ACPI_PROBE_TABLE_END(name)	__##name##_acpi_probe_table_end

=2D-
2.20.1

