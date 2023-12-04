Return-Path: <linux-acpi+bounces-2127-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E7803D2B
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 19:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8401D280F24
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E362D046
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFWapF2a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AD8C6
	for <linux-acpi@vger.kernel.org>; Mon,  4 Dec 2023 08:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701707752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9zFr5Z7rzhpztBFsVSLe9WUlFhYIprACtGJe/dj4Fs=;
	b=VFWapF2aCWTIGpVjwTspfQLU7Vw9qh0avCorSvHRSIQ+3aQ0Rf0LqlIYSzvzh6LsgsUstz
	y6quNpux7dAxmjA0PCs47ySsQqm6Sgadz+mUaa4XtBB8uqtbjjEAVbVlJKrVk51gdadPzy
	5zOzfKxL3vNj+si4ipG6Jz83ufPBpS0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-hU35Wk8LOlWd-ELVByGhqw-1; Mon, 04 Dec 2023 11:35:51 -0500
X-MC-Unique: hU35Wk8LOlWd-ELVByGhqw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5400c8c6392so3529372a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 04 Dec 2023 08:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707750; x=1702312550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9zFr5Z7rzhpztBFsVSLe9WUlFhYIprACtGJe/dj4Fs=;
        b=izp1yduNOXZuqNreWFq4vRW3B93i8G8tx+tbOt08wM5V1w+pNPBgXxY9SNn68nsXlY
         UVgMPhOkwK6lE7qe+6nKnhJpgOGQsXTD/8H+Jbv3iG5qZb0dwTj1w19oa8xG7j7f+p4/
         3x/fU2pRvN1RB4k8SuJjCMtoBCgXUfxsIjy8jFHWd2fYNtwz05p3RUVbv2DZ3N2EffP4
         Dv+nynEVEEQKFZYktFsumH3cxHh/NN5MstdFHLymuxblpr8RDK9Vdcb40/gmDTzBZiv5
         3tmipdNKUQGIqCKCbAqBkmn7wQEXb/OXBtoLdOh7W0iYbyZa5cXweKgVOQZHM+CovYHA
         zdEg==
X-Gm-Message-State: AOJu0Ywy+/IKxA9GeJryhACR2POg4UjppL2BnoOPmyVlHIgqVOdGKyaL
	L9YRurYdd+V8kpZPeJJiTDNeF6dKxd2Q8nrpXdzXdfCxpU6dAjEllsK3h68kzjkv3MhwSNuNt6v
	jKiKGA0sqZXetmp7vHTxTNg==
X-Received: by 2002:a50:d0c3:0:b0:54c:e4fc:3a6 with SMTP id g3-20020a50d0c3000000b0054ce4fc03a6mr783281edf.57.1701707750163;
        Mon, 04 Dec 2023 08:35:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvspMP4litz4PtJIqqNzNDS7Utl2A/0i6mBHzjqm4dZ53/GQNcL+SpJK1ptjLrLe0FmzpJ6A==
X-Received: by 2002:a50:d0c3:0:b0:54c:e4fc:3a6 with SMTP id g3-20020a50d0c3000000b0054ce4fc03a6mr783273edf.57.1701707749900;
        Mon, 04 Dec 2023 08:35:49 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v25-20020a509559000000b0054cacb41abasm2081677eda.60.2023.12.04.08.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:35:49 -0800 (PST)
Message-ID: <de6f1787-8e41-4b5b-a704-bac9cb71c1bf@redhat.com>
Date: Mon, 4 Dec 2023 17:35:49 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] ACPI: OSL: acpi_os_execute() improvements
Content-Language: en-US, nl
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Michal Wilczynski <michal.wilczynski@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <3281896.aeNJFYEL58@kreacher>
 <61ef73e6-e633-47e1-b599-ee66aa179227@redhat.com>
 <CAJZ5v0j1fHebN0w0oYFv0CapkF1XvQ-0xWtQtuLtx0So50hzsw@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0j1fHebN0w0oYFv0CapkF1XvQ-0xWtQtuLtx0So50hzsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 12/4/23 17:32, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> On Sat, Dec 2, 2023 at 3:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 11/29/23 14:45, Rafael J. Wysocki wrote:
>>> Hi Everyone,
>>>
>>> This series improves acpi_os_execute() on top of
>>>
>>> https://patchwork.kernel.org/project/linux-acpi/patch/5745568.DvuYhMxLoT@kreacher/
>>>
>>> but only the last patch really depends on it.
>>>
>>> The first two patches clean up the code somewhat and the third one modifies
>>> the function to allow Notify () handlers to run on all CPUs (not on CPU0 only).
>>>
>>> The last patch changes it to use GFP_KERNEL for memory allocations, as it does
>>> not run in interrupt context any more after the change linked above.
>>
>> I have added this series, as well as the preceding
>> "ACPI: OSL: Use a threaded interrupt handler for SCI"
>> patch to my personal tree now, so that it will get tested on various
>> devices when I run my personal tree on them.
>>
>> I'll let you know if I hit any issues caused by this series.
> 
> As stated here
> 
> https://lore.kernel.org/linux-acpi/CAJZ5v0jkHLGa2XxB4TMqzrBBdZYXY79+sh1Z0ZF6keYdLDyfkg@mail.gmail.com/
> 
> the last patch in this series is not really a good idea just yet, so
> please drop it.

Ack, done.

Regards,

Hans



