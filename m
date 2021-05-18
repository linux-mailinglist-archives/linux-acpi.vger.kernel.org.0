Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9423882B1
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 00:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352731AbhERWWC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 May 2021 18:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352729AbhERWWB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 May 2021 18:22:01 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB90C06175F
        for <linux-acpi@vger.kernel.org>; Tue, 18 May 2021 15:20:43 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso10002942otb.13
        for <linux-acpi@vger.kernel.org>; Tue, 18 May 2021 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jODzuDp4sTac2DHZrxz2pkx069Ko9bvNGW4qcLZX5ak=;
        b=ZPDXs04y3cwopzpzq9a6TrwilIRv8qgiq65vbhA+foD90s8vO0isbq41OOxIqzwuGg
         0TmWM50+IaGZfCmIcZ0G+RM4YZaAGV4+ZhD4OOXKC1MKcX7h5hfmBbQuPE+4pfdLx6yo
         zqzgrKa/kmdu/sWtlZ6+zBoaWSg0fEyqtsjPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jODzuDp4sTac2DHZrxz2pkx069Ko9bvNGW4qcLZX5ak=;
        b=Asf0nIHLDcFyYx3bqnB99sAvWcnw2QH69hhdNaUqiyyoBSZ4yBOUBi6sSx+ZDICOAo
         rdd6x6kXdjCH2FOHV0+Zm5BFz80G5gQid1/HM/nI052Gyo0O3neu5hdGdU9b98lPlAC9
         j+5nBKKgwtN3mbtrzTHaGDqzgLMR0Ro0j5teE5XozOh94KrcZiNDF/fCtdnT5qX1DBSx
         B6NGFNajJUwlk8qYMUIT1clJWbfhWgD+wECx/nnUtggy28984pDabveBgXVUZKQB7o5O
         XJsTYNarfXF+GDVeFCHyTxb7f2SFt1PpYdqRzsiIX3gPr4maUiUyRT8KtT6DS0DRwNmk
         nxrg==
X-Gm-Message-State: AOAM532OD7Iy1LGCvWpYs4ScNRkHezN3ir+zicb2RKphtbRQ90Ts5DYf
        9H3vOd77hvzSslyyYN+0z8j6f8EpqGYSCA==
X-Google-Smtp-Source: ABdhPJz43mxfhCri+Uh73Va5/8oWpZ8EBkxxvRBCwU4cap3f22XiWEU0XDX0VwiU6Sfn6CFSY7I4og==
X-Received: by 2002:a9d:1b24:: with SMTP id l33mr6090155otl.309.1621376442700;
        Tue, 18 May 2021 15:20:42 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id e22sm4084696otl.74.2021.05.18.15.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 15:20:42 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org
Cc:     Raul E Rangel <rrangel@chromium.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Robert Moore <robert.moore@intel.com>, devel@acpica.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: Increase ACPI_MAX_HANDLES
Date:   Tue, 18 May 2021 16:20:39 -0600
Message-Id: <20210518162034.1.I7db737fa0a8e7da8247a1a614633bc0fc6455a00@changeid>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_handle_list is used to store the references returned by
ThermalZone._PSL. With processors supporting Hyper-threading and more
cores, the previous limit is not enough for common cases. If _PSL
returns more than the limit, the passive thermal threshold fails to
initialize.

This change increase the limit to 32, so we can support at least 16 core
CPUs with Hyper-threads.

I acknowledge that this change is just kicking the can down the road.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 include/acpi/acpi_bus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 37dac195adbb..fdce8e7c4718 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -13,7 +13,7 @@
 #include <linux/property.h>
 
 /* TBD: Make dynamic */
-#define ACPI_MAX_HANDLES	10
+#define ACPI_MAX_HANDLES	32
 struct acpi_handle_list {
 	u32 count;
 	acpi_handle handles[ACPI_MAX_HANDLES];
-- 
2.31.1.751.gd2f1c929bd-goog

