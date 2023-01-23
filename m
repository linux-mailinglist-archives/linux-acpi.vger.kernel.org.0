Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4496677EBB
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 16:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjAWPHj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 10:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAWPHi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 10:07:38 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6523828D01
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 07:07:31 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k16so9256925wms.2
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 07:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RNT2OiNXGjJEKXpvdefLUa+i7waiiWYsbDu0gmBtwY=;
        b=Rs+kiDR4I33uxCS0R6tMo2JXPL/IslDBhq0l3AmRRi3u2vq6wQZTg2Gec5j3ql/McN
         5WJIfs2GrV0rzHfUVQsimt3XAQbhJW5jOF8wcpwhjngczy6xJ2WjzAxTSFebO1/raxKV
         9YbZp/G0xMYrWYl3RPvMF4j4QbsnZleHj79iOsmHgw7vZZghxpjJU5g5XxVrt8PXM2Na
         Dbjf1gYIbH7teEo8+hNeUQJbSxqiGDvjsBwgUl7nRjZ4F4kGyBS+DMCvuiCalbVO83oM
         rbvkpe1cXGyFSNAQlVxA7M1us8zAE9h76Pdbell9+b8IawsZZ35XvRzb8XThSuAgn2Pm
         bq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RNT2OiNXGjJEKXpvdefLUa+i7waiiWYsbDu0gmBtwY=;
        b=jmsZlYhE7AnvWN1jqjIl2TVXyOtU6dCyAO3yn3/OhBMy8oeP8lKiTXSHVMOrTjQQXh
         YgL/Wyp/nWOttKZHsncTTY+v5hMMthKxTdQgfW8MXMgPjBJ9jcS5KNDpzm3ThsqalLzI
         yAvubZiCqT7z7YEaXExdMuRvGVUx8MmTNXjf6rVIAsT78s1wXfbwHkIYBgRymZOfF2dG
         CiVQEB02b3Eyz/13e7poeGmFR5kbSlletWZcgYkR90Qb6BV76R/uGB0OWwYN06GxjIbT
         qF3n702PINIy6f3LTe3oFpC2+WB4cWJIkD50l1VDGkignBjYyPQR6bSNT1iBzsb1S/SD
         mN/A==
X-Gm-Message-State: AFqh2kqBR0+6J7ApyQhrVzmux8oQdL4OxsfzNGPt+d0HrQLlzw9oH6OL
        jBwMC0LmfRayFzGrD2A7pxxNT6bIKMWY9w==
X-Google-Smtp-Source: AMrXdXseGMCQqrstaFFjDjAUu2I5MTNxpPosbygExx3/3yWaaKzKF0CVTNLIjVY4Vwa0rpEMvhEHFQ==
X-Received: by 2002:a05:600c:3ca6:b0:3d1:caf1:3f56 with SMTP id bg38-20020a05600c3ca600b003d1caf13f56mr32531609wmb.9.1674486449711;
        Mon, 23 Jan 2023 07:07:29 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b003da286f8332sm11166596wmo.18.2023.01.23.07.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:07:29 -0800 (PST)
Date:   Mon, 23 Jan 2023 18:07:26 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     pierre.gondois@arm.com
Cc:     linux-acpi@vger.kernel.org
Subject: [bug report] arch_topology: Build cacheinfo from primary CPU
Message-ID: <Y86iruJPuwNN7rZw@kili>
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

Hello Pierre Gondois,

The patch 5944ce092b97: "arch_topology: Build cacheinfo from primary
CPU" from Jan 4, 2023, leads to the following Smatch static checker
warning:

drivers/base/cacheinfo.c:440 fetch_cache_info()	error: uninitialized symbol 'levels'.
drivers/base/cacheinfo.c:447 fetch_cache_info() error: uninitialized symbol 'split_levels'.

drivers/base/cacheinfo.c
    424 int fetch_cache_info(unsigned int cpu)
    425 {
    426         struct cpu_cacheinfo *this_cpu_ci;
    427         unsigned int levels, split_levels;
    428         int ret;
    429 
    430         if (acpi_disabled) {
    431                 ret = init_of_cache_level(cpu);
    432                 if (ret < 0)
    433                         return ret;
    434         } else {
    435                 ret = acpi_get_cache_info(cpu, &levels, &split_levels);
    436                 if (ret < 0)
    437                         return ret;

Apparently, I must have CONFIG_ACPI_PPTT disabled.

    438 
    439                 this_cpu_ci = get_cpu_cacheinfo(cpu);
--> 440                 this_cpu_ci->num_levels = levels;
                                                  ^^^^^^
Unititialized.

    441                 /*
    442                  * This assumes that:
    443                  * - there cannot be any split caches (data/instruction)
    444                  *   above a unified cache
    445                  * - data/instruction caches come by pair
    446                  */
    447                 this_cpu_ci->num_leaves = levels + split_levels;
    448         }
    449         if (!cache_leaves(cpu))
    450                 return -ENOENT;
    451 
    452         return allocate_cache_info(cpu);
    453 }

regards,
dan carpenter
