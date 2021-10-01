Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA4441F4D9
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Oct 2021 20:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355682AbhJAST0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Oct 2021 14:19:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50840 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355650AbhJAST0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2021 14:19:26 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id ff1e06f515a14179; Fri, 1 Oct 2021 20:17:40 +0200
Received: from kreacher.localnet (unknown [213.134.175.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id CD53666A7A3;
        Fri,  1 Oct 2021 20:17:39 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 4/4] ACPICA: Update version to 20210930
Date:   Fri, 01 Oct 2021 20:17:06 +0200
Message-ID: <7993379.T7Z3S40VBb@kreacher>
In-Reply-To: <2236872.ElGaqSPkdT@kreacher>
References: <2236872.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.164
X-CLIENT-HOSTNAME: 213.134.175.164
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudekiedguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfektdehueehteffueelleehhfffgfejtdehvddtfeetjeffveetheehvdejgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudejhedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduieegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit e01cc6b3d12b5f73f44d46fa15a7f569c793b328

Version 20210930.

Link: https://github.com/acpica/acpica/commit/e01cc6b3
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -Nurp linux.before_name/include/acpi/acpixf.h linux.after_name/include/acpi/acpixf.h
--- linux.before_name/include/acpi/acpixf.h	2021-10-01 19:33:19.411192223 +0200
+++ linux.after_name/include/acpi/acpixf.h	2021-10-01 19:33:15.880251109 +0200
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20210730
+#define ACPI_CA_VERSION                 0x20210930
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>



