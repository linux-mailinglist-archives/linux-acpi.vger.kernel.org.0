Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4763BA802
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Jul 2021 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhGCJO7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Jul 2021 05:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhGCJO6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Jul 2021 05:14:58 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E98C061762;
        Sat,  3 Jul 2021 02:12:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id d12so12412401pgd.9;
        Sat, 03 Jul 2021 02:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iVpr38UkV/+6m09Jsw19H3EtCbYsANjk4IEfqrWyxtc=;
        b=QlcQB1Z7D/2jZSlxaKX2/0pCzJ7YN5jQh4OpUiDJmhEdmhZ2CndDZ4wgFuyV/1Hb0B
         XWwx8kBEmeeg3n4GzhoNb2wPlYVXwsz4jvpKHLjtqbp4ekhFasugpnDDmhej6SmtvjTb
         n73LDPV4QoivEAJCUtsnaOydW2R6+feya9F7iB3iG6yt25khdSuUe8x2iSWP+7ENrQ/e
         0x3fBUVl/TbAUZoVfeEoYKWQ/tg5VP8pdf0+OC3v+9xOTVzQAfhYdLQPYGUlgRBtHx2K
         X6AIaAzvacIEDHcJc46yyR581rm8iR+q8uvM+mvXi5PEG7JYzz3Elo4D0Gqnjj6iWEAS
         qTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iVpr38UkV/+6m09Jsw19H3EtCbYsANjk4IEfqrWyxtc=;
        b=itz3V0zJdiyeqjBBSKmDsM6mcBzc90oq/93d0jgSjyVmX5HJ4ukAonArI05GeY782C
         buVlmxj++PCc4PFwqUr/gGN7WGMYw3K9wvFFV45NprN/msTwCATMwLdaxlhnlab5cqEc
         UgcLm8wd+CGzPel3kbQWAVh7BQmpSGZ7IlM7DsUZWG/II+WVwBtg5O1k6ZQfk4kr2jMX
         yocT2SflgaXQdToRCdafnaus7vIipZfu6ofcCZ6PMtCj7z3hfFjMjOeiAWeDcjwzHaxR
         g2sT3x2YrwQF1m/4z3pobc4uGQk43YlIO9u9v/LF9cGv8KXYcRqexHsWs9PRyNUwAfgQ
         QKmA==
X-Gm-Message-State: AOAM533PeqoETMc7tDH1WCzaINFzMzD2OTg7Twu6r/mWS6Yc1g2QGJTc
        zQ7hxLyIlR7LnGBRl+oVwoM=
X-Google-Smtp-Source: ABdhPJxw1tWA8NaMpxpQBIZGHvRJMer4Q61fAqAgxQFIxvBihEnKdbi/Oyo/DgkNCfhZZJMQE4bhYA==
X-Received: by 2002:a62:e50c:0:b029:2f9:b9b1:d44f with SMTP id n12-20020a62e50c0000b02902f9b9b1d44fmr3964640pff.42.1625303543634;
        Sat, 03 Jul 2021 02:12:23 -0700 (PDT)
Received: from ubuntu.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id a5sm1479975pff.143.2021.07.03.02.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 02:12:23 -0700 (PDT)
From:   gushengxian <gushengxian507419@gmail.com>
To:     robert.moore@intel.com, erik.kaneda@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ACPICA: fix if condition
Date:   Sat,  3 Jul 2021 02:12:18 -0700
Message-Id: <20210703091218.650202-1-gushengxian507419@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Fix if condition.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 drivers/acpi/acpica/dswexec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 41ba7773fd10..c4cd61469e1f 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -561,8 +561,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 								op->common.
 								node->object,
 								NULL);
-				if ACPI_FAILURE
-					(status) {
+				if (ACPI_FAILURE(status)) {
 					ACPI_EXCEPTION((AE_INFO, status,
 							"While writing to buffer field"));
 					}
-- 
2.25.1

