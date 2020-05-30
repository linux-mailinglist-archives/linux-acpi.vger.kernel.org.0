Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882391E9216
	for <lists+linux-acpi@lfdr.de>; Sat, 30 May 2020 16:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgE3OfW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 30 May 2020 10:35:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:52997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbgE3OfU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 30 May 2020 10:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590849298;
        bh=SSghX4fQBGTxIf7PjXQdIdo641GED8Z6u8uODLHkLDM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=L8gCbXzL6EKPS8AfkRBg60sOFN3vbAALJMC7py8wlXIGGkK4lXWc2EAPK2TxOUUMF
         500O/PaQNitoNBNzTQnEXe4ujn59ci6/obkcXdeO4xRRh3uNXURRXPlRqFnqfc/5d+
         T8neJQaxaMvvyO0fYNiLbhkDNlGRgWUJ+K1vVR7Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MFsUv-1jmQpx1X39-00HOjq; Sat, 30 May 2020 16:34:58 +0200
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
Subject: [PATCH v5 1/3] drivers/acpi: Add new macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
Date:   Sat, 30 May 2020 16:34:28 +0200
Message-Id: <20200530143430.5203-2-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200530143430.5203-1-oscar.carter@gmx.com>
References: <20200530143430.5203-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VMbpkJlC9z2iGZqsa3hJwDi6r26hEeojKiR18HY8sccgOf7TldP
 Rg/Z1TVPSM6eZgVXCLGW3zCDC7NFuS7NnCZ+quqGcOdkFKfic4obopuS/s/xqGXrmpQvlA5
 pX7uxhflFk5guHrwZSyxtQ9iRQ3v+yWqMyityiKReB4eB2sEU42wb+WwlvG8Hd4C/hZ2Yoi
 5NDs4Q85gOrUd+MKNTAGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HOkbiwqPs2g=:4rorHEqjsGladeRvpVY1Jg
 5gG1LP/CUqmOXXyFaVWAwBJjwM9NBENHow4ziciD3WSB4g1sC3oARZ9EGCvK+JcyKFbn/Wq7M
 o2QYoTXwGN0BPcTIMkjiTDuP1kI6N2Mmu3u58dADUsRKJ0g4Vra6cGBx3aj9TCDgUPN2afT/d
 MbEJaSPDlTUCYSALntyv6JJMHOiHqLka+DslEP4PyYR7AdYSnElpWKxv8FEvCqsxm8wcxB29L
 NMwhy7Dfo8Hj3+rCEpFQIL9RDcjiO89rrjb7JQYs6GTdAMZn2/0daE0gnPxjh1pipgiP3x7xu
 /mdwDj4wVMmgW/68sJanmt6yH4DoUrVww0HpB78bsbeGpYGQwctFtOdRqmvwRO6wFAzyxHMZw
 FBRHG2LFh4w7f8dgNpNMhbl5rTO5/4ATo7NIXyJdCXMewu1LDqRXja+xoKQY8Dxm+SMFTWW+E
 vvGdfYnR8+G4fibkh1dBCytAFcfhHlVuk3ENSzQQuDZTxJyF4q2E7o6vgCvy9q/U36hKqWkUX
 UocC8Uu8ZhlaRPK8z4xDKkPUUeqWIqw7GiENWigGwpySXmAaSebvwmC5kejmR+NAb9xpIa+dK
 FgX/92JfFhvg7icCqzgNhME4onGI3ZOQVhZY24RulzDBnnzwMH4FPIj9AHpocRu3NQUwDYyEs
 pSuFirNpC/lRYc5XEdZl7s3LUH5edju+twzPir08jnQeRiC/O7EgGW1hntRYxCsIMVC/V4iuU
 6dUGiaI1Y2hliNTFIxQ26oaSOfUQNI4XepP2rY4Dai8T2OO33crv6nAj8Q1W2uUtABy2H5xbB
 y6PlAdiZBsi7WAYScUw6JbJLNFeGpgOqg8erdcdiwvziBRH6XNVhY3QZmiuaBa1PE/2612Bik
 cJXlJdkm1XkgDAMYaIWCO8cFNEFxjBErbggvQDLipYHw/hRNcTq0ppm3gSWNj6ReCGKVrvWDm
 ebGk96z00nRLRuE5aNwJvR79zbAnmNTvN3YgZ4Bjtk7U0tN2bAQrzWRjvlqZ1oHzCQgoDhuMj
 mmJAGP9CSGnrNPfND4Hbo2km3lBtT7HY6rlWsBJ1SDJyePgpANF0WqS/44xDbNS8e959Wkamd
 tWH39wlrPnifiaC7QVabVxaYAXevLaPVm5NTqEQzhZ+IIfBuYfbNZbaWxz2ZHBspqWLZRVNuI
 DbLwH0CcSCLipNuz489vq9bPwpLBsLYqn0hRGjSqj/unwmDNgFZeXB4QVnh6VvwXaZoqiB6y1
 pqRTmIK4Ats5yAipC
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

