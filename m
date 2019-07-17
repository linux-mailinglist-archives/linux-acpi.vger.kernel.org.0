Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C5E6B50C
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jul 2019 05:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfGQDiX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 23:38:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44394 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfGQDiX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 23:38:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id d79so16344728qke.11
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jul 2019 20:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uHmT8dIDMxkmQnyhyd10BlvmdAMnrqetakFEtunVpYc=;
        b=lQP3Uj3zSjYwN7xJ4sNheKZ2RNLnmpEw9Fq8xckKflLU85L5tAw7kXDaRW8YM89gs0
         iNVDU6aYuxNvV04OF+1Xt97iKQGx37ARpBDOdvrYNRWWAat0InlbZRyHfN3qVj790F/E
         Pxsq7LtYUNVe3ONg4ZlVZ0oHXGKTjZ21GcZyVkTWyr18kQHpbWui8ywK6Y77gMYX/+sz
         iqSW5gA0/MW+u24AQldJMDvGWgmQHrhodKAOhxjb4Jri5wIrFuO/KdXLpC1yIU9R+MXD
         st/Wh55PJwXk2naX3pTaIviY/3fxl+PREDcNIyhI52uG5z8hoTuXemcaCGuMem9+bEmA
         svgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uHmT8dIDMxkmQnyhyd10BlvmdAMnrqetakFEtunVpYc=;
        b=s/OlA6KgUVRCmtMuYHnY+j9P/cANQfxS1lOSdVPB2BK4t6kMETOBgsi0c0qcOwG3Sp
         wTLGRDUuW495n7os+9qpiIY/yuVfxVwczMN/dml+pCxAecxb58/NXrIi3yOQevrxaiH5
         InxylEdQDLF9RUsSucD1aP69l20ORqFpsPpGv1WZIoYd1XAbkn7CkdxwVlF5OuAZr/kh
         HCQHSxBVVYT9SLZiTgr/YMQYJ9+XdVInW5B6g70j1+bCm62sLqmcLAHOijoFM4pQbMys
         XpknuWxeapiGXSx2Ock9Z9eGrW3segiXicDHMEfISQfwBtJhnhL1OuOFBt73sVaZCHF2
         s+XA==
X-Gm-Message-State: APjAAAVapLokooAikzFG6oj93VBBp2SygR7L1tmvKnLUtzspwS2hEbjb
        Yf3xxEqfgwPlJM9/W5t+byhaIw==
X-Google-Smtp-Source: APXvYqwtt1enVHPodfvCLHPiR048UpFB2S0yKmyc8cwJXYs3GJ/TEUB8drkxa9/Hae7qEYQmba4oVw==
X-Received: by 2002:a37:98c3:: with SMTP id a186mr24560759qke.498.1563334702197;
        Tue, 16 Jul 2019 20:38:22 -0700 (PDT)
Received: from ovpn-120-123.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y9sm10200160qki.116.2019.07.16.20.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jul 2019 20:38:21 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     rafael.j.wysocki@intel.com
Cc:     robert.moore@intel.com, erik.schmauss@intel.com, jkim@FreeBSD.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings
Date:   Tue, 16 Jul 2019 23:38:07 -0400
Message-Id: <20190717033807.1207-1-cai@lca.pw>
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
is an undefined behavior. Fix it by doing an integer arithmetic
instead.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/acpi/actypes.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index ad6892a24015..25b4a32da177 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -500,13 +500,13 @@ typedef u64 acpi_integer;
 
 #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
 #define ACPI_CAST_INDIRECT_PTR(t, p)    ((t **) (acpi_uintptr_t) (p))
-#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
+#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (a) + (acpi_size)(b))
 #define ACPI_SUB_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8, (a)) - (acpi_size)(b)))
 #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8, (a)) - ACPI_CAST_PTR (u8, (b))))
 
 /* Pointer/Integer type conversions */
 
-#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0, (acpi_size) (i))
+#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, 0, (acpi_size) (i))
 #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
 #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
-- 
2.20.1 (Apple Git-117)

