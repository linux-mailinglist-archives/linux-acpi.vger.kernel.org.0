Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F3219F773
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Apr 2020 16:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgDFOBz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Apr 2020 10:01:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38966 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDFOBz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Apr 2020 10:01:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id m2so633419lfo.6
        for <linux-acpi@vger.kernel.org>; Mon, 06 Apr 2020 07:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prytznet.se; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DF9xo5Ugj+GE9CsnV0I6VxMjelwsstlt8GDPYa0qqY8=;
        b=auJaXc8njXvCh+WriO786pHHfJR77QrQL+kTKaw/bdj2D5WzP8ZSesq/KDDOaHP5Vj
         2ezANI1PIAAVh30SGR4EJLXErZLZ155J6KPPfLhegRhrsHJJ6DbfH6/ErbrOu7cI2M8F
         /FIsseePR9uPnugJuLap+6lI3usT+CtjSH8JMQf07uj3C6eJaewnFTX5b4IFgOt5AEyS
         3wrd2ehns802nYfJTKMEXBcxuL7+1O+qycvwHl1PSOI7efjvao4/z/A1uxwfVZUnVvut
         d/lpZhKo0K67tUkcF614b9Tzwqb6OxZkbpEGukTz3h2ycyoD7FPyB4117yGi4EfJl/UL
         2oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DF9xo5Ugj+GE9CsnV0I6VxMjelwsstlt8GDPYa0qqY8=;
        b=lfq9l9MdFezb+VJbqgQBorp0c/xq3wNveJls4TuF2ISuiNthTPl4rTwXd4ArWA3dkM
         aFCL23DVcyO7jT4pTpuk2FxFQuxxShypaewlTbIW86bpfqfGpM+ryck6IIonpQOMLZzB
         eqAETl8FDjM3ptAueIdoUyevLKXH1gLBM2gjsaIIaPSY6O4zSIJT03SNc21BluxGcrHB
         f8V538NOwbbIQ8oMrxjGSgF8pgY/uBmrjhKYTVrNYwlAXLGC5SfyZik2t/IwCej06tVn
         teR6NDFBkdQkPzX9v1jCFpZmMtNdxym1IeO5txByZhnL29hvgmbBNuzwpnLM6kCl1A/A
         NJkw==
X-Gm-Message-State: AGi0PuZOGp7VKTasClM6LPUTz/DNOiBOHYqGNSczWbvwTzvH3/Ft5vch
        MlNQZqjXg/tkDQ6wtq5MMleTdp/N/cDErg==
X-Google-Smtp-Source: APiQypKcbpfttSH+/SSk0uDjbyFynamGys6QFeyIq1+IK9aTAtxNognuaaoGUQPjuE5WIhKAnhBurA==
X-Received: by 2002:a19:4b90:: with SMTP id y138mr12879584lfa.39.1586181711648;
        Mon, 06 Apr 2020 07:01:51 -0700 (PDT)
Received: from localhost.localdomain ([158.174.82.32])
        by smtp.gmail.com with ESMTPSA id k11sm6516277lfe.44.2020.04.06.07.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:01:51 -0700 (PDT)
From:   Vilhelm Prytz <vilhelm@prytznet.se>
To:     linux-acpi@vger.kernel.org
Cc:     Vilhelm Prytz <vilhelm@prytznet.se>
Subject: [PATCH] Documentation: firmware-guide: ACPI: fix table in namespace.rst
Date:   Mon,  6 Apr 2020 16:01:22 +0200
Message-Id: <20200406140122.21514-1-vilhelm@prytznet.se>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fixed the alignment in the ACPI block diagram (RST table) by adding missing spaces

Signed-off-by: Vilhelm Prytz <vilhelm@prytznet.se>
---
 Documentation/firmware-guide/acpi/namespace.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/namespace.rst b/Documentation/firmware-guide/acpi/namespace.rst
index 3eb763d6656d..6193582a2204 100644
--- a/Documentation/firmware-guide/acpi/namespace.rst
+++ b/Documentation/firmware-guide/acpi/namespace.rst
@@ -56,13 +56,13 @@ are illustrated in the following diagram::
                   +- - - -+                  |  +-------------------| |
                   | Entry | - - - - - - - -+ |  | Definition Blocks | |
                   +- - - -+                | |  +-------------------+ |
-                                          | |  +- - - - - - - - - -+ |
-                                          +-|->|       SSDT        | |
+                                           | |  +- - - - - - - - - -+ |
+                                           +-|->|       SSDT        | |
                                              |  +-------------------+ |
                                              |  | Definition Blocks | |
                                              |  +- - - - - - - - - -+ |
                                              +------------------------+
-                                                         |
+                                                          |
                                              OSPM Loading |
                                                          \|/
                                                    +----------------+
-- 
2.17.1

