Return-Path: <linux-acpi+bounces-16987-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF0EB58D3A
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 06:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F9924E299F
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 04:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FB72E0B5A;
	Tue, 16 Sep 2025 04:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAsxqDJG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263132E06E4
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 04:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998130; cv=none; b=opZs3k0cOWvGnYPCo+Rv+n8gPkKkVczS7a1CrudIj4oEnzmn7O7Oj/2rjAjym7A7Tn8De8P8ng1RpRbpyqiSDgomi6KPrj3wCD+Txkjv3iLaZnC6R8yuaLIISpQHHZrab51MP8dhsjOHzpuZrFd05H4cX2XLZKij+b/99AYb+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998130; c=relaxed/simple;
	bh=McKpF5pbp0B08HxMwaOQh+77moGljXjpv9ExEqMvqrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rm88mZT1MRAPs+XlSNxOuNjL1iyMdL7M/K901XidgSL+5ownMSpBlrG7fmSXJDcjN1rUmenVjUfmE3B4soxWEtFgyq3U6bbn+7xjhc1iTH1HX1PzhmhVkR9fDCzrivprsnbRPeeDB3hLLwOlQG6UKZW/c8MxYTFww/V5x1uFa7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAsxqDJG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so3234794a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 21:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998127; x=1758602927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdSOTRlpcbSm77LoC5qTO7Qj2WXZD3913QNmAyohauk=;
        b=iAsxqDJGyK6tvzTorEsVSUEuBJHI7lzp/5BEV9Wux96nvmddvYxeJQ1Pxvpd2zxtF/
         odfGJC6i+MsiMQaqOK2xq8ZI0ARkBidTF5I5eqq1ZR8Qjn+DauG6LysiVeyKRFvX28EL
         w6ZcpLJnXs6zocIW71x6zkcJ5+FAND5iyun6X1dBQ46MVXBvupNiU+xnLnPuRzi43J08
         BA1c5fGxCyMnm79SP3kRQxMi+O6QScp7FJQkKJCIjiivp3mQfwQ1xz1JjfoSzAPM7acG
         j6yJZpPiCXYc7n4vedVIAlccqhiIo5yA+omWiEO/NiWZlviC3u17B0o+jpKhtDTDqd64
         n6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998127; x=1758602927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdSOTRlpcbSm77LoC5qTO7Qj2WXZD3913QNmAyohauk=;
        b=JVIBeFdslJHSykcqij5VcTCDfh3PuDOorboxTqroq6AGH+rHBtqHrE7cO9JbOmZZCy
         24rLOewQZiPrdPrVolyy8eLFxUyfJ6L6kBWz2md+Viji6Urpa3mZ/R4g7IRZsH+7FnZE
         DoShrDMmu1hrqrbK+y+joCt1vJbhN8kkLaCZ4zETH68rKAZ6xF4GC75hh/WG9+7zZ3G9
         SItEFe2gE7bdfyhOnQEjDSqCWzJxlPRnpPLekmpf4rXD78I+fsSKkI7M6nHld4DGUOz7
         Lh+uAidck8iyf2S1DON33QzZIp7eVDBaBR32Sl3xY+dttiQrtMUq3J6+E7r8jNJZai9J
         KMaw==
X-Forwarded-Encrypted: i=1; AJvYcCUI9aDy0CrmJPW+OHhHZKBiovgkDxgZ47DRxd3fQeTG22PcxOIAvSYH+nGwGU21e2o5XFeA5TxHIidT@vger.kernel.org
X-Gm-Message-State: AOJu0YwMY+ejFZnpYkqy0GX78cmeckeipzjCad4IKzsrsD/h6bHEpVfC
	OFdPllEnO9uE2rW3PZWZ9WgLD1lgNJhRhEyNKtsRR8hzg4cme5jujGV/
X-Gm-Gg: ASbGnctggaey05hnSbcSAZgYDTTgQNTn1EyDRe7njFIZiVpP5uDefLrr5JprKqxyctl
	ECs3KU6gSoUNWcaMs2IqRJvfgOFGTqJHsk/xgUdNx4avpgLFkqarsbRZMsGU2zdxRjNxxf0b5if
	Xca6kv7oFPEJcqdZFhEgfvlqw4OXaHw4yT7vzPVrEXx90rAYMsiQLewuQEC/5yy2tKXzEYHQ9In
	FMdSo7XgHFEjkXeCKKOYWEEyp6KOcW9u4fl3mPP9wikvKrMgBwB/tr5/jZQvmAVUxIRS8ZmEZ56
	oFsIc4mG/s04LemJcBsIb+szGihY96CTr2bHlCqa+C2OyldQvbwo/u9e6MLicfULvtBTbsFpHed
	wBBO/EbxPb3BS/SSpYhyAiohFC3gHmgfZ0QvgMXU=
X-Google-Smtp-Source: AGHT+IGkIhcIMGh+oiZ/aDBZPsHwPAhQG69OhML0E/f2mr/YjQA5clLbS6Ua4uwzILjLJIA06eQ5gQ==
X-Received: by 2002:a17:902:d2c4:b0:25e:5d83:2ddd with SMTP id d9443c01a7336-25e5d832fdcmr159755585ad.45.1757998127447;
        Mon, 15 Sep 2025 21:48:47 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:46 -0700 (PDT)
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
	Holger Dengler <dengler@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 05/14] s390/pkey: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:26 +0800
Message-Id: <20250916044735.2316171-6-dolinux.peng@gmail.com>
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

Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Holger Dengler <dengler@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/s390/crypto/pkey_base.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/s390/crypto/pkey_base.c b/drivers/s390/crypto/pkey_base.c
index b15741461a63..4c4a9feecccc 100644
--- a/drivers/s390/crypto/pkey_base.c
+++ b/drivers/s390/crypto/pkey_base.c
@@ -48,16 +48,13 @@ int pkey_handler_register(struct pkey_handler *handler)
 
 	spin_lock(&handler_list_write_lock);
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(h, &handler_list, list) {
 		if (h == handler) {
-			rcu_read_unlock();
 			spin_unlock(&handler_list_write_lock);
 			module_put(handler->module);
 			return -EEXIST;
 		}
 	}
-	rcu_read_unlock();
 
 	list_add_rcu(&handler->list, &handler_list);
 	spin_unlock(&handler_list_write_lock);
-- 
2.34.1


