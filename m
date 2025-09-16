Return-Path: <linux-acpi+bounces-16983-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B7B58D28
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 06:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56321B20A15
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 04:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EFE2D6E49;
	Tue, 16 Sep 2025 04:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgiTKs98"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71B22C326F
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998105; cv=none; b=HcMpgRGyJpLjff3pBhkW08TA6tOxZ0GmTCIAWYvwdIxnPFg5cHXH3CCdDhSbewxGE7FlpjxB1CY8S4p9vdZJRchddkK+f3YMlU1pVoWAV9deNAzN8Xcw/lLpJEn+ds6woGfCVoZj82J0ovqIWek1G5ihqFswBAHioLT3RapTNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998105; c=relaxed/simple;
	bh=psJk8MWkw4yWUzhoGl6iC+/oKrIajPgKeNxYtGpbGJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k0p9aUNADfYsfKCiwtgxsVD2mohsowFOzmp8cnl2BFQTh9SmYphiWbbpDs0XTbA7F+8BY74y8XH6RlLlN3mUcwoBjr6jZfGN6w2SBniUaNsI2oMYNjecOLv5F1bxAmKmcF1j109HISvr+MZkdZnW3mNnWRgWnDAROsdwbX9Blbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgiTKs98; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24456ce0b96so56441385ad.0
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 21:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998101; x=1758602901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOaEQ/7pID9TluLY7/w8zgk+8Z8ChedlXZfnOV6tq/0=;
        b=UgiTKs98TYt0zah/UeSi4De4R5qcPuP9nE+oBFiDNrhtI0JRukYpwBGkrD1qMj8YZJ
         zxAPGGH9qL2hIdPkF9Ps9Xnd7Jvxf/ZVlkbnd47UidqnLrPiaPttc/PPgcfGNO4KSZFH
         MII8pjx2Ab32A8kOPiHi/IVq0+PdVSk9AH6nKylqP4ciHrUFZteDTLfbAAMcPsfOW9/9
         SxBLWNNbByPGH2KJGO4I8tQi++oIv91NAcecNWvFFImMV/zfHb4u5kUEiUYwITx8m6l+
         PbhcI71UPtGbN3T10jjL7ELy4EIjkaG/PtU6I9mrth/K43lLg7JX0O8z0A9pbbonH3JS
         zeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998101; x=1758602901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOaEQ/7pID9TluLY7/w8zgk+8Z8ChedlXZfnOV6tq/0=;
        b=jcZAMRY3VBoc+i0O5xx0jftjUbd5RrV8aA8M4oil30SYZ58AtKX3ZC+rw/u59OIlO4
         hJ3IoqH7e0Y/RcsvuJFsxOGMZTg71ZWzRn7kYuKabjcyfsnqQA6d0xbExfGxKVxx3LnY
         vdMT1mjAWXycVUlS/In+rM4LdkQ3W6NTh0A1kcijaWRctssesx2Zmb1RY3eD/iekMRQ+
         iWmg1FkKlgXYRJWDG0oAZq4qRxgM6S04xJn1P26rYqcwmgJzjjYVpFX09jI6Qg8TTw0F
         sKRk7ZT4cvfGrk419M3xTGfLW7JdJ9PSm7req7twNesDJm3/Ob3IIslodtH12lqFeecO
         WTNA==
X-Forwarded-Encrypted: i=1; AJvYcCUEE7/uEvi7E1Qpx47sQCpVWaANUdoUBu7qxvVU07y3nUH0n8FWCMWlkMvx6RwL3w2T8Xef/47V88dN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjqel3lPkJxfQf2vlpeq2JB26iWO7mvgDJXuJSXJJu1g+KmfE/
	wLSO73YAS+Cbt4Q02l1F5yGHjH4EPVEY4DLDlkQ1O+S5jR+1sy8n693z
X-Gm-Gg: ASbGncsWGdfX7X5lA0CYj2PE135V4fq2w81+oC8v5Zqdzri2YExiwTIgqw49mG2ptpZ
	ez5Yc5v8QWsfaG9JAhEVBzSddUDnI/vVqPln91C6mqcs+93SyMNfhjd0u7A56hyeJjXLLeOvatK
	5k3HE6yo/vtVQETbGOy7JG8fpW7vtllYRKrxJJeBlrlBIy34ZRcXfXO6Kz/eiHC0uk+YXYtEsSl
	Pg4qTTNlr0JZt/iyxer1TXOPTz3szfyWsG0P54cP99LgRPOxM4QebeueY7fjovSs3lhEciQMyEs
	DJiXw6zYXtgrIqehygoIncWi0srpByUruLpn05nTqsDznzayLWFZAkbmdEsFS1vI64TF3sLK8q9
	hUOoofLibPXNZuEjYarsU5fyM7oVSIYX6QytHR2c=
X-Google-Smtp-Source: AGHT+IFncLMpEiSXyRV3g2udd9oLTip5CIZ6fjiDS7nm0eY3IrUPzgwzagMuf9PJuGmIj5O4nns0xw==
X-Received: by 2002:a17:903:2f87:b0:249:71f5:4e5a with SMTP id d9443c01a7336-267d161e3b9mr10726455ad.26.1757998100825;
        Mon, 15 Sep 2025 21:48:20 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:20 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 01/14] ACPI: APEI: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:22 +0800
Message-Id: <20250916044735.2316171-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/acpi/apei/ghes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a0d54993edb3..97ee19f2cae0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1207,12 +1207,10 @@ static int ghes_notify_hed(struct notifier_block *this, unsigned long event,
 	int ret = NOTIFY_DONE;
 
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
-	rcu_read_lock();
 	list_for_each_entry_rcu(ghes, &ghes_hed, list) {
 		if (!ghes_proc(ghes))
 			ret = NOTIFY_OK;
 	}
-	rcu_read_unlock();
 	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
 
 	return ret;
-- 
2.34.1


