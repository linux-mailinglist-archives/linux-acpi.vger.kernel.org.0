Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81EF2A9E1B
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Nov 2020 20:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgKFTeg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Nov 2020 14:34:36 -0500
Received: from foss.arm.com ([217.140.110.172]:44032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgKFTef (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Nov 2020 14:34:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 684C11474;
        Fri,  6 Nov 2020 11:34:35 -0800 (PST)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34FB13F718;
        Fri,  6 Nov 2020 11:34:34 -0800 (PST)
Subject: Re: One question about ghes_notify_nmi
To:     yaoaili126@163.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org, YANGFENG1@kingsoft.com,
        yaoaili@kingsoft.com
References: <db14bb0f-d430-fddc-d2f6-7990b98e681c () arm ! com>
 <20201103073116.25857-1-yaoaili126@163.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <c0ffc83f-0c97-8a08-afef-b0e3190530e6@arm.com>
Date:   Fri, 6 Nov 2020 19:34:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201103073116.25857-1-yaoaili126@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

On 03/11/2020 07:31, yaoaili126@163.com wrote:
> From: Aili Yao <yaoaili@kingsoft.com>
> 
> Hi! Thanks for your reply.
> Got you!
> And for x86 platform, NMI is not only for hw errors, it does have some other
> functions like watchdog, and maybe others i don't know.
> when CPU is in heavy workload, the NMI watchdog will be triggered 
> repeatily, and it will come to ghes_notify_nmi, the atomic raw_spin_lock
> may lock the memory bus which may have little performance inpact to other
> coresi i think.
> I think you may modify it.

But the atomic property is needed. Without it, according to the commit that added that
code, CPUs serialise in the GHES code.


Thanks,

James
