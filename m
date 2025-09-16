Return-Path: <linux-acpi+bounces-16993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AABB58D6D
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 06:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234D3322541
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 04:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092672EC09F;
	Tue, 16 Sep 2025 04:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h23e2S6Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A726F292
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 04:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998169; cv=none; b=rzrcpkntEjfPnYE/FbeLcpw2UUdSAakwZSX9ITseopgZhBM3AA5l1LpHtEKHBOK2uxYlJ7wlnKAsf7rCZekrwOe++CoV91DMpmN1JUX55GEHn2sUdXg8VK0xM8f3sNGyi/dkONzLyqb8eZyi6hDqx7ohI9RusLEW36x38sDte20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998169; c=relaxed/simple;
	bh=+qvXPu8HTVeRFaubIyM3rQFPhKws6qzYTh9yka49uSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQEXh9wJGW3n0UMyKQTfYCdxZ0FqTvZ/H0yshEvFhwqGQ5a25oDn21gaNxky064MncBWslxEJSCCqTxjmoWv79snwmlCuZHCiwwO1Ci2fzPjKA+HEEeAzdUjdE1AAhrrhmUIyPem5/WppKxMT2hzTgF5d/Ib4OTx3UjdizHlc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h23e2S6Y; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b54dd647edcso548516a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 21:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998167; x=1758602967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSw+5V18QQW1zrEulMj1oteRdmYU7Zw4RYS7vag/74M=;
        b=h23e2S6YBhzCpQQF+vf3PMKlnWyaXYUwO6oF/J1csVqE8vMSVBFHJPP2kFyA7mTnw6
         QwnvilGcLAzZwk5dm9UBosQKS6iNp2CfPLVNNazBVsUUUJfAbDLJfrY+mfJQkUvtu3z1
         zWQax3mYP1rICXuSyt9xs3gS4/ZaW0cCGP0shYpcIQA0XBLWLYOdGS2SU+OIMLgtd4+t
         B4N2aRUeDCv7XMX5ZYvbbFkYrMoh8OH7RWXOt/2ZQJzUw1ujVaB2Fx6RTQa2fB9o45cH
         XBGVenMM6TSDsWgpoWOuPERolaNznuaoeMDBjHfKZa46SDncBp6qxbnQ5Typ86pzizmn
         KHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998167; x=1758602967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSw+5V18QQW1zrEulMj1oteRdmYU7Zw4RYS7vag/74M=;
        b=hL2VZwFWHUTdQhuELdNlZY/BGabNqh9/m9iDIUKwk4+gTdsm/0VL1B4RFkdbHuRXUw
         SSqisuTnhSej1xRiHZSkOhhf79YsEjWemQrm1egHHnAiAtu7f/g9a3SgX3hHRuEGOKIw
         uGIQrdLtcWdUpl7NKMrTehYL/mPj6OCtWimyGKxC7kD8bN2M5oAPlp0iVDuLNiyVeRXd
         ws/n404Vo+TDd2ZxhqRurQJUPmZ3ZCnljn9y8TEOUmrldromSncBLZfcsQKBq6hl4jpa
         CD9H7+j8nyCFCH3lhshPtSjWpAV9JcdYRVTe8ZZNrti3ivhOQbXW6zUuk4IYXUv5cDzh
         s6HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSL1FKFpUquqd/3GTGp7vHWmWyizZeJRVVokrdBlEAhAFPqwDWgDQE8H4wNecZDYX3fod1L4+lH3IZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxqdGT1BpaY7Y912s6PsHfq5+nzeS1CQWM4DqKayWfx/xHYNgmT
	fGPKpS269uVOWwo6mvs7hzQ8utSwPBSyOfX+gNerhM84IYJPEph969qKwEvC1L2jRFM=
X-Gm-Gg: ASbGncskFlrtjbbBn9xnXO+njKvw9M0pHoa07VlZx9GZw7E5I7xTXyVEuOANeyvDlKb
	SQh0mQOpXcrNbxg13Zh5bkb5JisLVjVol4skHDGVKx+xaI8OzauvJ6NOyk4piqJ0ZLJTylWa6Vf
	13BIx51wPDE55du4LjjkNA4dn+1GtkH4i8no/jRpNgbLTYT1i6pY/hsZi9OZK3oAk/JLzZIZQIk
	btdnMe9rerm0k8/bOn42n4eto3V85NiHInSuVDVLJbYukmCBnTGMah/gnNVsxhiqyZ6Bj3LQl64
	Ec8H3HtDKhETlTkl35SeATrzwioF7UB6Jlpc7xJZ2tPqevKmUaYZwEpH8OjBsnXITknAW4T3JdP
	LrlDi5NySVHOGTr1/Q4SspUaTrSJM+AMDpkIOH2s=
X-Google-Smtp-Source: AGHT+IFoVKHWE4WmC5NQoAJgz5S3HoMpNrjT8PBpaSw1vdAI3yXeG2nG2SQAkLHZCeabG5ejGwx28A==
X-Received: by 2002:a17:902:ea10:b0:24e:bdfa:112b with SMTP id d9443c01a7336-25d289e9988mr159622635ad.61.1757998167045;
        Mon, 15 Sep 2025 21:49:27 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:26 -0700 (PDT)
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
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 11/14] net: ncsi: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:32 +0800
Message-Id: <20250916044735.2316171-12-dolinux.peng@gmail.com>
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

Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: Paul Fertser <fercerpav@gmail.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 net/ncsi/ncsi-manage.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 446e4e3b9553..6e36cd64a31e 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -650,7 +650,6 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 
 	spin_lock_irqsave(&nc->lock, flags);
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list) {
 		vid = vlan->vid;
 		for (i = 0; i < ncf->n_vids; i++)
@@ -661,7 +660,6 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 		if (vid)
 			break;
 	}
-	rcu_read_unlock();
 
 	if (!vid) {
 		/* No VLAN ID is not set */
-- 
2.34.1


