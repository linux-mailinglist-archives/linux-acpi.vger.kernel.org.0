Return-Path: <linux-acpi+bounces-13665-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975BCAB1D7A
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 21:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE2F7BC7F1
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E9125E466;
	Fri,  9 May 2025 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="VSftU9+I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C892472BB;
	Fri,  9 May 2025 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820173; cv=none; b=AbG2Z+Jb7BRnURyBNbk2zcx8EH9jFfFRvGGoXa+fzcmgreg9XbEZgl8/ib4Yr0Smbc50r84uzxJEp0K70olWVDnTp/VnqiQdn3dGnQirXlCcnSbLoo8PTpLrySsERuyIigbzQfEx9f8AnhZSb1TVNI5AzfNhTymhPlHf0v5BbSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820173; c=relaxed/simple;
	bh=6AM8e1zl19Mjhm/gIYH4mQ+TqUeWAJH6j93XM/gLqh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ur9HFuROO5MdNTIprDdgnP5hviGeHHQZsRHfI95T3078z2lsHH0Ai1FzYUlYEhPGj6s2zKjyK3pYxgrd2IRE0hqqEo0LsD/AAtKhidGHOWuQPQPI/FOAWV0kttMDPmS6n7rSqQCLgEgeRhwKXXfO53+8idn6ZUgCXY3IEddmDzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=VSftU9+I; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [10.6.0.9] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 320472FC0050;
	Fri,  9 May 2025 21:49:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1746820162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYFU6DhSz8pciFEOp1AuA/iB4zkZWp16pD6o9K/F+90=;
	b=VSftU9+IdGHohpFnPLtRNBvGtKpia9ACHB0IC3lSNrHVzDZlOkWw6Ye9NjOo/4zjwSyjXP
	yqKg/fUrEuFE60yhr7UAkXOtGsE/q8hU8+cQeZp8gsWIlt2Z7ivEpOsWIWKscsLnpJNNBH
	NtBpqeTlpKxGKojkPtDO6awxf3NruMI=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <994476b8-fdc8-4123-ab39-de8f1629c27b@tuxedocomputers.com>
Date: Fri, 9 May 2025 21:49:21 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi/ec: Add device to acpi_ec_no_wakeup qurik
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250508111625.12149-1-wse@tuxedocomputers.com>
 <CAJZ5v0g+_8LT6YKSuOXHtxE-HLCZ2hxKuT2514HgQ45xyWy76A@mail.gmail.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <CAJZ5v0g+_8LT6YKSuOXHtxE-HLCZ2hxKuT2514HgQ45xyWy76A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 09.05.25 um 21:21 schrieb Rafael J. Wysocki:
> On Thu, May 8, 2025 at 1:16 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
>> Add the TUXEDO InfinityBook Pro AMD Gen9 to the acpi_ec_no_wakeup quirk
>> list to prevent spurious wakeups.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> ---
>>   drivers/acpi/ec.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> index 8db09d81918fb..de45a5b59effd 100644
>> --- a/drivers/acpi/ec.c
>> +++ b/drivers/acpi/ec.c
>> @@ -2301,6 +2301,12 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
>>                          DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
>>                  },
>>          },
>> +       {
>> +               // TUXEDO InfinityBook Pro AMD Gen9
>> +               .matches = {
>> +                       DMI_MATCH(DMI_BOARD_NAME, "GXxHRXx"),
>> +               },
>> +       },
>>          { },
>>   };
>>
>> --
> Applied as 6.16 material, thanks!
Forgot to add cc stable but i guess i will just wait till it reaches mainline 
and then send it manually?

