Return-Path: <linux-acpi+bounces-174-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C47AF824
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 04:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 130A7B207CD
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 02:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357463B6
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 02:30:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA61878
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 02:11:25 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9940876B8;
	Tue, 26 Sep 2023 19:11:24 -0700 (PDT)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RwKjx1bScztSyl;
	Wed, 27 Sep 2023 10:07:01 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm000004.china.huawei.com
 (7.193.23.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 27 Sep
 2023 10:11:22 +0800
Message-ID: <9497cf31-09b9-b083-bbe8-84307178b20a@huawei.com>
Date: Wed, 27 Sep 2023 10:11:21 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/3] ACPI: PCC: Define and use the common PCC shared
 memory regions related macros
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-hwmon@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andi Shyti
	<andi.shyti@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
	<linux@roeck-us.net>, <lihuisong@huawei.com>
References: <20230926-pcc_defines-v1-0-0f925a1658fd@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230926-pcc_defines-v1-0-0f925a1658fd@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000004.china.huawei.com (7.193.23.18)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Sudeep,

Could you please use these new common macros for kunpeng_hccs?

在 2023/9/26 20:27, Sudeep Holla 写道:
> This set of 3 small patches intend to consolidate and replace the existing
> locally defined macros within couple of PCC client drivers when accessing
> the command and status bitfields.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> Sudeep Holla (3):
>        ACPI: PCC: Add PCC shared memory region command and status bitfields
>        i2c: xgene-slimpro: Migrate to use generic PCC shmem related macros
>        hwmon: (xgene) Migrate to use generic PCC shmem related macros
>
>   drivers/hwmon/xgene-hwmon.c            | 16 +++++-----------
>   drivers/i2c/busses/i2c-xgene-slimpro.c | 16 ++++------------
>   include/acpi/pcc.h                     | 11 +++++++++++
>   3 files changed, 20 insertions(+), 23 deletions(-)
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230926-pcc_defines-24be5e33b6f3
>
> Best regards,

