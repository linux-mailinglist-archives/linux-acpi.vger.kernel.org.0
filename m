Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E321D4A93
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2019 01:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfJKXHl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 19:07:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43363 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbfJKXHk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 19:07:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id f21so5109900plj.10;
        Fri, 11 Oct 2019 16:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ny/ZNnxtQMyA+tF6f8WXbljYGPtP5sRnGWPW09z1Kxk=;
        b=VrZ9QQbXijQ3IOaDhrMxVR+ny2PMH4U0Aj8j9LitPUDlhC7BK0A9izSrCZnhiywLXk
         cJQvUhCuV5/m9VRelwK5FL8rjHH35ITpynZ2wMyK3les3DNOHyZdBEMduOw3hPN5wQgv
         VBrwzw3Od1P0pkkd6syrnS+PL2m1nFHD3Ez+scUhU2YNFgihJ/XmZDMJjzVssDobPgKr
         BGkaNCu/HowSlY0gGuNTVDPe1b/MdvoRqeY1JphQCiFWZVDevi4B3k54Lin2hxrD+lao
         FTxue0ePTPpH1mBlXtgCYtZBZiAw9kEl1rcMTbBLyePQqrWUBu2hht8mCK3InIQTPcA1
         buBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ny/ZNnxtQMyA+tF6f8WXbljYGPtP5sRnGWPW09z1Kxk=;
        b=kDskm6y1ooMBBVBnGXIXXLMmOsuiolVc1BUvAFeszZl4iCoXvLpDbUTwILoAYIBRdD
         OM+Vf7ACj3x3jwsfiSbQXN1BqURLaPPYXjzrJ1QbSZmKd3SHFKD79K4rhNhOhd1l+mQI
         IbHcb+wXobXKlP/NO5eJH0olVIgDzi/NnYN0I+wOQyJA/U5exg53IY560kAHdW/R8CRO
         qkF2sN4oRPDEr5OfNpVA3XSiKz/NoLiHWbCauqWabnhVysNS+V3QJP8STS3zTG37vKOL
         fD0CxNA+VYyDPlaBNJHxqtpWI3Chg1NqhNEWSL8GTWD3EW8LMuCrcKVvc3Why3lrwN9L
         OvEQ==
X-Gm-Message-State: APjAAAWSCToipr7mzU2J/Xbgk6voKK5hEMVwxhsoQZoYkJEuzA6vRH0a
        I+Q4OCi5IULXGfiIpdCg+Mc=
X-Google-Smtp-Source: APXvYqzqtNRx6MTlbCZQQrmM3yLChsapiejXSFjXZOQGqYztMT476aNy6Q8zjCNHBA3i/Z2puYW+CQ==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr17417331plp.221.1570835259476;
        Fri, 11 Oct 2019 16:07:39 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w2sm11529251pfn.57.2019.10.11.16.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:07:38 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 11/14] software node: move small properties inline when copying
Date:   Fri, 11 Oct 2019 16:07:18 -0700
Message-Id: <20191011230721.206646-12-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When copying/duplicating set of properties, move smaller properties that
were stored separately directly inside property entry structures. We can
move:

- up to 8 bytes from U8 arrays
- up to 4 words
- up to 2 double words
- one U64 value
- one or 2 strings.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index ae4b24ee2a54..546fc1b20095 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -277,6 +277,16 @@ static int property_entry_copy_data(struct property_entry *dst,
 		dst->value = src->value;
 	}
 
+	if (!dst->is_inline && dst->length <= sizeof(dst->value)) {
+		/* We have an opportunity to move the data inline */
+		const void *tmp = dst->pointer;
+
+		memcpy(&dst->value, tmp, dst->length);
+		dst->is_inline = true;
+
+		kfree(tmp);
+	}
+
 	dst->length = src->length;
 	dst->type = src->type;
 	dst->name = kstrdup(src->name, GFP_KERNEL);
-- 
2.23.0.700.g56cf767bdb-goog

