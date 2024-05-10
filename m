Return-Path: <linux-acpi+bounces-5716-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B428C2152
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 11:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1376F1C20AED
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 09:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238871649CF;
	Fri, 10 May 2024 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H5KPqkoL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD8A1635BC
	for <linux-acpi@vger.kernel.org>; Fri, 10 May 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715334830; cv=none; b=Aztpxo2+8hlQc9XROKy0wGfwsJ5ijpwHXGhqNJzKX6nQzY2+O1mEm6p1An8PLE7H5t4ZoArQmNK+ob4yrSI5yi9JAfdtcHbB6mHskVMMKtPUySNWrzetK7cg1o1TgswgMNsuILXkd8Qlx0ke46G9BUGNG4Urwb7pHGSnTNp9FPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715334830; c=relaxed/simple;
	bh=TkEdq8r0+/swqUjCHG6c36VrHTwqIXDZ1QgHk6NLqPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5kvuLW8MgPhRtjm2KVO8j72eobiPlbuXGM1+jLOuB/eebk4MJMk3bSNO4HO2hnvnAv39/tVuA0430MjjmlsUZOAvHAurzV2b3EnzBa0gc36kEDvtCSczs5wlFT9S6SoTRJaWZHl3bsWbks2oKSscwAKjds8RVElpW49RT2eOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H5KPqkoL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59cf8140d0so442118566b.3
        for <linux-acpi@vger.kernel.org>; Fri, 10 May 2024 02:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715334826; x=1715939626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgDr/j3I45aVQZVCtriHh098OsnX9VLTCcgYdnyh5r0=;
        b=H5KPqkoLooNmNVNVzl9Sy8BA8PYeBQZTrvQrO4cID0CGS8Y7qHqeMvu+YnkID+2cQs
         GRtm3zH+0H/bZ0X3UDvNR5sf6ZujFwJO3213f8QlJ+VK86IdlH71DwuX/5/fg2kJZSOg
         b87gNL97392rVinS+mpesirADnXDGoGYCJwAzAqHlXap9xWMyBNUOmezh72tYQXXSyor
         lXxQWqpwrYEt/HRmlixGBExcB3iAbhvGAOb5Zude7IdIDPEXMAThNztbjf2H82iEB5sx
         kf0YJs4KTWcmLx3NxCXY1YEPdsJ76LLChJ0pR3h3kDDj4em8mTLFdFGm+fLlrV8Mk5Iq
         znQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715334826; x=1715939626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgDr/j3I45aVQZVCtriHh098OsnX9VLTCcgYdnyh5r0=;
        b=YK5rU+YauR98CNkT3sElPYaDEa+Brxxd6mW/NY5Ik4Ie7XlsE3KvA4FHpGXX4pma6q
         pnprxQ0NGBSkPNTl71W93VIRZKf2NIFjXgsWIDy7kJyIZC/3c144OuvSEsx55MSX1am0
         j4rCIl13DEdimgEMtZNqrXgaUlfel5mbHtMbUljBS39MkrKLsNQR3p36QcgIWacEpUhE
         JCxzO3R3rbOJdxsYV0TGlta/kw9AUD6LM9NQ9fIIegjYMgqxbACQSSopo4kwwwLU7Jte
         c3pabEVelhQO+CaxKA3q/BJjiSMgVKgdojPDMC142cNpgDkUMbhX3cWx/mEm4adjwM1J
         cD0A==
X-Forwarded-Encrypted: i=1; AJvYcCXAj/G3Qgc7clz03+duWL3P7AwtYzw/y/oYS2AOrRtulQMNaCzz0vcBDLvV1HATH0Vm87KYON9T92xSIhL7iHWWxYYHwnd7wVaccQ==
X-Gm-Message-State: AOJu0Yz05XBcBNc7EezLHBqdTxB9ExhFxt/RXPPbAgzK32rO98zKxvrf
	Mg1ZbCqXOHhu8NkD5vAby/0H5PqLsgWGHI9NRy6/2NH8UIxC3xTTR1UxscVm5XE=
X-Google-Smtp-Source: AGHT+IEKz31JvWqjAEmRomlfNgaF8EqP2HQK8r73XnIs3tomW69Tn3zJ4arHD6nbkZkJnphFIwRQPg==
X-Received: by 2002:a17:906:134d:b0:a59:9eab:162b with SMTP id a640c23a62f3a-a5a2d5d01abmr136503366b.35.1715334826351;
        Fri, 10 May 2024 02:53:46 -0700 (PDT)
Received: from ?IPV6:2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c? (p200300e5873ca5006aafb7a77c29ae5c.dip0.t-ipconnect.de. [2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01968sm164814366b.166.2024.05.10.02.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 02:53:46 -0700 (PDT)
Message-ID: <c30ebad2-1ad3-4b58-afaf-e6dc32c091fc@suse.com>
Date: Fri, 10 May 2024 11:53:45 +0200
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
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <BL1PR12MB58493D17E23751A06FC931DDE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.05.24 11:06, Chen, Jiqian wrote:
> Hi,
> 
> On 2024/5/10 14:46, Jürgen Groß wrote:
>> On 19.04.24 05:36, Jiqian Chen wrote:
>>> +
>>> +    info->type = IRQT_PIRQ;
> I am considering whether I need to use a new type(like IRQT_GSI) here to distinguish with IRQT_PIRQ, because function restore_pirqs will process all IRQT_PIRQ.

restore_pirqs() already considers gsi == 0 to be not GSI related. Isn't this
enough?


Juergen

