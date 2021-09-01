Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89F73FD151
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Sep 2021 04:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241399AbhIAC2Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Aug 2021 22:28:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14442 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241128AbhIAC2Y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Aug 2021 22:28:24 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gznsv3fwwzbfZQ;
        Wed,  1 Sep 2021 10:23:31 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 10:27:26 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 1 Sep 2021 10:27:26 +0800
Subject: Re: [PATCH] acpi/arm64: fix next_platform_timer() section mismatch
 error
To:     Jackie Liu <liu.yun@linux.dev>, <lorenzo.pieralisi@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <liuyun01@kylinos.cn>
References: <7f29a149-e005-f13f-2cc4-a9eb737107e1@huawei.com>
 <20210823092526.2407526-1-liu.yun@linux.dev>
 <fc62139f5128ee8d0de0bc39030ca80f@linux.dev>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <002b6ef7-b427-b650-6222-d284f78f2d0b@huawei.com>
Date:   Wed, 1 Sep 2021 10:27:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <fc62139f5128ee8d0de0bc39030ca80f@linux.dev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/8/31 18:11, Jackie Liu wrote:
> Friendly ping...

Lorenzo, would you mind take this patch?

Thanks
Hanjun
