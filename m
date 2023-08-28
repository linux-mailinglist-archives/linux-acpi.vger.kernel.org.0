Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1129B78A3BC
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Aug 2023 03:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjH1BDj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 27 Aug 2023 21:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjH1BDS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Aug 2023 21:03:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCA0F4;
        Sun, 27 Aug 2023 18:03:15 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RYshK3sZsz1L9GX;
        Mon, 28 Aug 2023 09:01:37 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 28 Aug
 2023 09:03:12 +0800
Message-ID: <36f997d9-288e-07e2-07b5-9624252fe55e@huawei.com>
Date:   Mon, 28 Aug 2023 09:03:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RESEND v4 0/2] mailbox: pcc: Support platform notification
 for type4 and shared interrupt
To:     Robbie King <robbiek@xsightlabs.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
CC:     "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>,
        "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "liuyonglong@huawei.com" <liuyonglong@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230801063827.25336-1-lihuisong@huawei.com>
 <20230801093831.dkamhtuvamjalhaa@bogus>
 <779c1483-5b24-5c01-6821-8699b17802c7@huawei.com>
 <007ca8aa-f0ec-8d1d-2d3f-62f370b99104@huawei.com>
 <2ecbae88-89f1-fe94-3fac-148d002607ad@huawei.com>
 <AS8P193MB233566815E722D9B3B13B5EECAE2A@AS8P193MB2335.EURP193.PROD.OUTLOOK.COM>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <AS8P193MB233566815E722D9B3B13B5EECAE2A@AS8P193MB2335.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Robbie,

If this series is good for you, can you give it Tested-by?

/Huisong


在 2023/8/26 20:21, Robbie King 写道:
> We also need this patch upstreamed.
>
> Thanks!
>
>
> ------------------------------------------------------------------------
> *From:* lihuisong (C) <lihuisong@huawei.com>
> *Sent:* Friday, August 25, 2023 10:40:33 PM
> *To:* rafael@kernel.org <rafael@kernel.org>; 
> rafael.j.wysocki@intel.com <rafael.j.wysocki@intel.com>
> *Cc:* Robbie King <robbiek@xsightlabs.com>; guohanjun@huawei.com 
> <guohanjun@huawei.com>; linux-acpi@vger.kernel.org 
> <linux-acpi@vger.kernel.org>; linux-kernel@vger.kernel.org 
> <linux-kernel@vger.kernel.org>; wanghuiqiang@huawei.com 
> <wanghuiqiang@huawei.com>; zhangzekun11@huawei.com 
> <zhangzekun11@huawei.com>; wangxiongfeng2@huawei.com 
> <wangxiongfeng2@huawei.com>; tanxiaofei@huawei.com 
> <tanxiaofei@huawei.com>; wangkefeng.wang@huawei.com 
> <wangkefeng.wang@huawei.com>; liuyonglong@huawei.com 
> <liuyonglong@huawei.com>; Sudeep Holla <sudeep.holla@arm.com>
> *Subject:* Re: [PATCH RESEND v4 0/2] mailbox: pcc: Support platform 
> notification for type4 and shared interrupt
>
> kindly ping.
>
> 在 2023/8/17 14:50, lihuisong (C) 写道:
> > Hi Rafael,
> >
> > Can you take a look at this series?
> > All be done. This series have missed two merge window.
> >
> >
> > 在 2023/8/9 19:44, lihuisong (C) 写道:
> >> Hi Rafael,
> >>
> >> kindly ping.
> >>
> >>
> >> 在 2023/8/1 17:38, Sudeep Holla 写道:
> >>> Hi Rafael,
> >>>
> >>> On Tue, Aug 01, 2023 at 02:38:25PM +0800, Huisong Li wrote:
> >>>> PCC supports processing platform notification for slave subspaces and
> >>>> shared interrupt for multiple subspaces.
> >>>>
> >>> These changes have missed last 2 merge window. Let us know if you
> >>> can pull
> >>> this for v6.6 or you prefer to route this via mailbox.
> >>>
> >> .
> >
> > .
>
