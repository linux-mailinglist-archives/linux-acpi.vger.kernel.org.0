Return-Path: <linux-acpi+bounces-2178-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EA18077B6
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 19:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6E22820E3
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 18:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3443E41865
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Dus5xfvC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCFCD51
	for <linux-acpi@vger.kernel.org>; Wed,  6 Dec 2023 08:37:36 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D74D33F442
	for <linux-acpi@vger.kernel.org>; Wed,  6 Dec 2023 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701880654;
	bh=Zi682t5K7EyE6/V/tMw8fdaNtybN1Zt94trKteMb2ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Dus5xfvCGTSVwTXHnaJehUfoNjDrBwMxrLb2oaTpoeAOfk8HPtqMgWEt56B1ZG/IR
	 jE8/j1YTcdXAQaJpV6i9pYvj15ywSB+kuSsCQb/jgGnGDDVmc96AQcxmpzRdcmuNlo
	 MbRXgr/tiuMo8W1BtjI6KnuxINNPRVBYh2ijZ1Elo+wsJpOvLxopX6SSBWZ648Aw91
	 MzTBpj8oJsHLcU3sJMs2ccE8qqKCZw6/+3AQYLRe5WC21Zy9KrsW5OOjnBZnTz+C7g
	 YVMsdfOgqr3UIyb/KxH4kbz5gfGwVJcKH1sB5EdbAO5VAkiX7iKj5JCPdjZl07gtVc
	 MnV1bfT6wMkgQ==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c032abab6so37346315e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 06 Dec 2023 08:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880654; x=1702485454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zi682t5K7EyE6/V/tMw8fdaNtybN1Zt94trKteMb2ew=;
        b=jY14B5iv4kWbWMoBYgQJaig7MVhrrHmUO1iNVsE2BVz/ay0MnNCkHIscD8fZ2GYavw
         WeCrz7TJ7ax0S0QI7tm6q4ChIyZhazdkkOxiO4QT8gMG4rW7h7+DZIznnrqd4FWB2NHp
         yE1FnhZ+jj2tgihnYtDAl0OX1Ly3If32J7wPrlYLT5X06jXjVX1/Fu4ZO/S4sb0rRXcI
         9QIhFOlfm8RAXQZe7M2y0hnuDbIKGzbAN5oZ5fP+CaO0XrOeISEcGhGq9HO3KUFl3Yzs
         tkKvtouKqCFUr4wjB51Wucn75eM8kiW9dlyyoZ3OVyPn/P6CV6giMea4ZpUMzqGgazv6
         1bPA==
X-Gm-Message-State: AOJu0YwvIUgf6gWpLvO8+7iYqNQ7Ps8ZDoBThVzKiGMndAw/YSNX2x57
	zpLDvtKriPQN50yP0i3mJZEmEO7R0ENEKKmZxIrjq0LOaXX+dS6czF0tAlt2z3GvkJTz6bn6Mni
	bVtlWSYiC2JSgiyR/EwcPKYqrqpacjgZjOZtscpE=
X-Received: by 2002:a05:600c:1c1d:b0:40c:1c2a:ee6e with SMTP id j29-20020a05600c1c1d00b0040c1c2aee6emr538669wms.61.1701880654317;
        Wed, 06 Dec 2023 08:37:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMgacecIbMy3255zcVF0NByF8i+K7PORe5RRs8XOmBlXXH3pVjexVFuK5qZmbqjxuH1mYOYw==
X-Received: by 2002:a05:600c:1c1d:b0:40c:1c2a:ee6e with SMTP id j29-20020a05600c1c1d00b0040c1c2aee6emr538664wms.61.1701880653964;
        Wed, 06 Dec 2023 08:37:33 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b0040b4c7e1a65sm214908wmq.13.2023.12.06.08.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:37:33 -0800 (PST)
Message-ID: <a3ea149b-adad-4680-bb59-ae460e8eda04@canonical.com>
Date: Wed, 6 Dec 2023 17:37:27 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ACPI: XSDT: struct acpi_table_xsdt must be packed
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231111134827.174908-1-heinrich.schuchardt@canonical.com>
 <CAJZ5v0gGKuBNBvDj2fNMyCvKTrt2SWfusxyaf7W4jvvfL0nxUg@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAJZ5v0gGKuBNBvDj2fNMyCvKTrt2SWfusxyaf7W4jvvfL0nxUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.12.23 17:30, Rafael J. Wysocki wrote:
> On Sat, Nov 11, 2023 at 2:48 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> According to the ACPI 6.5 specification the component Entry starts at
>> offset 36 in the XSDT table which is not a multiple of 8. Hence we must
>> mark the structure as packed.
> 
> There is #pragma pack(1) at the beginning of actbl.h.  Is it not sufficient?

Sorry I missed that pragma.

> 
>> We did not see an error due to the incorrect packing yet as in
>> acpi_tb_parse_root_table() we use ACPI_ADD_PTR() to find the address of
>> Entry.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   include/acpi/actbl.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
>> index 451f6276da49..1a37ac378765 100644
>> --- a/include/acpi/actbl.h
>> +++ b/include/acpi/actbl.h
>> @@ -148,7 +148,7 @@ struct acpi_table_rsdt {
>>   struct acpi_table_xsdt {
>>          struct acpi_table_header header;        /* Common ACPI table header */
>>          u64 table_offset_entry[1];      /* Array of pointers to ACPI tables */
>> -};
>> +} __packed;
>>
>>   #define ACPI_RSDT_ENTRY_SIZE        (sizeof (u32))
>>   #define ACPI_XSDT_ENTRY_SIZE        (sizeof (u64))
>> --
>> 2.40.1
>>


