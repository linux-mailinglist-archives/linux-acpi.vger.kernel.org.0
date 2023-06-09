Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545B67297DB
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jun 2023 13:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbjFILJt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 9 Jun 2023 07:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbjFILJX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jun 2023 07:09:23 -0400
Received: from tilde.cafe (tilde.cafe [51.222.161.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3336E2D42;
        Fri,  9 Jun 2023 04:09:22 -0700 (PDT)
Received: from localhost (67.250.94.80.dyn.idknet.com [80.94.250.67])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by tilde.cafe (Postfix) with ESMTPSA id CA44020309;
        Fri,  9 Jun 2023 07:09:18 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jun 2023 14:09:17 +0300
Subject: Re: [REGRESSION] Asus X541UAK hangs on suspend and poweroff (v6.1.6
 onward)
Cc:     <bagasdotme@gmail.com>, <linux-acpi@vger.kernel.org>,
        <rafael@kernel.org>, <regressions@leemhuis.info>,
        <regressions@lists.linux.dev>, <stable@vger.kernel.org>,
        <helgaas@kernel.org>
From:   "Acid Bong" <acidbong@tilde.cafe>
To:     <acidbong@tilde.cafe>
Message-Id: <CT81XH8HT8A1.2XAHQ1IF5VSO9@bong>
X-Mailer: aerc 0.15.2-0-gf1772c92f92e
In-Reply-To: <CSB8TSV6LXJ8.7SHI9VM2YMAR@bong>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi there, hello.

This seems to be my final update.

About a week ago I returned to using Gajim, which, as I remember from
earlier, also seemed to be responsible for these hangings, and they got
more frequent (I haven't updated any software for the last 2 months). I
decided to move to the kernel version 6.1.1, which I earlier marked as
"good", and my laptop hung last evening during the shutdown. As always,
nothing in the logs.

I tried to compile some versions from 5.15.y branch, but either I had a
bad luck, or the commits weren't properly compatible with GCC 12 yet,
but they (.48 and .78) emitted warnings, so I never used them (or I
broke the repo, who knows).

Due to the fact that software does have impact on this behaviour, and
due to my health issues and potential conscription (cuz our army doesn't
care about health), which will cut me from my laptop for a long-long
time, I give up on bisecting. I'll just update all my software (there's
also a GCC upgrade in the repos) and hope for the best.

Sorry for inconvenience and have a great day. Thank you very much.
