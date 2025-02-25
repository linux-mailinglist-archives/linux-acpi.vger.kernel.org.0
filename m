Return-Path: <linux-acpi+bounces-11460-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C8FA44235
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 15:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28170188311D
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1A257420;
	Tue, 25 Feb 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="HEruRjUH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E4A269CF5;
	Tue, 25 Feb 2025 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492672; cv=pass; b=K2jNdkLW0ihqAsX38VWAn28c797wJcKfsPh/NPvysciTddnoNxroR92jlECN99v+PSc5RjlrBbNXbbQ3PbveyXdBka7JHmFSBrbOhwC42XPAb5C2xxtl16zs89xxlcOVYrwq/8HprGPjLfDO/31Jbl/CNV6jPFlKcnA5vlQx37o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492672; c=relaxed/simple;
	bh=cGl95/tIMt9LeTLZ8xfmaDBscvWC2WA8WugugzKt5NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mV1PxdIrsg3wmFHqd/P6aa6j4WmPgAQcqXTYM4sLon9u42ZeNm9nJpnT5eRhE8AA2rUWeYQsUetHoPZq+eL+7+UnbezoFgA3pVX382EWw8RbhkTLI9FX5CEL715SrZv/uZ/gGs1Fn62qe70+reX+jzraKTWl1DbbT1WfYGtZHpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=HEruRjUH; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1740492644; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nyqOiPjO9xY88nxZOJU9h3rTCmiCD4z1U8hGW4ePLec3CHGbYZLSJAf3xSpdb/ZkAJZ5K3lk8zRP2OLahU3xSq85hiYur/y1VjDOMQBttEILOv6CmrU1DCVzSabmlEn5Q9jQmVF1iR5OZFlZK2cKVgkYroeNQiCEDBDHMC5fnP0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740492644; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cGl95/tIMt9LeTLZ8xfmaDBscvWC2WA8WugugzKt5NA=; 
	b=GWTTCwiQkyXG3Gcs0Df/W2tOwpcP4klHaZsa0klEKrCKbaqk6UfZqXaQtRO8o1asSuZ6GfmNOxy6y4H1p4ZfQ/UMZzI7nIKk1gYVv+kKx3qjif+jKKCt+/pAEvUHTHfMQsEujWgNZCWkBMWZLwf+uGC9r+ItaSZXkORZPs7QEm8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740492644;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=cGl95/tIMt9LeTLZ8xfmaDBscvWC2WA8WugugzKt5NA=;
	b=HEruRjUHQrZ3QbI7kBESOhx/SQe47goTRUvUWi/lkv7ogKCnzn7cyX0sn73xRoYQ
	tmH+dJh14vsa6To7heSuDDwnq4ZB9ZD9pcZqmUCv0AHZ7brBtTyn6gO00VXZuhOlgFE
	szDWVPPe11bJH++dhYwzYsIm0guyo662ISuzIJdM=
Received: by mx.zohomail.com with SMTPS id 174049264087733.472544788742766;
	Tue, 25 Feb 2025 06:10:40 -0800 (PST)
Message-ID: <40cb71ba-df52-4741-8a71-3981077ec06e@zohomail.com>
Date: Tue, 25 Feb 2025 22:10:34 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] acpi/hmat / cxl: Add extended linear cache support
 for CXL
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
 tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com
References: <20250224182202.1683380-1-dave.jiang@intel.com>
 <20250224182202.1683380-3-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250224182202.1683380-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227c092eeba049f9e0924193b2500006922502ee46fb63b345dc55d52b807d1e23ffc5fe46028542c:zu080112270417f1c0b2656c8d81766a0b00001f68b1bd5582e158ffbb06419aac3e89ecb7e3cf8fb2e1b158:rf0801122d9b7cd119b24caac2f8f7bdb700004724bea10f80d77207bfcc289013a7e77c257a7277d627f2a07582de2f795d:ZohoMail
X-ZohoMailClient: External

On 2/25/2025 2:21 AM, Dave Jiang wrote:
> The current cxl region size only indicates the size of the CXL memory
> region without accounting for the extended linear cache size. Retrieve the
> cache size from HMAT and append that to the cxl region size for the cxl
> region range that matches the SRAT range that has extended linear cache
> enabled.
>
> The SRAT defines the whole memory range that includes the extended linear
> cache and the CXL memory region. The new HMAT ECN/ECR to the Memory Side
> Cache Information Structure defines the size of the extended linear cache
> size and matches to the SRAT Memory Affinity Structure by the memory
> proxmity domain. Add a helper to match the cxl range to the SRAT memory
> range in order to retrieve the cache size.
>
> There are several places that checks the cxl region range against the
> decoder range. Use new helper to check between the two ranges and address
> the new cache size.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

