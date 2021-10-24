Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157604387C6
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Oct 2021 11:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhJXJNG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 24 Oct 2021 05:13:06 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:35080 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229463AbhJXJNG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 24 Oct 2021 05:13:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UtQxvjU_1635066642;
Received: from B-J4ZXMD6R-0327.local(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0UtQxvjU_1635066642)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Oct 2021 17:10:43 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v2] ACPI, APEI, EINJ: Relax platform response timeout to 1
 second.
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        bp@alien8.de, james.morse@arm.com, lenb@kernel.org,
        rjw@rjwysocki.net, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
References: <20211015033817.16719-1-xueshuai@linux.alibaba.com>
 <20211022134424.67279-1-xueshuai@linux.alibaba.com>
 <YXNPSQT9LnxiyVFC@agluck-desk2.amr.corp.intel.com>
Message-ID: <777aca99-b076-5bd7-03e3-f12ef9e7edd0@linux.alibaba.com>
Date:   Sun, 24 Oct 2021 17:10:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YXNPSQT9LnxiyVFC@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Tony,

Thank you for your comments.

> I know I pointed you to msleep() ... sorry, I was wrong. For a
> 1 ms sleep the recommendation is to use usleep_range()
>
> See this write-up in Documentation/timers/timers-howto.rst:
>
>                - Why not msleep for (1ms - 20ms)?
>                        Explained originally here:
>                                https://lore.kernel.org/r/15327.1186166232@lwn.net
>
>                        msleep(1~20) may not do what the caller intends, and
>                        will often sleep longer (~20 ms actual sleep for any
>                        value given in the 1~20ms range). In many cases this
>                        is not the desired behavior.
>
> To answer the question posed in that document on "What is a good range?"
>
> I don't think injection cares too much about precision here. Maybe go
> with
>
>	usleep_range(1000, 5000);
> [with #defines for SLEEP_UNIT_MIN, SLEEP_UNIT_MAX instead of those
> numbers]
Got it. Thank you. I will change it latter.


>> +/* Firmware should respond within 1 seconds */
>> +#define FIRMWARE_TIMEOUT	(1 * MSEC_PER_SEC)
>>  #define ACPI5_VENDOR_BIT	BIT(31)
>>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>> @@ -40,6 +40,8 @@
>>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
>>   */
>>  static int acpi5;
>> +static int timeout_default = FIRMWARE_TIMEOUT;
>> +module_param(timeout_default, int, 0644);
>
> You've set the default to 1 second. Who would use this parameter?
> Do you anticipate systems that take even longer to inject?
> A user might set a shorter limit ... but I don't see why they
> would want to.
No, I don't. EINJ provides a hardware error injection mechanism to develop
and debug firmware code and hardware RAS feature. While we test on Arm
platform, it cannot meet the original timeout limit. Therefore, we send
this patch to relax the upper bound of timeout. In order to facilitate
other platforms to encounter the same problems, we expose timeout as a
configurable parameter in user space.


>>  struct set_error_type_with_address {
>>  	u32	type;
>> @@ -171,12 +173,12 @@ static int einj_get_available_error_type(u32 *type)
>>
>>  static int einj_timedout(u64 *t)
>>  {
>> -	if ((s64)*t < SPIN_UNIT) {
>> +	if ((s64)*t < SLEEP_UNIT) {
>>  		pr_warn(FW_WARN "Firmware does not respond in time\n");
>>  		return 1;
>>  	}
>> -	*t -= SPIN_UNIT;
>> -	ndelay(SPIN_UNIT);
>> +	*t -= SLEEP_UNIT;
>> +	msleep(SLEEP_UNIT);
>>  	touch_nmi_watchdog();
>
> Since we are sleeping instead of spinning, maybe we don't need to
> touch the nmi watchdog?
Agree. I will delete it in next version.

Regards,
Shuai

On 2021/10/23 AM7:54, Luck, Tony wrote:
> On Fri, Oct 22, 2021 at 09:44:24PM +0800, Shuai Xue wrote:
>> When injecting an error into the platform, the OSPM executes an
>> EXECUTE_OPERATION action to instruct the platform to begin the injection
>> operation. And then, the OSPM busy waits for a while by continually
>> executing CHECK_BUSY_STATUS action until the platform indicates that the
>> operation is complete. More specifically, the platform is limited to
>> respond within 1 millisecond right now. This is too strict for some
>> platforms.
>>
>> For example, in Arm platform, when injecting a Processor Correctable error,
>> the OSPM will warn:
>>     Firmware does not respond in time.
>>
>> And a message is printed on the console:
>>     echo: write error: Input/output error
>>
>> We observe that the waiting time for DDR error injection is about 10 ms
>> and that for PCIe error injection is about 500 ms in Arm platform.
>>
>> In this patch, we relax the response timeout to 1 second and allow user to
>> pass the time out value as a argument.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>> Changelog v1 -> v2:
>> - Implemented the timeout in msleep instead of udelay.
>> - Link to the v1 patch: https://lkml.org/lkml/2021/10/14/1402
>> ---
>>  drivers/acpi/apei/einj.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>> index 133156759551..e411eb30e0ee 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj.c
>> @@ -28,9 +28,9 @@
>>  #undef pr_fmt
>>  #define pr_fmt(fmt) "EINJ: " fmt
>>  
>> -#define SPIN_UNIT		100			/* 100ns */
>> -/* Firmware should respond within 1 milliseconds */
>> -#define FIRMWARE_TIMEOUT	(1 * NSEC_PER_MSEC)
>> +#define SLEEP_UNIT		1			/* 1ms */
> 
> I know I pointed you to msleep() ... sorry, I was wrong. For a
> 1 ms sleep the recommendation is to use usleep_range()
> 
> See this write-up in Documentation/timers/timers-howto.rst:
> 
>                 - Why not msleep for (1ms - 20ms)?
>                         Explained originally here:
>                                 https://lore.kernel.org/r/15327.1186166232@lwn.net
> 
>                         msleep(1~20) may not do what the caller intends, and
>                         will often sleep longer (~20 ms actual sleep for any
>                         value given in the 1~20ms range). In many cases this
>                         is not the desired behavior.
> 
> To answer the question posed in that document on "What is a good range?"
> 
> I don't think injection cares too much about precision here. Maybe go
> with
> 
> 	usleep_range(1000, 5000);
> [with #defines for SLEEP_UNIT_MIN, SLEEP_UNIT_MAX instead of those
> numbers]
> 
>> +/* Firmware should respond within 1 seconds */
>> +#define FIRMWARE_TIMEOUT	(1 * MSEC_PER_SEC)
>>  #define ACPI5_VENDOR_BIT	BIT(31)
>>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>> @@ -40,6 +40,8 @@
>>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
>>   */
>>  static int acpi5;
>> +static int timeout_default = FIRMWARE_TIMEOUT;
>> +module_param(timeout_default, int, 0644);
> 
> You've set the default to 1 second. Who would use this parameter?
> Do you anticipate systems that take even longer to inject?
> A user might set a shorter limit ... but I don't see why they
> would want to.
> 
>>  
>>  struct set_error_type_with_address {
>>  	u32	type;
>> @@ -171,12 +173,12 @@ static int einj_get_available_error_type(u32 *type)
>>  
>>  static int einj_timedout(u64 *t)
>>  {
>> -	if ((s64)*t < SPIN_UNIT) {
>> +	if ((s64)*t < SLEEP_UNIT) {
>>  		pr_warn(FW_WARN "Firmware does not respond in time\n");
>>  		return 1;
>>  	}
>> -	*t -= SPIN_UNIT;
>> -	ndelay(SPIN_UNIT);
>> +	*t -= SLEEP_UNIT;
>> +	msleep(SLEEP_UNIT);
>>  	touch_nmi_watchdog();
> 
> Since we are sleeping instead of spinning, maybe we don't need to
> touch the nmi watchdog?
> 
>>  	return 0;
>>  }
>> @@ -403,7 +405,7 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  			       u64 param3, u64 param4)
>>  {
>>  	struct apei_exec_context ctx;
>> -	u64 val, trigger_paddr, timeout = FIRMWARE_TIMEOUT;
>> +	u64 val, trigger_paddr, timeout = timeout_default;
>>  	int rc;
>>  
>>  	einj_exec_ctx_init(&ctx);
>> -- 
>> 2.20.1.12.g72788fdb
>>
> 
> -Tony
> 
