Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0DB405D0E
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Sep 2021 20:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbhIIS50 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Sep 2021 14:57:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65520 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbhIIS50 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Sep 2021 14:57:26 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 309e9d24b06a21dc; Thu, 9 Sep 2021 20:56:14 +0200
Received: from kreacher.localnet (unknown [213.134.181.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 37A2666A4BC;
        Thu,  9 Sep 2021 20:56:14 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPICA: Update the list of maintainers
Date:   Thu, 09 Sep 2021 20:56:13 +0200
Message-ID: <2610743.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.77
X-CLIENT-HOSTNAME: 213.134.181.77
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudefledgudefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppedvudefrddufeegrddukedurdejjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurdejjedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghnrdgsrhhofihnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Erik Kaneda will not be maintaining ACPICA any more, so drop his
address (which doesn't work any more anyway) from the maintainer
list.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS |    1 -
 1 file changed, 1 deletion(-)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -364,7 +364,6 @@ F:	drivers/acpi/apei/
 
 ACPI COMPONENT ARCHITECTURE (ACPICA)
 M:	Robert Moore <robert.moore@intel.com>
-M:	Erik Kaneda <erik.kaneda@intel.com>
 M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
 L:	linux-acpi@vger.kernel.org
 L:	devel@acpica.org



