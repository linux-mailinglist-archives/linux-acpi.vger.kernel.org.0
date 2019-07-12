Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEC7B6625B
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2019 01:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfGKXof (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Jul 2019 19:44:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38449 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbfGKXob (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jul 2019 19:44:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id az7so3831075plb.5
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jul 2019 16:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sb5/sBlO0o0IY+ND5ZXjrKZw9gM/z/BZ2b8OMvqM37o=;
        b=tCGTNt4ClbRqV/NfTPLBheEFeH7Zn70VzEPVb6u6yQtg9GPOuDTUPJlXw6bBhUJ1CR
         QpGk/qoWbRMoK0Pts8WznAkBiv/X+3OAFvGO2tXIqriAKW54HJaBcZeAgZjm6E+3gJ7u
         xfrwf9Vd3o1AR/P1EbjFliZLl/0moKn0MvFEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sb5/sBlO0o0IY+ND5ZXjrKZw9gM/z/BZ2b8OMvqM37o=;
        b=orSBteC+K1xwxrL+BpyITiUgxn78ecqBSfrCMhx70qyBuniCtvsSoE7IHoValU4t0O
         RZK9XHVs0Wi5rnilfWu2vPjMqnGpyae8IhSNLfy+iPVrluMO5yMqxOgla85scN9rwPsg
         NLzZqJyDAgfyS6+sjOK5xVY1QGBK4nEQPHlQdsQ7XzUAV9m8y6DpJ3NOqFtwMTUIcAy4
         ueRaELQtPZa7+Se535rxs8IL+0arp67KNGiWq4D//zk1wBxbmVtT5EjYXC7YYlp7M3WI
         hosGFEIW0DRHpZ/tXPIOkDL4+g7wxZr9Hv575/PojTSCRPO4rU0lU0Jjc7w15/d4hKDv
         KooQ==
X-Gm-Message-State: APjAAAWn+ZKOe546L+Eo+aANnOuuu/hXL3iPOmZOwgk1ZE39vu5O74fg
        wky1uoubv3HQqriacTNcquE=
X-Google-Smtp-Source: APXvYqz7RwC1sXenfqK+KGjrZckG5hTYMGbFgu1GP0DrdQq+/nz6LQrmjYSvr647um8kWQAd2c41tw==
X-Received: by 2002:a17:902:381:: with SMTP id d1mr7408739pld.331.1562888670006;
        Thu, 11 Jul 2019 16:44:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t10sm6163450pjr.13.2019.07.11.16.44.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 16:44:29 -0700 (PDT)
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
Subject: [PATCH v1 4/6] workqueue: Convert for_each_wq to use built-in list check
Date:   Thu, 11 Jul 2019 19:43:59 -0400
Message-Id: <20190711234401.220336-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190711234401.220336-1-joel@joelfernandes.org>
References: <20190711234401.220336-1-joel@joelfernandes.org>
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
 kernel/workqueue.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9657315405de..91ed7aca16e5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -424,9 +424,8 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
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
2.22.0.410.gd8fdbe21b5-goog

