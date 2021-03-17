Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE6833E8BF
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Mar 2021 06:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhCQFHi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Mar 2021 01:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCQFHN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Mar 2021 01:07:13 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701F5C06174A;
        Tue, 16 Mar 2021 22:07:13 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g185so37718860qkf.6;
        Tue, 16 Mar 2021 22:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZoar7PUvRHqzJ3ILx7H4A48d5LO3+tDAtgPdf0mrvs=;
        b=LMgKNRGRkE7jbUxNl6P1jhJC99dK4rtR4k7ae6r5AgGjxqL7Gfo4VNvfOgfgnvNZ2r
         SlWNBWw9Lj5AoKI0BvfopCPob6qno7EzTvd5g7chjtM8gI4bNFQSBBkzqjqbdeRjI4CY
         bAIR6tljL1NzYX0HWImBXWMPXzRj13PZMt7XT3DYXzGIHsQJEIXp+w//r9wU5+1waRwf
         HH4WOiXV+SdLPrZeFYwZLwYDsxHsO5IgLZbe8QXUaV+5IEjVEwEDRULNwYYi/5mtglm7
         O2ugDHpFqtBs2NmHXXypkoZMmUx/0INstMm7kyE5v0tqJOvt6Z+n/9S69jXGXJfkzdsZ
         yHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZoar7PUvRHqzJ3ILx7H4A48d5LO3+tDAtgPdf0mrvs=;
        b=t4t8IMVJHQ4dVq6/+YH0O5oUti+mOZVTTGrNrE/Lk+KZ2qUsL6cimKwvJoCss1RVQr
         z+33Tj78giNqQvMH5tjJQcTKTHN+u9uo17FyE3gvFvY+JRsNctzxlQujgWSYWmVQM+9H
         B/NqSYzEpJEyYvrNWJ0YtwpUCeS5NntwNH/splFNY8JywZzXx4N0QMg/BkEOZul0Kx+E
         whgsAaL8igNM+tYH5UIaqhNurM6D5lpoMmvqo8G2CpMsueEkmhqn/Km5re88nT9pKQpD
         EOEP+uaEwD6JD9521SK2FUjzKrj/ZYhjyl81yl7l+WHtCbZOHFuvo+v9hdk3czYWKXcE
         z0Fw==
X-Gm-Message-State: AOAM5321OO8gyWx8QEVA6mmEXPjUelezrpguT5Jv/GF2pEDVugO2/Cdq
        kXkigMuDqOuvQxo/D78CnsEDQvn+/KgbR3Mq
X-Google-Smtp-Source: ABdhPJyMndMzCrXDV6Uu7dSI2gL/MvnkHfTcCkATA/mTX1K13XByi3EEWDAytLryJLhQsThs3RlxXw==
X-Received: by 2002:a37:2749:: with SMTP id n70mr2790915qkn.105.1615957632646;
        Tue, 16 Mar 2021 22:07:12 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.5])
        by smtp.gmail.com with ESMTPSA id j30sm14843697qtv.90.2021.03.16.22.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 22:07:11 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     robert.moore@intel.com, erik.kaneda@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] include: acpi: A typo fix in the file cppc_acpi.h
Date:   Wed, 17 Mar 2021 10:36:41 +0530
Message-Id: <20210317050641.4158096-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


s/folowing/following/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/acpi/cppc_acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index c7fc4524e151..d174721bab33 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -31,7 +31,7 @@
 #define	CMD_READ 0
 #define	CMD_WRITE 1

-/* Each register has the folowing format. */
+/* Each register has the following format. */
 struct cpc_reg {
 	u8 descriptor;
 	u16 length;
--
2.30.2

