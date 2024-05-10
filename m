Return-Path: <linux-acpi+bounces-5719-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0449D8C21F8
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 12:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E5CBB22DEF
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 10:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39081168AF4;
	Fri, 10 May 2024 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DvxkZq/1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273C165FDC
	for <linux-acpi@vger.kernel.org>; Fri, 10 May 2024 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336510; cv=none; b=egHhmIH6SYdzNLb87WuTcjY6lVSJAi9yv4uHLcIdxYEadanFU7Xp0afEK7ZcqSW25V4ZlSO2Uz1c1zeVsR65ti1tw9iHUqsXrjGUUUE1NmCiOuLysEN7355MgyM6ow7sdehlMHi7O51+wQGlhfJv5zHD//J0EszRypmImD0sLQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336510; c=relaxed/simple;
	bh=gB3+mueVJC6rTSgQyDulrWqT4OQyPBK4CkJ9nqNOnDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkvE+bcQboVZw1/rczqMyRyGpJb5j3cqKOKPzGIt78vwk866N7NqIDFQFiI/L1ExjhTXZruAV3+Ze6XhAxxWqhyr9ec9n1f2zePCoIqCEJY0kXky3S+is/CVmvl1vQ7NatQBzBoCfLYg7Ivi4XYtr7JjRMe92Op1k7co+gG4sQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DvxkZq/1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59b097b202so426344666b.0
        for <linux-acpi@vger.kernel.org>; Fri, 10 May 2024 03:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715336506; x=1715941306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gB3+mueVJC6rTSgQyDulrWqT4OQyPBK4CkJ9nqNOnDg=;
        b=DvxkZq/17/W9rupy1Hfln/8kNK6uwz2R/TXTT1RAt7ZPsoIMzc320aWKuTs5/3nHn+
         i4r3/I0xbJJ5J6tntEanAVxr6WCQ7/vSiKSQMMeThKl+6XqXiYfbp0Bl676VwWuVhj2B
         +LteVG4Lv67BImrMV8DaR9Lf6JVOl1wuzTQhfgzL6Sf04w8CuOy/NImxRZWoKSc9TzkW
         e5MLAlDUb7umCXUTSIC+FtOYxCGqDgF7/8Sa3bWakljkSPCEe0GMthF9ZfcbE0SesrBC
         XhdLjz5n8wMOPfyE8Yg1cHNCdooHZ7QInQd384eT8BqYfoc/k4jOdQq9yvc+zLx6XdL1
         xczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715336506; x=1715941306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gB3+mueVJC6rTSgQyDulrWqT4OQyPBK4CkJ9nqNOnDg=;
        b=oL/5cdNHBviAKOh07JPZ76T7llqvyJ2gsqI61B77fNzNxIR4b5sWi2lOBMBfoh2xtA
         7islU/6ZTtDeFjHbNaGrm31X2eZEJN8MLtL8lqv7CuEFZWvIw6Hxu0ykFSBrMNnCKfIh
         jIHALSFq1q71KNxOiGS4Glfz+evGilOEPY+xwN7Jcdy6q1HFlCzf1O2vNyw7EyczvOdV
         cUJ1QVNpTXXNSwvfqQC3QvoNRdo1qPdA7D2PngxslUsiLoFCazeCz7HsWa5uo1z357EG
         xd+2OQ/GpcOVsIfePyOFpyWObCAlhASSm36KlvY2VjjuvYwq4AsPkPVi/EDlBDDvpEgA
         AaGg==
X-Forwarded-Encrypted: i=1; AJvYcCVBM0Q8Fk6NqosOe17kyeJ4CCWZavu/ZfZIv1NPzIXhNqJFVwgTyAeRP9yJY6iryuVSnL4hLB6d30L18CuL3P9huyoxnhnN/1QJoQ==
X-Gm-Message-State: AOJu0YyX98JhnrpzIPFvoW/NiNCBhAGmCiATOklZ99hFF46oXp4wS+Ir
	wImrllSYw2GbJpsAi3bFm/YMoxjkvYzsr+vICO74CK3AeWgPoUci+Dte7cjiXyY=
X-Google-Smtp-Source: AGHT+IGm0ShzWqxUTz6WdBSaEzgp1Qnpb/3O6/pweXuPBaR9LwjAUlSsib161KD3DVm9rCH0vGd4qA==
X-Received: by 2002:a17:906:cc84:b0:a59:c28a:d350 with SMTP id a640c23a62f3a-a5a2d55ab1fmr161431566b.24.1715336506363;
        Fri, 10 May 2024 03:21:46 -0700 (PDT)
Received: from ?IPV6:2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c? (p200300e5873ca5006aafb7a77c29ae5c.dip0.t-ipconnect.de. [2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d342sm168537766b.6.2024.05.10.03.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 03:21:45 -0700 (PDT)
Message-ID: <d0b5e7d5-3503-49be-9fa3-4b79c62059ca@suse.com>
Date: Fri, 10 May 2024 12:21:45 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC KERNEL PATCH v6 3/3] xen/privcmd: Add new syscall to get gsi
 from irq
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Huang, Ray" <Ray.Huang@amd.com>
References: <20240419033616.607889-1-Jiqian.Chen@amd.com>
 <20240419033616.607889-4-Jiqian.Chen@amd.com>
 <79666084-fc2f-4637-8f0b-3846285601b8@suse.com>
 <BL1PR12MB58493D17E23751A06FC931DDE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
 <c30ebad2-1ad3-4b58-afaf-e6dc32c091fc@suse.com>
 <BL1PR12MB58491D2210091DF9607A354AE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <BL1PR12MB58491D2210091DF9607A354AE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.05.24 12:13, Chen, Jiqian wrote:
> On 2024/5/10 17:53, Jürgen Groß wrote:
>> On 10.05.24 11:06, Chen, Jiqian wrote:
>>> Hi,
>>>
>>> On 2024/5/10 14:46, Jürgen Groß wrote:
>>>> On 19.04.24 05:36, Jiqian Chen wrote:
>>>>> +
>>>>> +    info->type = IRQT_PIRQ;
>>> I am considering whether I need to use a new type(like IRQT_GSI) here to distinguish with IRQT_PIRQ, because function restore_pirqs will process all IRQT_PIRQ.
>>
>> restore_pirqs() already considers gsi == 0 to be not GSI related. Isn't this
>> enough?
> No, it is not enough.
> xen_pvh_add_gsi_irq_map adds the mapping of gsi and irq, but the value of gsi is not 0,
> once restore_pirqs is called, it will do PHYSDEVOP_map_pirq for that gsi, but in pvh dom0, we shouldn't do PHYSDEVOP_map_pirq.

Okay, then add a new flag to info->u.pirq.flags for that purpose?


Juergen


