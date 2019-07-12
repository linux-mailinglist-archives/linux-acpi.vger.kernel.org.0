Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3CB566268
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2019 01:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfGKXot (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Jul 2019 19:44:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36045 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730499AbfGKXoe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jul 2019 19:44:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so3468229pfl.3
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jul 2019 16:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ZIVHYCgJL3yRIi6SYczqkcDc7iwVPEmctKSmd2Crvc=;
        b=weyT2Xtq2vSltoDfjRS7QyAHHP5rgF8+biSlRsYiS8lJ0ThTHGlPYRoWyR8jXC62XM
         l5SwCMDem7+8P/pejjNL1kUvgWDcvhvqPo2nGj5eahzpfUT6jCwtf4+D4JJiDwbxZ585
         8qs6F1/k7sh09QSdaz8CSnrGSPZzQbFmNT4a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ZIVHYCgJL3yRIi6SYczqkcDc7iwVPEmctKSmd2Crvc=;
        b=EZ5FJubajPPX+BNgTjzdC0UhLbjG22Yqas6ZYHgymOCjajifjOmC1DDanIGe2CuqMt
         tzBpyIuAZ+hU5v5sHvsCOmtzfO/v3XrpKLdGL+rk6poVuOV83WtGA6y1q8+Z/D/vrYm7
         z6urx0iNyNjzx0JXL4TdC22XvbOluFu8hMB2J7P93BgVZrOiV7sza8PGhcOaXRqX0xl3
         IrxBr5LP3qwfXWSErJjYGxr9AK7p3o41l/TbvXFijM6KJgyuGXrd6ZaDH/M+fTLunX1N
         Mgv3mXESVvpTVCgpjG+qRdWE8AOe+AFMRU/xCFokbwGMNMznBb8mkVc930Va1Yba8C7q
         7Bfg==
X-Gm-Message-State: APjAAAXbKfkjHCpGdIGyxOP9+Oq2kgD9TskDL1u06E29cBZCwmBScdjn
        2GPZDhwmaGp7ZsdPJAWFZ0M=
X-Google-Smtp-Source: APXvYqxf45Rt48qewS/1TxXy9teNni48bxwe3+YaybaZjyCTXYiBUvRLNPvO6nnYPvEQInHLi90qmA==
X-Received: by 2002:a17:90a:3aed:: with SMTP id b100mr7900731pjc.63.1562888673741;
        Thu, 11 Jul 2019 16:44:33 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t10sm6163450pjr.13.2019.07.11.16.44.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 16:44:32 -0700 (PDT)
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
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH v1 5/6] x86/pci: Pass lockdep condition to pcm_mmcfg_list iterator
Date:   Thu, 11 Jul 2019 19:44:00 -0400
Message-Id: <20190711234401.220336-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190711234401.220336-1-joel@joelfernandes.org>
References: <20190711234401.220336-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pcm_mmcfg_list is traversed with list_for_each_entry_rcu without a
reader-lock held, because the pci_mmcfg_lock is already held. Make this
known to the list macro so that it fixes new lockdep warnings that
trigger due to lockdep checks added to list_for_each_entry_rcu().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/x86/pci/mmconfig-shared.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 7389db538c30..6fa42e9c4e6f 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -29,6 +29,7 @@
 static bool pci_mmcfg_running_state;
 static bool pci_mmcfg_arch_init_failed;
 static DEFINE_MUTEX(pci_mmcfg_lock);
+#define pci_mmcfg_lock_held() lock_is_held(&(pci_mmcfg_lock).dep_map)
 
 LIST_HEAD(pci_mmcfg_list);
 
@@ -54,7 +55,7 @@ static void list_add_sorted(struct pci_mmcfg_region *new)
 	struct pci_mmcfg_region *cfg;
 
 	/* keep list sorted by segment and starting bus number */
-	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list) {
+	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list, pci_mmcfg_lock_held()) {
 		if (cfg->segment > new->segment ||
 		    (cfg->segment == new->segment &&
 		     cfg->start_bus >= new->start_bus)) {
@@ -118,7 +119,7 @@ struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus)
 {
 	struct pci_mmcfg_region *cfg;
 
-	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
+	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list, pci_mmcfg_lock_held())
 		if (cfg->segment == segment &&
 		    cfg->start_bus <= bus && bus <= cfg->end_bus)
 			return cfg;
-- 
2.22.0.410.gd8fdbe21b5-goog

