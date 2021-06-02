Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81C73980F3
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 08:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFBGP3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 02:15:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:7801 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhFBGP0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Jun 2021 02:15:26 -0400
IronPort-SDR: bjIxywN+ZVVZEXXegL4hAih71meB7F3AsbRWs4qUdf9UsGub0obFwvmNo1GBkmrhTI0o2Ypb/u
 YeSD8Ij5KakA==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="201850911"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="201850911"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 23:13:43 -0700
IronPort-SDR: TjzNhmbrWjEtYN4NPOpElZ2LxC0q5qeIfjvMZpX7JOTwWUVPnsoGw9/BZNjkYqrUUq3BsHPFSh
 dzmje3bvfxMw==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="479574763"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 23:13:41 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, james.morse@arm.com,
        bp@alien8.de, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] ACPI: APEI: ERST: Fix missing error code in erst_init()
References: <1622545553-19160-1-git-send-email-jiapeng.chong@linux.alibaba.com>
        <202106011259.317BFFAF@keescook>
Date:   Wed, 02 Jun 2021 14:13:38 +0800
In-Reply-To: <202106011259.317BFFAF@keescook> (Kees Cook's message of "Tue, 1
        Jun 2021 13:05:15 -0700")
Message-ID: <87fsy0aj59.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, Jun 01, 2021 at 07:05:53PM +0800, Jiapeng Chong wrote:
>> The error code is missing in this code scenario, add the error code
>> '-EINVAL' to the return value 'rc'.
>> 
>> Eliminate the follow smatch warning:
>> 
>> drivers/acpi/apei/erst.c:1114 erst_init() warn: missing error code 'rc'.
>> 
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>
> Is this a bug? I can't tell if this is meant to be a "silent" failure,
> like with acpi_disabled, erst_disabled, etc.
>
> If it _is_ a bug, then please include:
>
> Fixes: a08f82d08053 ("ACPI, APEI, Error Record Serialization Table (ERST) support")
>
> -Kees
>
>> ---
>>  drivers/acpi/apei/erst.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
>> index 242f3c2..492d499 100644
>> --- a/drivers/acpi/apei/erst.c
>> +++ b/drivers/acpi/apei/erst.c
>> @@ -1110,9 +1110,10 @@ static int __init erst_init(void)
>>  
>>  	status = acpi_get_table(ACPI_SIG_ERST, 0,
>>  				(struct acpi_table_header **)&erst_tab);
>> -	if (status == AE_NOT_FOUND)
>> +	if (status == AE_NOT_FOUND) {
>> +		rc = -EINVAL;

I don't think this is necessary.  It isn't an error not to have ERST
table in a machine.

Best Regards,
Huang, Ying

>>  		goto err;
>> -	else if (ACPI_FAILURE(status)) {
>> +	} else if (ACPI_FAILURE(status)) {
>>  		const char *msg = acpi_format_exception(status);
>>  		pr_err("Failed to get table, %s\n", msg);
>>  		rc = -EINVAL;
>> -- 
>> 1.8.3.1
>> 
