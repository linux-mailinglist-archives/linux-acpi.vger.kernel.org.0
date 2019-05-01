Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A52210580
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2019 08:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfEAGmW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 May 2019 02:42:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42971 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfEAGmW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 May 2019 02:42:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id w25so8218388pfi.9;
        Tue, 30 Apr 2019 23:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JsEmKkv5N9dvLUrbidM9wSUlAe5nAnboBrCBffm62Oo=;
        b=cwL3PtqtIkyYXoJT8odJ4izToz0VBot3Jm0mH9awQEBSbg1neNxRnFwh69nPWQIIU9
         OdnBFc6HA9635L6JCd7SgGIXGR6FKmL/7sO4BqDh0P/UaoaF+FFA3dRSUBIlS4iOno3Y
         6+Se5F8lLsaEheXKR0qTOXC727tJuyvgt5NUz1UZEL31cbZItaTzFHuUw0UMY6kI1Xi4
         JfsTy9tGNmOKxBAHKrPYZn/aphnf4y0tR8uQIB0cqqCF/R16SWDz7PbPXNvPGRiMIffA
         Cmis7AMgaST3fUN0AzleS+JKzMpseqENAuj9usG0m93dD6ufvhU0A+k4wAOXpejBdiBV
         yEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JsEmKkv5N9dvLUrbidM9wSUlAe5nAnboBrCBffm62Oo=;
        b=dKnOGb1xJAu3P5biostlnsTSgDRaxDzWezSF4NfGq8hspuTPAYOYT9smCTAX/CwdaI
         MgpOpR8roNjVo5Uka/x7kj5g5N6z87Xd1sgzSUE6dwD7PzSVFhpRnpMc1+yOf9131zSx
         2/jFyJS59X18PTwGKGzImPxSUP3Dje3izrUviOnkV9esNneIOVWKMrT+sG+DWiNw9LKH
         3Zv21/Pw5wBgUc4F+db0FTfbhwceU/IGq2sH7gf8JCMkXhhVd0mVUSQ280CcAlId7PPE
         cihwcx9FVd1tWG2DKcWbC3WpRuNNBBNj6/i3alUc/4N/oGZiRGSqEkUnKujwrh+ktk/4
         u17A==
X-Gm-Message-State: APjAAAVnYogATEUKHfLnfTXYFtv/nY/W/vyGmUuudBNI+151asdsOKB1
        n4FrzmcjzGH1h85NtTHsgz7x3CiuTROZmw==
X-Google-Smtp-Source: APXvYqzzg8hCBN/xO+owS00ws0DIIRdvdI1vRuQPYNc5wNzisAaB1v4Ael0P4vq8O2PlbTqQSZrnTw==
X-Received: by 2002:aa7:8384:: with SMTP id u4mr22819697pfm.214.1556692941512;
        Tue, 30 Apr 2019 23:42:21 -0700 (PDT)
Received: from nishad ([106.51.235.3])
        by smtp.gmail.com with ESMTPSA id b144sm15434921pfb.68.2019.04.30.23.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 23:42:20 -0700 (PDT)
Date:   Wed, 1 May 2019 12:12:13 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] acpi/nfit: Use the correct style for SPDX License Identifier
Message-ID: <20190501064209.GA4716@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch corrects the SPDX License Identifier style
in drivers/acpi/nfit/intel.h. For C header files
Documentation/process/license-rules.rst mandates C-like comments
(opposed to C source files where C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/acpi/nfit/intel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/intel.h b/drivers/acpi/nfit/intel.h
index 0aca682ab9d7..8f5461c1dd9d 100644
--- a/drivers/acpi/nfit/intel.h
+++ b/drivers/acpi/nfit/intel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright(c) 2018 Intel Corporation. All rights reserved.
  * Intel specific definitions for NVDIMM Firmware Interface Table - NFIT
-- 
2.17.1

