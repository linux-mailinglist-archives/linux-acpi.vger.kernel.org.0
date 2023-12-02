Return-Path: <linux-acpi+bounces-2088-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2ED801D45
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 15:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9969A1F2117B
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194DF18B19
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKEHYoXS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C39A9C
	for <linux-acpi@vger.kernel.org>; Sat,  2 Dec 2023 04:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701520998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h4DJq4T+U4J3l6LPK0uojmAyF6LfoimHRqrF4QgIogY=;
	b=OKEHYoXSRhDkPNBwOtE/s+9Cez9NGZIjpKPk/7dvosdaftNhFGbWiJ5nxkQmet94Q8783E
	Yn1hc35P++Z7CWksuPxwPqD0BvMNHIKnCHfJ5XDKlSnaLrXd+M52IMc+6bvgm+c1jfzPPn
	eIOmiyuEseT+sopcbhoHuKTzfdNOnwc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-tl7W2rPjOAK6_1eUU2ktdw-1; Sat, 02 Dec 2023 07:43:15 -0500
X-MC-Unique: tl7W2rPjOAK6_1eUU2ktdw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a114f099bebso271446366b.2
        for <linux-acpi@vger.kernel.org>; Sat, 02 Dec 2023 04:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701520994; x=1702125794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4DJq4T+U4J3l6LPK0uojmAyF6LfoimHRqrF4QgIogY=;
        b=qdISrhkVMkW1krGFbchCEssVyE3HSbcHd3xtH9dQ4clbMS7DIpE7cCbT8ilgZLIasg
         hTDao9rKK+4TOHnsamq3A1qk7lkdGOmg8CDkUDbtgxzSiNLTR37Vs1sGUAXbLFS/JSKm
         D8rx11nuVPOQ+vxSGszFe/pFDGx80HUIO0DR3/DJMyCt8rBx7mCH8iQr5ZvkO7Xub9NE
         fD05SSu2X9Rv6MHUGl4IBcDH+zYNANxFLNQmbH8qC9UcSWzJj91MttJV6b1Y8WiqCq7o
         di6YNW++aU2nvah/V3fdprMwtlRX29aBLW+EFKgtLMbbjdTfDve6PFRUbFeGXR5Zwz5L
         b//Q==
X-Gm-Message-State: AOJu0Yz6woipnOedy+PvCMyro6duerNdzuxpB7ZZz6/zIV4ng5XkLtPc
	D+4L6Mlm87/GmyPmuuotOWMD/bUWhhj1z55W9clnXEIddV0M3d8Vd0x2Jy0Qn3iQk/SFEDDsTXL
	OjtkoewlbDCkHdSaYvnTVRA==
X-Received: by 2002:a17:906:d295:b0:a19:a19b:55f6 with SMTP id ay21-20020a170906d29500b00a19a19b55f6mr1716432ejb.134.1701520994694;
        Sat, 02 Dec 2023 04:43:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkw8ECvyYB005RuSFu+FKenCisiOosr0lIXRvYlHHyXKgGxBCWlDX8Hlv33kA9TEyha+zm5A==
X-Received: by 2002:a17:906:d295:b0:a19:a19b:55f6 with SMTP id ay21-20020a170906d29500b00a19a19b55f6mr1716421ejb.134.1701520994397;
        Sat, 02 Dec 2023 04:43:14 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m25-20020a170906235900b009fcb10eecb2sm2985850eja.84.2023.12.02.04.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 04:43:13 -0800 (PST)
Message-ID: <61ef73e6-e633-47e1-b599-ee66aa179227@redhat.com>
Date: Sat, 2 Dec 2023 13:43:13 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] ACPI: OSL: acpi_os_execute() improvements
Content-Language: en-US, nl
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Michal Wilczynski <michal.wilczynski@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <3281896.aeNJFYEL58@kreacher>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3281896.aeNJFYEL58@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/29/23 14:45, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This series improves acpi_os_execute() on top of
> 
> https://patchwork.kernel.org/project/linux-acpi/patch/5745568.DvuYhMxLoT@kreacher/
> 
> but only the last patch really depends on it.
> 
> The first two patches clean up the code somewhat and the third one modifies
> the function to allow Notify () handlers to run on all CPUs (not on CPU0 only).
> 
> The last patch changes it to use GFP_KERNEL for memory allocations, as it does
> not run in interrupt context any more after the change linked above.

I have added this series, as well as the preceding
"ACPI: OSL: Use a threaded interrupt handler for SCI"
patch to my personal tree now, so that it will get tested on various
devices when I run my personal tree on them.

I'll let you know if I hit any issues caused by this series.

Regards,

Hans



