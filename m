Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B5112CFE7
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2019 13:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfL3MKG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Dec 2019 07:10:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54964 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727400AbfL3MKG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Dec 2019 07:10:06 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C8FC8D8A95EED0F8C0E1;
        Mon, 30 Dec 2019 20:10:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 30 Dec 2019
 20:09:55 +0800
Subject: Re: [PATCH 1/2] cpufreq : cppc: Break out if we match the HiSilicon
 cppc workaround
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
References: <1577152590-25574-1-git-send-email-guohanjun@huawei.com>
 <2965934.S1MOicRWCW@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <25ced2e7-426b-be14-326f-076e01f9e2e7@huawei.com>
Date:   Mon, 30 Dec 2019 20:10:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <2965934.S1MOicRWCW@kreacher>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019/12/30 6:47, Rafael J. Wysocki wrote:
> On Tuesday, December 24, 2019 2:56:29 AM CET Hanjun Guo wrote:
>> Bail out if we match the OEM information, to save some possible
>> extra iteration. And update the code to fix minor coding style issue.
>>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>> ---
>>  drivers/cpufreq/cppc_cpufreq.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 8d8da76..d0ca300 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -39,7 +39,7 @@
>>  static struct cppc_cpudata **all_cpu_data;
>>  
>>  struct cppc_workaround_oem_info {
>> -	char oem_id[ACPI_OEM_ID_SIZE +1];
>> +	char oem_id[ACPI_OEM_ID_SIZE + 1];
>>  	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
>>  	u32 oem_revision;
>>  };
>> @@ -93,8 +93,10 @@ static void cppc_check_hisi_workaround(void)
>>  	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
>>  		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
>>  		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
>> -		    wa_info[i].oem_revision == tbl->oem_revision)
>> +		    wa_info[i].oem_revision == tbl->oem_revision) {
>>  			apply_hisi_workaround = true;
>> +			break;
>> +		}
>>  	}
>>  }
>>  
>>
> 
> Both this and the [2/2] applies as 5.6 material with reworked
> subjects and changelog changes.  Thanks!

Much better for the reworked subject and changelog, thank
you very much!

Hanjun

