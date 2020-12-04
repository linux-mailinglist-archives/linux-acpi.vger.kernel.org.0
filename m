Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314B82CE471
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Dec 2020 01:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgLDA2k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Dec 2020 19:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgLDA2j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2020 19:28:39 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFA5C061A4F;
        Thu,  3 Dec 2020 16:27:59 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t4so3644177wrr.12;
        Thu, 03 Dec 2020 16:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bfb5d3+2S9JH8wBxkFfQemxxT3PfbV/hkWGgdqWK+2k=;
        b=avTuOm+YMx8bgyxwZ+cDWgHUigVl3SimWdYJhL2edrAt1+SOGbP8ALx13VR+OBxfe4
         H3RYi7bUkNDl9vxabn83Fzwred58Bryup17lIxE3XrUNeWBu4a6iUZupQa8/lZF9nN3+
         8b1Fk1jepOe8r0CdFcLtC31qrRPHfIJZLf+pV9tlHBWnR/sbfZe08pm11QeSRfJxhBL1
         YT281yK9RyYBeHO/tcx+GeFD8eLY03FSHUPPuKGMrDR1mobaNJcCihgFPgQ6YfFhLV+L
         zkg8G6SP/s2S4NVds7QZySs5/ulA4M19WIszSonmCDhxtD924kCCoeM5m01CIlsBeui+
         6CVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bfb5d3+2S9JH8wBxkFfQemxxT3PfbV/hkWGgdqWK+2k=;
        b=uPEgEynkkwoONOjxP0CCAVGP1bBRqOiWxMqNd9oKkZY19wv4RLhWK3gH1TWEFWR4/V
         3sPVooZzSq4Jaycuq8GtbOXJO7aNm2G2Tw34jYjqHYlV7vCh55w8r4A/aWu9Y0IJnepl
         56MgYU6ZJoQUUOwVwq1Js2hDZjSmW+AXPGB/m6qMVbx8aUFkaJyrwxhGvxstwlyPkxsJ
         l3cawDfxcqFvvSYv1Yu/HyhpC+yXX897ivQCt0TrKgUhd9PgV2SiDbOMhrHOWP9GsxOS
         cGukE9fgDqAhZOyQ39BDHqJNHsWTNuTRckUmaBSn8lJ0w4q3MAnI2WEG6cTTZp5hNP8a
         bCqg==
X-Gm-Message-State: AOAM5323c3Cw0CjAdnAKrhckHP/IOv4/80BrZ4O9hwx/fQ8/l+zGvQW7
        V0jN9ziXQjmJ4Ct0NPNB16H9apfX66MoEZL3
X-Google-Smtp-Source: ABdhPJx7gqirS2esVFVzQOwV0VSKtaITvwJ4LvJdLuV/7haF/fjcxT0A3x0mEmTshu4jFrZKYoZPgg==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr1801914wru.173.1607041677842;
        Thu, 03 Dec 2020 16:27:57 -0800 (PST)
Received: from valhalla.home ([2.31.225.57])
        by smtp.gmail.com with ESMTPSA id d17sm1306815wro.62.2020.12.03.16.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 16:27:57 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, mika.westerberg@linux.intel.com
Subject: [PATCH] acpi: resource: Use AE_ABORT_METHOD to terminate acpi_dev_get_resources()
Date:   Fri,  4 Dec 2020 00:27:40 +0000
Message-Id: <20201204002740.300109-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Switching this function to AE_CTRL_TERMINATE broke the documented
behaviour of acpi_dev_get_resources() - AE_CTRL_TERMINATE does not, in
fact, terminate the resource walk because acpi_walk_resource_buffer()
ignores it (specifically converting it to AE_OK), referring to that
value as "an OK termination by the user function". This means that
acpi_dev_get_resources() does not abort processing when the preproc
function returns a negative value.

Revert to AE_ABORT_METHOD

Fixes: 8a66790b7850 ("ACPI / resources: Use AE_CTRL_TERMINATE to terminate resources walks")
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 drivers/acpi/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index ad04824ca3ba..f2f5f1dc7c61 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -541,7 +541,7 @@ static acpi_status acpi_dev_process_resource(struct acpi_resource *ares,
 		ret = c->preproc(ares, c->preproc_data);
 		if (ret < 0) {
 			c->error = ret;
-			return AE_CTRL_TERMINATE;
+			return AE_ABORT_METHOD;
 		} else if (ret > 0) {
 			return AE_OK;
 		}
-- 
2.25.1

