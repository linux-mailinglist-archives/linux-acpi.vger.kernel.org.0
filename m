Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97A3769292
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2019 16:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404732AbfGOOhg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jul 2019 10:37:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36190 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404724AbfGOOhf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jul 2019 10:37:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so8404803plt.3
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jul 2019 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d04DTAkj28sWGBD0hTaxcXYNvJEjAGRiNh/YBevkbdQ=;
        b=GC6kguZwzG85dZF5iWDrsveKaK2Fc4LgmUwLVCWkEfV1JlGAke0LxakzpuHBiFRaFB
         sYDHXQtZ71NbUDuVJ8YWKIw1R3eOc2C2ORLfAM04ltJddQI7SF38zyg1iFNWeipYVwov
         WMKiys6ZkCmWDq7512TerhvIp/7tNwu+a4rUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d04DTAkj28sWGBD0hTaxcXYNvJEjAGRiNh/YBevkbdQ=;
        b=DZ6nv6nSSGPrq0Wd0qSpkSWzFEV2YCvZh68HyQwRgJJ76Ecc+QXTUR7KL3YYWqEW+9
         hiMe33aLPnzarWKyiO4vmPzrOqb39aTX7VxM4ujIga5HOamNgjxjMhKdlw6GQMLLAROz
         PH4WQev/ZlOr8O3tnQgNB7aYsJLDu7k1pd8voR9fb1xM2Q4DqXqFiDnw2OydexgdvPAJ
         ACZ2ekSPBJFVb1zxGHEm4USLZA1WoGYW4doPT0FxjiHGZ6XA4uJhBPwKCxm8N/A6mkje
         ytXh9NvOr/HtctYHLWFioINMpoN/taBwWEfchiX4Q1l50TMwKuTchJFCC6jskri45ukN
         el8g==
X-Gm-Message-State: APjAAAUHyP0zwDqkiXRMndcW4CPl8NuDPjK2qzx5l7IYpk0LMfz4x1Nq
        Kgr1eRXCni+a06rdQpOFPIM=
X-Google-Smtp-Source: APXvYqwtv2gdmgGFtRTdsHXi0t6+nEY2tSbkW03BagiSXi1mseRekjbX7fP3TCtLfUm4acXXT6gmhg==
X-Received: by 2002:a17:902:aa88:: with SMTP id d8mr27314486plr.274.1563201454429;
        Mon, 15 Jul 2019 07:37:34 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s66sm18381852pfs.8.2019.07.15.07.37.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 07:37:33 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
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
Subject: [PATCH 5/9] driver/core: Convert to use built-in RCU list checking (v1)
Date:   Mon, 15 Jul 2019 10:37:01 -0400
Message-Id: <20190715143705.117908-6-joel@joelfernandes.org>
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
it in driver core.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/base/base.h          |  1 +
 drivers/base/core.c          | 10 ++++++++++
 drivers/base/power/runtime.c | 15 ++++++++++-----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index b405436ee28e..0d32544b6f91 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -165,6 +165,7 @@ static inline int devtmpfs_init(void) { return 0; }
 /* Device links support */
 extern int device_links_read_lock(void);
 extern void device_links_read_unlock(int idx);
+extern int device_links_read_lock_held(void);
 extern int device_links_check_suppliers(struct device *dev);
 extern void device_links_driver_bound(struct device *dev);
 extern void device_links_driver_cleanup(struct device *dev);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index da84a73f2ba6..85e82f38717f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -68,6 +68,11 @@ void device_links_read_unlock(int idx)
 {
 	srcu_read_unlock(&device_links_srcu, idx);
 }
+
+int device_links_read_lock_held(void)
+{
+	return srcu_read_lock_held(&device_links_srcu);
+}
 #else /* !CONFIG_SRCU */
 static DECLARE_RWSEM(device_links_lock);
 
@@ -91,6 +96,11 @@ void device_links_read_unlock(int not_used)
 {
 	up_read(&device_links_lock);
 }
+
+int device_links_read_lock_held(void)
+{
+	return lock_is_held(&device_links_lock);
+}
 #endif /* !CONFIG_SRCU */
 
 /**
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 952a1e7057c7..7a10e8379a70 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -287,7 +287,8 @@ static int rpm_get_suppliers(struct device *dev)
 {
 	struct device_link *link;
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held()) {
 		int retval;
 
 		if (!(link->flags & DL_FLAG_PM_RUNTIME) ||
@@ -309,7 +310,8 @@ static void rpm_put_suppliers(struct device *dev)
 {
 	struct device_link *link;
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held()) {
 		if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
 			continue;
 
@@ -1640,7 +1642,8 @@ void pm_runtime_clean_up_links(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.consumers, s_node) {
+	list_for_each_entry_rcu(link, &dev->links.consumers, s_node,
+				device_links_read_lock_held()) {
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
@@ -1662,7 +1665,8 @@ void pm_runtime_get_suppliers(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held())
 		if (link->flags & DL_FLAG_PM_RUNTIME) {
 			link->supplier_preactivated = true;
 			refcount_inc(&link->rpm_active);
@@ -1683,7 +1687,8 @@ void pm_runtime_put_suppliers(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held())
 		if (link->supplier_preactivated) {
 			link->supplier_preactivated = false;
 			if (refcount_dec_not_one(&link->rpm_active))
-- 
2.22.0.510.g264f2c817a-goog

