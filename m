Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8FE39A878
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhFCRP7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Jun 2021 13:15:59 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:45679 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbhFCROE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jun 2021 13:14:04 -0400
Received: by mail-wr1-f41.google.com with SMTP id z8so6578618wrp.12
        for <linux-acpi@vger.kernel.org>; Thu, 03 Jun 2021 10:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTjd03y8TglinzqMGJIZSRr/9URvtjInPh0BcY13G+A=;
        b=WAxZiPnsjuq//CH74fMuCOVEQhD05UkkjHeFJX9hz56/StO3WRQGBK4xJ/3ZnXbq3C
         R3G2st+gNPrnpdDLMvyHlJLlPO4YaLGQZ9GTCg9W6QscPAlrnHibI+5YFugkxkhFqhBF
         8btBBpQucPeTSMGVWyOIDQN/leA7UJh3J0UMKqA6jCq96PYbMrcqdvm097cpx0W3U3pF
         a1ClxbMcL00gYlUgab6BP37XuIg7XfOJoraZw/8fQTeIyL0QDvpMPsLKP0S7u8N0JXn3
         paR9FaIP/QS4Y7ppjP4ioifWnSX+3pPf03bNRXZWjz/+J9/pZ3+FycqObBLOYSyumYZz
         qmBg==
X-Gm-Message-State: AOAM531+kjlykqqkqu5MauJOqd1tYpf4LxI3FIy4oyGY4EllOxT5YX4b
        IZOKp25J2udzA9Iu6p9xqWQ=
X-Google-Smtp-Source: ABdhPJy+aEMYLnucqADPTV4X7gNRDJeJA/lbF7xl/47a7W08zsp7Nuo1xFWSO1YbuVngOGn4WqkKKQ==
X-Received: by 2002:a05:6000:233:: with SMTP id l19mr65690wrz.34.1622740323389;
        Thu, 03 Jun 2021 10:12:03 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r5sm1790945wmh.18.2021.06.03.10.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 10:12:02 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Lance Ortiz <lance.ortiz@hp.com>,
        Joe Perches <joe@perches.com>, linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: sysfs: Fix a buffer overrun problem with description_show()
Date:   Thu,  3 Jun 2021 17:12:01 +0000
Message-Id: <20210603171201.801071-1-kw@linux.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently, a device description can be obtained using ACPI, if the _STR
method exists for a particular device, and then exposed to the userspace
via a sysfs object as a string value.

If the _STR method is available for a given device then the data
(usually a Unicode string) is read and stored in a buffer (of the
ACPI_TYPE_BUFFER type) with a pointer to said buffer cached in the
struct acpi_device_pnp for later access.

The description_show() function is responsible for exposing the device
description to the userspace via a corresponding sysfs object and
internally calls the utf16s_to_utf8s() function with a pointer to the
buffer that contains the Unicode string so that it can be converted from
UTF16 encoding to UTF8 and thus allowing for the value to be safely
stored and later displayed.

When invoking the utf16s_to_utf8s() function, the description_show()
function also sets a limit of the data that can be saved into a provided
buffer as a result of the character conversion to be a total of
PAGE_SIZE, and upon completion, the utf16s_to_utf8s() function returns
an integer value denoting the number of bytes that have been written
into the provided buffer.

Following the execution of the utf16s_to_utf8s() a newline character
will be added at the end of the resulting buffer so that when the value
is read in the userspace through the sysfs object then it would include
newline making it more accessible when working with the sysfs file
system in the shell, etc.  Normally, this wouldn't be a problem, but if
the function utf16s_to_utf8s() happens to return the number of bytes
written to be precisely PAGE_SIZE, then we would overrun the buffer and
write the newline character outside the allotted space which can have
undefined consequences or result in a failure.

To fix this buffer overrun, ensure that there always is enough space
left for the newline character to be safely appended.

Fixes: d1efe3c324ea ("ACPI: Add new sysfs interface to export device description")
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/acpi/device_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index fa2c1c93072c..a393e0e09381 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -448,7 +448,7 @@ static ssize_t description_show(struct device *dev,
 		(wchar_t *)acpi_dev->pnp.str_obj->buffer.pointer,
 		acpi_dev->pnp.str_obj->buffer.length,
 		UTF16_LITTLE_ENDIAN, buf,
-		PAGE_SIZE);
+		PAGE_SIZE - 1);
 
 	buf[result++] = '\n';
 
-- 
2.31.1

