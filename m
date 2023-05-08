Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245946FB62D
	for <lists+linux-acpi@lfdr.de>; Mon,  8 May 2023 20:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjEHSD1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 May 2023 14:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjEHSD1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 May 2023 14:03:27 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF44AE5A
        for <linux-acpi@vger.kernel.org>; Mon,  8 May 2023 11:03:22 -0700 (PDT)
Date:   Mon, 08 May 2023 18:03:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1683568993; x=1683828193;
        bh=tnQrUpBjZ5FWw23LcCAZJiqdu8dL9KhQ+9q8BrAIc88=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=WesZj9t/SdqGrmMkq/eotDjug9THB0eN/dClw1wgVQ56mZaxBQpxJsc/TYX8Mo8Mr
         wD3eRPP1FWpnvX7eU66T3DZ7NANTwQ4zVYUtebGxyHpqp2LNy/3JZa88h2xgkL43fx
         Lp7GjXqGVdruNmVE2xZaZFyfx073WBZaesr6BRL46y4a9dgD5WrV9UV3pTYPLO4aVD
         ERrx2mc5j8OpaXD+8fgAs3NY2Qw9PNPTZPZufeAPLqUf5qJIi6oZgdjItSj8vyR/K9
         J0o9EhPy0EGL2PVJ/+EJ2y+H27YcsN0HbaT6Ad2hGDpNWhjEu6noXEVEl637cIwzgJ
         ACrTCyAxwOfUg==
To:     linux-acpi@vger.kernel.org
From:   =?utf-8?Q?Rub=C3=A9n_G=C3=B3mez?= <mrgommer@proton.me>
Subject: [PATCH] Laptop internal keyboard not working on LG UltraPC 17U70P
Message-ID: <jzqzwdedY4SnVMhKdJpA2nv5eA7o6COWGesAYO0Th3IXK2Pu2UoYfKlhd0YJhospEusFM-qmJG5Mzo-vGhE9VzVWebfqbyYlDdk7ZeDUXCI=@proton.me>
Feedback-ID: 66491317:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

This patch, destined to the specific laptop model LG UltraPC 17U70P, solves=
 an already known problem happening with some devices where the keyboard IR=
Q is handled with the ActiveLow attribute. The kernel currently ignores tha=
t, and as a consequence the internal keyboard stops responding as soon it l=
oads up. This has been extensively discussed in bug 213031 [1]. From the wo=
rk done there an ad hoc list was introduced in the kernel to handle those d=
evices, as seems like other broader solutions would cause problems to other=
 devices. This patch just adds this laptop model to that list. I filled a b=
ug specifically for this laptop model with number 216983 [2]. Patch is alre=
ady tested against commit 7163a2111f6c in the linux-pm branch.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D213031
[2] https://bugzilla.kernel.org/show_bug.cgi?id=3D216983

Signed-off-by: Rub=C3=A9n G=C3=B3mez Agudo <mrgommer@proton.me>
---
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index e8492b3a393a..0800a9d77558 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -516,6 +516,17 @@ static const struct dmi_system_id maingear_laptop[] =
=3D {
        { }
 };

+static const struct dmi_system_id lg_laptop[] =3D {
+       {
+               .ident =3D "LG Electronics 17U70P",
+               .matches =3D {
+                       DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+                       DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
+               },
+       },
+       { }
+};
+
 struct irq_override_cmp {
        const struct dmi_system_id *system;
        unsigned char irq;
@@ -532,6 +543,7 @@ static const struct irq_override_cmp override_table[] =
=3D {
        { lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true=
 },
        { tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true =
},
        { maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true=
 },
+       { lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 };

 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
