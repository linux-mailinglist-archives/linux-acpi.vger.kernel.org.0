Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53947297497
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Oct 2020 18:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbgJWQhy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Oct 2020 12:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751830AbgJWQdt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:49 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C76F52468E;
        Fri, 23 Oct 2020 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=aze7TjC84Uc8SJubYPng7vvu1DjXQUzWlcB1MzITV/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e90TF8VCkorCRtM6nS/rGaOYyNg8zUk9M0V26eTmEwfcYP8i1I7eTEyjPbvQxBG2u
         NmAa/1etwUe303x9xBYf7sUmmo1CTqadAmqO3LCWBMPpD9DyH4qFU4o0ZSp+S+Mbio
         DElJDr6y+gAb7CZ0YZ6sjbvjxfJFqeVgQGy1Ys2c=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00f-002AwN-Pl; Fri, 23 Oct 2020 18:33:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 24/56] PNP: fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:11 +0200
Message-Id: <1e3d69e0890a36303f4c804ae9c523df9f098d6a.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It sounds that there were function renames. Update the kernel-doc
markups accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pnp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index 3bf18d718975..a50ab002e9e4 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -51,7 +51,7 @@ static void pnp_remove_protocol(struct pnp_protocol *protocol)
 }
 
 /**
- * pnp_protocol_register - adds a pnp protocol to the pnp layer
+ * pnp_register_protocol - adds a pnp protocol to the pnp layer
  * @protocol: pointer to the corresponding pnp_protocol structure
  *
  *  Ex protocols: ISAPNP, PNPBIOS, etc
@@ -91,7 +91,7 @@ int pnp_register_protocol(struct pnp_protocol *protocol)
 }
 
 /**
- * pnp_protocol_unregister - removes a pnp protocol from the pnp layer
+ * pnp_unregister_protocol - removes a pnp protocol from the pnp layer
  * @protocol: pointer to the corresponding pnp_protocol structure
  */
 void pnp_unregister_protocol(struct pnp_protocol *protocol)
-- 
2.26.2

