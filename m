Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461DA76766D
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jul 2023 21:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjG1Tgn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jul 2023 15:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjG1Tgm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Jul 2023 15:36:42 -0400
Received: from abi149hd126.arn1.oracleemaildelivery.com (abi149hd126.arn1.oracleemaildelivery.com [129.149.84.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1189130D3
        for <linux-acpi@vger.kernel.org>; Fri, 28 Jul 2023 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=WvVvdhVMzarAPgKSDz+57haMY2V5DGCr8AR4QPbT3O8=;
 b=rukcSh68Gpps9upIqEQ+y8jUK2Frk5bbMPYpsWWB6hVV0+QszLKHOFxoNru4LcpPgXpG6Y3XB1JM
   Ur0J7r4wi8zMZpgbtaM+7r9DFNR3hG9xwp0SikiW99DfJo+SNHyn+nWyUulY6uc4NA05ndeUYw8Q
   qGMty3/Z0GdDxhoTxBAGS4RkWY9l7PifP6iKJ/fXNryUYefS/7x9IX/l9RggUkFmjDUBiNLtdJH0
   WKib2lM0kKZiJrtrM44G92f2/wGGi4dvZCYW7xr1khj4Lb2kZfUXqfwn6wLzwPsw9A7msLuuPCwF
   5fDQcAb10oRow7xHK01yT0bDs4t0Lg13GyICCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=WvVvdhVMzarAPgKSDz+57haMY2V5DGCr8AR4QPbT3O8=;
 b=SYtVKkXGqHHS59unG/tWwhvB675j1bHk3qDavnHzZYqt7klKnHk93h6UPZWnqW/NadhHew0jsV0G
   59deC+Z7HvlIq7t7BkjTuNR773lp9wAQFR3m7E6ZGVOS33MhOwe2Syj8GrWip4omm42y69VFZy+K
   C2FRI1/zDc6vqCKS/ZE1ywI2CGjOzcRYB8NAgTBztBmAGBj99M4wCw8OBiJKADqaXm8l7ns9m+lj
   0bGexf3o/OyCVxCaJyLIu3oRxfVm5YPUh0tsLafqDFmWJcIIk3s4//B4vnw7pEdBw/4c59PYNf/f
   KDVY0xXMYfVZTiVtFrbDb0X2wix6fVn7P3BpiA==
Received: by omta-ad1-fd3-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230629 64bit (built Jun 29
 2023))
 with ESMTPS id <0RYI0063EUH39Y10@omta-ad1-fd3-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-acpi@vger.kernel.org; Fri, 28 Jul 2023 19:36:39 +0000 (GMT)
Message-id: <a1b7de54-53ec-0899-eaf6-e1c3d3d15f56@augustwikerfors.se>
Date:   Fri, 28 Jul 2023 21:36:36 +0200
MIME-version: 1.0
Subject: Re: [PATCH v2] ACPI: resource: Add a quirk for Lenovo Yoga 7 14ARB7
Content-language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, regressions@lists.linux.dev
References: <20230728191408.18141-1-mario.limonciello@amd.com>
From:   August Wikerfors <git@augustwikerfors.se>
In-reply-to: <20230728191408.18141-1-mario.limonciello@amd.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAFMx/BI9+2fEpnCAiiG34Fma+jsCm2JEnzmZKHoPTgqTmh1iK3C2jNizYSEZhxg
 ICQN8F9QebZzzi7+Kc5azFZlY3aynMC72svbX7HDo2g/y7UaLyLPtZb1T5hHnSkW
 xrUsbhJU7wtXQb9OJ6OB89mqRw387xWWchd51fSgZ2MYMkxgPXEhoK0PnLImDVKZ
 t4PkFaD7UW/znuZqxCxF27UIxvX7iR9qrYYGVFEiuYNF4iuu6hUA1F/CQpi2eoGg
 PyDJcj3rJFrKTZL1tGQbL8nxhz4gKVvLF8qQl/oHrB6La3M2t6qL6W4F41HhK0w8
 HU6FJWwzV3hHT9j4RWnyskJyphPpfK/ng5pd157SxtBzFMHt47El/JHZAuUEDzK4
 eJzJCa1jSbhO1xuIn/AgAd5MPr5hzj64w8D5FG4CPoYYZ4ItdixAY9n9bBevy56k KejAvLM=
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-07-28 21:14, Mario Limonciello wrote:
> Lenovo Yoga 7 needs to have keyboard interrupt signaling polarity
> is incorrect in the MADT and the value from the DSDT should be used.
> 
> Reported-by: August Wikerfors <git@augustwikerfors.se>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217718
> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: August Wikerfors <git@augustwikerfors.se>

Thanks!
