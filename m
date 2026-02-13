Return-Path: <linux-acpi+bounces-20968-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO1dIvLKjmm/EwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20968-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 07:55:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36233133537
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 07:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E19CE3052B8F
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 06:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08C2272801;
	Fri, 13 Feb 2026 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="O2k7g86B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFD277007
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770965744; cv=none; b=IbXyrWIVZlp0M25KCNSCqqo2YAt2tb6zkWnd0bcd0S/7hXSkytF3SOBS/qdA7Y/rC+rS6QN8eD750JYp6OGeQ5vjhAFLWc9qTQkh8aly5IR+1qSrLJ71dxE16puuXIXugwZFEbzG/caGA/yKOdakcsRErHzNNkSqL0ibaVFVPHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770965744; c=relaxed/simple;
	bh=tfRTUJkCc32g4iDhziQe0wsZk/tG/Cc4BR8eWbZn0V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mn36FTOLhdQhaYnqVtwfj9J134+/C8/y86vUCzbNHxfj+djlZaB7YAn6l20cfPhmxjTxSy+SwSQffDtb1OBe1ODQsmrnnylmpbQCcI88sF0ybQA4EN5hW08lFLhMaQRsQ1Des4dQ2HRGYqyH7/BZwu16vggnEuYEY0Adj/on4w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=O2k7g86B; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45f126d47b8so375647b6e.2
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 22:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1770965742; x=1771570542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lubSrpyTaylapxsmwDf9p0k6fdzQ/YAegC4aSdF8hSg=;
        b=O2k7g86BP6SMg1IPQb90LzLnkeopKaf2vv7J8z7xH6jD1Y0vSp2FkG8Iwhd0mUPfsU
         wZyJnImdgT4S9YvDhc4XTHtQ71GvFIElVMTLgGvofLIOVKVwM1AKXNVpTPFDp2G/gayZ
         HSe2iZLHklb9KfUF5p1Xn7CTSDG5vebQeJhLat8dxAPmzBAMyAHiOfWEOi+hu5ehuwC+
         7Sh7zuspQqkdm7X6JWQyV+RVGyHeAjwbEVJI1f9oNQSKYxwU9aQlzjAlpx4l2jJjjg4v
         4DftfYWqPqCMxEa1InsfNt4G0QUWx07QrWGDN67QPV4TJFPZC9gNExaC3dx7sFB7fjWu
         h8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770965742; x=1771570542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lubSrpyTaylapxsmwDf9p0k6fdzQ/YAegC4aSdF8hSg=;
        b=psbLlqe7kwOW0tll5/+ZBEgw3C97U/QlyMNi/8GsnnioTblZCVOW36uOY0ztwK8f2x
         s6SYc0ezurwHlzd/UziRELzhDQscU/j4sbG4a8upi3WW4yBGFPeS1F/OysHqGGKHEOl8
         5wWvSRVsw0l1Xm6XMHgte0oTQeTCYZbNeD5fMthN9C5foGiwOVJakTPMZXUjmwkpPBY8
         A937gRpwccKqKjqNOBB2fe1k7gE0Z3PyQKm5JqTEJai3RrRK0DosMQPjD1zcO7/gq6i/
         Zs8M9QEbFovHx0MmwjHDZQ6GNPtBf4BpsodrsYQ9kaFijGbbKThmGd6r7I89q7Uom2bU
         PfEw==
X-Forwarded-Encrypted: i=1; AJvYcCVXmaXxFWWMTaXOAVDxk+UmDjTw1lr72ltTLW22k0h40UyCoFd4bdLhfZsdO1C/Z7L/LvjYyht3TRjk@vger.kernel.org
X-Gm-Message-State: AOJu0YyFfKQREej6FduIwfGGW2Zs9cquZdfEaN+mbB4N2k/UUMSzfsis
	thj2020uYrXKqfvJFMpImvs5LDUoJ+zYf7k82beq9Tq690/gFHu39Iz5bkNpV/0Q9BY=
X-Gm-Gg: AZuq6aIfgF0wZMXGba87BgJJSgabstWZ966ORd3ZJc08zp3MTtuLGjlYjUVCCIOZ1Jg
	32xOaXoZz3Zor50iZ3BBYkUy8ddMaXmQ3if8LJKGtmak6QO5tg9+qv3ozsKQ5Zow4T4NzSfhYuA
	bwIUbXrce62WG691wI1qH+UZE8f4S37zOsmVRHFNlyam3uun1BZecP1wKZDskvZ88RPwnBksxAs
	6xGMglcXGD8KO85s/fmz+at1LxlgVKBDxMWIyKDrYOQnAoSb8BFCW9mLqqB3Do437/d2DNdF0HF
	6KhqUgSJTyrOawN2iGjWPi2MnxW8MFLjOJWAGK3uEX+Pum/YS1wNknnBqQGs8vG0Z/SKGX/gat4
	oy9MZALqzaVJpzv1MrLc1jCAA+OHwIyZuKezRYbxfcWfgRSpjm12YPWoKTaTBeh+HFwUXUyRdRL
	Mvu/HT82QjeBr/v3zPCZAvdHVTyPrTjXgyIEa/iVv/OG4WCEntzffOxu0dS+xlgtKqhYCdK89/8
	tv54g==
X-Received: by 2002:a05:6808:f93:b0:45c:75ec:b9b3 with SMTP id 5614622812f47-4639eed169amr431269b6e.9.1770965741624;
        Thu, 12 Feb 2026 22:55:41 -0800 (PST)
Received: from localhost ([2001:470:b8f6:1b:a3ab:7352:1dc1:6b46])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-4636ae8f86fsm4200112b6e.3.2026.02.12.22.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 22:55:40 -0800 (PST)
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
Subject: [PATCH 2/3] ipmi:msghandler: Handle error returns from the SMI sender
Date: Fri, 13 Feb 2026 00:52:14 -0600
Message-ID: <20260213065351.915707-3-corey@minyard.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20968-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[minyard.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36233133537
X-Rspamd-Action: no action

It used to be, until recently, that the sender operation on the low
level interfaces would not fail.  That's not the case any more with
recent changes.

So check the return value from the sender operation, and propagate it
back up from there and handle the errors in all places.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Fixes: bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is non-functional")
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_msghandler.c | 97 +++++++++++++++++++----------
 1 file changed, 65 insertions(+), 32 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index a042b1596933..c209486bfee7 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -1887,19 +1887,32 @@ static struct ipmi_smi_msg *smi_add_send_msg(struct ipmi_smi *intf,
 	return smi_msg;
 }
 
-static void smi_send(struct ipmi_smi *intf,
+static int smi_send(struct ipmi_smi *intf,
 		     const struct ipmi_smi_handlers *handlers,
 		     struct ipmi_smi_msg *smi_msg, int priority)
 {
 	int run_to_completion = READ_ONCE(intf->run_to_completion);
 	unsigned long flags = 0;
+	int rv = 0;
 
 	ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
 	smi_msg = smi_add_send_msg(intf, smi_msg, priority);
 	ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
 
-	if (smi_msg)
-		handlers->sender(intf->send_info, smi_msg);
+	if (smi_msg) {
+		rv = handlers->sender(intf->send_info, smi_msg);
+		if (rv) {
+			ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
+			intf->curr_msg = NULL;
+			ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
+			/*
+			 * Something may have been added to the transmit
+			 * queue, so schedule a check for that.
+			 */
+			queue_work(system_wq, &intf->smi_work);
+		}
+	}
+	return rv;
 }
 
 static bool is_maintenance_mode_cmd(struct kernel_ipmi_msg *msg)
@@ -2312,6 +2325,7 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	struct ipmi_recv_msg *recv_msg;
 	int run_to_completion = READ_ONCE(intf->run_to_completion);
 	int rv = 0;
+	bool in_seq_table = false;
 
 	if (supplied_recv) {
 		recv_msg = supplied_recv;
@@ -2365,33 +2379,47 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		rv = i_ipmi_req_ipmb(intf, addr, msgid, msg, smi_msg, recv_msg,
 				     source_address, source_lun,
 				     retries, retry_time_ms);
+		in_seq_table = true;
 	} else if (is_ipmb_direct_addr(addr)) {
 		rv = i_ipmi_req_ipmb_direct(intf, addr, msgid, msg, smi_msg,
 					    recv_msg, source_lun);
 	} else if (is_lan_addr(addr)) {
 		rv = i_ipmi_req_lan(intf, addr, msgid, msg, smi_msg, recv_msg,
 				    source_lun, retries, retry_time_ms);
+		in_seq_table = true;
 	} else {
-	    /* Unknown address type. */
+		/* Unknown address type. */
 		ipmi_inc_stat(intf, sent_invalid_commands);
 		rv = -EINVAL;
 	}
 
-	if (rv) {
-out_err:
-		if (!supplied_smi)
-			ipmi_free_smi_msg(smi_msg);
-		if (!supplied_recv)
-			ipmi_free_recv_msg(recv_msg);
-	} else {
+	if (!rv) {
 		dev_dbg(intf->si_dev, "Send: %*ph\n",
 			smi_msg->data_size, smi_msg->data);
 
-		smi_send(intf, intf->handlers, smi_msg, priority);
+		rv = smi_send(intf, intf->handlers, smi_msg, priority);
+		if (rv && in_seq_table) {
+			/*
+			 * If it's in the sequence table, it will be
+			 * retried later, so ignore errors.
+			 */
+			rv = 0;
+			/* But we need to fix the timeout. */
+			intf_start_seq_timer(intf, smi_msg->msgid);
+			ipmi_free_smi_msg(smi_msg);
+			smi_msg = NULL;
+		}
 	}
+out_err:
 	if (!run_to_completion)
 		mutex_unlock(&intf->users_mutex);
 
+	if (rv) {
+		if (!supplied_smi)
+			ipmi_free_smi_msg(smi_msg);
+		if (!supplied_recv)
+			ipmi_free_recv_msg(recv_msg);
+	}
 	return rv;
 }
 
@@ -3965,12 +3993,12 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
 		dev_dbg(intf->si_dev, "Invalid command: %*ph\n",
 			msg->data_size, msg->data);
 
-		smi_send(intf, intf->handlers, msg, 0);
-		/*
-		 * We used the message, so return the value that
-		 * causes it to not be freed or queued.
-		 */
-		rv = -1;
+		if (smi_send(intf, intf->handlers, msg, 0) == IPMI_CC_NO_ERROR)
+			/*
+			 * We used the message, so return the value that
+			 * causes it to not be freed or queued.
+			 */
+			rv = -1;
 	} else if (!IS_ERR(recv_msg)) {
 		/* Extract the source address from the data. */
 		ipmb_addr = (struct ipmi_ipmb_addr *) &recv_msg->addr;
@@ -4044,12 +4072,12 @@ static int handle_ipmb_direct_rcv_cmd(struct ipmi_smi *intf,
 		msg->data[4] = IPMI_INVALID_CMD_COMPLETION_CODE;
 		msg->data_size = 5;
 
-		smi_send(intf, intf->handlers, msg, 0);
-		/*
-		 * We used the message, so return the value that
-		 * causes it to not be freed or queued.
-		 */
-		rv = -1;
+		if (smi_send(intf, intf->handlers, msg, 0) == IPMI_CC_NO_ERROR)
+			/*
+			 * We used the message, so return the value that
+			 * causes it to not be freed or queued.
+			 */
+			rv = -1;
 	} else if (!IS_ERR(recv_msg)) {
 		/* Extract the source address from the data. */
 		daddr = (struct ipmi_ipmb_direct_addr *)&recv_msg->addr;
@@ -4189,7 +4217,7 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 				  struct ipmi_smi_msg *msg)
 {
 	struct cmd_rcvr          *rcvr;
-	int                      rv = 0;
+	int                      rv = 0; /* Free by default */
 	unsigned char            netfn;
 	unsigned char            cmd;
 	unsigned char            chan;
@@ -4242,12 +4270,12 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 		dev_dbg(intf->si_dev, "Invalid command: %*ph\n",
 			msg->data_size, msg->data);
 
-		smi_send(intf, intf->handlers, msg, 0);
-		/*
-		 * We used the message, so return the value that
-		 * causes it to not be freed or queued.
-		 */
-		rv = -1;
+		if (smi_send(intf, intf->handlers, msg, 0) == IPMI_CC_NO_ERROR)
+			/*
+			 * We used the message, so return the value that
+			 * causes it to not be freed or queued.
+			 */
+			rv = -1;
 	} else if (!IS_ERR(recv_msg)) {
 		/* Extract the source address from the data. */
 		lan_addr = (struct ipmi_lan_addr *) &recv_msg->addr;
@@ -5056,7 +5084,12 @@ static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
 				ipmi_inc_stat(intf,
 					      retransmitted_ipmb_commands);
 
-			smi_send(intf, intf->handlers, smi_msg, 0);
+			/* If this fails we'll retry later or timeout. */
+			if (smi_send(intf, intf->handlers, smi_msg, 0) != IPMI_CC_NO_ERROR) {
+				/* But fix the timeout. */
+				intf_start_seq_timer(intf, smi_msg->msgid);
+				ipmi_free_smi_msg(smi_msg);
+			}
 		} else
 			ipmi_free_smi_msg(smi_msg);
 
-- 
2.43.0


