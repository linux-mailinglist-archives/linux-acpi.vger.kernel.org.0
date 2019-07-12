Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C81673B9
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2019 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfGLRBB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jul 2019 13:01:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43541 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfGLRA7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jul 2019 13:00:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so5028406plb.10
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jul 2019 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AptpBaMmXVEAzBSMLWJKxPr4rttPnZ1wioK1nwnHwy8=;
        b=yQvAOcpIfNDNwzp6qEHjOsGXYqVnpbH/+yqEi1B80+c8YsLEO2bHlrNL9T4ka/DGw/
         z2jqgOlDW+zlIDSpKaAxSzYrAquMnRnl5eFGmevh+cE6wTqwUm8hjiPn1KaWffrhd+9j
         /1RA5jQTnJIh+/+WoSk+cY6XTKUqwecgKppuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AptpBaMmXVEAzBSMLWJKxPr4rttPnZ1wioK1nwnHwy8=;
        b=iwaQvjpdsoa2m2JYuz6r8YfGKyUv0zwYfeMq94NHnPM6rzzaLCgWxltuBG8R34EVDS
         Rg3BmvEtbdiuqxYENGEEWFdQBc03PfmfZKb4AR/0kv+JDFR2VzHPXlyO39IOlFiLx5D8
         sUE7F2kLchEbyQtjYOq1ELBEY9q+DVBiseQQmljNW9CbL6xko30IneiyFQrC6ghHDgcs
         MgFrfTthQjVEgxkhzrx4XonIIEIz2BKSGuDdPm+oz3tW8bWRL2v/KTCeug4u7MijpIFx
         C0OO1NUhasUhS13PAa95gdrht0FSOd9rLzahICfgEwklaX5QSoQmCH3eTeupksm+Oh7F
         NabA==
X-Gm-Message-State: APjAAAUgLvAqZJevziyqnSCa8T9SujnDjBodVn1gWBtJfwILDuUEtBXN
        F5KbZuhjfsn4IhVcHigAx80=
X-Google-Smtp-Source: APXvYqxSVQC9IuM5FvE8lT+y5f9yl5+BBjiQfPurEohLODoTR1n3Ry5MZxUFhO2jwyxSjsXaeUm7lw==
X-Received: by 2002:a17:902:7c96:: with SMTP id y22mr12852939pll.39.1562950858903;
        Fri, 12 Jul 2019 10:00:58 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a15sm7127385pgw.3.2019.07.12.10.00.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 10:00:58 -0700 (PDT)
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
Subject: [PATCH v2 6/9] workqueue: Convert for_each_wq to use built-in list check
Date:   Fri, 12 Jul 2019 13:00:21 -0400
Message-Id: <20190712170024.111093-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190712170024.111093-1-joel@joelfernandes.org>
References: <20190712170024.111093-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

list_for_each_entry_rcu now has support to check for RCU reader sections
as well as lock. Just use the support in it, instead of explictly
checking in the caller.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/workqueue.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9657315405de..5e88449bdd83 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -363,11 +363,6 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 			 !lockdep_is_held(&wq_pool_mutex),		\
 			 "RCU or wq_pool_mutex should be held")
 
-#define assert_rcu_or_wq_mutex(wq)					\
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
-			 !lockdep_is_held(&wq->mutex),			\
-			 "RCU or wq->mutex should be held")
-
 #define assert_rcu_or_wq_mutex_or_pool_mutex(wq)			\
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
 			 !lockdep_is_held(&wq->mutex) &&		\
@@ -424,9 +419,8 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
  * ignored.
  */
 #define for_each_pwq(pwq, wq)						\
-	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node)		\
-		if (({ assert_rcu_or_wq_mutex(wq); false; })) { }	\
-		else
+	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,		\
+				 lock_is_held(&(wq->mutex).dep_map))
 
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
 
-- 
2.22.0.510.g264f2c817a-goog

