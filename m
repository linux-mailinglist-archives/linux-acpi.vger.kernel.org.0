Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F68129C51
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2019 02:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfLXBJf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Dec 2019 20:09:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbfLXBJe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Dec 2019 20:09:34 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3493CCB8EFC3D2449AF1;
        Tue, 24 Dec 2019 09:09:33 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 09:09:24 +0800
Subject: Re: [RFC PATCH 2/2] ACPI/IORT: Workaround for IORT ID count "minus
 one" issue
To:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Erik Schmauss <erik.schmauss@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
References: <1577092997-9852-1-git-send-email-guohanjun@huawei.com>
 <1577092997-9852-2-git-send-email-guohanjun@huawei.com>
 <VI1PR0401MB2496B0F77AE0FBF4D24022B4F12E0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <cf662130-e690-d0d8-c678-f0ddb350cef9@huawei.com>
Date:   Tue, 24 Dec 2019 09:08:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB2496B0F77AE0FBF4D24022B4F12E0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019/12/23 20:17, Pankaj Bansal wrote:
> ​
> Can we put a warning of the sort to update the> ACPI table with correct values?

Good point, I will add the firmware bug warning
in iort_check_id_count_workaround().

> eventually i would like that this workaround be removed from
> linux, when sufficient time has passed and all the
> platforms' ACPI tables have been updated.?

I agree with you but it will take much longer time than expected.

Thanks
Hanjun

