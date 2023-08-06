Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC07715FB
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Aug 2023 17:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjHFPvv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Aug 2023 11:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjHFPvv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Aug 2023 11:51:51 -0400
Received: from abi149hd127.arn1.oracleemaildelivery.com (abi149hd127.arn1.oracleemaildelivery.com [129.149.84.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5C01B3
        for <linux-acpi@vger.kernel.org>; Sun,  6 Aug 2023 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=x/SG0A30SFxLUadyn8TesCdeaY9lbopeGx+AqtWaSH8=;
 b=C+0lAmAwhYrlUEOg/RIc/wacgQBoujwxGhqqUcgOInd1LxjmmPHw1zhOlckEIwVFbd75wGEVBbjr
   irGqxzv+EJwnPlToLsJgRoaN+pSRkLhN4X9vyJw5P38DUd5oVAq1GxIXfE0xywidKb2qj4XJGQWn
   1eukAEOCfyKKqsYK18iuXGC2/liVnjlu8BRw1cLDM8tH+GqoEcTRRPwMCrVeeDAxSZ9wncjEVOee
   UqEb3a6X2jbC6lBAUYxxoHFPWLBRwa1Zj8RjjaoplXKadhk3cTmdwCkd6Ns6Waosao507K30EEbA
   rPpTHtsA5pkE2ZXy21iTGOH5ooKNGNWc97hWIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=x/SG0A30SFxLUadyn8TesCdeaY9lbopeGx+AqtWaSH8=;
 b=grz5RZOv+pIfbcPpS2paGkgXdbft3u/fTSi0ZQyBdTdBiNVl2zewx7VKLegh+9Wv4sI6hMR4gJzD
   C56llS8GCEstumBlU1t90ICOg55h//7dQa6lyPU22BOnOT3aYCCMFrnPXv1/BxWwcDiofsTyXOAI
   151kCgRsSSd+l+84wwLyfYZmAH56fr9NTg6KPYoC9H5yqW6Or9JY4qDg5cDL/MDVQieqpwO+2rYK
   LqkQaPe2QPFOfln8ZhTL0rMrjGhgB4F1uD06n2kFeUzuzs/uHIGzdIRKzy7ap8lnbI47w5gFRMNc
   7f+GQBamBeiBs2f/+YsY9mOCggg7XF2RPy9Nwg==
Received: by omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230707 64bit (built Jul  7
 2023))
 with ESMTPS id <0RYZ00IBU82AK120@omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-acpi@vger.kernel.org; Sun, 06 Aug 2023 15:51:46 +0000 (GMT)
Message-id: <e56c1c28-9300-4103-b9b1-52191c09c436@augustwikerfors.se>
Date:   Sun, 6 Aug 2023 17:51:43 +0200
MIME-version: 1.0
From:   August Wikerfors <git@augustwikerfors.se>
Subject: Re: [PATCH] ACPI: resource: revert
 "Remove "Zen" specific match and quirks"
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
References: <20230806151453.10690-1-hdegoede@redhat.com>
Content-language: en-US
In-reply-to: <20230806151453.10690-1-hdegoede@redhat.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAH1BlvagG6VXJZ1MKDUlAUw9iWIQPC6vIGZnYKwTMs/fesCqfB/c4UbXaYbw7b5
 +holF8NzX225p2fEg/a+rflSLvHEpxdQxcSXGJrxmoodzoVcL2ozmqLfsYy9rNdq
 0uHKT1fL1x2/H1sbnoi48ebGnlnterGMUMvSsDCSyff5NgBEIur3elmFy+vmFFGv
 OVJmzyuUmw7Mor5c3DQjjGg+xcbKZVMs4Cf9AAAfimIL3q7dSTM9E9v1H4gSwb64
 WhPGv2NCnyDjU7CHOtYXcvgaszfikJRik50o74ovvC8vBWf0Ro8u9/7Obhfn4kZI
 z3HC6/vDSvGBSJTQtRimr273FDc+HhqCJdOyReAuZbcdNAc4tXmv/S2JlrI5canC
 w+MIaBsiXU7Wy4Gdyrb2tssoKnkXcFoUBWaNoBXY0IXUws01BqRvW9vqyyj01cDj 7yXVdw==
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-08-06 17:14, Hans de Goede wrote:
> Commit a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and
> quirks") is causing keyboard problems for quite a log of AMD based
> laptop users, leading to many bug reports.
> 
> Revert this change for now, until we can come up with
> a better fix for the PS/2 IRQ trigger-type/polarity problems
> on some x86 laptops.
> 
> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229165
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229317
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217726

Other reports for various Lenovo laptops:
https://lore.kernel.org/all/596b9c4a-fb83-a8ab-3a44-6052d83fa546@augustwikerfors.se/T/
https://bugzilla.kernel.org/show_bug.cgi?id=217718
https://bugzilla.kernel.org/show_bug.cgi?id=217731

> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

FWIW only reverting a9c4a912b7dc will also cause a regression because it 
did also fix the keyboard on some devices, see the links in its commit 
message.

Regards,
August Wikerfors
