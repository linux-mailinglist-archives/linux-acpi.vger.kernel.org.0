Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC4D725CF4
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jun 2023 13:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbjFGLUn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Jun 2023 07:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbjFGLUj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jun 2023 07:20:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DFE198B;
        Wed,  7 Jun 2023 04:20:24 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qbkv7693fzTkyq;
        Wed,  7 Jun 2023 19:02:11 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 19:02:32 +0800
Subject: Re: [PATCH 0/3 v2] Update ACPI documentation for Arm systems
To:     Jose Marinho <jose.marinho@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        James Morse <James.Morse@arm.com>,
        Rob Herring <Rob.Herring@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <20230606093528.1494344-1-jose.marinho@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <ea79719a-d210-517e-f781-7d54e1a6b0ed@huawei.com>
Date:   Wed, 7 Jun 2023 19:02:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20230606093528.1494344-1-jose.marinho@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023/6/6 17:35, Jose Marinho wrote:
> This set of patches updates the Linux kernel ACPI documentation for Arm
> systems. The intent is to integrate the developments in the BBR
> specification that happened over the last couple of years.
> 
> Cc: Catalin Marinas<catalin.marinas@arm.com>
> Cc: Jeremy Linton<Jeremy.Linton@arm.com>
> Cc: James Morse<James.Morse@arm.com>
> Cc: Rob Herring<Rob.Herring@arm.com>
> Cc: Will Deacon<will@kernel.org>
> Cc: Jonathan Corbet<corbet@lwn.net>
> Cc: Hanjun Guo<guohanjun@huawei.com>
> Cc:linux-arm-kernel@lists.infradead.org
> Cc:linux-doc@vger.kernel.org
> Cc:linux-acpi@vger.kernel.org
> 
> v2:
>   - Clarify that the RAS tables are conditionaly required when ACPI
>     Platform Error Interfaces are required: Hanjun Guo.
>   - Clarify that HMAT is required if NUMA is supported and the system
>     contains heterogeneous memory: Hanjun Guo.

Thanks for updating the document,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
