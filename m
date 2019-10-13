Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89438D53E2
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Oct 2019 05:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfJMDHj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 12 Oct 2019 23:07:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34295 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfJMDHj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Oct 2019 23:07:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id 3so20105414qta.1;
        Sat, 12 Oct 2019 20:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uv/SCI2+r8QKkTtlVTmJGQdWZWhzTT2rXVrB6kUXTKk=;
        b=fI92N1K0H2qHC8A2gXN4PcmjEr8BpLqZJfcS0KTZfn5v9509s8VAgBnXeqWx/KBr1y
         V7eEEr0EcX4kf68NfKOzgODe0mxzDNquMsemQhVr44c+97fDEvLG6JZNmYxARpsS3/Wk
         phd56vWAi/a3VzSb1NtJaz5LNhDQN76NG1EFVZjCpjwyjhW6E3IabjwJmQAyUm+LwAJa
         qocxKkMEm36kihGuXvOlaswzci+Fxetp/QIfmMcEUfmCq1uNm3tOHMIf+GG8dts94/vl
         YhUGHPNhHIA71dr/Dx3jY6YEKyNIyVxgUvnVvXTFL6XCJh0fY1O/m9ZjUliofV4zQajO
         Cjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uv/SCI2+r8QKkTtlVTmJGQdWZWhzTT2rXVrB6kUXTKk=;
        b=LfvvvSyrO6Ig40tBTYRPrUXjBxTfJP5wDMQe1kwSUb2lLtNG9WpHXLepjDO1h+kcB2
         0YJfsAKPJauVHldyUD1aDbcDqXH5GoWVrS0XWDKn3ynQkgVp7pw0D2O6dnCQuvKSFKj7
         DiTdbGb/aoEpysUquzmwe5sl14AA5KFL4khs1HKOnzm99kSVipLONxXPKHc17n9u6y0k
         K5UDSTfr9JlBWLNwyjC/5fnD7K+3PuS21jwlGMOmfHUWx9oYnM0n3CYBhXZQZbScCJhB
         57MgOteC/kNHO7SaWenIHc7QaoTxzgM3m6EO7zoMMCHBu5R6pnNYRa4P9qnKFUJzB2Gk
         l4JA==
X-Gm-Message-State: APjAAAVc0oBFA+a5Rqq77EgVkou1KEQlbAKv9hCye7ShzilXRuIgzBbS
        iitfaoERhsQD5cyZ5afRiS34hnMpQTkG
X-Google-Smtp-Source: APXvYqxxX+J7KKtMAp3P3d8+mGxLzqe09PAY6vHaY06Ks1i3XoKh8J41jsBmUTeYVCXxvecFcaZeBw==
X-Received: by 2002:ac8:2dcc:: with SMTP id q12mr21143754qta.302.1570936058241;
        Sat, 12 Oct 2019 20:07:38 -0700 (PDT)
Received: from localhost.localdomain (c-24-126-9-89.hsd1.wv.comcast.net. [24.126.9.89])
        by smtp.gmail.com with ESMTPSA id z8sm5766371qkf.37.2019.10.12.20.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 20:07:37 -0700 (PDT)
From:   James Pack <jpack61108@gmail.com>
To:     rjw@rjwysocki.net
Cc:     trivial@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Pack <jpack61108@gmail.com>
Subject: [PATCH] ACPI Documentation: Minor Spelling Fix
Date:   Sat, 12 Oct 2019 23:07:23 -0400
Message-Id: <20191013030723.31391-1-jpack61108@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Very minor spelling fix in ACPI documentation

Signed-off-by: James Pack <jpack61108@gmail.com>
---
 Documentation/firmware-guide/acpi/namespace.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/namespace.rst b/Documentation/firmware-guide/acpi/namespace.rst
index 835521baeb89..3eb763d6656d 100644
--- a/Documentation/firmware-guide/acpi/namespace.rst
+++ b/Documentation/firmware-guide/acpi/namespace.rst
@@ -261,7 +261,7 @@ Description Tables contain information used for the creation of the
 struct acpi_device objects represented by the given row (xSDT means DSDT
 or SSDT).
 
-The forth column of the above table indicates the 'bus_id' generation
+The fourth column of the above table indicates the 'bus_id' generation
 rule of the struct acpi_device object:
 
    _HID:
-- 
2.20.1

