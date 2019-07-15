Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6889569BF0
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2019 22:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbfGOUAf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jul 2019 16:00:35 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34429 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732475AbfGOUAe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jul 2019 16:00:34 -0400
Received: by mail-pf1-f202.google.com with SMTP id i2so10861738pfe.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jul 2019 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ltEwpddVsPtTuDLtrlTH79lQ0wtxe6Ku3Ez2JGRWXl8=;
        b=qUGNTWHd8cZUGEV/MrQ6Rzs0Q6B03B3+qYdukUxrV7I471dM21/tJLvicY0ImNJ5We
         qA9WMrnUGec3rGwDICVFEFPT/u9uaAxn6SQ9vmcvY9BUP2imWeStbHygN1Aro1OCdzo1
         yNJua5MFZK/5Ai8sct0Rj4jAzW8ESYSK5h502yHPVOZ2Ne76w6p43gV39FGdMo/su427
         rOq9MGgHlOc1a4pGIkuVXo/0Gq4fCpC7VI3CTydOCwcj0cvLD7OsiVFHz7J2hDLMOchv
         yqesyv/lbO1tLXprCbEMBrutWPFgm5ZraO09zU8e1dGWTa1FpkM7DzvME5t06lxkfmSh
         eY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ltEwpddVsPtTuDLtrlTH79lQ0wtxe6Ku3Ez2JGRWXl8=;
        b=kkJpoDptNoj2755i2vf1xykQBmigOsAtL2c7R4G0FR8XwwKy+3gUMw/zvScjH6tmos
         AD0n4CaCUqHznSX9CnyciM2IXIqAAL7YVpDoLskc3dudJoZjlv9b3VXLQXi4Aw5wdwor
         Q7yLkgV/qIeAZwvkuMQh63SDWbwqhFGbONC6t2IEHlukDo1YYqde5vNOEKGXg3xU1WBZ
         P8T2zeGBudhj8b9jdiCr7ngVR3mlmWJ3oYEkNQWrBlYFCXgFHK9AlZMYl8cUYo4JuzgV
         63sqQeY/DzI/GdParCpIYOq4tZ+6y7h7yDAQWWe56Fc3c6AJ56CY960UwXrHcBFcHDYL
         nj8g==
X-Gm-Message-State: APjAAAXEqtAE9jGh51HODz1FpfFhwUfcPuzt95Q0Za0VwXLcpSjHQZUO
        GEt1LElzKUKSmxbEFGldNvmRqc8wyJ3dNt72Qp20wg==
X-Google-Smtp-Source: APXvYqzaZwXWU1ppSmCsSN1we8DZ21N1eqAeSFesPXn+z4flX/4Su/naENifMnq+dmC88rLw/yveo0+fpL5mxSXNg+hiMA==
X-Received: by 2002:a63:774c:: with SMTP id s73mr27072981pgc.238.1563220833268;
 Mon, 15 Jul 2019 13:00:33 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:32 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-16-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 15/29] acpi: Ignore acpi_rsdp kernel param when the kernel
 has been locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Josh Boyer <jwboyer@redhat.com>

This option allows userspace to pass the RSDP address to the kernel, which
makes it possible for a user to modify the workings of hardware .  Reject
the option when the kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: Dave Young <dyoung@redhat.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/osl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 9c0edf2fc0dd..06e7cffc4386 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -26,6 +26,7 @@
 #include <linux/list.h>
 #include <linux/jiffies.h>
 #include <linux/semaphore.h>
+#include <linux/security.h>
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
@@ -180,7 +181,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
-	if (acpi_rsdp)
+	if (acpi_rsdp && !security_locked_down(LOCKDOWN_ACPI_TABLES))
 		return acpi_rsdp;
 #endif
 	pa = acpi_arch_get_root_pointer();
-- 
2.22.0.510.g264f2c817a-goog

