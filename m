Return-Path: <linux-acpi+bounces-16996-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBB1B58D8D
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 06:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58C5322B34
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 04:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BF62F1FF3;
	Tue, 16 Sep 2025 04:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL+Xia8W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C02F1FC4
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998190; cv=none; b=btbR1CAbO1kCjr17i5Q00E3qN2XaJ8JIpOJMbprfEaVSQ6ypz5qGJFtlmLcWkTAbjjTdI83BBAHdnwm/+J6Z4PUp4qXI/vWvJxPzVYSypPBQ1NbuBfQ9R5IiMFXFXOZR49f9UQEC09prsaTbq4u2pGLsZMjiYUjG9S30Aj1ynP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998190; c=relaxed/simple;
	bh=slyVnZPzDDOXEcpF4QZOR3I7YB3yd3f7Gxtzb+FU87Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GgBA8tfsbPyJu+OFl77283+dFoEmNxRA6/CxBwN1VEXb60i4kx4Su6wFAcZoZBY5yfxD6q1lotuYaYnbto+3/wiSNsK5pGoX7Wc1jTOXUY+G8G3Up23RER98nntYtImbfjq8drphQO5QFYlUZ+FkvMde/6tswxiRdlowXM8XBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL+Xia8W; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-25d44908648so47050505ad.0
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998187; x=1758602987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlYXyo2uZuFo7JhGyy9UUCXJlKeDR2CbpPIjqr5RgpE=;
        b=JL+Xia8W4uyroTDLgoFXQGcvga86g7+1VEKz2roIDSxQwxKuGGI1kJw0E5mRvO2QSO
         m/1WcvkXEpAacTm9jy5S7c5V4Dczrr3meBJOyddNip27HVCCCOgthvtb5FLtkxbvF41s
         iGlUzzPGymDg3T5amMQJm6PDCBR7n+L0ahtyEay0NJYWIu7m2vFg6tr2ajT32yaanfBd
         xDtJu+c4X/3CeTjTCyDCOh+jJ9IMVyUrOd4EWhGGuGTa3TWSp3+no8CtHQqAuwI3rWWA
         BuIdQSsCM/Xgm1YsJeGbAazZkNWV/RcrZ3PBFtpntXLtYH4Vrd8FCoda8o0sXcMxI94o
         +OOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998187; x=1758602987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlYXyo2uZuFo7JhGyy9UUCXJlKeDR2CbpPIjqr5RgpE=;
        b=aDvmoDaEndmhJAvqdxJEwAlj69TMVoniMQURWT8bC2nmhas7kYrFg/mXOgsyl8GYRn
         FTsPLXAL8nQH+C9dQudKXncGVZsg2EBH47Na51StB/ukeAzN1FKIp12M6IhOBCZDMGPz
         GE9ScpHljqgadWy/0O5pDD8MEmNN2Bnwu3RKe9IFw6/3+qadiYyNzqMpVnaxiWMcrn8+
         wxYYsj6/xbNoBIDbXU1vhnakfyJoxcwqNbYQJT0HNFw4EwM4pOzdE2bY1VPu2ojhQXun
         88j3BKftkbeLeTtFSNEbNVitg+4SLooyD5ACItdf6BARDD/cPrRG2zKCKEtC132R0oDd
         SJGw==
X-Forwarded-Encrypted: i=1; AJvYcCWDDtAXDmb0/pxWskba+K+CU1/v6+Y9pPNXPCOQKUcWUskKV0Km8I+hMZmuhOaT6lFS805IyaKDvuLQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyVHGGGdA/caetbTSMURTspAqNNV9i1Jfq2o94C3TlWIqbtvaTg
	iXuAe2q5BgSk8GIALxAc0CeWpGwE7+pG5z2f0zgLkuQbs662Y5DRGS/PFvCrFygs4AU=
X-Gm-Gg: ASbGncuGWofd7PYV+Jb8+7MXH68vyDllEVA1t3GOCeqpNeWLO231jKepu47NWRXrJ+y
	1ZwDtB/QURPB2iK5DtnT6c2352/1UcPCTtWc40Ki6vfAKVQ/vhMTzLnh85ILX9P58NdbAAcW4z3
	OAcX5ZZgvuPGKq6TXfISn/85X6l/4+ToA8XHxfOPuLhC+1vtE3CgxQ4FsE69jsjifHIZshvuyR8
	x2RIAwUvAm0Fj8v/3JanIuuErujvnmK13BmQCCBgSw8133/lBuTXonZbd97x639ivC9DR8g/C6R
	g/2rKURBRRuRl2Om9JojrKhXsoNjVMHqB5lDx6N7fDQpbvOVxCCF81rZ+3agvE1lqPYNf9nOd/m
	sz4Vty3zpAG3QTrkaclMXrI1k1pnCfhNrjdM6GDwXRHI4TJs6mQ==
X-Google-Smtp-Source: AGHT+IFV4zbzh4iycIfH4WDU92suC0bCanMglT0Ogl2GwpwL8kM68NHrYSygkh1AIkIcAzvJhqwslA==
X-Received: by 2002:a17:903:2f4f:b0:24c:99bd:52bb with SMTP id d9443c01a7336-25d267641camr179941415ad.30.1757998187203;
        Mon, 15 Sep 2025 21:49:47 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:46 -0700 (PDT)
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
	"Toke" <toke@toke.dk>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 14/14] wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:35 +0800
Message-Id: <20250916044735.2316171-15-dolinux.peng@gmail.com>
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

Cc: "Toke" <toke@toke.dk>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 0ac9212e42f7..4a0f465aa2fe 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -1993,7 +1993,6 @@ void ath_txq_schedule(struct ath_softc *sc, struct ath_txq *txq)
 
 	ieee80211_txq_schedule_start(hw, txq->mac80211_qnum);
 	spin_lock_bh(&sc->chan_lock);
-	rcu_read_lock();
 
 	if (sc->cur_chan->stopped)
 		goto out;
@@ -2011,7 +2010,6 @@ void ath_txq_schedule(struct ath_softc *sc, struct ath_txq *txq)
 	}
 
 out:
-	rcu_read_unlock();
 	spin_unlock_bh(&sc->chan_lock);
 	ieee80211_txq_schedule_end(hw, txq->mac80211_qnum);
 }
-- 
2.34.1


