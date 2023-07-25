Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5DE76093A
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jul 2023 07:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjGYF3i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jul 2023 01:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGYF3h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jul 2023 01:29:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F6DE59
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jul 2023 22:29:36 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666eec46206so4816627b3a.3
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jul 2023 22:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690262976; x=1690867776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JffUwG5326xuKPzlEojNAz+P0KswaZOylMYMK9oigVI=;
        b=Puoaq6MlxKFy+9BHEaSqKQsnkMf3TZh+ZHQCggaH7fm0vvocL/n5gTMYzOzB4XlBTH
         7eScle8E3XsXUwItonwl3oZfT5EGkPq4deDf2fmEYSZ1qvI3F6TTCAgizR+aHfNJOaOW
         zJy7xZhu4AVdfqBRg+4l6BzpXPaYKYJtbbEiFYjeewtsNHiOK1MgPyG5jIwgGbX3MxDp
         C6BaKpqCxfcrAUv0C+M729VVUam8g3JB+Wcg7A7kH+bCILSsCEshrcvZejys5KFUCNrP
         Qwy9tQqxZSvPLew8hXVjBogQ0R3/PJi+o8Qt5A6h6xe0XbGPX+Gr99ifiL+vtFTCxWJu
         WD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690262976; x=1690867776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JffUwG5326xuKPzlEojNAz+P0KswaZOylMYMK9oigVI=;
        b=l/uHukgelMCAUzJ1t+qhzOBBdvFFBAmG7foRvjrF7VbejaYu3RcBp+LdsLQrKOeJtb
         S63BUic+da5WWlLN5drxtsA5UA4XjyAG/GSyPxV7i4+Ix6yAz34CkHQl9JXC5W0wcHPF
         wiLTQfPaBcaU9/iS0ivhg5VO6dCkM5vE82/HvSUzzickD2Vn+dMswcesbHcUPsQL5oFg
         m9o4zI9u6vabdGQG86HCk/q456qQoB+0MMRgJiAnnq2NoTY/0gK6ztv6vUt5NkAUrqU9
         Gtv3PJ0qlYkGE4gtdsSjBxpXN0qh4nVx/D9OUKWo5/XK783KMyWYFsaEf1SbO4i5tHkh
         SdlQ==
X-Gm-Message-State: ABy/qLY3Leugn2EHEJSBqwcpaq22eRXY/pBxsQW+doJDPT9QvbHNR7jx
        fragpJmIpXOtuk2820YUIOVCv22GK6wSKLyaPX0=
X-Google-Smtp-Source: APBJJlGz3kXzSjbB0E9FvWZVqQFWKgwDsonouogzNgTYWza1EtbTAGTPVNlmvSnX4SRgOibbs/IMIQ==
X-Received: by 2002:a05:6a00:1148:b0:641:3bf8:6514 with SMTP id b8-20020a056a00114800b006413bf86514mr12784986pfm.10.1690262975805;
        Mon, 24 Jul 2023 22:29:35 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.25])
        by smtp.gmail.com with ESMTPSA id r6-20020a62e406000000b00684b64da08bsm8634597pfh.132.2023.07.24.22.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 22:29:35 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] PNP/ACPI: Fix string truncation warning
Date:   Tue, 25 Jul 2023 10:59:25 +0530
Message-Id: <20230725052925.1712680-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

LKP reports below warning when building for RISC-V.

drivers/pnp/pnpacpi/core.c:253:17:
warning: 'strncpy' specified bound 50 equals destination
size [-Wstringop-truncation]

This appears like a valid issue since the destination
string may not be null-terminated. To fix this, append
the NUL explicitly after the strncpy.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307241942.Rff2Nri5-lkp@intel.com/
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/pnp/pnpacpi/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 38928ff7472b..6ab272c84b7b 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -254,6 +254,9 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	else
 		strncpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
 
+	/* Handle possible string truncation */
+	dev->name[sizeof(dev->name) - 1] = '\0';
+
 	if (dev->active)
 		pnpacpi_parse_allocated_resource(dev);
 
-- 
2.39.2

