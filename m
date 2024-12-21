Return-Path: <linux-acpi+bounces-10239-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184FB9F9D67
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 01:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF8B168C8E
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 00:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C48EADC;
	Sat, 21 Dec 2024 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="iX4vmOue"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2D6AAD
	for <linux-acpi@vger.kernel.org>; Sat, 21 Dec 2024 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734740954; cv=none; b=nF+lTSKv1ztJYgntt8oASa6Q4Q//9zz2y6Kc1ROT1eqmO6LgbPOLfxJ4kCVBuB0Nk6VXAJxJNqlQ5TtHj0y9aw7AFlj8/J4VALHAJk2sg/Yh5A3SIXd3CSTGmYQElo7XKTjoTHLXzE432qLqUzbO74IA6RCwcGXCjoVsR066VKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734740954; c=relaxed/simple;
	bh=JOubcB4G4WGgdMvQDT82hSZMzQsiikON5vuT/uzQEJI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cM+PwIja+MiMtCw29MmmSTOaWNBX3g0VSvsxfgim0Vu81/FDZt1umIhHqPd/MAB5uMBRlnUl0YLJZo6mKEDh10/HQXiOWUP+/iOGZ9Tuo04Scyy9kuUG/l8W++et00nwD7ZKYET1xFMWU2Hnt/q34Z6kLYZq+0M9J26DyPsXbcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=iX4vmOue; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso17118375e9.0
        for <linux-acpi@vger.kernel.org>; Fri, 20 Dec 2024 16:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1734740951; x=1735345751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jJhtITZ4lAQh7K0AUG62aoM5fzqsK11mdNKPUcHR19E=;
        b=iX4vmOue1AGfuJOVQNaVZnCXVAiumNVv5T4cpMj/+72wW+s9DJpEp6p1TKIN/olAO4
         Mlwa25KS9IU8jrEkctCb5v3ewmIGXr5zNlKEOEMjQ8FhtC5rVmI0G6ACTTw+XAkagQWa
         lZotuL6g6XOPtbH153xUowq/OmN9AKSOBLdPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734740951; x=1735345751;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJhtITZ4lAQh7K0AUG62aoM5fzqsK11mdNKPUcHR19E=;
        b=m4NUGxJeYvpHhV9fMnTqiUcc0efcNuHPVqASUiy3gxBnrAGPbdrUtLDpVScBvnfO6d
         Hxss6c8iiFLqJtRJPmMhqe8F1mHDsw2hWiI2ToMfBIRF6rlO7hcEE7K3UkAL6E2CZO7+
         HuU44+TSZVsKpYK+jfC+pqrF+KlxPr/L+os6IQ3MNsDxGgzqJ/b8pGbxzJeEm1R0iSQ4
         PHMs+BqEgmodO/fVl9NFVaVbIoOLCB8vUL63oyGi14BVm47gajpt+WeUGJKwpFNAYkvZ
         SO8lwSQDnqjEUlcpJolu23TBbLEQYHRtp3QcADzJUwNnhlgF94L8OdG9WoUj8FwCeC5T
         y9cA==
X-Forwarded-Encrypted: i=1; AJvYcCVRNzpktrKOvJa0Esa0hb84mDR1QYgT3ZJo1f8a7rSQHKD41yfZkR/FP2rON7SGymnn1gl0f99sfVZW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd5utOBcSXH0UZmVoqBMAPykbntZk1RZbguvJpkGiiUrFe95yJ
	BfyTnUFspprxHGwJEJU2pDoqZ13uGqR2yVUucH7n2eZ5BQqvrHrTyx2ER1nNhvY=
X-Gm-Gg: ASbGncsyCVAITehRgSAt15ZdOZ91KIagEtq39hLoS2ttrFFJtJLqiVrloIFMldBLPlR
	hwHt41O4JtU6sC1YRytiLuYFoH727tKDH+QnNJDtgVQpxSythAmrEkgkye1pXQsZY44DeJfGinG
	P/jK3CZ8ZnqoMrWaDa5861XmZ7XE+ebVLJ+FOouetAG+0mh6/OdSM9WmCoU/DsWKNdNpE/h/GV5
	Kms/RfXWqvcwSRle7J1UK1lOe8pLHnsIijKSRvshPMHhaCKxY+FY5zYlZSrFnD0uDilexbjKfUY
	ifqqpHcL+4PWOd1MCwsN
X-Google-Smtp-Source: AGHT+IECeMNav5CpQtcaNYfvmITM4dOtdZrobWjXidFoGQgpul8V7Zd2a6z5unpSRoQUQqmPQIqoPQ==
X-Received: by 2002:a05:600c:45cf:b0:434:f739:7ce3 with SMTP id 5b1f17b1804b1-436686430aemr41364475e9.8.1734740951619;
        Fri, 20 Dec 2024 16:29:11 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b1f6sm94687385e9.31.2024.12.20.16.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 16:29:11 -0800 (PST)
Message-ID: <f97c1228-7fca-4487-814c-6dd6ba581721@citrix.com>
Date: Sat, 21 Dec 2024 00:29:10 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sohil.mehta@intel.com
Cc: acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, bp@alien8.de,
 dave.hansen@linux.intel.com, fenghua.yu@intel.com, hpa@zytor.com,
 irogers@google.com, jdelvare@suse.com, jolsa@kernel.org,
 kan.liang@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
 linux@roeck-us.net, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 namhyung@kernel.org, peterz@infradead.org, rafael@kernel.org,
 rui.zhang@intel.com, tglx@linutronix.de, tony.luck@intel.com,
 viresh.kumar@linaro.org, x86@kernel.org
References: <20241220213711.1892696-1-sohil.mehta@intel.com>
Subject: Re: [RFC PATCH 00/15] Prepare for new Intel family models
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20241220213711.1892696-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> ---Noteworthy quirks---
> Pentium II Overdrive - A unique family number:
>   Wikipedia says[2], In Intel's "Family/Model/Stepping" scheme, the Pentium II
>   OverDrive CPU identifies itself as family 6, model 3, though this is 
>   misleading, as it is not based on the family 6/model 3 Klamath core. As 
>   mentioned in the Pentium II Processor update documentation from Intel, 
>   "although this processor has a CPUID of 163xh, it uses a Pentium II processor 
>   CPUID 065xh processor core."
>
>   A dump of the microcode file 06-03-02 shows:
>     001/001: sig 0x00001632, pf_mask 0x00, 1998-06-10, rev 0x0002, size 2048
>   An archived CPUID dump [3] also says:
>     CPUID 00000001: 00001632-00000000-00000000-0183FBFF
>
>   That would translate to a family number of 22 (0x16). This aberration is 
>   not explicitly handled anywhere in the kernel so the platform might already 
>   be broken. This series might make it worse for the platform if the latest 
>   kernel works on it by chance.

Are you sure?  Bits 13:12 are the type field, and the 0x1 you've got is
for an OverDrive processor.

x86_family() will consider this to be family 6 as far as I can see.

~Andrew

