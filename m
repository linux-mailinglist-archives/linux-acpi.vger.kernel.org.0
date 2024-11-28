Return-Path: <linux-acpi+bounces-9790-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C9A9DB289
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2024 06:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8D128279C
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2024 05:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1AD13DB9F;
	Thu, 28 Nov 2024 05:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6GzfjcG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46791386BF;
	Thu, 28 Nov 2024 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772392; cv=none; b=Hr8AnwHIBrdhWGzMdpvZ9TgrmGo5Ci89jUAiP2Cb+FoXJeGFFrK+1uXXQYGFMfnW2pUx3eUVTSWcGCGnBlu9fkA4td9T8qJSRyf8nDmI96Grh6KXEYt6gUPe8Y+9YNjjUP1hFpHmcFSrfvxL4USMKXXgz7UuClDObMMc+6KBlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772392; c=relaxed/simple;
	bh=q0h/8gJLp0gi27H54L5UHK5kW0bmhamvPRIhgEkdf0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2tqqRqBlL8/NoxEOWcmYjbhERfMwA6UiUU0BOOLb9Nsu6Y4xc66cjGmVnfbZpqjyZ6dytFrdOUECKnGxEmPxF1gIW1B4efv5x1y/uVFdZrslH2UXvSAvZY2jSraYD7EcXrTE6mhylEuqrDfYxWC7/B1SRoxPYQ6r4Ev7G0x4ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6GzfjcG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ea1e5fc65bso388289a91.3;
        Wed, 27 Nov 2024 21:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732772390; x=1733377190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t00tEb4E12UQ92MlgqLiTeE/yIwZhbS/yVAJUvJOOsk=;
        b=P6GzfjcGtYqllC7U/QpZDT4lgjebP6NJ2VKGcf3/1qxkw2Rd1wYyUJsSbrVOw5qQq8
         Yl4LIYi7TtI7vuUnSP9mq3BVZPkR8g3TWraQXI6UARvIg8TD00IVlxHEc18ATc9ZR0WR
         TfWmvhejyt4+BuyuBeYAdce9HqbKA2yH6TZqhb8ogyr8XR0k8z2oJPSCexGdv8BtDzdr
         oacQSNRGicb6JarXeAYUD6j+hvXXqaXDOb1zCa4NGMKXFOEhoyV0g0WXuEwBiCnodzRK
         zS+VnueoKGjGXwPstUa2aLPmsFXTzpiMMTZr+BnJgSbstlTicHbD++hTH1oytB2ugIQt
         8ABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732772390; x=1733377190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t00tEb4E12UQ92MlgqLiTeE/yIwZhbS/yVAJUvJOOsk=;
        b=G3/Fj5fqsWDdLj4czyBiL9R7ZdGdyRSciDdXmG5gwMHogZdUBDAW2QQyq/7AZMCbYa
         rV5OYQYyNKoBxK3G6EEBbuWsbugXWKy9RIjru+yYH0lObfVxRZGdkcCYu1L3gKkLU7EC
         muI8qbe64PsADWbC+VyLoD43zDIH6DC/askCSb8qr0rXKx4uEkw2uB5+Pc7HPRf3gieY
         zM4wZd6ffkk7uwUnNdaDO19+2DjqsYQvvkvlDp3yjvN0Nq33PWsZjfbAHICZMgdtLYDl
         tzj0O+kiJABNx0oAXaj1p0o6yufm/mj7tSF0SbhBC1ZmmUCMnhmIlmyakY4WDBDP2UjR
         TZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCVJhO4dRHomsGILWYoS7wQ4cz/0P/ih44P2Zd7UMZCwFxC2hjzWvtRlT+gbwvy/LrDzuWu0usSY5kwWLWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXAvtLkjDuO4ULor5QelKh/OK0V1D+Hp9F9YILWuHP2gUxaBB/
	TbTjO7F7+XEFduNJJ/bEV+bYviPG4HA56hOJ+vhg6H0sBgVtNhEt
X-Gm-Gg: ASbGnctdRa4BS+uybwUE4dYTi70qx15nSqrfFdlldZ5QtCjnExgBDiYObtFN4erfjiP
	2GZzoevBZMMgziZh8I2bS4xm/r7y4UiPrvvhnCOlXyYyio5dKZztqQ/8Bs7Md7DLx/bUDDjHXgm
	O2R6CC9iVUBOsewjJ108z2rsKnzGLKA6RJvDJKWbWANvLn1f5urlIQZdAF+epIZPBhW8dHa9jMK
	Y0NTs3+8N6VUhXwKDEoxsGH4aZBXuPsY9g4M26VELg9CV3AdNbIum6mbukTr3T3pEyJDe+6
X-Google-Smtp-Source: AGHT+IHhKqy7i5oZJ0dDSwXdikeb120EBwdCOEJLtPJyeBeGi/5ktrJ8ovIHj22jK2XheK8pZkm0Wg==
X-Received: by 2002:a17:90a:d410:b0:2ea:a9ac:eedd with SMTP id 98e67ed59e1d1-2ee08eb1d90mr7615170a91.9.1732772389741;
        Wed, 27 Nov 2024 21:39:49 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:bb0d:3829:251:d17e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa48129sm2596378a91.16.2024.11.27.21.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 21:39:49 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] device property: fix UAF in device_get_next_child_node()
Date: Wed, 27 Nov 2024 21:39:35 -0800
Message-ID: <20241128053937.4076797-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
References: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwnode_get_next_child_node() always drops reference to the node passed
as the "child" argument, which makes "child" pointer no longer valid
and we can not use it to scan the secondary node in case there are no
more children in primary one.

Also, it is not obvious whether it is safe to pass children of the
secondary node to fwnode_get_next_child_node() called on the primary
node in subsequent calls to device_get_next_child_node().

Fix the issue by checking whether the child node passed in is indeed a
child of primary or secondary node, and do not call
fwnode_get_next_child_node() for the wrong parent node. Also set the
"child" to NULL after unsuccessful call to fwnode_get_next_child_node()
on primary node to make sure secondary node's children are scanned from
the beginning.

Fixes: 114dbb4fa7c4 ("drivers property: When no children in primary, try secondary")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/property.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 696ba43b8e8a..0ca3c0908b0c 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -815,11 +815,26 @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 	}
 
 	/* Try to find a child in primary fwnode */
-	next = fwnode_get_next_child_node(fwnode, child);
-	if (next)
-		return next;
+	if (!child || fwnode_get_parent(child) == fwnode) {
+		next = fwnode_get_next_child_node(fwnode, child);
+		if (next)
+			return next;
+		/*
+		 * We ran out of children in primary - reset the child
+		 * node to start from the beginning when scanning secondary
+		 * node.
+		 */
+		child = NULL;
+	}
 
 	/* When no more children in primary, continue with secondary */
+
+	if (IS_ERR_OR_NULL(fwnode->secondary) ||
+	    (child && fwnode_get_parent(child) != fwnode->secondary)) {
+		fwnode_handle_put(child);
+		return NULL;
+	}
+
 	return fwnode_get_next_child_node(fwnode->secondary, child);
 }
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
-- 
2.47.0.338.g60cca15819-goog


