Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F74826A376
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Sep 2020 12:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgIOKq3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 06:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgIOKn5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2020 06:43:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5811C06174A;
        Tue, 15 Sep 2020 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VUh0x74rFETn1g3Yut3ZTkkDJyuzqbAXdAXZp2icBLA=; b=uZp0qBVO7EA2b4U9UE3pkYlpRm
        Skm19GN/kZHisiT/YZXL/HiTJqeVFHQF7AC2EWBmJEkEACC0H84gdHLjrMnctcUj1NE63NVhMC8Cd
        uKkUryTxfC+SOPbeaJAgSBzwI3RevZ99IGUwxjsPlJFor55u0JTtes9eV1haMCqwBk6zzCcofTtIi
        JbiBRYIp9BYY/PTL7j1vfZSTU7K5rr2lElOroXFKeRPh6oCB8VArdTIN/hRCpmPceIIWOrEq2vWla
        XIB6nZH9BnCwJpyZ8pqOuAPIgj+8g+18Gs2EZRwjTs0+Oy3a3BWyOLhYKnQ618zHNjaaiSk1ZvX13
        vwpwi04A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kI8R5-0006v6-7X; Tue, 15 Sep 2020 10:43:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B003B305C16;
        Tue, 15 Sep 2020 12:43:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8A932214EDD4A; Tue, 15 Sep 2020 12:43:40 +0200 (CEST)
Message-ID: <20200915103157.345404192@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Sep 2020 12:31:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, bp@alien8.de
Cc:     x86@kernel.org, tony.luck@intel.com, lenb@kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, paulmck@kernel.org, tglx@linutronix.de,
        naresh.kamboju@linaro.org, peterz@infradead.org
Subject: [RFC][PATCH 0/4] Fix up ACPI processor idle vs RCU
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

A number of people have been tripping over the improved RCU-lockdep complaints
in idle.

These 4 patches attempt to cure ACPI processor idle. I've done my best to not
wreck things, but it's all magical code with very few comments, so who knows..

Boris tested an earlier version of these patches and they worked for his
32bit Atom board that was triggering complaints.

