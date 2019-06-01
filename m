Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8145B320FB
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jun 2019 00:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfFAW23 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 1 Jun 2019 18:28:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41347 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfFAW2B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Jun 2019 18:28:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id s24so5306926plr.8
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jun 2019 15:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYEdUUvy8S93JfyESlA9B4bQMgXK5qa78QvxuKI1iX8=;
        b=JpIZxOLHu3pAr7XqjE6lQyNILkSNtWAhlsGBsqQ9nX8Mkf45RZkSqCsB1ogyuaGHYR
         oID/Qzt9GUMhWhlEy7pzJd90HrYVZDZ4ddj9Se3v7fLclY18Kge6hu4MUcAmLD+wf4b0
         XKyDW7+epwfSMkz4uMyVUA2uPZnDSVHkqAT6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYEdUUvy8S93JfyESlA9B4bQMgXK5qa78QvxuKI1iX8=;
        b=IIqu0EQNBiogIY6GS7LVEPJStQrbRolQWOOeMLfogriOGSpRAZnADfdgJEXus8ab32
         S3Org/C7N0FEenvoTPgFXZBg1S+EYx66V9yLuiWJl11CgwjdKHjDtZF8Ig2oAI7AEQRJ
         gQaaFcE1SZSHPvpcpl3ugsY2ZlDM1PVxdWFFoVSxF1L83ogtCM15MV9pWtYo/8J95Ytb
         i0ERGjuIwuXoQ4AeEnb++nQUOox+jR7aOeZ81MBSgXpBrMbueRkaQ+2cY+3EpeuFWJ4e
         2CXV36sSarJWajDwRuJte75uNnFX9emQ68iqZYZtSmlPAz0qPj/PdxEhnrzvIuAo3YNn
         cNDA==
X-Gm-Message-State: APjAAAUunfXTNQReKWxW1xZ594HRV3+1WFFYLq1wzRInO35LVxtiEJVD
        j5kVHW3Bf/XF8WvIigsmIAFUEg==
X-Google-Smtp-Source: APXvYqwKk4GW7sHHyPB0GuHYf6OQ+CpmILR8gGtCpOPuYf+Qeg4Mh/EguSHhpRRCqMTs3zQmTpmcmg==
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr20196036pln.10.1559428080628;
        Sat, 01 Jun 2019 15:28:00 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t33sm9908018pjb.1.2019.06.01.15.27.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 01 Jun 2019 15:27:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>,
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [RFC 4/6] workqueue: Convert for_each_wq to use built-in list check
Date:   Sat,  1 Jun 2019 18:27:36 -0400
Message-Id: <20190601222738.6856-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190601222738.6856-1-joel@joelfernandes.org>
References: <20190601222738.6856-1-joel@joelfernandes.org>
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
2.22.0.rc1.311.g5d7573a151-goog

