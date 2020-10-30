Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6D82A0591
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 13:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgJ3MkE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 08:40:04 -0400
Received: from foss.arm.com ([217.140.110.172]:33620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgJ3MkD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 08:40:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D83C51063;
        Fri, 30 Oct 2020 05:40:02 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5A423F68F;
        Fri, 30 Oct 2020 05:40:01 -0700 (PDT)
Subject: Re: One question about ghes_notify_nmi
To:     yaoaili126@163.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org, YANGFENG1@kingsoft.com,
        yaoaili@kingsoft.com
References: <20201030024129.15519-1-yaoaili126@163.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <db14bb0f-d430-fddc-d2f6-7990b98e681c@arm.com>
Date:   Fri, 30 Oct 2020 12:39:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201030024129.15519-1-yaoaili126@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

On 30/10/2020 02:41, yaoaili126@163.com wrote:
> From: Aili Yao <yaoaili@kingsoft.com>
> Sorry for my ignorance，When I look in to this code, I am totally condused.

No worries - this code is pretty confusing!


> The Line 1136 has guarranted that Only one NMI will enter following code I think, Is
> this right? if so, what is ghes_notify_lock_nmi going to pretect?

Looking at one of the others like ghes_notify_sea() might be simpler.
The lock protects the fixmap slot, in case the notification occurs on multiple CPUs.

notify_nmi is weird as it has this atomic_add_unless() which seems to throw away some of
the CPUs if they arrive ~together. It was added by commit 6fe9e7c26a971 ("GHES: Make NMI
handler have a single reader"), which describes the motivation.

I'm not familiar with how x86 CPUs trigger NMI. From the commit message I've assumed this
means there is some broadcast source of NMI, that is never firmware-first. I thought the
trip via SMM for firmware-first did 'something' to hold the other CPUs so only one CPU
takes the NMI - but I couldn't find it last time I went looking.

As I've no idea how this works, I decided not to change it. I added the spinlock so that
the the fixmap slot provided to ghes_in_nmi_spool_from_list() is always protected by a
spinlock, but the atomic means that for notify_nmi, the lock will never be contended.



Thanks,

James
