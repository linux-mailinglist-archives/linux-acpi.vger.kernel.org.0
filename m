Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9418030DE89
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 16:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhBCPps (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 10:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbhBCPpc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 10:45:32 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1814AC0613D6;
        Wed,  3 Feb 2021 07:44:52 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id u16so135310qvo.9;
        Wed, 03 Feb 2021 07:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=967+scZz5c/VMb8QxhN8JJ1TyJw7YVtgje+ictxSWfE=;
        b=W9cR27rS5wSTdzg8SX5V048E11ydpWYV5g8B/Th/mXLyO6MZ1UWYb5JS21T3E00Zwc
         vqIrQmZcJYa/RiD0Akt2OZerYzoIorG8EzCiKZ1AKeEkiWR2n96lVZmmyCX6QESOgnJE
         8oGj7+/OpBUr2/RMtsVK2HKy8qXp7LnXWCaVkfnh2deNxD1Q0A7h9o/s4CFzd4wYvCKM
         TDm0/J/9zuQs9VKQ5sJ2vEDi/Sx1IWZs55QZ3arnhKXar/5YPBufBZMk4HpyPtytNjWa
         Y0peHCe9jXTKw81c2hrnye4Ho/ghzSWnX7t8GObYSqMFAjf946hBSn0cg5pXS+GNkIT/
         i4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=967+scZz5c/VMb8QxhN8JJ1TyJw7YVtgje+ictxSWfE=;
        b=tYtr7mTV2c2/CoPO7TSP86CwDIzrtQYT523LJYxAbVnNJsMO5m5sukgOGaIUr7yuDP
         e4NhayUTxAzVGLcx+tghwCV4sqvDWolsdnPxG1mNjooNMpXAsTas6Q2DAlr4MoKGyPmT
         /2ekf0lRm5zvEbVMxbJq/geDn9+Oak5qBOwpBofn6vk3VKR8zx3f9fdQuGrKDBR7FI0R
         oKm3g4YcSeN3MUas5Xcg4aMgZLBtgQT4C3S0fZ9x7OmOuTc+PWyCg4ikRceRCzpEUk8V
         KC3o0bNQvXk6CiRnjJUJHOrieIm9JpN9OHo79298L22MCt9NOtw/ut4FSeB/hlplncw0
         w+sA==
X-Gm-Message-State: AOAM531rJmv/3eDnLWqjQzP2NPKpOtRoYYAr9i2EgEPpPekpuQ5SxLEh
        fMYDOFTG3h78gNOPWJ8JVNI=
X-Google-Smtp-Source: ABdhPJxxJXDZSqwfz04ep3TuMOEDWyxgzktejYV0vydgtNU+CgmdshqXj4Yl+ltDhDwRo8wCC23M8Q==
X-Received: by 2002:a05:6214:1103:: with SMTP id e3mr3428912qvs.12.1612367091437;
        Wed, 03 Feb 2021 07:44:51 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.139])
        by smtp.gmail.com with ESMTPSA id g11sm1560043qto.89.2021.02.03.07.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:44:50 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     robert.moore@intel.com, erik.kaneda@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] include: acpi:  Correct spelling in the file acoutput.h is optimzation to optimization
Date:   Wed,  3 Feb 2021 21:14:37 +0530
Message-Id: <20210203154437.15949-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


s/optimzation/optimization/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/acpi/acoutput.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index c5d900c0ecda..1ba212372e79 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -362,7 +362,7 @@
  *
  * A less-safe version of the macros is provided for optional use if the
  * compiler uses excessive CPU stack (for example, this may happen in the
- * debug case if code optimzation is disabled.)
+ * debug case if code optimization is disabled.)
  */

 /* Exit trace helper macro */
--
2.26.2

