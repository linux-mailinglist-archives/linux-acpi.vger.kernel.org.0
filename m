Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E842A3DF7
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 08:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgKCHsP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Nov 2020 02:48:15 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:37696 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCHsP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Nov 2020 02:48:15 -0500
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2020 02:48:13 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=X0PFd
        pQu5HRUeg0J0/a0LlKtzKU9wCRVpHB31BrzpO0=; b=cE/6K5VIAWa03mEqNKzIV
        HOHlD98jdpq4e7kQWS9Rx/94WMnUdyWHqP1H6YrJyN9MdEqWHr9g+FbzGqv1SPoG
        gH0ke53cwrOgjPcl5+Fvm8eYMuSkUWIPsD/BSQtPYaJPRJM97sUGJrCiYXzrarls
        LBH+c7UWQpsUWQyp/czvbM=
Received: from smtp.163.com (unknown [36.112.24.9])
        by smtp2 (Coremail) with SMTP id GtxpCgBHDOZIB6FfMkUfAA--.26S2;
        Tue, 03 Nov 2020 15:31:20 +0800 (CST)
From:   yaoaili126@163.com
To:     james.morse@arm.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org, YANGFENG1@kingsoft.com,
        yaoaili@kingsoft.com
Subject: Re: Re: One question about ghes_notify_nmi
Date:   Mon,  2 Nov 2020 23:31:16 -0800
Message-Id: <20201103073116.25857-1-yaoaili126@163.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <db14bb0f-d430-fddc-d2f6-7990b98e681c () arm ! com>
References: <db14bb0f-d430-fddc-d2f6-7990b98e681c () arm ! com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgBHDOZIB6FfMkUfAA--.26S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1fGF18Cw13GF43tw47urg_yoW8Kr1fpa
        93XasrCF95WF10yr4kZay7t3y5Za4kCr43JF1rK3ykZ3s8uFZxtr1Igw429rWkCr1Iq345
        t3ZrK3y8Aas8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URHqxUUUUU=
X-Originating-IP: [36.112.24.9]
X-CM-SenderInfo: 51drtxdolrjli6rwjhhfrp/1tbifAvRG1r6nPtBdgADsO
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Aili Yao <yaoaili@kingsoft.com>

Hi! Thanks for your reply.
Got you!
And for x86 platform, NMI is not only for hw errors, it does have some other
functions like watchdog, and maybe others i don't know.
when CPU is in heavy workload, the NMI watchdog will be triggered 
repeatily, and it will come to ghes_notify_nmi, the atomic raw_spin_lock
may lock the memory bus which may have little performance inpact to other
coresi i think.
I think you may modify it.

Thanks
Aili Yao

> -----Original Message-----
> From: James Morse [mailto:james.morse@arm.com]
> Sent: Friday, October 30, 2020 8:40 PM
> To: yaoaili126@163.com
> Cc: rjw@rjwysocki.net; lenb@kernel.org; tony.luck@intel.com; bp@alien8.de;
> linux-acpi@vger.kernel.org; YANGFENG1
> <YANGFENG1@kingsoft.com>; yaoaili<yaoaili@kingsoft.com>
> Subject: Re: One question about ghes_notify_nmi
> 
> Hello,
> 
> On 30/10/2020 02:41, yaoaili126@163.com wrote:
> > From: Aili Yao <yaoaili@kingsoft.com>
> > Sorry for my ignorance，When I look in to this code, I am totally condused.
> 
> No worries - this code is pretty confusing!
> 
> 
> > The Line 1136 has guarranted that Only one NMI will enter following
> > code I think, Is this right? if so, what is ghes_notify_lock_nmi going to
> pretect?
> 
> Looking at one of the others like ghes_notify_sea() might be simpler.
> The lock protects the fixmap slot, in case the notification occurs on multiple
> CPUs.
> 
> notify_nmi is weird as it has this atomic_add_unless() which seems to throw
> away some of the CPUs if they arrive ~together. It was added by commit
> 6fe9e7c26a971 ("GHES: Make NMI handler have a single reader"), which
> describes the motivation.
> 
> I'm not familiar with how x86 CPUs trigger NMI. From the commit message
> I've assumed this means there is some broadcast source of NMI, that is never
> firmware-first. I thought the trip via SMM for firmware-first did 'something'
> to hold the other CPUs so only one CPU takes the NMI - but I couldn't find it
> last time I went looking.
> 
> As I've no idea how this works, I decided not to change it. I added the
> spinlock so that the the fixmap slot provided to
> ghes_in_nmi_spool_from_list() is always protected by a spinlock, but the
> atomic means that for notify_nmi, the lock will never be contended.
> 
> 
> 
> Thanks,
> 
> James

