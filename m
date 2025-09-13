Return-Path: <linux-acpi+bounces-16838-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF0CB55DD9
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 04:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B8914E0FF5
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 02:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3953F1B4248;
	Sat, 13 Sep 2025 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="orduhV2/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5E2A1BF;
	Sat, 13 Sep 2025 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757730952; cv=none; b=uKslLAoap9DhNKIdpidfwyfHM+RYpOeaMP+cGcR9vSr1X7+ASXHvNpiKgaXw6Z6owlguTdUVkdhJQzGEtWqMi0j0gIvQ6QsNDl+iyz26jyEXe+NfhgNqZ2EtEloH9Gv7lXtYvpvk0KUHdykMGr+rBB39e7OGxo9esSCO8SeEU3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757730952; c=relaxed/simple;
	bh=qH6GlusyYn76bRUhmFjPNlI/YGuFnoPH4y9X0YWXntE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Asd5wZ9INIsGU9JZ1rFNOeLx64LON35DGlGzrllD6F0DT6aFa8EB0XA+73DZ6f4vCCA2ThJoOtX9C2OIkKffQWl9bxsJlLU0f3S88bDs0lweFsNn3SGfjlF/aMmwt4FuFXArBUvptt2xw020N64rJ8/XXjrYFIkEJeKrl7fsOus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=orduhV2/; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757730946; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nx44N8HBOO1IppEPh29ozMVKXEWUrjETzCF71QaAXYU=;
	b=orduhV2/HUePRLO8DBDLuO1y0gvTzDhu0ukdOe/f5EJ6FfAsuSD2CtbadB8ronxhrUbYTvrYjh0zWwS2FAhVIeRVmxm0t+WbOo0toFqFYw1/tXiskM6pALECogm3TsbqTtKS85kBpl/GldZnk1hnbrWLN04snB9Wzhrr4bFVtQU=
Received: from 30.246.178.7(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WnsS-Gn_1757730943 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 13 Sep 2025 10:35:44 +0800
Message-ID: <865002bf-8a65-4b1f-a428-bca134825a7a@linux.alibaba.com>
Date: Sat, 13 Sep 2025 10:35:43 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi,srat: Fix incorrect device handle check for Generic
 Initiator
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
 andrew@kernel.org, bfaccini@nvidia.com, eahariha@linux.microsoft.com,
 dan.j.williams@intel.com, thorsten.blum@linux.dev, gourry@gourry.net,
 nunodasneves@linux.microsoft.com, wangyuquan1236@phytium.com.cn,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20250910093949.5793-1-xueshuai@linux.alibaba.com>
 <20250910105729.000070a5@huawei.com>
 <998939f5-e0f9-457f-98a2-73f687ad29cc@linux.alibaba.com>
 <20250911101144.00001a84@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250911101144.00001a84@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/11 17:11, Jonathan Cameron 写道:
> On Thu, 11 Sep 2025 12:28:00 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> 在 2025/9/10 17:57, Jonathan Cameron 写道:
>>> On Wed, 10 Sep 2025 17:39:49 +0800
>>> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>>    
>>>> The Generic Initiator Affinity Structure in SRAT table uses device
>>>> handle type field to indicate the device type. According to ACPI
>>>> specification, the device handle type value of 1 represents PCI device,
>>>> not 0.
>>>>
>>>> Fix this by defining explicit macros for device handle types and using
>>>> the correct check for PCI devices:
>>>>
>>>> - ACPI_SRAT_ACPI_DEVICE_HANDLE (0): ACPI device handle
>>>> - ACPI_SRAT_PCI_DEVICE_HANDLE (1): PCI device handle
>>>>
>>>> Fixes: 894c26a1c274 ("ACPI: Support Generic Initiator only domains")
>>>> Reported-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>
>>> The actbl3.h additions need to go through acpcia and then have a link
>>> tag in here to show that it was merged.  Perhaps just fix it with a number
>>> for now and follow up with the acpcia stuff in the longer run?
>>
>> Sure, I will drop changes in actbl3.h to make it easy to progress.
>>
>>>
>>> Also note clearly this only affects a debug print - no functional bug.
>>> That may change whether people choose to backport this or not.
>>
>> Yes.
>>
>>>
>>> I'm curious on whether you are thinking of wiring this up so that
>>> we can set the appropriate nodes on PCI Devices other than by doing it
>>> with _PXM().  For obscure reasons there can be references both ways
>>> (so DSDT Device entry -> SRAT via _PXM, and SRAT -> Device via this field
>>> of generic initiators).
>>>
>>> For now we only implement the first one so all we need is a node to be
>>> instantiated for the GI to sit in.
>>>
>>> Come to think of it the fix that made PCI device entries in DSDT with _PXM
>>> turn up in the right place was reverted (for a problem with broken firmware
>>> on AMD threadripper systems - IIRC that I think is long solved).
>>> Not sure if that path even works today and the one this code is about has
>>> never been hooked up.
>>
>> You mean add a new map like pxm_to_node_map[]?
>>
>   
> Two things involved here. If a _PXM entry exists for the PCI device, then unreverting:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0d76bcc960e6057750fcf556b65da13f8bbdfd2b
> or something to replace that is needed.  There may still be a problem somewhere
> as we never entirely figured out the cause last time.  It is also possible this got
> fixed via another method in the meantime so first thing to do is to put some devices
> in a GI only node and see if the numa node value in sysfs is correct.
> 
> For the entry you are touching here to be passed to the actual set_dev_node() we'd
> probably do it by stashing any GI entries found when parsing SRAT in an xarray or similar and
> adding a lookup to see if we have a match in that xarray but not a _PXM in pci_acpi_setup().
> 
> Not particularly hard to do, but have to be very careful wrt to broken bios descriptions
> of the topologies.
> 
> Jonathan
> 

Hi, Jonathan,

Thanks for the detailed guide, it sounds a bit complicated to me :)

I send a v2 to fix device_handle_type check.

Thanks.
Shuai


