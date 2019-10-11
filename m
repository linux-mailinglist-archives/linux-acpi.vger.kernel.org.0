Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7400D4AB0
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2019 01:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfJKXH1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 19:07:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34351 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfJKXH1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 19:07:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id k7so5132192pll.1;
        Fri, 11 Oct 2019 16:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kC26ffR+trBknrfzrjK9Qw6ONsmCGAuEKQl7xYThEA=;
        b=kHiz8ZzAOitA6k2P2pLSfizpmXcvpgQR36t1m18tG+e4PWi1yiaolf1pUIuVjAUpTN
         aeFoP7zdeKOVs8btF7tYPoG3mrvsEWnzQA6gefaJznd5pn4IFkQT8di2dQrZzfeAAf9f
         hYLaSI3WhqiMeisVhNPtJqZSRgdDhXDsE49qqii2GHwHz+2fYzV1pPiqGgg+gNQpd3AM
         wdD1dejcilNH5FRK7VSuU6TTDM6pmdtO9THkMEYYrHgU4AcbeHdRL3uSu9UTIhM3UGzh
         Er4mQTIv0sFfqrKkTyl3KOeJB8rf4DBxK52FY5WFWeEdGVmPbODbtu8nU+M/WpJTbyrm
         N0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kC26ffR+trBknrfzrjK9Qw6ONsmCGAuEKQl7xYThEA=;
        b=hhmd3WeWaG+r0cydxJP+ALSQ8bGWUjClgi/SnbrFQBr4RXiGtyxnff11yMc2allwqQ
         kQjtLkzvqMrqbKwoKaiPxbvK2O1dLxBan+zPgTkrwCPUf+ORh5sOYqWwauaqs3sgGyBb
         2Fa5eCLqw/CoUJMBj4sQCLyfp/+1lj/t4DyXGpg/YSpRRPbQWpq+WycwYfZlkjHt0eDB
         MbCwFD4gmJxKHCNYzrtuvGgW1WOxcap9BK70bQB+VijJe0Ey8SoJfODLDUCSvm1+xxQ7
         MI+3qWLg+CF5hkSpqwZiJm0sdpUnjhqwmUmeg6YLWUR0npSotmZLGfpBmyb47QCK+HsC
         yhOA==
X-Gm-Message-State: APjAAAWARrhyb3Y3agZHZGLY0R84711rFg0iHKsYMvouU9hpP0GUKM7c
        gNYd5qFgYNkYkgtreMbfhNw=
X-Google-Smtp-Source: APXvYqwJyc3CfgPlSum7I4t2L2RB4PO1jhsjwNn7JanaFSEtmoK7glcsV8KGSwXixMezhYZCh0qdVg==
X-Received: by 2002:a17:902:a610:: with SMTP id u16mr17682886plq.200.1570835246462;
        Fri, 11 Oct 2019 16:07:26 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w2sm11529251pfn.57.2019.10.11.16.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:07:25 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 01/14] software node: remove DEV_PROP_MAX
Date:   Fri, 11 Oct 2019 16:07:08 -0700
Message-Id: <20191011230721.206646-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This definition is not used anywhere, let's remove it.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/property.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 9b3d4ca3a73a..44c1704f7163 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -22,7 +22,6 @@ enum dev_prop_type {
 	DEV_PROP_U32,
 	DEV_PROP_U64,
 	DEV_PROP_STRING,
-	DEV_PROP_MAX,
 };
 
 enum dev_dma_attr {
-- 
2.23.0.700.g56cf767bdb-goog

