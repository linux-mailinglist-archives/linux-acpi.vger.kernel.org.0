Return-Path: <linux-acpi+bounces-13645-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C622AAFEF9
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 17:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD8C1B4357F
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475C722AE65;
	Thu,  8 May 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="UXmAMz62"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0AD2797A1
	for <linux-acpi@vger.kernel.org>; Thu,  8 May 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717149; cv=none; b=uUQQgA7RLY6JoJiMsHBDUTXBksvHuHl2Gh8P46v+6oEovYAU07QpcbNBhAUPjAPoZs0k9HXaUWbOuQoCQHfjQR8CXyzhakQKV1Tzots0VBOi4EZYstKbKG5zU50RantcX9ffZFNmNa1T5sJJiEXbHZMx7H0HRtXgEXJv3viv4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717149; c=relaxed/simple;
	bh=5/2pypVm4lwsU5ymbD+hU4e7DKfSVOUl3zhaH7yP1+Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sqQnaKfvDshGxkCeQMwtWNQVhK10n6Bccc5iOURtQypCdJlG/9Kc/U2jk1+FyOCCzO/WywymnZAMKCGsbqmNjLl4/n6kN/8hNAndxV6Y+ZZygU/Y7TswTHiw/2laMZ5r/ENG+gspJbLTLq6AYFO979w8UHVJh0gh5Oza9H/ZUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=UXmAMz62; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250508151214cdc7ac71dabe41de24
        for <linux-acpi@vger.kernel.org>;
        Thu, 08 May 2025 17:12:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uftzIXqC64HEGiRyuY9ElhNCZUYKd/Y/wyxroPYE6ng=;
 b=UXmAMz626eeoPOPP7HQs6gkM8vahr/Lrzcclaj2AWesCVLhTpF0XOvnVLF38SU61ybw8l0
 8/br3R9xnAWyM/krI+kzelPavVfTte2RtGGre8djj9Q97Duvwm24B6d9pQHg1IyNEFgDpE5Z
 WkZQRsKf1kvsRub3qDuwvHkMzkPMvhFON5XNkrAOb2MqrzDxtiw6FhnEMcF3EsShmc55nXNw
 3kBtksKGeIpRJpZWLRXg8IGpqyORLVEztcFEIXU57o5maF+Xj4tcw80oWkvgtP5PzOp+/hbh
 IP6cei7gNvIARgg3EZQ1D5vRr/1UsshwKFvTevTZCENnP5K1R1Sq5Etg==;
Message-ID: <0fb49864-9c93-482b-b016-150357d9b2a7@siemens.com>
Date: Thu, 8 May 2025 16:12:13 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] watchdog: Add driver for Intel OC WDT
From: Diogo Ivo <diogo.ivo@siemens.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com,
 benedikt.niedermayr@siemens.com
References: <20250317-ivo-intel_oc_wdt-v3-0-32c396f4eefd@siemens.com>
 <20250317-ivo-intel_oc_wdt-v3-1-32c396f4eefd@siemens.com>
 <daeedd95-1d4a-4d17-baa1-9c1580095de9@siemens.com>
Content-Language: en-US
In-Reply-To: <daeedd95-1d4a-4d17-baa1-9c1580095de9@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

Hello,

On 4/8/25 9:31 AM, Diogo Ivo wrote:
> Hello,
> 
> On 3/17/25 10:55 AM, Diogo Ivo wrote:
>> Add a driver for the Intel Over-Clocking Watchdog found in Intel
>> Platform Controller (PCH) chipsets. This watchdog is controlled
>> via a simple single-register interface and would otherwise be
>> standard except for the presence of a LOCK bit that can only be
>> set once per power cycle, needing extra handling around it.
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>> ---
>> v2->v3:
>>   - Collect R-b from Guenter
>>
>> v1->v2:
>>   - Split v1 into two patches, adding the ACPI IDs in a separate patch
>>   - Initialize hearbeat module parameter to zero
>>   - Clarify wording around lock handling
>>   - Properly print resource with %pR when failing to obtain it
>>   - Enable compile testing and add dependency on HAS_IOPORT
>>   - Drop unneeded ACPI_PTR() and MODULE_ALIAS()
>> ---
>> ---
>>   drivers/watchdog/Kconfig        |  11 ++
>>   drivers/watchdog/Makefile       |   1 +
>>   drivers/watchdog/intel_oc_wdt.c | 233 ++++++++++++++++++++++++++++++ 
>> ++++++++++
>>   3 files changed, 245 insertions(+)
>>
> 
> Gentle ping on this patch.

Another ping on this patch. Is there anything missing from my side
blocking this?

Best regards,
Diogo

