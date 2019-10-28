Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19483E78A3
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2019 19:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfJ1Sk3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Oct 2019 14:40:29 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:46206 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfJ1Sk3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Oct 2019 14:40:29 -0400
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Oct 2019 14:40:28 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 124EB1CC
        for <linux-acpi@vger.kernel.org>; Mon, 28 Oct 2019 18:31:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PUhOw6jSI3yv for <linux-acpi@vger.kernel.org>;
        Mon, 28 Oct 2019 13:31:25 -0500 (CDT)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id DDD2F13F
        for <linux-acpi@vger.kernel.org>; Mon, 28 Oct 2019 13:31:25 -0500 (CDT)
Received: by mail-yb1-f200.google.com with SMTP id k79so8611394ybf.21
        for <linux-acpi@vger.kernel.org>; Mon, 28 Oct 2019 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tt/VlbO+igImLkepQJBqwL30PnoA8x9FYvcXGMTcDYw=;
        b=oNO8+LLHuVipTV+Rmo33B3yON7KyUc9Xj/Pfe8UT1QPRw01PV6eWl4WHxhg+9SvBZ0
         bqscgIZdzeoQ8IDLZ+0i7jpFyHxw8oin0pPI85H9xjH+ZiugAxI7LYEq4oCB3R/t/8O9
         P9NmBYOztPK9w7xgbg982mHdMuuUtwOufxCq00e94XU8xEBtjVN9q2yvz/aAl4Gsw4n/
         Y21aeTWKjmxUx5zC4y2uCsTo/vzdgf+uRr09xIxVvn0ITT0WEByyWq6IQCwnMA1BAIiQ
         NKebG+Q/ALGkz/AiQWBhLGddIleFsBRSnclNxPt7HJdNi2GyMz4saYe5STIzNQDWdgCE
         PRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tt/VlbO+igImLkepQJBqwL30PnoA8x9FYvcXGMTcDYw=;
        b=inEZgl1jaFK+JbyW9coxarYGHVS2Lu7lXFJ7xOvPJlHHvkNi9YST456waR3SmDsiXO
         FjJLYHXVpEWXIzNHg676v7TqIfcTNg/Vupd29e/ZL2v6bM0iURUuqzfzbKFW30J27LOB
         DdQHUcJXUoWcx40Rm8gmiMFaMFspmmaFK0mrwXD1QDtEnma+2C5rbpyCdgqgy/rVia9O
         zOhtjhNhIP2JR0C2oQJYxmHfS24mjwoTONOXCtTaY91zw/hMrhwoMI+9JERLmJLJJYx/
         AhCEYH/7tzXkNXu1NMPRodXCiSCP5h52Qa8wPhtR9GAtWKf18PQ9S4KPph7BxJtCR3oS
         hrOw==
X-Gm-Message-State: APjAAAVwZLUIfIU+8Oh2HFpfowowc1r/3lk9S24zCMt62fF13QeNUZb/
        245qV73s8Kmnn/dwLw8M+VmCuB9UcRIXijxn4UGcPm/hCkAmLJn0dXGEQlnQ3l5CxEHTc/Z5bPH
        dBLJiDg4qj9pfWXvvfR3N/ZG+9g==
X-Received: by 2002:a81:848b:: with SMTP id u133mr14474839ywf.249.1572287485189;
        Mon, 28 Oct 2019 11:31:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzdS2/es6j9HHrsCkQGYL6DtKHSGg0H+WNsXY+UpzKPg1CIgtE3W/3jPS5Q92CHzMEUvQZuBA==
X-Received: by 2002:a81:848b:: with SMTP id u133mr14474807ywf.249.1572287484704;
        Mon, 28 Oct 2019 11:31:24 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id v198sm7033511ywv.44.2019.10.28.11.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 11:31:24 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] acpi: fix potential race conditions bypassing checks
Date:   Mon, 28 Oct 2019 13:31:14 -0500
Message-Id: <20191028183114.15709-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

"obj" is a local variable. Elements are deep-copied from external
package to obj and security-checked. The original code is
seemingly fine; however, compilers optimize the deep copies into
shallow copies, introducing potential race conditions. For
example, the checks for type and length may be bypassed. The fix
tells compilers to not optimize the deep copy by inserting
"volatile".

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/acpi/processor_throttling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 532a1ae3595a..6f4d86f8a9ce 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -413,7 +413,7 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *ptc = NULL;
-	union acpi_object obj = { 0 };
+	volatile union acpi_object obj = { 0 };
 	struct acpi_processor_throttling *throttling;
 
 	status = acpi_evaluate_object(pr->handle, "_PTC", NULL, &buffer);
-- 
2.17.1

