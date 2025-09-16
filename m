Return-Path: <linux-acpi+bounces-16989-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A24FB58D61
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 06:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FABE52628A
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 04:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE6D2E540B;
	Tue, 16 Sep 2025 04:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCefdEHH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F452E4279
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 04:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998143; cv=none; b=cyzvjXhLCaOb3iAkRnMB1AeLOShGq+qSCRpBE30fR+RyZidemT5nJtPecQ+d9p8+6U3q0Eblv/x5s75hn8vzz9DSY3BfU7KtKoA+LOYZo8z6QG4nLwVcERZFu9IOko+Bl7229dSnzymwl33Cf4YQ6+/IG92NhqLhFgaTfygBBOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998143; c=relaxed/simple;
	bh=HguuC3cJW9LHrBXuF3iFTqdhADSKZ6I2ZWC/adsG6L4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YNEeYEq9mLLH8zRN+uBii1JNm2wnjSEh0M3DFFpUO+f9Y3/FNbGD3KJvrvya1r5V1N5NHuUZBOwTxF/Cb7TfkmWGRr8xEkh/IZcPAIp8x7gwQ5R8yLw+IFlkGKPE0iVSSIyzZT/wb/5BKbktiSf2xWz5FAraw7Yayxoq1k1r1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCefdEHH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2570bf605b1so48700255ad.2
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 21:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998141; x=1758602941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y26N2MyOP2FIPMMMBT4JTn6kc4P01rdpdKyvYPEfOYc=;
        b=SCefdEHHiZ8jZW6xYxJti7tA2y6Bt/GimNvdDYVlgmt2cdNVo7OAJcSr5LXKXEOZbf
         UGGGRX1bIlzd25p9XFG3/AuL4AFo52i36GuOp66KC85Uy/XbHwdetBCk4RfB+CQtV8gG
         bGB3fSsvylkjw0Qw4Syn2pjMO2oaoTpIVOMeW4ync7cEGsK5I0d5n9YApMb74KRv+vYB
         BDsg0UVn1UNIr5Bvs8KUVv/ud5TILGiBsHgcv/yWZ1/CxUmiVCACSIprr/HVidhnRt5o
         0KUolDW/QN7el5Pxc8O7RQcX/fWH9lLT4zQlNsvIDmOvD+BeCZn4n36z8iFAwSLI9O/A
         kioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998141; x=1758602941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y26N2MyOP2FIPMMMBT4JTn6kc4P01rdpdKyvYPEfOYc=;
        b=B4gxoPfE3Yn4nVGmikAVrVDWYkdeJiV9xRjMiQEOBA4qKotAE4fBD3cj0G3MKYvVCp
         8EHD8LTE3YC/MEC+Z9o0NvWXKuthFzwkr0zA0tFKiOMy7Tr8p0jKreBIsuyJL79hrOZF
         WHLNIGB3Ta0fGoFySlydSLT1VP5p3yxThAQk8fx0TgRpJjMVokPbAVEHcvuoTeYKnoTq
         Q+60z9Tn4iBWfaanG11QGhvVYr3G3tx+FQinePe1PkNOxm0st84Zk7uwuyHwq347cTZf
         FbdRQd4OA8pBb6JpT/r3LnfR7HTP2GWZoEa44DQ38GyZMkMvu7oHErTOcOKwiRzvsJYi
         aTjw==
X-Forwarded-Encrypted: i=1; AJvYcCUDCnmK2PbuGCze4/C0IsWEJ72f6BqpeQ3ZmTnYFf3ZnuBWgpUzUFS+DAcGEzVX2tlGNMgO+X39wJv0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2yZkoFVRBfOcAdHVcmsFAcLiXUIP3U6Ug80dTSn5RrwINMWSX
	K7t5Ji0Hw30cG2KD+7WrueibdvY42a/mVOKEReXZtunIPaWCzpvmUxcE
X-Gm-Gg: ASbGnctY5BdMA0zuuK17Nf4aAyrws0pyDXSGCRy62vXZMaEzmZnY/3/pFTNjCnDLF45
	bDn8ml0PqW1ChVsoMdQyY1Wp40cf6+TMOg2jLeok8Rz1IEsXJN1VVKJ7SXU+X1q1/WtGD3PcjlF
	yn7XwBgXNpFBd/md/IoIBrrTy7j5ErSLMgU9P5+0HtzMQPD8ZOdqXkXZqa5zr4qIRavGf/3dbxR
	bPOIYI79YSOHEaUsozhlaBdr8f0/LmDN0sENBjBWjKmlnXQ8xH2JiYGf1cYnynw7+x1jwKV5iEQ
	YsuuxmFu5UZefejyZjhEKcbPaIG/v6qVaKR3ZryutCxZbQvq9FtbwH/ANmhE1l2eQqyqw15JLdb
	XD4wrPUCUKxmsEDg7DsEw43FEd/upX9zD+3SIuJw=
X-Google-Smtp-Source: AGHT+IEF8hyGYSwfpfRfNi45Ml5S5Z1xWLwd/+S+vouYcjrRAMMRr1JH2N5TAK8bBOVvYAZpMt3b8w==
X-Received: by 2002:a17:903:ac3:b0:267:d772:f845 with SMTP id d9443c01a7336-267d772fcf1mr8896415ad.52.1757998140582;
        Mon, 15 Sep 2025 21:49:00 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:00 -0700 (PDT)
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
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 07/14] yama: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:28 +0800
Message-Id: <20250916044735.2316171-8-dolinux.peng@gmail.com>
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

Cc: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 security/yama/yama_lsm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 3d064dd4e03f..60d38deb181b 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -117,14 +117,12 @@ static void yama_relation_cleanup(struct work_struct *work)
 	struct ptrace_relation *relation;
 
 	spin_lock(&ptracer_relations_lock);
-	rcu_read_lock();
 	list_for_each_entry_rcu(relation, &ptracer_relations, node) {
 		if (relation->invalid) {
 			list_del_rcu(&relation->node);
 			kfree_rcu(relation, rcu);
 		}
 	}
-	rcu_read_unlock();
 	spin_unlock(&ptracer_relations_lock);
 }
 
@@ -152,7 +150,6 @@ static int yama_ptracer_add(struct task_struct *tracer,
 	added->invalid = false;
 
 	spin_lock(&ptracer_relations_lock);
-	rcu_read_lock();
 	list_for_each_entry_rcu(relation, &ptracer_relations, node) {
 		if (relation->invalid)
 			continue;
@@ -166,7 +163,6 @@ static int yama_ptracer_add(struct task_struct *tracer,
 	list_add_rcu(&added->node, &ptracer_relations);
 
 out:
-	rcu_read_unlock();
 	spin_unlock(&ptracer_relations_lock);
 	return 0;
 }
-- 
2.34.1


