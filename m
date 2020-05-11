Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F271CD291
	for <lists+linux-acpi@lfdr.de>; Mon, 11 May 2020 09:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgEKHbE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 May 2020 03:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgEKHbE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 May 2020 03:31:04 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C93C061A0C
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2020 00:31:03 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w20so8317780ljj.0
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2020 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KTscfAD0JCHvSYiPLgfsrC0xcobt60NP7Gi96XZWkns=;
        b=jMbYO7NZMuJHj26QIlPtOO3zD/WpBvkft7wip3JItO3UmWZi77uBWoVQnOZIczyFAO
         uBAjT+BnTndhcvHaC0452icq5eVHB/JXKvtUKP8lqHGBC5Dm3pOCNiBF3W68QafAk59a
         vnxld9vzXNB8X2BTWeF1ASvN4tmxqPALzT83zSJsVGn0SkTg+NIWbW76PyYdJlAFjMkW
         YL9OT6N3109lci4aQPQKta0SLRPO8nQApC0NGDGAJC7SNx7EToH7K88Q3o/4tCMsxZ6z
         FQQ6gEr+k+T+lbZ47aAjsHntIBUiInypjMJeAN7LjYgvyvSFl1kGNNLXRRuIrWS6k2L/
         ZcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KTscfAD0JCHvSYiPLgfsrC0xcobt60NP7Gi96XZWkns=;
        b=kRJgwGlhK00QYm3vj8TI9PCMzj3PTrh/Osw4K23OjxuC1uS7CBNYNVaG4cdy8a7O8U
         H6tiIV/omwvLxt/wktskCTQSxUmqMd/4smktnSQhXBx6tyyTgxs3NiumqL+sUiHq/PUY
         FcydoIbDK4RBnOMdSg1BO0crvZFQUPnI3XqAsM8urmuA2vLerenj7u24C957Z4WIbTvo
         BH8LvzOpJQ8LOtTzKHSPAVVURItvL1cxZekynv3eownMdf+jx9hQGUgihu8iSROx+6ge
         iP/HxLXCq6B5JvrlrOWdpZmKd/PFa7rvbN6T2rwgOICwIEHmYYJS5KO1Mb6QystP0/uN
         Ctsg==
X-Gm-Message-State: AOAM533R8xUHwDpbLC8UEbvcTsgqE8Tb2s0gD0GcvGJTDBLNNiBQNwZu
        NdWdzOVimpO6Cw+7oF8e4v7TV/p+SOor3TLsq10=
X-Google-Smtp-Source: ABdhPJysp9hwyznNNlHwKsdllhRPl7qqGztrc2nJRx2cAoht6ZT1e01mL/GkvMRmwfC28nMc9BbtItIX680HF6MCO3k=
X-Received: by 2002:a2e:9dcd:: with SMTP id x13mr8819222ljj.120.1589182262411;
 Mon, 11 May 2020 00:31:02 -0700 (PDT)
MIME-Version: 1.0
From:   Aaron Chou <zhoubb.aaron@gmail.com>
Date:   Mon, 11 May 2020 15:30:51 +0800
Message-ID: <CAMpQs4JoyZcHQLahh4w8OaowQ1y3pkTCTYvDn+dkVNOQ4zDpHQ@mail.gmail.com>
Subject: [ARM64 ACPI] different CPU L3 cache size reported by /sys/device/ and dmidecode
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In the system, I can get the L3 cache size from two or more ways.

Firstly, I can get it from the kernel interface, such as the `lscpu` command.
Also, I can cat the file `/sys/devices/system/cpu/cpu3/cache/index3/size`.

The way above can give me the L3 cache size is 32768K.

Now if I use the `dmidecode -t cache` command, I get the L3 cache size
is 24576K.

And the real size of the L3 cache is 24576K.

Why is it? who can explain it to me?

Thanks.
