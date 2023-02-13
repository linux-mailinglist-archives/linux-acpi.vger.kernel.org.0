Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA136695042
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 20:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjBMTD0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 14:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjBMTDO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 14:03:14 -0500
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9FD227B5;
        Mon, 13 Feb 2023 11:02:46 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id cq19so11593362edb.5;
        Mon, 13 Feb 2023 11:02:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZGXFxfnUs6m9Z+D2oTWwA1fTxn8/RRvy1XIBWLK9zHw=;
        b=Co7dYN8mvZupm0blGePDpvBq8+6XAzscNrsl2LRKMffwmtIm4brIhv731vYV3DyVk8
         Zh5J/FNruRl37Ff4oUsIP5nCfakpQOTygBjJdLj+2u0pwY0WJEydwvcFEMA8OX6qzEvh
         eJEovGEnB7CdUW+LcSaJcVWr5cqA6aEckd+s/mXAuPWvvGktXLjbp4SGe8qZbAG15eO/
         3FiexfSqCZKPunqScFNjCgvywecdhvc6g0per6tQwBbp8Ik8Ne6wLd6+2DJg9pQIK/+J
         YfUMII9oQuntUVDODWd3kfA59fnbkbYU24nANNh1qb2OFQP5cagBrIm4B6aE8TwxR/DF
         JF1Q==
X-Gm-Message-State: AO0yUKV0aVABedMutuRfbCXRtFsdBEsnX4xXIM5GfJUMxy3xLD2NexXX
        ByuftFOUXre7E5AjNYYF3aSFmlsdJxrgtOkawSwCOyEElyY=
X-Google-Smtp-Source: AK7set+tggQU4tQ5HsolypNoHGYMLo+Kv2FjxT4YGo2yDXf2btXlkl2GgmA5RKfhmxyp6Xl+EEAHtPxmufqVIM7Y9n8=
X-Received: by 2002:a50:d6c1:0:b0:4ac:c297:5520 with SMTP id
 l1-20020a50d6c1000000b004acc2975520mr2410292edj.6.1676314952815; Mon, 13 Feb
 2023 11:02:32 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 20:02:21 +0100
Message-ID: <CAJZ5v0hmgUdmWKi5Wr+gW1uwj+eQnY5Da6v=WaSCrOjNYJmRvg@mail.gmail.com>
Subject: [Notice] I will be sending pull requests for 6.3-rc1 early
To:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[Sending again from the kernel.org address, sorry for the confusion]

Hi All,

I'll be sending my pull requests for 6.3-rc1 this week, most likely on
Thursday, because I will be traveling during the following few days
and I don't want to delay the integration of the new material
unnecessarily.

This means in particular, that if you have any new material that has
never been posted before, except for fixes, it is not likely to be
considered for 6.3 at this point, so please defer posting it, ideally
until 6.3-rc1 is out.

Thanks!
