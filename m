Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5377DE23A8
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 22:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406288AbfJWUDC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 16:03:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38579 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405905AbfJWUC6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 16:02:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so12760182pgt.5;
        Wed, 23 Oct 2019 13:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qkhxgO5jibnlb7gKc/t5p3Tr0Xmy8V6wC17jmmeP1b0=;
        b=VDyBfirf7hTX/0XDXtmE+/2SNFRPPiCNMhvOaqZ9MgSmlbI5q39XmbT1oHQZTdd2cT
         7KigdNosMVhwjJ3M4bVKZboxHtEU/wOY8VYGZoO6xNkT94Yj6kn/4VqGqNQKEjFlX+bt
         xI5aPv2t/p0wFu0hEd01w95myRHzbReYji3iknCj8WkJKJ1EX46fQXUtlFveQULjZWFt
         7636pZlfaU1sImvN7KkfBdoCHoO5NTra/NeQmeVLtET9DwwaE01MYA4ALGRXsGS0o+Qj
         haVu96qCtMuPo9+rQoOzgfPkZVxC0bAEU1fD+FURS47wb56DQYZRPgdBzRXHpjL6lrIK
         PAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qkhxgO5jibnlb7gKc/t5p3Tr0Xmy8V6wC17jmmeP1b0=;
        b=K+97ebz08kbPyJXA5fFHvdkmu8EXpcwtxMs2dqEgOLlOYJ+mlJqWA5LxWt8OH+w4hR
         pAikzrcCUOoMAnjY8ot+lAX+Xr5KJw4Hye2RNBYpNfq8vNnk8DAwvMPygTwjGokLKZMe
         J/hsgsJfCZCQPkT4X5r3G8KVj7UsQ1H8vSc5zjYPNQt10keUcejNBJJpu5HGgFvcBFAQ
         +Irn2WHwRK3CqwJQh6Zq5cz/3k0kHnCF9MhxmG29usHrwLhZcpl3W+IKjOh/JHnFFB4G
         E2I41y1QKXCs56zYDbemEK6bCFK5wA6dvf52FZx68vMkDGaUFKe7qOp0Pq+zo2mE9QbW
         VGXQ==
X-Gm-Message-State: APjAAAXtFnE0cKYma6rgs4AdWO4WCzgjxLc1/VHzeZnIsKTqhv9mrnnz
        XIVf4r/heoyy4N5u+XbWiEc=
X-Google-Smtp-Source: APXvYqxHlIN2pAAFMCYe9L8Yy42MavOeVtrhlKodtX0YyZgHgWr5v5zWh+4rJ2KwNRnpKQYn540vhQ==
X-Received: by 2002:a62:61c4:: with SMTP id v187mr12953291pfb.23.1571860976940;
        Wed, 23 Oct 2019 13:02:56 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm10593598pfy.43.2019.10.23.13.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:02:56 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 11/15] software node: move small properties inline when copying
Date:   Wed, 23 Oct 2019 13:02:29 -0700
Message-Id: <20191023200233.86616-12-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
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
index 18a30fb3cc58..49e1108aa4b7 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -280,6 +280,16 @@ static int property_entry_copy_data(struct property_entry *dst,
 	if (!dst->name)
 		goto out_free_data;
 
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
 	return 0;
 
 out_free_data:
-- 
2.23.0.866.gb869b98d4c-goog

