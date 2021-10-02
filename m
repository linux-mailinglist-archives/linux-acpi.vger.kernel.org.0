Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9BF41F9E0
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Oct 2021 06:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhJBEqt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 2 Oct 2021 00:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhJBEqt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Oct 2021 00:46:49 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7825CC061775;
        Fri,  1 Oct 2021 21:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=r6g82CisCmXF23aDh6/Yob8NqFKFNYUbpI0fuA/iR/A=; b=WzXOriUpcILM1GsfYhOXO7Fmmt
        Dv5u4sSt0Wl7MQh6J5Pe5OXfGDzAMZaKYYotx67k+uqBALeyARuUYegZKvcIyeD9K+xZNQy242HBZ
        3B+eAil6N8AXRSowg5ZdMC2hD6PRr8VxDM7Xbzx99RZUlJFfruRjiL+9efTCK5APpROgW2/7uo8F5
        Y2oyei/qTRbLpyeoiX7/7iwJ0Qd7BaeCrdVqkgqSGy0DRXt9PNP6xmigdOGBPua5rZi1Bi2940p75
        0UeqsX38Cnli/BMxzZgEGA1vW+vh69GgvgV44xv4nZApVlwWbgaT8eKPw0hXyFi+EJJBLWjE3YNnq
        GIF381yw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWWtS-001mbD-LN; Sat, 02 Oct 2021 04:45:02 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] PNP: system.c: unmark a comment as being kernel-doc
Date:   Fri,  1 Oct 2021 21:45:00 -0700
Message-Id: <20211002044500.24306-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix a documentation build warning caused by the comment not being
in kernel-doc format:

system.c:110: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Reserve motherboard resources after PCI claim BARs,

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Aditya Srivastava <yashsri421@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org
---
 drivers/pnp/system.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211001.orig/drivers/pnp/system.c
+++ linux-next-20211001/drivers/pnp/system.c
@@ -106,7 +106,7 @@ static int __init pnp_system_init(void)
 	return pnp_register_driver(&system_pnp_driver);
 }
 
-/**
+/*
  * Reserve motherboard resources after PCI claim BARs,
  * but before PCI assign resources for uninitialized PCI devices
  */
