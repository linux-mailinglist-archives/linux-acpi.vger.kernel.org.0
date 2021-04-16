Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECE136192E
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Apr 2021 07:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhDPFRr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Apr 2021 01:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbhDPFRq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Apr 2021 01:17:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36270C061756
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 22:17:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id x12so19482214ejc.1
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 22:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a50IcdnhgZEvsPlVOQCYwuiT5Nw59xUv8V7Dt7AB8ec=;
        b=Kx4vU7nL6+WWW9/bFW2xrYUssnTxFwAiQq1M1mij8fBbsBmU1EI/FApEAV0JPYUV3O
         8ScPtb77sQtWZTkMDnjBrSlTgPFL5tvZhO/vutCaZmdB15ZZTxxy+FVzYrwKptWCTWEw
         DcR4nrY76od53LRi4pUFYbgamvg0tLC2ND2gxl7hXBNTiK3nCwe4k4tKwYN0uuVqOhxc
         Gz2fKJF+GZzhbXM1X0dscDh4zzA3tKLtA2gntPcbhgSlw4W+T6JLBTtslniE8tDY15eQ
         HcRZ9wBvhTEstVT3WiEOhzJy2P1WVRu7By1iLebTwM9uwJZwd3i8ou3s/TVs7B0bIFHt
         a0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a50IcdnhgZEvsPlVOQCYwuiT5Nw59xUv8V7Dt7AB8ec=;
        b=GKWNeyGLaQFTxTg809TvbXFn8uZs9ssFGnf4V118xkWxxj4b2NqPMTpO96y3eurf1v
         i1UV2VfO4ykt434Xy0USEdqRo4c+w0GSkWDo7a+6o00THbs8fPBryDY38JFXr3YNY+tp
         WqKLETAlgAAEZd6f7YKvHkInD9tw/1vpe4oVRcXT1PcfCyw7bJyslzztN5oSxjyx17hy
         p74zC3UTsLx+WX6nxWlQXCmTz7pSwlF38ZvvN/C9DDXd2ngCZ7u95A5UaAI1Ky/BrYk4
         gcBaBxwt/cX64x5EZw8e/8bPg3Ahp3MMg5TUWfbtxEayQE3l64ghD8K0P+jdJCWjhWUc
         IqDg==
X-Gm-Message-State: AOAM533YNA8xxTcSEPZkNGwGrys4SgQn6rD7vC91sx+2ootkgRa3lvL4
        HgiJoi6Hj+AheSmgcZl2l4eckOZrCaauQ0WGUz8F5Q==
X-Google-Smtp-Source: ABdhPJzON0Yh7zxJFlJUIXPjsFg1VQTGGptwmZ97+vKn5UxbZ+RlSLTFihiznvOGyYOlfFFz+2jk0MoSZoVebbgAbrs=
X-Received: by 2002:a17:906:8407:: with SMTP id n7mr6532409ejx.264.1618550241023;
 Thu, 15 Apr 2021 22:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210415135901.47131-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210415135901.47131-1-andriy.shevchenko@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Apr 2021 22:17:09 -0700
Message-ID: <CAPcyv4jpkZNsQEvCe_dLoq0DOTrEX36vhkJg+zqEacUkJtvWiQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 15, 2021 at 6:59 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Strictly speaking the comparison between guid_t and raw buffer
> is not correct. Import GUID to variable of guid_t type and then
> compare.

Hmm, what about something like the following instead, because it adds
safety. Any concerns about evaluating x twice in a macro should be
alleviated by the fact that ARRAY_SIZE() will fail the build if (x) is
not an array.

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 8c5dde628405..bac01eec07a6 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -681,7 +681,7 @@ int nfit_spa_type(struct acpi_nfit_system_address *spa)
        int i;

        for (i = 0; i < NFIT_UUID_MAX; i++)
-               if (guid_equal(to_nfit_uuid(i), (guid_t *)&spa->range_guid))
+               if (guid_equal(to_nfit_uuid(i), cast_guid(spa->range_guid)))
                        return i;
        return -1;
 }
diff --git a/include/linux/uuid.h b/include/linux/uuid.h
index 8cdc0d3567cd..cec1dc2ab994 100644
--- a/include/linux/uuid.h
+++ b/include/linux/uuid.h
@@ -33,6 +33,9 @@ typedef struct {
 extern const guid_t guid_null;
 extern const uuid_t uuid_null;

+#define cast_guid(x) ({ BUILD_BUG_ON(ARRAY_SIZE(x) != 16); (guid_t *)&(x); })
+#define cast_uuid(x) ({ BUILD_BUG_ON(ARRAY_SIZE(x) != 16); (uuid_t *)&(x); })
+
 static inline bool guid_equal(const guid_t *u1, const guid_t *u2)
 {
        return memcmp(u1, u2, sizeof(guid_t)) == 0;
