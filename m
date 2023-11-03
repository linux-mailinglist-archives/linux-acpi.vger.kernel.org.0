Return-Path: <linux-acpi+bounces-1186-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2D67E069E
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 17:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412BDB20A49
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 16:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D091CA92
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ0S3oq8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C2D156CC
	for <linux-acpi@vger.kernel.org>; Fri,  3 Nov 2023 14:48:35 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6A8134;
	Fri,  3 Nov 2023 07:48:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so1976886b3a.1;
        Fri, 03 Nov 2023 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699022913; x=1699627713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZFSh6qAKf9SWlQfSHeGHU8O0JslBOMZQzZbKbmC68U=;
        b=BJ0S3oq8VOWU3y3EI7p3JG6nQNblAdt0xUZKW+Ly7/3+RK69TTjnG5PeE9ndt7gU18
         YZ/sR4DA4iHmmIS73jjFx9Pmfe/mE6EAv1zvGmN/3TrVc/piO9g/WTc2dgwoxpHbc3i+
         /qQrV6046w2H6NijTqMEzlPboeDvkauEhJj2atlw8ALTb0e8WacOTZfQM/VeCKncXFFv
         LkYf6AUseSi6isYyhO1KrIOkGdrv1gCYCmcoGEUxyjKMO3vZgYTBHzMsJToP/la6WNtG
         oglyLldUrQ27sZ0EbzJs5O4JzjGeMFIza9q1zJkCbsDNIdmVUDQSpNDyTcG/zsopKt+V
         Ul0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699022913; x=1699627713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZFSh6qAKf9SWlQfSHeGHU8O0JslBOMZQzZbKbmC68U=;
        b=LQKqIHXQd5sZafvhsqvNQkg0Q/7rx2GuLZjDb9q+SCitLK1YT9GxakQ2JhHlSGD9oe
         iKHE+T9tbqdHZuj0Lalf4i4IxrpbAPUSCcfy99VGme5SnLFH7CiWIcm8O6hsVjjduCc1
         DrTV4ASXmWi/iK2UT/0XJ8d6MGyX5Pd8JhiQAKCZcSxl3fea/m55mExC7icnB7rcWO3n
         4+/eweVeqv11gZ4DsCVZS9vdppIzqZFgljFRPGK5jAo0gdAPA/zBiJ8Zp3nIrvY4VwvK
         QIfsCsE/Gp9/EvgBB2NJUWtfjN2HqtKb5FluO7t0MGEqn+RWsPZSkFQHzE13xDotXlFT
         uw0g==
X-Gm-Message-State: AOJu0Yz0jg/NQ+IIndJLhMgymYNrG/ytiqZhAqOqnLv2yZv110vrp1zm
	Z7JFYwgkKf4pmRyBl+uCnfg8F3WHZQEJqZR1Eoo=
X-Google-Smtp-Source: AGHT+IEN20eLdsNfDWFxmAryfKfP8R9YTt3YXXSY526nOmEPl2L0PGLa4/woCOH1EAaP9dDJzrJZaw==
X-Received: by 2002:a05:6a21:3e02:b0:180:d33d:9256 with SMTP id bk2-20020a056a213e0200b00180d33d9256mr12948124pzc.58.1699022913590;
        Fri, 03 Nov 2023 07:48:33 -0700 (PDT)
Received: from localhost.localdomain ([112.96.228.118])
        by smtp.gmail.com with ESMTPSA id c10-20020a056a00248a00b006b725b2158bsm1537192pfv.41.2023.11.03.07.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:48:33 -0700 (PDT)
From: "shiqiang.deng" <shiqiang.deng213@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"shiqiang.deng" <shiqiang.deng213@gmail.com>
Subject: [PATCH] driver: acpi: fix the memory leak issue in the cm_write() function.
Date: Fri,  3 Nov 2023 22:48:04 +0800
Message-Id: <20231103144804.5841-1-shiqiang.deng213@gmail.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the cm_write() function, memory is allocated,
and at the end of the function when uncopied_bytes is 0,
the memory is freed. If uncopied_bytes is not equal to 0,
a memory leak occurs.

Signed-off-by: shiqiang.deng <shiqiang.deng213@gmail.com>
---
 drivers/acpi/custom_method.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index d39a9b474..70132d291 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -79,6 +79,7 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
 		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
 	}
 
+	kfree(buf);
 	return count;
 }
 
-- 
2.30.0


