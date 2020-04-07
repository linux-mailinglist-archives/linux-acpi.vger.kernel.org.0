Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8001A0485
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Apr 2020 03:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDGBc5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Apr 2020 21:32:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12681 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbgDGBc5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Apr 2020 21:32:57 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B0ADEB2D00854CFD018B;
        Tue,  7 Apr 2020 09:32:53 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.195) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Apr 2020
 09:32:48 +0800
Subject: Re: [Devel] Re: [PATCH] ACPICA: make acpi_gbl_next_cmd_num static
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
References: <20200403064712.26746-1-yanaijie@huawei.com>
 <CAJZ5v0gHsUMS+LciZnzC12=QO+hsVkeQWHDR1LC8PMCxoWvtAQ@mail.gmail.com>
 <CY4PR11MB1719914B52CC92F25827F99CF0C20@CY4PR11MB1719.namprd11.prod.outlook.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <7a7a7582-d94d-8560-adb1-c5323101d696@huawei.com>
Date:   Tue, 7 Apr 2020 09:32:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CY4PR11MB1719914B52CC92F25827F99CF0C20@CY4PR11MB1719.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.195]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



ÔÚ 2020/4/7 2:30, Kaneda, Erik Ð´µÀ:
> Hi Jason,
> 
> This variable is being used in other parts of the code base so I made an adjustment here:https://github.com/acpica/acpica/pull/582
> Once this pull request gets merged, we'll do a release and resubmit this change to Linux upstream.

Got it, thanks.

Jason

