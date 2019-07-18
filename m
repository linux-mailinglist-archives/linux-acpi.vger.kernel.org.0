Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E851D6D56E
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2019 21:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391456AbfGRTt2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Jul 2019 15:49:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39970 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391417AbfGRTt2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jul 2019 15:49:28 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so28501974qtn.7
        for <linux-acpi@vger.kernel.org>; Thu, 18 Jul 2019 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LqBcHSVnlAllZiCdAIfktp/f17HTD3kFXRWdIGauFW4=;
        b=S/4klFkD+731bYW7+qq/rIq/lS9np6FQhfN5DWdVFYUYB7BxJOsTGOSQyQrZvjtWwO
         awqzevSWhKvdOp40Z2Idd8B6KZwDjCoVdoQNqnTiqSAQX/SK2903jkOO/WVGzN7krgJP
         mWHjt422KGWNS5Kb2YArQyxV/sP2mvtsSrfeFbVq3qSU8Vh4F7lXG0hbopEih6s5jaFs
         N6XJF8xIzqweGVIIv3bPfP1XgrO0luP7rBBFh8OkXdXA/NvqBCFhtn5lYLwMzH9cwOgP
         roQAgl8Z0XViFrnZQW8IjdtdVYUg+Tn7Ra2vvUMJpfa2aIbS01OSnXDDnxSdxoeS/wxG
         41IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LqBcHSVnlAllZiCdAIfktp/f17HTD3kFXRWdIGauFW4=;
        b=FMZTmcs2n7qKb7swGhfSUwcO2jODGHpCL7VKe733bkR4G8qrVBNfvgxYeYjAJoDp7p
         YmrhdloTjun3+yXb/JxYDJv7ZZjdOeTPTHJn5RpUrBhwzcj9dPPgt7dBJtrVftJ41T1L
         lDIPnzdMHlHGWC+6SD5r+fe4gZ1KPrdfPyhWo57kyOGnd855YUfAyKLbw68wwup/gbk0
         1ZxP/16qvetnFBZHE/vswtD3rxhh6RORczJh9NTuW/feEvrFsmocWvWgCaB9JleLrhxT
         jiiwSxT9GOhpp3fEv0sBgUXBE3tDgUaivOB517XbOGW67rjjfXnh+dFrp5Xh2czDBrtC
         a4FA==
X-Gm-Message-State: APjAAAUQQScKTnPuYHY0CEKxE92D6k32mz5+2Zi/OLnBcZ0HnX2ceJH4
        ugz65znGHU/9p3uEBXpqJ0lDng==
X-Google-Smtp-Source: APXvYqxLJQTINuoj/Sa55WUDeFWqt2YGpt7FUzZy5ZTPTJBzY1xxa9K4nQKtYnoZgn77M3jRzjsH7w==
X-Received: by 2002:a0c:ecc9:: with SMTP id o9mr34822037qvq.100.1563479367148;
        Thu, 18 Jul 2019 12:49:27 -0700 (PDT)
Received: from localhost.localdomain (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i62sm13548544qke.52.2019.07.18.12.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jul 2019 12:49:26 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     rafael.j.wysocki@intel.com
Cc:     robert.moore@intel.com, erik.schmauss@intel.com, jkim@FreeBSD.org,
        lenb@kernel.org, ndesaulniers@google.com,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings
Date:   Thu, 18 Jul 2019 15:48:46 -0400
Message-Id: <20190718194846.1880-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Clang generate quite a few of those warnings.

drivers/acpi/scan.c:759:28: warning: arithmetic on a null pointer
treated as a cast from integer to pointer is a GNU extension
[-Wnull-pointer-arithmetic]
		status = acpi_get_handle(ACPI_ROOT_OBJECT,
obj->string.pointer,
                                         ^~~~~~~~~~~~~~~~
./include/acpi/actypes.h:458:56: note: expanded from macro
'ACPI_ROOT_OBJECT'
 #define ACPI_ROOT_OBJECT                ((acpi_handle) ACPI_TO_POINTER
(ACPI_MAX_PTR))
							^~~~~~~~~~~~~~~
./include/acpi/actypes.h:509:41: note: expanded from macro
'ACPI_TO_POINTER'
 #define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0,
(acpi_size) (i))
                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/acpi/actypes.h:503:84: note: expanded from macro
'ACPI_ADD_PTR'
 #define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t,
(ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
                                         ^~~~~~~~~~~~~~~~~
./include/acpi/actypes.h:501:66: note: expanded from macro
'ACPI_CAST_PTR'
 #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
                                                                 ^
This is because pointer arithmetic on a pointer not pointing to an array
is an undefined behavior (C11 6.5.6, constraint 8). Fix it by just
casting the corresponding pointers using ACPI_CAST_PTR() and skip the
arithmetic. Also, fix a checkpatch warning together.

ERROR: Macros with complex values should be enclosed in parentheses
 #45: FILE: include/acpi/actypes.h:509:
+#define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, i)

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Use ACPI_CAST_PTR() in ACPI_TO_POINTER() directly without
    arithmetic.

 include/acpi/actypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index ad6892a24015..163181e2d884 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -506,7 +506,7 @@ typedef u64 acpi_integer;
 
 /* Pointer/Integer type conversions */
 
-#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0, (acpi_size) (i))
+#define ACPI_TO_POINTER(i)              (ACPI_CAST_PTR (void, i))
 #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
 #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
-- 
2.20.1 (Apple Git-117)

