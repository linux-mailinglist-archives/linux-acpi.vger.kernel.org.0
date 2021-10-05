Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24434421F7F
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 09:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhJEHiV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 03:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhJEHiU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Oct 2021 03:38:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49368C061745;
        Tue,  5 Oct 2021 00:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y5gt1If+/hsqVVHAj7xKvSyW9r0OWSsRYlpPTn9rXvI=; b=Y2iouF3pc6pA0xJBIGNkubZ1Mx
        7DW/raaukClWHAVBw/ChGAo+J7CPQ5WRZ/CdpsW0rd704RivUwBNxvTLOry4Wta1h61uyLS8zgJFh
        1043QH6Fzk29fb9yeSjGqNKfio2NNytjtpJQZADd99IbcpzbdO5VUUhF08NgM1+tPcImhGOfsnIH1
        sHBn5AO/QMk8sRtXM95qsR5Ky1W5BGdP52TdDOXF7CFdIpvM2CijBbiVBZmSdC5yJfGh9pzxlllme
        hHM9wRPospRJNK6ec8qnqsem4CIqMmLJbdlBTUat6YfX+cZw1geTzQAhG2hfK2X2xNKY13nOGIEis
        xL2Hq4JA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXezJ-0080YT-HK; Tue, 05 Oct 2021 07:35:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0EF498631C; Tue,  5 Oct 2021 09:35:44 +0200 (CEST)
Date:   Tue, 5 Oct 2021 09:35:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        aubrey.li@linux.intel.com, bp@alien8.de, bristot@redhat.com,
        bsegall@google.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, guodong.xu@linaro.org, hpa@zytor.com,
        jonathan.cameron@huawei.com, juri.lelli@redhat.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        mark.rutland@arm.com, mgorman@suse.de, msys.mizuma@gmail.com,
        prime.zeng@hisilicon.com, rjw@rjwysocki.net, rostedt@goodmis.org,
        song.bao.hua@hisilicon.com, sudeep.holla@arm.com,
        tglx@linutronix.de, rafael@kernel.org, tim.c.chen@linux.intel.com,
        valentin.schneider@arm.com, will@kernel.org, x86@kernel.org,
        yangyicong@huawei.com, Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH RESEND 2/3] scheduler: Add cluster scheduler level in
 core and related Kconfig for ARM64
Message-ID: <20211005073544.GI4323@worktop.programming.kicks-ass.net>
References: <20210924085104.44806-1-21cnbao@gmail.com>
 <20210924085104.44806-3-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924085104.44806-3-21cnbao@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 24, 2021 at 08:51:03PM +1200, Barry Song wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 

> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

That is not a valid SoB pattern. The first SoB should be the author, the
last SoB should be the one sending the patch, in this case both are
Barry. What's Yicong's contribution in all this?
