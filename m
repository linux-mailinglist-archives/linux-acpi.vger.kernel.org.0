Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92871673C5
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2019 19:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfGLRBO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jul 2019 13:01:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45482 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbfGLRBM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jul 2019 13:01:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so4779308pgp.12
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jul 2019 10:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/5hJQY7vBLoyimOM3U70MNxFgsc86oXhHYtdVzU5ujQ=;
        b=UAjbMqka7p1GCxFlNusyg29g1RCPFz9WIMtWvkN7qrcNF+ATnO9YKmLvPnuqPRJWG8
         01CXWPFPyGYm3lOSoebpREdMbvmnc55dMqjKROvd/t5QxrZ6o7iZwPGUGOYk4Ll55hdr
         IVAnsP7Rq6Ff+RAPzreODHBCQNzqAghR4nuBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/5hJQY7vBLoyimOM3U70MNxFgsc86oXhHYtdVzU5ujQ=;
        b=sEg0PfLe/6VEG42A9MN8kIypWdQS1124PWgggI56x/E1TneBcVQLMakuFZCFuIA8t3
         x/ZGuyzgLvhsu9y0ytGpKU0Xkj/bDvU+ZAJCClPtD3hHMTb/n6xJwNUHWxXf0WsPHBLP
         ZsKEK/rRtxSWrrp4iIl/tufc5FOFE4E0Z+SP7L732croZt21i4LJVrh6Tx6yjtSBEgnE
         gezkRAHJrrSH9LSvk+xzaiaGOHoN+WQxtoMyh5cTUFNGCf6h0v6EWJEelTsb12tfo+r6
         VT+WTwWDsG+YSHlM3bMNZAHqHPpbxJjyzm06Cu5K46f9o1jPpC1vcqe7MPqT+3PBkLhd
         tUrQ==
X-Gm-Message-State: APjAAAW6siew83JWxBB5EEOJG8ljU4UAzURmZDKvD4MGcZ0f3HkH/3qE
        yIp/XFBemSVn5b4t9pjPBpM=
X-Google-Smtp-Source: APXvYqysKQjlbPJnzD1SgXu0qrPOgUWrpmjWhJmLr3dLME/oF4p6YcJaiWDgGdC5pNxKNHie+MpwEA==
X-Received: by 2002:a63:dc56:: with SMTP id f22mr12036675pgj.305.1562950871565;
        Fri, 12 Jul 2019 10:01:11 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a15sm7127385pgw.3.2019.07.12.10.01.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 10:01:10 -0700 (PDT)
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
Subject: [PATCH v2 9/9] doc: Update documentation about list_for_each_entry_rcu
Date:   Fri, 12 Jul 2019 13:00:24 -0400
Message-Id: <20190712170024.111093-10-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190712170024.111093-1-joel@joelfernandes.org>
References: <20190712170024.111093-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch updates the documentation with information about
usage of lockdep with list_for_each_entry_rcu().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/lockdep.txt   | 15 +++++++++++----
 Documentation/RCU/whatisRCU.txt |  9 ++++++++-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/lockdep.txt b/Documentation/RCU/lockdep.txt
index da51d3068850..3d967df3a801 100644
--- a/Documentation/RCU/lockdep.txt
+++ b/Documentation/RCU/lockdep.txt
@@ -96,7 +96,14 @@ other flavors of rcu_dereference().  On the other hand, it is illegal
 to use rcu_dereference_protected() if either the RCU-protected pointer
 or the RCU-protected data that it points to can change concurrently.
 
-There are currently only "universal" versions of the rcu_assign_pointer()
-and RCU list-/tree-traversal primitives, which do not (yet) check for
-being in an RCU read-side critical section.  In the future, separate
-versions of these primitives might be created.
+Similar to rcu_dereference_protected, The RCU list and hlist traversal
+primitives also check for whether there are called from within a reader
+section. However, an optional lockdep expression can be passed to them as
+the last argument in case they are called under other non-RCU protection.
+
+For example, the workqueue for_each_pwq() macro is implemented as follows.
+It is safe to call for_each_pwq() outside a reader section but under protection
+of wq->mutex:
+#define for_each_pwq(pwq, wq)
+	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,
+				lock_is_held(&(wq->mutex).dep_map))
diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index 981651a8b65d..a08c03735963 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -290,7 +290,7 @@ rcu_dereference()
 	at any time, including immediately after the rcu_dereference().
 	And, again like rcu_assign_pointer(), rcu_dereference() is
 	typically used indirectly, via the _rcu list-manipulation
-	primitives, such as list_for_each_entry_rcu().
+	primitives, such as list_for_each_entry_rcu() [2].
 
 	[1] The variant rcu_dereference_protected() can be used outside
 	of an RCU read-side critical section as long as the usage is
@@ -305,6 +305,13 @@ rcu_dereference()
 	a lockdep splat is emitted.  See RCU/Design/Requirements/Requirements.html
 	and the API's code comments for more details and example usage.
 
+	[2] In case the list_for_each_entry_rcu() primitive is intended
+	to be used outside of an RCU reader section such as when
+	protected by a lock, then an additional lockdep expression can be
+	passed as the last argument to it so that RCU lockdep checking code
+	knows that the dereference of the list pointers are safe. If the
+	indicated protection is not provided, a lockdep splat is emitted.
+
 The following diagram shows how each API communicates among the
 reader, updater, and reclaimer.
 
-- 
2.22.0.510.g264f2c817a-goog

