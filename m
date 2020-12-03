Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51212CD331
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Dec 2020 11:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbgLCKIq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Dec 2020 05:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgLCKIq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2020 05:08:46 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC70BC061A4D;
        Thu,  3 Dec 2020 02:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bU6KsdkUGEC13tivHFxD1MLAYDK3da6itDnIcIEnA2A=; b=Qg7wX6rioJyI/yE4R+nmx58n+N
        Xo/pLk/LZc1YDNSQRbE0N4C7tvC5PBD3UpFZs52FyRgYnj2S6EUf3l7/OMnJzE/iWHHDHWtrj5jrz
        XdK9fEVUd/ZHzXunODNvZDlOJ0+92R91dm5HpOP4l3pzPZmxd0KSDjMFEEpIqHD+n12u/cP5rmAec
        4kGDXR7Bc2b3zTcXRY/hU2WcGSFkjzhpj3ogWP68PZ7SlZ8Y07mK7R+eRW/Ut+jCs+WVvc5N3cFRg
        crMRcO3rKKJBzxZZ9kmpA4nXo0R0s/ArB9yT6gDozR/aI+4xYB+NBA9en2vTuDSWIxN3mE8fhRxiP
        mP6dJ8Fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kklWY-0001rj-G4; Thu, 03 Dec 2020 10:07:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 071E8302753;
        Thu,  3 Dec 2020 11:07:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C66FC201B7B65; Thu,  3 Dec 2020 11:07:39 +0100 (CET)
Date:   Thu, 3 Dec 2020 11:07:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: Re: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
Message-ID: <20201203100739.GJ2414@hirez.programming.kicks-ass.net>
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
 <20201201025944.18260-3-song.bao.hua@hisilicon.com>
 <jhj1rg9v7gr.mognet@arm.com>
 <20201203092831.GH2414@hirez.programming.kicks-ass.net>
 <ebc9da1f1fdf45479651906edbfc55a6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebc9da1f1fdf45479651906edbfc55a6@hisilicon.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 03, 2020 at 09:57:09AM +0000, Song Bao Hua (Barry Song) wrote:

> Would you point out the link of your previous patches?

https://lkml.kernel.org/r/20180530142236.667774973@infradead.org

