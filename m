Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAC76F3986
	for <lists+linux-acpi@lfdr.de>; Mon,  1 May 2023 23:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjEAVCc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 1 May 2023 17:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEAVCb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 May 2023 17:02:31 -0400
Received: from tilde.cafe (tilde.cafe [51.222.161.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6071BDC;
        Mon,  1 May 2023 14:02:30 -0700 (PDT)
Received: from localhost (124.250.94.80.dyn.idknet.com [80.94.250.124])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by tilde.cafe (Postfix) with ESMTPSA id 835DC20584;
        Mon,  1 May 2023 17:02:27 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 02 May 2023 00:02:26 +0300
Message-Id: <CSB8TSV6LXJ8.7SHI9VM2YMAR@bong>
Cc:     <stable@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        "Thorsten Leemhuis" <regressions@leemhuis.info>,
        "Rafael J. Wysocki" <rafael@kernel.org>
From:   "Acid Bong" <acidbong@tilde.cafe>
To:     "Bagas Sanjaya" <bagasdotme@gmail.com>,
        <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Asus X541UAK hangs on suspend and poweroff (v6.1.6
 onward)
X-Mailer: aerc 0.14.0-126-g6d59ad3f02bc
References: <CRVU11I7JJWF.367PSO4YAQQEI@bong>
 <5f445dab-a152-bcaa-4462-1665998c3e2e@gmail.com>
 <ZE+1pKbfy1l/tTo6@debian.me>
In-Reply-To: <ZE+1pKbfy1l/tTo6@debian.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi there, and thank you for the reminder.

Bisecting, unfortunately, takes a long time: I'm only trying out the 7th
commit, 15e7433e1dc2 (previous 6 marked as bad). The bug, as noted in
the head, doesn't have any (strict) patterns and takes randomly long
times: some kernels hung on the next day after compilation, one took 5
days. I'm not excluding a possibility that I might've got the versions
wrong and the bug occured on the update from 6.1-pf1 to 6.1-pf2 (6.1 and
6.1.3; could be unrelated, but I saw a bunch of commits related to i915
and Skylake).

I also checked my package manager log, no programs related to kernel
compilation (glibc, gcc, archivers and such) were updated until I
updated to the problematic version, and for about two weeks after the
upgrade (the first occurence happened soon after it).

What exactly do you mean by "swapping the hardware"? I'm already sure
it's not related to my storage, because a month ago I replaced my faulty
HDD with an SSD, but the bug still remained. Unfortunately, I don't have
spare PCs or resources to purchase new hardware.
