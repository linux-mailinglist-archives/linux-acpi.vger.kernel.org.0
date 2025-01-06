Return-Path: <linux-acpi+bounces-10385-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2439FA025F6
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2025 13:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C223A5A48
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2025 12:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142231DF255;
	Mon,  6 Jan 2025 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMsA9zVJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99541DED79
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jan 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736167663; cv=none; b=bgiDx8gzkAOxK7GHJ70+woUeF+BY9f5YT+pZCXKYs1UJn4fB4FUEY8YPuVmMUMC17NOdPUmvxdqGA96ZUQNC4DiwyBzUlcbFPhFOPNsVUOhA2cZT5+yhYPNoW5UgK/8rM4DWeC6xHY+/LmmqQB4UI+BuzggTy6287zyKeuQShwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736167663; c=relaxed/simple;
	bh=cKNc9KoYETCeTPuJLTqCyQX106fXhXFr33sir8gG/24=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tqOccCZSS1O4N7PdkRbPWPuFMfP5t+XUDvUwxKyWKVFfWk+DSWDIgE7O7/3nrF3ZZp65bjAuzRzLZhoc+9DrGwsinQ+u+niY2h/sfdsXuIZ0Dq/Huoc17KjeQuZYIgcycwMES1Trluu4XMy0afMIKAvW8GsjpnmBV1vdWOq+pMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMsA9zVJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736167660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dkb+rY3M+7dZ1Zo79DORBPQFm2iH+/jBnX4+iKG/QsU=;
	b=bMsA9zVJB5upzqfO8/b3oKPNF6WY4/1BGkrL5O19rTm89vhWmyMUWPi5ZL+9NSshTbLjOX
	gxOCNs5UoLE4l66dW7HVMd/MMR5xHwqq/hTtEs/CoJtk39LJYEaDRa0zdBBM+UqSnYra38
	GjaNWHkI3FsrzlnIHTfdfXAjTXBhvRA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-NIfE1FERNwSk7HELHZKIdw-1; Mon, 06 Jan 2025 07:47:38 -0500
X-MC-Unique: NIfE1FERNwSk7HELHZKIdw-1
X-Mimecast-MFC-AGG-ID: NIfE1FERNwSk7HELHZKIdw
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aaf901a0ef9so343287966b.0
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jan 2025 04:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736167657; x=1736772457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dkb+rY3M+7dZ1Zo79DORBPQFm2iH+/jBnX4+iKG/QsU=;
        b=D3BlhVGv+D66CZsLpRyv7ufyl7VAilggZUGOtiuO58ehQn1lrjUGhINUISg8ZxWy8F
         8JGxTS63TANvB2m9JGnYPYO9WK3Y834INZbJN+NHZYXgfl96Bn5lKIp6KF25rX6ren+M
         Qt0+c8IiBsFNPWp7828uK+KGaChKJc/DdkNFUr1KgOYHGcbjcV+oiQEhe2xAdz0/kcdh
         xwv+dRThJ/DK2sa191Kec6kiiN7ZWXN7SJ7pguiebR0Sisrn08W3tngN3FtJJvm4jiNg
         CLICmjdnIVkX6QVodEl4lcq1r3dYoIsqPxG4BAHCiOuBt8/xc+lBvmPimZ14oA2vLdph
         O5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVKmq5S913KIsgbW+z/v+Ov2NGbkCiF3Bsd4Y5uoqPk9L9hOXwTt/ciGaqXNZwTjdK+BdYmJJJf0aPZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27KkNNEP3egjgQfgLqFeu3iWKNh4LXmAQCzB7R7OhXcRsKK+8
	Va/lecT1nnjvqVc+IhplIw9aI2QYrAudWWtE7MMeTvfH15EU6qy9FAwFfhKeWcBxrghfMyaz6qm
	JBwIu0IO8UYCX4hRsjnZ/or2AaAiINocc44fRmCYDAxbC1CpOBfYK8ha52Lg=
X-Gm-Gg: ASbGncvW+Yhb/Z1E2+5SoOnKcP/VP62EHevJ0WhaWyvpXHu23qiOypN8I+zxrwKD6e4
	Uomy9q0mJyCOr5ICukPPbCEzWhognOE3ALAyRbN45WBawDHPEZbSPMRvsPAG8hRWl17g5CUUAGX
	2xgcgj9WA7Jq6YBi93GeoRokKZBH3PhK5F3TFow7Hqor3FzoGrFOZD6rexyD5ZqbtZg3EO6EM88
	J5UTBeYt0s14Oc8x1XFnomPcjKz0JtfThd1SP3C5tQfJnt90vJC2hWIbXIHTec=
X-Received: by 2002:a17:907:3f9e:b0:aa6:7f99:81aa with SMTP id a640c23a62f3a-aac2d446f68mr4754742566b.6.1736167657220;
        Mon, 06 Jan 2025 04:47:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2ZtMJkNlBqhQHyaJJvhOgi94/VowQ89yDD5sfDE7wLG6cS+OJlemHSlP0Pxsa12YGeTk1xw==
X-Received: by 2002:a17:907:3f9e:b0:aa6:7f99:81aa with SMTP id a640c23a62f3a-aac2d446f68mr4754741066b.6.1736167656855;
        Mon, 06 Jan 2025 04:47:36 -0800 (PST)
Received: from [192.168.245.203] ([109.37.140.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e830af1sm2241780866b.14.2025.01.06.04.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 04:47:36 -0800 (PST)
Message-ID: <f46c5c52-b49a-433b-81cb-ae1e5d5d3ed7@redhat.com>
Date: Mon, 6 Jan 2025 13:47:35 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: resource: Add Asus Vivobook X1504VAP to
 irq1_level_low_skip_override[]
To: Gustavo Azor <gazo11@mail.com>, bugzilla-daemon@kernel.org,
 jwrdegoede@fedoraproject.org, linux-acpi@vger.kernel.org,
 stable@vger.kernel.org, rafael@kernel.org
References: <trinity-13f8fb07-bab6-4449-acb7-77c6d708cc37-1735365047718@3c-app-mailcom-lxa14>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <trinity-13f8fb07-bab6-4449-acb7-77c6d708cc37-1735365047718@3c-app-mailcom-lxa14>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gustavo,

Most of us have taken 2 weeks off around Christmas + New year.

Normal kernel patch review processes should be starting up again now,
so some patience please and then this patch should be merged soon.

Regards,

Hans



On 28-Dec-24 6:50 AM, Gustavo Azor wrote:
> 
> 
>  
> 
> Estimated people:
> Seems to me, I browse drivers/acpi/resources.c: the patch was not included in kernel versions stable 6.12.7 or long term 6.6.68.
> I hope will be include in mainline 6.13.-rc5 to inform if work in the ASUS Vivobook 15 X1504VAP_X1504VA keyboard.
> I have not idea how work with git diff or compiling kernels to try the patch, and need to try in installed kernel.
> Thanks.Regards.
> 
> Sent: Friday, December 20, 2024 at 8:23 PM
> From: bugzilla-daemon@kernel.org
> To: gazo11@mail.com
> Subject: [Bug 219224] Laptop Internal Keyboard not working on ASUS VivoBook E1404GA on ubuntu 24.04.
> https://bugzilla.kernel.org/show_bug.cgi?id=219224
> 
> --- Comment #11 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
> (In reply to gazo11 from comment #10)
>> Hello I have the same problem for dmidecode:
>>
>>
>> System Information
>> Manufacturer: ASUSTeK COMPUTER INC.
>> Product Name: ASUS Vivobook 15 X1504VAP_X1504VA
>> Version: 1.0
>> Serial Number: S1N0CV02L86302G
>> UUID: cdc508f0-d3f1-f743-bce4-5eb9d4c06fda
>> Wake-up Type: Power Switch
>> SKU Number:
>> Family: ASUS Vivobook 15
>>
>> Its possible to get this model listed in future kernels? Thanks!
> 
> Thank you for reporting this, I've submitted a patch to add this to the
> irq1_level_low_skip_override[] list:
> 
> https://lore.kernel.org/linux-acpi/20241220181352.25974-1-hdegoede@redhat.com/[https://lore.kernel.org/linux-acpi/20241220181352.25974-1-hdegoede@redhat.com/]
> 
> --
> You may reply to this email to add a comment.
> 
> You are receiving this mail because:
> You are on the CC list for the bug.
> 


