Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B29E7658E6
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jul 2023 18:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjG0QjN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jul 2023 12:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjG0QjN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jul 2023 12:39:13 -0400
Received: from abi149hd127.arn1.oracleemaildelivery.com (abi149hd127.arn1.oracleemaildelivery.com [129.149.84.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F672D4F
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jul 2023 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=TUR8Bp9AvDdz7mF4b5ZMncRJ7atKCHvCkxwXqShE5b0=;
 b=c/MRb5/z40lzFSg1LT2XsFo0z1oN7p6bTdXRLP6mwQdT5zY3hazwFa4dGcC8X8qsZ/qkSCHIPf3a
   X7UVoh5LKZ3Fy7G/zw3kFa29fBPrS3XV8QcmVxyszr4nvdPZ1/6XxYm1J4NbpwhHRCweS1o3af82
   E0Sj+yasUOiQug9p32BrrBhMda9n+NjW7iUyKgrEj9ORQ62IkzfbPi25XbURzsrZ3p6AuCo0qrZ+
   +oRrsod/nmiZ6AYXjZWu+8I9W8E/yBcmRpnnCHf9vi7wRz5XejHqJILXJgH9ZZuJvzOGYp3EF6PG
   VpCiDm8vgLu1li4l5Nf9U/pxr+UIRT8x31Rafw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=TUR8Bp9AvDdz7mF4b5ZMncRJ7atKCHvCkxwXqShE5b0=;
 b=WWVLg7uniBO4YJRL4OnT/2QOSJ4y0NoM2bs7qsENSY/9VwGUg3IdKQKzW+pM6fz0F7qBY5oz08kF
   Ud9DF2O58qfPgFWYRNTtsd84eV5rpL1c0ZmbWMQwBbnJShkvVEgPZNUB2TzW81VXy3TuTCVOw6qq
   dDcI1jVRqfooRIl/+7L0Oi+RcR0qFauWHQDNie7Wk9AL64S9F7h5SEuA+RELVVxKDcNxeKw7otk4
   ZL3MgUcrXmrk3xrU3AFiXLbVG8X1mt11wxR9rk/R3xTR8kI7orr5oQhI0FIfUwRAcv2vxMDuPSRk
   dtSQRnJpLi3f6Unlu62SOT0S7/a9Fs9shkflPQ==
Received: by omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230629 64bit (built Jun 29
 2023))
 with ESMTPS id <0RYG006JZRL64P80@omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-acpi@vger.kernel.org; Thu, 27 Jul 2023 16:39:07 +0000 (GMT)
Message-id: <838377ff-4df5-6b5d-e127-615e7e4dce4e@augustwikerfors.se>
Date:   Thu, 27 Jul 2023 18:39:03 +0200
MIME-version: 1.0
From:   August Wikerfors <git@augustwikerfors.se>
Subject: Re: [REGRESSION] IRQ override revert breaks keyboard on Lenovo Yoga 7
 14ARB7
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <596b9c4a-fb83-a8ab-3a44-6052d83fa546@augustwikerfors.se>
 <d3179d08-d513-a7e4-9ddb-416e50578957@amd.com>
Content-language: en-US
In-reply-to: <d3179d08-d513-a7e4-9ddb-416e50578957@amd.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 8bit
Reporting-Meta: AAEmfh3AQNA2NlNOpFxqcaDLKO5WwzqH005cigcB7ucbTA9rDG1WbIVPpXsWcScT
 KYdQNzGmTT8E1DtL1mf3ADYa+DJRhvHpbFkvkZusQMwF9Cv/sz7iO4b0Zr7bETo0
 GYeknTtyMHQn1UtFmEG46wRBBAsQnhiXotFyJ3hQtN18ulu36dQyrP8jsb3LlOKI
 Ju7t0pALPxCyKiAOwyDZWsOEjcJnBiZzGGj2O62bsE4qmDAjayZtanfBh+7y9JaG
 hMRAOhHAE51WZ2rcla7jhgtOPAGMEEri1jNFcHIv3tIrc7H54oZOCtArCogSmZ0u
 vivwdmlF311Ge43lsB8CUNc2B3sszcosQRCOItCA6wGbe/9ojoEBV17UiVey/uXx
 gsHeNY93oWmQYRNozYlk8zQCL3yO93AZV79H4KERCBGzd9o8d73xkGTkqXyj9kth HqIue2M=
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-07-27 04:56, Mario Limonciello wrote:
> This is unfortunate.  Before we go adding more quirks for your system, 
> can you please check for a BIOS upgrade for your system?  If it's 
> happening with the latest BIOS, then can you please open a kernel 
> bugzilla with an acpidump and dmidecode included?

The latest released BIOS is K5CN40WW, I'm using K5CN40WWT66 which is a 
later beta that partially mitigates a Windows BSOD issue. I've opened a 
Bugzilla report with the dmidecode here: 
https://bugzilla.kernel.org/show_bug.cgi?id=217718

For the acpidump I'm not sure what parts could be sensitive so I will 
e-mail it directly to you.
