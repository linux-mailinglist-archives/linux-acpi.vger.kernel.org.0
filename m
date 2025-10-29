Return-Path: <linux-acpi+bounces-18320-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C29C1A0D2
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF93D467AF9
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8738F336ED3;
	Wed, 29 Oct 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="n4eFsOfQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E637324B3F
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737257; cv=none; b=QumZ5/nWiKANdOPKXAW+XCgMvAaTZaLoXxvHarQ3fs1Mn4I9wZ2jFIyWOZkA/r7bZfSSF9bZqaTGY2a/hsg0MBsWycWFPJUzEdXs1qVMPaczX4/qFPYMuVbSjDw/rMt/XYWoganNe9QjXjjb+dHhAichT68t7meqwt7ymYPQA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737257; c=relaxed/simple;
	bh=NtqJe6hBkLHRTCl6BTB7x/7lULJenUS592JeZPPvj04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcY783VgQf+B5f31F/P5QozLlYXdC3H0Pex/A5/O++b6iaIupHGd8Rjc/aeBKmcciqu1sBlk18rWiWF+8PbDEZg3pqzMJxBfiumBasOaxAwT75sVmuKwAgLYmXG7l68/bKNiSKnsmUJh+2srl4rBgILfdGTgvQ0MT83Trf2XGUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=n4eFsOfQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32ec291a325so5548674a91.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737254; x=1762342054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cSTruKqOLsH1I5PXwtSeYHag9AZi6yAFctm+4E+iHg=;
        b=n4eFsOfQmw7vy8H0EQh3724meSGRDi0FRed/dNTXlGNtXkp1+sMlerl0IJuQLHbEmu
         UjOs7MXAanhTCmlaZ9mJDk/jGxnqxAY8Rp5JTGg2QrVwCVwRnPMwMEFvc6fDO/5h/KnK
         KLnKiFfwQzQPrfUWI3UxXPMNwe5LR5HCwJfX8RqnptusOJ6AExuvbNd5gkTAmzYtTyGD
         EaanQt5rBv/hSK6U976VlKadqIYwh+XbMgFziTeacbtVDyLRYvCgDbO09yN9oyMxZqSt
         N6mQ8Yb4sY1Ng+VVzK9hIJJ+JPw1TSVPSNZZoqHqUgwAVPtMBV6h0ILFQ/9SytlXg4Cp
         lNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737254; x=1762342054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cSTruKqOLsH1I5PXwtSeYHag9AZi6yAFctm+4E+iHg=;
        b=bRLVKxFNiR5eHnXysFhs4jq1pNaf7ylOBYO/Ev1CkRqN8js9NTtlsMIfBiya1Duz4a
         MUSERqPgmYwxA2z6XX7F0LE6+RkQInWw2+GVjYbGVa/ARY69Th5KRJoZumvUniWwlFoE
         TnkAGSGU7WdsbmBdg3mv9pHEG77MljFgcGwPO1/9fwXB0BE8hWcpuF9Ul3vYldDfXOAa
         zmsi9mxb9OwkNpnojWy6+2SsnTUxHHYmtK7blA565h4I/h1OOVbTpbNb8a7IZOFa1dgZ
         OzYkIjI940zjB2eUVArjC691D/gFpJhyP0jZ2veyu526rfgGtzQBkygENgK2PFvuzXbv
         sVWA==
X-Forwarded-Encrypted: i=1; AJvYcCVCiJkY1I0GwhkQ7hwUd+KnY2OxLqYF+V0SDC0Hrd34aIkfOQNp/bF7BkzeJV1aCaDg60pDKiw9twAv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Qhv2cLMzvMY6SbLeIM45AqeVnClN5bBW4mnAwt9M7nPbv3ro
	ECnSkx8S+4NHmx105WPmas77kJ2Yo5/8FlX0IxD0li15tvDyd4hEjerCIdOwYJMf37c=
X-Gm-Gg: ASbGncsLpZUIiwO6XisFTFYdrTwKRrHwh0sH0cYAWTQhakX2DdjkfpuiwJBuWiiDqYr
	xvmKEpJR8j8I0q1UG2O+aU40TZuarIWb2OfN6PoMsTt4QuqKiBut7aXo2ufvo6W+3CbghUdySVr
	mFiBhh4mEG02KN/lyzksVbX4aRtnt+MdO8HTwo0OUMYQhucr8bILL+FdQWDSwyomCWdD2odZ/3J
	L6w9URYBs51NfXrZ5Bk+KMocuvpEkpXxbMPmsN6u5POgCV6hR98Nm9pwWib7QbMjayXrQ0ReXMT
	iDlnaIz7L03h66nMkPD5Hed1MJ2+QTV9k2IWed0A8NTEfmHGdurJOXpcHVDSi9oNrmmEtTOgtwy
	/YWVTTm5OTrsBI3+/elQehkbZu91QXTytRT7R5KATx3kmqawfM5qEuB6mA6wF18opj5GITDJbNX
	5Oz/TJzq7IzfQp6GJmyBk1wlec99YHVmZN3BdgYJU=
X-Google-Smtp-Source: AGHT+IEEUQbjEhb35jM58E8VRwx1ELP2wmCevbIBmE4Rmb/2cMhIG6S77jc+DoMY/nX9v+1TYNMJig==
X-Received: by 2002:a17:90a:fc46:b0:33b:938c:570a with SMTP id 98e67ed59e1d1-3403a301f0cmr3025943a91.33.1761737254196;
        Wed, 29 Oct 2025 04:27:34 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:33 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v2 06/10] riscv: Add functions to register ghes having SSE notification
Date: Wed, 29 Oct 2025 16:56:44 +0530
Message-ID: <20251029112649.3811657-7-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to register the ghes entries which have SSE as
notification type. The vector inside the ghes is the SSE event
ID that should be registered.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/firmware/riscv/riscv_sbi_sse.c | 147 +++++++++++++++++++++++++
 include/linux/riscv_sbi_sse.h          |  16 +++
 2 files changed, 163 insertions(+)

diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/riscv/riscv_sbi_sse.c
index 6561c7acdaaa..46ebc9e9651c 100644
--- a/drivers/firmware/riscv/riscv_sbi_sse.c
+++ b/drivers/firmware/riscv/riscv_sbi_sse.c
@@ -5,6 +5,8 @@
 
 #define pr_fmt(fmt) "sse: " fmt
 
+#include <acpi/ghes.h>
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
 #include <linux/cpu_pm.h>
@@ -700,3 +702,148 @@ static int __init sse_init(void)
 	return ret;
 }
 arch_initcall(sse_init);
+
+struct sse_ghes_callback {
+	struct list_head head;
+	struct ghes *ghes;
+	sse_event_handler_fn *callback;
+};
+
+struct sse_ghes_event_data {
+	struct list_head head;
+	u32 event_num;
+	struct list_head callback_list;
+	struct sse_event *event;
+};
+
+static DEFINE_SPINLOCK(sse_ghes_event_list_lock);
+static LIST_HEAD(sse_ghes_event_list);
+
+static int sse_ghes_handler(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	struct sse_ghes_event_data *ev_data = arg;
+	struct sse_ghes_callback *cb = NULL;
+
+	list_for_each_entry(cb, &ev_data->callback_list, head) {
+		if (cb && cb->ghes && cb->callback) {
+			cb->callback(ev_data->event_num, cb->ghes, regs);
+		}
+	}
+
+	return 0;
+}
+
+int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+		      sse_event_handler_fn *hi_cb)
+{
+	struct sse_ghes_event_data *ev_data, *evd;
+	struct sse_ghes_callback *cb;
+	u32 ev_num;
+	int err;
+
+	if (!sse_available)
+		return -EOPNOTSUPP;
+	if (!ghes || !lo_cb || !hi_cb)
+		return -EINVAL;
+
+	ev_num = ghes->generic->notify.vector;
+
+	ev_data = NULL;
+	spin_lock(&sse_ghes_event_list_lock);
+	list_for_each_entry(evd, &sse_ghes_event_list, head) {
+		if (evd->event_num == ev_num) {
+			ev_data = evd;
+			break;
+		}
+	}
+	spin_unlock(&sse_ghes_event_list_lock);
+
+	if (!ev_data) {
+		ev_data = kzalloc(sizeof(*ev_data), GFP_KERNEL);
+		if (!ev_data)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&ev_data->head);
+		ev_data->event_num = ev_num;
+
+		INIT_LIST_HEAD(&ev_data->callback_list);
+
+		ev_data->event = sse_event_register(ev_num, ev_num,
+						    sse_ghes_handler, ev_data);
+		if (IS_ERR(ev_data->event)) {
+			pr_err("%s: Couldn't register event 0x%x\n", __func__, ev_num);
+			kfree(ev_data);
+			return -ENOMEM;
+		}
+
+		err = sse_event_enable(ev_data->event);
+		if (err) {
+			pr_err("%s: Couldn't enable event 0x%x\n", __func__, ev_num);
+			sse_event_unregister(ev_data->event);
+			kfree(ev_data);
+			return err;
+		}
+
+		spin_lock(&sse_ghes_event_list_lock);
+		list_add_tail(&ev_data->head, &sse_ghes_event_list);
+		spin_unlock(&sse_ghes_event_list_lock);
+	}
+
+	list_for_each_entry(cb, &ev_data->callback_list, head) {
+		if (cb->ghes == ghes)
+			return -EALREADY;
+	}
+
+	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
+	if (!cb)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&cb->head);
+	cb->ghes = ghes;
+	cb->callback = lo_cb;
+	list_add_tail(&cb->head, &ev_data->callback_list);
+
+	return 0;
+}
+
+int sse_unregister_ghes(struct ghes *ghes)
+{
+	struct sse_ghes_event_data *ev_data, *tmp;
+	struct sse_ghes_callback *cb;
+	int free_ev_data = 0;
+
+	if (!ghes)
+		return -EINVAL;
+
+	spin_lock(&sse_ghes_event_list_lock);
+
+	list_for_each_entry_safe(ev_data, tmp, &sse_ghes_event_list, head) {
+		list_for_each_entry(cb, &ev_data->callback_list, head) {
+			if (cb->ghes != ghes)
+				continue;
+
+			list_del(&cb->head);
+			kfree(cb);
+			break;
+		}
+
+		if (list_empty(&ev_data->callback_list))
+			free_ev_data = 1;
+
+		if (free_ev_data) {
+			spin_unlock(&sse_ghes_event_list_lock);
+
+			sse_event_disable(ev_data->event);
+			sse_event_unregister(ev_data->event);
+			ev_data->event = NULL;
+
+			spin_lock(&sse_ghes_event_list_lock);
+
+			list_del(&ev_data->head);
+			kfree(ev_data);
+		}
+	}
+
+	spin_unlock(&sse_ghes_event_list_lock);
+
+	return 0;
+}
diff --git a/include/linux/riscv_sbi_sse.h b/include/linux/riscv_sbi_sse.h
index a1b58e89dd19..cd615b479f82 100644
--- a/include/linux/riscv_sbi_sse.h
+++ b/include/linux/riscv_sbi_sse.h
@@ -11,6 +11,7 @@
 
 struct sse_event;
 struct pt_regs;
+struct ghes;
 
 typedef int (sse_event_handler_fn)(u32 event_num, void *arg,
 				   struct pt_regs *regs);
@@ -24,6 +25,10 @@ void sse_event_unregister(struct sse_event *evt);
 
 int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int cpu);
 
+int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+		      sse_event_handler_fn *hi_cb);
+int sse_unregister_ghes(struct ghes *ghes);
+
 int sse_event_enable(struct sse_event *sse_evt);
 
 void sse_event_disable(struct sse_event *sse_evt);
@@ -47,6 +52,17 @@ static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
 	return -EOPNOTSUPP;
 }
 
+static inline int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+				    sse_event_handler_fn *hi_cb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int sse_unregister_ghes(struct ghes *ghes)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int sse_event_enable(struct sse_event *sse_evt)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0


