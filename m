Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0429B2B0291
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 11:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgKLKMJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 05:12:09 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:44110 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgKLKMI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 05:12:08 -0500
X-AuditID: 0a580155-613ff7000003c60c-49-5fad06abca99
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 9A.84.50700.BA60DAF5; Thu, 12 Nov 2020 17:55:55 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 12 Nov
 2020 18:12:03 +0800
Date:   Thu, 12 Nov 2020 18:12:03 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>, <lenb@kernel.org>
CC:     <james.morse@arm.com>, <rjw@rjwysocki.net>, <tony.luck@intel.com>,
        <linux-acpi@vger.kernel.org>, <YANGFENG1@kingsoft.com>
Subject: Re: [PATCH] ACPI, APEI, Fix incorrect return value of
 apei_map_generic_address
Message-ID: <20201112181203.6c39d096.yaoaili@kingsoft.com>
In-Reply-To: <20201112172407.432b88cc.yaoaili@kingsoft.com>
References: <20201110120002.459078-1-yaoaili126@163.com>
        <20201110145450.GA9857@nazgul.tnic>
        <20201112172407.432b88cc.yaoaili@kingsoft.com>
Organization: Kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsXCFcGooLuabW28wdK1MhafN/xjs7i/bzmT
        xc6Hb9kslu/rZ7Q4c/oSq8WbC/dYHNg8vrf2sXismbeG0WPxnpdMHptWdbJ5bLnazuLxeZNc
        AFsUl01Kak5mWWqRvl0CV8ay41eYC15wVtw7NZm1gXEjexcjJ4eEgInE75sXmbsYuTiEBKYz
        Saxc/osFwnnBKNG6fi5rFyMHB4uAqsTOn4kgDWxA5q57s1hBbBEBU4lFi5qYQGxmgXqJux2L
        WEBsYYFIif1rZoEt4BWwkjgxqwXM5hSwlvjx/xLU/H5GiRd35oDN5xcQk3jVYAxxkL3E879n
        mSF6BSVOznzCAjFfR+LEqmPMELa8xPa3c8BsIQFFicNLfkE9oyRxpHsGG4QdK7Fs3ivWCYzC
        s5CMmoVk1CwkoxYwMq9iZCnOTTfaxAiJhdAdjDOaPuodYmTiYDzEKMHBrCTCq+ywJl6INyWx
        siq1KD++qDQntfgQozQHi5I4b+1ZoJRAemJJanZqakFqEUyWiYNTqoGpaIV8VFlp+/zTIdGO
        OU92OaRL7pqf8V7lohwD08KF9lfyXn/rjJe5pBm56mv06ocpa0o6pb27NnQuv2vinRGVrl77
        6PuvuTJ+DEHW7Ra+3bdt8k0CdB+/3/n5W32piZCRUCirn9CM7yU1+zbkZ5/ce+/8+kqOJdnb
        ta5ErL3iuypvlq6BcRRjdRZjKm/wgryif9zbt5wO+nKx6rBN5bYIGd3pVc+csndp/XikI6zI
        2rKMme/UvP2vF1h8D1xzzfyKqBrHjs0f7gdlys6OSn/j5/C70v2ni31L05m9M6rEbuWxeW3m
        c9Xt3uwRFyXAmlu6vHt3LJuCrdaNF7P3C53fM7N/KueMpEOFv882LFViKc5INNRiLipOBABY
        nsFk9AIAAA==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Oh, Do you mean the document Posting.rst?
Is the wrong doing  BUILD error from robot?

I am really sorry for this!
Before submit anything, I will do more build test and real test.
I will try my best not doing it again. 

If not this, please help point out!.

Thank you!

On Thu, 12 Nov 2020 17:24:07 +0800
Aili Yao <yaoaili@kingsoft.com> wrote:

> Hi, Thanks for your reply! 
> I am really sorry for the chaos from me! 
> 
> 
> On Tue, 10 Nov 2020 15:54:50 +0100
> Borislav Petkov <bp@alien8.de> wrote:
> 
> > On Tue, Nov 10, 2020 at 04:00:02AM -0800, yaoaili126@163.com wrote:  
> > > From: Aili Yao <yaoaili@kingsoft.com>
> > > 
> > > Hi!
> > > Thank you for all the suggestions and comments!
> > > I have re-submited the patch following your comments
> > > I really need to read Documentation/process more detailly!    
> > 
> > Yes, and while doing that please read about top-posting too and stop
> > doing it.  
> I am sorry I don't fully get it, please help point it out and I will avoid
> doing it again.
> 1.The top-posting is the Documents in Documentation/ ?
> 2.I am sorry for the wrong doings, Can you be more clearly.
> Then I will avoid doing it.
> 
> > 
> > Thanks!
> >   
> 
> Thanks
> Aili Yao

