Return-Path: <linux-acpi+bounces-20969-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LdrI/XKjmm/EwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20969-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 07:55:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19126133540
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 07:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC80C305289F
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 06:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412B42773F0;
	Fri, 13 Feb 2026 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="ZNbtDBtP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97412773CB
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770965746; cv=none; b=R9hYDksbhPQKdFBrYpVDHIIqFBLpAVNvj9Pg11P79fC3vOcIqzNd0zNTHQzcdcYTqIG9tgVVL8OVjzcOE0JEz/9K2i+rYKe9Z1ht3j/yQilHNc2pvCq7Q/CcdTtl/k+0m8PCBlmMPlL0BJ6UaZVSVavIIedhbYiMJPGx7EYB5Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770965746; c=relaxed/simple;
	bh=lQbl8rYIfrG6wxU4E3tWWSxo4aRWKZ/dPc/QN30m1rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ukow9Pkagi+19xuTEkpWwfx20TWC8sTvxQsi3CJqA4KpyxwZLaHTGohr1clgnKnnDHkZgFM3gTpuM8ALBtWl8fQXnSkgu6C27aFaRg9OmL5uGN9waQG93W9SW2Yhhq5QqjU9iBHYO+Ri687L+pUNiRm/DuSac5F89cXXVVAxdyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=ZNbtDBtP; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45f18e8f2f5so407734b6e.3
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 22:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1770965744; x=1771570544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWDi80vPYKTAc6upvJphSdvAtuHW5MV8Yc1eLb4RAzw=;
        b=ZNbtDBtPb0lSM6o2LcZ7iDkFi/n3hx/bsvxEuT+cl23EngTjBIEuYp9scehwqKOzvQ
         GKUGRZhn9VW8r+j4MvrFxDUZYuq55B+n/6+PKwSST4781ID0e+1LdmL9z9BWgMsEqWL3
         CbFPOAH7Drz0tRu7utXXsXSI28dsxmW5qGea9s5rW2HA1D6iIngQSMjd6My6LVA25Wv1
         uD+GYJMPpk7bbAvd0vTTU1Ii9eayMfqVR1TGRwOId5Ulo58a6M1sR6IcIYe+xkWhOCM2
         KMCouXmVDvv3Rfn2AMe0P9icQsHYz5pknu+BAgL0Ej8YNgr/QnhffK+tEnByhgeeRxMv
         JIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770965744; x=1771570544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UWDi80vPYKTAc6upvJphSdvAtuHW5MV8Yc1eLb4RAzw=;
        b=Z1ATf635U0F1XSxFPWFp5eXBbyI6ZhfQFdLO1QkNqvsteLC1R/4uubBbTRd/m4/qdf
         zdYbXAAGuPvkeXZmyX3vkxlISp5YsdHdS6p8IGripidXnB0Ntc9+jMRd9lhYTmh6Cxkb
         AYkp5KaFfMb8LzcRFyOxqOszhjQyCsWSvvASXziGA1dscKkDDy4/7kVfikNyJahLvbWh
         mFdyyerv8MNV050j4tzaJHNuDjlsC1WVSJKP40bpWt+jW61ZJ+z6DNG4KpzX4iKtXaVE
         q0KoWGUpV2ow47SiVrJtLGFrbG0KcAcGX0ZbMJPCiXqgmMVutTc62GvETLlgqlCMJT+0
         fAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeeydK3rPEDZJFOBem+OQ5VCqA3fJbympToj3cxeY24n+cu257WDfy23JOs0rBfYmM8vcdQNFiYo0u@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5733ErIQiMe4qsijSoGxq8qzLTfgcIOxztogw9nYIwrNjTl+X
	zs6/prGS1vu7J50N9nzv5HWy4pedsxWZba5CsuK3UcrE+aCLbiu+Bhc4M+zt8vLmzjo=
X-Gm-Gg: AZuq6aKpy+Bfhp19GMfetWngQZjaK0n5YSxrqu0Gwl+uvVO39QqGXx0FJZzdMqc5ebW
	rFxy/GOHfjIlpTce8D94AntUpxWKXheTOY2XvAjZlvAUnhJXcBM8O6Qls6yZMx53+WMX/YJAOcb
	UZ25GjLMjGTHRSJzv+iaF9kWlIZlpkxD159QYcjM8+3qWeDF47nGrl//l0z6Yj5Yl5HOtT6qi6Q
	XlvRDlzkNyi2hyAMc1u2AWXxTpSu2wNHbM2RHJWGYz3yual5izzlL8WwwOoz1RYbHm1Cx/FdDYA
	IgWBulWTpx0AVp9nzW9mi/F6jbNqrDCVTaw5QFdKpYHDYbAl9YbyoS1kgmg2h3U1xDVkYmLQp3Z
	7XQ4HTc1/zOa4DE/3NZd1BQcqsIA5eRJQ1VYjnz2LvnhaGKGWxQF/27o23ZBvTDzbN3oRSZ7Wq7
	hlE2eW2MKt14dls3Gdv6idWrqEG2i73VXeDly8HSVv77G5bXacr2MenLS998S0v7BM9zH4gNZPd
	5/NelbRZ6Qz4/+R
X-Received: by 2002:a05:6808:c1e8:b0:45a:770c:d77b with SMTP id 5614622812f47-4639f1dcb8fmr563573b6e.35.1770965743932;
        Thu, 12 Feb 2026 22:55:43 -0800 (PST)
Received: from localhost ([2001:470:b8f6:1b:a3ab:7352:1dc1:6b46])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-4636b065d46sm4261406b6e.12.2026.02.12.22.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 22:55:42 -0800 (PST)
From: Corey Minyard <corey@minyard.net>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Igor Raits <igor@gooddata.com>,
	linux-acpi@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Daniel Secik <daniel.secik@gooddata.com>,
	Zdenek Pesek <zdenek.pesek@gooddata.com>,
	Jiri Jurica <jiri.jurica@gooddata.com>,
	Huisong Li <lihuisong@huawei.com>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 3/3] ipmi:si: Fix check for a misbehaving BMC
Date: Fri, 13 Feb 2026 00:52:15 -0600
Message-ID: <20260213065351.915707-4-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213065351.915707-1-corey@minyard.net>
References: <20260213065351.915707-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20969-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[minyard.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,minyard.net:mid,minyard.net:dkim,minyard.net:email]
X-Rspamd-Queue-Id: 19126133540
X-Rspamd-Action: no action

There is a race on checking the state in the sender, it needs to be
checked under a lock.  But you also need a check to avoid issues with
a misbehaving BMC for run to completion mode.  So leave the check at
the beginning for run to completion, and add a check under the lock
to avoid the race.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Fixes: bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is non-functional")
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_si_intf.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 3667033fcc51..6eda61664aaa 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -924,9 +924,14 @@ static int sender(void *send_info, struct ipmi_smi_msg *msg)
 {
 	struct smi_info   *smi_info = send_info;
 	unsigned long     flags;
+	int rv = IPMI_CC_NO_ERROR;
 
 	debug_timestamp(smi_info, "Enqueue");
 
+	/*
+	 * Check here for run to completion mode.  A check under lock is
+	 * later.
+	 */
 	if (smi_info->si_state == SI_HOSED)
 		return IPMI_BUS_ERR;
 
@@ -940,18 +945,15 @@ static int sender(void *send_info, struct ipmi_smi_msg *msg)
 	}
 
 	spin_lock_irqsave(&smi_info->si_lock, flags);
-	/*
-	 * The following two lines don't need to be under the lock for
-	 * the lock's sake, but they do need SMP memory barriers to
-	 * avoid getting things out of order.  We are already claiming
-	 * the lock, anyway, so just do it under the lock to avoid the
-	 * ordering problem.
-	 */
-	BUG_ON(smi_info->waiting_msg);
-	smi_info->waiting_msg = msg;
-	check_start_timer_thread(smi_info);
+	if (smi_info->si_state == SI_HOSED) {
+		rv = IPMI_BUS_ERR;
+	} else {
+		BUG_ON(smi_info->waiting_msg);
+		smi_info->waiting_msg = msg;
+		check_start_timer_thread(smi_info);
+	}
 	spin_unlock_irqrestore(&smi_info->si_lock, flags);
-	return IPMI_CC_NO_ERROR;
+	return rv;
 }
 
 static void set_run_to_completion(void *send_info, bool i_run_to_completion)
-- 
2.43.0


