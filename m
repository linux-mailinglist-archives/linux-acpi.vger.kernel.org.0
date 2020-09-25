Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC05327842F
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 11:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgIYJiD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 05:38:03 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:10142 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgIYJiC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 05:38:02 -0400
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 6F73E2008557
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 09:38:01 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VFCsKEro"
Date:   Fri, 25 Sep 2020 09:37:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1601026678;
        bh=a4b4rc+EQaWNlnyXjMiEsFGlt7vu4qg954Q1DEdwhkU=;
        h=Date:To:From:Reply-To:Subject:From;
        b=VFCsKErokakTVyYb3HVsqPkw9nMD2LfbmuelZaxoRDnZTuda+5JA1BFsCV7YBG7oE
         tKcDhNk2jWe6VjEGlBdpba2clZ3udKePWMlCUlVJyMPP7RBU3w3ait+aO15u9xpzux
         mNHQCol9x20XVUu1bTSFWg8nW411jWbpFrzbeOMs=
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: [PATCH] ACPI: battery.h: include linux/power_supply.h
Message-ID: <6_vrlQfVYcRdLYK5BlS8E-_nRAXwCcIc-A2BAszjnowG_e4C-wMy6rdjbZZ0DzCJOMzHZfYUnhaHZfRIXFNE9Vp-23q9R2j305D26c3-EMA=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi/battery.h uses 'struct power_supply *', but fails to
include/create any declaration of the type. Include linux/
power_supply.h to fix that.

Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
---
 include/acpi/battery.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/battery.h b/include/acpi/battery.h
index 5d8f5d910c82..b8d56b702c7a 100644
--- a/include/acpi/battery.h
+++ b/include/acpi/battery.h
@@ -2,6 +2,8 @@
 #ifndef __ACPI_BATTERY_H
 #define __ACPI_BATTERY_H

+#include <linux/power_supply.h>
+
 #define ACPI_BATTERY_CLASS "battery"

 #define ACPI_BATTERY_NOTIFY_STATUS=090x80
--
2.28.0


