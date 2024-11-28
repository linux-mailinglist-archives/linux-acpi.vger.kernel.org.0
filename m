Return-Path: <linux-acpi+bounces-9789-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 843139DB287
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2024 06:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA902827A5
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2024 05:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC1613B780;
	Thu, 28 Nov 2024 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpEn37s9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE412C7FD;
	Thu, 28 Nov 2024 05:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772390; cv=none; b=phTxcGgQsOkKRbkpCvW6JPbI7zPTxWWx5R1TXjQMT8i2Hkvr3qxSIrC7Tg4JWw6Op5wGue9CLlNfZqO7cLgBeRgjfz42bd5yOgKhYtnIht17J2d2heh8jTkb790mE6FZutwKUYoUM5XhhOE08AXWiumTccWfmJ5yu2HDazoY30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772390; c=relaxed/simple;
	bh=plheEZQytYBgGKVoRVI6FCKulnzuzkfVqLQPHuN98LY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCZ5g42MWXP/i8OMLc4ArB/ZwmyWypBWlnLN+JdI4Nw6bxOIru9aFX48FhiFYxFWg2FXdVwgnlaDOQj6vPHV0jm3KvR5S0FyF9qoTstBce3qrxyPvNHP/vgnzrF1BSls6M5+gISEJM9ICx3bs0cPNRlwhVUwQolt3v+nFnz4LjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpEn37s9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ea2dd09971so409302a91.3;
        Wed, 27 Nov 2024 21:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732772389; x=1733377189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wH7kKXV6SUgTlW9F8VI+SFr+OnwnXgKARmGzL8+HNko=;
        b=XpEn37s9ZsKAMKsUXpcE0uDt0qUtcKZEuScjdQ0Asj1ZR+y6YgyJsDifQJ27KvkWeF
         emV1WHPE89ma52H0LsvWl/p9E19V8jOsbxv/xGYg35jSKeOYfnH9Ti7zUx3G7bTsfMBo
         umQNCVrckOaipyiNM2zt7M2iwrn22ESGtvzN5xy+b97HTt+tLRIpv8AAjgtCQBR/gdbM
         gxcjtf2C/kPjVAPXqzZS6Oubz9yIQMc8K/KRH/poeT38gl9tHWtxg4ZM/Kme5jwagyGF
         3N9tx6dcMyYQCvs/zzfYhPL8Wrmm97E8RhCs6dKBstlUX3iTx3hf5zu7xGJT97Mg/iB4
         DtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732772389; x=1733377189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wH7kKXV6SUgTlW9F8VI+SFr+OnwnXgKARmGzL8+HNko=;
        b=Rlvmvla/jBK6GuvOfsWjFt+ZCI+qAOuAaLumFQROU9D20slQsOXxg6QtV8I8/3KnkF
         9qe6+jGBWxRAeEIiTmqOOaYMUdo+YaH2xWwFcP+WMcrSS2ZYs3l/eaqUAboI3nqcZZIb
         t6Ijqk8j78uX5V6BLIwFP/IuyCNBlu4BBxenPiHDG6qfNv/xHC/HonxzUv7JkZRf9T4h
         yDCSL+ZUhYBSIxTuL6MrY3m3u0Lx3e1/psJjQRXrLF017vpza6z3Ah2ayClQDQMP9a5X
         90hqI3KyWUD+sGmRGqjoiReNF4hMrXcBoy0mHh+10v5UjsqP1LIvWGvf4BeXx/OoCLHL
         J+gA==
X-Forwarded-Encrypted: i=1; AJvYcCUON86rUMhewrtHfl7Dw4Sfz7ddBe6vL8+B/pzcvjuKC8TUfHr0VnF+5h7PkUAtNW/NT3wQpH//xhYn57g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtlYwalEcHX2uNklIVS4DzBvKz/5JzTxc1grCPvAG61Hmnomo
	hvhx+W9TZsesmuJZb4kWFAHK0nOO7qzk4v8aE/Zy03TUtI1dIaQN
X-Gm-Gg: ASbGncs1yYOkM7uNF55L3yGBTvvwxHo6iN0dVw6PN6LjI6cMyVr07co4ZrIX1Xk2pFu
	UiHfr1x2tQCCgfhwsWCCPlpXPI0DAok5uV3A1D7BOED+Fkp3N2x4sk6m2VqGxFQqBXVi9uZOvip
	ZgP9l703V9qpRVUwwj0+ccFeIW+X7YdqEes4QAWxrAGQEygMfN84BsmbhEVr2sJ2Z5DEVMwzWFw
	YC9h8fj80v46rrZf9Frxi0I6ysIn7SI0oMP7cqKNtLKqCKFfmhIQq6bYWApun/4bn4CXEOP
X-Google-Smtp-Source: AGHT+IFnhZEL+4ZWDatpHCDYYr0+uSfxiNH0T66deNFepei/f5o1CbyU18KG1EtqDr4RGlOXwrlPsg==
X-Received: by 2002:a17:90b:35c9:b0:2ea:4a6b:79d1 with SMTP id 98e67ed59e1d1-2ee08eb2bdfmr7750727a91.11.1732772388550;
        Wed, 27 Nov 2024 21:39:48 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:bb0d:3829:251:d17e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa48129sm2596378a91.16.2024.11.27.21.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 21:39:47 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] device property: do not leak child nodes when using NULL/error pointers
Date: Wed, 27 Nov 2024 21:39:34 -0800
Message-ID: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation to various API calls that locate children for a given
fwnode (such as fwnode_get_next_available_child_node() or
device_get_next_child_node()) states that the reference to the node
passed in "child" argument is dropped unconditionally, however the
change that added checks for the main node to be NULL or error pointer
broke this promise.

Add missing fwnode_handle_put() calls to restore the documented
behavior.

Fixes: 002752af7b89 ("device property: Allow error pointer to be passed to fwnode APIs")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/property.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 837d77e3af2b..696ba43b8e8a 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -759,6 +759,12 @@ struct fwnode_handle *
 fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 			   struct fwnode_handle *child)
 {
+	if (IS_ERR_OR_NULL(fwnode) ||
+	    !fwnode_has_op(fwnode, get_next_child_node)) {
+		fwnode_handle_put(child);
+		return NULL;
+	}
+
 	return fwnode_call_ptr_op(fwnode, get_next_child_node, child);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
@@ -778,9 +784,6 @@ fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
 {
 	struct fwnode_handle *next_child = child;
 
-	if (IS_ERR_OR_NULL(fwnode))
-		return NULL;
-
 	do {
 		next_child = fwnode_get_next_child_node(fwnode, next_child);
 		if (!next_child)
@@ -806,8 +809,10 @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 	const struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct fwnode_handle *next;
 
-	if (IS_ERR_OR_NULL(fwnode))
+	if (IS_ERR_OR_NULL(fwnode)) {
+		fwnode_handle_put(child);
 		return NULL;
+	}
 
 	/* Try to find a child in primary fwnode */
 	next = fwnode_get_next_child_node(fwnode, child);
-- 
2.47.0.338.g60cca15819-goog


