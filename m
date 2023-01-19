Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED99673D23
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jan 2023 16:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjASPKF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 10:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjASPKE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 10:10:04 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B527929F;
        Thu, 19 Jan 2023 07:09:59 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g10so1793291wmo.1;
        Thu, 19 Jan 2023 07:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAyoS/l0ukb8nWYy7RZDQQ8DiM08SBtHt1L84CqYlRc=;
        b=TjcnCssRgj+EfEZEr5WV0hvoRM0b5BzKvluALWmMw0IpLVZH4dq15+EwYLmr5tlijq
         l5EmfwjYhZS3Oq6zL6xfjTFis8ERb45I4R/9H13MJHD/gr2T+5n91U4uvLzTEW4pJzix
         JtsvGq6lWCS/hzzAhCBmBTNt11hG9TJUs+5hhEIdyl4pFn5onTF2nRnVlh7VN9rk/7Nz
         JW7e6tNuP8f88EWly/1YpgtBWbppvG8ACYd23xql5Ab5Fq7TO6LYyPplp56Rg1SRl5/Y
         /9rGjHbJOdHvf4+XKeb0648rqOhY+9EXZr55eW5iZtvg3TxMWK69lb5lDIqiW+yjKB+X
         V8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAyoS/l0ukb8nWYy7RZDQQ8DiM08SBtHt1L84CqYlRc=;
        b=QQOixVYP0Y6tpw9tNd/RoB21mCzwZypJWtcRPn/1KJ04qAxR7G353IJR4q+sNE79FY
         DVIXwNYEOITutwLbxPXRFt8uu++QSEif614/jllvojhA5vunRA1W8HPp489lmZdhU4E0
         WjHz+gVidFhfPENSq625JDOfBMg0VmgKgpJ7NKmzoww7RPc2LQTvQp/wjJXUz69lyHWX
         V/qFbsao0vE9Zm+Uvom+nfcp4vesKEs3tuQqYaaEj0LL5IKaodOCUBvFg+pOwWyPJnul
         HnGp5r+hTftQmchbupZfjZlbDGiTRuzMaRZ4ZNH8z8ONhBeCuaSa/0MXtrKkGuEj1JHl
         2DVQ==
X-Gm-Message-State: AFqh2kqdFBgsq3CiRZEjEi/n21vKCi/G1w+Z+qPPmQ8uvg04+D0TzqAr
        3GgdsMCXwevHNxwXE8qPpjA=
X-Google-Smtp-Source: AMrXdXsp0JKlPpH8FShIRP0LvtpChF3J/qGgB+aSM3orEEx/A6n7DvN+mte7plsHtFaCM4K21rzXog==
X-Received: by 2002:a05:600c:3549:b0:3da:acb1:2f09 with SMTP id i9-20020a05600c354900b003daacb12f09mr6758658wmq.19.1674140998132;
        Thu, 19 Jan 2023 07:09:58 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d6d49000000b002bc8130cca7sm25982573wri.23.2023.01.19.07.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 07:09:57 -0800 (PST)
Date:   Thu, 19 Jan 2023 18:09:54 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
        linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        cip-dev <cip-dev@lists.cip-project.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH v2] ACPI: NFIT: prevent underflow in acpi_nfit_ctl()
Message-ID: <Y8ldQn1v4r5i5WLX@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The concern here would be that "family" is negative and we pass a
negative value to test_bit() resulting in an out of bounds read
and potentially a crash.

This patch is based on static analysis and not on testing.

Fixes: 9a7e3d7f0568 ("ACPI: NFIT: Fix input validation of bus-family")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
v2: add missing close parens ) in subject

 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index f1cc5ec6a3b6..da0739f04c98 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -446,10 +446,10 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	const char *cmd_name, *dimm_name;
 	unsigned long cmd_mask, dsm_mask;
 	u32 offset, fw_status = 0;
+	unsigned int family = 0;
 	acpi_handle handle;
 	const guid_t *guid;
 	int func, rc, i;
-	int family = 0;
 
 	if (cmd_rc)
 		*cmd_rc = -EINVAL;
-- 
2.35.1
