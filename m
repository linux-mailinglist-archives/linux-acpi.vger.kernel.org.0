Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7972A0AF
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jun 2023 18:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjFIQzK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Jun 2023 12:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjFIQzJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jun 2023 12:55:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBACD3A89;
        Fri,  9 Jun 2023 09:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 607786149D;
        Fri,  9 Jun 2023 16:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9093DC4339B;
        Fri,  9 Jun 2023 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686329706;
        bh=g0n7Chn+cQVOQcgJcJpt6/rZ1wekppiGu7jjzY6gVhA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bJv2N4TjN4yV0hQPDf2kHJjlofjOwT7s8t2TnMdGxo5ObVp+hEbKd4unoa60bWYsg
         38mmZaPX5USW+VF9fWLPY5Yz75TttrQB1mViTraeBj3Ktt9EfGX6EAdFahml5X6yrA
         YbDyWJmkEeldns0cdQgfM+jl2MwZmH93fbpaGEHl5ivKqw1zyrnlVkj9Iph7WenKzs
         osKRJyGaOsNOj94wLKZVO2vhGp8lHAkCTzgemMemSVCgsXduaNn8WsqXY8wST2EMh0
         6FOdj7GAbZDc4MqMnoRTh5cbZJ2OYFqGEw8kpje3HQqT9PSNkRylclD/YOSYh/qktV
         UG2MXDRJnT00A==
Date:   Fri, 9 Jun 2023 11:55:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Acid Bong <acidbong@tilde.cafe>
Cc:     bagasdotme@gmail.com, linux-acpi@vger.kernel.org,
        rafael@kernel.org, regressions@leemhuis.info,
        regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [REGRESSION] Asus X541UAK hangs on suspend and poweroff (v6.1.6
 onward)
Message-ID: <20230609165505.GA1251392@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CT81XH8HT8A1.2XAHQ1IF5VSO9@bong>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 09, 2023 at 02:09:17PM +0300, Acid Bong wrote:
> Hi there, hello.
> 
> This seems to be my final update.
> 
> About a week ago I returned to using Gajim, which, as I remember from
> earlier, also seemed to be responsible for these hangings, and they got
> more frequent (I haven't updated any software for the last 2 months). I
> decided to move to the kernel version 6.1.1, which I earlier marked as
> "good", and my laptop hung last evening during the shutdown. As always,
> nothing in the logs.
> 
> I tried to compile some versions from 5.15.y branch, but either I had a
> bad luck, or the commits weren't properly compatible with GCC 12 yet,
> but they (.48 and .78) emitted warnings, so I never used them (or I
> broke the repo, who knows).
> 
> Due to the fact that software does have impact on this behaviour, and
> due to my health issues and potential conscription (cuz our army doesn't
> care about health), which will cut me from my laptop for a long-long
> time, I give up on bisecting. I'll just update all my software (there's
> also a GCC upgrade in the repos) and hope for the best.
> 
> Sorry for inconvenience and have a great day. Thank you very much.

No inconvenience on our side; your help is invaluable, especially for
intermittent problems like this one.  They are really hard to find and
debug, and I'm sorry that we didn't get this one resolved.

Bjorn
