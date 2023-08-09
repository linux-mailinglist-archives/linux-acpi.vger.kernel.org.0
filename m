Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F4D776497
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 17:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjHIP6k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjHIP6j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 11:58:39 -0400
Received: from abi149hd127.arn1.oracleemaildelivery.com (abi149hd127.arn1.oracleemaildelivery.com [129.149.84.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E5A1FF9
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=wJbRNyHi8yoNQasim14sSnWXoA8mCY7kOtEKklhD9LI=;
 b=ALcv05k++y44xeffdk0vwwr4NJDRAm33D0wA93M2I4QUaWQw4IzW2T0FKWvYT3UC+VhuI4CLqWZr
   KuEFHQ4PyDaLSSGWQ9aIPg+2lMDz0EnAJzMYAoDfr0MP5SclJkfbXSpJCFJbDaZB2uYgwmgeAEZm
   lxdJcVWkPZyF1oAeQxqzYA6jxoqQODjKD1ONYK9CbpTpovARSlxcR8cBEAY+J/nxPkUODvwgEjz5
   oNbW5yWxOJWRxasW/kSQVyDLZy4lKMwiAmo6tVPNT9TLgd1Qj+FCJhBE77+A8mJTMoK+KbQ5q9Vc
   9VvRtsII3sEe1ARJikRih3h1Kxk1FwEIq8Cdhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=wJbRNyHi8yoNQasim14sSnWXoA8mCY7kOtEKklhD9LI=;
 b=N2gBetHlAq0OqxQQCFmtN/Wvw3AbVpd9totApijuZcCblmppefqRzehXgWWMNZ2Kh0YIZ7jD+6MT
   jY3JQ/X9QobD0hiROTPXSr/mOne0Oj3aqFmhzQCbhyI7Ojzv4DVCh79szptimVh2rv/sgFIsrXI4
   0QE9Rki/wDvawFUIqBkpb4rVLqGVwjosYSQxLxoFaJHwzoruCk2AbLO592+0g/6jQOzRpLF3mwdq
   As4cv2RvHl0DZJOVdENVv5BIv6hdHZYhG96PMAToPc1B+9laoCijS7bRRnl1LbaO+Sx64d8r/05g
   6YFm4PbWqFykqf2p13DC4IDi8NjZHOJ9XU0lpQ==
Received: by omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230707 64bit (built Jul  7
 2023))
 with ESMTPS id <0RZ4004QESDHNXD0@omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-acpi@vger.kernel.org; Wed, 09 Aug 2023 15:58:29 +0000 (GMT)
Message-id: <6a6fa2ba-c07d-45b2-96c5-b0f44f5f288b@augustwikerfors.se>
Date:   Wed, 9 Aug 2023 17:58:25 +0200
MIME-version: 1.0
Subject: Re: [PATCH v3 3/3] ACPI: resource: Honor MADT INT_SRC_OVR settings for
 IRQ1 on AMD Zen
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
References: <20230809085526.84913-1-hdegoede@redhat.com>
 <20230809085526.84913-4-hdegoede@redhat.com>
Content-language: en-US
From:   August Wikerfors <git@augustwikerfors.se>
In-reply-to: <20230809085526.84913-4-hdegoede@redhat.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAEnYWVjk7Vvuxio3PH4r2Bu30R2r5iymG9J69E5kFnUIZYVKHhD1P6r9DekHpXi
 KOBUp4dsB38XhXFLQyPg7AxmivqcTZlDoZmBUqigGd8/vUL/XVPFfGYKoxUD6dly
 XrHLcu4Esvwu0EvEOINjnqnUNXyz3Y3wkWZ4aWUjesxMjbdZND+BGFX7k2jLglSG
 LgZKlTYAAB7muWR5hxzpssZRwyuLd/TULWOCjLxuEZ+znVVg476C9xaeHnWp5lyq
 pfLJ8CATyxBIPEmFPxMhzljiOQZia/ZlCW1j9lp1VeGg/Hu7VAZgl7DOvAsqxOb1
 YxXgNveOwmvVmjir7Va4cJZLaD+lUOCmA8GtgkNZZ+gHkKAX2EQdQbxhfITMJFjS
 yJuXHEvM0+Ouljt4KA17uNntGLyR7sw+n6yiDoNAX7g0QgVTi8R/WJW/9ygmdb5p t0tiiA==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-08-09 10:55, Hans de Goede wrote:
> On AMD Zen acpi_dev_irq_override() by default prefers the DSDT IRQ 1
> settings over the MADT settings.
> 
> This causes the keyboard to malfunction on some laptop models
> (see Links), all models from the Links have an INT_SRC_OVR MADT entry
> for IRQ 1.
> 
> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217336
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217406
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

One of the laptops fixed by a9c4a912b7dc, PCSpecialist Elimina Pro 16 M 
[1], seems to have no INT_SRC_OVR entry for IRQ 1 [2]:

> [    0.084265] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.084266] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)

I'm not sure if it was IRQ 1 that needed to be overridden for that model 
though, so it may work anyway with patch 2 of this series.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217394#c18
[2] https://bugzilla.kernel.org/attachment.cgi?id=304338

Regards,
August Wikerfors
