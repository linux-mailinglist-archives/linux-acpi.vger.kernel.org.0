Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD202B01E9
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 10:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgKLJYR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 04:24:17 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:22485 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725902AbgKLJYQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 04:24:16 -0500
X-AuditID: 0a580155-5fbff7000003c60c-1b-5facfb6fb65c
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 74.34.50700.F6BFCAF5; Thu, 12 Nov 2020 17:07:59 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 12 Nov
 2020 17:24:07 +0800
Date:   Thu, 12 Nov 2020 17:24:07 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <james.morse@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <tony.luck@intel.com>, <linux-acpi@vger.kernel.org>,
        <YANGFENG1@kingsoft.com>, <yaoaili126@163.com>
Subject: Re: [PATCH] ACPI, APEI, Fix incorrect return value of
 apei_map_generic_address
Message-ID: <20201112172407.432b88cc.yaoaili@kingsoft.com>
In-Reply-To: <20201110145450.GA9857@nazgul.tnic>
References: <20201110120002.459078-1-yaoaili126@163.com>
        <20201110145450.GA9857@nazgul.tnic>
Organization: Kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsXCFcGooJv/e028wd9byhafN/xjs7i/bzmT
        xc6Hb9kslu/rZ7Q4c/oSq8WbC/dYLFZ9fcvowO6xeMUUVo/vrX0sHmvmrWH0WLznJZPHplWd
        bB5brrazeHzeJBfAHsVlk5Kak1mWWqRvl8CV8XZeN2PBHraK7RfPMDcw/mfpYuTkkBAwkeg4
        1MHexcjFISQwnUmi8cwyZgjnBaPEyxt72UGqWARUJZoPzGYEsdmA7F33ZrGC2CICShJfF81l
        AmlgFljFKPFqdyNYQlggUmL/mllgzbwCVhKTe74wg9icAgYSe14dAosLCcRJbFkzna2LkYOD
        X0BM4lWDMcRF9hLP/55lhmgVlDg58wnYpcwCOhInVh1jhrDlJba/ncMMMUZR4vCSX+wQvUoS
        R7pnsEHYsRLL5r1incAoPAvJqFlIRs1CMmoBI/MqRpbi3HSjTYyQCAndwTij6aPeIUYmDsZD
        jBIczEoivMoOa+KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ89aeBUoJpCeWpGanphakFsFkmTg4
        pRqYMpd+CLkyS5B1WmRKiaWBonneqo92jc9mWGQ/DZ/q42wc/CXFPXM7R1B+97O6baYPlHa7
        7nT+dUs2IjKcc/10r9uPD7l5aDBPMdmi4zJ77qeF11gW5N6rZjNJLPoYYTf9z76/h2Jrj/Zb
        sLHuqXzakbzu6dJJiZMWq/WUpdtKKS1oP328dDFL6dI0f2+fK5dPpn2Yt9N93bNZ8l8W3m0Q
        r/yU5376jUJNLsfrb6qZiQY8pd+OWokpWbnzLNzc0mu6oyh2W9h6n0OqLV9T3xqxnDKdvfNb
        6x3pKevj+7WUi29kxsz9Z2Rk5n/0WyR/0qcNazh43j3YsmlGc/Zfs20trmoTOzW3CT6cb/4z
        cf8RJZbijERDLeai4kQAhEGn2v8CAAA=
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Thanks for your reply! 
I am really sorry for the chaos from me! 


On Tue, 10 Nov 2020 15:54:50 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Nov 10, 2020 at 04:00:02AM -0800, yaoaili126@163.com wrote:
> > From: Aili Yao <yaoaili@kingsoft.com>
> > 
> > Hi!
> > Thank you for all the suggestions and comments!
> > I have re-submited the patch following your comments
> > I really need to read Documentation/process more detailly!  
> 
> Yes, and while doing that please read about top-posting too and stop
> doing it.
I am sorry I don't fully get it, please help point it out and I will avoid
doing it again.
1.The top-posting is the Documents in Documentation/ ?
2.I am sorry for the wrong doings, Can you be more clearly.
Then I will avoid doing it.

> 
> Thanks!
> 

Thanks
Aili Yao
