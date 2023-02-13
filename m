Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6435D695020
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 19:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjBMS7m (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 13:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjBMS7k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 13:59:40 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5701211D0;
        Mon, 13 Feb 2023 10:59:14 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lf10so2442677ejc.5;
        Mon, 13 Feb 2023 10:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OR8Z9cLKxBW1b1gksvWzIK8A0mOtCkd+I+gKj+kdmKw=;
        b=Sa0UqoXLZkO1/9GN8q6pRyMMhjOW8lI16X9t+7pOQtCjMuDvf/gvic0Qw3JvLrmrLv
         UXDHTA7L7qPfBml9eA9jG14vcOJltkuzWGtVU22cYF2tgK8tmUXGI5D0/kU9Z8vwXm2z
         kV4YsiFdaSNQ9GJTeZsjQBm4/qru+HY/22WCh56Iyn1WGt47kF/32lJeNyBhqYl8fcjY
         RFF97FOrVF7NEdvFv2EzgtflbtQjWis1wUdoLfl72LmZKaOZiAvwS3YHDpOSsch0mGlo
         gh2cJne9F/1wlSCWWsrH7+179r2dF4NzrdeMv5alY5uy4YJNRqWEnqRYge0jyRo1vge7
         4RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OR8Z9cLKxBW1b1gksvWzIK8A0mOtCkd+I+gKj+kdmKw=;
        b=v7nKe3DNL51XIdMRJHff/Wqf0vtQHOtpxP8584HyXPgJnbTPYNxUI9eU5Hc1pHbWM+
         oKNqJH5PpyfZCcPF+zu3VRmJsL6mAKarqI1Eq9JCNTCxpP3feTQnswwfunZMx91PrA8X
         N8Wxqr+irw9ukS7VWWuI89s08VYr+5KvbrTyeRy9rMLNhIx7ikgl99/wFxBNfjwYDcgZ
         F+5g5Eclh7x3/1P13dEygJ/ixpZ9IahTQYEU7RWkFjBR2yCEUg8+5E3B5KfqQq+dc39Z
         bpUtFJyU7CyBPYuU/vBR7Xpm1FE+BEym9xosPpdHiGZAtWpaqlbnL1uYRjoOxw2tn1D2
         9SHg==
X-Gm-Message-State: AO0yUKU/UX2XcwpTA+pmLy6cntGvzUg3rIL/YGrm1ehsKTqkB8V3pytw
        JVB9aM22gd0zMLgQm6zgTMVtvADgxO4lE6UAPxsvr+sT
X-Google-Smtp-Source: AK7set+Z/wQPsh3ircG0B6rdt2n7gPpSWO4BZaCLaY2X9+80cLXuOQ74wbLQw4aS9fCE7b7EgGQtanQVUuyD1jifLao=
X-Received: by 2002:a17:906:2813:b0:883:b1d3:ae67 with SMTP id
 r19-20020a170906281300b00883b1d3ae67mr5061372ejc.5.1676314750610; Mon, 13 Feb
 2023 10:59:10 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Date:   Mon, 13 Feb 2023 19:58:59 +0100
Message-ID: <CAJZ5v0heGJ3B5+Uf2u+=upkhskXcEkPQvO-7v_JH6JD_rJxRYw@mail.gmail.com>
Subject: [Notice] I will be sending pull requests for 6.3-rc1 early
To:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

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
