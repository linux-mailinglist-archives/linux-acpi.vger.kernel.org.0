Return-Path: <linux-acpi+bounces-11462-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7FFA44225
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 15:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5DF177DB7
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3514268692;
	Tue, 25 Feb 2025 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="fKodRmYR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8026A1BD;
	Tue, 25 Feb 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492739; cv=pass; b=AGrzLOmLuR76A0N2uLn1vHP3hBfjyo5mCvU/05o7EqSECw8ueGEooATXaoURpbHxNvSHXqNLOCcKGnhG7ddd4gcIxE53yHz/MoP8j7AV/3oI5dB/bH5AzTWY07onchz4EHbrLf+znQuKdaILHM23eEc/7ntTEwB+IxPJXBeyzew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492739; c=relaxed/simple;
	bh=RXETdaJQjGckWcQ+1o+Stl2ijbxP5K69YX/we00DGkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOMKioij4/nrZraDtHCFt3j2a9Dh6CA5+iOGS5Iu0JbzTDyEGIvIsNySdDLCI4BNaM7Z7Y1ovQhf0MR6E2gZP44mdSi72U3mPx/QH8omZMxGpQ6rsh2UAqyCoYdDfRezbOM1URS8vXFPBVFctEe1pNBYJWaCawIaEeFo2Kp3/eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=fKodRmYR; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1740492713; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OZndYgqANuZNXF7T/VvyVfBujsjkZhUos3I3aNMnIYUz7Vgt4THWUGzb7ZudTFTXw+whuW/d8/YYt9Ejst6+RMOYyfTgUP8to9bWJSDkGoAZL2LU9zJjZXZCXLDO4EWiL006GM0Qmzm0UMlphRBMrbIw5rCUx1GTKYugQbqh/VI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740492713; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1XvaMRD+vkbBUUclMyHLmtvPUEgmRspiAu6Im4VAnGo=; 
	b=HwKrT3Mfv9/vtAXUTm1XWkGx3cn9RskfWSbDHhuBb9P8JDx6uv3NYPJnVckKC7IqhRXi1GHYeryFF0rvYKTz2+hcMQdRx1Iwl3VwJuouoePQ1aToccUyyaMOK+oinO1wVX9fHv03mBdHng6PQXtONrGr/RzesNSxxIwiSRrrdSw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740492713;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=1XvaMRD+vkbBUUclMyHLmtvPUEgmRspiAu6Im4VAnGo=;
	b=fKodRmYR2GoD1iw7GI9RYwccKQu8u5a0HiX7nO+L9qH9j9vsjFIp5LSPrQ/o9IGW
	bapa05YDEkV4Uy5Hmo+ld0d/IrpbJMIiVsbfcYeT3jtl1AACwqnux5DnKClLycz32b4
	ysSLvk6hYaTBDFGqIWbePci9BiGSxRl7RxYZ9ec4=
Received: by mx.zohomail.com with SMTPS id 1740492710136779.3645926287403;
	Tue, 25 Feb 2025 06:11:50 -0800 (PST)
Message-ID: <3bff8405-d970-4e2d-b630-e84ed702359b@zohomail.com>
Date: Tue, 25 Feb 2025 22:11:44 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] cxl: Add mce notifier to emit aliased address for
 extended linear cache
To: Dave Jiang <dave.jiang@intel.com>
Cc: rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
 tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20250224182202.1683380-1-dave.jiang@intel.com>
 <20250224182202.1683380-5-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250224182202.1683380-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112275ff5750f318b3d3c2e788d950000123141e005eaff449cbb22841913dd2b41aa0af807b4821069:zu0801122771f162b56dfe2b2b3e0c8fe100008c3dfec84d01d18911d744c495d857ca5f40d3951bc33088f6:rf0801122da69ae5d3e46b87eb2855ac9200009941810445eb6814c1e3853d582e3504c03a8e28d4a56900627f60dcd44463:ZohoMail
X-ZohoMailClient: External

On 2/25/2025 2:21 AM, Dave Jiang wrote:
> Below is a setup with extended linear cache configuration with an example
> layout of memory region shown below presented as a single memory region
> consists of 256G memory where there's 128G of DRAM and 128G of CXL memory.
> The kernel sees a region of total 256G of system memory.
>
>               128G DRAM                          128G CXL memory
> |-----------------------------------|-------------------------------------|
>
> Data resides in either DRAM or far memory (FM) with no replication. Hot
> data is swapped into DRAM by the hardware behind the scenes. When error is
> detected in one location, it is possible that error also resides in the
> aliased location. Therefore when a memory location that is flagged by MCE
> is part of the special region, the aliased memory location needs to be
> offlined as well.
>
> Add an mce notify callback to identify if the MCE address location is part
> of an extended linear cache region and handle accordingly.
>
> Added symbol export to set_mce_nospec() in x86 code in order to call
> set_mce_nospec() from the CXL MCE notify callback.
>
> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

