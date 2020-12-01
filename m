Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98722CA042
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 11:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgLAKrP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 05:47:15 -0500
Received: from foss.arm.com ([217.140.110.172]:40528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgLAKrP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Dec 2020 05:47:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38384101E;
        Tue,  1 Dec 2020 02:46:29 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB68E3F66B;
        Tue,  1 Dec 2020 02:46:21 -0800 (PST)
Subject: Re: [RFC PATCH v2 0/2] scheduler: expose the topology of clusters and
 add cluster scheduler
To:     Barry Song <song.bao.hua@hisilicon.com>,
        valentin.schneider@arm.com, catalin.marinas@arm.com,
        will@kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     linuxarm@huawei.com, xuwei5@huawei.com, prime.zeng@hisilicon.com
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <fb332889-6385-fe23-be12-5caf150d5817@arm.com>
Date:   Tue, 1 Dec 2020 11:46:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 01/12/2020 03:59, Barry Song wrote:

[...]

> Although I believe there is still a lot to do, sending a RFC to get feedbacks
> of community experts might be helpful for the next step.
> 
> Barry Song (1):
>   scheduler: add scheduler level for clusters
> 
> Jonathan Cameron (1):
>   topology: Represent clusters of CPUs within a die.

Just to make sure. Since this is v2, the v1 is
https://lkml.kernel.org/r//20201016152702.1513592-1-Jonathan.Cameron@huawei.com

Might not be obvious to everyone since sender and subject have changed.
