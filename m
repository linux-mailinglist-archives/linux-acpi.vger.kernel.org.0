Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 809EE69364
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2019 16:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404208AbfGOOny (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jul 2019 10:43:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46606 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392030AbfGOOhr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jul 2019 10:37:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so8368814plz.13
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jul 2019 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zPd11qsqBV6enPH1pgmEhMrw3DVmEsKL+rgelJGu5E=;
        b=XStDr0pOpAvfMPGvyaCiXhax5OpTI8omiicJPCmLonS9L7hbMWB8WbkqauDTlsAue1
         /IzXyBhFpxdPHPkwfVRCjLPZYScMK7RsrUnJmmgQGxgyicRfMpFtWxfw1YpluI/oDB0w
         mhjDfrjf8F43ROWC4kjFdePNxqWjxG9UE7yCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zPd11qsqBV6enPH1pgmEhMrw3DVmEsKL+rgelJGu5E=;
        b=S3wQgn6DgreRRWS3+Tg9gxuhd3kZkS42xJ3UruMtFUCEMqYaZAzeN+zzgw6GFrmvQP
         qqWG3uQ1zvU2H0ujw3kZla2u5/5BgOH+fqi2+DmxcY3dMrhzhdQS4ukuk6zVxeZYjWIB
         fD4AKFIABG//dPoG+wdJSat7R43yBU7mHoUv4gqI/iAeiIXtJTjB+eXp38g17Qj2RNVu
         nhveLY1uuNLLjzxUZJyw7LLeIbSsM/S5MdFnJIYCjVuKdq6jLvkw1/nY7PB6URfTiBqk
         sL39a+nz19izuu6ujgPSEqVrNZ/qSEAYDyxU+Q/kfTGpWLzKu3XFw42ZJBq/eRyfF/mE
         2IXg==
X-Gm-Message-State: APjAAAUILLx/nK4nnwoE2u95bDWAIIUe9uwcydRPFE3X5DE1cEYM/5Sk
        brNHtQxVRwWL0d/eI0Ndafg=
X-Google-Smtp-Source: APXvYqzkIpFv5vPuz81gmhFr3B+gCTSP4FKDqSNzw1vK/5n3JtNPasCMdlzt1VHFYex1IyUvrWl66Q==
X-Received: by 2002:a17:902:2889:: with SMTP id f9mr27373830plb.230.1563201466638;
        Mon, 15 Jul 2019 07:37:46 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s66sm18381852pfs.8.2019.07.15.07.37.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 07:37:45 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 8/9] acpi: Use built-in RCU list checking for acpi_ioremaps list (v1)
Date:   Mon, 15 Jul 2019 10:37:04 -0400
Message-Id: <20190715143705.117908-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190715143705.117908-1-joel@joelfernandes.org>
References: <20190715143705.117908-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

list_for_each_entry_rcu has built-in RCU and lock checking. Make use of
it for acpi_ioremaps list traversal.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/acpi/osl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 9c0edf2fc0dd..2f9d0d20b836 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/lockdep.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/kmod.h>
@@ -80,6 +81,7 @@ struct acpi_ioremap {
 
 static LIST_HEAD(acpi_ioremaps);
 static DEFINE_MUTEX(acpi_ioremap_lock);
+#define acpi_ioremap_lock_held() lock_is_held(&acpi_ioremap_lock.dep_map)
 
 static void __init acpi_request_region (struct acpi_generic_address *gas,
 	unsigned int length, char *desc)
@@ -206,7 +208,7 @@ acpi_map_lookup(acpi_physical_address phys, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
-	list_for_each_entry_rcu(map, &acpi_ioremaps, list)
+	list_for_each_entry_rcu(map, &acpi_ioremaps, list, acpi_ioremap_lock_held())
 		if (map->phys <= phys &&
 		    phys + size <= map->phys + map->size)
 			return map;
@@ -249,7 +251,7 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
-	list_for_each_entry_rcu(map, &acpi_ioremaps, list)
+	list_for_each_entry_rcu(map, &acpi_ioremaps, list, acpi_ioremap_lock_held())
 		if (map->virt <= virt &&
 		    virt + size <= map->virt + map->size)
 			return map;
-- 
2.22.0.510.g264f2c817a-goog

